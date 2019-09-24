package com.model2.mvc.service.domain;

import java.sql.Date;

import com.model2.mvc.service.domain.Purchase;

public class Review {
	
	///Field
	private Purchase trans;
	private String content;
	private String reviewImg;
	private int good;
	private Date reviewDate;
	private int reviewNo;
	
	///Constructor
	public Review() {
	}
	
	///Method
	public Purchase getTrans() {
		return trans;
	}
	public void setTrans(Purchase trans) {
		this.trans = trans;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReviewImg() {
		return reviewImg;
	}
	public void setReviewImg(String reviewImg) {
		this.reviewImg = reviewImg;
	}
	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	public Date getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	
	@Override
	public String toString() {
		return "ReviewVO [trans=" + trans + ", content=" + content + ", reviewImg=" + reviewImg
				+ ", good=" + good + ", reviewDate=" + reviewDate + ", reviewNo=" + reviewNo + "]";
	}
	
}