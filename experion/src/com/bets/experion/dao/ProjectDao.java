package com.bets.experion.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.bets.experion.entity.Feature;
import com.bets.experion.entity.Gallery;
import com.bets.experion.entity.ImageType;
import com.bets.experion.entity.LocationMap;
import com.bets.experion.entity.Project;
import com.bets.experion.entity.ProjectLogo;
import com.bets.experion.entity.WalkThrough;

@Component("projectDao")
@SuppressWarnings("unchecked")
public class ProjectDao {

	public static final Logger LOG = Logger.getLogger(ProjectDao.class.getName());
	private EntityManager entityManager;

	@PersistenceContext
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	/*@Transactional(readOnly = false)
	public User saveOrUpdateUser(User userinfo) {
		LOG.info("saveUser()");
		try {
			userinfo = entityManager.merge(userinfo);
			LOG.info("Data successfuly added");
			return userinfo;
		} catch (Exception e) {
			LOG.error("Error occured in dao",e );
			return null;
		}

	}	*/

	public List<ImageType> getImageType() {
		LOG.info("entering getImageType() ");
		try {			
			Query hqlGetImageType = entityManager.createQuery("from ImageType");
			

			LOG.info("User id existence..." + hqlGetImageType);
			List<ImageType> imageTypeList = hqlGetImageType.getResultList();
			
				return imageTypeList;
			
		} catch (Exception e) {
			LOG.error("error in getImageType()", e);
		}
		return null;
	}
	
	
	public List<ImageType> getImageTypeNotInProject(Long projectId) {
		LOG.info("entering getImageTypeNotInProject() " + projectId );
		try {			
			Query hqlGetImageType = entityManager.createQuery("from ImageType where id not in"
					+ " (select imageTypeInfo.id from ProjectLogo where projectInfo.id= ?)");
			hqlGetImageType.setParameter(1, projectId);

			LOG.info("User id existence..." + hqlGetImageType);
			List<ImageType> imageTypeList = hqlGetImageType.getResultList();
			LOG.info("User id existence..." + imageTypeList.isEmpty());
				return imageTypeList;
			
		} catch (Exception e) {
			LOG.error("error in getImageTypeNotInProject()", e);
		}
		return null;
	}
	
	

	public ImageType getImageTypeByName(String resolution) {
		// TODO Auto-generated method stub
		LOG.info("entering getImageTypeByName() ");
		try {			
			Query hqlGetImageType = entityManager.createQuery("from ImageType where resolution = ?");
			hqlGetImageType.setParameter(1, resolution);

			LOG.info("User id existence..." + hqlGetImageType);
			List<ImageType> imageTypeList = hqlGetImageType.getResultList();
			if(!imageTypeList.isEmpty())
				return imageTypeList.get(0);
			
		} catch (Exception e) {
			LOG.error("error in getImageTypeByName()", e);
		}
		return null;
	}
	
	@Transactional
	public Project saveOrUpdateProject(Project projectDetail) {
		LOG.info("entering ssaveOrUpdateProject(Project) with: " + projectDetail);
		
		try {
			projectDetail = entityManager.merge(projectDetail);
			//entityManager.flush();
			LOG.info("Data successfuly added id is.." + projectDetail.getId());
			return projectDetail;
			
		} catch (Exception e) {
			LOG.error("Error in saveOrUpdate(Project)", e);
		}
		return null;

	}
	
	public ImageType getImageTypeById(long imageTypeId) {
		// TODO Auto-generated method stub
		LOG.info("entering getImageTypeById() " + imageTypeId);
		try {			
			Query hqlGetImageType = entityManager.createQuery("from ImageType where id = ?");
			hqlGetImageType.setParameter(1, imageTypeId);

			LOG.info("User id existence..." + hqlGetImageType);
			List<ImageType> imageTypeList = hqlGetImageType.getResultList();
			
			if(!imageTypeList.isEmpty()){
				return imageTypeList.get(0);
			}
			
		} catch (Exception e) {
			LOG.error("error in getImageTypeById()", e);
		}
		return null;
		
	}
	@Transactional
	public ProjectLogo saveOrUpdateProjectLogo(ProjectLogo projectLogoInfo) {
		// TODO Auto-generated method stub
		
      LOG.info("entering saveOrUpdateProjectLogo(projectLogoInfo) with: " + projectLogoInfo);
		
		try {
			projectLogoInfo = entityManager.merge(projectLogoInfo);
			//entityManager.flush();
			LOG.info("Data successfuly added id is.." + projectLogoInfo.getId());
			return projectLogoInfo;
			
		} catch (Exception e) {
			LOG.error("Error in saveOrUpdateProjectLogo(projectLogoInfo)", e);
		}
		return null;
	}

