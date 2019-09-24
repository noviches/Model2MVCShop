<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<!-- ///////////////////////// JSTL ///////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
	<head>
		<title>��� ���� ����</title>
		
		<meta charset="EUC-KR">
		
		<!-- ///////////////////////// Bootstrap, jQuery CDN ///////////////////////// -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
		
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		
		<!-- ///////////////////////// CSS ///////////////////////// -->
		<style>
			.btns {
				float : right;
			}
			.btns button:last-child {
				margin-left : 10px;
			}
		</style>
		
		<!-- ///////////////////////// JavaScript ///////////////////////// -->
		<script type="text/javascript">
			$( function(){
				$("button:nth-child(1)").on("click", function(){
					$("form").attr("method", "POST").attr("action", "/review/updateReview").attr("enctype", "multipart/form-data").submit();
				});
				
				$("button:nth-child(2)").on("click", function(){
					close();
				});
			});
		</script>
	</head>
	
	<body>
		<!-- ȭ�鱸�� div Start ///////////////////////////////////// -->
		<div class="container">
			<h3>��� ���� �ۼ�</h3>
			
			<!-- form Start ///////////////////////////////////// -->
			<form>
				<div>
					������ ��ǰ : [ ${review.trans.purchaseProd.prodNo} ] ${review.trans.purchaseProd.prodName}
					<input type="hidden" name="tranNo" value="${review.trans.tranNo}">
				</div>
				<div class="form-group" style="margin-top:20px;">
					<input type="file" name="file">
				</div>
				<div class="form-group">
					<textarea class="form-control" name="content" rows="3">${review.content}</textarea>
				</div>
				<div class="form-group">
					<div class="btns">
						<button type="button" class="btn btn-primary btn-sm">�����Ϸ�</button>
						<button type="button" class="btn btn-primary btn-sm">��&nbsp;��</button>
					</div>
				</div>
			</form>
		</div>
	</body>
</html>