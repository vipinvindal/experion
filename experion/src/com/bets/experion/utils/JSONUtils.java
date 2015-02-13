package com.bets.experion.utils;

import java.io.BufferedReader;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;

/**
 * 
 * @author siddharth
 *
 */
public class JSONUtils {
	private static Logger logger = Logger.getLogger(JSONUtils.class.getName());

	/**
	 * 
	 * getJSONObject() reads the <code>HTTPRequest</code> and returns the JSONObject in it.  
	 * 
	 * @param request
	 * @return JSONObject
	 */
	public static JSONObject getJSONObject(HttpServletRequest request) {
		try{
			StringBuffer jb = new StringBuffer();
			String line = null;
			BufferedReader reader = request.getReader();
	
			while ((line = reader.readLine()) != null)
				jb.append(line);
	
			return JSONObject.fromObject(jb.toString());
		}
		catch(Exception e){
			logger.error("error in getJSONObject()", e);
		}
		return null;
	}
}