	public Project getProjectById(long projectId) {
		// TODO Auto-generated method stub
		LOG.info("entering getProjectById() ");
		try {			
			Query hqlGetProject = entityManager.createQuery("from Project where id = ?");
			hqlGetProject.setParameter(1, projectId);

			LOG.info("Project existence..." + hqlGetProject);
			List<Project> projectList = hqlGetProject.getResultList();
			if(!projectList.isEmpty()){
				return projectList.get(0);
			}
				
			
		} catch (Exception e) {
			LOG.error("error in getProjectById()", e);
		}
		return null;
	}

	public List<Project> getProject() {
		// TODO Auto-generated method stub
		LOG.info("entering getProject() ");
		try {			
			Query hqlGetProject = entityManager.createQuery("from Project where status = ? ");
			
			hqlGetProject.setParameter(1, true);
			
			
			/*Query hqlGetProjectWithLogo = entityManager.createQuery("Select Project, ProjectLogo from "
					+ Project.class.getCanonicalName()
					 +" project left outer join project.ProjectLogo projectLogo"
					+ " where projectLogo.imageTypeInfo.id= ? and project.status = ?");
			//Query getMember = entityManager
			
			//project.id, project.name, project.shortDescription, projectLogo.id
*/
			LOG.info("Project existence..." + hqlGetProject);
			List<Project> projectList = hqlGetProject.getResultList();
			
				return projectList;
			
		} catch (Exception e) {
			LOG.error("error in getProject()", e);
		}
		return null;
	}
	public List<Project> getProjects(Date projectUpdate, Long imageTypeId, boolean status) {
		// TODO Auto-generated method stub
		LOG.info("entering getProject() " );
		try {			
			
			Query hqlGetProject = entityManager.createQuery("from Project where updatedOn >= ? and status = ?");
			
		
			hqlGetProject.setParameter(1, projectUpdate);
			hqlGetProject.setParameter(2, status);
	
			
			LOG.info("Project existence..." + hqlGetProject);
			List<Project> projectList = hqlGetProject.getResultList();
			
				return projectList;
			
		} catch (Exception e) {
			LOG.error("error in getProject()", e);
		}
		return null;
	}

	public List<ProjectLogo> getProjectLogo(long projectId) {
		// TODO Auto-generated method stub
		LOG.info("entering getProjectLogo() ");
		try {			
			Query hqlGetProjectLogo = entityManager.createQuery("from ProjectLogo where projectInfo.id = ? and status = ? ");
			hqlGetProjectLogo.setParameter(1, projectId);
			hqlGetProjectLogo.setParameter(2, true);

			LOG.info("ProjectLogo existence..." + hqlGetProjectLogo);
			List<ProjectLogo> projectLogoList = hqlGetProjectLogo.getResultList();
			
				return projectLogoList;
			
		} catch (Exception e) {
			LOG.error("error in getProjectLogo()", e);
		}
		return null;
	}
	
	public ProjectLogo getProjectLogoByImageTypeId(long projectId, long imageTypeId) {
		// TODO Auto-generated method stub
		LOG.info("entering getProjectLogo() ");
		try {			
			Query hqlGetProjectLogo = entityManager.createQuery("from ProjectLogo where projectInfo.id = ? and imageTypeInfo.id= ? and status = ? ");
			hqlGetProjectLogo.setParameter(1, projectId);
			hqlGetProjectLogo.setParameter(2, true);

			LOG.info("ProjectLogo existence..." + hqlGetProjectLogo);
			List<ProjectLogo> projectLogoList = hqlGetProjectLogo.getResultList();
			if(!projectLogoList.isEmpty())
				return projectLogoList.get(0);
			
		} catch (Exception e) {
			LOG.error("error in getProjectLogo()", e);
		}
		return null;
	}
	
