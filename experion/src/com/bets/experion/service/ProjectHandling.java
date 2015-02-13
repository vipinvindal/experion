package com.bets.experion.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.bets.experion.dao.ProjectDao;
import com.bets.experion.entity.Feature;
import com.bets.experion.entity.ImageType;
import com.bets.experion.entity.Project;
import com.bets.experion.entity.ProjectLogo;
import com.bets.experion.entity.WalkThrough;
import com.bets.experion.mvc.form.FeatureDTO;
import com.bets.experion.mvc.form.FileUploadDetailDTO;
import com.bets.experion.mvc.form.LogoFormDTO;
import com.bets.experion.mvc.form.ProjectUploadFormDTO;
import com.bets.experion.mvc.form.WalkthroughDTO;
import com.bets.experion.utils.Constants;
import com.bets.experion.utils.UtilAppConf;

@Component("projectHandling")
public class ProjectHandling {

	private final Logger LOG = Logger.getLogger(ProjectHandling.class);

	private ProjectDao projectDao;
	private UtilAppConf utilApp;

	@Autowired
	public ProjectHandling(UtilAppConf utilApp, ProjectDao projectDao) {
		this.utilApp = utilApp;
		this.projectDao = projectDao;

	}

	
	public List<ImageType> getImageTypeNotInProject(Long projectId) {
		LOG.info("in getImageTypeNotInProject");

		try {
			return projectDao.getImageTypeNotInProject(projectId);

		} catch (Exception e) {
			LOG.error("in getImageTypeNotInProject", e);
		}
		return null;
	}
	
	public List<ImageType> getImageType() {
		LOG.info("in getImageType");

		try {
			return projectDao.getImageType();

		} catch (Exception e) {
			LOG.error("in getImageType", e);
		}
		return null;
	}
	
	public Project getProjectDetailById(String projectID) {
		LOG.info("in getProjectDetail");

		try {
			long projectId = Long.parseLong(projectID);
			return projectDao.getProjectById(projectId);

		} catch (Exception e) {
			LOG.error("in getProjectDetail", e);
		}
		return null;
	}
	
	public Project deleteProjectDetailById(String projectID) {
		LOG.info("in deleteProjectDetailById");

		try {
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			long projectId = Long.parseLong(projectID);
			Project projectInfo =  projectDao.getProjectById(projectId);
			projectInfo.setStatus(false);
			projectInfo.setUpdatedOn(updationDate);
			
			projectInfo = projectDao.saveOrUpdateProject(projectInfo);

		} catch (Exception e) {
			LOG.error("in deleteProjectDetailById", e);
		}
		return null;
	}
	public ImageType getImageTypeByResolution(String resolution) {
		try {
			return projectDao.getImageTypeByName(resolution);
		} catch (Exception e) {
			LOG.error("in getImageType", e);
		}
		return null;
	}
	public List<Project> getProjectDetail() {
		LOG.info("in getProjectDetail");

		try {
			return projectDao.getProject();

		} catch (Exception e) {
			LOG.error("in getProjectDetail", e);
		}
		return null;
	}
	
	public List<Project> getProjectDetails(Date projectUpdate, Long imageTypeId) {
		LOG.info("in getProjectDetail" );

		try {
			return projectDao.getProjects(projectUpdate, imageTypeId, true);

		} catch (Exception e) {
			LOG.error("in getProjectDetail", e);
		}
		return null;
	}
	
	
	public Project addProject(String projectName, String shortDescription, String longDescription) {
		LOG.info("in addProject WITH" + projectName + shortDescription );

		try {
			Project projectInfo = new Project();

			Calendar calendar = Calendar.getInstance();
			java.util.Date creationDate = calendar.getTime();

			LOG.info("creationDate...." + creationDate);

			
			projectInfo.setName(projectName);
			projectInfo.setShortDescription(shortDescription);
			projectInfo.setStatus(true);
			projectInfo.setCreatedOn(creationDate);
			projectInfo.setLongDescription(longDescription);
			projectInfo.setUpdatedOn(creationDate);
			
			projectInfo = projectDao.saveOrUpdateProject(projectInfo);
			LOG.info("project addeded with id" + projectInfo.getId() );
			return projectInfo;

		} catch (Exception e) {
			LOG.error("in addProject", e);
		}
		return null;
	}
	
	public Project updateProject(String projectId, String projectName, String shortDescription, String longDescription) {
		LOG.info("in addProject WITH" + projectName + shortDescription );

		try {
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			
			Project projectInfo = projectDao.getProjectById(Long.parseLong(projectId));
			projectInfo.setShortDescription(shortDescription);
			projectInfo.setLongDescription(longDescription);
			projectInfo.setUpdatedOn(updationDate);
			projectInfo.setName(projectName);
			projectInfo = projectDao.saveOrUpdateProject(projectInfo);
			LOG.info("project addeded with id" + projectInfo.getId() );
			return projectInfo;

		} catch (Exception e) {
			LOG.error("in addProject", e);
		}
		return null;
	}

	

