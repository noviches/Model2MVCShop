package com.model2.mvc.service.review;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Review;

public interface ReviewDao {

	// INSERT
	public void addReview(Review review) throws Exception;
	
	// SELECT ONE
	public Review getReview(int reviewNo) throws Exception;
	
	public Review getReview2(int tranNo) throws Exception;
	
	// SELECT LIST
	public List<Review> getReviewList(Search search) throws Exception;
	
	// UPDATE
	public void updateReview(Review review) throws Exception;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount) return
	public int getTotalCount(Search search) throws Exception;
	
}