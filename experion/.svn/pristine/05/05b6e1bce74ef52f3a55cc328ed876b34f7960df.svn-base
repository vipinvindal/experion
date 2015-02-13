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

import com.bets.experion.dao.FeedDao;
import com.bets.experion.dao.ProjectDao;
import com.bets.experion.entity.Feed;
import com.bets.experion.entity.FeedLogo;
import com.bets.experion.entity.ImageType;
import com.bets.experion.mvc.form.FeedFormDTO;
import com.bets.experion.mvc.form.FileUploadDetailDTO;
import com.bets.experion.utils.Constants;
import com.bets.experion.utils.UtilAppConf;

@Component("feedHandling")
public class FeedHandling {

	private final Logger LOG = Logger.getLogger(FeedHandling.class);

	private ProjectDao projectDao;
	private FeedDao feedDao;
	private UtilAppConf utilApp;

	@Autowired
	public FeedHandling(UtilAppConf utilApp,
			FeedDao feedDao, ProjectDao projectDao) {
		this.projectDao = projectDao;
		this.utilApp = utilApp;
		this.feedDao = feedDao;

	}

	
	
	public Feed getFeedDetailById(String feedID) {
		LOG.info("in getFeedDetailById");

		try {
			long feedId = Long.parseLong(feedID);
			return feedDao.getFeedById(feedId);

		} catch (Exception e) {
			LOG.error("in getFeedDetail", e);
		}
		return null;
	}
	
	public Feed deleteFeedDetailById(String feedID) {
		// TODO Auto-generated method stub
		LOG.info("in deleteFeedDetailById");

		try {
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			long feedId = Long.parseLong(feedID);
			Feed feedInfo =  feedDao.getFeedById(feedId);
			feedInfo.setStatus(false);
			
			
			feedInfo = feedDao.saveOrUpdateFeed(feedInfo);

		} catch (Exception e) {
			LOG.error("in deleteFeedDetailById", e);
		}
		return null;
	}
	
	public List<Feed> getFeedDetail() {
		LOG.info("in getFeedDetail");

		try {
			return feedDao.getFeed();

		} catch (Exception e) {
			LOG.error("in getFeedDetail", e);
		}
		return null;
	}
	
	public List<Feed> getFeedDetails() {
		LOG.info("in getFeedDetail" );

		try {
			return feedDao.getFeed();

		} catch (Exception e) {
			LOG.error("in getFeedDetail", e);
		}
		return null;
	}
	
	
	public Feed addFeed(String feedTitle, String description) {
		LOG.info("in addFeed WITH" + feedTitle + description );

		try {
			Feed feedInfo = new Feed();

			Calendar calendar = Calendar.getInstance();
			java.util.Date creationDate = calendar.getTime();

			LOG.info("creationDate...." + creationDate);

			
			feedInfo.setTitle(feedTitle);
			feedInfo.setDescription(description);
			feedInfo.setStatus(true);
			feedInfo.setCreatedOn(creationDate);
			
			
			feedInfo = feedDao.saveOrUpdateFeed(feedInfo);
			LOG.info("feed addeded with id" + feedInfo.getId() );
			return feedInfo;

		} catch (Exception e) {
			LOG.error("in addFeed", e);
		}
		return null;
	}
	
	/*public Feed updateFeed(String feedId, String feedTitle, String description) {
		LOG.info("in addFeed WITH" + feedTitle + description );

		try {
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			
			Feed feedInfo = feedDao.getFeedById(Long.parseLong(feedId));

			feedInfo.setTitle(feedTitle);
			feedInfo.setDescription(description);
			feedInfo.setStatus(true);
			
			feedInfo = feedDao.saveOrUpdateFeed(feedInfo);
			LOG.info("feed addeded with id" + feedInfo.getId() );
			return feedInfo;

		} catch (Exception e) {
			LOG.error("in addFeed", e);
		}
		return null;
	}
*/
	

