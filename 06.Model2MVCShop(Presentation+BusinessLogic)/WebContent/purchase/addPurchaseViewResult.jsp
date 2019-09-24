<%@ page contentType="text/html;charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- /////////////////////// EL / JSTL �������� �ּ� ó�� ///////////////////////
<%@ page import="com.model2.mvc.service.domain.Purchase" %>

<%
Purchase purchase = (Purchase)request.getAttribute("purchase");
%>
/////////////////////// EL / JSTL �������� �ּ� ó�� /////////////////////// --%>
<html>
	<head>
		<title>���ſϷ�</title>
	</head>
	
	<body>
		<form name="updatePurchase" action="/updatePurchaseView.do?tranNo=${purchase.tranNo}" method="post">
			������ ���� ���Ű� �Ǿ����ϴ�.
			<table border=1>
			<tr>
				<td></td>
				<td>��ǰ��ȣ</td>
				<td>${purchase.purchaseProd.prodNo}</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>�����ھ��̵�</td>
				<td>${purchase.buyer.userId}</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>���Ź��</td>
				<%-- //////////////////////// EL / JSTL �������� �ּ� ó�� ////////////////////////
				<td>
					<% if(Integer.parseInt(purchase.getPaymentOption()) == 1) { %>
						���ݱ���
					<% }else { %>
						�ſ뱸��
					<% } %>
				//////////////////////// EL / JSTL �������� �ּ� ó�� //////////////////////// --%>
				<td>
					<c:if test="${purchase.paymentOption eq '1'}">
						���ݱ���
					</c:if>
					<c:if test="${purchase.paymentOption eq '2'}">
						�ſ뱸��
					</c:if>
				</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>�������̸�</td>
				<td>${purchase.receiverName}</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>�����ڿ���ó</td>
				<td>${purchase.receiverPhone}</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>�������ּ�</td>
				<td>${purchase.divyAddr}</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>���ſ�û����</td>
				<td>${purchase.divyRequest}</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>����������</td>
				<td>${purchase.divyDate}</td>
				<td></td>
			</tr>
			</table>
		</form>
	</body>
</html>