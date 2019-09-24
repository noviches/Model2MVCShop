package com.model2.mvc.service.review;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Review;

public interface ReviewService {
	
	// ������
	public void addReview(Review review) throws Exception;
	
	// ��������Ȯ��
	public Review getReview(int reviewNo) throws Exception;
	
	public Review getReview2(int tranNo) throws Exception;

	// ������������Ʈ
	public Map<String, Object> getReviewList(Search search) throws Exception;

	// �������
	public void updateReview(Review review) throws Exception;
	
}