package com.model2.mvc.service.purchase;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseService {
	
	// 구매등록
	public void addPurchase(Purchase purchase) throws Exception;
	
	// 구매정보확인
	public Purchase getPurchase(int tranNo) throws Exception;
	
	public Purchase getPurchase2(int prodNo) throws Exception;

	// 구매정보리스트
	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception;

	// 구매정보수정
	public void updatePurchase(Purchase purchase) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;
	
	// 구매취소
	public void removePurchase(int tranNo) throws Exception;
	
}