<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
	<head>
		<title>���ſϷ�</title>
	</head>
	
	<body>
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
			<td>�ѱ��űݾ�</td>
			<td>${purchase.totalPrice}&nbsp;��</td>
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
	</body>
</html>