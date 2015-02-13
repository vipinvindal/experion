package com.bets.experion.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.bets.experion.entity.User;

@Component("userDao")
@SuppressWarnings("unchecked")
public class UserDao {

	public static final Logger LOG = Logger.getLogger(UserDao.class.getName());
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

	public User getUserByUserID(String userID) {
		LOG.info("entering getUserByUserID with: userID:" + userID);
		try {			
			Query hqlUserByUserID = entityManager.createQuery("from User where userId = ? ");
			hqlUserByUserID.setParameter(1, userID);

			LOG.info("User id existence..." + hqlUserByUserID);
			List<User> userList = hqlUserByUserID.getResultList();
			if(!userList.isEmpty()){
				return userList.get(0);
			}
		} catch (Exception e) {
			LOG.error("error in getUserByUserID()", e);
		}
		return null;
	}

	
}
