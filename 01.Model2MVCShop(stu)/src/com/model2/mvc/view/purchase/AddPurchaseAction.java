package com.model2.mvc.view.purchase;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model2.mvc.framework.Action;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.product.vo.ProductVO;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.purchase.vo.PurchaseVO;
import com.model2.mvc.service.user.vo.UserVO;

public class AddPurchaseAction extends Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String prodNo = request.getParameter("prodNo");
		
		HttpSession session = request.getSession(true);
		UserVO userVO = (UserVO)session.getAttribute("user");
		
		ProductService service1 = new ProductServiceImpl();
		ProductVO productVO = service1.getProduct(Integer.parseInt(prodNo));
		
		PurchaseVO purchaseVO = new PurchaseVO();
		purchaseVO.setBuyer(userVO);
		purchaseVO.setDivyAddr(request.getParameter("receiverAddr"));
		purchaseVO.setDivyDate(request.getParameter("receiverDate"));
		purchaseVO.setDivyRequest(request.getParameter("receiverRequest"));
		purchaseVO.setPurchaseProd(productVO);
		purchaseVO.setReceiverName(request.getParameter("receiverName"));
		purchaseVO.setReceiverPhone(request.getParameter("receiverPhone"));
		purchaseVO.setPaymentOption(request.getParameter("paymentOption"));
		purchaseVO.setTranCode("1");
		
		System.out.println("[ AddPurchaseAction ½ÇÇà Áß ]");
		System.out.println(userVO.toString());
		System.out.println(productVO.toString());
		System.out.println(purchaseVO.toString());
			
		PurchaseService service2 = new PurchaseServiceImpl();
		service2.addPurchase(purchaseVO);
		
		request.setAttribute("vo", purchaseVO);
		
		return "forward:/purchase/addPurchaseViewResult.jsp";
	}
	
}