<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page contentType="text/html; charset=EUC-KR" %>

<html>
	<head>
		<title>��� ��ǰ ����</title>
		
		<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
		<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
		<script type="text/javascript">
		$( function(){
			$("span").on("click", function(){
				window.close();
				opener.location = "/product/getProduct?prodNo="+$(this).text().trim()+"&menu=search";
			});
		});
		</script>
	</head>
	<body>
		����� ��� ��ǰ�� �˰� �ִ�
		<br>
		<br>
		<%
		request.setCharacterEncoding("euc-kr");
		response.setCharacterEncoding("euc-kr");
		String history = null;
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null && cookies.length > 0) {
			for(int i=0; i<cookies.length; i++) {
				Cookie cookie = cookies[i];
				
				if(cookie.getName().equals("history")) {
					history = cookie.getValue();
				}
			}
			if(history != null) {
				String[] h = history.split(",");
				
				for(int i=0; i<h.length; i++) {
					if(! h[i].equals("null") && ! h[i].equals("")) {
		%>
						<a href="/product/getProduct?prodNo=<%= h[i] %>&menu=search" target="rightFrame"><%= h[i] %></a>
						<%-- <span><%= h[i] %></span> --%>
						<br>
		<%
					}
				}
			}
		}
		%>
	</body>
</html>