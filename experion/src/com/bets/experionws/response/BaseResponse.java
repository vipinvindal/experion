package com.bets.experionws.response;

import com.bets.experion.entity.User;



public class BaseResponse {
	private Long responseCode = null;
	private String responseMessage = null;
	private String responseType = null;
	private Boolean userStatus = null;
	private User user = null;

	public Long getResponseCode() {
		return responseCode;
	}
	public void setResponseCode(Long responseCode) {
		this.responseCode = responseCode;
	}
	public String getResponseMessage() {
		return responseMessage;
	}
	public void setResponseMessage(String responseMessage) {
		this.responseMessage = responseMessage;
	}
	
	public boolean isError(){
		return (responseCode < 200?true:false);
	}
	public String getResponseType() {
		return responseType;
	}
	public void setResponseType(String responseType) {
		this.responseType = responseType;
	}
	public Boolean getUserStatus() {
		return userStatus;
	}
	public void setUserStatus(Boolean userStatus) {
		this.userStatus = userStatus;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
}
