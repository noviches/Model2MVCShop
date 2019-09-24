package com.model2.mvc.service.review.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.review.ReviewDao;
import com.model2.mvc.service.review.ReviewService;

@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {
	
	///Field
	@Autowired
	@Qualifier("reviewDaoImpl")
	private ReviewDao reviewDao;
	public void setReviewDao(ReviewDao reviewDao) {
		this.reviewDao = reviewDao;
	}
	
	///Constructor
	public ReviewServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addReview(Review review) throws Exception {
		reviewDao.addReview(review);
	}
	
	public Review getReview(int reviewNo) throws Exception {
		return reviewDao.getReview(reviewNo);
	}
	
	public Review getReview2(int tranNo) throws Exception {
		return reviewDao.getReview2(tranNo);
	}
	
	public Map<String, Object> getReviewList(Search search) throws Exception {
		List<Review> list = reviewDao.getReviewList(search);
		int totalCount = reviewDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	public void updateReview(Review review) throws Exception {
		reviewDao.updateReview(review);
	}
	
}