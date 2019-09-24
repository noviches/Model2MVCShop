<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<!-- ///////////////////////// JSTL ///////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
			//============= "����" Event ���� =============
			$( function(){
				$("button.btn.btn-primary").on("click", function(){
					fncUpdateProduct();
				});
			});
			
			//============= "���" Event ó�� ��  ���� =============
			$( function(){
				$("a[href='#']").on("click", function(){
					self.location = "/product/getProduct?prodNo="+$("input:hidden[name='prodNo']").val()+"&menu=search";
				});
			});
		
			///////////////////////////////////////////////////////////////////////
			function fncUpdateProduct() {
				// Form ��ȿ�� ����
				var name = $("#prodName").val();
				var detail = $("#prodDetail").val();
				var manuDate = $("#manuDate").val();
				var price = $("#price").val();
			
				if(name == null || name.length < 1) {
					alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
					return;
				}
				if(detail == null || detail.length < 1) {
					alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
					return;
				}
				if(manuDate == null || manuDate.length < 1) {
					alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
					return;
				}
				if(price == null || price.length < 1) {
					alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
					return;
				}
				
				$("form").attr("method", "post").attr("action", "/product/updateProduct").attr("enctype", "multipart/form-data").submit();
			}
			
			//============= "Calendar" Event ó�� ��  ���� =============
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
		
		<!-- ȭ�鱸�� div Start ///////////////////////////////////// -->
		<div class="container">
			<div class="page-header text-center">
				<h3 class="text-info">��ǰ��������</h3>
			</div>
			
			<!-- form Start ///////////////////////////////////// -->
			<form class="form-horizontal">
				<div class="form-group">
				  <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">�� ǰ ��</label>
				  <div class="col-sm-4">
					<input type="text" class="form-control" id="prodName" name="prodName" value="${product.prodName}">
					<input type="hidden" name="prodNo" value="${product.prodNo}" />
				  </div>
				</div>
				<div class="form-group">
				  <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">��ǰ������</label>
				  <div class="col-sm-4">
					<input type="text" class="form-control" id="prodDetail" name="prodDetail" value="${product.prodDetail}">
				  </div>
				</div>
				<div class="form-group">
				  <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">��������</label>
				  <div class="col-sm-4">
					<input type="text" class="form-control" id="manuDate" name="manuDate" value="${product.manuDate}">
				  </div>
				</div>
				<div class="form-group">
				  <label for="price" class="col-sm-offset-1 col-sm-3 control-label">����</label>
				  <div class="col-sm-4">
					<input type="text" class="form-control" id="price" name="price" style="width:80%; float:left;" value="${product.price}">
					<span style="float:left; padding:7px 0 0 15px;">��</span>
				  </div>
				</div>
				<div class="form-group">
				  <label for="reQuantity" class="col-sm-offset-1 col-sm-3 control-label">����</label>
				  <div class="col-sm-4">
					<input type="number" class="form-control" id="reQuantity" name="reQuantity" style="width:80%; float:left;" value="${product.reQuantity}">
					<span style="float:left; padding:7px 0 0 15px;">��</span>
				  </div>
				</div>
				<div class="form-group">
				  <label for="fileTitle" class="col-sm-offset-1 col-sm-3 control-label">�������̹���</label>
				  <div class="col-sm-4">
					<input type="file" class="form-control" id="fileTitle" name="fileTitle">
				  </div>
				</div>
				<div class="form-group">
				  <label for="file" class="col-sm-offset-1 col-sm-3 control-label">��ǰ���̹���</label>
				  <div class="col-sm-4">
					<input type="file" class="form-control" id="file" name="file" multiple>
				  </div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-4 text-center">
						<button type="button" class="btn btn-primary">��&nbsp;��</button>
						<a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
					</div>
				</div>
			</form>
			<!-- form End ///////////////////////////////////// -->
		</div>
		<!-- ȭ�鱸�� div End ///////////////////////////////////// -->
	</body>
</html>