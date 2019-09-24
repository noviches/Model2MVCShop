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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@Controller
@RequestMapping("/purchase/*")
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
	
	// @RequestMapping("/addPurchaseView.do")
	@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public String addPurchase(@RequestParam("prod_no") int prodNo, Model model) throws Exception {
		
		System.out.println("/purchase/addPurchase : GET");
		
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);
		
		return "forward:/purchase/addPurchaseView.jsp";
		
	}
	
	// @RequestMapping("/addPurchase.do")
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public String addPurchase(@ModelAttribute() Purchase purchase, @RequestParam("prodNo") int prodNo, Model model, HttpSession session) throws Exception {
		
		System.out.println("/purchase/addPurchase : POST");
		
		purchase.setBuyer((User)session.getAttribute("user"));
		purchase.setTranCode("1");
		
		Product product = productService.getProduct(prodNo);
		int temp = product.getReQuantity();
		product.setReQuantity(temp-purchase.getQuantity());
		purchase.setPurchaseProd(product);
		
		System.out.println(purchase);
		purchaseService.addPurchase(purchase);
		productService.updateProduct(product);
		
		return "forward:/purchase/addPurchaseViewResult.jsp";
		
	}
	
	// @RequestMapping("/getPurchase.do")
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public String getPurchase(@RequestParam("tranNo") int tranNo, Model model) throws Exception {
		
		System.out.println("/purchase/getPurchase : GET");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchaseView.jsp";
		
	}
	
	// @RequestMapping("/updatePurchaseView.do")
	@RequestMapping(value="updatePurchase", method=RequestMethod.GET)
	public String updatePurchaseView(@RequestParam("tranNo") int tranNo, Model model) throws Exception {
		
		System.out.println("/purchase/updatePurchase : GET");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchaseView.jsp";
		
	}
	
	// @RequestMapping("/updatePurchase.do")
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public String updatePurchase(@ModelAttribute("purchase") Purchase purchase, Model model, HttpSession session) throws Exception {
		
		System.out.println("/purchase/updatePurchase : POST");
		
		purchaseService.updatePurchase(purchase);
		purchase = purchaseService.getPurchase(purchase.getTranNo());
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchaseView.jsp";
		
	}
	
	// @RequestMapping("/deletePurchase.do")
	@RequestMapping(value="deletePurchase", method=RequestMethod.GET)
	public String deletePurchase(@RequestParam("tranNo") int tranNo, @RequestParam("tranCode") String tranCode, Model model, HttpSession session) throws Exception {
		
		System.out.println("/purchase/deletePurchase : GET");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		Product product = productService.getProduct(purchase.getPurchaseProd().getProdNo());
		
		purchase.setTranCode(tranCode);
		
		int temp = product.getReQuantity();
		product.setReQuantity(temp+purchase.getQuantity());
		
		purchaseService.updateTranCode(purchase);
		productService.updateProduct(product);
		
		return "forward:/purchase/listPurchase";
		
	}
	
	// @RequestMapping("/updateTranCodeByProd.do")
	/*
	@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.GET)
	public String updateTranCodeByProd(@RequestParam("prodNo") int prodNo, @RequestParam("tranCode") String tranCode, @RequestParam("menu") String menu, Model model, HttpSession session) throws Exception {
		
		System.out.println("/purchase/updateTranCodeByProd : GET");
		
		Purchase purchase = purchaseService.getPurchase(prodNo);
		
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranCode(purchase);
		
		return "forward:/purchase/listPurchase";
		
	}
	*/
	
	// @RequestMapping("/updateTranCode.do")
	@RequestMapping(value="updateTranCode", method=RequestMethod.GET)
	public String updateTranCodeAction(@RequestParam("tranNo") int tranNo, @RequestParam("tranCode") String tranCode, Model model, HttpSession session) throws Exception {
		
		System.out.println("/purchase/updateTranCode : GET");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranCode(purchase);
		
		return "forward:/purchase/listPurchase";
		
	}
	
	// @RequestMapping("/listPurchase.do")
	@RequestMapping(value="listPurchase")
	public String listPurchase(@ModelAttribute("search") Search search, @RequestParam(value="prodNo", required=false, defaultValue="0") String prodNo, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("/purchase/listPurchase : GET / POST");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		if(! prodNo.equals("0")) {
			search.setSearchKeyword(prodNo);
		}
		
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