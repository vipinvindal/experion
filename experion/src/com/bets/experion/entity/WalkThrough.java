package com.bets.experion.entity;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "walkthrough")
public class WalkThrough implements Serializable {

	private static final long serialVersionUID = 1L;

	/*
	 * id project_id image_path image_name status
	 */

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(name = "url_link", length = 252, nullable = false)
	private String urlLink;

	@Column(name = "url_name", nullable = true)
	private String urlName;

	@ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.ALL})
	@JoinColumn(name = "project_id", nullable = false)
	private Project projectInfo;

	@Column(name = "status", nullable = true)
	private Boolean status;

	public WalkThrough() {
		// TODO Auto-generated constructor stub
	}

	public WalkThrough(String urlLink, String urlName, Project projectInfo,
			Boolean status) {

		this.urlName = urlName;
		this.urlLink = urlLink;
		this.status = status;
		this.projectInfo = projectInfo;
		

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUrlLink() {
		return urlLink;
	}

	public void setUrlLink(String urlLink) {
		this.urlLink = urlLink;
	}

	public String getUrlName() {
		return urlName;
	}

	public void setUrlName(String urlName) {
		this.urlName = urlName;
	}

	public Project getProjectInfo() {
		return projectInfo;
	}

	public void setProjectInfo(Project projectInfo) {
		this.projectInfo = projectInfo;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	

}