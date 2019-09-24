package com.model2.mvc.service.domain;

import java.sql.Date;

public class Product {
	
	///Field
	private String fileName;
	private String manuDate;
	private int price;
	private String prodDetail;
	private String prodName;
	private int prodNo;
	private int reQuantity;
	private int saleCount;
	private Date regDate;
	
	///Constructor
	public Product() {
	}
	
	///Method
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getManuDate() {
		return manuDate;
	}
	public void setManuDate(String manuDate) {
		this.manuDate = manuDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getProdDetail() {
		return prodDetail;
	}
	public void setProdDetail(String prodDetail) {
		this.prodDetail = prodDetail;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public int getProdNo() {
		return prodNo;
	}
	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}
	public int getReQuantity() {
		return reQuantity;
	}
	public void setReQuantity(int reQuantity) {
		this.reQuantity = reQuantity;
	}
	public int getSaleCount() {
		return saleCount;
	}
	public void setSaleCount(int saleCount) {
		this.saleCount = saleCount;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	@Override
	public String toString() {
		return "ProductVO : [fileName]" + fileName + "[manuDate]" + manuDate
				+ "[price]" + price + "[prodDetail]" + prodDetail + "[prodName]" + prodName
				+ "[prodNo]" + prodNo + "[reQuantity]" + reQuantity + "[saleCount]" + saleCount;
	}
	
}