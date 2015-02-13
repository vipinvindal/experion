package com.bets.experion.mvc.form;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class LocationMapUploadFormDTO {
	private String projectName;
	private String projectId;
	
	
	private List<MultipartFile> files;
	private List<String> iamgeTypeResolution;
	private List<String> iamgeTypeId;
	private List<String> gallaryId;
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public List<MultipartFile> getFiles() {
		return files;
	}
	public void setFiles(List<MultipartFile> files) {
		this.files = files;
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
	public List<String> getGallaryId() {
		return gallaryId;
	}
	public void setGallaryId(List<String> gallaryId) {
		this.gallaryId = gallaryId;
	}
	
	
}