	public FileUploadDetailDTO storeImage(FeedFormDTO feedUploadForm, String imageTypeFolder, Feed feedInfo, boolean isEdit) {

		try {
			LOG.info("File name ...." + feedUploadForm.getFiles());
					
			//List<MultipartFile> files = uploadForm.getFiles();

			List<String> fileNames = new ArrayList<String>();
			
			String finalMediaPath = "";
			String fileName = "";
			FileUploadDetailDTO fileUploadDetailDTO = new FileUploadDetailDTO();

			String mediaTempPath = utilApp.getProperty(Constants.IMAGE_FOLDER_PATH, Constants.IMAGE_FOLDER_PATH_DEFAULT);
			
			String mediaFeedPath = mediaTempPath + feedInfo.getTitle().trim() + File.separator;
			File mediaFeedDirCheck = new File(mediaFeedPath);
			
			
			if (!mediaFeedDirCheck.exists()) {
				boolean mediaFeedDirCreate = mediaFeedDirCheck.mkdirs();
				LOG.info("IS Media type DIRECTORY CREATED " + mediaFeedDirCreate);
			}
					
			String mediaTypePath = mediaFeedPath + imageTypeFolder + File.separator;
			File mediaTypeDirCheck = new File(mediaTypePath);
			
			
			if (!mediaTypeDirCheck.exists()) {
				boolean mediaTypeDirCreate = mediaTypeDirCheck.mkdirs();
				LOG.info("IS Media type DIRECTORY CREATED " + mediaTypeDirCreate);
			}		
			
			File mediaDirCheck = new File(mediaTypePath);

			InputStream inputStream = null;
			OutputStream outputStream = null;

			if (null != feedUploadForm.getFiles() && feedUploadForm.getFiles().size() > 0) {
				for (int fileCount = 0; fileCount < feedUploadForm.getFiles().size();fileCount++) {

					MultipartFile multipartFile = feedUploadForm.getFiles().get(fileCount);
					String resolution = feedUploadForm.getIamgeTypeResolution().get(fileCount);
					String imageTypeId = feedUploadForm.getIamgeTypeId().get(fileCount);
					
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
						updateFeedLogo(feedUploadForm.getFeedLogoId().get(fileCount), fileName, finalMediaPath);	
					}else
					{
						addFeedLogo(feedInfo, imageTypeId, fileName, finalMediaPath);	
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
	
	public FeedLogo addFeedLogo(Feed feedInfo, String imageTypeId, String imageName, String imagePath ) {
		LOG.info("in addImage WITH" + imageName + imagePath);

		try {
		
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			ImageType imageTypeInfo = projectDao.getImageTypeById(Long.parseLong(imageTypeId));
			feedInfo = feedDao.getFeedById(feedInfo.getId());
			FeedLogo feedLogoInfo = new FeedLogo();
			
			feedLogoInfo.setImageName(imageName);
			feedLogoInfo.setImagePath(imagePath);
			feedLogoInfo.setFeedInfo(feedInfo);
			feedLogoInfo.setImageTypeInfo(imageTypeInfo);
			feedLogoInfo.setStatus(true);
			
			
			feedLogoInfo = feedDao.saveOrUpdateFeedLogo(feedLogoInfo);
			LOG.info("feed logo addeded with id" + feedLogoInfo.getId() );
			return feedLogoInfo;

		} catch (Exception e) {
			LOG.error("in addImage", e);
		}
		return null;
	}
	
	public FeedLogo updateFeedLogo(String feedLogoId, String imageName, String imagePath ) {
		LOG.info("in addImage WITH" + imageName + imagePath);

		try {
		
			Calendar calendar = Calendar.getInstance();
			java.util.Date updationDate = calendar.getTime();

			LOG.info("creationDate...." + updationDate);
			FeedLogo feedLogoInfo = feedDao.getFeedLogoById(Long.parseLong(feedLogoId));
			
			
			
			feedLogoInfo.setImageName(imageName);
			feedLogoInfo.setImagePath(imagePath);
		
			
			feedLogoInfo = feedDao.saveOrUpdateFeedLogo(feedLogoInfo);
			LOG.info("feed logo addeded with id" + feedLogoInfo.getId() );
			return feedLogoInfo;

		} catch (Exception e) {
			LOG.error("in addImage", e);
		}
		return null;
	}


	public List<FeedLogo> getFeedLogo(Feed feedInfo) {
		// TODO Auto-generated method stub
		LOG.info("in getFeedDetail");

		try {
			return feedDao.getFeedLogo(feedInfo.getId());

		} catch (Exception e) {
			LOG.error("in getFeedDetail", e);
		}
		return null;
	}
	public FeedLogo getFeedLogoByImageTypeId(Feed feedInfo,	ImageType imageTypeInfo) {
		// TODO Auto-generated method stub
		LOG.info("in getFeedLogoByImageTypeId");
		try {
			return feedDao.getFeedLogoByImageTypeId(feedInfo.getId(), imageTypeInfo.getId());

		} catch (Exception e) {
			LOG.error("in getFeedLogoByImageTypeId", e);
		}
		return null;
	}
	public FeedLogo getFeedLogoById(String feedLogoId ) {
		LOG.info("in getFeedLogoById WITH" + feedLogoId );

		try {
			
			FeedLogo feedLogoInfo = feedDao.getFeedLogoById(Long.parseLong(feedLogoId));
			
			
			
			return feedLogoInfo;

		} catch (Exception e) {
			LOG.error("in getFeedLogoById", e);
		}
		return null;
	}	
	
	

	
}
