package com.bets.experion.entity;

import static javax.persistence.GenerationType.IDENTITY;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "image_description")
public class ImageType implements Serializable {

	private static final long serialVersionUID = 1L;
	/*id
	display_name
	resolution
	*/
	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(name = "display_name", unique = true, nullable = false, length = 100)	
	private String displayName;

	@Column(name = "resolution", length = 100, nullable = false)	
	private String resolution;

	@Column(name = "status", nullable = true)
	private Boolean status;

	public ImageType()
	{
		
	}

	public ImageType(String displayName, String resolution, Boolean status) {

		this.displayName = displayName;
		this.resolution = resolution;
		this.status = status;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public String getResolution() {
		return resolution;
	}

	public void setResolution(String resolution) {
		this.resolution = resolution;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}


}