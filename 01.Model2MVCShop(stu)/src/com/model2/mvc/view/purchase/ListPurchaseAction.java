package com.model2.mvc.view.purchase;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.common.SearchVO;
import com.model2.mvc.framework.Action;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.user.vo.UserVO;

public class ListPurchaseAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("[ ListPurchaseAction 시작 ]");
		
		SearchVO searchVO = new SearchVO();
		
		int page = 1;
		
		if(request.getParameter("page") != null)
			page = Integer.parseInt(request.getParameter("page"));
		
		searchVO.setPage(page);
		searchVO.setSearchCondition(request.getParameter("searchCondition"));
		
		if(request.getMethod().equals("GET") && request.getParameter("searchKeyword") != null) {
			searchVO.setSearchKeyword(this.convertKo(request.getParameter("searchKeyword")));
		}else {
			searchVO.setSearchKeyword(request.getParameter("searchKeyword"));
		}
		
		String pageUnit = getServletContext().getInitParameter("pageSize");
		searchVO.setPageUnit(Integer.parseInt(pageUnit));
		
		HttpSession session = request.getSession(true);
		UserVO userVO = (UserVO)session.getAttribute("user");
		
		System.out.println("[ ListPurchaseAction 실행 중 ]");
		System.out.println(userVO.toString());
		
		PurchaseService service = new PurchaseServiceImpl();
		HashMap<String, Object> map = service.getPurchaseList(searchVO, userVO.getUserId());

		System.out.println("[ ListPurchaseAction 끝 ]");
		
		request.setAttribute("map", map);
		request.setAttribute("searchVO", searchVO);
		
		return "forward:/purchase/listPurchase.jsp";
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