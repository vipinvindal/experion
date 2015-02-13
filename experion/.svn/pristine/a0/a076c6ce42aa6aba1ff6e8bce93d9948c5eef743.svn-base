package in.bets.experion.test;

import java.net.URI;

import net.sf.json.JSONObject;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.BasicConfigurator;

public class JSONTest {

	private boolean testReg() throws Exception{
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("resolution", "163dpi Non-Retina 3.5");
		jsonObj.put("updateDate", "2013-12-02");
		

		System.out.println(jsonObj.toString());
		
		URI url = new URI("http://localhost:8080/experion/clientGetProject.html");
		
		HttpClient httpClient = new DefaultHttpClient();

	    try {
	        HttpPost postRequest = new HttpPost(url);
	        
	        postRequest.setHeader("req", jsonObj.toString());
	        HttpResponse response = httpClient.execute(postRequest);

	        String jsonValueString = EntityUtils.toString(response.getEntity());
	        System.out.println("SIDDHARTH:::::" + jsonValueString);
	        
	    }catch (Exception ex) {
	    	ex.printStackTrace();
	    } finally {
	        httpClient.getConnectionManager().shutdown();
	    }
		
		return true;
	}
	
	public static void main(String args[]) throws Exception{
		BasicConfigurator.configure();
		JSONTest jsonTest = new JSONTest();
		
		System.out.println("Registration test is: " + (jsonTest.testReg()?"Passed":"Failed"));
		
	}
}
