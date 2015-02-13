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
import com.bets.experion.entity.Gallery;
import com.bets.experion.entity.ImageType;
import com.bets.experion.entity.Project;
import com.bets.experion.mvc.form.FileUploadDetailDTO;
import com.bets.experion.mvc.form.GalleryUploadFormDTO;
import com.bets.experion.utils.Constants;
import com.bets.experion.utils.UtilAppConf;

@Component("galleryHandling")
public class GalleryHandling {

	private final Logger LOG = Logger.getLogger(GalleryHandling.class);

	private ProjectDao projectDao;
	private UtilAppConf utilApp;

	@Autowired
	public GalleryHandling(UtilAppConf utilApp, ProjectDao projectDao) {
		this.utilApp = utilApp;
		this.projectDao = projectDao;
	}

	public FileUploadDetailDTO storeImage(GalleryUploadFormDTO galleryUploadForm, String imageTypeFolder, 
			Project projectInfo, boolean isEdit, String commonName) {

		try {
			LOG.info("File name ...." + galleryUploadForm.getFiles());
					
			//List<MultipartFile> files = uploadForm.getFiles();

			List<String> fileNames = new ArrayList<String>();
			String commonFileName = "";
		   if(commonName == "")
			   commonFileName = getGalleryLastId();
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

			if (null != galleryUploadForm.getFiles() && galleryUploadForm.getFiles().size() > 0) {
				for (int fileCount = 0; fileCount < galleryUploadForm.getFiles().size();fileCount++) {

					MultipartFile multipartFile = galleryUploadForm.getFiles().get(fileCount);
					String resolution = galleryUploadForm.getIamgeTypeResolution().get(fileCount);
					String imageTypeId = galleryUploadForm.getIamgeTypeId().get(fileCount);
					
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
						updateGallery(projectInfo, imageTypeId, fileName, finalMediaPath, commonFileName);	
					}else
					{
						addGallery(projectInfo, imageTypeId, fileName, finalMediaPath, commonFileName);	
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
	
	public Gallery addGallery(Project projectInfo, String imageTypeId, String imageName, String imagePath, String commonFileName ) {
		LOG.info("in addGallery WITH" + imageName + imagePath);

		try {
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			
			ImageType imageTypeInfo = projectDao.getImageTypeById(Long.parseLong(imageTypeId));
			projectInfo = projectDao.getProjectById(projectInfo.getId());
			Gallery galleryInfo = new Gallery();
			
			galleryInfo.setImageName(imageName);
			galleryInfo.setImagePath(imagePath);
			galleryInfo.setProjectInfo(projectInfo);
			galleryInfo.setImageTypeInfo(imageTypeInfo);
			galleryInfo.setStatus(true);
			galleryInfo.setCommonName(commonFileName);
			galleryInfo.getProjectInfo().setUpdatedOn(updationDate);
			galleryInfo = projectDao.saveOrUpdateGallery(galleryInfo);
			LOG.info("project logo addeded with id" + galleryInfo.getId() );
			return galleryInfo;

		} catch (Exception e) {
			LOG.error("in addGallery", e);
		}
		return null;
	}
	
	public Gallery updateGallery(Project projectInfo, String imageTypeId, String imageName, String imagePath, String commonFileName ) {
		LOG.info("in updateGallery WITH" + imageName + imagePath);

		try {
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			
			ImageType imageTypeInfo = projectDao.getImageTypeById(Long.parseLong(imageTypeId));
			
			Gallery galleryInfo = projectDao.getGalleryByCommonNameAndImageID(imageTypeInfo.getId(), commonFileName);
			if(galleryInfo == null)
			{
			galleryInfo = new Gallery();
			}
			galleryInfo.setImageName(imageName);
			galleryInfo.setImagePath(imagePath);
			galleryInfo.setProjectInfo(projectInfo);
			galleryInfo.setImageTypeInfo(imageTypeInfo);
			galleryInfo.setStatus(true);
			galleryInfo.setCommonName(commonFileName);
			galleryInfo.getProjectInfo().setUpdatedOn(updationDate);
			galleryInfo = projectDao.saveOrUpdateGallery(galleryInfo);
			LOG.info("project logo addeded with id" + galleryInfo.getId() );
			return galleryInfo;

		} catch (Exception e) {
			LOG.error("in updateGallery", e);
		}
		return null;
	}
	
	public Gallery getGalleryById(String galleryId ) {
		LOG.info("in getGalleryById WITH" + galleryId );

		try {
			
			Gallery galleryInfo = projectDao.getGalleryById(Long.parseLong(galleryId));
			
			
		
			return galleryInfo;

		} catch (Exception e) {
			LOG.error("in getGalleryById", e);
		}
		return null;
	}

	public String getGalleryLastId() {
		LOG.info("in getGalleryLastId " );

		try {
			
			Gallery galleryInfo = projectDao.getGalleryLastId();
			 if(galleryInfo == null)
			 {
				 return "1";
			 }
			 else
			 {
				long galleryLastId = galleryInfo.getId() + 1;
				return String.valueOf(galleryLastId);
			 }
		
			

		} catch (Exception e) {
			LOG.error("in getGalleryLastId", e);
		}
		return null;
	}

	
	public List<Gallery> getGalleryByProjectId(Long ProjectId) {
		LOG.info("in getGalleryByProjectId WITH" + ProjectId );
		try {
			List<Gallery> galleryInfoList = projectDao.getGalleryByProjectId(ProjectId);
			return galleryInfoList;
		} catch (Exception e) {
			LOG.error("in getGalleryByProjectId", e);
		}
		return null;
	}

	public Gallery deleteSingleGallery(String galleryId) {
		LOG.info("in deleteSingleGallery WITH" + galleryId );
		try {
			Gallery galleryInfo = projectDao.getGalleryById(Long.parseLong(galleryId));
			if(galleryInfo != null)
			{
				galleryInfo.setStatus(false);
			}
			galleryInfo = projectDao.saveOrUpdateGallery(galleryInfo);
			return galleryInfo;
		} catch (Exception e) {
			LOG.error("in deleteSingleGallery", e);
		}
		return null;
	}	
	
	public void deleteGallery(String commonName) {
		LOG.info("in getGalleryById WITH" + commonName );
		try {
			List<Gallery> galleryInfoList = projectDao.getGalleryByCommonName(commonName);
			if(galleryInfoList != null)
			{ 
				for(Gallery galleryInfo : galleryInfoList){
					galleryInfo.setStatus(false);
					projectDao.saveOrUpdateGallery(galleryInfo);
				}
			}
		} catch (Exception e) {
			LOG.error("in getGalleryById", e);
		}
	}	
}
