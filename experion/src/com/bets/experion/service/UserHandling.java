package com.bets.experion.service;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.bets.experion.dao.UserDao;
import com.bets.experion.entity.ImageType;
import com.bets.experion.entity.User;
import com.bets.experion.utils.UtilAppConf;
import com.bets.experionws.response.BaseResponse;
import com.bets.experionws.response.ResponseCodes;

@Component("userHandling")
public class UserHandling {

	private final Logger LOG = Logger.getLogger(UserHandling.class);

	
	private UserDao userDao;
	private UtilAppConf utilApp;
	

	@Autowired
	public UserHandling(UserDao userdao, UtilAppConf utilApp) {
		this.userDao = userdao;
		this.utilApp = utilApp;
		
	}

	
	
	public BaseResponse validateUser(String userID, String password) {
		BaseResponse response = new BaseResponse();
		response.setResponseType("SignInResponse");
		User existingUser = userDao.getUserByUserID(userID);
		
		if(existingUser != null){
			response.setUser(existingUser);
			if(existingUser.getPassword().equals(password)){
				LOG.info("valid userID: userID exists and passwords match");
					response.setResponseCode(ResponseCodes.VALID_USER);
					response.setResponseMessage(utilApp.getProperty(ResponseCodes.VALID_USER.toString(),"VALID_USER"));
					response.setUserStatus(Boolean.TRUE);
				
			}
			else{
				response.setResponseCode(ResponseCodes.INVALID_PASSWORD);
				response.setResponseMessage(utilApp.getProperty(ResponseCodes.INVALID_PASSWORD.toString(),"INVALID_PASSWORD"));
			}
		}
		else {
			response.setResponseCode(ResponseCodes.INVALID_USER);
			response.setResponseMessage(utilApp.getProperty(ResponseCodes.INVALID_USER.toString(),"INVALID_USER"));
		}
		return response;
	}
public ImageType getImageType()
{
	
	//User existingUser = userDao.getUserByUserID(userID);
	return null;
}
		
}
