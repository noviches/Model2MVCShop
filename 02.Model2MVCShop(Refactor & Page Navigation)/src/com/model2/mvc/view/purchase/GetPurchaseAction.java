package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;

public class GetPurchaseAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String tranNo = request.getParameter("tranNo");
		
		PurchaseService service = new PurchaseServiceImpl();
		Purchase purchase = service.getPurchase(Integer.parseInt(tranNo));
		
		System.out.println("GetPurchaseAction :: "+purchase);
		
		request.setAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchaseView.jsp";
	}
	
}