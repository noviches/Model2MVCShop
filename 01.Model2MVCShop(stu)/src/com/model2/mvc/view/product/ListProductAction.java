package com.model2.mvc.view.product;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.common.SearchVO;
import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;

public class ListProductAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("[ ListProductAction Ω√¿€ ]");
		
		SearchVO searchVO = new SearchVO();
		
		int page = 1;
		
		if(request.getParameter("page") != null && request.getMethod().equals("GET"))
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
		
		ProductService service = new ProductServiceImpl();
		HashMap<String, Object> map = service.getProductList(searchVO);

		System.out.println("[ ListProductAction ≥° ]");
		
		request.setAttribute("map", map);
		request.setAttribute("searchVO", searchVO);
		
		return "forward:/product/listProduct.jsp";
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