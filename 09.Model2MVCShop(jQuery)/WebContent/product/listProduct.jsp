<%@ page contentType="text/html;charset=EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
	<head>
		<title>상품 목록조회</title>
		
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		
		<!-- CDN(Content Delivery Network) 호스트 사용 -->
		<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
		<script type="text/javascript">
			//===== 기존Code 주석 처리 후  jQuery 변경 ======//
			// 검색  / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용
			function fncGetList(currentPage) {
				// document.getElementById("currentPage").value = currentPage;
				$("#currentPage").val(currentPage);
			   	// document.detailForm.submit();
				$("form").attr("method", "post").attr("action", "/product/listProduct").submit();
			}
			//===========================================//
			
			//==> 추가된 부분 : "검색", prodNo link Event 연결 및 처리
			$( function(){
				//==> 검색 Event 연결처리부분
				$("td.ct_btn01:contains('검색')").on("click", function(){
					fncGetList(1);
				});
				
				$("select[name='searchSort'], select[name='searchCode'], select[name='pageSize']").on("change", function(){
					fncGetList(1);
				});
				
				//==> prodNo LINK Event 연결처리
				$(".ct_list_pop td:nth-child(3)").on("click", function(){
					self.location = "/product/getProduct?prodNo="+$(this).parent().find($("input:hidden[name='prodNo']")).val()+"&menu="+$("input:hidden[name='menu']").val();
				});
				
				$(".ct_list_pop td:nth-child(11)").on("click", function(){
					self.location = "/purchase/listPurchase?prodNo="+$(this).parent().find($("input:hidden[name='prodNo']")).val();
				});
				
				$(".ct_list_pop:nth-child(4n+6)").css("background-color", "whitesmoke");
				// console.log($(".ct_list_pop:nth-child(4)").html()); //==> ok
				$(".ct_list_pop").css("height", "50px");
			});
		</script>
	</head>
	
	<body bgcolor="#ffffff" text="#000000">
		<div style="width:98%; margin-left:10px;">
			<form name="detailForm">
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
									상품 관리
								</c:if>
								<c:if test="${param.menu eq 'search'}">
									상품 목록조회
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
						<!-- <select name="searchSort" class="ct_input_g" style="width:80px; height:23px;" onchange="javascript:fncGetList('1');"> -->
						<select name="searchSort" class="ct_input_g" style="width:80px; height:23px;">
							<option value="0" ${ ! empty search.searchSort && search.searchSort eq 0 ? "selected" : "" }>최신순</option>
							<option value="1" ${ ! empty search.searchSort && search.searchSort eq 1 ? "selected" : "" }>상품명순</option>
							<option value="2" ${ ! empty search.searchSort && search.searchSort eq 2 ? "selected" : "" }>가격높은순</option>
							<option value="3" ${ ! empty search.searchSort && search.searchSort eq 3 ? "selected" : "" }>가격낮은순</option>
						</select>
					</td>
					<td align="right">
						가격대
						<input type="text" name="searchMin" value="${ ! empty search.searchMin ? search.searchMin : '' }" class="ct_input_g" style="width:100px; height:23px; padding-left:5px;" placeholder="최소금액" />
						~
						<input type="text" name="searchMax" value="${ ! empty search.searchMax ? search.searchMax : '' }" class="ct_input_g" style="width:100px; height:23px; padding-left:5px;" placeholder="최대금액" />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select name="searchCondition" class="ct_input_g" style="width:80px; height:23px;">
								<option value="0" ${ ! empty search.searchCondition && search.searchCondition eq 0 ? "selected" : "" }>상품명</option>
								<option value="1" ${ ! empty search.searchCondition && search.searchCondition eq 1 ? "selected" : "" }>상품상세정보</option>
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
								<!-- <a href="javascript:fncGetList('1');">검색</a> -->
								검색
								<input type="hidden" name="menu" value="${param.menu}" />
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
						전체  ${resultPage.totalCount} 건수, 현재 ${resultPage.currentPage} 페이지
					</td>
					<td colspan="4" align="right" width="110px;" style="padding-bottom:10px;">
						<!-- <select name="searchCode" class="ct_input_g" style="width:120px; height:23px;" onchange="javascript:fncGetList('1');"> -->
						<select name="searchCode" class="ct_input_g" style="width:120px; height:23px;">
							<option value="" ${ ! empty search.searchCode ? "selected" : "" }>전체보기</option>
							<option value="0" ${ ! empty search.searchCode && search.searchCode eq 0 ? "selected" : "" }>판매 중인 상품</option>
							<c:if test="${param.menu eq 'manage'}">
								<option value="1" ${ ! empty search.searchCode && search.searchCode eq 1 ? "selected" : "" }>품절된 상품</option>
							</c:if>
						</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<!-- <select name="pageSize" class="ct_input_g" style="width:100px; height:23px;" onchange="javascript:fncGetList('1');"> -->
						<select name="pageSize" class="ct_input_g" style="width:100px; height:23px;">
							<option value="5" ${ ! empty search.pageSize && search.pageSize eq 5 ? "selected" : "" }>5개씩 보기</option>
							<option value="10" ${ ! empty search.pageSize && search.pageSize eq 10 ? "selected" : "" }>10개씩 보기</option>
							<option value="15" ${ ! empty search.pageSize && search.pageSize eq 15 ? "selected" : "" }>15개씩 보기</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="220">상품명</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">상품상세정보</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="200">가격</td>	
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="200">남은수량</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">
						<c:if test="${param.menu eq 'manage'}">
							구매상품관리
						</c:if>
						<c:if test="${param.menu ne 'manage'}">
							상품상태
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
							<%-- <a href="/product/getProduct?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a> --%>
							<span style="cursor:pointer">${product.prodName}</span>
							<input type="hidden" name="prodNo" value="${product.prodNo}" />
						</td>
						<td></td>
						<td align="left" style="padding-left:20px;">
							<c:if test="${! empty product.thumbnail}">
								<span style="padding-right:20px;">
									<img src="/images/uploadFiles/thumbnail/${product.thumbnail}" height="42" weight="42" align="middle" />
								</span>
							</c:if>
							${product.prodDetail}
						</td>
						<td></td>
						<td align="right" style="padding-right:70px;">${product.price}&nbsp;원</td>
						<td></td>
						<td align="center">
							<c:if test="${product.reQuantity eq 0}">
								-
							</c:if>
							<c:if test="${product.reQuantity ne 0}">
								${product.reQuantity}&nbsp;개
							</c:if>
						</td>
						<td></td>
						<td align="center">
							<c:if test="${param.menu eq 'manage' && product.saleCount ne 0}">
								<%-- <a href="/purchase/listPurchase?prodNo=${product.prodNo}">판매현황</a> --%>
								<span style="cursor:pointer">판매현황</span>
							</c:if>
							<c:if test="${param.menu ne 'manage'}">
								<c:if test="${! empty product.reQuantity && product.reQuantity ne 0}">
									판매 중
								</c:if>
								<c:if test="${empty product.reQuantity || product.reQuantity eq 0}">
									품절
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