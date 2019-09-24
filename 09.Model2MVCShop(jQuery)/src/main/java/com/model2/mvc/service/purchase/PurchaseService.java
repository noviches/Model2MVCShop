package com.model2.mvc.service.purchase;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseService {
	
	// ���ŵ��
	public void addPurchase(Purchase purchase) throws Exception;
	
	// ��������Ȯ��
	public Purchase getPurchase(int tranNo) throws Exception;
	
	public Purchase getPurchase2(int prodNo) throws Exception;

	// ������������Ʈ
	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception;

	// ������������
	public void updatePurchase(Purchase purchase) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;
	
	// �������
	public void removePurchase(int tranNo) throws Exception;
	
}