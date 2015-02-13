package com.bets.experion.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.bets.experion.dao.ProjectDao;
import com.bets.experion.entity.ImageType;
import com.bets.experion.entity.LocationMap;
import com.bets.experion.entity.Project;
import com.bets.experion.mvc.form.FileUploadDetailDTO;
import com.bets.experion.mvc.form.LocationMapUploadFormDTO;
import com.bets.experion.utils.Constants;
import com.bets.experion.utils.UtilAppConf;

@Component("locationMapHandling")
public class LocationMapHandling {

	private final Logger LOG = Logger.getLogger(LocationMapHandling.class);

	private ProjectDao projectDao;
	private UtilAppConf utilApp;

	@Autowired
	public LocationMapHandling(UtilAppConf utilApp, ProjectDao projectDao) {
		this.utilApp = utilApp;
		this.projectDao = projectDao;

	}

	
	
	public FileUploadDetailDTO storeImage(LocationMapUploadFormDTO locationMapUploadForm, String imageTypeFolder, Project projectInfo,boolean isEdit, String commonName) {

		try {
			LOG.info("File name ...." + locationMapUploadForm.getFiles());
					
			//List<MultipartFile> files = uploadForm.getFiles();

			List<String> fileNames = new ArrayList<String>();
			String commonFileName = "";
			 if(commonName == "")
				   commonFileName = getLocationMapLastId();
			   else
				   commonFileName = commonName;
			String finalMediaPath = "";
			String fileName = "";
			FileUploadDetailDTO fileUploadDetailDTO = new FileUploadDetailDTO();

			String mediaTempPath = utilApp.getProperty(Constants.IMAGE_FOLDER_PATH, Constants.IMAGE_FOLDER_PATH_DEFAULT);
			
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

			if (null != locationMapUploadForm.getFiles() && locationMapUploadForm.getFiles().size() > 0) {
				for (int fileCount = 0; fileCount < locationMapUploadForm.getFiles().size();fileCount++) {

					MultipartFile multipartFile = locationMapUploadForm.getFiles().get(fileCount);
					String resolution = locationMapUploadForm.getIamgeTypeResolution().get(fileCount);
					String imageTypeId = locationMapUploadForm.getIamgeTypeId().get(fileCount);
					
					LOG.info("Image Resoultion and ID  ...." + resolution +"..."+imageTypeId);
					if(multipartFile.getOriginalFilename().replaceAll(" ","") != null && multipartFile.getOriginalFilename().replaceAll(" ","") != "")		
					{
						fileName = resolution.trim().replaceAll(" ","") +multipartFile.getOriginalFilename().replaceAll(" ","");
					
					// Handle file content - multipartFile.getInputStream()
					inputStream = multipartFile.getInputStream();
					LOG.info("File name ...." + fileName);
							

					if (!mediaDirCheck.exists()) {
						boolean mediaTypedirCreate = mediaDirCheck.mkdirs();
						LOG.info("IS Media type DIRECTORY CREATED "
								+ mediaTypedirCreate);
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
					if(isEdit)
					{
						updateLocationMap(projectInfo, imageTypeId, fileName, finalMediaPath, commonFileName);	
					}else
					{
						addLocationMap(projectInfo, imageTypeId, fileName, finalMediaPath, commonFileName);	
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
	
	public LocationMap addLocationMap(Project projectInfo, String imageTypeId, String imageName, String imagePath, String commonFileName ) {
		LOG.info("in addLocationMap WITH" + imageName + imagePath);

		try {
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			
			ImageType imageTypeInfo = projectDao.getImageTypeById(Long.parseLong(imageTypeId));
			projectInfo = projectDao.getProjectById(projectInfo.getId());
			
			LocationMap locationMapInfo = new LocationMap();
			
			locationMapInfo.setImageName(imageName);
			locationMapInfo.setImagePath(imagePath);
			locationMapInfo.setProjectInfo(projectInfo);
			locationMapInfo.setImageTypeInfo(imageTypeInfo);
			locationMapInfo.setStatus(true);
			locationMapInfo.setCommonName(commonFileName);
			locationMapInfo.getProjectInfo().setUpdatedOn(updationDate);
			locationMapInfo = projectDao.saveOrUpdateLocationMap(locationMapInfo);
			LOG.info("project location map addeded with id" + locationMapInfo.getId() );
			return locationMapInfo;

		} catch (Exception e) {
			LOG.error("in addLocationMap", e);
		}
		return null;
	}
	
	public LocationMap getLocationMapById(String locationMapId ) {
		LOG.info("in getLocationMapById WITH" + locationMapId );

		try {
			
			LocationMap locationMapInfo = projectDao.getLocationMapById(Long.parseLong(locationMapId));
			
			
		
			return locationMapInfo;

		} catch (Exception e) {
			LOG.error("in getLocationMapById", e);
		}
		return null;
	}	
	
	public LocationMap updateLocationMap(Project projectInfo, String imageTypeId, String imageName, String imagePath, String commonFileName ) {
		LOG.info("in updateLocationMap WITH" + imageName + imagePath);

		try {
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			
			ImageType imageTypeInfo = projectDao.getImageTypeById(Long.parseLong(imageTypeId));
			
			LocationMap locatioMapInfo = projectDao.getLocationMapByCommonNameAndImageID(imageTypeInfo.getId(), commonFileName);
			if(locatioMapInfo == null)
			{
				locatioMapInfo = new LocationMap();
			}
			locatioMapInfo.setImageName(imageName);
			locatioMapInfo.setImagePath(imagePath);
			locatioMapInfo.setProjectInfo(projectInfo);
			locatioMapInfo.setImageTypeInfo(imageTypeInfo);
			locatioMapInfo.setStatus(true);
			locatioMapInfo.setCommonName(commonFileName);
			locatioMapInfo.getProjectInfo().setUpdatedOn(updationDate);
			locatioMapInfo = projectDao.saveOrUpdateLocationMap(locatioMapInfo);
			LOG.info("project logo addeded with id" + locatioMapInfo.getId() );
			return locatioMapInfo;

		} catch (Exception e) {
			LOG.error("in updateLocationMap", e);
		}
		return null;
	}
	
	public String getLocationMapLastId() {
		LOG.info("in getLocationMapLastId " );

		try {
			
			LocationMap LocationMapInfo = projectDao.getLocationMapLastId();
			 if(LocationMapInfo == null)
			 {
				 return "1";
			 }
			 else
			 {
				long LocationMapLastId = LocationMapInfo.getId() + 1;
				return String.valueOf(LocationMapLastId);
			 }
		
			

		} catch (Exception e) {
			LOG.error("in getLocationMapLastId", e);
		}
		return null;
	}

	
	public List<LocationMap> getLocationMapByProjectId(Long ProjectId) {
		LOG.info("in getLocationMapByProjectId WITH" + ProjectId);
		try {
			List<LocationMap> LocationMapInfoList = projectDao.getLocationMapByProjectId(ProjectId);
			return LocationMapInfoList;
		} catch (Exception e) {
			LOG.error("in getLocationMapByProjectId", e);
		}
		return null;
	}

	public LocationMap deleteSingleLocationMap(String LocationMapId) {
		LOG.info("in deleteSingleLocationMap WITH" + LocationMapId);
		try {
			LocationMap LocationMapInfo = projectDao.getLocationMapById(Long.parseLong(LocationMapId));
			if (LocationMapInfo != null) {
				LocationMapInfo.setStatus(false);
			}
			LocationMapInfo = projectDao.saveOrUpdateLocationMap(LocationMapInfo);

			return LocationMapInfo;
		} catch (Exception e) {
			LOG.error("in deleteSingleLocationMap", e);
		}
		return null;
	}	
	
	public void deleteLocationMap(String commonName) {
		LOG.info("in getLocationMapById WITH" + commonName);
		try {
			List<LocationMap> LocationMapInfoList = projectDao.getLocationMapByCommonName(commonName);
			if (LocationMapInfoList != null) {
				for (LocationMap LocationMapInfo : LocationMapInfoList) {
					LocationMapInfo.setStatus(false);
					projectDao.saveOrUpdateLocationMap(LocationMapInfo);
				}
			}
		} catch (Exception e) {
			LOG.error("in getLocationMapById", e);
		}
	}	
}
