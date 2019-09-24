package com.model2.mvc.framework;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.common.util.HttpUtil;

public class ActionServlet extends HttpServlet {

	private RequestMapping mapper;

	@Override
	public void init() throws ServletException {
		super.init();
		
		String resources = getServletConfig().getInitParameter("resources"); // 특정 서블릿에서만 init-param 사용
		mapper = RequestMapping.getInstance(resources);
	}

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURI(); // 포트 뒤부터 파일까지의 경로
		String contextPath = request.getContextPath(); // 포트 뒤부터 프로젝트 폴더까지의 경로
		String path = url.substring(contextPath.length());
		System.out.println(path);
		
		try {
			Action action = mapper.getAction(path);
			action.setServletContext(getServletContext());
			
			String resultPage = action.execute(request, response);
			String result = resultPage.substring(resultPage.indexOf(":")+1);
			
			if(resultPage.startsWith("forward:")) // 문자열이 해당 문자로 시작하는지 확인
				HttpUtil.forward(request, response, result);
			else
				HttpUtil.redirect(response, result);
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	
}