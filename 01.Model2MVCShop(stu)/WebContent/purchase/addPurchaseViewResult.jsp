<%@ page contentType="text/html;charset=euc-kr" %>

<%@ page import="com.model2.mvc.service.purchase.vo.*" %>

<%
PurchaseVO purchaseVO = (PurchaseVO)request.getAttribute("vo");
%>

<html>
	<head>
		<title>���ſϷ�</title>
	</head>
	
	<body>
		<form name="updatePurchase" action="/updatePurchaseView.do?tranNo=<%= purchaseVO.getTranNo() %>" method="post">
			������ ���� ���Ű� �Ǿ����ϴ�.
			<table border=1>
			<tr>
				<td></td>
				<td>��ǰ��ȣ</td>
				<td><%= purchaseVO.getPurchaseProd().getProdNo() %></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>�����ھ��̵�</td>
				<td><%= purchaseVO.getBuyer().getUserId() %></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>���Ź��</td>
				<td>
					<% if(Integer.parseInt(purchaseVO.getPaymentOption()) == 1) { %>
						���ݱ���
					<% }else { %>
						�ſ뱸��
					<% } %>
				</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>�������̸�</td>
				<td><%= purchaseVO.getReceiverName() %></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>�����ڿ���ó</td>
				<td><%= purchaseVO.getReceiverPhone() %></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>�������ּ�</td>
				<td><%= purchaseVO.getDivyAddr() %></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>���ſ�û����</td>
				<td><%= purchaseVO.getDivyRequest() %></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>����������</td>
				<td><%= purchaseVO.getDivyDate() %></td>
				<td></td>
			</tr>
			</table>
		</form>
	</body>
</html>