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
		
		<!-- ///////////////////////// CSS ///////////////////////// -->
		<style>
			body {
				padding-top : 50px;
			}
			#prodNo:hover {
				color : darkblue;
				text-decoration : underline;
				cursor : pointer;"
			}
		</style>
		
		<!-- ///////////////////////// JavaScript ///////////////////////// -->
		<script type="text/javascript">
			$( function(){	
				$($("button")[1]).on("click", function(){
					self.location = "/purchase/updatePurchase?tranNo=${purchase.tranNo}";
				});
				
				$($("button")[2]).on("click", function(){
					self.location = "/purchase/listPurchase";
				});
				
				$("#prodNo").on("click", function(){
					self.location = "/product/getProduct?prodNo="+${purchase.purchaseProd.prodNo}+"&menu=search";
				});
			});
		</script>
	</head>
	
	<body>
		<!-- ToolBar Start ///////////////////////////////////// -->
		<jsp:include page="/layout/toolbar.jsp" />
		<!-- ToolBar End ///////////////////////////////////// -->
		
		<!-- 화면구성 div Start ///////////////////////////////////// -->
		<div class="container">
			<div class="page-header">
				<h3 class="text-info">구매상세조회</h3>
			</div>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>구매상품</strong></div>
				<div class="col-xs-8 col-md-4" id="prodNo">[ ${purchase.purchaseProd.prodNo} ] ${purchase.purchaseProd.prodName}</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>구매자 아이디</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>구매방법</strong></div>
				<div class="col-xs-8 col-md-4">${ purchase.paymentOption eq '1' ? '현금구매' : '신용구매' }</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>구매자 이름</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>구매자 연락처</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>구매자 주소</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.divyAddr}</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>구매요청사항</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.divyRequest}</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>구매수량</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.quantity}&nbsp;개</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>총구매금액</strong></div>
				<div class="col-xs-8 col-md-4">
					<fmt:formatNumber value="${purchase.totalPrice}" pattern="#,###" />&nbsp;원
				</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>배송희망일</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.divyDate}</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>주문일</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.orderDate}</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-md-12 text-center">
					<c:if test="${purchase.tranCode ne '2' && purchase.tranCode ne '3'}">
						<button type="button" class="btn btn-primary">수&nbsp;정</button>&nbsp;&nbsp;&nbsp;
					</c:if>
					<button type="button" class="btn btn-primary">확&nbsp;인</button>
				</div>
			</div>
			<br/>
		</div>
		<!-- 화면구성 div End ///////////////////////////////////// -->
	</body>
</html>