	public ProjectLogo getProjectLogoById(long projectLogoId) {
		// TODO Auto-generated method stub
		LOG.info("entering getProjectLogoById() ");
		try {			
			Query hqlGetProjectLogo = entityManager.createQuery("from ProjectLogo where  id = ?");
			hqlGetProjectLogo.setParameter(1, projectLogoId);
			

			LOG.info("ProjectLogo existence..." + hqlGetProjectLogo);
			List<ProjectLogo> projectLogoList = hqlGetProjectLogo.getResultList();
			if(!projectLogoList.isEmpty()){
				return projectLogoList.get(0);
			}
				
			
		} catch (Exception e) {
			LOG.error("error in getProjectLogoById()", e);
		}
		return null;
	}

	public List<WalkThrough> getWalkThrough(Long projectId) {
		// TODO Auto-generated method stub
		LOG.info("entering getWalkThrough() ");
		try {			
			Query hqlGetWalkthrough = entityManager.createQuery("from WalkThrough where projectInfo.id = ? and status = ? ");
			hqlGetWalkthrough.setParameter(1, projectId);
			hqlGetWalkthrough.setParameter(2, true);

			LOG.info("getWalkThrough existence..." + hqlGetWalkthrough);
			List<WalkThrough> walkthroughList = hqlGetWalkthrough.getResultList();
			
				return walkthroughList;
			
		} catch (Exception e) {
			LOG.error("error in getWalkThrough()", e);
		}
		return null;
	}
	@Transactional
	public WalkThrough saveOrUpdateWalkThrough(WalkThrough walkThroughInfo) {
		// TODO Auto-generated method stub
        LOG.info("entering saveOrUpdateWalkThrough(walkThroughInfo) with: " + walkThroughInfo);
		
		try {
			walkThroughInfo = entityManager.merge(walkThroughInfo);
			LOG.info("Data successfuly added id is.." + walkThroughInfo.getId());
			return walkThroughInfo;
			
		} catch (Exception e) {
			LOG.error("Error in saveOrUpdateWalkThrough(walkThroughInfo)", e);
		}
		return null;
	}

	public WalkThrough getWalkThroughById(long walkThroughId) {
		// TODO Auto-generated method stub
		LOG.info("entering getWalkThroughById() ");
		try {			
			Query hqlGetWalkthrough = entityManager.createQuery("from WalkThrough where id = ? ");
			hqlGetWalkthrough.setParameter(1, walkThroughId);
			

			LOG.info("Walk through existence..." + hqlGetWalkthrough);
			List<WalkThrough> walkthroughList = hqlGetWalkthrough.getResultList();
			if(!walkthroughList.isEmpty())
				return walkthroughList.get(0);
			
		} catch (Exception e) {
			LOG.error("error in getWalkThroughById()", e);
		}
		return null;
	}

	public List<Feature> getFeature(Long projectId) {
		// TODO Auto-generated method stub
		LOG.info("entering getFeature() with project ID... " + projectId);
		try {			
			Query hqlGetFeature = entityManager.createQuery("from Feature where projectInfo.id = ? and status = ? ");
			hqlGetFeature.setParameter(1, projectId);
			hqlGetFeature.setParameter(2, true);

			LOG.info("getFeature existence..." + hqlGetFeature);
			List<Feature> featureList = hqlGetFeature.getResultList();
			
				return featureList;
			
		} catch (Exception e) {
			LOG.error("error in getFeature()", e);
		}
		return null;
	}

