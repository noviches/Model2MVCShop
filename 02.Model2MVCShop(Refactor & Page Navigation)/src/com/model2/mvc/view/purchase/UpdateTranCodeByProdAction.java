package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;

public class UpdateTranCodeByProdAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int prodNo = Integer.parseInt(request.getParameter("prodNo"));
		String menu = request.getParameter("menu");
		
		PurchaseService service = new PurchaseServiceImpl();
		
		Purchase purchase = service.getPurchase2(prodNo);
		
		purchase.setTranCode(request.getParameter("tranCode"));
		
		service.updateTranCode(purchase);
		
		System.out.println("UpadateTranCodeByProdAction :: "+purchase);
		
		return "forward:/listProduct.do?menu="+menu;
	}
	
}