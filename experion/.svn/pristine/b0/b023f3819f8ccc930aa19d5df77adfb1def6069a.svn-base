package com.bets.experion.entity;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "app_config")
public class AppConfig implements java.io.Serializable{

	private static final long serialVersionUID = -8246261091447639402L;

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id")
	private Long id;

	@Column(name = "config_key", nullable = false, unique = true)
	private String configKey;

	@Column(name = "default_value", nullable = false, length = 2000)
	private String defaultValue;

	@Column(name = "custom_value", nullable = true, length = 2000)
	private String customValue;

	public AppConfig(){
		super();
	}

	public AppConfig(String configKey,String defaultValue,String customValue){
		super();
		this.configKey=configKey;
		this.defaultValue=defaultValue;
		this.customValue=customValue;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getConfigKey() {
		return configKey;
	}

	public void setConfigKey(String configKey) {
		this.configKey = configKey;
	}

	public String getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}

	public String getCustomValue() {
		return customValue;
	}
	public String getCustomValueHTML() {
		if(customValue!=null)
			return customValue.replaceAll("&", "&amp;").replaceAll("\"", "&quot;");
		else
			return customValue;
	}


	public void setCustomValue(String customValue) {
		this.customValue = customValue;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((configKey == null) ? 0 : configKey.hashCode());
		result = prime * result
				+ ((customValue == null) ? 0 : customValue.hashCode());
		result = prime * result
				+ ((defaultValue == null) ? 0 : defaultValue.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AppConfig other = (AppConfig) obj;
		if (configKey == null) {
			if (other.configKey != null)
				return false;
		} else if (!configKey.equals(other.configKey))
			return false;
		if (customValue == null) {
			if (other.customValue != null)
				return false;
		} else if (!customValue.equals(other.customValue))
			return false;
		if (defaultValue == null) {
			if (other.defaultValue != null)
				return false;
		} else if (!defaultValue.equals(other.defaultValue))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "AppConfig [id=" + id + ", configKey=" + configKey
				+ ", defaultValue=" + defaultValue + ", customValue="
				+ customValue + "]";
	}

}
