<%@ page contentType="text/html;charset=EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- /////////////////////// EL / JSTL 적용으로 주석 처리 ////////////////////////
<%@ page import="com.model2.mvc.service.domain.Product" %>
<%
Product product = (Product)request.getAttribute("product");
%>
/////////////////////// EL / JSTL 적용으로 주석 처리 //////////////////////// --%>
<html>
	<head>
		<title>판매상품관리</title>
	
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
	</head>
	
	<body bgcolor="#ffffff" text="#000000">
		<div style="width:98%; margin-left:10px;">
			<form name="detailForm" method="post">
				<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="15" height="37">
						<img src="/images/ct_ttl_img01.gif" width="15" height="37">
					</td>
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">상품상세조회</td>
							<td width="20%" align="right">&nbsp;</td>
						</tr>
						</table>
					</td>
					<td width="12" height="37">
						<img src="/images/ct_ttl_img03.gif" width="12" height="37" />
					</td>
				</tr>
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:13px;">
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="105">${product.prodNo}</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.prodName}</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						상품이미지 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<img src="http://placehold.it/300X300" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						상품상세정보 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.prodDetail}</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">제조일자</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.manuDate}</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">가격</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.price}</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">등록일자</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.regDate}</td>
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
							<c:if test="${product.proTranCode ne '3'}">
								<td width="17" height="23">
									<img src="/images/ct_btnbg01.gif" width="17" height="23" />
								</td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
									<a href="/addPurchaseView.do?prod_no=${product.prodNo}">구매</a>
								</td>
								<td width="14" height="23">
									<img src="/images/ct_btnbg03.gif" width="14" height="23">
								</td>
								<td width="30"></td>
							</c:if>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
								<a href="javascript:history.go(-1);">이전</a>
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
			</form>
		</div>
	</body>
</html>