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
@Table(name = "projects")
public class Project implements Serializable {

	private static final long serialVersionUID = 1L;
	/*
	 * id name date logo_path image_path description
	 */

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(name = "name", nullable = false, length = 252)
	private String name;

	@Column(name = "short_description", length = 500, nullable = false)
	private String shortDescription;
	
	@Column(name = "long_description", length = 3000, nullable = false)
	private String longDescription;

	@Temporal(TemporalType.DATE)
	@Column(name = "created_on", nullable = true)
	private Date createdOn;
	
	@Temporal(TemporalType.DATE)
	@Column(name = "updated_on", nullable = true)
	private Date updatedOn;

	@Column(name = "status", nullable = true)
	private Boolean status;

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "projectInfo", cascade = {CascadeType.ALL}, orphanRemoval=true)
	private Set<ProjectLogo> projectLogo = new HashSet<ProjectLogo>(0);
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "projectInfo", cascade = {CascadeType.ALL}, orphanRemoval=true)
	private Set<Gallery> gallery = new HashSet<Gallery>(0);
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "projectInfo", cascade = {CascadeType.ALL}, orphanRemoval=true)
	private Set<WalkThrough> walkThrough = new HashSet<WalkThrough>(0);
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "projectInfo", cascade = {CascadeType.ALL}, orphanRemoval=true)
	private Set<Feature> feature = new HashSet<Feature>(0);
	
	@OneToMany(fetch = FetchType.EAGER, mappedBy = "projectInfo", cascade = {CascadeType.ALL}, orphanRemoval=true)
	private Set<LocationMap> locationMap = new HashSet<LocationMap>(0);


	public Project() {
		// TODO Auto-generated constructor stub
	}

	public Project(String name, String shortDescription,String longDescription,
			Date createdOn, Boolean status) {

		this.name = name;
		this.shortDescription = shortDescription;
		this.createdOn = createdOn;
		this.status = status;
		

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getShortDescription() {
		return shortDescription;
	}

	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}

	public String getLongDescription() {
		return longDescription;
	}

	public void setLongDescription(String longDescription) {
		this.longDescription = longDescription;
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

	public Date getUpdatedOn() {
		return updatedOn;
	}

	public void setUpdatedOn(Date updatedOn) {
		this.updatedOn = updatedOn;
	}

	public Set<ProjectLogo> getProjectLogo() {
		return projectLogo;
	}

	public void setProjectLogo(Set<ProjectLogo> projectLogo) {
		this.projectLogo = projectLogo;
	}

	public Set<Gallery> getGallery() {
		return gallery;
	}

	public void setGallery(Set<Gallery> gallery) {
		this.gallery = gallery;
	}

	public Set<WalkThrough> getWalkThrough() {
		return walkThrough;
	}

	public void setWalkThrough(Set<WalkThrough> walkThrough) {
		this.walkThrough = walkThrough;
	}

	public Set<Feature> getFeature() {
		return feature;
	}

	public void setFeature(Set<Feature> feature) {
		this.feature = feature;
	}

	public Set<LocationMap> getLocationMap() {
		return locationMap;
	}

	public void setLocationMap(Set<LocationMap> locationMap) {
		this.locationMap = locationMap;
	}

	
}