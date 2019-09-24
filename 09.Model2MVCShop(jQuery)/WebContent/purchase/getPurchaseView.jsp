<%@ page contentType="text/html;charset=EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
	<head>
		<title>���Ż���ȸ</title>
		
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
		<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
		<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
		<script type="text/javascript">
			$( function(){	
				$("td.ct_btn01:contains('����')").on("click", function(){
					// Debug..
					// alert($("td.ct_btn01:contains('����')").html());
					self.location = "/purchase/updatePurchase?tranNo=${purchase.tranNo}";
				});
				
				$("td.ct_btn01:contains('Ȯ��')").on("click", function(){
					// Debug..
					// alert($("td.ct_btn01:contains('Ȯ��')").html());
					self.location = "/purchase/listPurchase";
				});
			});
		</script>
	</head>
	
	<body bgcolor="#ffffff" text="#000000">
		<div style="width:98%; margin-left:10px;">
			<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="15" height="37">
					<img src="/images/ct_ttl_img01.gif"	width="15" height="37" />
				</td>
				<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="93%" class="ct_ttl01">���Ż���ȸ</td>
						<td width="20%" align="right">&nbsp;</td>
					</tr>
					</table>
				</td>
				<td width="12" height="37">
					<img src="/images/ct_ttl_img03.gif"	width="12" height="37" />
				</td>
			</tr>
			</table>
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:13px;">
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					��ǰ��ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="105">${purchase.purchaseProd.prodNo}</td>
						<td></td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">
					�����ھ��̵� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.buyer.userId}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">���Ź��</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					${ purchase.paymentOption eq '1' ? '���ݱ���' : '�ſ뱸��' }
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">�������̸�</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.receiverName}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">�����ڿ���ó</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.receiverPhone}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">�������ּ�</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.divyAddr}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">���ſ�û����</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.divyRequest}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">���ż���</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.quantity}&nbsp;��</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">��������</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.divyDate}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">�ֹ���</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">${purchase.orderDate}</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			</table>
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
			<tr>
				<td width="53%"></td>
				<td align="right">
					<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<c:if test="${purchase.tranCode ne '2' && purchase.tranCode ne '3'}">
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23" />
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
								<%-- <a href="/purchase/updatePurchase?tranNo=${purchase.tranNo}">����</a> --%>
								<span style="cursor:pointer">����</span>
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23" />
							</td>
							<td width="30"></td>
						</c:if>
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
							<!-- <a href="/purchase/listPurchase">Ȯ��</a> -->
							<span style="cursor:pointer">Ȯ��</span>
						</td>
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif"width="14" height="23" />
						</td>
					</tr>
					</table>
				</td>
			</tr>
			</table>
		</div>
	</body>
</html>