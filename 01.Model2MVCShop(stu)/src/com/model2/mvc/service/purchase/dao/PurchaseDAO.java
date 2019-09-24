package com.model2.mvc.service.purchase.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.model2.mvc.common.SearchVO;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.product.vo.ProductVO;
import com.model2.mvc.service.purchase.vo.PurchaseVO;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.impl.UserServiceImpl;
import com.model2.mvc.service.user.vo.UserVO;

public class PurchaseDAO {
	
	public PurchaseDAO() {
	}

	public void insertPurchase(PurchaseVO purchaseVO) throws Exception {
		System.out.println("[ PurchaseDAO - insertPurchase 시작 ]");
		
		Connection con = DBUtil.getConnection();

		String sql = "INSERT INTO transaction VALUES (seq_transaction_tran_no.nextval, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, ?)";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, purchaseVO.getPurchaseProd().getProdNo());
		stmt.setString(2, purchaseVO.getBuyer().getUserId());
		stmt.setString(3, purchaseVO.getPaymentOption());
		stmt.setString(4, purchaseVO.getReceiverName());
		stmt.setString(5, purchaseVO.getReceiverPhone());
		stmt.setString(6, purchaseVO.getDivyAddr());
		stmt.setString(7, purchaseVO.getDivyRequest());
		stmt.setString(8, purchaseVO.getTranCode());
		stmt.setString(9, purchaseVO.getDivyDate());
		stmt.executeUpdate();
		
		System.out.println("[ PurchaseDAO - insertPurchase 끝 ]");
		
