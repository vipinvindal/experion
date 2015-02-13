package com.bets.experion.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.MessagingException;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.InitialDirContext;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.sun.mail.util.ASCIIUtility;


@Component("EmailValidator")
public class EmailValidator {
	private static Logger logger = Logger.getLogger(EmailValidator.class.getCanonicalName());
	
	private static final byte[] CRLF = { (byte)'\r', (byte)'\n' };
	private static final String from = "verify-email@beyondevolution.in";
	private static final String EMAIL_PATTERN = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" +
			"[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
 
	private Pattern pattern;
	private Matcher matcher;
 
	public EmailValidator() {
		if(logger.isDebugEnabled())
			logger.debug("creating object for EmailValidator");
		pattern = Pattern.compile(EMAIL_PATTERN);
	}
 
	private boolean validatePattern(final String emailString) {
		if(logger.isDebugEnabled())
			logger.debug("inside validatPattern() for emailId: " + emailString);
		
		matcher = pattern.matcher(emailString);
		return matcher.matches();
	}	

	public boolean validate(String emailString) {
		if(logger.isInfoEnabled())
			logger.info("inside validate() for emailId: " + emailString);
		
		boolean validEmailId = false; 

		if(!validatePattern(emailString)){
			if(logger.isInfoEnabled())
				logger.info("Incorrecet pattern, returning false");
			return validEmailId;
		}

		String[] emailSplit = {};
		try {
			if(logger.isDebugEnabled())
				logger.debug("going to split emailId on @");
			
			emailSplit = emailString.split("@");
			if(emailSplit.length!=2){
				if(logger.isInfoEnabled())
					logger.info("Incorrecet pattern - split failed, returning false");
				return validEmailId;
			}
			if(logger.isInfoEnabled())
				logger.info("email user: " + emailSplit[0] +"::::domain: " + emailSplit[1]);
			
			List<String> mxRecords = lookupMailHosts(emailSplit[1]);
			for (String mailHost : mxRecords) {
				int returnCode = verifyEmail(mailHost, emailString);
				if(returnCode != -1){
					if(returnCode == 200 || returnCode == 220 || returnCode == 250 ){
						validEmailId = true;
						break;
					}
				}
			}
			if(logger.isInfoEnabled())
				logger.info("emailId " + emailString + " is " + (validEmailId?"valid":"invalid"));
			
		} catch (NamingException e) {
			if(emailSplit!=null && emailSplit.length == 2 ){
				logger.error("No DNS record for '"+ emailSplit[1] +"'");
			}
			else{
				logger.error("No DNS record for '"+ emailString +"'");
			}
		}
		return validEmailId;
	}

	private int verifyEmail(String mailHost, String emailId) {
		if(logger.isDebugEnabled()){
			logger.debug("inside : verifyEmail()");
			logger.debug("checking emailId: " + emailId +"::::on Host: " + mailHost);
		}
		Socket soc = null;
		int returnCode = -1 ;
		try {
			if(logger.isDebugEnabled())
				logger.debug("creating socket");

			soc = new Socket(mailHost, 25);
			
			if(logger.isDebugEnabled())
				logger.debug("initializing i/o streams");
			
			OutputStream oStream = soc.getOutputStream();
			InputStream iStream = soc.getInputStream();   
			InputStreamReader isr = new InputStreamReader(iStream);   
			BufferedReader br = new BufferedReader(isr);   
			
			returnCode = readServerResponse(br);
			if(logger.isDebugEnabled())
				logger.debug("returnCode: " + returnCode);
			
			if(returnCode != 200 && returnCode != 220 &&  returnCode != 221 
					&& returnCode != 250 && returnCode != -1)
				return -1;
			
			if(logger.isDebugEnabled())
				logger.debug("sending HELO");
			
			String cmd = "HELO beyondevolution.in";
			sendCommand(cmd,oStream);
			returnCode = readServerResponse(br);

			if(logger.isDebugEnabled())
				logger.debug("returnCode: " + returnCode);
			
			if(returnCode != 200 && returnCode != 220 &&  returnCode != 221 
					&& returnCode != 250 && returnCode != -1)
				return -1;
			
			cmd = "MAIL FROM: " + normalizeAddress(from);
			sendCommand(cmd,oStream);
			returnCode = readServerResponse(br);
			if(logger.isDebugEnabled())
				logger.debug("returnCode: " + returnCode);
			
			if(returnCode != 200 && returnCode != 220 &&  returnCode != 221 
					&& returnCode != 250 && returnCode != -1)
				return returnCode;
			
			try {
				Thread.sleep(10);
			} catch (InterruptedException e) {
				e.printStackTrace();
				logger.error("error in verifyEmail()", e);
			}

			cmd = "RCPT TO: " + normalizeAddress(emailId);
			sendCommand(cmd,oStream);
			returnCode = readServerResponse(br);

			if(logger.isDebugEnabled())
				logger.debug("returnCode: " + returnCode);

		} catch (UnknownHostException e) {
			logger.error("Unknown Host: ", e);
			returnCode = -1;
		} catch (IOException e) {
			logger.error("I/O error: ", e);
			returnCode = -1;
		} catch (MessagingException e) {
			logger.error("Messaging error: ", e);
			returnCode = -1;
		} catch (Exception e) {
			logger.error("Messaging error: ", e);
			returnCode = -1;
		}
		finally{
			if(soc!=null)
				try {
					soc.close();
				} catch (IOException e) {
					e.printStackTrace();
					logger.error("error in verifyEmail()", e);
				}
		}
		return returnCode; 
	}