	public FileUploadDetailDTO storeImage(ProjectUploadFormDTO projectUploadForm, String imageTypeFolder, 
			Project projectInfo, boolean isEdit) {
		try {
			LOG.info("File name ...." + projectUploadForm.getFiles());
			
			List<String> fileNames = new ArrayList<String>();
			String finalMediaPath = "";
			String fileName = "";
			FileUploadDetailDTO fileUploadDetailDTO = new FileUploadDetailDTO();

			String mediaTempPath = utilApp.getProperty(Constants.IMAGE_FOLDER_PATH,	Constants.IMAGE_FOLDER_PATH_DEFAULT);

			String mediaProjectPath = mediaTempPath + projectInfo.getName().trim() + File.separator;
			File mediaProjectDirCheck = new File(mediaProjectPath);

			if (!mediaProjectDirCheck.exists()) {
				boolean mediaProjectDirCreate = mediaProjectDirCheck.mkdirs();
				LOG.info("IS Media type DIRECTORY CREATED " + mediaProjectDirCreate);
			}

			String mediaTypePath = mediaProjectPath + imageTypeFolder + File.separator;
			File mediaTypeDirCheck = new File(mediaTypePath);

			if (!mediaTypeDirCheck.exists()) {
				boolean mediaTypeDirCreate = mediaTypeDirCheck.mkdirs();
				LOG.info("IS Media type DIRECTORY CREATED " + mediaTypeDirCreate);
			}

			File mediaDirCheck = new File(mediaTypePath);
			InputStream inputStream = null;
			OutputStream outputStream = null;

			if (null != projectUploadForm.getFiles() && projectUploadForm.getFiles().size() > 0) {
				
				for (int fileCount = 0; fileCount < projectUploadForm.getFiles().size(); fileCount++) {

					MultipartFile multipartFile = projectUploadForm.getFiles().get(fileCount);
					String resolution = projectUploadForm.getIamgeTypeResolution().get(fileCount);
					String imageTypeId = projectUploadForm.getIamgeTypeId().get(fileCount);

					LOG.info("Image Resoultion and ID  ...." + resolution + "..." + imageTypeId);
					if (multipartFile.getOriginalFilename().replaceAll(" ", "") != null
							&& multipartFile.getOriginalFilename().replaceAll(" ", "") != "") {
						
						fileName = resolution.trim().replaceAll(" ", "") + multipartFile.getOriginalFilename().replaceAll(" ", "");
						
						// Handle file content - multipartFile.getInputStream()
						inputStream = multipartFile.getInputStream();
						LOG.info("File name ...." + fileName);

						if (!mediaDirCheck.exists()) {
							boolean mediaTypedirCreate = mediaDirCheck.mkdirs();
							LOG.info("IS Media type DIRECTORY CREATED " + mediaTypedirCreate);
						}

						finalMediaPath = mediaDirCheck + File.separator + fileName;
						outputStream = new FileOutputStream(finalMediaPath);

						int readBytes = 0;
						byte[] buffer = new byte[8192];
						while ((readBytes = inputStream.read(buffer, 0, 8192)) != -1) {
							outputStream.write(buffer, 0, readBytes);
						}
						outputStream.close();
						inputStream.close();
						if (isEdit) {
							updateProjectLogo(projectUploadForm
									.getProjectLogoId().get(fileCount),
									fileName, finalMediaPath);
						} else {
							addProjectLogo(projectInfo, imageTypeId, fileName, finalMediaPath);
						}
						fileNames.add(finalMediaPath);
						LOG.info("finalMediaPath" + finalMediaPath);
					}// Close if file name
				}// close for loop
				fileUploadDetailDTO.setFileName(fileName);
				fileUploadDetailDTO.setFilePath(finalMediaPath);
				fileUploadDetailDTO.setFilePathList(fileNames);
			}
			return fileUploadDetailDTO;
		} catch (Exception e) {
			LOG.error("Error in stroeImage", e);
		}
		return null;
	}
	
