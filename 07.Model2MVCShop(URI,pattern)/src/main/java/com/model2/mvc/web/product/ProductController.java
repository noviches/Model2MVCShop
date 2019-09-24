package com.model2.mvc.web.product;

import java.io.FileOutputStream;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
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
	
	// @RequestMapping("/addProductView.do")
	// public String addProductView() throws Exception {
	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public ModelAndView addProduct() throws Exception {
		
		System.out.println("/product/addProduct : GET");
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/addProductView.jsp");
		
		// return "redirect:/product/addProductView.jsp";
		return modelAndView;
		
	}
	
	// @RequestMapping("/addProduct.do")
	// public String addProduct(@ModelAttribute("product") Product product) throws Exception {
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public ModelAndView addProduct(@ModelAttribute("product") Product product, @RequestParam("file") MultipartFile file, HttpServletRequest request, Model model) throws Exception {
		
		System.out.println("/product/addProduct : POST");
		
		/////////////////////////////// 파일 업로드 ///////////////////////////////
		String savePath = "C:\\Users\\USER\\git\\07\\07.Model2MVCShop(URI,pattern)\\WebContent\\images\\uploadFiles";
		
		String originalFilename = file.getOriginalFilename(); // 파일이름.확장명
		product.setFileName(originalFilename);
		String fullPath = savePath + "\\" + originalFilename;
		
		if(!file.isEmpty()) {
			byte[] bytes = file.getBytes();
			FileOutputStream fos = new FileOutputStream(fullPath);
			fos.write(bytes);
			
			// [다른 방법]
			// File files = new File(fullPath);
			// file.transferTo(files); 
		}
		/////////////////////////////// 파일 업로드 ///////////////////////////////

		String[] temp = product.getManuDate().split("-");
		product.setManuDate(temp[0]+temp[1]+temp[2]);
		
		System.out.println(product);
		productService.addProduct(product);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/getProduct.jsp");
		
		// return "forward:/product/getProduct.jsp";
		return modelAndView;
		
	}
	
	// @RequestMapping("/getProduct.do")
	// public String getProduct(@RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu, Model model) throws Exception {
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public ModelAndView getProduct(@RequestParam("prodNo") String prodNo, @RequestParam("menu") String menu, Model model,
	HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		
		Product product = productService.getProduct(Integer.parseInt(prodNo));
		
		Cookie[] cookies = request.getCookies();
		String str = "";
		
		if(cookies != null && cookies.length > 0) {
			boolean temp = true;
			
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("history")) {
					temp = false;
					
					System.out.println("저장되어있는 쿠키값 : "+cookies[i].getValue());
					
					str += cookies[i].getValue()+",";
					
					if(cookies[i].getValue().indexOf(prodNo) == -1) {
						temp = true;
					}
				}
			}
			if(temp) {
				str += prodNo;
			}
		}
		Cookie cookie = new Cookie("history", str);
		cookie.setMaxAge(30);
		cookie.setPath("/");
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
	
	// @RequestMapping("/updateProductView.do")
	// public String updateProductView(@RequestParam("prodNo") int prodNo, Model model) throws Exception {
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public ModelAndView updateProductView(@RequestParam("prodNo") int prodNo, Model model) throws Exception {
		
		System.out.println("/product/updateProduct : GET");
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/updateProduct.jsp");
		
		// return "forward:/product/updateProduct.jsp";
		return modelAndView;
		
	}
	
	// @RequestMapping("/updateProduct.do")
	// public String updateProduct(@ModelAttribute("product") Product product, Model model, HttpSession session) throws Exception {
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public ModelAndView updateProduct(@ModelAttribute("product") Product product, Model model, HttpSession session) throws Exception {
		
		System.out.println("/product/updateProduct : POST");
		
		productService.updateProduct(product);
		
		model.addAttribute("product", product);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/getProduct.jsp");
		
		// return "forward:/product/getProduct.jsp";
		return modelAndView;
		
	}
	
	// @RequestMapping("/listProduct.do")
	// public String listProduct(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {
	@RequestMapping(value="listProduct")
	public ModelAndView listProduct(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {
		
		System.out.println("/product/listProduct : GET / POST");
		
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