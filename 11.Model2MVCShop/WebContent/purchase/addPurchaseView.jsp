<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<!-- ///////////////////////// JSTL ///////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<html lang="ko">
	<head>
		<meta charset="EUC-KR">
		
		<!-- ���� : http://getbootstrap.com/css/ ���� -->
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
			//============= "����" Event ���� =============
			$( function(){
				$("button.btn.btn-primary").on("click", function(){
					fncAddPurchase();
				});
			});
			
			//============= "���" Event ó�� ��  ���� =============
			$( function(){
				$("a[href='#']").on("click", function(){
					history.go(-1);
				});
			});
			
			//============= "���" Event ó�� ��  ���� =============
			$( function(){
				$("#quantity").on("change", function(){
					totalPrice("${product.price}", $(this).val());
				});
			});
			
			function totalPrice(price, quantity) {
				var total = price * quantity;
				
				$("input[name='totalPrice']").val(total);
				$("span[name='total']").text(total+" ��");
			}
			
			function fncAddPurchase() {
				$("form").attr("method", "post").attr("action", "/purchase/addPurchase").submit();
			}
			
			//============= "Calendar" Event ó�� ��  ���� =============
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
		
		<!-- ȭ�鱸�� div Start ///////////////////////////////////// -->
		<div class="container">
			<h1 class="bg-primary text-center">���Ž�û</h1>
			
			<!-- form Start ///////////////////////////////////// -->
			<form class="form-horizontal">
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>��ǰ��ȣ</strong></div>
					<div class="col-sm-4">
						${product.prodNo}
						<input type="hidden" name="prodNo" id="prodNo" value="${product.prodNo}" />
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>�� ǰ ��</strong></div>
					<div class="col-sm-4">${product.prodName}</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>��ǰ������</strong></div>
					<div class="col-sm-4">${product.prodDetail}</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>��������</strong></div>
					<div class="col-sm-4">${product.manuDate}</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>����</strong></div>
					<div class="col-sm-4">
						<fmt:formatNumber value="${product.price}" pattern="#,###" />&nbsp;��
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>��������</strong></div>
					<div class="col-sm-4">${product.reQuantity}&nbsp;��</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>�������</strong></div>
					<div class="col-sm-4">${product.regDate}</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>������ ���̵�</strong></div>
					<div class="col-sm-4">
						${user.userId}
						<input type="hidden" name="buyerId" value="${user.userId}" />
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">���Ź��</label>
					<div class="col-sm-4">
						<select class="form-control" name="paymentOption">
							<option value="1">���ݱ���</option>
							<option value="2">�ſ뱸��</option>
						</select>
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">������ �̸�</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverName" name="receiverName" value="${user.userName}">
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">������ ����ó</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" value="${user.phone}">
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">������ �ּ�</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyAddr" name="divyAddr" value="${user.addr}">
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">���ſ�û����</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyRequest" name="divyRequest">
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="quantity" class="col-sm-offset-1 col-sm-3 control-label">���ż���</label>
					<div class="col-sm-4">
						<input type="number" class="form-control" id="quantity" name="quantity" min="1" style="width:80%; float:left;">
						<span style="float:left; padding:7px 0 0 15px;">&nbsp;��</span>
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">����������</label>
					<div class="col-sm-4">
						<input type="text" class="form-control" id="divyDate" name="divyDate">
					</div>
				</div>
				<hr/>
				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-3 control-label"><strong>�ѱ��Աݾ�</strong></div>
					<div class="col-sm-4">
						<span name="total"></span>
						<input type="hidden" name="totalPrice" />
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-4 text-center">
						<button type="button" class="btn btn-primary">��&nbsp;��</button>
						<a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
					</div>
				</div>
			</form>
		</div>
	</body>
</html>