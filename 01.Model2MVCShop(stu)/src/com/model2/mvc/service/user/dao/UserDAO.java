package com.model2.mvc.service.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import com.model2.mvc.common.SearchVO;
import com.model2.mvc.common.util.DBUtil;
import com.model2.mvc.service.user.vo.UserVO;

public class UserDAO {
	
	public UserDAO() {
	}

	public void insertUser(UserVO userVO) throws Exception {
		System.out.println("[ UserDAO - insertUser 시작 ]");
		
		Connection con = DBUtil.getConnection();

		String sql = "INSERT INTO users VALUES (?, ?, ?, 'user', ?, ?, ?, ?, SYSTATE)";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, userVO.getUserId());
		stmt.setString(2, userVO.getUserName());
		stmt.setString(3, userVO.getPassword());
		stmt.setString(4, userVO.getSsn());
		stmt.setString(5, userVO.getPhone());
		stmt.setString(6, userVO.getAddr());
		stmt.setString(7, userVO.getEmail());
		stmt.executeUpdate();
		
		System.out.println("[ UserDAO - insertUser 끝 ]");
		
		con.close();
	}

	public UserVO findUser(String userId) throws Exception {
		System.out.println("[ UserDAO - findUser 시작 ]");
		
		Connection con = DBUtil.getConnection();

		String sql = "SELECT * FROM users WHERE user_id=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, userId);

		ResultSet rs = stmt.executeQuery();

		UserVO userVO = null;
		
		while (rs.next()) {
			userVO = new UserVO();
			userVO.setUserId(rs.getString("user_id"));
			userVO.setUserName(rs.getString("user_name"));
			userVO.setPassword(rs.getString("password"));
			userVO.setRole(rs.getString("role"));
			userVO.setSsn(rs.getString("ssn"));
			userVO.setPhone(rs.getString("cell_phone"));
			userVO.setAddr(rs.getString("addr"));
			userVO.setEmail(rs.getString("email"));
			userVO.setRegDate(rs.getDate("reg_date"));
		}
		
		System.out.println("[ UserDAO - findUser 끝 ]");
		
		con.close();

		return userVO;
	}

	public HashMap<String, Object> getUserList(SearchVO searchVO) throws Exception {
		System.out.println("[ UserDAO - getUserList 시작 ]");
		
		Connection con = DBUtil.getConnection();
		
		String sql = "SELECT * FROM users ";
		if (searchVO.getSearchCondition() != null) {
			if (searchVO.getSearchCondition().equals("0")) {
				sql += "WHERE UPPER(user_id) LIKE UPPER( '%" + searchVO.getSearchKeyword() + "%' )";
			} else if (searchVO.getSearchCondition().equals("1")) {
				sql += "WHERE UPPER(user_name) LIKE UPPER( '%" + searchVO.getSearchKeyword() + "%' )";
			}
		}
		sql += " ORDER BY user_id";

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

		ArrayList<UserVO> list = new ArrayList<UserVO>();
		
		if(total > 0) {
			for(int i=0; i<searchVO.getPageUnit(); i++) {
				UserVO vo = new UserVO();
				vo.setUserId(rs.getString("user_id"));
				vo.setUserName(rs.getString("user_name"));
				vo.setPassword(rs.getString("password"));
				vo.setRole(rs.getString("role"));
				vo.setSsn(rs.getString("ssn"));
				vo.setPhone(rs.getString("cell_phone"));
				vo.setAddr(rs.getString("addr"));
				vo.setEmail(rs.getString("email"));
				vo.setRegDate(rs.getDate("reg_date"));

				list.add(vo);
				
				if (!rs.next())
					break;
			}
		}
		System.out.println("list.size() : " + list.size());
		map.put("list", list);
		System.out.println("map().size() : " + map.size());

		System.out.println("[ UserDAO - getUserList 끝 ]");
		
		con.close();
			
		return map;
	}

	public void updateUser(UserVO userVO) throws Exception {
		System.out.println("[ UserDAO - updateUser 시작 ]");
		
		Connection con = DBUtil.getConnection();

		String sql = "UPDATE users SET user_name=?, cell_phone=?, addr=?, email=? WHERE user_id=?";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, userVO.getUserName());
		stmt.setString(2, userVO.getPhone());
		stmt.setString(3, userVO.getAddr());
		stmt.setString(4, userVO.getEmail());
		stmt.setString(5, userVO.getUserId());
		stmt.executeUpdate();
		
		System.out.println("[ UserDAO - updateUser 끝 ]");
		
		con.close();
	}
}