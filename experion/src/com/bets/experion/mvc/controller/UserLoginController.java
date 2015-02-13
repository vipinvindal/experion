package com.bets.experion.mvc.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bets.experion.entity.User;
import com.bets.experion.service.ProjectHandling;
import com.bets.experion.service.UserHandling;
import com.bets.experionws.response.BaseResponse;
import com.bets.experionws.response.ResponseCodes;

@Controller
public class UserLoginController extends HttpServlet{

	private static final long serialVersionUID = 1L;

	private static final Logger LOG = Logger.getLogger(UserLoginController.class);
	private UserHandling userHandling;
	private ProjectHandling projectHandling;
	
	
	@Autowired
	public UserLoginController(UserHandling userHandling, ProjectHandling projectHandling) {
		
		this.userHandling = userHandling;
		this.projectHandling = projectHandling;
		
		
	}
	/**
	 * /userLogin.html
	 * userLogin.html is used get login page.
	 *
	 * 
	 * @param request
	 * @param response
	 * 
	 * login.jsp page open
	 * error.jsp page open
	 */
	
	
	@RequestMapping("/userLogin.html")
	public String login(HttpServletRequest request, HttpSession session, Model model) {
		LOG.info("entering login()");
		try {
			session.invalidate();
			return "userLogin";
		} catch (Exception e) {
			LOG.error("error in login()", e);
		}
		return "error";
	}
	
	/**
	 * /userLoginSuccess.html
	 * /userLoginSuccess.html is used to verify login detail.
	 *  Takes input as a request object.
	 * 
	 * @param request
	 * request.getParameter("userId") 
	 * request.getParameter("password")
	 * 
	 * @param response
	 * 
	 * project.jsp page open
	 * error.jsp page open
	 *
	 */
	

	@RequestMapping("/userLoginSuccess.html")
	public String loginSuccess(HttpServletRequest request, HttpSession session, Model model) {
		LOG.info("entering loginSuccess()");
		try {
			String userId = request.getParameter("userId");
			String password = request.getParameter("password");
			
			BaseResponse finalResult = userHandling.validateUser(userId,password);
			finalResult.setResponseType("FileUploadResponse");
			if(!ResponseCodes.VALID_USER.equals(finalResult.getResponseCode())){
				LOG.info("userid & password does not match matche, setting errorMessage and redirecting to login.html");
				session.setAttribute("errorMessage", "Invalid Login...");
				return "userLogin";
			}
			else{
				User existingUser = finalResult.getUser();
				//Project projectInfo = projectHandling.getProjectDetail();
				model.addAttribute("projectList", projectHandling.getProjectDetail() );
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				return "project";
			}
		
		} catch (Exception e) {
			LOG.error("error in userLoginSuccess()", e);
		}
		LOG.info("error occoured, going to error page.");
		return "error";
	}
	
	/**
	 * /projectBack.html
	 * projectBack.html is used going back to project home page.
	 * Takes input as a session object.
	 * 
	 * @param request
	 * session.getAttribute("user")
	 * session.getAttribute("password")
	 * 
	 * @param response
	 * 
	 * project.jsp page open
	 * error.jsp page open
	 * 
	 */

	@RequestMapping("/projectBack.html")
	public String projectBack(HttpServletRequest request, HttpSession session, Model model) {
		LOG.info("entering projectBack()");
		try {
			 String userId = session.getAttribute("user").toString();
			 String password = session.getAttribute("password").toString();
			
			BaseResponse finalResult = userHandling.validateUser(userId,password);
			finalResult.setResponseType("FileUploadResponse");
			if(!ResponseCodes.VALID_USER.equals(finalResult.getResponseCode())){
				LOG.info("userid & password does not match matche, setting errorMessage and redirecting to login.html");
				session.setAttribute("errorMessage", "Invalid Login...");
				return "userLogin";
			}
			else{
				
				User existingUser = finalResult.getUser();
				//Project projectInfo = projectHandling.getProjectDetail();
				model.addAttribute("projectList", projectHandling.getProjectDetail() );
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				
				
				
				return "project";
			}
		
		} catch (Exception e) {
			LOG.error("error in projectBack()", e);
		}
		LOG.info("error occoured, going to error page.");
		return "error";
	}

	/**
	 * /userLogout.html
	 * userLogout.html is used log out from current session.
	 *
	 * 
	 * @param request
	 * @param response
	 * 
	 * userLogin.jsp page open
	 * error.jsp page open
	 */

@RequestMapping("/userLogout.html")
public String userLogout(HttpServletRequest request, HttpSession session, Model model) {
	LOG.info("entering loginSuccess()");
	try {
		
		session.invalidate();
		model.addAttribute("userDetail", "User logged out successfully");
			return "userLogin";
		
	
	} catch (Exception e) {
		LOG.error("error in userLoginSuccess()", e);
	}
	LOG.info("error occoured, going to error page.");
	return "error";
}

}
