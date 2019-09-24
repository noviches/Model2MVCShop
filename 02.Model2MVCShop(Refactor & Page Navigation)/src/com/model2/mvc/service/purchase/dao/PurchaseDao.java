package com.model2.mvc.service.purchase.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.impl.UserServiceImpl;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;

public class PurchaseDao {
	
	///Field
	
	///Constructor
	public PurchaseDao() {
	}

	///Method
	public void insertPurchase(Purchase purchase) throws Exception {
		Connection con = DBUtil.getConnection();

		String sql = "INSERT INTO transaction VALUES (seq_transaction_tran_no.nextval, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE, ?)";
		
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setInt(1, purchase.getPurchaseProd().getProdNo());
		pStmt.setString(2, purchase.getBuyer().getUserId());
		pStmt.setString(3, purchase.getPaymentOption());
		pStmt.setString(4, purchase.getReceiverName());
		pStmt.setString(5, purchase.getReceiverPhone());
		pStmt.setString(6, purchase.getDivyAddr());
		pStmt.setString(7, purchase.getDivyRequest());
		pStmt.setString(8, purchase.getTranCode());
		pStmt.setString(9, purchase.getDivyDate());
		pStmt.executeUpdate();
		
		pStmt.close();
		con.close();
	}
	
	public Purchase findPurchase(int tranNo) throws Exception {
		Connection con = DBUtil.getConnection();

		String sql = "SELECT * FROM transaction WHERE tran_no=?";
		
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setInt(1, tranNo);

		ResultSet rs = pStmt.executeQuery();

		Purchase purchase = null;
		UserService service1 = new UserServiceImpl();
		ProductService service2 = new ProductServiceImpl();
		
		while (rs.next()) {
			User user = service1.getUser(rs.getString("buyer_id"));
			Product product = service2.getProduct(rs.getInt("prod_no"));
			
			purchase = new Purchase();
			purchase.setTranNo(rs.getInt("tran_no"));
			purchase.setBuyer(user);
			purchase.setPurchaseProd(product);
			purchase.setReceiverName(rs.getString("receiver_name"));
			purchase.setReceiverPhone(rs.getString("receiver_phone"));
			purchase.setDivyAddr(rs.getString("demailaddr"));
			purchase.setDivyRequest(rs.getString("dlvy_request"));
			purchase.setTranCode(rs.getString("tran_status_code"));
			purchase.setOrderDate(rs.getDate("order_Data"));
			purchase.setDivyDate(rs.getString("dlvy_date"));
			purchase.setPaymentOption(rs.getString("payment_option").substring(0, 1));
		}
		
		rs.close();
		pStmt.close();
		con.close();

		return purchase;
	}
	
	public Purchase findPurchase2(int prodNo) throws Exception {
		Connection con = DBUtil.getConnection();

		String sql = "SELECT * FROM transaction WHERE prod_no=?";
		
		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setInt(1, prodNo);

		ResultSet rs = pStmt.executeQuery();

		Purchase purchase = null;
		UserService service1 = new UserServiceImpl();
		ProductService service2 = new ProductServiceImpl();
		
		while (rs.next()) {
			User user = service1.getUser(rs.getString("buyer_id"));
			Product product = service2.getProduct(rs.getInt("prod_no"));
			
			purchase = new Purchase();
			purchase.setTranNo(rs.getInt("tran_no"));
			purchase.setBuyer(user);
			purchase.setPurchaseProd(product);
			purchase.setReceiverName(rs.getString("receiver_name"));
			purchase.setReceiverPhone(rs.getString("receiver_phone"));
			purchase.setDivyAddr(rs.getString("demailaddr"));
			purchase.setDivyRequest(rs.getString("dlvy_request"));
			purchase.setTranCode(rs.getString("tran_status_code"));
			purchase.setOrderDate(rs.getDate("order_Data"));
			purchase.setDivyDate(rs.getString("dlvy_date"));
			purchase.setPaymentOption(rs.getString("payment_option").substring(0, 1));
		}
		
		rs.close();
		pStmt.close();
		con.close();

		return purchase;
	}
	
	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		Connection con = DBUtil.getConnection();
		
		// Original Query 구성
		String sql = "SELECT * FROM transaction WHERE buyer_id='"+buyerId+"' ORDER BY tran_no DESC";
		
		System.out.println("PurchaseDAO :: Original SQL :: " + sql);
		
