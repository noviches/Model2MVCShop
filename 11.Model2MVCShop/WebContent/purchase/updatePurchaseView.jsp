<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<!-- ///////////////////////// JSTL ///////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	<head>
		<meta charset="EUC-KR">
		
		<!-- 참조 : http://getbootstrap.com/css/ 참조 -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		
		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<!-- ///////////////////////// Bootstrap, jQuery CDN ///////////////////////// -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
		
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
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
			//============= "수정" Event 연결 =============
			$( function(){
				$("button.btn.btn-primary").on("click", function(){
					fncUpdatePurchase();
				});
			});
			
			//============= "취소" Event 처리 및  연결 =============
			$( function(){
				$("a[href='#']").on("click", function(){
					self.location = "/purchase/getPurchase?tranNo="+${purchase.tranNo};
				});
			});
			
			function fncUpdatePurchase() {
				$("form").attr("method", "POST").attr("action", "/purchase/updatePurchase?tranNo=${purchase.tranNo}").submit();
			}
			
			$( function(){
				$("input[name='manuDate']").datepicker({
				    dateFormat:'yy-mm-dd'
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
			<div class="page-header text-center">
				<h3 class="text-info">구매정보수정</h3>
			</div>
			
			<!-- form Start ///////////////////////////////////// -->
			<form class="form-horizontal">
				<div class="form-group">
				  <label for="buyerId" class="col-sm-offset-1 col-sm-3 control-label">구매자 아이디</label>
				  <div class="col-sm-4">
					<span>${purchase.buyer.userId}</span>
					<input type="hidden" name="buyerId" value="${purchase.buyer.userId}">
				  </div>
				</div>
				<div class="form-group">
				  <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
				  <div class="col-sm-4">
					<select class="form-control" name="paymentOption">
						<option value="1" ${purchase.paymentOption eq '1' ? "selected" : ""}>현금구매</option>
						<option value="2" ${purchase.paymentOption eq '2' ? "selected" : ""}>신용구매</option>
					</select>
				  </div>
				</div>
				<div class="form-group">
				  <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자 이름</label>
				  <div class="col-sm-4">
					<input type="text" class="form-control" id="receiverName" name="receiverName" value="${purchase.receiverName}">
				  </div>
				</div>
				<div class="form-group">
				  <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자 연락처</label>
				  <div class="col-sm-4">
					<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${purchase.receiverPhone}">
				  </div>
				</div>
				<div class="form-group">
				  <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자 주소</label>
				  <div class="col-sm-4">
					<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${purchase.divyAddr}">
				  </div>
				</div>
				<div class="form-group">
				  <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
				  <div class="col-sm-4">
					<input type="text" class="form-control" id="divyRequest" name="divyRequest" value="${purchase.divyRequest}">
				  </div>
				</div>
				<div class="form-group">
				  <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매수량</label>
				  <div class="col-sm-4">
					<span>${purchase.quantity}&nbsp;개</span>
				  </div>
				</div>
				<div class="form-group">
				  <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
				  <div class="col-sm-4">
					<input type="text" class="form-control" id="divyDate" name="divyDate" value="${purchase.divyDate}">
				  </div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-4 text-center">
						<button type="button" class="btn btn-primary">수&nbsp;정</button>
						<a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
					</div>
				</div>
			</form>
			<!-- form End ///////////////////////////////////// -->
		</div>	
		<!-- 화면구성 div End ///////////////////////////////////// -->
	</body>
</html>