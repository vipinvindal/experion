package com.bets.experion.utils;

import java.util.List;
import java.util.Properties;

import javax.annotation.PostConstruct;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.bets.experion.dao.AppConfigDao;
import com.bets.experion.entity.AppConfig;

@Component("UtilAppConf")
@Scope(value = "singleton")
public class UtilAppConf {

    private static UtilAppConf applicationConfParameters = null;
	private static final Logger LOG = Logger.getLogger(UtilAppConf.class.getName());
    private static Properties props;

	private AppConfigDao appConfigDao;
	
    @Autowired
    public UtilAppConf(AppConfigDao appConfigDao) {
    	this.appConfigDao = appConfigDao;
    	applicationConfParameters = this;
    }

	public static UtilAppConf getInstance() {
        if (applicationConfParameters == null) {
//            applicationConfParameters = new UtilAppConf();
            applicationConfParameters.initialize();
        }
        return applicationConfParameters;
    }
    
    public void reload(){
    	props = new Properties();
        this.initialize();
    }

    @PostConstruct
	public void initialize() {
		LOG.debug("Initialize the bean in PostConstruct");
		if (props == null) {
			props = new Properties();
		}
		try {
			List<AppConfig> appConfigList = appConfigDao.getAllAppConfig();
			for (AppConfig appConfig : appConfigList) {
				if (appConfig.getCustomValue() != null && appConfig.getCustomValue().trim().length()>0) {					
					props.put(appConfig.getConfigKey(), appConfig.getCustomValue());
				} else {
					props.put(appConfig.getConfigKey(), appConfig.getDefaultValue());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error("Error in initialize(): ", e);
		}
	}

    public String getProperty(String name) {
    	if(props==null)
    		initialize();
        return props.getProperty(name);
    }
    
    public String getProperty(String name, String defaultValue) {
    	if(props==null)
    		initialize();
        String returnVal = props.getProperty(name);
        if (returnVal == null)
        	returnVal = defaultValue;
        return returnVal;
    }
}
