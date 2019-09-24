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
		</style>
		
		<!-- ///////////////////////// JavaScript ///////////////////////// -->
		<script type="text/javascript">
			$( function(){
				$($("button")[1]).on("click", function(){
					self.location = "/product/listProduct?menu=manage";
				});
				
				$($("button")[2]).on("click", function(){
					self.location = "/product/addProduct";
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
				<h3 class="text-info">상품등록</h3>
			</div>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>상 품 명</strong></div>
				<div class="col-xs-8 col-md-4">${product.prodName}</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>상품상세정보</strong></div>
				<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
				<div class="col-xs-8 col-md-4">${product.manuDate}</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>가 격</strong></div>
				<div class="col-xs-8 col-md-4">
					<fmt:formatNumber value="${product.price}" pattern="#,###" />&nbsp;원
				</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-xs-4 col-md-2"><strong>상품이미지</strong></div>
				<div class="col-xs-8 col-md-4">
					<c:if test="${!empty files}">
						<c:forEach var="file" items="${files}">
							<p><img src="/images/uploadFiles/${file}" width="100%" /></p>
						</c:forEach>
					</c:if>
					<c:if test="${empty product.fileName}">관련 이미지가 없습니다.</c:if>
				</div>
			</div>
			<hr/>
			<div class="row">
				<div class="col-md-12 text-center">
					<button type="button" class="btn btn-primary">확&nbsp;인</button>&nbsp;&nbsp;&nbsp;
					<button type="button" class="btn btn-primary">추가등록</button>
				</div>
			</div>
			<br/>
		</div>
		<!-- 화면구성 div End ///////////////////////////////////// -->
	</body>
</html>