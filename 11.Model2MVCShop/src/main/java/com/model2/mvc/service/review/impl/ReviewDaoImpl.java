package com.model2.mvc.service.review.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.review.ReviewDao;

@Repository("reviewDaoImpl")
public class ReviewDaoImpl implements ReviewDao {
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public ReviewDaoImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addReview(Review review) throws Exception {
		sqlSession.insert("ReviewMapper.addReview", review);
	}
	
	public Review getReview(int reviewNo) throws Exception {
		return sqlSession.selectOne("ReviewMapper.getReview", reviewNo);
	}
	
	public Review getReview2(int tranNo) throws Exception {
		return sqlSession.selectOne("ReviewMapper.getReview2", tranNo);
	}
	
	public List<Review> getReviewList(Search search) throws Exception {
		return sqlSession.selectList("ReviewMapper.getReviewList", search);
	}
	
	public void updateReview(Review review) throws Exception {
		sqlSession.update("ReviewMapper.updateReview", review);
	}
	
	// 게시판 Page 처리를 위한 전체 Row(totalCount) return
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("ReviewMapper.getTotalCount", search);
	}
	
}