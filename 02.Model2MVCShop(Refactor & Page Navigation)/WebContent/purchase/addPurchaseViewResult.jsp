<%@ page contentType="text/html;charset=euc-kr" %>

<%@ page import="com.model2.mvc.service.domain.Purchase" %>

<%
Purchase purchase = (Purchase)request.getAttribute("purchase");
%>

<html>
	<head>
		<title>���ſϷ�</title>
	</head>
	
	<body>
		<form name="updatePurchase" action="/updatePurchaseView.do?tranNo=<%= purchase.getTranNo() %>" method="post">
			������ ���� ���Ű� �Ǿ����ϴ�.
			<table border=1>
			<tr>
				<td></td>
				<td>��ǰ��ȣ</td>
				<td><%= purchase.getPurchaseProd().getProdNo() %></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>�����ھ��̵�</td>
				<td><%= purchase.getBuyer().getUserId() %></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>���Ź��</td>
				<td>
					<% if(Integer.parseInt(purchase.getPaymentOption()) == 1) { %>
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
				<td><%= purchase.getReceiverName() %></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>�����ڿ���ó</td>
				<td><%= purchase.getReceiverPhone() %></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>�������ּ�</td>
				<td><%= purchase.getDivyAddr() %></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>���ſ�û����</td>
				<td><%= purchase.getDivyRequest() %></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td>����������</td>
				<td><%= purchase.getDivyDate() %></td>
				<td></td>
			</tr>
			</table>
		</form>
	</body>
</html>