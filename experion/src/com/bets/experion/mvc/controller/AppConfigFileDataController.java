package com.bets.experion.mvc.controller;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.bets.experion.dao.AppConfigDao;
import com.bets.experion.entity.AppConfig;
/**
 * methods to export and import functionality for app config info
 * @author hari
 *
 */
@Controller
public class AppConfigFileDataController {

	private static final Logger LOG = Logger.getLogger(AppConfigFileDataController.class);

	private AppConfigDao appConfDAO;	
	@Autowired
	public void setAppConfigDao(AppConfigDao appConfDAO) {		
		this.appConfDAO = appConfDAO;		
	}

	/**
	 * method to export appConfig data to file 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/exportAppConfigFile.html")
	public void exportAppConfigFile(HttpServletRequest request,HttpServletResponse response) throws Exception 
	{		
		if(LOG.isInfoEnabled())
		{
			LOG.info("Entered into exportAppConfigFile()");	
		}	
		OutputStream o = response.getOutputStream();
		response.setContentType("text/csv");		
		response.setHeader("Content-Disposition", "attachment; filename=\"appConfig.csv\"");		
		try{
			StringBuffer writer = new StringBuffer();
			List<AppConfig> listAppConfig = appConfDAO.getAllAppConfig();
			if(!listAppConfig.isEmpty())
			{
				for(AppConfig appCfg:listAppConfig)
				{
					LOG.info("File IS Created with:"+appCfg.getConfigKey()+",\t"+appCfg.getDefaultValue()+",\t"+appCfg.getCustomValue());
					writer.append(appCfg.getCustomValue()!=null?appCfg.getCustomValue().replaceAll(",","&comma;"):" ");
					writer.append(',');
					writer.append(appCfg.getDefaultValue().replaceAll(",","&comma;"));
					writer.append(',');
					writer.append(appCfg.getConfigKey().toString().replaceAll(",","&comma;"));
					writer.append('\n');
				}
			}
			o.write(writer.toString().getBytes());
			o.flush();
		}catch(Exception exception){
			if(LOG.isTraceEnabled())
			{
				LOG.trace("errot occured in exportAppConfigFile()",exception);
			}
		}

	}

	/**
	 * method import appConfig custom data from file to database
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/importAppConfigFile.html")
	public ModelAndView importAppConfigFile(HttpServletRequest request,HttpServletResponse response) throws Exception {
		if(LOG.isInfoEnabled())
		{
			LOG.info("Entered into importAppConfigFile()");	
		}	
		ModelAndView appConfigModelAndView =new ModelAndView();
		List<AppConfig> listAppConfig=new ArrayList<AppConfig>();
		try {
			MultipartRequest multipartRequest = (MultipartRequest) request;
			MultipartFile file = multipartRequest.getFile("appConfigFile");
			InputStream is = null;
			BufferedReader br = null;
			String line = "";
			String cvsSplitBy = ",";
			try {
				byte[] buffer = file.getBytes();
				is = new ByteArrayInputStream(buffer);
				br = new BufferedReader(new InputStreamReader(is));
				while ((line = br.readLine()) != null) {
					String[] data = line.split(cvsSplitBy);
					LOG.info("AppConfig Fields" + "\t" + data[0] + "\t"+ data[1] + "\t" + data[2]);
					AppConfig appConfig = new AppConfig(data[2].replaceAll("&comma;",","), data[1].replaceAll("&comma;",","),data[0].replaceAll("&comma;",","));
					listAppConfig.add(appConfig);
				}
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (br != null) {
					try {
						br.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			appConfDAO.saveOrUpdateAppConfigData(listAppConfig);
			listAppConfig = appConfDAO.getAllAppConfig();
			appConfigModelAndView.setViewName("config");
			appConfigModelAndView.addObject("listAppConfig", listAppConfig);
		}catch(Exception exception)
		{
			exception.printStackTrace();
			if(LOG.isTraceEnabled())
			{
				LOG.trace("error occured in importAppConfigFile()",exception);
			}
			appConfigModelAndView.setViewName("config");
		}
		return appConfigModelAndView;

	}
}
