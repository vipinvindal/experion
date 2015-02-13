package com.bets.experion.mvc.form;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ProjectUploadFormDTO {
	private String projectName;
	private String shortDescription;
	private String longDescription;
	private String projectId;
	
	
	private List<MultipartFile> files;
	private List<String> iamgeTypeResolution;
	private List<String> iamgeTypeName;
	public List<String> getIamgeTypeName() {
		return iamgeTypeName;
	}
	public void setIamgeTypeName(List<String> iamgeTypeName) {
		this.iamgeTypeName = iamgeTypeName;
	}
	private List<String> iamgeTypeId;
	private List<String> projectLogoId;
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
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
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public List<String> getIamgeTypeResolution() {
		return iamgeTypeResolution;
	}
	public void setIamgeTypeResolution(List<String> iamgeTypeResolution) {
		this.iamgeTypeResolution = iamgeTypeResolution;
	}
	public List<String> getIamgeTypeId() {
		return iamgeTypeId;
	}
	public void setIamgeTypeId(List<String> iamgeTypeId) {
		this.iamgeTypeId = iamgeTypeId;
	}
	public List<String> getProjectLogoId() {
		return projectLogoId;
	}
	public void setProjectLogoId(List<String> projectLogoId) {
		this.projectLogoId = projectLogoId;
	}
	public List<MultipartFile> getFiles() {
		return files;
	}
	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}
	
}