	public Feature getFeatureById(long featureId) {
		// TODO Auto-generated method stub
		try {			
			Query hqlGetFeature = entityManager.createQuery("from Feature where id = ? and status = ? ");
			hqlGetFeature.setParameter(1, featureId);
			hqlGetFeature.setParameter(2, true);

			LOG.info("getFeatureById existence..." + hqlGetFeature);
			List<Feature> featureList = hqlGetFeature.getResultList();
			if(!featureList.isEmpty())
				return featureList.get(0);
			
		} catch (Exception e) {
			LOG.error("error in getFeatureById()", e);
		}
		return null;
	}
	@Transactional
	public Feature saveOrUpdateFeature(Feature featureInfo) {
		// TODO Auto-generated method stub
		 LOG.info("entering saveOrUpdateFeature(featureInfo) with: " + featureInfo);
			
			try {
				featureInfo = entityManager.merge(featureInfo);
				LOG.info("Data successfuly added id is.." + featureInfo.getId());
				return featureInfo;
				
			} catch (Exception e) {
				LOG.error("Error in saveOrUpdateFeature(featureInfo)", e);
			}
			return null;
	}
	@Transactional
	public Gallery saveOrUpdateGallery(Gallery galleryInfo) {
		// TODO Auto-generated method stub
		
	      LOG.info("entering saveOrUpdateGallery(galleryInfo) with: " + galleryInfo);
			
			try {
				galleryInfo = entityManager.merge(galleryInfo);
				//entityManager.flush();
				LOG.info("Data successfuly added id is.." + galleryInfo.getId());
				return galleryInfo;
				
			} catch (Exception e) {
				LOG.error("Error in saveOrUpdateGallery(galleryInfo)", e);
			}
			return null;
		}
	@Transactional
	public LocationMap saveOrUpdateLocationMap(LocationMap locationMapInfo) {
		// TODO Auto-generated method stub
		LOG.info("entering saveOrUpdateLocationMap(locationMapInfo) with: " + locationMapInfo);
		
		try {
			locationMapInfo = entityManager.merge(locationMapInfo);
			//entityManager.flush();
			LOG.info("Data successfuly added id is.." + locationMapInfo.getId());
			return locationMapInfo;
			
		} catch (Exception e) {
			LOG.error("Error in saveOrUpdateLocationMap(locationMapInfo)", e);
		}
		return null;
	}

	public LocationMap getLocationMapById(long locationMapId) {
		// TODO Auto-generated method stub
		try {			
			Query hqlGetLocationMap = entityManager.createQuery("from LocationMap where id = ? and status = ? ");
			hqlGetLocationMap.setParameter(1, locationMapId);
			hqlGetLocationMap.setParameter(2, true);

			LOG.info("getLocationMapById existence..." + hqlGetLocationMap);
			List<LocationMap> locationMapList = hqlGetLocationMap.getResultList();
			if(!locationMapList.isEmpty())
				return locationMapList.get(0);
			
		} catch (Exception e) {
			LOG.error("error in getLocationMapById()", e);
		}
		return null;
	}

	public Gallery getGalleryById(long galleryId){
		// TODO Auto-generated method stub
		try {			
			Query hqlGetGallery = entityManager.createQuery("from Gallery where id = ? and status = ? ");
			hqlGetGallery.setParameter(1, galleryId);
			hqlGetGallery.setParameter(2, true);

			LOG.info("getGalleryById existence..." + hqlGetGallery);
			List<Gallery> galleryList = hqlGetGallery.getResultList();
			if(!galleryList.isEmpty())
				return galleryList.get(0);
			
		} catch (Exception e) {
			LOG.error("error in getGalleryById()", e);
		}
		return null;
	}

	public List<Gallery> getGalleryByProjectId(Long projectId) {
		// TODO Auto-generated method stub
		try {			
			Query hqlGetGallery = entityManager.createQuery("from Gallery where projectInfo.id = ? and status = ? ");
			hqlGetGallery.setParameter(1, projectId);
			hqlGetGallery.setParameter(2, true);

			LOG.info("getGalleryByProjectId existence..." + hqlGetGallery);
			List<Gallery> galleryList = hqlGetGallery.getResultList();
			
				return galleryList;
			
		} catch (Exception e) {
			LOG.error("error in getGalleryByProjectId()", e);
		}
		return null;
	}

