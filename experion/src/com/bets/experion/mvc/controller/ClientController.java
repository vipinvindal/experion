package com.bets.experion.mvc.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bets.experion.entity.Feature;
import com.bets.experion.entity.Feed;
import com.bets.experion.entity.FeedLogo;
import com.bets.experion.entity.Gallery;
import com.bets.experion.entity.ImageType;
import com.bets.experion.entity.LocationMap;
import com.bets.experion.entity.Project;
import com.bets.experion.entity.ProjectLogo;
import com.bets.experion.entity.WalkThrough;
import com.bets.experion.service.FeedHandling;
import com.bets.experion.service.ProjectHandling;
import com.bets.experion.utils.Constants;
import com.bets.experion.utils.JSONUtils;
import com.bets.experion.utils.UtilAppConf;
import com.bets.experionws.response.ResponseCodes;

@Controller
public class ClientController {

	private static final Logger LOG = Logger.getLogger(ClientController.class);

	private UtilAppConf utilApp;
	private ProjectHandling projectHandling;
	private FeedHandling feedHandling;
	

	@Autowired
	public ClientController(UtilAppConf utilApp, ProjectHandling projectHandling, FeedHandling feedHandling) {

		this.utilApp = utilApp;
		this.projectHandling = projectHandling;
		this.feedHandling = feedHandling;
	}

