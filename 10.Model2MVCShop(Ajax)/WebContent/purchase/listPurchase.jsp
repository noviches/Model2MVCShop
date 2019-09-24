<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
	<head>
		<title>구매 목록조회</title>
		
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		
		<!-- CDN(Content Delivery Network) 호스트 사용 -->
		<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
		<script type="text/javascript">
			function fncGetList(currentPage) {
				// document.getElementById("currentPage").value = currentPage;
				$("#currentPage").val(currentPage);
			   	// document.detailForm.submit();
			   	$("form").attr("method", "post").attr("action", "/purchase/listPurchase").submit();
			}
			
			$( function(){
				$("select[name='searchCode']").on("change", function(){
					fncGetList(1);
				});
				
				$(".ct_list_pop td:nth-child(1)").on("click", function(){
					self.location = "/purchase/getPurchase?tranNo="+$("input:hidden[name='tranNo']").val();
				});
				
				$(".ct_list_pop td:nth-child(3)").on("click", function(){
					self.location = "/user/getUser?userId="+$(this).text().trim();
				});
				
				$("#orderRemove").on("click", function(){
					fncGetList(1);
				});
				
				$(".ct_list_pop td:nth-child(15) span:contains('배송하기')").on("click", function(){
					self.location = "/purchase/updateTranCode?tranNo="+$(this).parent().find($("input:hidden[name='tranNo']")).val()+"&tranCode=2";
				});
				
				$(".ct_list_pop td:nth-child(15) span:contains('배송정보수정')").on("click", function(){
					self.location = "/purchase/updatePurchase?tranNo="+$(this).parent().find($("input:hidden[name='tranNo']")).val();
				});
				
				$(".ct_list_pop td:nth-child(15) span:contains('물건도착')").on("click", function(){
					self.location = "/purchase/updateTranCode?tranNo="+$(this).parent().find($("input:hidden[name='tranNo']")).val()+"&tranCode=3";
				});
				
				$(".ct_list_pop td:nth-child(15) span:contains('주문취소')").on("click", function(){
					/* self.location = "/purchase/deletePurchase?tranNo="+$(this).parent().find($("input:hidden[name='tranNo']")).val(); */
					self.location = "/purchase/deletePurchase?tranNo="+$(this).parent().find($("input:hidden[name='tranNo']")).val()+"&tranCode=4";
				});
			});
		</script>
	</head>
	
	<body bgcolor="#ffffff" text="#000000">
		<div style="width:98%; margin-left:10px;">
			<form name="detailForm">
				<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="15" height="37">
						<img src="/images/ct_ttl_img01.gif"width="15" height="37">
					</td>
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">
								<c:if test="${sessionScope.user.role eq 'admin'}">
									구매상태 조회
								</c:if>
								<c:if test="${sessionScope.user.role ne 'admin'}">
									구매 목록조회
								</c:if>
							</td>
						</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif" width="12" height="37"></td>
				</tr>
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
				<tr>
					<td colspan="11" >
						전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지
					</td>
					<td colspan="4" align="right" width="110px;" style="padding-bottom:10px;">
						<c:if test="${sessionScope.user.role eq 'user'}">
							<span id="orderRemove" style="cursor:pointer">주문취소내역</span>
							<input type="hidden" name="searchCode" value="4" />
						</c:if>
						<c:if test="${sessionScope.user.role eq 'admin'}">
							<select name="searchCode" class="ct_input_g" style="width:120px; height:23px;" onchange="javascript:fncGetList('1');">
								<option value="" ${ ! empty search.searchCode ? "selected" : "" }>전체보기</option>
								<option value="1" ${ ! empty search.searchCode && search.searchCode eq 1 ? "selected" : "" }>구매완료 상품</option>
								<option value="2" ${ ! empty search.searchCode && search.searchCode eq 2 ? "selected" : "" }>배송중인 상품</option>
								<option value="3" ${ ! empty search.searchCode && search.searchCode eq 3 ? "selected" : "" }>배송완료 상품</option>
							</select>
						</c:if>
					</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">회원ID</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">구매자명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">전화번호</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">배송희망일</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">배송현황</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">주문일</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">정보수정</td>
				</tr>
				<tr>
					<td colspan="15" bgcolor="808285" height="1"></td>
				</tr>
				<c:set var="i" value="0" />
				<c:forEach var="purchase" items="${list}">
					<c:set var="i" value="${ i+1 }" />
					<tr class="ct_list_pop">
						<td align="center">
							<%-- <a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">${ i }</a> --%>
							<span style="cursor:pointer">${ i }</span>
						</td>
						<td></td>
						<td align="left" style="padding-left:30px;">
							<%-- <a href="/user/getUser?userId=${purchase.buyer.userId}">${purchase.buyer.userId}</a> --%>
							<span style="cursor:pointer">${purchase.buyer.userId}</span>
						</td>
						<td></td>
						<td align="left" style="padding-left:30px;">${purchase.receiverName}</td>
						<td></td>
						<td align="center">${purchase.receiverPhone}</td>
						<td></td>
						<td align="center">${purchase.divyDate}</td>
						<td></td>
						<td align="center">
							현재
							<c:if test="${purchase.tranCode eq null || purchase.tranCode eq '0'}">
								판매 중
							</c:if>
							<c:if test="${purchase.tranCode eq '1'}">
								구매완료
							</c:if>
							<c:if test="${purchase.tranCode eq '2'}">
								배송 중
							</c:if>
							<c:if test="${purchase.tranCode eq '3'}">
								배송완료
							</c:if>
							상태 입니다.
						</td>
						<td></td>
						<td align="center">${purchase.orderDate}</td>
						<td></td>
						<td align="center">
							<input type="hidden" name="tranNo" class="tranNo" value="${purchase.tranNo}">
							<c:if test="${sessionScope.user.role eq 'admin'}">
								<c:if test="${purchase.tranCode eq '1'}">
									<span style="cursor:pointer">배송하기</span>
								</c:if>
							</c:if>
							<c:if test="${sessionScope.user.role ne 'admin'}">
								<c:if test="${purchase.tranCode eq '1'}">
									<%-- <a href="/purchase/updatePurchase?tranNo=${purchase.tranNo}">배송정보수정</a> --%>
									<span style="cursor:pointer">배송정보수정</span>
									&nbsp;&nbsp;
									<%-- <a href="/purchase/deletePurchase?tranNo=${purchase.tranNo}">주문취소</a> --%>
									<span style="cursor:pointer">주문취소</span>
								</c:if>
								<c:if test="${purchase.tranCode eq '2'}">
									<%-- <a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=3">물건도착</a> --%>
									<span style="cursor:pointer">물건도착</span>
								</c:if>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="15" bgcolor="D6D7D6" height="1"></td>
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