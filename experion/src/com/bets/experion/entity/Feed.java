package com.bets.experion.entity;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "feed")
public class Feed implements Serializable {

	private static final long serialVersionUID = 1L;
	

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(name = "title",  nullable = false, length = 252)
	private String title;

	@Column(name = "description", length = 500, nullable = false)
	private String description;
	
	@Temporal(TemporalType.DATE)
	@Column(name = "created_on", nullable = true)
	private Date createdOn;
	
	@Column(name = "status", nullable = true)
	private Boolean status;

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "feedInfo", cascade = {CascadeType.ALL}, orphanRemoval=true)
	private Set<FeedLogo> feedLogo = new HashSet<FeedLogo>(0);
	
	


	public Feed() {
		// TODO Auto-generated constructor stub
	}

	public Feed(String title, String description, Date createdOn, Boolean status) {

		this.title = title;
		this.description = description;
		this.createdOn = createdOn;
		this.status = status;
		

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public Set<FeedLogo> getFeedLogo() {
		return feedLogo;
	}

	public void setFeedLogo(Set<FeedLogo> feedLogo) {
		this.feedLogo = feedLogo;
	}

	}