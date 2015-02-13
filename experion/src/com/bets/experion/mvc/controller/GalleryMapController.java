package com.bets.experion.mvc.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bets.experion.entity.Gallery;
import com.bets.experion.entity.ImageType;
import com.bets.experion.entity.LocationMap;
import com.bets.experion.entity.Project;
import com.bets.experion.entity.User;
import com.bets.experion.mvc.form.GalleryUpdateUploadFormDTO;
import com.bets.experion.mvc.form.GalleryUploadFormDTO;
import com.bets.experion.mvc.form.LocationMapUploadFormDTO;
import com.bets.experion.service.GalleryHandling;
import com.bets.experion.service.LocationMapHandling;
import com.bets.experion.service.ProjectHandling;
import com.bets.experion.service.UserHandling;
import com.bets.experion.utils.Constants;
import com.bets.experionws.response.BaseResponse;
import com.bets.experionws.response.ResponseCodes;

@Controller
public class GalleryMapController extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static final Logger LOG = Logger.getLogger(GalleryMapController.class);
	private UserHandling userHandling;
	private ProjectHandling projectHandling;
	private GalleryHandling galleryHandling;
	private LocationMapHandling locationMapHandling;
	
	
	@Autowired
	public GalleryMapController(UserHandling userHandling, ProjectHandling projectHandling, 
			GalleryHandling galleryHandling, LocationMapHandling locationMapHandling) {
		
		this.userHandling = userHandling;
		this.projectHandling = projectHandling;
		this.galleryHandling= galleryHandling;
		this.locationMapHandling = locationMapHandling;
		
		
	}
	
	
	
	@RequestMapping("/addGallery.html")
	public String addGallery(@ModelAttribute("gallery") GalleryUploadFormDTO galleryUploadForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			
            String userId = session.getAttribute("user").toString();
			
			String password = session.getAttribute("password").toString();
			
			BaseResponse finalResult = userHandling.validateUser(userId,password);
			finalResult.setResponseType("FileUploadResponse");
			if(!ResponseCodes.VALID_USER.equals(finalResult.getResponseCode())){
				LOG.info("userid & password does not match matche, setting errorMessage and redirecting to login.html");
				session.invalidate();
				return "userLogin";
			}
			else{
			
				User existingUser = finalResult.getUser();
			//	model.addAttribute("userDetail", existingUser);
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				String projectId = request.getParameter("projectId");
				//session.setAttribute("imageTypeList", projectHandling.getImageType());
				boolean isEdit = false;
			    
			    Project projectInfo = projectHandling.getProjectDetailById(projectId);
			   
			    
			if(projectInfo == null)
			{
				return "project";
			}else
			{  
				
				
				String imageTypeFolder = Constants.GALLERY_FOLDER_NAME;
				galleryHandling.storeImage(galleryUploadForm, imageTypeFolder, projectInfo, isEdit, "");
				model.addAttribute("projectList", projectHandling.getProjectDetail() );
			
//			List<Walkthrough> walkthroughList = projectHandling.getWalkthrough(projectInfo.getId());
		//	model.addAttribute("feature", projectHandling.getFeature(projectInfo.getId()));
		//	model.addAttribute("projectDetail", projectInfo);
			return gallery(galleryUploadForm, model, request, session);
			}	
			}	
		}catch(Exception e){
			LOG.error("error in file upload", e);
		}
		return "error";
	}
	@RequestMapping("/updateGallery.html")
	public String updateGallery(@ModelAttribute("gallery") GalleryUploadFormDTO galleryUploadForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			
            String userId = session.getAttribute("user").toString();
			
			String password = session.getAttribute("password").toString();
			
			BaseResponse finalResult = userHandling.validateUser(userId,password);
			finalResult.setResponseType("FileUploadResponse");
			if(!ResponseCodes.VALID_USER.equals(finalResult.getResponseCode())){
				LOG.info("userid & password does not match matche, setting errorMessage and redirecting to login.html");
				session.invalidate();
				return "userLogin";
			}
			else{
			
				User existingUser = finalResult.getUser();
			//	model.addAttribute("userDetail", existingUser);
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				String projectId = request.getParameter("projectId");
				String commonName = request.getParameter("galleryCommon");
				//session.setAttribute("imageTypeList", projectHandling.getImageType());
				boolean isEdit = true;
			    
			    Project projectInfo = projectHandling.getProjectDetailById(projectId);
			   
			    
			if(projectInfo == null)
			{
				return "project";
			}else
			{  
				
				
				String imageTypeFolder = Constants.GALLERY_FOLDER_NAME;
				galleryHandling.storeImage(galleryUploadForm, imageTypeFolder, projectInfo, isEdit, commonName);
				model.addAttribute("projectList", projectHandling.getProjectDetail() );
			
//			List<Walkthrough> walkthroughList = projectHandling.getWalkthrough(projectInfo.getId());
		//	model.addAttribute("feature", projectHandling.getFeature(projectInfo.getId()));
		//	model.addAttribute("projectDetail", projectInfo);
			return gallery(galleryUploadForm, model, request, session);
			}	
			}	
		}catch(Exception e){
			LOG.error("error in file upload", e);
		}
		return "error";
	}
	
	@RequestMapping("/deleteGallery.html")
	public String deleteGallery(@ModelAttribute("gallery") GalleryUploadFormDTO galleryUploadForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			
            String userId = session.getAttribute("user").toString();
			
			String password = session.getAttribute("password").toString();
			
			BaseResponse finalResult = userHandling.validateUser(userId,password);
			finalResult.setResponseType("FileUploadResponse");
			if(!ResponseCodes.VALID_USER.equals(finalResult.getResponseCode())){
				LOG.info("userid & password does not match matche, setting errorMessage and redirecting to login.html");
				session.invalidate();
				return "userLogin";
			}
			else{
			
				User existingUser = finalResult.getUser();
			//	model.addAttribute("userDetail", existingUser);
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				String commonName = request.getParameter("galleryCommon");
				galleryHandling.deleteGallery(commonName);
				model.addAttribute("projectList", projectHandling.getProjectDetail() );
			return gallery(galleryUploadForm, model, request, session);
			
			}	
		}catch(Exception e){
			LOG.error("error in file upload", e);
		}
		return "error";
	}
	@RequestMapping("/deleteSinglegallery.html")
	public String deleteSinglegallery(@ModelAttribute("gallery") GalleryUploadFormDTO galleryUploadForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			
            String userId = session.getAttribute("user").toString();
			
			String password = session.getAttribute("password").toString();
			
			BaseResponse finalResult = userHandling.validateUser(userId,password);
			finalResult.setResponseType("FileUploadResponse");
			if(!ResponseCodes.VALID_USER.equals(finalResult.getResponseCode())){
				LOG.info("userid & password does not match matche, setting errorMessage and redirecting to login.html");
				session.invalidate();
				return "userLogin";
			}
			else{
			
				User existingUser = finalResult.getUser();
			//	model.addAttribute("userDetail", existingUser);
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				String galleryId = request.getParameter("galleryId");
				//session.setAttribute("imageTypeList", projectHandling.getImageType());
				galleryHandling.deleteSingleGallery(galleryId)	;		    
				model.addAttribute("projectList", projectHandling.getProjectDetail() );
			
			return gallery(galleryUploadForm, model, request, session);
			
			}	
		}catch(Exception e){
			LOG.error("error in file upload", e);
		}
		return "error";
	}
	@RequestMapping("/gallery.html")
	public String gallery(@ModelAttribute("gallery") GalleryUploadFormDTO galleryUploadForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		LOG.info("in gallery");
		try {
			LOG.info("project name ...." + galleryUploadForm.getProjectName());
			LOG.info("project Description ...." + galleryUploadForm.getProjectId());
			
            String userId = session.getAttribute("user").toString();
			
			String password = session.getAttribute("password").toString();
			
			BaseResponse finalResult = userHandling.validateUser(userId,password);
			finalResult.setResponseType("FileUploadResponse");
			if(!ResponseCodes.VALID_USER.equals(finalResult.getResponseCode())){
				LOG.info("userid & password does not match matche, setting errorMessage and redirecting to login.html");
				session.invalidate();
				return "userLogin";
			}
			else{
				
				User existingUser = finalResult.getUser();
			//	model.addAttribute("userDetail", existingUser);
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				String projectId = request.getParameter("projectId");
				Project projectInfo = projectHandling.getProjectDetailById(projectId);
			  
			if(projectInfo == null)
			{
				return "project";
			}else
			{   List<ImageType> imageTypeList = projectHandling.getImageType();
				session.setAttribute("imageTypeList", imageTypeList);
				List<Gallery> galleryInfoList = galleryHandling.getGalleryByProjectId(projectInfo.getId());
				
				Map<String,  Map<String, Gallery>> galleryMap = new HashMap<String,  Map<String, Gallery>>();
				
				for(Gallery galleryInfo : galleryInfoList)
				{
				
					Map<String, Gallery> galleryTypeMap = galleryMap.get(galleryInfo.getCommonName());
					if(galleryTypeMap ==  null)
						   galleryTypeMap = new HashMap<String, Gallery>();	
					
					galleryTypeMap.put(galleryInfo.getImageTypeInfo().getId().toString(), galleryInfo);
					galleryMap.put(galleryInfo.getCommonName(), galleryTypeMap);
				
				}
				List<String> commanNameList= new ArrayList<String>();
				commanNameList.addAll(galleryMap.keySet());
				LOG.info("galleryTypeMap...." +  galleryMap);
				model.addAttribute("galleryDetailMap", galleryMap);
				model.addAttribute("commanNameList", commanNameList);
				model.addAttribute("projectDetail", projectInfo);
				model.addAttribute("dataList", generateGalleryList(imageTypeList, galleryMap) );
			 return "gallery"; 
			}	
			}	
		}catch(Exception e){
			LOG.error("error in gallery", e);
		}
		return "error";
	}
	
	@ModelAttribute("gallery")
	public GalleryUploadFormDTO gallryModel() {
		GalleryUploadFormDTO galleryUploadFormDTO = new GalleryUploadFormDTO();
	     /* init regForm */
	     return galleryUploadFormDTO;
	}	

	@ModelAttribute("galleryUpdate")
	public GalleryUpdateUploadFormDTO gallryUpdateModel() {
		GalleryUpdateUploadFormDTO galleryUpdateUploadFormDTO = new GalleryUpdateUploadFormDTO();
	     /* init regForm */
	     return galleryUpdateUploadFormDTO;
	}
	
	public List<List<Gallery>> generateGalleryList(List<ImageType> imageTypeList, Map<String, Map<String, Gallery>> galleryMap){

		List<List<Gallery>> result = new ArrayList<List<Gallery>>();
		
		try{
		
			for(String commonNames : galleryMap.keySet()){
				
				List<Gallery> galleryList = new ArrayList<Gallery>();
				
				Map<String, Gallery> typeGallery = galleryMap.get(commonNames);
			 
				for(ImageType  imageType:imageTypeList) {
					Gallery gallery = typeGallery.get(imageType.getId().toString());
					if(gallery != null){
						galleryList.add(gallery);
						
					}
					else{
						galleryList.add(null);
					}
				}
				result.add(galleryList);
			}
		}catch(Exception e){
			LOG.error("error in generateList", e);
			result = null;
		}
		return result;
	}
	
	
	@RequestMapping("/addLocationMap.html")
	public String addLocationMap(@ModelAttribute("locationMap") LocationMapUploadFormDTO locationMapUploadForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			
            String userId = session.getAttribute("user").toString();
			
			String password = session.getAttribute("password").toString();
			
			BaseResponse finalResult = userHandling.validateUser(userId,password);
			finalResult.setResponseType("FileUploadResponse");
			if(!ResponseCodes.VALID_USER.equals(finalResult.getResponseCode())){
				LOG.info("userid & password does not match matche, setting errorMessage and redirecting to login.html");
				session.invalidate();
				return "userLogin";
			}
			else{
			
				User existingUser = finalResult.getUser();
			//	model.addAttribute("userDetail", existingUser);
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				String projectId = request.getParameter("projectId");
				//session.setAttribute("imageTypeList", projectHandling.getImageType());
				boolean isEdit = false;
			    
			    Project projectInfo = projectHandling.getProjectDetailById(projectId);
			   
			    
			if(projectInfo == null)
			{
				return "project";
			}else
			{  
				
				
			String imageTypeFolder = Constants.LOCATION_MAP_FOLDER_NAME;
			locationMapHandling.storeImage(locationMapUploadForm, imageTypeFolder, projectInfo, isEdit,"");
			model.addAttribute("projectList", projectHandling.getProjectDetail() );
			
			return locationMap(locationMapUploadForm, model, request, session);
			}	
			}	
		}catch(Exception e){
			LOG.error("error in file upload", e);
		}
		return "error";
	}
	
	
	
	
	@RequestMapping("/updateLocationMap.html")
	public String updateLocationMap(@ModelAttribute("locationMap") LocationMapUploadFormDTO locationMapUploadForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			
            String userId = session.getAttribute("user").toString();
			
			String password = session.getAttribute("password").toString();
			
			BaseResponse finalResult = userHandling.validateUser(userId,password);
			finalResult.setResponseType("FileUploadResponse");
			if(!ResponseCodes.VALID_USER.equals(finalResult.getResponseCode())){
				LOG.info("userid & password does not match matche, setting errorMessage and redirecting to login.html");
				session.invalidate();
				return "userLogin";
			}
			else{
			
				User existingUser = finalResult.getUser();
			//	model.addAttribute("userDetail", existingUser);
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				String projectId = request.getParameter("projectId");
				String commonName = request.getParameter("locationMapCommon");
				//session.setAttribute("imageTypeList", projectHandling.getImageType());
				boolean isEdit = true;
			    
			    Project projectInfo = projectHandling.getProjectDetailById(projectId);
			   
			    
			if(projectInfo == null)
			{
				return "project";
			}else
			{  
				
				
				String imageTypeFolder =Constants.GALLERY_FOLDER_NAME;
				locationMapHandling.storeImage(locationMapUploadForm, imageTypeFolder, projectInfo, isEdit, commonName);
				model.addAttribute("projectList", projectHandling.getProjectDetail() );
			
//			List<Walkthrough> walkthroughList = projectHandling.getWalkthrough(projectInfo.getId());
		//	model.addAttribute("feature", projectHandling.getFeature(projectInfo.getId()));
		//	model.addAttribute("projectDetail", projectInfo);
			return locationMap(locationMapUploadForm, model, request, session);
			}	
			}	
		}catch(Exception e){
			LOG.error("error in file upload", e);
		}
		return "error";
	}
	
	@RequestMapping("/deleteLocationMap.html")
	public String deleteLocationMap(@ModelAttribute("locationMap") LocationMapUploadFormDTO locationMapUploadForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			
            String userId = session.getAttribute("user").toString();
			
			String password = session.getAttribute("password").toString();
			
			BaseResponse finalResult = userHandling.validateUser(userId,password);
			finalResult.setResponseType("FileUploadResponse");
			if(!ResponseCodes.VALID_USER.equals(finalResult.getResponseCode())){
				LOG.info("userid & password does not match matche, setting errorMessage and redirecting to login.html");
				session.invalidate();
				return "userLogin";
			}
			else{
			
				User existingUser = finalResult.getUser();
			//	model.addAttribute("userDetail", existingUser);
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				String commonName = request.getParameter("locationMapCommon");
				locationMapHandling.deleteLocationMap(commonName);
				model.addAttribute("projectList", projectHandling.getProjectDetail() );
			return locationMap(locationMapUploadForm, model, request, session);
			
			}	
		}catch(Exception e){
			LOG.error("error in file upload", e);
		}
		return "error";
	}
	@RequestMapping("/deleteSingleLocationMap.html")
	public String deleteSinglelocationMap(@ModelAttribute("locationMap") LocationMapUploadFormDTO locationMapUploadForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			
            String userId = session.getAttribute("user").toString();
			
			String password = session.getAttribute("password").toString();
			
			BaseResponse finalResult = userHandling.validateUser(userId,password);
			finalResult.setResponseType("FileUploadResponse");
			if(!ResponseCodes.VALID_USER.equals(finalResult.getResponseCode())){
				LOG.info("userid & password does not match matche, setting errorMessage and redirecting to login.html");
				session.invalidate();
				return "userLogin";
			}
			else{
			
				User existingUser = finalResult.getUser();
			//	model.addAttribute("userDetail", existingUser);
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				String locationMapId = request.getParameter("locationMapId");
				//session.setAttribute("imageTypeList", projectHandling.getImageType());
				locationMapHandling.deleteSingleLocationMap(locationMapId)	;		    
				model.addAttribute("projectList", projectHandling.getProjectDetail() );
			
			return locationMap(locationMapUploadForm, model, request, session);
			
			}	
		}catch(Exception e){
			LOG.error("error in file upload", e);
		}
		return "error";
	}
	
	@RequestMapping("/locationMap.html")
	public String locationMap(@ModelAttribute("locationMap") LocationMapUploadFormDTO locationMapUploadForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			
            String userId = session.getAttribute("user").toString();
			
			String password = session.getAttribute("password").toString();
			
			BaseResponse finalResult = userHandling.validateUser(userId,password);
			finalResult.setResponseType("FileUploadResponse");
			if(!ResponseCodes.VALID_USER.equals(finalResult.getResponseCode())){
				LOG.info("userid & password does not match matche, setting errorMessage and redirecting to login.html");
				session.invalidate();
				return "userLogin";
			}
			else{
				
				User existingUser = finalResult.getUser();
			//	model.addAttribute("userDetail", existingUser);
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				String projectId = locationMapUploadForm.getProjectId();
				
			    Project projectInfo = projectHandling.getProjectDetailById(projectId);
			   
			    
			if(projectInfo == null)
			{
				return "project";
			}else
			{   
				List<ImageType> imageTypeList = projectHandling.getImageType();
				session.setAttribute("imageTypeList", imageTypeList);
			
			List<LocationMap> locationMapInfoList = locationMapHandling.getLocationMapByProjectId(projectInfo.getId());
			
			Map<String, Map<String, LocationMap>> locationMapMap = new HashMap<String, Map<String, LocationMap>>();
			
			for(LocationMap locationMapInfo : locationMapInfoList)
			{
			
				Map<String, LocationMap> locationMapTypeMap = locationMapMap.get(locationMapInfo.getCommonName());
				if(locationMapTypeMap ==  null)
					locationMapTypeMap = new HashMap<String, LocationMap>();	
				
				locationMapTypeMap.put(locationMapInfo.getImageTypeInfo().getId().toString(), locationMapInfo);
				locationMapMap.put(locationMapInfo.getCommonName(), locationMapTypeMap);
			
			}
			LOG.info("LocationMapTypeMap...." +  locationMapMap);
		//	String retunHtmlCode = generateHtml(projectHandling.getImageType());
			List<String> commanNameList= new ArrayList<String>();
			commanNameList.addAll(locationMapMap.keySet());
			model.addAttribute("locationMapDetailMap", locationMapMap);
			model.addAttribute("commanNameList", commanNameList);
			model.addAttribute("projectDetail", projectInfo);
			model.addAttribute("dataList", generateLocationMapList(imageTypeList, locationMapMap) );
				return "locationMap"; 
			}	
			}	
		}catch(Exception e){
			LOG.error("error in file upload", e);
		}
		return "error";
	}
	
	@ModelAttribute("locationMap")
	public LocationMapUploadFormDTO locationMapModel() {
		LocationMapUploadFormDTO locationMapUploadFormDTO = new LocationMapUploadFormDTO();
	     /* init regForm */
	     return locationMapUploadFormDTO;
	}	
	
	public List<List<LocationMap>> generateLocationMapList(List<ImageType> imageTypeList, Map<String, Map<String, LocationMap>> locationMapMap){

		List<List<LocationMap>> result = new ArrayList<List<LocationMap>>();
		try{
		
			for(String commonNames : locationMapMap.keySet()){
				
				List<LocationMap> locationList = new ArrayList<LocationMap>();
				Map<String, LocationMap> typeLocationMap = locationMapMap.get(commonNames);
			 
				for(ImageType  imageType:imageTypeList) {
					LocationMap locationMap = typeLocationMap.get(imageType.getId().toString());
					if(locationMap != null){
						locationList.add(locationMap);
					}
					else{
						locationList.add(null);
					}
				}
				result.add(locationList);
			}
		}catch(Exception e){
			LOG.error("error in generateList", e);
			result = null;
		}
		return result;
	}
	
	/*
	public String generateHtml(List<ImageType> imageTypeList, Map<String, Map> locationMapMap)
	{
		try
		{
			StringBuffer htmlCode = new StringBuffer();
			
			htmlCode.append("<tr>");
			
			for(ImageType  imageType:imageTypeList)
			{
				htmlCode.append( "<th colspan=\"0\">").append(imageType.getDisplayName()).append("</th> <th>Delete</th>");
			 htmlCode.append("</tr>");			  
		
			}
			Set<String> locationMapKeySet= locationMapMap.keySet();
			for(String locationMapKey : locationMapKeySet)
				{
				  Map<String, LocationMap> locationMapTypeMap = locationMapMap.get(locationMapKey);
				  htmlCode.append("<tr>");	
				  for(ImageType  imageType:imageTypeList)
				  {
					  LocationMap locationMapInfo = locationMapTypeMap.get(imageType.getId().toString());
					  if(locationMapInfo != null)
					  {
						 htmlCode.append("<td>");
						 htmlCode.append("<img src=\"<c:url value='/viewImage.html?imagePath=").append(locationMapInfo.getImagePath())
						 .append("'/>\" border = \"5\" width = \"100\" height= \"100\">")
							<s:form method="post" action="./deleteSinglegallery.html?galleryId=${galleryInfo.id}&projectId=${projectDetail.id}">
						    <input type="submit" value="Delete Image" />
						    </s:form>	  
					  }
				  }

				}
			
			   
			      
			         <td>
			         
					<img src="<c:url value='/viewImage.html?imagePath=${galleryInfo.imagePath}'/>" border = "5" width = "100" height= "100">
					<s:form method="post" action="./deleteSinglegallery.html?galleryId=${galleryInfo.id}&projectId=${projectDetail.id}">
				    <input type="submit" value="Delete Image" />
				    </s:form>	
</td>
					</c:when>
					<c:otherwise>
					<td>
				   <s:form method="post" action="./updateGallery.html?galleryCommon=${commonName}&projectId=${projectDetail.id}" 
				 modelAttribute="gallery" enctype="multipart/form-data">
						<s:input path="files" type="file" />
						<s:input type="hidden" path="iamgeTypeId" value ="${(imageTypeId.id)}" />
				        <s:input type="hidden" path="iamgeTypeResolution" value = "${imageTypeId.resolution}" />
							<input type="submit" value="Add Image" />
			            </s:form>
			            ${imageTypeId.id}
			            </td>
					</c:otherwise>
					</c:choose>
			       
			        </c:forEach> 
			        
			        <td>
			     
			        <s:form method="post" action="./deleteGallery.html?galleryCommon=${commonName}&projectId=${projectDetail.id}">
				    <input type="submit" value="Delete Images" />
				    </s:form>
			        </td>
			        
			     </tr>
			    
			     
			     
			     </c:forEach>
			     
			     
			     
			</table>
			 LOG.info("htmlCode.toString()...." +  htmlCode.toString());
			 return htmlCode.toString();
		}catch(Exception e)
		{
			LOG.error("generateHtml", e);
		}
		return null;
	}
	*/
	
}

