package com.bets.experion.mvc.controller;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bets.experion.entity.FeedLogo;
import com.bets.experion.entity.Gallery;
import com.bets.experion.entity.LocationMap;
import com.bets.experion.entity.ProjectLogo;
import com.bets.experion.service.FeedHandling;
import com.bets.experion.service.GalleryHandling;
import com.bets.experion.service.LocationMapHandling;
import com.bets.experion.service.ProjectHandling;
import com.bets.experion.utils.Constants;
import com.bets.experion.utils.UtilAppConf;

/**
 * This Class methods are redirect to privacy , terms and Conditions pages
 * @author hari
 *
 */
@Controller
public class ViewController {
	private static final Logger LOG = Logger.getLogger(ViewController.class);
	private UtilAppConf utilApp;
	private ProjectHandling projectHandling;
	private GalleryHandling galleryHandling;
	private LocationMapHandling locationMapHandling;
	private FeedHandling feedHandling;
	/**
	 * method to redirect Terms and conditions document pages 
	 * @param request
	 * @param session
	 * @param model
	 * @return
	 */
	@Autowired
	public ViewController(UtilAppConf utilApp, ProjectHandling projectHandling, GalleryHandling galleryHandling, 
			LocationMapHandling locationMapHandling, FeedHandling feedHandling)
	{
		this.utilApp = utilApp;
		this.projectHandling = projectHandling;
		this.galleryHandling= galleryHandling;
		this.locationMapHandling = locationMapHandling;
		this.feedHandling = feedHandling;
	}
	
	
	@RequestMapping("/viewImage.html")
	public void viewImage(HttpServletRequest request, HttpSession session,HttpServletResponse response) 
			throws ServletException, IOException {

		try {
			String recivedFilename = request.getParameter("imagePath");
			LOG.info("File path... " + recivedFilename);		
			File recivedFile = new File(recivedFilename);
			LOG.info("File exist... " + recivedFile.exists());
			

			String mimetype = new MimetypesFileTypeMap().getContentType(recivedFile);
			response.setContentType((mimetype != null) ? mimetype : "text/html;charset=UTF-8");
			response.setContentLength((int) recivedFile.length());

			OutputStream out = response.getOutputStream();
			FileInputStream in = new FileInputStream(recivedFilename);
			int size = in.available();
			byte[] content = new byte[size];
			in.read(content);
			out.write(content);
			in.close();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error("error in viewImg()", e);
		}
	}
	@RequestMapping("/dwImg.html")
	public void dwImg(HttpServletRequest request, HttpServletResponse response) {
		LOG.info("entering dwImg(request, response)");
		
		try {
			String originalFilename = "";
		
			String recivedFilename="";
			String imageID = request.getParameter("imgID");
			String typeOfImage = request.getParameter("imgTy");
			LOG.info(" fileID and type rceived " + imageID + ".." + typeOfImage);
			
			if(typeOfImage.equalsIgnoreCase(Constants.LOCATION_MAP_FOLDER_NAME)){
				LOG.info("getting localtion map");
				LocationMap imageDetail = locationMapHandling.getLocationMapById(imageID);
				if(imageDetail != null)
					recivedFilename = imageDetail.getImagePath();
			}
			else if(typeOfImage.equalsIgnoreCase(Constants.GALLERY_FOLDER_NAME)){
				LOG.info("getting gallery");
				Gallery imageDetail = galleryHandling.getGalleryById(imageID);
				if(imageDetail != null)
					recivedFilename = imageDetail.getImagePath();
			}
			else if(typeOfImage.equalsIgnoreCase(Constants.LOGO_FOLDER_NAME)){
				LOG.info("getting Logo");
				ProjectLogo imageDetail = projectHandling.getProjectLogoById(imageID);
				if(imageDetail != null)
					recivedFilename = imageDetail.getImagePath();
			}
			else if(typeOfImage.equalsIgnoreCase(Constants.FEED_LOGO_FOLDER_NAME)){
				LOG.info("getting feed image");
				FeedLogo imageDetail = feedHandling.getFeedLogoById(imageID);
				if(imageDetail != null)
					recivedFilename = imageDetail.getImagePath();
			}
				  
					LOG.info("Actual path... " + recivedFilename);
					
					originalFilename = recivedFilename.substring(recivedFilename.lastIndexOf("/") + 1);
					LOG.info("Filename...." + originalFilename);
					
					File f = new File(recivedFilename);

					LOG.info("File exist... " + f.exists());
					if (!f.exists()) {
						
						// to do
					}

					int length = 0;
					ServletOutputStream op = response.getOutputStream();

					String mimetype = new MimetypesFileTypeMap().getContentType(f);
					LOG.info("File MIMIE type is :::::::::::" + mimetype);

					File fileTemp = new File(recivedFilename);
					byte javaBuffer[] = new byte[recivedFilename.length()];

					response.setContentType((mimetype != null) ? mimetype : "application/octet-stream");
					response.setHeader("Content-Disposition","attachment; filename=\"" + originalFilename + "\"");

					response.setContentLength((int) fileTemp.length());
					LOG.info("fileName: " + fileTemp.getAbsolutePath() + "::length: "+fileTemp.length());

					DataInputStream in = null;
					try {
						in = new DataInputStream(new FileInputStream(fileTemp));
						LOG.info("File input steram type is :::::::::::" + in);
						LOG.info("File buffer is :::::::::::" + javaBuffer);
						while ((in != null) && ((length = in.read(javaBuffer)) != -1)) {
							op.write(javaBuffer, 0, length);
						}
						byte[] buf = new byte[1024];
						int count = 0;
						while ((count = in.read(buf)) != -1) {
							op.write(buf, 0, count);
							LOG.info("In while loop :::::::::::" + count);
						}
					} catch (Exception e) {
						LOG.error("error in downloading", e);
					}

					finally {
						in.close();
						op.flush();
						op.close();
					}
				
		} catch (Exception e) {
			LOG.error("error in downloading", e);
		}
	}

}
