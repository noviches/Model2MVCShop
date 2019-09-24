package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;

public class AddPurchaseAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String prodNo = request.getParameter("prodNo");
		
		HttpSession session = request.getSession(true);
		User user = (User)session.getAttribute("user");
		
		ProductService service1 = new ProductServiceImpl();
		Product product = service1.getProduct(Integer.parseInt(prodNo));
		
		Purchase purchase = new Purchase();
		purchase.setBuyer(user);
		purchase.setDivyAddr(request.getParameter("receiverAddr"));
		purchase.setDivyDate(request.getParameter("receiverDate"));
		purchase.setDivyRequest(request.getParameter("receiverRequest"));
		purchase.setPurchaseProd(product);
		purchase.setReceiverName(request.getParameter("receiverName"));
		purchase.setReceiverPhone(request.getParameter("receiverPhone"));
		purchase.setPaymentOption(request.getParameter("paymentOption"));
		purchase.setTranCode("1");
			
		PurchaseService service2 = new PurchaseServiceImpl();
		service2.addPurchase(purchase);
		
		System.out.println("AddPurchaseAction :: "+purchase);
		
		request.setAttribute("purchase", purchase);
		
		return "forward:/purchase/addPurchaseViewResult.jsp";
	}
	
}