	public Gallery getGalleryLastId() {
		// TODO Auto-generated method stub
		
		try {			
			Query hqlGetGallery = entityManager.createQuery("from Gallery order by id desc");
			hqlGetGallery.setMaxResults(1);
			LOG.info("getGalleryLastId existence..." + hqlGetGallery);
			List<Gallery> galleryList = hqlGetGallery.getResultList();
			if(!galleryList.isEmpty())
			return galleryList.get(0);
			
		} catch (Exception e) {
			LOG.error("error in getGalleryLastId()", e);
		}
		return null;
	}
	public List<Gallery> getGalleryByCommonName(String commonName) {
		// TODO Auto-generated method stub
		
		try {			
			Query hqlGetGallery = entityManager.createQuery("from Gallery where commonName = ?");
			hqlGetGallery.setParameter(1, commonName);
			//hqlGetGallery.setParameter(2, imageTypeID);
			LOG.info("getGalleryLastId existence..." + hqlGetGallery);
			List<Gallery> galleryList = hqlGetGallery.getResultList();
			
			return galleryList;
			
		} catch (Exception e) {
			LOG.error("error in getGalleryByCommonName()", e);
		}
		return null;
	}
	public Gallery getGalleryByCommonNameAndImageID(long imageTypeID, String commonName) {
		// TODO Auto-generated method stub
		
		try {			
			Query hqlGetGallery = entityManager.createQuery("from Gallery where commonName = ? and imageTypeInfo.id = ?");
			hqlGetGallery.setParameter(1, commonName);
			hqlGetGallery.setParameter(2, imageTypeID);
			LOG.info("getGalleryLastId existence..." + hqlGetGallery);
			List<Gallery> galleryList = hqlGetGallery.getResultList();
			if(!galleryList.isEmpty())
			return galleryList.get(0);
			
		} catch (Exception e) {
			LOG.error("error in getGalleryByCommonNameAndImageID()", e);
		}
		return null;
	}
	public LocationMap getLocationMapLastId() {
		// TODO Auto-generated method stub
		
		try {			
			Query hqlGetLocationMap = entityManager.createQuery("from LocationMap order by id desc");
			hqlGetLocationMap.setMaxResults(1);
			LOG.info("getFeatureById existence..." + hqlGetLocationMap);
			List<LocationMap> locationMapList = hqlGetLocationMap.getResultList();
			if(!locationMapList.isEmpty())
					return locationMapList.get(0);
			
		} catch (Exception e) {
			LOG.error("error in getLocationMapLastId()", e);
		}
		return null;
	}

	public List<LocationMap> getLocationMapByProjectId(Long projectId) {
		// TODO Auto-generated method stub
		try {			
			Query hqlLocationMap = entityManager.createQuery("from LocationMap where projectInfo.id = ? and status = ? ");
			hqlLocationMap.setParameter(1, projectId);
			hqlLocationMap.setParameter(2, true);

			LOG.info("getGalleryByProjectId existence..." + hqlLocationMap);
			List<LocationMap> locationMapList = hqlLocationMap.getResultList();
			
				return locationMapList;
			
		} catch (Exception e) {
			LOG.error("error in getLocationMapByProjectId()", e);
		}
		return null;
	}

	public List<LocationMap> getLocationMapByCommonName(String commonName) {
		// TODO Auto-generated method stub
		
		try {			
			Query hqlGetLocationMap = entityManager.createQuery("from LocationMap where commonName = ?");
			hqlGetLocationMap.setParameter(1, commonName);
			//hqlGetLocationMap.setParameter(2, imageTypeID);
			LOG.info("getLocationMapLastId existence..." + hqlGetLocationMap);
			List<LocationMap> LocationMapList = hqlGetLocationMap.getResultList();
			
			return LocationMapList;
			
		} catch (Exception e) {
			LOG.error("error in etLocationMapByCommonName()", e);
		}
		return null;
	}
	public LocationMap getLocationMapByCommonNameAndImageID(long imageTypeID, String commonName) {
		// TODO Auto-generated method stub
		
		try {			
			Query hqlGetLocationMap = entityManager.createQuery("from LocationMap where commonName = ? and imageTypeInfo.id = ?");
			hqlGetLocationMap.setParameter(1, commonName);
			hqlGetLocationMap.setParameter(2, imageTypeID);
			LOG.info("getLocationMapLastId existence..." + hqlGetLocationMap);
			List<LocationMap> LocationMapList = hqlGetLocationMap.getResultList();
			if(!LocationMapList.isEmpty())
			return LocationMapList.get(0);
			
		} catch (Exception e) {
			LOG.error("error in getLocationMapByCommonNameAndImageID()", e);
		}
		return null;
	}
}

