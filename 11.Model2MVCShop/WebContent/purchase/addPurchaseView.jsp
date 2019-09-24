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
		
		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<!-- ///////////////////////// Bootstrap, jQuery CDN ///////////////////////// -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
		
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		
		<!-- ///////////////////////// CSS ///////////////////////// -->
		<style>
			body > div.container {
				border : 3px solid #D6CDB7;
				margin-top : 10px;
			}
		</style>
		
		<!-- ///////////////////////// JavaScript ///////////////////////// -->
		<script type="text/javascript">
			//============= "구매" Event 연결 =============
			$( function(){
				$("button.btn.btn-primary").on("click", function(){
					fncAddPurchase();
				});
			});
			
			//============= "취소" Event 처리 및  연결 =============
			$( function(){
				$("a[href='#']").on("click", function(){
					history.go(-1);
				});
			});
			
			//============= "취소" Event 처리 및  연결 =============
			$( function(){
				$("#quantity").on("change", function(){
					totalPrice("${product.price}", $(this).val());
				});
			});
			
			function totalPrice(price, quantity) {
				var total = price * quantity;
				
				$("input[name='totalPrice']").val(total);
				$("span[name='total']").text(total+" 원");
			}
			
			function fncAddPurchase() {
				$("form").attr("method", "post").attr("action", "/purchase/addPurchase").submit();
			}
			
			//============= "Calendar" Event 처리 및  연결 =============
			$( function(){
				$("#divyDate").datepicker({
				    dateFormat:'yy-mm-dd'
				});
			});
		</script>
	</head>
	
	<body bgcolor="#ffffff" text="#000000">
		<!-- ToolBar Start ///////////////////////////////////// -->
		<div class="navbar navbar-default">
			<div class="container">
				<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
			</div>
		</div>
		<!-- ToolBar End ///////////////////////////////////// -->
		
		<!-- 화면구성 div Start ///////////////////////////////////// -->
		<div class="container">
			<h1 class="bg-primary text-center">구매신청</h1>
			
			<!-- form Start ///////////////////////////////////// -->
			<form class="form-horizontal">
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>상품번호</strong></div>
					<div class="col-sm-4">
						${product.prodNo}
						<input type="hidden" name="prodNo" id="prodNo" value="${product.prodNo}" />
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>상 품 명</strong></div>
					<div class="col-sm-4">${product.prodName}</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>상품상세정보</strong></div>
					<div class="col-sm-4">${product.prodDetail}</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>제조일자</strong></div>
					<div class="col-sm-4">${product.manuDate}</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>가격</strong></div>
					<div class="col-sm-4">
						<fmt:formatNumber value="${product.price}" pattern="#,###" />&nbsp;원
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>남은수량</strong></div>
					<div class="col-sm-4">${product.reQuantity}&nbsp;개</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>등록일자</strong></div>
					<div class="col-sm-4">${product.regDate}</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>구매자 아이디</strong></div>
					<div class="col-sm-4">
						${user.userId}
						<input type="hidden" name="buyerId" value="${user.userId}" />
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
					<div class="col-sm-4">
						<select class="form-control" name="paymentOption">
							<option value="1">현금구매</option>
							<option value="2">신용구매</option>
						</select>
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자 이름</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}">
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자 연락처</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자 주소</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${user.addr}">
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyRequest" name="divyRequest">
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="quantity" class="col-sm-offset-1 col-sm-3 control-label">구매수량</label>
					<div class="col-sm-4">
						<input type="number" class="form-control" id="quantity" name="quantity" min="1" style="width:80%; float:left;">
						<span style="float:left; padding:7px 0 0 15px;">&nbsp;개</span>
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyDate" name="divyDate">
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>총구입금액</strong></div>
					<div class="col-sm-4">
						<span name="total"></span>
						<input type="hidden" name="totalPrice" />
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-4 text-center">
						<button type="button" class="btn btn-primary">구&nbsp;매</button>
						<a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
					</div>
				</div>
			</form>
		</div>
	</body>
</html>