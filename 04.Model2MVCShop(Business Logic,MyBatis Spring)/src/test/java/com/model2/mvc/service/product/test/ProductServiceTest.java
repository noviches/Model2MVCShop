package com.model2.mvc.service.product.test;

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
import com.model2.mvc.service.product.ProductService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/commonservice.xml"})
public class ProductServiceTest {

	//==> @RunWith, @ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	// @Test
	public void testAddProduct() throws Exception {
		
		Product product = new Product();
		product.setProdName("testProdName");
		product.setProdDetail("testProdDetail");
		product.setPrice(888888);
		
		productService.addProduct(product);
		
		// insert 후 해당 상품번호 입력하여 확인
		product = productService.getProduct(10041);

		//==> console 확인
		System.out.println(product);
		
		//==> API 확인
		Assert.assertEquals("testProdName", product.getProdName());
		Assert.assertEquals("testProdDetail", product.getProdDetail());
		Assert.assertEquals(888888, product.getPrice());
		
	}
	
	// @Test
	public void testGetProduct() throws Exception {
		
		Product product = new Product();
		//==> 필요하다면...
//		product.setProdName("testProdName");
//		product.setProdDetail("testProdDetail");
//		product.setPrice(888888);
//		productService.addProduct(product);
		
		// insert 후 해당 상품번호 입력하여 확인
		product = productService.getProduct(10041);

		//==> console 확인
		System.out.println(product);
		
		//==> API 확인
		Assert.assertEquals(10041, product.getProdNo());
		Assert.assertEquals("testProdName", product.getProdName());
		Assert.assertEquals("testProdDetail", product.getProdDetail());
		Assert.assertEquals(888888, product.getPrice());

		Assert.assertNotNull(productService.getProduct(10001));
		Assert.assertNotNull(productService.getProduct(10002));
		
	}
	
	// @Test
	public void testUpdateProduct() throws Exception {
		
		// insert 후 해당 상품번호 입력하여 확인
		Product product = productService.getProduct(10041);
		Assert.assertNotNull(product);
		
		Assert.assertEquals("testProdName", product.getProdName());
		Assert.assertEquals("testProdDetail", product.getProdDetail());
		Assert.assertEquals(888888, product.getPrice());

		product.setProdName("change");
		product.setProdDetail("change");
		product.setPrice(999999);
		
		productService.updateProduct(product);
		
		// insert 후 해당 상품번호 입력하여 확인
		product = productService.getProduct(10041);
		Assert.assertNotNull(product);
		
		//==> console 확인
		System.out.println(product);
			
		//==> API 확인
		Assert.assertEquals("change", product.getProdName());
		Assert.assertEquals("change", product.getProdDetail());
		Assert.assertEquals(999999, product.getPrice());
		
	}
	
	 //==> 주석을 풀고 실행하면....
	 @Test
	 public void testGetProductListAll() throws Exception {
		
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String, Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
//	 	search.setCurrentPage(1);
//	 	search.setPageSize(3);
//	 	search.setSearchCondition("0");
//	 	search.setSearchKeyword("%좋%");
//	 	map = productService.getProductList(search);
//	 	
//	 	list = (List<Object>)map.get("list");
//	 	Assert.assertEquals(3, list.size());
//	 	
//	 	//==> console 확인
//	 	System.out.println(list);
//	 	
//	 	totalCount = (Integer)map.get("totalCount");
//	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
//	 	search.setCurrentPage(1);
//	 	search.setPageSize(3);
//	 	search.setSearchMin("35");
//	 	search.setSearchMax("65");
//	 	map = productService.getProductList(search);
//	 	
//	 	list = (List<Object>)map.get("list");
//	 	Assert.assertEquals(2, list.size());
//	 	
//	 	//==> console 확인
//	 	System.out.println(list);
//	 	
//	 	totalCount = (Integer)map.get("totalCount");
//	 	System.out.println(totalCount);
	 	
	 }
	 
	 // @Test
	 public void testGetProductListByProductName() throws Exception {
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("%좋%");
	 	Map<String, Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 }
	 
	 // @Test
	 public void testGetProductListByProductDetail() throws Exception {
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword("%좋%");
	 	Map<String, Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 }
 
}