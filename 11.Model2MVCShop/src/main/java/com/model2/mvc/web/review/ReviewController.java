package com.model2.mvc.web.review;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.transaction.Transaction;
import org.omg.IOP.TransactionService;
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
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.review.ReviewService;

@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	///Field
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	// setter Method 구현 않음
	
	public ReviewController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Value("#{commonProperties['savePath']}")
	String savePath;
	
	@RequestMapping(value="addReview", method=RequestMethod.GET)
	public ModelAndView addReview(@RequestParam("tranNo") int tranNo) throws Exception {
		
		System.out.println("/review/addReview : GET");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		Product product = productService.getProduct(purchase.getPurchaseProd().getProdNo());
		purchase.setPurchaseProd(product);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("purchase", purchase);
		modelAndView.setViewName("/review/addReviewView.jsp");
		
		return modelAndView;
		
	}
	
	@RequestMapping(value="addReview", method=RequestMethod.POST)
	public ModelAndView addReview(@ModelAttribute("review") Review review, @RequestParam("tranNo") int tranNo,
	@RequestParam(value="file", required=false) MultipartFile file) throws Exception {
		
		System.out.println("/review/addReview : POST");
		
		review.setTrans(purchaseService.getPurchase(tranNo));
		
		/////////////////////////////// 파일 업로드 ///////////////////////////////
		if(!file.isEmpty() && file != null) {
		    String fileName = file.getOriginalFilename(); // 파일이름.확장명
		    
		    file.transferTo(new File(savePath+"\\review\\"+fileName));
		    
		    review.setReviewImg(fileName);
		}
		/////////////////////////////// 파일 업로드 ///////////////////////////////
		
		reviewService.addReview(review);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("/review/getReview.jsp");
		
		return modelAndView;
		
	}
	
	@RequestMapping(value="getReview", method=RequestMethod.GET)
	public ModelAndView getReview(@RequestParam("tranNo") int tranNo) throws Exception {
		
		System.out.println("/review/getReview : GET");
		
		Review review = reviewService.getReview2(tranNo);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("review", review);		
		modelAndView.setViewName("/review/getReview.jsp");
		
		return modelAndView;

	}
	
	@RequestMapping(value="updateReview", method=RequestMethod.GET)
	public ModelAndView updateReview(@RequestParam("reviewNo") int reviewNo) throws Exception {
		
		System.out.println("/review/updateReview : GET");
		
		Review review = reviewService.getReview(reviewNo);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("review", review);
		modelAndView.setViewName("/review/updateReview.jsp");
		
		return modelAndView;
		
	}
	
	@RequestMapping(value="updateReview", method=RequestMethod.POST)
	public ModelAndView updateReview(@ModelAttribute("review") Review review, @RequestParam(value="file", required=false) MultipartFile file,
	HttpSession session) throws Exception {
		
		System.out.println("/review/updateReview : POST");
		
		/////////////////////////////// 파일 업로드 ///////////////////////////////
		if(!file.isEmpty() && file != null) {
			String fileName = file.getOriginalFilename(); // 파일이름.확장명
			
			file.transferTo(new File(savePath+"\\review\\"+fileName));
			
			review.setReviewImg(fileName);
		}
		/////////////////////////////// 파일 업로드 ///////////////////////////////
		
		reviewService.updateReview(review);
		
		Review dbReview = reviewService.getReview(review.getReviewNo());
		Purchase purchase = purchaseService.getPurchase(dbReview.getTrans().getTranNo());
		Product product = productService.getProduct(purchase.getPurchaseProd().getProdNo());
		
		purchase.setPurchaseProd(product);
		dbReview.setTrans(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("review", dbReview);
		modelAndView.setViewName("/review/getReview.jsp");
		
		return modelAndView;
		
	}
	
	@RequestMapping(value="listReview")
	public ModelAndView listReview(@ModelAttribute("search") Search search, HttpServletRequest request) throws Exception {
		
		System.out.println("/review/listReview : GET / POST");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		if(search.getPageSize() == 0) {
			search.setPageSize(pageSize);
		}
		
		Map<String, Object> map = reviewService.getReviewList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, search.getPageSize());
		System.out.println(resultPage);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("/review/listReview.jsp");
		
		return modelAndView;
		
	}
	
}