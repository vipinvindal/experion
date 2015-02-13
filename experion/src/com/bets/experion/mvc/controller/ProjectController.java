package com.bets.experion.mvc.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bets.experion.entity.Feature;
import com.bets.experion.entity.Project;
import com.bets.experion.entity.ProjectLogo;
import com.bets.experion.entity.User;
import com.bets.experion.mvc.form.FeatureDTO;
import com.bets.experion.mvc.form.FileUploadDetailDTO;
import com.bets.experion.mvc.form.LogoFormDTO;
import com.bets.experion.mvc.form.ProjectUploadFormDTO;
import com.bets.experion.mvc.form.WalkthroughDTO;
import com.bets.experion.service.ProjectHandling;
import com.bets.experion.service.UserHandling;
import com.bets.experion.utils.Constants;
import com.bets.experionws.response.BaseResponse;
import com.bets.experionws.response.ResponseCodes;

@Controller
public class ProjectController extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static final Logger LOG = Logger.getLogger(ProjectController.class);
	private UserHandling userHandling;
	private ProjectHandling projectHandling;
	
	@Autowired
	public ProjectController(UserHandling userHandling, ProjectHandling projectHandling) {
		
		this.userHandling = userHandling;
		this.projectHandling = projectHandling;
		
		
	}
	
	/**
	 * /projectAdd.html
	 * projectAdd.html is used get window to add new project
	 *
	 * 
	 * @param request
	 * @param response
	 * projectSave.jsp page open
	 * userLogin.jsp page open
	 * error.jsp page open
	 */
	
	@RequestMapping("/projectAdd.html")
	public String projectAdd(HttpServletRequest request, HttpSession session, Model model) {
		LOG.info("entering projectAdd()");
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
				
				session.setAttribute("imageTypeList", projectHandling.getImageType());
				return "projectSave";
			}
		
		} catch (Exception e) {
			LOG.error("error in userLoginSuccess()", e);
		}
		LOG.info("error occoured, going to error page.");
		return "error";
	}
	
	@ModelAttribute("uploadProject")
	public ProjectUploadFormDTO projectModel() {
		ProjectUploadFormDTO projectUploadForm = new ProjectUploadFormDTO();
	     /* init regForm */
	     return projectUploadForm;
	}
	
	@ModelAttribute("logoAdd")
	public LogoFormDTO logoModel() {
		LogoFormDTO logoUploadForm = new LogoFormDTO();
	     /* init regForm */
	     return logoUploadForm;
	}
	
	/**
	 * /projectSave.html
	 * projectSave.html is used save new project. 
	 *
	 * 
	 * @param request
	 * @param response
	 * project.jsp page open
	 * projectSave.jsp page open
	 * userLogin.jsp page open
	 * error.jsp page open
	 */
	
	@RequestMapping("/projectSave.html")
	public String projectSave(@ModelAttribute("uploadProject") ProjectUploadFormDTO projectUploadForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			LOG.info("project name ...." + projectUploadForm.getProjectName());
			LOG.info("project Description ...." + projectUploadForm.getShortDescription());
			LOG.info("file size ...." + projectUploadForm.getFiles().size());
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
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				session.setAttribute("imageTypeList", projectHandling.getImageType());
				
			
			    String projectName     =  projectUploadForm.getProjectName();
			    String shortDescription =  projectUploadForm.getShortDescription();
			    String longDescription = projectUploadForm.getLongDescription();
			    		
			    
			    Project projectInfo = projectHandling.addProject(projectName, shortDescription, longDescription);
			   
			    
				if(projectInfo == null)
				{
					return "projectSave";
				}else
				{ LOG.info("project addeded with id" + projectInfo.getId() );
					
				boolean isEdit = false;
				    String imageTypeFolder = Constants.LOGO_FOLDER_NAME;
					FileUploadDetailDTO fileUploadDetailDTO = projectHandling.storeImage(projectUploadForm, imageTypeFolder, projectInfo, isEdit);
			
						if(fileUploadDetailDTO != null)
						{	
						LOG.info("file uploaded" + fileUploadDetailDTO.getFilePath() + "........" + fileUploadDetailDTO.getFileName());
						model.addAttribute("projectList", projectHandling.getProjectDetail() );
						return "project";
						}
						else
						{
							return "projectSave";
						}
				}
			
			}	
			
		}catch(Exception e){
			LOG.error("error in file upload", e);
		}
		return "error";
	}
	
	/**
	 * /projectEdit.html
	 * projectEdit.html is used to open new window to edit detail of existing  project. 
	 *
	 * 
	 * @param request
	 * @param response
	 * 
	 * projectEdit.jsp page open
	 * userLogin.jsp page open
	 * error.jsp page open
	 */
	
	@RequestMapping("/projectEdit.html")
	public String projectEdit(@ModelAttribute("uploadProject") ProjectUploadFormDTO uploadForm, HttpServletRequest request, HttpSession session, Model model) {
		LOG.info("entering projectAdd()");
		try {
			String userId = session.getAttribute("user").toString();
			String projectId = request.getParameter("projectId");
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
				Project projectInfo = projectHandling.getProjectDetailById(projectId);
				List<ProjectLogo> projectLogoInfo = projectHandling.getProjectLogo(projectInfo);
				uploadForm.setShortDescription(projectInfo.getShortDescription());
				uploadForm.setLongDescription(projectInfo.getLongDescription());
				model.addAttribute("projectDetail", projectInfo);
				model.addAttribute("projectLogo", projectLogoInfo);
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				model.addAttribute("imageTypeListLogo", projectHandling.getImageTypeNotInProject(projectInfo.getId()));
				return "projectEdit";
			}
		
		} catch (Exception e) {
			LOG.error("error in userLoginSuccess()", e);
		}
		LOG.info("error occoured, going to error page.");
		return "error";
	}
	
	/**
	 * /projectDelete.html
	 * projectDelete.html is used to delete existing  project. 
	 *
	 * 
	 * @param request
	 * @param response
	 * 
	 * project.jsp page open
	 * userLogin.jsp page open
	 * error.jsp page open
	 */
	@RequestMapping("/projectDelete.html")
	public String projectDelete(@ModelAttribute("uploadProject") ProjectUploadFormDTO uploadForm, HttpServletRequest request, HttpSession session, Model model) {
		LOG.info("entering projectDelete()");
		try {
			String userId = session.getAttribute("user").toString();
			String projectId = request.getParameter("projectId");
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
				projectHandling.deleteProjectDetailById(projectId);
				
				model.addAttribute("projectList", projectHandling.getProjectDetail() );
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
			//	session.setAttribute("imageTypeList", projectHandling.getImageType());
				return "project";
			}
		
		} catch (Exception e) {
			LOG.error("error in projectDelete()", e);
		}
		LOG.info("error occoured, going to error page.");
		return "error";
	}
	
	/**
	 * /projectUpdate.html
	 * projectUpdate.html is used to save  edited detail of existing  project. 
	 *
	 * 
	 * @param request
	 * @param response
	 * 
	 * projectEdit.jsp page open
	 * userLogin.jsp page open
	 * error.jsp page open
	 */
	@RequestMapping("/projectUpdate.html")
	public String projectUpdate(@ModelAttribute("uploadProject") ProjectUploadFormDTO uploadForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			LOG.info("project name ...." + uploadForm.getProjectName());
			LOG.info("project Description ...." + uploadForm.getShortDescription());
			LOG.info("file size ...." + uploadForm.getFiles().size());
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
				boolean isEdit = true;
				User existingUser = finalResult.getUser();
			//	model.addAttribute("userDetail", existingUser);
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				String projectId = request.getParameter("projectId");
				session.setAttribute("imageTypeList", projectHandling.getImageType());
				
			
			    String projectName     =  uploadForm.getProjectName();
			    		
			    String shortDescription =  uploadForm.getShortDescription();
			    
			    String longDescription = uploadForm.getLongDescription();
			    		
			    
			    Project projectInfo = projectHandling.updateProject(projectId, projectName, shortDescription, longDescription);
			   
			    
			if(projectInfo == null)
			{
				return "projectEdit";
			}else
			{ LOG.info("project addeded with id" + projectInfo.getId() );
				String imageTypeFolder = Constants.LOGO_FOLDER_NAME;
				FileUploadDetailDTO fileUploadDetailDTO = projectHandling.storeImage(uploadForm, imageTypeFolder, projectInfo, isEdit);
			
			// return new ModelAndView("message");
			if(fileUploadDetailDTO != null)
			{	
		
			LOG.info("file uploaded" + fileUploadDetailDTO.getFilePath() + "........" + fileUploadDetailDTO.getFileName());
			model.addAttribute("projectList", projectHandling.getProjectDetail() );
			return "project";
			}
			else
			{
				return "projectEdit";
			}
			}
			
			}	
			
		}catch(Exception e){
			LOG.error("error in projectUpdate", e);
		}
		return "error";
	}
	
	/**
	 * /addLogo.html
	 * addLogo.html is used to add logo for particular project with all available resolutions.  
	 *
	 * 
	 * @param request
	 * @param response
	 * 
	 * projectEdit.jsp page open
	 * projectSave.jsp page open
	 * project.jsp page open
	 * userLogin.jsp page open
	 * error.jsp page open
	 */
	
	@RequestMapping("/addLogo.html")
	public String addLogo(@ModelAttribute("logoAdd") LogoFormDTO logoAddForm, Model model, 
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
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				session.setAttribute("imageTypeList", projectHandling.getImageType());
							    
			    Project projectInfo = projectHandling.getProjectDetailById(request.getParameter("projectId"));
			   
			    
				if(projectInfo == null)
				{
					return "projectSave";
				}else
				{ LOG.info("project addeded with id" + projectInfo.getId() );
					
				boolean isEdit = false;
				    String imageTypeFolder = Constants.LOGO_FOLDER_NAME;
					FileUploadDetailDTO fileUploadDetailDTO = projectHandling.storeImage(logoAddForm, imageTypeFolder, projectInfo, isEdit);
			
						if(fileUploadDetailDTO != null)
						{	
						LOG.info("file uploaded" + fileUploadDetailDTO.getFilePath() + "........" + fileUploadDetailDTO.getFileName());
						model.addAttribute("projectList", projectHandling.getProjectDetail() );
						return "project";
						}
						else
						{
							return "projectEdit";
						}
				}
			
			}	
			
		}catch(Exception e){
			LOG.error("error in file upload", e);
		}
		return "error";
	}
	
	/**
	 * /walkthrough.html
	 * walkthrough.html is used to open new window to show walk through link for particular project..  
	 *
	 * 
	 * @param request
	 * @param response
	 * 
	 * 
	 * walkthrough.jsp page open
	 * project.jsp page open
	 * userLogin.jsp page open
	 * error.jsp page open
	 */
	
	@RequestMapping("/walkthrough.html")
	public String walkthrough(@ModelAttribute("walkthrough") WalkthroughDTO walkthroughForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			LOG.info("project name ...." + walkthroughForm.getProjectName());
			LOG.info("project Description ...." + walkthroughForm.getProjectId());
			
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
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				String projectId = request.getParameter("projectId");

				Project projectInfo = projectHandling.getProjectDetailById(projectId);
			    
				if(projectInfo == null){
					return "project";
				}
				else{  
				    
					model.addAttribute("walkthroughList", projectHandling.getWalkThrough(projectInfo.getId()));
					model.addAttribute("projectDetail", projectInfo);
					model.addAttribute("walkthrough",  walkthroughModel());
					return "walkthrough";
				}	
			}	
		}catch(Exception e){
			LOG.error("error in walkthrough", e);
		}
		return "error";
	}
	@ModelAttribute("walkthrough")
	public WalkthroughDTO walkthroughModel() {
		WalkthroughDTO walkthroughForm = new WalkthroughDTO();
	     return walkthroughForm;
	}
	
	/**
	 * /walkThroughDelete.html
	 * walkThroughDelete.html is used to delete walk through link for particular project..  
	 *
	 * 
	 * @param request
	 * @param response
	 * 
	 * 
	 * 
	 * project.jsp page open
	 * userLogin.jsp page open
	 * error.jsp page open
	 */

	@RequestMapping("/walkThroughDelete.html")
	public String walkthroughDelete(@ModelAttribute("walkthrough") WalkthroughDTO walkthroughForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			LOG.info("project name ...." + walkthroughForm.getProjectName());
			LOG.info("project Description ...." + walkthroughForm.getProjectId());
			
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
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				String projectId = request.getParameter("projectId");
				String walkThroughId = request.getParameter("walkThroughId");
			    Project projectInfo = projectHandling.getProjectDetailById(projectId);
			    
				if(projectInfo == null)
				{
					return "project";
				}
				else
				{  
					projectHandling.deleteWalkThrough(walkThroughId);    
					return walkthrough( walkthroughForm, model, request, session);
				}	
			}	
		}catch(Exception e){
			LOG.error("error in walkthroughDelete", e);
		}
		return "error";
	}
	
	/**
	 * /walkThroughAdd.html
	 * walkThroughAdd.html is used to add new walk through link for particular project..  
	 *
	 * 
	 * @param request
	 * @param response
	 * 
	 * 
	 * walkthrough.jsp page open
	 * project.jsp page open
	 * userLogin.jsp page open
	 * error.jsp page open
	 */

	
	@RequestMapping("/walkThroughAdd.html")
	public String walkthroughAdd(@ModelAttribute("walkthrough") WalkthroughDTO walkthroughForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			LOG.info("project name ...." + walkthroughForm.getProjectName());
			LOG.info("project Description ...." + walkthroughForm.getProjectId());
			
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
				
			    
			    Project projectInfo = projectHandling.getProjectDetailById(projectId);
			   
			    
			if(projectInfo == null)
			{
				return "project";
			}else
			{  
			projectHandling.addWalkThrough(projectInfo, walkthroughForm);
//			List<Walkthrough> walkthroughList = projectHandling.getWalkthrough(projectInfo.getId());
			/*model.addAttribute("walkthroughList", projectHandling.getWalkThrough(projectInfo.getId()));
			model.addAttribute("projectDetail", projectInfo);
			model.addAttribute("walkthrough",  new WalkthroughDTO());*/
		//	walkthrough( walkthroughForm, model, request, session);
		//	return walkthrough( walkthroughForm, model, request, session);
			return "redirect:walkthrough.html?projectId="+projectInfo.getId();
			}	
			}	
		}catch(Exception e){
			LOG.error("error in walkthroughAdd", e);
		}
		return "error";
	}
	
	/**
	 * /feature.html
	 * feature.html is used to open feature of particular project..  
	 *
	 * 
	 * @param request
	 * @param response
	 * 
	 * 
	 * feature.jsp page open
	 * project.jsp page open
	 * userLogin.jsp page open
	 * error.jsp page open
	 */
	
	@RequestMapping("/feature.html")
	public String feature(@ModelAttribute("feature") FeatureDTO featureUploadForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			LOG.info("project name ...." + featureUploadForm.getProjectName());
			LOG.info("project Description ...." + featureUploadForm.getProjectId());
			
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
				
			    
			    Project projectInfo = projectHandling.getProjectDetailById(projectId);
			   
			    
			if(projectInfo == null)
			{
				return "project";
			}else
			{  
			 List<Feature> featureList   = projectHandling.getFeature(projectInfo.getId());
			 
			    if(featureList != null && featureList.size() > 0)
			    {
			    	featureUploadForm.setFeature(featureList.get(0).getFeatureDetail());
			    	featureUploadForm.setFeatureId(featureList.get(0).getId().toString());
			    	featureUploadForm.setProjectName(featureList.get(0).getProjectInfo().getName());
			    	featureUploadForm.setProjectId(featureList.get(0).getProjectInfo().getId().toString());
			    }
			    else
			    {
			    	featureUploadForm.setProjectName(projectInfo.getName());
			    	featureUploadForm.setProjectId(projectInfo.getId().toString());
			    }
			 
//			List<Walkthrough> walkthroughList = projectHandling.getWalkthrough(projectInfo.getId());
		//	model.addAttribute("feature", projectHandling.getFeature(projectInfo.getId()));
		//	model.addAttribute("projectDetail", projectInfo);
			return "feature";
			}	
			}	
		}catch(Exception e){
			LOG.error("error in feature", e);
		}
		return "error";
	}
	/**
	 * /featureUpdate.html
	 * featureUpdate.html is used to edit existing feature of particular project..  
	 *
	 * 
	 * @param request
	 * @param response
	 * 
	 * 
	 * feature.jsp page open
	 * project.jsp page open
	 * userLogin.jsp page open
	 * error.jsp page open
	 */
	@RequestMapping("/featureUpdate.html")
	public String featureUpdate(@ModelAttribute("feature") FeatureDTO featureUploadForm, Model model, 
			HttpServletRequest request,  HttpSession session) throws IOException {
		try {
			LOG.info("project name ...." + featureUploadForm.getProjectName());
			LOG.info("project Description ...." + featureUploadForm.getProjectId());
			
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
				boolean isNewFeature = false;
				User existingUser = finalResult.getUser();
			//	model.addAttribute("userDetail", existingUser);
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				String projectId = featureUploadForm.getProjectId();
				String featureId = featureUploadForm.getFeatureId();
				LOG.info("project featureId ...." + featureId);
				
			    Project projectInfo = projectHandling.getProjectDetailById(projectId);
			   if(featureUploadForm.getFeatureId() == null || featureUploadForm.getFeatureId() == "" || featureUploadForm.getFeatureId().isEmpty())
			   {
				   LOG.info("project featureId not present seetin isNewFeature true....");
				   isNewFeature = true;
			   }
			    
			    
			if(projectInfo == null)
			{
				return "project";
			}else
			{  
				 Feature featureInfo = projectHandling.updateFeature(projectInfo, featureUploadForm, isNewFeature);
			//	List<Feature> featureList   = projectHandling.getFeature(projectInfo.getId());
			    if(featureInfo != null)
			    {
			    	featureUploadForm.setFeature(featureInfo.getFeatureDetail());
			    	featureUploadForm.setFeatureId(featureInfo.getId().toString());
			    	featureUploadForm.setProjectName(featureInfo.getProjectInfo().getName());
			    	featureUploadForm.setProjectId(featureInfo.getProjectInfo().getId().toString());
			    }
			    else
			    {
			    	featureUploadForm.setProjectName(projectInfo.getName());
			    	featureUploadForm.setProjectId(projectInfo.getId().toString());
			    }
			 return "feature"; 
			}	
			}	
		}catch(Exception e){
			LOG.error("error in featureUpdate", e);
		}
		return "error";
	}
	
	@ModelAttribute("feature")
	public FeatureDTO featureModel() {
		FeatureDTO featureUploadForm = new FeatureDTO();
	     /* init regForm */
	     return featureUploadForm;
	}	
}

