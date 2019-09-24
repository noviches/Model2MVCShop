package com.model2.mvc.service.product.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.model2.mvc.common.SearchVO;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.product.vo.ProductVO;

public class ProductDAO {
	
	public ProductDAO() {
	}

	public void insertProduct(ProductVO productVO) throws Exception {
		System.out.println("[ ProductDAO - insertProduct 시작 ]");
		
		Connection con = DBUtil.getConnection();

		String sql = "INSERT INTO product VALUES (seq_product_prod_no.nextval, ?, ?, ?, ?, ?, SYSDATE)";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, productVO.getProdName());
		stmt.setString(2, productVO.getProdDetail());
		stmt.setString(3, productVO.getManuDate());
		stmt.setInt(4, productVO.getPrice());
		stmt.setString(5, productVO.getFileName());
		stmt.executeUpdate();
		
		System.out.println("[ ProductDAO - insertProduct 끝 ]");
		
		con.close();
	}
	
	public ProductVO findProduct(int prodNo) throws Exception {
		System.out.println("[ ProductDAO - findProduct 시작 ]");
		
		Connection con = DBUtil.getConnection();

		String sql = "SELECT * FROM product WHERE prod_no=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, prodNo);

		ResultSet rs = stmt.executeQuery();

		ProductVO productVO = null;
		
		while (rs.next()) {
			productVO = new ProductVO();
			productVO.setProdNo(rs.getInt("prod_no"));
			productVO.setProdName(rs.getString("prod_name"));
			productVO.setProdDetail(rs.getString("prod_detail"));
			productVO.setManuDate(rs.getString("manufacture_day"));
			productVO.setPrice(rs.getInt("price"));
			productVO.setFileName(rs.getString("image_file"));
			productVO.setRegDate(rs.getDate("reg_date"));
		}
		
		System.out.println("[ ProductDAO - findProduct 끝 ]");
		
		con.close();

		return productVO;
	}
	
	public HashMap<String, Object> getProductList(SearchVO searchVO) throws Exception {
		System.out.println("[ ProductDAO - getProductList 시작 ]");
		
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT p.*, t.tran_status_code FROM product p, transaction t WHERE ";
		if (searchVO.getSearchCondition() != null) {
			if (searchVO.getSearchCondition().equals("0")) {
				sql += "p.prod_no='" + searchVO.getSearchKeyword() + "' AND ";
			} else if (searchVO.getSearchCondition().equals("1")) {
				sql += "p.prod_name LIKE '%" + searchVO.getSearchKeyword() + "%' AND ";
			} else if (searchVO.getSearchCondition().equals("2")) {
				sql += "p.price='" + searchVO.getSearchKeyword() + "' AND ";
			}
		}
		sql += "p.prod_no = t.prod_no(+) ORDER BY p.prod_no DESC";

		PreparedStatement stmt = con.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
		ResultSet rs = stmt.executeQuery();

		rs.last();
		int total = rs.getRow();
		System.out.println("ROW 의 수 : " + total);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("count", new Integer(total));

		rs.absolute(searchVO.getPage() * searchVO.getPageUnit() - searchVO.getPageUnit()+1);
		System.out.println("searchVO.getPage() : " + searchVO.getPage());
		System.out.println("searchVO.getPageUnit() : " + searchVO.getPageUnit());

		ArrayList<ProductVO> list = new ArrayList<ProductVO>();
		
		System.out.println("[ ProductDAO - getProductList 실행중 ]");
		
		if(total > 0) {
			for(int i=0; i<searchVO.getPageUnit(); i++) {
				ProductVO vo = new ProductVO();
				vo.setProdNo(rs.getInt("prod_no"));
				vo.setProdName(rs.getString("prod_name"));
				vo.setProdDetail(rs.getString("prod_detail"));
				vo.setManuDate(rs.getString("manufacture_day"));
				vo.setPrice(rs.getInt("price"));
				vo.setFileName(rs.getString("image_file"));
				vo.setRegDate(rs.getDate("reg_date"));
				vo.setProTranCode(rs.getString("tran_status_code"));
				
				list.add(vo);
				
				System.out.println(vo.toString());
				
				if (!rs.next())
					break;
			}
		}
		System.out.println("list.size() : " + list.size());
		map.put("list", list);
		System.out.println("map().size() : " + map.size());

		System.out.println("[ ProductDAO - getProductList 끝 ]");
		
		con.close();
			
		return map;
	}
	
	public void updateProduct(ProductVO productVO) throws Exception {
		System.out.println("[ ProductDAO - updateProduct 시작 ]");
		
		Connection con = DBUtil.getConnection();

		String sql = "UPDATE product SET prod_name=?, prod_detail=?, manufacture_day=?, price=? WHERE prod_no=?";

		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, productVO.getProdName());
		stmt.setString(2, productVO.getProdDetail());
		stmt.setString(3, productVO.getManuDate());
		stmt.setInt(4, productVO.getPrice());
		stmt.setInt(5, productVO.getProdNo());
		stmt.executeUpdate();

		System.out.println("[ ProductDAO - updateProduct 끝 ]");
		
		con.close();
	}
	
}