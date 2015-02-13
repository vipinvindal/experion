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
@Table(name = "location_map")
public class LocationMap implements Serializable {

	private static final long serialVersionUID = 1L;

	/*
	 * id project_id image_path image_name status
	 */

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(name = "image_path", length = 252, nullable = false)
	private String imagePath;

	@Column(name = "image_name", nullable = true)
	private String imageName;

	@Column(name = "common_name", nullable = true)
	private String commonName;
	
	@ManyToOne(fetch = FetchType.EAGER, cascade = {CascadeType.ALL})
	@JoinColumn(name = "project_id", nullable = false)
	private Project projectInfo;

	@Column(name = "status", nullable = true)
	private Boolean status;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "image_type_id", nullable = false)
	private ImageType imageTypeInfo;

	public LocationMap() {

	}

	public LocationMap(String imagePath, String imageName, Project projectInfo,
			Boolean status, ImageType imageTypeInfo, String commonName) {

		this.imageName = imageName;
		this.imagePath = imagePath;
		this.status = status;
		this.projectInfo = projectInfo;
		this.imageTypeInfo = imageTypeInfo;
		this.commonName = commonName;

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getImageName() {
		return imageName;
	}

	public void setImageName(String imageName) {
		this.imageName = imageName;
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

	public ImageType getImageTypeInfo() {
		return imageTypeInfo;
	}

	public void setImageTypeInfo(ImageType imageTypeInfo) {
		this.imageTypeInfo = imageTypeInfo;
	}

	public String getCommonName() {
		return commonName;
	}

	public void setCommonName(String commonName) {
		this.commonName = commonName;
	}

}