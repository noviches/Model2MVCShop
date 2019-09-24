package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@Controller
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	// setter Method 구현 않음
	
	public PurchaseController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ? : 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ? : 2}")
	int pageSize;
	
	@RequestMapping("/addPurchaseView.do")
	public String addPurchaseView(@RequestParam("prod_no") int prodNo, Model model) throws Exception {
		System.out.println("/addPurchaseView.do");
		
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	@RequestMapping("/addPurchase.do")
	public String addPurchase(@ModelAttribute() Purchase purchase, @RequestParam("prodNo") int prodNo, Model model, HttpSession session) throws Exception {
		System.out.println("/addPurchase.do");
		
		purchase.setBuyer((User)session.getAttribute("user"));
		purchase.setPurchaseProd(productService.getProduct(prodNo));
		purchase.setTranCode("1");
		
		System.out.println(purchase);
		purchaseService.addPurchase(purchase);
		
		return "forward:/purchase/addPurchaseViewResult.jsp";
	}
	
	@RequestMapping("/getPurchase.do")
	public String getPurchase(@RequestParam("tranNo") int tranNo, Model model) throws Exception {
		System.out.println("/getPurchase.do");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchaseView.jsp";
	}
	
	@RequestMapping("/updatePurchaseView.do")
	public String updatePurchaseView(@RequestParam("tranNo") int tranNo, Model model) throws Exception {
		System.out.println("/updatePurchaseView.do");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchaseView.jsp";
	}
	
	@RequestMapping("/updatePurchase.do")
	public String updatePurchase(@ModelAttribute("purchase") Purchase purchase, Model model, HttpSession session) throws Exception {
		System.out.println("/updatePurchase.do");
		
		purchaseService.updatePurchase(purchase);
		purchase = purchaseService.getPurchase(purchase.getTranNo());
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchaseView.jsp";
	}
	
	@RequestMapping("/deletePurchase.do")
	public String deletePurchase(@RequestParam("tranNo") int tranNo, Model model, HttpSession session) throws Exception {
		System.out.println("/deletePurchase.do");
		
		purchaseService.removePurchase(tranNo);
		
		return "forward:/listPurchase.do";
	}
	
	@RequestMapping("/updateTranCodeByProd.do")
	public String updateTranCodeByProd(@RequestParam("prodNo") int prodNo, @RequestParam("tranCode") String tranCode, @RequestParam("menu") String menu, Model model, HttpSession session) throws Exception {
		System.out.println("/updateTranCodeByProd.do");
		
		Purchase purchase = purchaseService.getPurchase2(prodNo);
		
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranCode(purchase);
		
		return "forward:/listProduct.do?menu="+menu;
	}
	
	@RequestMapping("/updateTranCode.do")
	public String updateTranCodeAction(@RequestParam("tranNo") int tranNo, @RequestParam("tranCode") String tranCode, Model model, HttpSession session) throws Exception {
		System.out.println("/updateTranCode.do");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranCode(purchase);
		
		return "forward:/listPurchase.do";
	}
	
	@RequestMapping("/listPurchase.do")
	public String listPurchase(@ModelAttribute("search") Search search, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		System.out.println("/listPurchase.do");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		String buyerId = ((User)session.getAttribute("user")).getUserId();
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/purchase/listPurchase.jsp";
	}
	
}