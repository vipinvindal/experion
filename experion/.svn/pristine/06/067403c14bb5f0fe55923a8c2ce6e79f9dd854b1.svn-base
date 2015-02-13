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
@Table(name = "feature")
public class Feature implements Serializable {

	private static final long serialVersionUID = 1L;

	/*
	 * id project_id image_path image_name status
	 */

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(name = "feature_detail", length = 5000, nullable = false)
	private String featureDetail;

	
	@ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.ALL})
	@JoinColumn(name = "project_id", nullable = false)
	private Project projectInfo;

	@Column(name = "status", nullable = true)
	private Boolean status;

	public Feature() {

	}

	public Feature(String featureDetail, Project projectInfo, Boolean status) {

		this.featureDetail = featureDetail;
		this.status = status;
		this.projectInfo = projectInfo;

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFeatureDetail() {
		return featureDetail;
	}

	public void setFeatureDetail(String featureDetail) {
		this.featureDetail = featureDetail;
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