	private void sendCommand(String cmd,  OutputStream serverOutput) throws MessagingException {
		if(logger.isDebugEnabled())
			logger.debug("inside sendCommand(String), sending " + cmd);
		sendCommand(ASCIIUtility.getBytes(cmd),serverOutput);
	}

	private void sendCommand(byte[] cmdBytes, OutputStream serverOutput) throws MessagingException {
		if(logger.isDebugEnabled())
			logger.debug("inside sendCommand(byte[])");
		
		try {
			serverOutput.write(cmdBytes);
			serverOutput.write(CRLF);
			serverOutput.flush();
		} catch (IOException ex) {
			logger.error("Can't send to SMTP host", ex);
			throw new MessagingException("Can't send command to SMTP host", ex);
		}
	}
	
	private int readServerResponse(BufferedReader inputStream) throws MessagingException {
		if(logger.isDebugEnabled()){
			logger.debug("inside : readServerResponse()");
		}
		String serverResponse = "";
		int returnCode = 0;
		
		StringBuffer buf = new StringBuffer(100);

		try {
			String line = new String ();
			do {
				line = inputStream.readLine();
		    	if (line == null) {
		    		serverResponse = buf.toString();
		    		if (serverResponse.length() == 0)
		    			serverResponse = "[EOF]";
		    		return -1;
		    	}
				buf.append(line);
				buf.append("\n");
		    } while (isNotLastLine(line));
		    serverResponse = buf.toString();
		} catch (Exception ioex) {
			throw new MessagingException("Exception reading response", ioex);
		}
		if(logger.isInfoEnabled())
			logger.info("serverResponse: " + serverResponse);

		if (serverResponse.length() >= 3) {
			try {
				if(logger.isInfoEnabled())
					logger.info("parsing server response");

					returnCode = Integer.parseInt(serverResponse.substring(0, 3));
				if(logger.isInfoEnabled()){
					logger.info("returnCode: " + returnCode);
				}
			} catch (NumberFormatException nfe) {
				logger.error("error parsing responseCode", nfe);
			}
		} else {
			returnCode = -1;
		}
		if (returnCode == -1)
			return returnCode;
		
		if(logger.isInfoEnabled())
			logger.info("returning returnCode: " + returnCode);
		return returnCode; 
	}


	private boolean isNotLastLine(String line) {
		if(logger.isDebugEnabled())
			logger.debug("inside : isNotLastLine()");
		
		return line != null && line.length() >= 4 && line.charAt(3) == '-';
	}

	private String normalizeAddress(String addr) {
		if(logger.isDebugEnabled())
			logger.debug("inside : normalizeAddress()");
		
		if ((!addr.startsWith("<")) && (!addr.endsWith(">")))
			return "<" + addr + ">";
		else
			return addr;
	}

