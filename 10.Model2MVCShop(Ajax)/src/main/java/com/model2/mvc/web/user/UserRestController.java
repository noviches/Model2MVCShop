package com.model2.mvc.web.user;

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
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;

//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	// setter Method 구현 않음
		
	public UserRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="json/getUser/{userId}", method=RequestMethod.GET)
	public User getUser(@PathVariable String userId) throws Exception {
		
		System.out.println("/user/json/getUser : GET");
		
		// Business Logic
		User user = userService.getUser(userId);
		
		if(user != null) {
			return user;
		}else {
			return new User();
		}
		
	}

	@RequestMapping(value="json/login", method=RequestMethod.POST)
	public User login(@RequestBody User user, HttpSession session) throws Exception {
		
		System.out.println("/user/json/login : POST");
		System.out.println(":: "+user);
		
		// Business Logic
		User dbUser = userService.getUser(user.getUserId());
		
		if(user.getPassword().equals(dbUser.getPassword())) {
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
		
	}
	
	@RequestMapping(value="json/listUser", method=RequestMethod.POST)
	public Map listUser(@RequestBody Search search) throws Exception {
		
		System.out.println("/user/json/listUser : POST");
		System.out.println(":: "+search);
		
		// Business Logic
		Map<String, Object> map = userService.getUserList(search);
		
		return map;
		
	}
	
}