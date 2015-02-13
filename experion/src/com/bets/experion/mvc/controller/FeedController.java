package com.bets.experion.mvc.controller;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bets.experion.entity.Feed;
import com.bets.experion.entity.User;
import com.bets.experion.mvc.form.FeedFormDTO;
import com.bets.experion.mvc.form.FileUploadDetailDTO;
import com.bets.experion.service.FeedHandling;
import com.bets.experion.service.ProjectHandling;
import com.bets.experion.service.UserHandling;
import com.bets.experion.utils.Constants;
import com.bets.experionws.response.BaseResponse;
import com.bets.experionws.response.ResponseCodes;

@Controller
public class FeedController extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static final Logger LOG = Logger.getLogger(FeedController.class);
	private UserHandling userHandling;
	private FeedHandling feedHandling;
	private ProjectHandling projectHandling;
	
	
	
	@Autowired
	public FeedController(UserHandling userHandling, FeedHandling feedHandling, ProjectHandling projectHandling) {
		
		this.userHandling = userHandling;
		this.feedHandling = feedHandling;
		this.projectHandling = projectHandling;
		
		
	}
	
	@RequestMapping("/feedAdd.html")
	public String feedAdd(@ModelAttribute("uploadFeed") FeedFormDTO feedForm, HttpServletRequest request, HttpSession session, Model model) {
		LOG.info("entering feedAdd()");
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
				
				 Feed feedInfo = feedHandling.addFeed(feedForm.getFeedTitle(), feedForm.getDescription());
				  	    
					if(feedInfo == null)
					{
						return feed(feedForm, model, request, session);
					}else
					{ 
						LOG.info("feed addeded with id" + feedInfo.getId() );
						
						boolean isEdit = false;
					    String imageTypeFolder = Constants.FEED_LOGO_FOLDER_NAME;
						FileUploadDetailDTO fileUploadDetailDTO = feedHandling.storeImage(feedForm, imageTypeFolder, feedInfo, isEdit);
						
						LOG.info("file uploaded" + fileUploadDetailDTO.getFilePath() + "........" + fileUploadDetailDTO.getFileName());
						model.addAttribute("feedList", feedHandling.getFeedDetail() );
						model.addAttribute("uploadFeed", new FeedFormDTO());
						return feed(feedForm, model, request, session);
					}
			}
		
		} catch (Exception e) {
			LOG.error("error in userLoginSuccess()", e);
		}
		LOG.info("error occoured, going to error page.");
		return "error";
	}
	
	@ModelAttribute("uploadFeed")
	public FeedFormDTO feedModel() {
		FeedFormDTO feedForm = new FeedFormDTO();
	     /* init regForm */
	     return feedForm;
	}
	

	@RequestMapping("/feed.html")
	public String feed(@ModelAttribute("uploadFeed") FeedFormDTO feedForm, Model model, 
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
				//Project projectInfo = projectHandling.getProjectDetail();
				model.addAttribute("feedList", feedHandling.getFeedDetail() );
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("imageTypeList", projectHandling.getImageType());
				session.setAttribute("password", existingUser.getPassword());
				
				return "feed";
			
			}	
			
		}catch(Exception e){
			LOG.error("error in file upload", e);
		}
		return "error";
	}
	
	

	@RequestMapping("/feedDelete.html")
	public String feedDelete(@ModelAttribute("uploadFeed") FeedFormDTO feedForm, HttpServletRequest request, HttpSession session, Model model) {
		LOG.info("entering feedDelete()");
		try {
			String userId = session.getAttribute("user").toString();
			String feedId = request.getParameter("feedId");
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
				feedHandling.deleteFeedDetailById(feedId);
				
				model.addAttribute("feedList", feedHandling.getFeedDetail() );
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				return "feed";
			}
		
		} catch (Exception e) {
			LOG.error("error in feedDelete()", e);
		}
		LOG.info("error occoured, going to error page.");
		return "error";
	}
}