	private List<String> lookupMailHosts(String domainName) throws NamingException {
		
		if(logger.isInfoEnabled())
			logger.info("inside lookupMailHosts() for domain: " + domainName);
		
		InitialDirContext iDirC = new InitialDirContext();
		Attributes attributes = iDirC.getAttributes("dns:/" + domainName, new String[] { "MX" });
		Attribute attributeMX = attributes.get("MX");

		if (attributeMX == null) {
			if(logger.isInfoEnabled())
				logger.info("MX records not found, returning domainName: " + domainName);
			
			List<String> list = new ArrayList<String>();
			list.add(domainName);
			return (list);
		}

		if(logger.isInfoEnabled())
			logger.info("MX records found, count(MX): " + attributeMX.size());

		if(logger.isDebugEnabled())
			logger.debug("split MX records into Preference Values and Host Names");

		// split MX RRs into Preference Values(pvhn[0]) and Host Names(pvhn[1])
		String[][] pvhn = new String[attributeMX.size()][2];
		for (int i = 0; i < attributeMX.size(); i++) {
			try{
				pvhn[i] = ("" + attributeMX.get(i)).split("\\s+");
			}
			catch(Exception e){
				logger.error("split MX records failed. This should not happen, ignoring the error.");
			}
		}

		if(logger.isDebugEnabled())
			logger.debug("sort the MX records by RR value (lower is preferred)");
		
		// sort the MX RRs by RR value (lower is preferred)
		Arrays.sort(pvhn, new Comparator<String[]>() {
			public int compare(String[] o1, String[] o2) {
				if(o1[0]!=null && o2[0]!=null)
					try{
						return (Integer.parseInt(o1[0]) - Integer.parseInt(o2[0]));
					}catch(Exception e){
						logger.error("Parsing RR failed. This should not happen, ignoring the error.");
					}
				return -1;
			}
		});

		if(logger.isDebugEnabled())
			logger.debug("put sorted host names in a list, get rid of any trailing '.'");
		
		// put sorted host names in an array, get rid of any trailing '.'
		List<String> sortedHostNames = new ArrayList<String>();
		for (int i = 0; i < pvhn.length; i++) {
			if(pvhn[i][0]!=null && pvhn[i][0].length()>0)
				sortedHostNames.add(pvhn[i][1].endsWith(".") ? pvhn[i][1].substring(0, pvhn[i][1].length() - 1) : pvhn[i][1]);
		}
		if(logger.isDebugEnabled())
			logger.debug("sortedHostNames: " + sortedHostNames);

		return sortedHostNames;
	}
	
	public static void main(String[] args) {
		//BasicConfigurator.configure();
		EmailValidator emailValidator = new EmailValidator();
		
		String emailId = "saurab1.sharma@airtelmail.com";
//		System.out.println("email Id (" +emailId +") is " + (emailValidator.validate(emailId)?"valid":"not valid"));
//
//		emailId = "saurab1.sharma@airtel.com";
//		System.out.println("email Id (" +emailId +") is " + (emailValidator.validate(emailId)?"valid":"not valid"));
//		
//		emailId = "bisht1980@gmail.com";
//		System.out.println("email Id (" +emailId +") is " + (emailValidator.validate(emailId)?"valid":"not valid"));
//		
//		emailId = "bisht1980@yahoo.co.uk";
//		System.out.println("email Id (" +emailId +") is " + (emailValidator.validate(emailId)?"valid":"not valid"));
//
//		emailId = "siddharth.bisht@yahoo.co.uk";
//		System.out.println("email Id (" +emailId +") is " + (emailValidator.validate(emailId)?"valid":"not valid"));

		emailId = "fb@beyondevolution.in";
		System.out.println("email Id (" +emailId +") is " + (emailValidator.validate(emailId)?"valid":"not valid"));

//		emailId = "samir_saxena_07@hotmail.com";
//		System.out.println("email Id (" +emailId +") is " + (emailValidator.validate(emailId)?"valid":"not valid"));


	}
}