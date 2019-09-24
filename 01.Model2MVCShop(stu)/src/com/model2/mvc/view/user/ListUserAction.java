package com.model2.mvc.view.user;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.common.SearchVO;
import com.model2.mvc.framework.Action;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.impl.UserServiceImpl;

public class ListUserAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("[ ListUserAction Ω√¿€ ]");
		
		SearchVO searchVO = new SearchVO();
		
		int page = 1;
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
			
		searchVO.setPage(page);
		searchVO.setSearchCondition(request.getParameter("searchCondition"));
		
		if(request.getMethod().equals("GET") && request.getParameter("searchKeyword") != null) {
			searchVO.setSearchKeyword(this.convertKo(request.getParameter("searchKeyword")));
		}else {
			searchVO.setSearchKeyword(request.getParameter("searchKeyword"));
		}
		
		String pageUnit = getServletContext().getInitParameter("pageSize");
		searchVO.setPageUnit(Integer.parseInt(pageUnit));
		
		UserService service = new UserServiceImpl();
		HashMap<String, Object> map = service.getUserList(searchVO);

		System.out.println("[ ListUserAction ≥° ]");
		
		request.setAttribute("map", map);
		request.setAttribute("searchVO", searchVO);
		
		return "forward:/user/listUser.jsp";
	}
	
	private String convertKo(String searchKeyword) {
		String temp = null;
		
		try {
			byte[] b = searchKeyword.getBytes("8859_1");
			temp = new String(b, "EUC_KR");
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return temp;
	}
	
}