package com.bets.experion.mvc.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bets.experion.dao.AppConfigDao;
import com.bets.experion.entity.AppConfig;
import com.bets.experion.entity.User;
import com.bets.experion.service.UserHandling;
import com.bets.experion.utils.UtilAppConf;
import com.bets.experionws.response.BaseResponse;
import com.bets.experionws.response.ResponseCodes;
@Controller
public class LoginController  {
	
	private AppConfigDao appConfDAO;
	private UtilAppConf appConf ;
	private UserHandling userHandling;
	
	@Autowired
	public void setLoginBD(AppConfigDao appConfDAO, UtilAppConf appConf, UserHandling userHandling) {
	
		this.userHandling = userHandling;
		this.appConfDAO = appConfDAO;
		this.appConf = appConf;
	}	
	public static final Logger logger = Logger.getLogger(LoginController.class.getName());	

	/**
	 * method to open mSecure Home page with all command options
	 * @param request
	 * @param response
	 * @return mSecureHome page with ModelAndView Attributes of list of devices
	 * @throws Exception
	 */
	

	@RequestMapping("/saveAppConfig.html")
	public String saveConfigObject(HttpServletRequest request, HttpSession session, Model model) {
		logger.info("entering saveConfigObject()");
		try {
			if(session.getAttribute("loginSuccess")!=null  && ((Boolean)session.getAttribute("loginSuccess")).booleanValue()){
				String idStr = request.getParameter("id");
				String customValue = request.getParameter("customValue");

				logger.info("login details: id: " + idStr +":: customValue: " + customValue);

				Long id = null;
				try{
					id = Long.valueOf(idStr);
				}
				catch(NumberFormatException e){
					logger.error("error parsing id in saveConfigObject()", e);
					session.setAttribute("errorMessage", "error in parsing number, please mail to npd@beyondevolution.in");
				}

				if(id != null){
					AppConfig appConf = appConfDAO.getAppConfigById(id);
					appConf.setCustomValue(customValue);
					boolean saved = appConfDAO.saveOrUpdate(appConf);
					if(saved){
						session.setAttribute("successMessage", "Config Saved successfully.");
					}
					else{
						session.setAttribute("errorMessage", "Error saving Config, please mail to npd@beyondevolution.in");
					}
				}	

				List<AppConfig> listAppConfig = appConfDAO.getAllAppConfig();
				session.setAttribute("listAppConfig", listAppConfig);
				appConf.reload();
				logger.info("returning config");

				return "config";
			}
			else{
				session.setAttribute("errorMessage", "session expired");
				session.invalidate();
				return "login";
			}

		} catch (Exception e) {
			session.setAttribute("errorMessage", "Error saving Config, please mail to npd@beyondevolution.in");
			logger.error("error in saveConfigObject()", e);
		}
		logger.info("error occoured, going to error page.");
		return "config";
	}

	/**
	 * method to test adminLogin credential test if credential are match it will open adminHome page with appConfig data
	 * @param request
	 * @param session
	 * @param model
	 * @return adminHome page with list of appConfig fields
	 */
	@RequestMapping("/configList.html")
	public String configList(HttpServletRequest request, HttpSession session, Model model) {
		logger.info("entering loginSuccess()");
			
		try {
			String userId = session.getAttribute("user").toString();
			String password = session.getAttribute("password").toString();
				
			BaseResponse finalResult = userHandling.validateUser(userId,password);
			finalResult.setResponseType("FileUploadResponse");
			if(!ResponseCodes.VALID_USER.equals(finalResult.getResponseCode())){
				logger.info("userid & password does not match matche, setting errorMessage and redirecting to login.html");
				session.setAttribute("errorMessage", "Invalid Login...");
				return "userLogin";
			}
			else{
				
				User existingUser = finalResult.getUser();
				//Project projectInfo = projectHandling.getProjectDetail();
				session.setAttribute("user", existingUser.getUserId());
				session.setAttribute("password", existingUser.getPassword());
				
				logger.info("userid & password matches, going to set appConfig list in session");				
				List<AppConfig> listAppConfig = appConfDAO.getAllAppConfig();
				session.setAttribute("listAppConfig", listAppConfig);
				logger.info("returning config");
				session.setAttribute("loginSuccess", Boolean.TRUE);
				session.removeAttribute("errorMessage");
				return "config";
					
			}
			
		} catch (Exception e) {
			logger.error("error in userLoginSuccess()", e);
		}
		logger.info("error occoured, going to error page.");
			
		return "error";
	}
}
