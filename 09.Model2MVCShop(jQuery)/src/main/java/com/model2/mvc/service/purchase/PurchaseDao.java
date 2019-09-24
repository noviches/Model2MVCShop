package com.model2.mvc.service.purchase;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {

	// INSERT
	public void addPurchase(Purchase purchase) throws Exception;
	
	// SELECT ONE
	public Purchase getPurchase(int tranNo) throws Exception;
	
	public Purchase getPurchase2(int ProdNo) throws Exception;
	
	// SELECT LIST
	public List<Purchase> getPurchaseList(Search search, String buyerId) throws Exception;
	
	// UPDATE
	public void updatePurchase(Purchase purchase) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;
	
	// DELETE
	public void removePurchase(int tranNo) throws Exception;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount) return
	public int getTotalCount(Search search, String buyerId) throws Exception;
	
}