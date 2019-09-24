package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	// setter Method 구현 않음
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ? : 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ? : 2}")
	int pageSize;
	
	@RequestMapping("/addProductView.do")
	// public String addProductView() throws Exception {
	public ModelAndView addProductView() throws Exception {
		System.out.println("/addProductView.do");
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/addProductView.jsp");
		
		// return "redirect:/product/addProductView.jsp";
		return modelAndView;
	}
	
	@RequestMapping("/addProduct.do")
	// public String addProduct(@ModelAttribute("product") Product product) throws Exception {
	public ModelAndView addProduct(@ModelAttribute("product") Product product) throws Exception {
		System.out.println("/addProduct.do");
		
		String[] temp = product.getManuDate().split("-");
		product.setManuDate(temp[0]+temp[1]+temp[2]);
		
		productService.addProduct(product);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/getProduct.jsp");
		
		// return "forward:/product/getProduct.jsp";
		return modelAndView;
	}
	
	@RequestMapping("/getProduct.do")
	// public String getProduct(@RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu, Model model) throws Exception {
	public ModelAndView getProduct(@RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu, Model model,
	HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("/getProduct.do");
		
		Product product = productService.getProduct(prodNo);
		
		Cookie[] cookies = request.getCookies();
		Cookie cookie = null;
		String str = "";
		
		if(cookies != null && cookies.length > 0) {
			for(int i=0; i<cookies.length; i++) {
				Cookie temp = cookies[i];
				
				if(temp.getName().equals("history")) {
					System.out.println("저장되어있는 쿠키값 : "+temp.getValue());
					
					str += cookies[i].getValue()+",";
				}
			}
			str += prodNo;
		}
		cookie = new Cookie("history", str);
		cookie.setMaxAge(30);
		response.addCookie(cookie);
		
		model.addAttribute("product", product);
		
		ModelAndView modelAndView = new ModelAndView();
		
		/*
		if(menu.equals("manage")) {
			return "forward:/product/updateProduct.jsp";
		}else {
			return "forward:/product/getProductDetail.jsp";
		}
		*/
		
		if(menu.equals("manage")) {
			modelAndView.setViewName("/product/updateProduct.jsp");
		}else {
			modelAndView.setViewName("/product/getProductDetail.jsp");
		}
		return modelAndView;
	}
	
	@RequestMapping("/updateProductView.do")
	// public String updateProductView(@RequestParam("prodNo") int prodNo, Model model) throws Exception {
	public ModelAndView updateProductView(@RequestParam("prodNo") int prodNo, Model model) throws Exception {
		System.out.println("/updateProductView.do");
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/updateProduct.jsp");
		
		// return "forward:/product/updateProduct.jsp";
		return modelAndView;
	}
	
	@RequestMapping("/updateProduct.do")
	// public String updateProduct(@ModelAttribute("product") Product product, Model model, HttpSession session) throws Exception {
	public ModelAndView updateProduct(@ModelAttribute("product") Product product, Model model, HttpSession session) throws Exception {
		System.out.println("/updateProduct.do");
		
		productService.updateProduct(product);
		
		model.addAttribute("product", product);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/getProduct.jsp");
		
		// return "forward:/product/getProduct.jsp";
		return modelAndView;
	}
	
	@RequestMapping("/listProduct.do")
	// public String listProduct(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {
	public ModelAndView listProduct(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {
		System.out.println("/listProduct.do");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		if(search.getPageSize() == 0) {
			search.setPageSize(pageSize);
		}
		
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, search.getPageSize());
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/listProduct.jsp");
		
		// return "forward:/product/listProduct.jsp";
		return modelAndView;
	}
	
}