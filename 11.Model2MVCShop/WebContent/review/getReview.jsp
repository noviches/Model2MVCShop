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
			.cont {
				border : 1px solid gray;
				padding : 10px;
			}
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
					var tranNo = ${review.trans.tranNo};
					
					window.opener.reviewList(tranNo);
					close();
				});

				$("button:nth-child(2)").on("click", function(){
					self.location = "/review/updateReview?reviewNo="+${review.reviewNo};
				});
			});
		</script>
	</head>
	
	<body>
		<!-- ȭ�鱸�� div Start ///////////////////////////////////// -->
		<div class="container">
			<h3>��� ���� ����</h3>
		
			<div>
				������ ��ǰ : [ ${review.trans.purchaseProd.prodNo} ] ${review.trans.purchaseProd.prodName}
			</div>
			<div class="cont">
				${review.content}
			</div>
			<div>
				<div class="btns">
					<button type="button" class="btn btn-primary btn-sm">��&nbsp;��</button>
					<c:if test="${sessionScope.user.userId == review.trans.buyer.userId}">
						<button type="button" class="btn btn-primary btn-sm">��&nbsp;��</button>
					</c:if>
				</div>
			</div>
		</div>
	</body>
</html>