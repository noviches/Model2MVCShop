<%@ page contentType="text/html;charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- /////////////////////// EL / JSTL 적용으로 주석 처리 ///////////////////////
<%@ page import="com.model2.mvc.service.domain.Purchase" %>

<%
Purchase purchase = (Purchase)request.getAttribute("purchase");
%>
/////////////////////// EL / JSTL 적용으로 주석 처리 /////////////////////// --%>
<html>
	<head>
		<title>구매완료</title>
	</head>
	
	<body>
		<form name="updatePurchase" action="/updatePurchaseView.do?tranNo=${purchase.tranNo}" method="post">
			다음과 같이 구매가 되었습니다.
			<table border=1>
			<tr>
				<td></td>
				<td>물품번호</td>
				<td>${purchase.purchaseProd.prodNo}</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>구매자아이디</td>
				<td>${purchase.buyer.userId}</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>구매방법</td>
				<%-- //////////////////////// EL / JSTL 적용으로 주석 처리 ////////////////////////
				<td>
					<% if(Integer.parseInt(purchase.getPaymentOption()) == 1) { %>
						현금구매
					<% }else { %>
						신용구매
					<% } %>
				//////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>
				<td>
					<c:if test="${purchase.paymentOption eq '1'}">
						현금구매
					</c:if>
					<c:if test="${purchase.paymentOption eq '2'}">
						신용구매
					</c:if>
				</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>구매자이름</td>
				<td>${purchase.receiverName}</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>구매자연락처</td>
				<td>${purchase.receiverPhone}</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>구매자주소</td>
				<td>${purchase.divyAddr}</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>구매요청사항</td>
				<td>${purchase.divyRequest}</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>배송희망일자</td>
				<td>${purchase.divyDate}</td>
				<td></td>
			</tr>
			</table>
		</form>
	</body>
</html>