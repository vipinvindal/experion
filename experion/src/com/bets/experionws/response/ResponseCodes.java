package com.bets.experionws.response;

public class ResponseCodes {
	//FATAL ERRORS 
	public static Long UNHANDLED_ERROR = 1000L;
	public static Long UNKNOWN_MEDIA_TYPE = 1001L;

	//FAILURE CODES
	public static Long INVALID_USER = 100L;
	public static Long INVALID_PASSWORD = 101L;
	public static Long INVALID_IMAGE_TYPE = 103L;
	
	public static Long NO_PROJECT_FOUND = 104L;
	public static Long NO_FEED_FOUND = 104L;
	
	
	
	public static Long VALID_USER = 200L;
	public static Long PROJECT_FOUND = 400L;
	public static Long FEED_FOUND = 400L;
}