		//==> TotalCount GET
		int totalCount = this.getTotalCount(sql);
		System.out.println("PurchaseDAO :: totalCount :: " + totalCount);
				
		//==> CurrentPage 게시물만 받도록 Query 다시구성
		sql = makeCurrentPageSql(sql, search);
		PreparedStatement pStmt = con.prepareStatement(sql);
		ResultSet rs = pStmt.executeQuery();
			
		System.out.println(search);
		
		List<Purchase> list = new ArrayList<Purchase>();
		
		while(rs.next()) {
			UserService service1 = new UserServiceImpl();
			User user = service1.getUser(rs.getString("buyer_id"));
			
			ProductService service2 = new ProductServiceImpl();
			Product product = service2.getProduct(rs.getInt("prod_no"));
			
			Purchase purchase = new Purchase();
			purchase.setTranNo(rs.getInt("tran_no"));
			purchase.setBuyer(user);
			purchase.setPurchaseProd(product);
			purchase.setPaymentOption(rs.getString("payment_option").substring(0, 1));
			purchase.setReceiverName(rs.getString("receiver_name"));
			purchase.setReceiverPhone(rs.getString("receiver_phone"));
			purchase.setDivyAddr(rs.getString("demailaddr"));
			purchase.setDivyRequest(rs.getString("dlvy_request"));
			purchase.setTranCode(rs.getString("tran_status_code"));
			purchase.setOrderDate(rs.getDate("order_Data"));
			purchase.setDivyDate(rs.getString("dlvy_date"));
			
			list.add(purchase);
		}
		
		//==> totalCount 정보 저장
		map.put("totalCount", new Integer(totalCount));
		//==> currentPage 의 게시물 정보 갖는 List 저장
		map.put("list", list);

		rs.close();
		pStmt.close();
		con.close();

		return map;
	}
	
	public Map<String, Object> getPurchaseList(Search search) throws Exception {
		
		
		
		
		
		return null;
	}
	
	public void updatePurchase(Purchase purchase) throws Exception {
		Connection con = DBUtil.getConnection();

		String sql = "UPDATE transaction SET payment_option=?, receiver_name=?, receiver_phone=?, demailaddr=?, dlvy_request=?, dlvy_date=? WHERE tran_no=?";

		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setString(1, purchase.getPaymentOption());
		pStmt.setString(2, purchase.getReceiverName());
		pStmt.setString(3, purchase.getReceiverPhone());
		pStmt.setString(4, purchase.getDivyAddr());
		pStmt.setString(5, purchase.getDivyRequest());
		pStmt.setString(6, purchase.getDivyDate());
		pStmt.setInt(7, purchase.getTranNo());
		pStmt.executeUpdate();

		pStmt.close();
		con.close();
	}
	
	public void updateTranCode(Purchase purchase) throws Exception {
		Connection con = DBUtil.getConnection();

		String sql = "UPDATE transaction SET tran_status_code=? WHERE tran_no=?";

		PreparedStatement pStmt = con.prepareStatement(sql);
		pStmt.setString(1, purchase.getTranCode());
		pStmt.setInt(2, purchase.getTranNo());
		pStmt.executeUpdate();

		pStmt.close();
		con.close();
	}
	
	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	private int getTotalCount(String sql) throws Exception {
		sql = "SELECT COUNT(*) FROM ( " +sql+ " ) countTable";
		
		Connection con = DBUtil.getConnection();
		PreparedStatement pStmt = con.prepareStatement(sql);
		ResultSet rs = pStmt.executeQuery();
		
		int totalCount = 0;
		
		if(rs.next()){
			totalCount = rs.getInt(1);
		}
		
		pStmt.close();
		con.close();
		rs.close();
		
		return totalCount;
	}
	
	// 게시판 currentPage Row 만  return 
	private String makeCurrentPageSql(String sql, Search search) {
		sql = "SELECT * FROM ( SELECT inner_table.*, ROWNUM AS row_seq FROM ( "+sql+" ) inner_table "
				+"WHERE ROWNUM <="+search.getCurrentPage()*search.getPageSize()+" ) "
				+"WHERE row_seq BETWEEN "+((search.getCurrentPage()-1)*search.getPageSize()+1) +" AND "+search.getCurrentPage()*search.getPageSize();
		
		System.out.println("PurchaseDAO :: make SQL :: "+ sql);	
		
		return sql;
	}
	
}