		con.close();
	}
	
	public PurchaseVO findPurchase(int tranNo) throws Exception {
		System.out.println("[ PurchaseDAO - findPurchase 시작 ]");
		
		Connection con = DBUtil.getConnection();

		String sql = "SELECT * FROM transaction WHERE tran_no=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, tranNo);

		ResultSet rs = stmt.executeQuery();

		PurchaseVO purchaseVO = null;
		UserService service1 = new UserServiceImpl();
		ProductService service2 = new ProductServiceImpl();
		
		while (rs.next()) {
			UserVO userVO = service1.getUser(rs.getString("buyer_id"));
			ProductVO productVO = service2.getProduct(rs.getInt("prod_no"));
			
			purchaseVO = new PurchaseVO();
			purchaseVO.setTranNo(rs.getInt("tran_no"));
			purchaseVO.setPurchaseProd(productVO);
			purchaseVO.setBuyer(userVO);
			purchaseVO.setReceiverName(rs.getString("receiver_name"));
			purchaseVO.setReceiverPhone(rs.getString("receiver_phone"));
			purchaseVO.setDivyAddr(rs.getString("demailaddr"));
			purchaseVO.setDivyRequest(rs.getString("dlvy_request"));
			purchaseVO.setTranCode(rs.getString("tran_status_code"));
			purchaseVO.setOrderDate(rs.getDate("order_Data"));
			purchaseVO.setDivyDate(rs.getString("dlvy_date"));
			purchaseVO.setPaymentOption(rs.getString("payment_option"));
		}
		
		System.out.println("[ PurchaseDAO - findPurchase 끝 ]");
		
		con.close();

		return purchaseVO;
	}
	
	public PurchaseVO findPurchase2(int prodNo) throws Exception {
		System.out.println("[ PurchaseDAO - findPurchase 시작 ]");
		
		Connection con = DBUtil.getConnection();

		String sql = "SELECT * FROM transaction WHERE prod_no=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, prodNo);

		ResultSet rs = stmt.executeQuery();

		PurchaseVO purchaseVO = null;
		UserService service1 = new UserServiceImpl();
		ProductService service2 = new ProductServiceImpl();
		
		while (rs.next()) {
			UserVO userVO = service1.getUser(rs.getString("buyer_id"));
			ProductVO productVO = service2.getProduct(rs.getInt("prod_no"));
			
			purchaseVO = new PurchaseVO();
			purchaseVO.setTranNo(rs.getInt("tran_no"));
			purchaseVO.setPurchaseProd(productVO);
			purchaseVO.setBuyer(userVO);
			purchaseVO.setReceiverName(rs.getString("receiver_name"));
			purchaseVO.setReceiverPhone(rs.getString("receiver_phone"));
			purchaseVO.setDivyAddr(rs.getString("demailaddr"));
			purchaseVO.setDivyRequest(rs.getString("dlvy_request"));
			purchaseVO.setTranCode(rs.getString("tran_status_code"));
			purchaseVO.setOrderDate(rs.getDate("order_Data"));
			purchaseVO.setDivyDate(rs.getString("dlvy_date"));
			purchaseVO.setPaymentOption(rs.getString("payment_option"));
		}
		
		System.out.println("[ PurchaseDAO - findPurchase 끝 ]");
		
		con.close();

		return purchaseVO;
	}
	
	public HashMap<String, Object> getPurchaseList(SearchVO searchVO, String buyerId) throws Exception {
		System.out.println("[ PurchaseDAO - getPurchaseList 시작 ]");
		
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT * FROM transaction WHERE buyer_id='"+buyerId+"' ORDER BY tran_no DESC";

		PreparedStatement stmt = 
				con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		ResultSet rs = stmt.executeQuery();

		rs.last();
		int total = rs.getRow();
		System.out.println("ROW 의 수 : " + total);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("count", new Integer(total));

		rs.absolute(searchVO.getPage() * searchVO.getPageUnit() - searchVO.getPageUnit()+1);
		System.out.println("searchVO.getPage() : " + searchVO.getPage());
		System.out.println("searchVO.getPageUnit() : " + searchVO.getPageUnit());

		ArrayList<PurchaseVO> list = new ArrayList<PurchaseVO>();
		
		System.out.println("[ PurchaseDAO - getPurchaseList 실행중 ]");
		
		if(total > 0) {
			for(int i=0; i<searchVO.getPageUnit(); i++) {
				UserService service1 = new UserServiceImpl();
				UserVO userVO = service1.getUser(rs.getString("buyer_id"));
				
				ProductService service2 = new ProductServiceImpl();
				ProductVO productVO = service2.getProduct(rs.getInt("prod_no"));
				
				PurchaseVO vo = new PurchaseVO();
				vo.setTranNo(rs.getInt("tran_no"));
				vo.setPurchaseProd(productVO);
				vo.setBuyer(userVO);
				vo.setPaymentOption(rs.getString("payment_option"));
				vo.setReceiverName(rs.getString("receiver_name"));
				vo.setReceiverPhone(rs.getString("receiver_phone"));
				vo.setDivyAddr(rs.getString("demailaddr"));
				vo.setDivyRequest(rs.getString("dlvy_request"));
				vo.setTranCode(rs.getString("tran_status_code"));
				vo.setOrderDate(rs.getDate("order_Data"));
				vo.setDivyDate(rs.getString("dlvy_date"));
				
				list.add(vo);
				
				System.out.println(vo.toString());
				
				if (!rs.next())
					break;
			}
		}
		System.out.println("list.size() : " + list.size());
		map.put("list", list);
		System.out.println("map().size() : " + map.size());

		System.out.println("[ PurchaseDAO - getPurchaseList 끝 ]");
		
		con.close();
			
		return map;
	}
	
	public HashMap<String, Object> getPurchaseList(SearchVO searchVO) throws Exception {
		
		
		
		
		
		return null;
	}
	
	public void updatePurchase(PurchaseVO purchaseVO) throws Exception {
		System.out.println("[ PurchaseDAO - updatePurchase 시작 ]");
		
		Connection con = DBUtil.getConnection();

		String sql = "UPDATE transaction SET payment_option=?, receiver_name=?, receiver_phone=?, demailaddr=?, dlvy_request=?, dlvy_date=? WHERE tran_no=?";

		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, purchaseVO.getPaymentOption());
		stmt.setString(2, purchaseVO.getReceiverName());
		stmt.setString(3, purchaseVO.getReceiverPhone());
		stmt.setString(4, purchaseVO.getDivyAddr());
		stmt.setString(5, purchaseVO.getDivyRequest());
		stmt.setString(6, purchaseVO.getDivyDate());
		stmt.setInt(7, purchaseVO.getTranNo());
		stmt.executeUpdate();

		System.out.println("[ PurchaseDAO - updatePurchase 끝 ]");
		
		con.close();
	}
	
	public void updateTranCode(PurchaseVO purchaseVO) throws Exception {
		System.out.println("[ PurchaseDAO - updateTranCode 시작 ]");
		
		Connection con = DBUtil.getConnection();

		String sql = "UPDATE transaction SET tran_status_code=? WHERE tran_no=?";

		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, purchaseVO.getTranCode());
		stmt.setInt(2, purchaseVO.getTranNo());
		stmt.executeUpdate();

		System.out.println("[ PurchaseDAO - updateTranCode 끝 ]");
		
		con.close();
	}
	
}