package com.model2.mvc.service.review;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Review;

public interface ReviewService {
	
	// 리뷰등록
	public void addReview(Review review) throws Exception;
	
	// 리뷰정보확인
	public Review getReview(int reviewNo) throws Exception;
	
	public Review getReview2(int tranNo) throws Exception;

	// 리뷰정보리스트
	public Map<String, Object> getReviewList(Search search) throws Exception;

	// 리뷰수정
	public void updateReview(Review review) throws Exception;
	
}