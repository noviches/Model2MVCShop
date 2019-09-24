<%@ page contentType="text/html;charset=EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- /////////////////////// EL / JSTL �������� �ּ� ó�� ///////////////////////
<%@ page import="java.util.List" %>

<%@ page import="com.model2.mvc.service.domain.Product" %>
<%@ page import="com.model2.mvc.common.Search" %>
<%@ page import="com.model2.mvc.common.Page" %>
<%@ page import="com.model2.mvc.common.util.CommonUtil" %>

<%
List<Product> list = (List<Product>)request.getAttribute("list");
Page resultPage = (Page)request.getAttribute("resultPage");

Search search = (Search)request.getAttribute("search");
//==> null �� ""(nullString)���� ����
String searchCondition = CommonUtil.null2str(search.getSearchCondition());
String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
%>
/////////////////////// EL / JSTL �������� �ּ� ó�� /////////////////////// --%>
<html>
	<head>
		<title>��ǰ �����ȸ</title>
		
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		
		<script type="text/javascript">
			// <!--	
			// �˻�  / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿� 
			function fncGetList(currentPage) {
				document.getElementById("currentPage").value = currentPage;
			   	document.detailForm.submit();
			}
			// -->
		</script>
	</head>
	
	<body bgcolor="#ffffff" text="#000000">
		<div style="width:98%; margin-left:10px;">
			<form name="detailForm" action="/product/listProduct" method="post" onsubmit="return false">
				<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="15" height="37">
						<img src="/images/ct_ttl_img01.gif" width="15" height="37" />
					</td>
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">
								<c:if test="${param.menu eq 'manage'}">
									��ǰ ����
								</c:if>
								<c:if test="${param.menu eq 'search'}">
									��ǰ �����ȸ
								</c:if>
							</td>
						</tr>
						</table>
					</td>
					<td width="14" height="37">
						<img src="/images/ct_ttl_img03.gif" width="12" height="37" />
					</td>
				</tr>
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
				<tr>
					<td align="left">
						<select name="searchSort" class="ct_input_g" style="width:80px; height:23px;" onchange="javascript:fncGetList('1');">
							<option value="0" ${ ! empty search.searchSort && search.searchSort eq 0 ? "selected" : "" }>�ֽż�</option>
							<option value="1" ${ ! empty search.searchSort && search.searchSort eq 1 ? "selected" : "" }>��ǰ���</option>
							<option value="2" ${ ! empty search.searchSort && search.searchSort eq 2 ? "selected" : "" }>���ݳ�����</option>
							<option value="3" ${ ! empty search.searchSort && search.searchSort eq 3 ? "selected" : "" }>���ݳ�����</option>
						</select>
					</td>
					<td align="right">
						���ݴ�
						<input type="text" name="searchMin" value="${ ! empty search.searchMin ? search.searchMin : '' }" class="ct_input_g" style="width:100px; height:23px; padding-left:5px;" placeholder="�ּұݾ�" />
						~
						<input type="text" name="searchMax" value="${ ! empty search.searchMax ? search.searchMax : '' }" class="ct_input_g" style="width:100px; height:23px; padding-left:5px;" placeholder="�ִ�ݾ�" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select name="searchCondition" class="ct_input_g" style="width:80px; height:23px;">
								<option value="0" ${ ! empty search.searchCondition && search.searchCondition eq 0 ? "selected" : "" }>��ǰ��</option>
								<option value="1" ${ ! empty search.searchCondition && search.searchCondition eq 1 ? "selected" : "" }>��ǰ������</option>
						</select>
						<input type="text" name="searchKeyword" value="${ ! empty search.searchKeyword ? search.searchKeyword : '' }" class="ct_input_g" style="width:200px; height:23px; padding-left:5px;" />
					</td>
					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23">
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
								<a href="javascript:fncGetList('1');">�˻�</a>
								<input type="hidden" name="menu" value="<%= request.getParameter("menu") %>" />
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
				<tr>
					<td colspan="7">
						��ü  ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������
					</td>
					<td colspan="4" align="right" width="110px;" style="padding-bottom:10px;">
						<select name="searchCode" class="ct_input_g" style="width:120px; height:23px;" onchange="javascript:fncGetList('1');">
							<option value="" ${ ! empty search.searchCode ? "selected" : "" }>��ü����</option>
							<option value="0" ${ ! empty search.searchCode && search.searchCode eq 0 ? "selected" : "" }>�Ǹ� ���� ��ǰ</option>
							<c:if test="${param.menu eq 'manage'}">
								<option value="1" ${ ! empty search.searchCode && search.searchCode eq 1 ? "selected" : "" }>ǰ���� ��ǰ</option>
							</c:if>
						</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select name="pageSize" class="ct_input_g" style="width:100px; height:23px;" onchange="javascript:fncGetList('1');">
							<option value="5" ${ ! empty search.pageSize && search.pageSize eq 5 ? "selected" : "" }>5���� ����</option>
							<option value="10" ${ ! empty search.pageSize && search.pageSize eq 10 ? "selected" : "" }>10���� ����</option>
							<option value="15" ${ ! empty search.pageSize && search.pageSize eq 15 ? "selected" : "" }>15���� ����</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="220">��ǰ��</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">��ǰ������</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="200">����</td>	
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="200">��������</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">
						<c:if test="${param.menu eq 'manage'}">
							���Ż�ǰ����
						</c:if>
						<c:if test="${param.menu ne 'manage'}">
							��ǰ����
						</c:if>
					</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
				<c:set var="i" value="0" />
				<c:forEach var="product" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr class="ct_list_pop">
						<td align="center">${ i }</td>
						<td></td>
						<td align="left" style="padding-left:30px;">
							<a href="/product/getProduct?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a>
						</td>
						<td></td>
						<td align="left" style="padding-left:20px;">
							<c:if test="${! empty product.fileName}">
								<span style="padding-right:20px;">
									<img src="/images/uploadFiles/${product.fileName}" height="23" align="middle" />
								</span>
							</c:if>
							${product.prodDetail}
						</td>
						<td></td>
						<td align="right" style="padding-right:70px;">${product.price}&nbsp;��</td>
						<td></td>
						<td align="center">
							<c:if test="${product.reQuantity eq 0}">
								-
							</c:if>
							<c:if test="${product.reQuantity ne 0}">
								${product.reQuantity}&nbsp;��
							</c:if>
						</td>
						<td></td>
						<td align="center">
							<c:if test="${param.menu eq 'manage' && product.saleCount ne 0}">
								<a href="/purchase/listPurchase?prodNo=${product.prodNo}">�Ǹ���Ȳ</a>
							</c:if>
							<c:if test="${param.menu ne 'manage'}">
								<c:if test="${! empty product.reQuantity && product.reQuantity ne 0}">
									�Ǹ� ��
								</c:if>
								<c:if test="${empty product.reQuantity || product.reQuantity eq 0}">
									ǰ��
								</c:if>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="11" bgcolor="D6D7D6" height="1"></td>
					</tr>
				</c:forEach>
				</table>
				
				<!-- PageNavigation Start... -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
				<tr>
					<td align="center">
						<input type="hidden" id="currentPage" name="currentPage" value="" />
						<jsp:include page="../common/pageNavigator.jsp" />
					</td>
				</tr>
				</table>
				<!-- PageNavigation End... -->
			</form>
		</div>
	</body>
</html>