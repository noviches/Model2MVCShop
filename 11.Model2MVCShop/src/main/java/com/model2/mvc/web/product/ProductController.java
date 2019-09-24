package com.model2.mvc.web.product;

import java.io.File;
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
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.review.ReviewService;
import com.model2.mvc.web.review.ReviewController;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	// setter Method 구현 않음
	
	public ProductController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Value("#{commonProperties['savePath']}")
	String savePath;
	
	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public ModelAndView addProduct() throws Exception {
		
		System.out.println("/product/addProduct : GET");
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/addProductView.jsp");
		
		return modelAndView;
		
	}
	
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public ModelAndView addProduct(@ModelAttribute("product") Product product, @RequestParam(value="fileTitle", required=false) MultipartFile fileTitle,
	@RequestParam(value="file", required=false) MultipartFile[] files, HttpServletRequest request) throws Exception {
		
		System.out.println("/product/addProduct : POST");
		
		/////////////////////////////// 파일 업로드 ///////////////////////////////
		if(!fileTitle.isEmpty() && fileTitle != null) {
		    String thumnailName = fileTitle.getOriginalFilename(); // 파일이름.확장명
		    
		    fileTitle.transferTo(new File(savePath+"\\thumbnail\\"+thumnailName));
		    
		    product.setThumbnail(thumnailName);
		}
		
		if(files.length > 1) {
			String str = "";
			int index = 0;
			
			for(MultipartFile uploadedFile : files) {
				String fileName = uploadedFile.getOriginalFilename();
				str += fileName;
				
				if(index != files.length) {
					str += ",";
				}
				
				uploadedFile.transferTo(new File(savePath+"\\"+fileName));
				index++;
	        }
			product.setFileName(str);
		}
		/////////////////////////////// 파일 업로드 ///////////////////////////////

		String[] temp = product.getManuDate().split("-");
		product.setManuDate(temp[0]+temp[1]+temp[2]);
		
		System.out.println(product);
		productService.addProduct(product);
		
		ModelAndView modelAndView = new ModelAndView();
		
		if(product.getFileName() != null && product.getFileName() != "") {
			String[] fileArray = product.getFileName().split(",");
			
			modelAndView.addObject("files", fileArray);
		}
		
		modelAndView.setViewName("/product/getProduct.jsp");
		
		return modelAndView;
		
	}
	
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public ModelAndView getProduct(@RequestParam("prodNo") String prodNo, @RequestParam("menu") String menu,
	HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		
		Product product = productService.getProduct(Integer.parseInt(prodNo));
		
		/////////////////////////////// 쿠키 저장 ///////////////////////////////
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
		cookie.setMaxAge(60*60);
		cookie.setPath("/");
		
		response.addCookie(cookie);
		/////////////////////////////// 쿠키 저장 ///////////////////////////////
		
		ModelAndView modelAndView = new ModelAndView();
		
		int temp = product.getHits()+1;
		product.setHits(temp);
		productService.updateHits(product);
		
		if(product.getFileName() != null && product.getFileName() != "") {
			String[] fileArray = product.getFileName().split(",");
			
			modelAndView.addObject("files", fileArray);
		}
		modelAndView.addObject("product", product);
		
		/////////////////////////////// 상품 리뷰 ///////////////////////////////
		Search search = new Search();
		search.setSearchKeyword(prodNo);
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		
		Map<String, Object> map = reviewService.getReviewList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		/////////////////////////////// 상품 리뷰 ///////////////////////////////
		
		if(menu.equals("manage")) {
			modelAndView.setViewName("/product/updateProduct.jsp");
		}else {
			modelAndView.setViewName("/product/getProductDetail.jsp");
		}
		return modelAndView;
		
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public ModelAndView updateProduct(@RequestParam("prodNo") int prodNo) throws Exception {
		
		System.out.println("/product/updateProduct : GET");
		
		Product product = productService.getProduct(prodNo);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("product", product);
		modelAndView.setViewName("/product/updateProduct.jsp");
		
		return modelAndView;
		
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public ModelAndView updateProduct(@ModelAttribute("product") Product product, @RequestParam(value="fileTitle", required=false) MultipartFile fileTitle,
	@RequestParam(value="file", required=false) MultipartFile[] files, HttpSession session) throws Exception {
		
		System.out.println("/product/updateProduct : POST");
		
		/////////////////////////////// 파일 업로드 ///////////////////////////////
		if(!fileTitle.isEmpty() && fileTitle != null) {
			String thumnailName = fileTitle.getOriginalFilename(); // 파일이름.확장명
			
			fileTitle.transferTo(new File(savePath+"\\thumbnail\\"+thumnailName));
			
			product.setThumbnail(thumnailName);
		}
		
		if(files.length > 1) {
			String str = "";
			int index = 0;
			
			for(MultipartFile uploadedFile : files) {
				String fileName = uploadedFile.getOriginalFilename();
				str += fileName;
				
				if(index != files.length) {
					str += ",";
				}
				
				uploadedFile.transferTo(new File(savePath+"\\"+fileName));
				index++;
			}
			product.setFileName(str);
		}
		/////////////////////////////// 파일 업로드 ///////////////////////////////
		
		ModelAndView modelAndView = new ModelAndView();
		
		if(product.getManuDate().indexOf("-") != -1) {
			String[] temp = product.getManuDate().split("-");
			product.setManuDate(temp[0]+temp[1]+temp[2]);
		}
		
		productService.updateProduct(product);
		
		Product dbProduct = productService.getProduct(product.getProdNo());
		
		if(dbProduct.getFileName() != null && dbProduct.getFileName() != "") {
			String[] fileArray = dbProduct.getFileName().split(",");
			
			modelAndView.addObject("files", fileArray);
		}
		modelAndView.addObject("product", dbProduct);
		modelAndView.setViewName("/product/getProduct.jsp");
		
		return modelAndView;
		
	}
	
	@RequestMapping(value="listProduct")
	public ModelAndView listProduct(@ModelAttribute("search") Search search, HttpServletRequest request) throws Exception {
		
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
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("/product/listProduct.jsp");
		
		return modelAndView;
		
	}
	
}