	public FileUploadDetailDTO storeImage(LogoFormDTO logoFormDTO, String imageTypeFolder, 
			Project projectInfo, boolean isEdit) {
		try {
			LOG.info("File name ...." + logoFormDTO.getFiles());
			
			List<String> fileNames = new ArrayList<String>();
			String finalMediaPath = "";
			String fileName = "";
			FileUploadDetailDTO fileUploadDetailDTO = new FileUploadDetailDTO();

			String mediaTempPath = utilApp.getProperty(Constants.IMAGE_FOLDER_PATH,	Constants.IMAGE_FOLDER_PATH_DEFAULT);

			String mediaProjectPath = mediaTempPath + projectInfo.getName().trim() + File.separator;
			File mediaProjectDirCheck = new File(mediaProjectPath);

			if (!mediaProjectDirCheck.exists()) {
				boolean mediaProjectDirCreate = mediaProjectDirCheck.mkdirs();
				LOG.info("IS Media type DIRECTORY CREATED " + mediaProjectDirCreate);
			}

			String mediaTypePath = mediaProjectPath + imageTypeFolder + File.separator;
			File mediaTypeDirCheck = new File(mediaTypePath);

			if (!mediaTypeDirCheck.exists()) {
				boolean mediaTypeDirCreate = mediaTypeDirCheck.mkdirs();
				LOG.info("IS Media type DIRECTORY CREATED " + mediaTypeDirCreate);
			}

			File mediaDirCheck = new File(mediaTypePath);
			InputStream inputStream = null;
			OutputStream outputStream = null;

			if (null != logoFormDTO.getFiles() && logoFormDTO.getFiles().size() > 0) {
				
				for (int fileCount = 0; fileCount < logoFormDTO.getFiles().size(); fileCount++) {

					MultipartFile multipartFile = logoFormDTO.getFiles().get(fileCount);
					String resolution = logoFormDTO.getIamgeTypeResolution().get(fileCount);
					String imageTypeId = logoFormDTO.getIamgeTypeId().get(fileCount);

					LOG.info("Image Resoultion and ID  ...." + resolution + "..." + imageTypeId);
					if (multipartFile.getOriginalFilename().replaceAll(" ", "") != null
							&& multipartFile.getOriginalFilename().replaceAll(" ", "") != "") {
						
						fileName = resolution.trim().replaceAll(" ", "") + multipartFile.getOriginalFilename().replaceAll(" ", "");
						
						// Handle file content - multipartFile.getInputStream()
						inputStream = multipartFile.getInputStream();
						LOG.info("File name ...." + fileName);

						if (!mediaDirCheck.exists()) {
							boolean mediaTypedirCreate = mediaDirCheck.mkdirs();
							LOG.info("IS Media type DIRECTORY CREATED " + mediaTypedirCreate);
						}

						finalMediaPath = mediaDirCheck + File.separator + fileName;
						outputStream = new FileOutputStream(finalMediaPath);

						int readBytes = 0;
						byte[] buffer = new byte[8192];
						while ((readBytes = inputStream.read(buffer, 0, 8192)) != -1) {
							outputStream.write(buffer, 0, readBytes);
						}
						outputStream.close();
						inputStream.close();
						if (isEdit) {
							updateProjectLogo(logoFormDTO
									.getProjectLogoId().get(fileCount),
									fileName, finalMediaPath);
						} else {
							addProjectLogo(projectInfo, imageTypeId, fileName, finalMediaPath);
						}
						fileNames.add(finalMediaPath);
						LOG.info("finalMediaPath" + finalMediaPath);
					}// Close if file name
				}// close for loop
				fileUploadDetailDTO.setFileName(fileName);
				fileUploadDetailDTO.setFilePath(finalMediaPath);
				fileUploadDetailDTO.setFilePathList(fileNames);
			}
			return fileUploadDetailDTO;
		} catch (Exception e) {
			LOG.error("Error in stroeImage", e);
		}
		return null;
	}
	
	
	public ProjectLogo addProjectLogo(Project projectInfo, String imageTypeId, String imageName, String imagePath ) {
		LOG.info("in addImage WITH" + imageName + imagePath);

		try {
		
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			ImageType imageTypeInfo = projectDao.getImageTypeById(Long.parseLong(imageTypeId));
			projectInfo = projectDao.getProjectById(projectInfo.getId());
			ProjectLogo projectLogoInfo = new ProjectLogo();
			
			projectLogoInfo.setImageName(imageName);
			projectLogoInfo.setImagePath(imagePath);
			projectLogoInfo.setProjectInfo(projectInfo);
			projectLogoInfo.setImageTypeInfo(imageTypeInfo);
			projectLogoInfo.setStatus(true);
			projectLogoInfo.getProjectInfo().setUpdatedOn(updationDate);
			
			projectLogoInfo = projectDao.saveOrUpdateProjectLogo(projectLogoInfo);
			LOG.info("project logo addeded with id" + projectLogoInfo.getId() );
			return projectLogoInfo;

		} catch (Exception e) {
			LOG.error("in addImage", e);
		}
		return null;
	}
	
