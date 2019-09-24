package com.model2.mvc.service.purchase.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/context-common.xml",
								   "classpath:config/context-aspect.xml",
								   "classpath:config/context-mybatis.xml",
								   "classpath:config/context-transaction.xml"})
public class PurchaseServiceTest {

	//==> @RunWith, @ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;

	// @Test
	public void testAddPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		Product product = new Product();
		User user = new User();
		
		product.setProdNo(10000);
		user.setUserId("user01");
		
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		purchase.setPaymentOption("2");
		purchase.setReceiverName("������");
		purchase.setDivyAddr("��⵵");
		purchase.setTranCode("1");
		
		purchaseService.addPurchase(purchase);
		
		// insert �� �ش� ���Ź�ȣ �Է��Ͽ� Ȯ��
		purchase = purchaseService.getPurchase(10088);

		//==> console Ȯ��
		System.out.println(purchase);
		
		//==> API Ȯ��
		Assert.assertEquals(10000, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user01", purchase.getBuyer().getUserId());
		Assert.assertEquals("2", purchase.getPaymentOption());
		Assert.assertEquals("������", purchase.getReceiverName());
		Assert.assertEquals("��⵵", purchase.getDivyAddr());
		Assert.assertEquals("1", purchase.getTranCode());
		
	}
	
	// @Test
	public void testGetPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		//==> �ʿ��ϴٸ�...
//		Product product = new Product();
//		User user = new User();
//		
//		product.setProdNo(10000);
//		user.setUserId("user01");
//		
//		purchase.setPurchaseProd(product);
//		purchase.setBuyer(user);
//		purchase.setPaymentOption("2");
//		purchase.setReceiverName("������");
//		purchase.setDivyAddr("��⵵");
//		purchase.setTranCode("1");
//		purchaseService.addPurchase(purchase);
		
		// insert �� �ش� ��ǰ��ȣ �Է��Ͽ� Ȯ��
		purchase = purchaseService.getPurchase(10089);

		//==> console Ȯ��
		System.out.println(purchase);
		
		//==> API Ȯ��
		Assert.assertEquals(10000, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user01", purchase.getBuyer().getUserId());
		Assert.assertEquals("2", purchase.getPaymentOption());
		Assert.assertEquals("������", purchase.getReceiverName());
		Assert.assertEquals("��⵵", purchase.getDivyAddr());
		Assert.assertEquals("1", purchase.getTranCode());

		Assert.assertNotNull(purchaseService.getPurchase(10065));
		Assert.assertNotNull(purchaseService.getPurchase(10066));
		
		System.out.println("=======================================");
		
		Assert.assertNotNull(purchaseService.getPurchase2(10001));
		Assert.assertNotNull(purchaseService.getPurchase2(10010));
		
	}
	
	// @Test
	public void testUpdatePurchase() throws Exception {
		
		// insert �� �ش� ��ǰ��ȣ �Է��Ͽ� Ȯ��
		Purchase purchase = purchaseService.getPurchase(10046);
		Assert.assertNotNull(purchase);

		Assert.assertEquals(10010, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user01", purchase.getBuyer().getUserId());
		Assert.assertEquals("SCOTT", purchase.getReceiverName());
		Assert.assertEquals("1", purchase.getPaymentOption());

		purchase.setReceiverName("change");
		purchase.setPaymentOption("2");
		
		purchaseService.updatePurchase(purchase);
		
		// insert �� �ش� ��ǰ��ȣ �Է��Ͽ� Ȯ��
		purchase = purchaseService.getPurchase(10046);
		Assert.assertNotNull(purchase);
		
		//==> console Ȯ��
		System.out.println(purchase);
			
		//==> API Ȯ��
		Assert.assertEquals("change", purchase.getReceiverName());
		Assert.assertEquals("2", purchase.getPaymentOption());
		
		System.out.println("=======================================");
		
		purchase = purchaseService.getPurchase(10065);
		Assert.assertNotNull(purchase);
		
		//==> console Ȯ��
		System.out.println(purchase);
		
		Assert.assertEquals("change", purchase.getReceiverName());
		
	}
	
	// @Test
	public void testRemovePurchase() throws Exception {
		
		purchaseService.removePurchase(10046);
		
		//==> API Ȯ��
		Assert.assertNull(purchaseService.getPurchase(10046));
		
	}
	
	//==> �ּ��� Ǯ�� �����ϸ�....
	// @Test
	public void testGetPurchaseListAById() throws Exception {
		
		Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String, Object> map = purchaseService.getPurchaseList(search, "user06");
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console Ȯ��
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	}
 
}