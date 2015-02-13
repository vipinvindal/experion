package com.bets.experion.entity;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

@Entity
@Table(name = "users", uniqueConstraints = {@UniqueConstraint(columnNames = "user_id")})
public class User implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(name = "user_id", unique = true, nullable = false, length = 252)	
	private String userId;

	@Column(name = "password", length = 25, nullable = false)	
	private String password;

	@Temporal(TemporalType.DATE)
	@Column(name = "created_on", nullable = true)
	private Date createdOn;

	@Column(name = "status", nullable = true)
	private Boolean status;

	@Column(name = "user_name", nullable = true)
	private String userName;

	public User() {
		// TODO Auto-generated constructor stub
	}

	public User(String userId, String password, String country, Date createdOn, Boolean status, String userName) {

		this.userId = userId;
		this.password = password;
		this.createdOn = createdOn;
		this.status = status;
		this.userName = userName;
		

		
	}




	public Long getId() {
		return id;
	}




	public void setId(Long id) {
		this.id = id;
	}




	public String getUserId() {
		return userId;
	}




	public void setUserId(String userId) {
		this.userId = userId;
	}




	public String getPassword() {
		return password;
	}




	public void setPassword(String password) {
		this.password = password;
	}




	public Date getCreatedOn() {
		return createdOn;
	}




	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}




	public Boolean getStatus() {
		return status;
	}




	public void setStatus(Boolean status) {
		this.status = status;
	}




	public String getUserName() {
		return userName;
	}




	public void setUserName(String userName) {
		this.userName = userName;
	}

	

}