package com.model2.mvc.web.review;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.review.ReviewService;

//==> 회원관리 RestController
@RestController
@RequestMapping("/review/*")
public class ReviewRestController {
	
	///Field
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	// setter Method 구현 않음
	
	public ReviewRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="json/getReview/{tranNo}", method=RequestMethod.GET)
	public Review getReview(@PathVariable int tranNo) throws Exception {
		
		System.out.println("/review/json/getReview : GET");
		
		// Business Logic
		Review review = reviewService.getReview(tranNo);
		
		if(review != null) {
			return review;
		}else {
			return new Review();
		}
		
	}
	
}