<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<!-- ///////////////////////// JSTL ///////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<html lang="ko">
	<head>
		<meta charset="EUC-KR">
		
		<!-- 참조 : http://getbootstrap.com/css/ 참조 -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		
		<!-- ///////////////////////// Bootstrap, jQuery CDN ///////////////////////// -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
		
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		
		<!-- Bootstrap Dropdown Hover CSS -->
		<link href="/css/animate.min.css" rel="stylesheet">
		<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
		
		<!-- Bootstrap Dropdown Hover JS -->
		<script src="/javascript/bootstrap-dropdownhover.min.js"></script>
		
		<!-- jQuery UI toolTip 사용 CSS -->
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		
		<!-- jQuery UI toolTip 사용 JS-->
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		
		<!-- ///////////////////////// CSS ///////////////////////// -->
		<style>
			body {
				padding-top : 50px;
			}
			.img {
				display : inline-block;
				width : 50px;
				height : 50px;
				overflow : hidden;
			}
			.img > img {
				width : 80px;
			}
		</style>
		
		<!-- ///////////////////////// JavaScript ///////////////////////// -->
		<script type="text/javascript">
			//============= 검색 / page 두가지 경우 모두  Event 처리 =============
			function fncGetList(currentPage) {
				$("#currentPage").val(currentPage);
				$("form").attr("method", "POST").attr("action", "/product/listProduct").submit();
			}
			
			//============= "검색" Event 처리 =============
			$( function(){
				//============= 자동완성 검색  Event 처리 (double Click) =============
				$("#searchKeyword").autocomplete({
					source: function(request, response){
						$.ajax( 
								{
									url : "/product/json/listProduct",
									method : "POST",
									dataType : "json",
									headers : {
										"Accept" : "application/json",
										"Content-Type" : "application/json"
									},
									data : JSON.stringify({
										searchKeyword : request.term,
										searchCondition : $("select[name='searchCondition']").val(),
										currentPage : 1,
										pageSize : 10
									}),
									success : function(JSONData, status){
										// Debug...
										// alert(status);
										// alert("JSONData : \n"+JSONData);
										// alert("JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData));
										// alert(JSONData != null);
										// alert(JSONData.list[0].productName);
										
										var array = new Array();
										
										$.each(JSONData.list, function(index, item){
											if($("select[name='searchCondition']").val() == 0){
												array.push(item.prodName);
											}else {
												array.push(item.prodDetail);
											}
										});
										
										response(array);
									}
								}
						);
					}
				});
				
				//==> 검색 Event 연결처리부분
				$("button.btn.btn-default").on("click", function(){
					fncGetList(1);
				});
				
				$("select[name='searchSort'], select[name='searchCode'], select[name='pageSize']").on("change", function(){
					fncGetList(1);
				});
				
				//==> prodNo LINK Event 연결처리
				$("td:nth-child(2)").on("click", function(){
					self.location = "/product/getProduct?prodNo="+$(this).parent().find($("input:hidden[name='prodNo']")).val()+"&menu="+$("input:hidden[name='menu']").val();
				});
				
				$("td:nth-child(6) span").on("click", function(){
					self.location = "/purchase/listPurchase?prodNo="+$(this).parent().parent().find($("input:hidden[name='prodNo']")).val();
				});
				
				$(".ct_list_pop:nth-child(4n+6)").css("background-color", "whitesmoke");
				$(".ct_list_pop").css("height", "60px");
			});
		</script>
	</head>
	
	<body>
		<!-- ToolBar Start ///////////////////////////////////// -->
		<jsp:include page="/layout/toolbar.jsp" />
		<!-- ToolBar End ///////////////////////////////////// -->
	
		<!-- 화면구성 div Start ///////////////////////////////////// -->
		<div class="container">
			<div class="page-header text-info">
				<h3>
					<c:if test="${param.menu eq 'manage'}">
						상품 관리
					</c:if>
					<c:if test="${param.menu eq 'search'}">
						상품 목록조회
					</c:if>
				</h3>
			</div>
			
			<!-- table 위쪽 검색 Start ///////////////////////////////////// -->
			<form class="form-inline" name="detailForm">
				<div class="row" style="margin-bottom:5px;">
					<div class="col-md-6 text-left">
						<p class="text-primary">
							전체  ${ resultPage.totalCount } 건수, 현재 ${ resultPage.currentPage } 페이지
						</p>
					</div>
					<div class="col-md-6 text-right">
						<div class="form-group">
							<label for="searchMin">가격대&nbsp;&nbsp;</label>
							<input type="text" class="form-control" style="width:145px;" id="searchMin" name="searchMin" placeholder="최소금액" value="${ ! empty search.searchMin ? search.searchMin : '' }">
							&nbsp;~&nbsp;
							<input type="text" class="form-control" style="width:145px;" id="searchMax" name="searchMax" placeholder="최대금액" value="${ ! empty search.searchMax ? search.searchMax : '' }">
						</div>
						<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						<input type="hidden" id="currentPage" name="currentPage" value="" />
						<input type="hidden" name="menu" value="${param.menu}" />
					</div>
				</div>
				<div class="row" style="margin-bottom:5px;">
					<div class="col-md-6 text-left">
						<div class="form-group">
							<select class="form-control" name="pageSize">
								<option value="5" ${ ! empty search.pageSize && search.pageSize eq 5 ? "selected" : "" }>5개씩 보기</option>
								<option value="10" ${ ! empty search.pageSize && search.pageSize eq 10 ? "selected" : "" }>10개씩 보기</option>
								<option value="15" ${ ! empty search.pageSize && search.pageSize eq 15 ? "selected" : "" }>15개씩 보기</option>
							</select>
						</div>
						<div class="form-group">
							<select class="form-control" name="searchSort">
								<option value="0" ${ ! empty search.searchSort && search.searchSort eq 0 ? "selected" : "" }>최신순</option>
								<option value="1" ${ ! empty search.searchSort && search.searchSort eq 1 ? "selected" : "" }>상품명순</option>
								<option value="2" ${ ! empty search.searchSort && search.searchSort eq 2 ? "selected" : "" }>조회수순</option>
								<option value="3" ${ ! empty search.searchSort && search.searchSort eq 3 ? "selected" : "" }>가격높은순</option>
								<option value="4" ${ ! empty search.searchSort && search.searchSort eq 4 ? "selected" : "" }>가격낮은순</option>
							</select>
						</div>
					</div>
					<div class="col-md-6 text-right">
						<div class="form-group">
							<select class="form-control" name="searchCode">
								<option value="" ${ ! empty search.searchCode ? "selected" : "" }>전체보기</option>
								<option value="0" ${ ! empty search.searchCode && search.searchCode eq 0 ? "selected" : "" }>판매 중인 상품</option>
								<c:if test="${param.menu eq 'manage'}">
									<option value="1" ${ ! empty search.searchCode && search.searchCode eq 1 ? "selected" : "" }>품절된 상품</option>
								</c:if>
							</select>
						</div>
						<div class="form-group">
							<select class="form-control" name="searchCondition">
								<option value="0" ${ ! empty search.searchCondition && search.searchCondition eq 0 ? "selected" : "" }>상품명</option>
								<option value="1" ${ ! empty search.searchCondition && search.searchCondition eq 1 ? "selected" : "" }>상품상세정보</option>
							</select>
						</div>
						<div class="form-group">
							<label class="sr-only" for="searchKeyword">검색어</label>
							<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="검색어" value="${ ! empty search.searchKeyword ? search.searchKeyword : '' }">
						</div>
						<button type="button" class="btn btn-default">검색</button>
						<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						<input type="hidden" id="currentPage" name="currentPage" value="" />
					</div>
				</div>
			</form>
			<!-- table 위쪽 검색 End ///////////////////////////////////// -->
			
			<!-- table Start ///////////////////////////////////// -->
			<table class="table table-hover table-striped">
				<thead>
					<tr>
						<th align="center">No</th>
						<th align="center">상품명</th>
						<th align="center">상품상세정보</th>
						<th align="center">가격</th>
						<th align="center">남은수량</th>
						<th align="center">
							<c:if test="${param.menu eq 'manage'}">
								구매상품관리
							</c:if>
							<c:if test="${param.menu ne 'manage'}">
								상품상태
							</c:if>
						</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="i" value="0" />
					<c:forEach var="product" items="${list}">
						<c:set var="i" value="${ i+1 }" />
						<tr>
							<td align="center">${ i }</td>
							<td align="left">
								<span style="cursor:pointer">${product.prodName}</span>
								<input type="hidden" name="prodNo" value="${product.prodNo}" />
							</td>
							<td align="left">
								<c:if test="${! empty product.thumbnail}">
									<span class="img">
										<img src="/images/uploadFiles/thumbnail/${product.thumbnail}" align="middle" />&nbsp;&nbsp;&nbsp;
									</span>
								</c:if>
								${product.prodDetail}
							</td>
							<td align="right">
								<fmt:formatNumber value="${product.price}" pattern="#,###" />&nbsp;원
							</td>
							<td align="center">
								<c:if test="${product.reQuantity eq 0}">
									-
								</c:if>
								<c:if test="${product.reQuantity ne 0}">
									${product.reQuantity}&nbsp;개
								</c:if>
							</td>
							<td align="center">
								<c:if test="${param.menu eq 'manage' && product.saleCount ne 0}">
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
					</c:forEach>
				</tbody>
			</table>
			<!-- table End ///////////////////////////////////// -->
		</div>
		<!-- 화면구성 div End ///////////////////////////////////// -->
		
		<!-- PageNavigation Start... -->
		<jsp:include page="../common/pageNavigator_new.jsp" />
		<!-- PageNavigation End... -->
	</body>
</html>