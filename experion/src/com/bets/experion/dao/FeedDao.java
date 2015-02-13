package com.bets.experion.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.bets.experion.entity.Feed;
import com.bets.experion.entity.FeedLogo;

@Component("feedDao")
@SuppressWarnings("unchecked")
public class FeedDao {

	public static final Logger LOG = Logger.getLogger(FeedDao.class.getName());
	private EntityManager entityManager;

	@PersistenceContext
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}


		
	@Transactional
	public Feed saveOrUpdateFeed(Feed feedDetail) {
		LOG.info("entering saveOrUpdateFeed(Feed) with: " + feedDetail);
		
		try {
			feedDetail = entityManager.merge(feedDetail);
			//entityManager.flush();
			LOG.info("Data successfuly added id is.." + feedDetail.getId());
			return feedDetail;
			
		} catch (Exception e) {
			LOG.error("Error in saveOrUpdateFeed(Feed)", e);
		}
		return null;

	}
	
	
	@Transactional
	public FeedLogo saveOrUpdateFeedLogo(FeedLogo feedLogoInfo) {
		// TODO Auto-generated method stub
		
      LOG.info("entering saveOrUpdateFeedLogo(feedLogoInfo) with: " + feedLogoInfo);
		
		try {
			feedLogoInfo = entityManager.merge(feedLogoInfo);
			//entityManager.flush();
			LOG.info("Data successfuly added id is.." + feedLogoInfo.getId());
			return feedLogoInfo;
			
		} catch (Exception e) {
			LOG.error("Error in saveOrUpdateFeedLogo(feedLogoInfo)", e);
		}
		return null;
	}

	public Feed getFeedById(long feedId) {
		// TODO Auto-generated method stub
		LOG.info("entering getFeedById() ");
		try {			
			Query hqlGetFeed = entityManager.createQuery("from Feed where id = ?");
			hqlGetFeed.setParameter(1, feedId);

			LOG.info("Feed existence..." + hqlGetFeed);
			List<Feed> feedList = hqlGetFeed.getResultList();
			if(!feedList.isEmpty()){
				return feedList.get(0);
			}
				
			
		} catch (Exception e) {
			LOG.error("error in getFeedById()", e);
		}
		return null;
	}

	public List<Feed> getFeed() {
		// TODO Auto-generated method stub
		LOG.info("entering getFeed() ");
		try {			
			Query hqlGetFeed = entityManager.createQuery("from Feed where status = ? ");
			
			hqlGetFeed.setParameter(1, true);
			
			LOG.info("Feed existence..." + hqlGetFeed);
			List<Feed> feedList = hqlGetFeed.getResultList();
			
				return feedList;
			
		} catch (Exception e) {
			LOG.error("error in getFeed()", e);
		}
		return null;
	}
	

	public List<FeedLogo> getFeedLogo(long feedId) {
		// TODO Auto-generated method stub
		LOG.info("entering getFeedLogo() ");
		try {			
			Query hqlGetFeedLogo = entityManager.createQuery("from FeedLogo where feedInfo.id = ? and status = ? ");
			hqlGetFeedLogo.setParameter(1, feedId);
			hqlGetFeedLogo.setParameter(2, true);

			LOG.info("FeedLogo existence..." + hqlGetFeedLogo);
			List<FeedLogo> feedLogoList = hqlGetFeedLogo.getResultList();
			
				return feedLogoList;
			
		} catch (Exception e) {
			LOG.error("error in getFeedLogo()", e);
		}
		return null;
	}
	
	public FeedLogo getFeedLogoByImageTypeId(long feedId, long imageTypeId) {
		// TODO Auto-generated method stub
		LOG.info("entering getFeedLogo() ");
		try {			
			Query hqlGetFeedLogo = entityManager.createQuery("from FeedLogo where feedInfo.id = ? and imageTypeInfo.id= ? and status = ? ");
			hqlGetFeedLogo.setParameter(1, feedId);
			hqlGetFeedLogo.setParameter(2, true);

			LOG.info("FeedLogo existence..." + hqlGetFeedLogo);
			List<FeedLogo> feedLogoList = hqlGetFeedLogo.getResultList();
			if(!feedLogoList.isEmpty())
				return feedLogoList.get(0);
			
		} catch (Exception e) {
			LOG.error("error in getFeedLogo()", e);
		}
		return null;
	}
	
	public FeedLogo getFeedLogoById(long feedLogoId) {
		// TODO Auto-generated method stub
		LOG.info("entering getFeedLogoById() ");
		try {			
			Query hqlGetFeedLogo = entityManager.createQuery("from FeedLogo where  id = ?");
			hqlGetFeedLogo.setParameter(1, feedLogoId);
			

			LOG.info("FeedLogo existence..." + hqlGetFeedLogo);
			List<FeedLogo> feedLogoList = hqlGetFeedLogo.getResultList();
			if(!feedLogoList.isEmpty()){
				return feedLogoList.get(0);
			}
				
			
		} catch (Exception e) {
			LOG.error("error in getFeedLogoById()", e);
		}
		return null;
	}

	
}