	public ProjectLogo updateProjectLogo(String projectLogoId, String imageName, String imagePath ) {
		LOG.info("in addImage WITH" + imageName + imagePath);

		try {
		
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			ProjectLogo projectLogoInfo = projectDao.getProjectLogoById(Long.parseLong(projectLogoId));
			
			
			
			projectLogoInfo.setImageName(imageName);
			projectLogoInfo.setImagePath(imagePath);
			projectLogoInfo.getProjectInfo().setUpdatedOn(updationDate);
			
			projectLogoInfo = projectDao.saveOrUpdateProjectLogo(projectLogoInfo);
			LOG.info("project logo addeded with id" + projectLogoInfo.getId() );
			return projectLogoInfo;

		} catch (Exception e) {
			LOG.error("in addImage", e);
		}
		return null;
	}


	public List<ProjectLogo> getProjectLogo(Project projectInfo) {
		LOG.info("in getProjectDetail");
		try {
			return projectDao.getProjectLogo(projectInfo.getId());
		} catch (Exception e) {
			LOG.error("in getProjectDetail", e);
		}
		return null;
	}
	
	public ProjectLogo getProjectLogoByImageTypeId(Project projectInfo,	ImageType imageTypeInfo) {
		LOG.info("in getProjectLogoByImageTypeId");
		try {
			return projectDao.getProjectLogoByImageTypeId(projectInfo.getId(), imageTypeInfo.getId());
		} catch (Exception e) {
			LOG.error("in getProjectLogoByImageTypeId", e);
		}
		return null;
	}
	
	public ProjectLogo getProjectLogoById(String projectLogoId ) {
		LOG.info("in getProjectLogoById WITH" + projectLogoId );
		try {
			ProjectLogo projectLogoInfo = projectDao.getProjectLogoById(Long.parseLong(projectLogoId));
			return projectLogoInfo;
		} catch (Exception e) {
			LOG.error("in getProjectLogoById", e);
		}
		return null;
	}	
	public List<WalkThrough> getWalkThrough(Long projectId) {
		LOG.info("in getWalkthrough");
		try {
			return projectDao.getWalkThrough(projectId);
		} catch (Exception e) {
			LOG.error("in getWalkthrough", e);
		}
		return null;
	}

	public void addWalkThrough(Project projectInfo, WalkthroughDTO walkthroughForm) {
		try {
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			WalkThrough walkThroughInfo = new WalkThrough();
			
			walkThroughInfo.setProjectInfo(projectInfo);
			walkThroughInfo.setStatus(true);
			walkThroughInfo.setUrlLink(walkthroughForm.getWalkThroughLink());
			walkThroughInfo.getProjectInfo().setUpdatedOn(updationDate);
			projectDao.saveOrUpdateWalkThrough(walkThroughInfo);

		} catch (Exception e) {
			LOG.error("in getWalkthrough", e);
		}
		
		
	}
	public void deleteWalkThrough(String walkThroughId) {
		try {
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			WalkThrough walkThroughInfo = projectDao.getWalkThroughById(Long.parseLong(walkThroughId));
			walkThroughInfo.getProjectInfo().setUpdatedOn(updationDate);
			walkThroughInfo.setStatus(false);
			projectDao.saveOrUpdateWalkThrough(walkThroughInfo);
		} catch (Exception e) {
			LOG.error("in getWalkthrough", e);
		}
	}

	public List<Feature> getFeature(Long projectId) {
		LOG.info("in getFeature");
		try {
			return projectDao.getFeature(projectId);
		} catch (Exception e) {
			LOG.error("in getFeature", e);
		}
		return null;
	}

	public Feature updateFeature(Project projectInfo, FeatureDTO featureUploadForm, boolean isNewFeature) {
		LOG.info("in updateFeature");
		try {
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			Feature featureInfo = new Feature();
			if(isNewFeature)
			{
				featureInfo.setProjectInfo(projectInfo);
				featureInfo.setFeatureDetail(featureUploadForm.getFeature());
				featureInfo.setStatus(true);
				featureInfo.getProjectInfo().setUpdatedOn(updationDate);
			}
			else
			{
				featureInfo = projectDao.getFeatureById(Long.parseLong(featureUploadForm.getFeatureId()));
				featureInfo.setFeatureDetail(featureUploadForm.getFeature());
				featureInfo.getProjectInfo().setUpdatedOn(updationDate);
			}
			return projectDao.saveOrUpdateFeature(featureInfo);

		} catch (Exception e) {
			LOG.error("in updateFeature", e);
		}
		return null;
	}
}
