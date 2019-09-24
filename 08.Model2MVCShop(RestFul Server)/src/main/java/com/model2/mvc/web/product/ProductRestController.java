package com.model2.mvc.web.product;

import java.io.FileOutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

//==> 회원관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
	
	public ProductRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="json/addProduct", method=RequestMethod.POST)
	public Product addUser(@RequestBody Product product, HttpServletRequest request) throws Exception {
		
		System.out.println("/user/json/addProduct : POST");
		
		/////////////////////////////// 파일 업로드 ///////////////////////////////
		/*
		String savePath = "C:\\workspace\\08.Model2MVCShop(RestFul Server)\\WebContent\\images\\uploadFiles";
		
		String originalFilename = file.getOriginalFilename(); // 파일이름.확장명
		product.setFileName(originalFilename);
		String fullPath = savePath + "\\" + originalFilename;
		
		if(!file.isEmpty()) {
			byte[] bytes = file.getBytes();
			FileOutputStream fos = new FileOutputStream(fullPath);
			fos.write(bytes);
		}
		*/
		/////////////////////////////// 파일 업로드 ///////////////////////////////
		
		String[] temp = product.getManuDate().split("-");
		product.setManuDate(temp[0]+temp[1]+temp[2]);
		
		productService.addProduct(product);
		
		return product;
			
	}
	
}