	/**
	 * /clientGetProject.html
	 * clientGetProject is used by client to get all project and its active related data like logo, short description.
	 * Takes <code>net.sf.json.JSONObject</code> object within the post request 
	 * To test this method following json object can be used 
	 * <code>
	 *	        JSONObject jsonObject = new JSONObject();
	 *	        jsonObject.put("resolution","resolution");
	 *			jsonObject.put("updateDate","updateDate");
	 *
	 *	       
	 * </code>
	 * 
	 * @param request
	 * @param response
	 * 
	 * INVALID_IMAGE_TYPE = 103
	 * PROJECT_FOUND = 400
	 * NO_PROJECT_FOUND = 104
	 * 
	 * 
	 * @return HttpEntity<byte[]>
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/clientGetProject.html")
	public HttpEntity<byte[]> getProject(HttpServletRequest request,
			HttpServletResponse response) {
		LOG.info("clientGetProject.......");

		String responseMsg = "";
		Long responseCode = 0L;
		
		JSONObject jsonObj = JSONUtils.getJSONObject(request);
		InetAddress ip;
		try {
			ip = InetAddress.getLocalHost();
			LOG.info("Current IP address : " + ip.getHostAddress());
		} catch (UnknownHostException e) {
			e.printStackTrace();
			LOG.error("error in clientGetProject()", e);
		}

		try {

			JSONObject jsonObjResponse = new JSONObject();
			JSONArray projectDetails = new JSONArray();
			
			JSONArray projectDeleteDetails = new JSONArray();

			LOG.info("jsonObj......." + jsonObj);
			String imageType = jsonObj.getString("resolution");
			String projectUpdateInStr = jsonObj.getString("updateDate");
			Date projectUpdate = stringToDateConvertor(projectUpdateInStr);
			LOG.info("imageType....." + imageType);

			if (imageType == null) {
				responseCode = ResponseCodes.INVALID_IMAGE_TYPE;
				responseMsg = utilApp.getProperty(
						ResponseCodes.INVALID_IMAGE_TYPE.toString(),
						"INVALID_IMAGE_TYPE");
			} else {
				ImageType imageTypeInfo = projectHandling
						.getImageTypeByResolution(imageType);

				if (imageTypeInfo != null) {
					List<Project> projectInfoList = projectHandling.getProjectDetails(projectUpdate, imageTypeInfo.getId());
					if (projectInfoList != null && projectInfoList.size() > 0) {
						responseCode = ResponseCodes.PROJECT_FOUND;
						responseMsg = utilApp.getProperty(
								ResponseCodes.PROJECT_FOUND.toString(),
								"PROJECT_FOUND");
						for (Project projectInfo : projectInfoList) {
							String logoUrl = "";
							String logoUrlDefault = "";
							JSONObject projectDetail = new JSONObject();
							JSONObject projectDeleteDetail = new JSONObject();
							LOG.info("project id with status" + projectInfo.getId() + projectInfo.getStatus());
							if(projectInfo.getStatus())
							{
							projectDetail.put("projectId", projectInfo.getId().toString());
							projectDetail.put("projectName",projectInfo.getName());
							projectDetail.put("projectShortDescription",projectInfo.getShortDescription());
							
							if(projectInfo.getProjectLogo() == null || projectInfo.getProjectLogo().isEmpty())
							{
								projectDetail.put("projectLogo", null);
							}
							for (ProjectLogo projectLogoInfo : projectInfo
									.getProjectLogo()) {
								if (projectLogoInfo.getImageTypeInfo().getId() == imageTypeInfo.getId()) {
									logoUrl = buildUrl(projectLogoInfo.getId().toString(),Constants.LOGO_FOLDER_NAME);
								}
								/** @author mregendra 24-04-2014 adding default logo if actual logo not present **/
								logoUrlDefault = buildUrl(projectLogoInfo.getId().toString(),Constants.LOGO_FOLDER_NAME);
							} // close for loop projectLogo
							
							/** @author mregendra 24-04-2014 adding default logo if actual logo not present **/
							if(logoUrl != "" && !logoUrl.isEmpty())
							{
								projectDetail.put("projectLogo", logoUrl);
							}else
							{
								projectDetail.put("projectLogo", logoUrlDefault);
							}
							
							projectDetails.add(projectDetail);
							}else
							{
								projectDeleteDetail.put("deletedProject", projectInfo.getId().toString());
								projectDeleteDetails.add(projectDeleteDetail);
							}// close if project = false
						} // close for loop project
					} else {
						responseCode = ResponseCodes.NO_PROJECT_FOUND;
						responseMsg = utilApp.getProperty(ResponseCodes.NO_PROJECT_FOUND.toString(),"NO_PROJECT_FOUND");
					}

				} else {
					responseCode = ResponseCodes.INVALID_IMAGE_TYPE;
					responseMsg = utilApp.getProperty(ResponseCodes.INVALID_IMAGE_TYPE.toString(),"INVALID_IMAGE_TYPE");
				}

			}
			jsonObjResponse.put("responseCode", responseCode);
			jsonObjResponse.put("responseMsg", responseMsg);
			jsonObjResponse.put("project", projectDetails);
			jsonObjResponse.put("deletedProject", projectDeleteDetails);
			byte[] documentBody = jsonObjResponse.toString().getBytes();
			HttpHeaders header = new HttpHeaders();
			header.setContentType(new MediaType("application", "json"));
			header.setContentLength(documentBody.length);
			return new HttpEntity<byte[]>(documentBody, header);

		} catch (Exception e) {
			LOG.info("error occured", e);
		}
		return null;
	}

	
	/**
	 * /clientGetProjectDetail.html
	 * clientGetProjectDetail is used by client to get all all detail like walk through, gallery, etc of particular project.
	 * Takes <code>net.sf.json.JSONObject</code> object within the post request 
	 * To test this method following json object can be used 
	 * <code>
	 *	        JSONObject jsonObject = new JSONObject();
	 *	        jsonObject.put("resolution","resolution");
	 *			jsonObject.put("projectId","projectId");
	 *
	 *	       
	 * </code>
	 * 
	 * @param request
	 * @param response
	 * 
	 * INVALID_IMAGE_TYPE = 103
	 * PROJECT_FOUND = 400
	 * NO_PROJECT_FOUND = 104
	 * 
	 * 
	 * @return HttpEntity<byte[]>
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/clientGetProjectDetail.html")
	public HttpEntity<byte[]> getProjectDetail(HttpServletRequest request,
			HttpServletResponse response) {
		LOG.info("clientGetProjectDetail.......");

		String responseMsg = "";
		Long responseCode = 0L;
		
		JSONObject jsonObj = JSONUtils.getJSONObject(request);
		InetAddress ip;
		try {
			ip = InetAddress.getLocalHost();
			LOG.info("Current IP address : " + ip.getHostAddress());
		} catch (UnknownHostException e) {
			e.printStackTrace();
			LOG.error("error in clientGetProject()", e);
		}

		try {
			// JSONObject jsonObj = new JSONObject(jsonStr);
			JSONObject jsonObjResponse = new JSONObject();
			// JSONArray projectDetails = new JSONArray();
			JSONObject projectDetail = new JSONObject();

			JSONArray walkThroughtDetails = new JSONArray();
			

			JSONArray galleryDetails = new JSONArray();
			

			JSONArray locationMapDetails = new JSONArray();
			

			LOG.info("jsonObj......." + jsonObj);
			String imageType = jsonObj.getString("resolution");
			String projectId = jsonObj.getString("projectId");

			LOG.info("imageType....." + imageType + "...project id..."
					+ projectId);

			if (imageType == null) {
				responseCode = ResponseCodes.INVALID_IMAGE_TYPE;
				responseMsg = utilApp.getProperty(
						ResponseCodes.INVALID_IMAGE_TYPE.toString(),
						"INVALID_IMAGE_TYPE");
			} else {
				ImageType imageTypeInfo = projectHandling
						.getImageTypeByResolution(imageType);

				if (imageTypeInfo != null) {
					Project projectInfo = projectHandling
							.getProjectDetailById(projectId);
					if (projectInfo != null) {
						responseCode = ResponseCodes.PROJECT_FOUND;
						responseMsg = utilApp.getProperty(
								ResponseCodes.PROJECT_FOUND.toString(),
								"PROJECT_FOUND");

						projectDetail.put("projectId", projectInfo.getId()
								.toString());
						// projectDetail.put("projectName",
						// projectInfo.getName());
						// projectDetail.put("projectShortDescription",
						// projectInfo.getShortDescription());
						projectDetail.put("projectLongDescription",
								projectInfo.getLongDescription());

						// For loop start for Feature
						for (Feature featureInfo : projectInfo.getFeature()) {
							projectDetail.put("feature", featureInfo.getFeatureDetail());

						}// close for loop

						// For loop start for WalkThrough
						for (WalkThrough walkThroughInfo : projectInfo.getWalkThrough()) {
							
							if(walkThroughInfo.getStatus())
							{JSONObject walkThroughtDetail = new JSONObject();
							walkThroughtDetail.put("walkThroughLink", walkThroughInfo.getUrlLink());
							walkThroughtDetails.add(walkThroughtDetail);
						}
						}// close foor loop
						projectDetail.put("walkThrough", walkThroughtDetails);

						// For loop start for WalkThrough
						for (LocationMap locationMapInfo : projectInfo.getLocationMap()) {
							if (locationMapInfo.getImageTypeInfo().getId() == imageTypeInfo.getId() && locationMapInfo.getStatus()) {
								JSONObject locationMapDetail = new JSONObject();
								String locationMapUrl = buildUrl(locationMapInfo.getId().toString(),Constants.LOCATION_MAP_FOLDER_NAME);

								locationMapDetail.put("locationMapLink", locationMapUrl);
								locationMapDetails.add(locationMapDetail);
							}
						}// close foor loop
						projectDetail.put("locationMap", locationMapDetails);

						// For loop start for WalkThrough
						
						for (Gallery galleryInfo : projectInfo.getGallery()) {
							
							if (galleryInfo.getImageTypeInfo().getId() == imageTypeInfo.getId() && galleryInfo.getStatus())
							 {JSONObject galleryDetail = new JSONObject();
								String galleryUrl = buildUrl(galleryInfo.getId().toString(),Constants.GALLERY_FOLDER_NAME);

								galleryDetail.put("galleryLink", galleryUrl);
								galleryDetails.add(galleryDetail);
							}
						}// close foor loop

						projectDetail.put("gallery", galleryDetails);

					} // close if project = null
					else {
						responseCode = ResponseCodes.NO_PROJECT_FOUND;
						responseMsg = utilApp.getProperty(
								ResponseCodes.NO_PROJECT_FOUND.toString(),
								"NO_PROJECT_FOUND");
					}

				} else {
					responseCode = ResponseCodes.INVALID_IMAGE_TYPE;
					responseMsg = utilApp.getProperty(
							ResponseCodes.INVALID_IMAGE_TYPE.toString(),
							"INVALID_IMAGE_TYPE");
				} // close if imageType= null

			}
			jsonObjResponse.put("responseCode", responseCode);
			jsonObjResponse.put("responseMsg", responseMsg);
			jsonObjResponse.put("project", projectDetail);
			byte[] documentBody = jsonObjResponse.toString().getBytes();
			HttpHeaders header = new HttpHeaders();
			header.setContentType(new MediaType("application", "json"));
			header.setContentLength(documentBody.length);
			return new HttpEntity<byte[]>(documentBody, header);

		} catch (Exception e) {
			LOG.info("error occured", e);
		}
		return null;
	}

	public String buildUrl(String imageID, String downImageType) {
		String returnUrl = "";
		try {
			LOG.info("SSB::::" +utilApp.getProperty(Constants.DOWNLOAD_URL_PATH) +":::"+ imageID +":::"+ downImageType);
			returnUrl = utilApp.getProperty(Constants.DOWNLOAD_URL_PATH).replaceAll("@@imageID@@", imageID)
					.replaceAll("@@imageType@@", downImageType);
		} catch (Exception e) {
			LOG.error("error in buildUrl", e);
		}
		LOG.info("returning url: " + returnUrl +":SSB:");
		return returnUrl;
	}
	
	/**
	 * /clientGetFeeds.html
	 * /clientGetFeeds.html is used by client to get feed.
	 * Takes <code>net.sf.json.JSONObject</code> object within the post request 
	 * To test this method following json object can be used 
	 * <code>
	 *	        JSONObject jsonObject = new JSONObject();
	 *	        jsonObject.put("resolution","resolution");
	 *			
	 *
	 *	       
	 * </code>
	 * 
	 * @param request
	 * @param response
	 * 
	 * INVALID_IMAGE_TYPE = 103
	 * NO_FEED_FOUND = 104
	 * FEED_FOUND = 400
	 * 
	 * 
	 * @return HttpEntity<byte[]>
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping("/clientGetFeeds.html")
	public HttpEntity<byte[]> getFeed(HttpServletRequest request,
			HttpServletResponse response) {
		LOG.info("clientGetProject.......");

		String responseMsg = "";
		Long responseCode = 0L;

		JSONObject jsonObj = JSONUtils.getJSONObject(request);
		InetAddress ip;
		try {
			ip = InetAddress.getLocalHost();
			LOG.info("Current IP address : " + ip.getHostAddress());
		} catch (UnknownHostException e) {
			e.printStackTrace();
			LOG.error("error in clientGetProject()", e);
		}

		try {

			JSONObject jsonObjResponse = new JSONObject();
			JSONArray feedDetails = new JSONArray();
			
			LOG.info("jsonObj......." + jsonObj);
			String imageType = jsonObj.getString("resolution");
			
			LOG.info("imageType....." + imageType);

			if (imageType == null) {
				responseCode = ResponseCodes.INVALID_IMAGE_TYPE;
				responseMsg = utilApp.getProperty(ResponseCodes.INVALID_IMAGE_TYPE.toString(),"INVALID_IMAGE_TYPE");
			} else {
				ImageType imageTypeInfo = projectHandling.getImageTypeByResolution(imageType);

				if (imageTypeInfo != null) {
					List<Feed> feedInfoList = feedHandling.getFeedDetails();
					if (feedInfoList != null && feedInfoList.size() > 0) {
						responseCode = ResponseCodes.FEED_FOUND;
						responseMsg = utilApp.getProperty(ResponseCodes.FEED_FOUND.toString(),"FEED_FOUND");
						for (Feed feedInfo : feedInfoList) {
                            
							JSONObject feedDetail = new JSONObject();
							LOG.info("feed id with status" + feedInfo.getId() + feedInfo.getStatus());
							
							feedDetail.put("feedId", feedInfo.getId().toString());
							feedDetail.put("feedTitle",feedInfo.getTitle());
							feedDetail.put("feedDescription",feedInfo.getDescription());
							if(feedInfo.getFeedLogo() == null || feedInfo.getFeedLogo().isEmpty())
							{
								feedDetail.put("feedLogo", null);
							}
							for (FeedLogo feedLogoInfo : feedInfo.getFeedLogo()) {
								if (feedLogoInfo.getImageTypeInfo().getId() == imageTypeInfo.getId()) {
									String logoUrl = buildUrl(feedLogoInfo.getId().toString(), Constants.FEED_LOGO_FOLDER_NAME);
									feedDetail.put("feedLogo", logoUrl);
								}
							} // close for loop feedLogo
							feedDetails.add(feedDetail);
							
						} // close for loop feed
					} else {
						responseCode = ResponseCodes.NO_PROJECT_FOUND;
						responseMsg = utilApp.getProperty(ResponseCodes.NO_PROJECT_FOUND.toString(),"NO_PROJECT_FOUND");
					}

				} else {
					responseCode = ResponseCodes.INVALID_IMAGE_TYPE;
					responseMsg = utilApp.getProperty(
							ResponseCodes.INVALID_IMAGE_TYPE.toString(),
							"INVALID_IMAGE_TYPE");
				}

			}
			jsonObjResponse.put("responseCode", responseCode);
			jsonObjResponse.put("responseMsg", responseMsg);
			jsonObjResponse.put("feed", feedDetails);
			
			byte[] documentBody = jsonObjResponse.toString().getBytes();
			HttpHeaders header = new HttpHeaders();
			header.setContentType(new MediaType("application", "json"));
			header.setContentLength(documentBody.length);
			return new HttpEntity<byte[]>(documentBody, header);

		} catch (Exception e) {
			LOG.info("error occured", e);
		}
		return null;
	}

	
	
	
	public Date stringToDateConvertor(String dateInStr) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

		try {
					
			LOG.info(dateInStr);
			Date date  = (Date)formatter.parse(dateInStr.trim()); 
			LOG.info(date.toString());
			LOG.info(formatter.format(date));
			return date;

			/*String[] datePart = dateInStr.split("-");
			Calendar calendar = Calendar.getInstance();
			Date date =  new Date();
			calendar.set(Integer.parseInt(datePart[0]), Integer.parseInt(datePart[1]), Integer.parseInt(datePart[2]));*/
			
			
		} catch (Exception e) {
			LOG.error("error in stringToDateConvertor", e);
		}
		return null;
	}
}
