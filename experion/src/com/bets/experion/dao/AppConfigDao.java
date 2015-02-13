package com.bets.experion.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.bets.experion.entity.AppConfig;

@SuppressWarnings("unchecked")
@Component("appConfigDao")
public class AppConfigDao {
	public static final Logger LOG = Logger.getLogger(AppConfigDao.class.getName());
	private EntityManager entityManager;

	@PersistenceContext
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}
	
	@Transactional(readOnly = true)
	public List<AppConfig> getAllAppConfig() {
		LOG.info("entering getAllAppConfig()");
		try {
			Query getConfigQuery = entityManager.createQuery("from AppConfig");
			return getConfigQuery.getResultList();
		} catch (Exception e) {
			LOG.info("Error in getAllAppConfig()", e);
		}
		return null;
	}

	@Transactional(readOnly=true)
	public AppConfig getAppConfigById(Long id) {
		LOG.info("entering getAppConfigById() with id:" + id);
		try {
			return entityManager.find(AppConfig.class, id);
		} catch (Exception e) {
			LOG.error("Error in getAppConfigById()", e);
		}
		return null;
	}

	@Transactional(readOnly=false)
	public boolean saveOrUpdate(AppConfig appConf) {
		LOG.info("entering saveOrUpdate() with appConf:" + appConf);
		try {
			appConf = entityManager.merge(appConf);
			return true;
		} catch (Exception e) {
			LOG.error("Error in saveOrUpdate()", e);
		}
		return false;
	}
	
	@Transactional(readOnly = false)
	public Boolean saveOrUpdateAppConfigData(List<AppConfig> listAppConfig) {
		if(LOG.isInfoEnabled())
		{
			LOG.info("entering saveOrUpdateAppConfigData() with appConf:" + listAppConfig);
		}
		Query appConfigMergeQuery=entityManager.createQuery("from AppConfig appCfg where appCfg.configKey = ? ");
		Boolean status=false;
		
		if(!listAppConfig.isEmpty())
		{
			for(AppConfig appConfig:listAppConfig)
			{
				appConfigMergeQuery.setParameter(1,appConfig.getConfigKey());
//				appConfigMergeQuery.setParameter(2,appConfig.getDefaultValue());				
				List<AppConfig> appCfgList=appConfigMergeQuery.getResultList();
				if(!appCfgList.isEmpty())
				{
					LOG.info("Update AppConfig: "+appConfig.getConfigKey()+"\t"+appConfig.getDefaultValue()+"\t"+appConfig.getCustomValue());
					AppConfig appCfgObject=appCfgList.get(0);
					appCfgObject.setCustomValue(appConfig.getCustomValue());
					saveOrUpdate(appCfgObject);
				}
				else
				{
					LOG.info("Save AppConfog"+appConfig.getConfigKey()+"\t"+appConfig.getDefaultValue()+"\t"+appConfig.getCustomValue());
					saveOrUpdate(appConfig);
				}
			}			
		}		
		if(LOG.isInfoEnabled())
		{
			LOG.info("exit saveOrUpdateAppConfigData() with appConf:" + listAppConfig);
		}
		return status;
	}

}
