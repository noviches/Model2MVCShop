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
		
		<!-- jQuery UI toolTip ��� CSS -->
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		
		<!-- jQuery UI toolTip ��� JS-->
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		
		<!-- ///////////////////////// CSS ///////////////////////// -->
		<style>
			body {
				padding-top : 50px;
			}
		</style>
		
		<!-- ///////////////////////// JavaScript ///////////////////////// -->
		<script type="text/javascript">
		</script>
	</head>
	
	<body>
		<!-- ToolBar Start ///////////////////////////////////// -->
		<jsp:include page="/layout/toolbar.jsp" />
		<!-- ToolBar End ///////////////////////////////////// -->
	
		<!-- ȭ�鱸�� div Start ///////////////////////////////////// -->
		<div class="container">
			<div class="page-header text-info">
				<h3>����ı�</h3>
			</div>
			
			<!-- table ���� �˻� Start ///////////////////////////////////// -->
			<form class="form-inline" name="detailForm">
				<div class="row" style="margin-bottom:5px;">
					<div class="col-md-6 text-left">
						<p class="text-primary">
							��ü  ${ resultPage.totalCount } �Ǽ�, ���� ${ resultPage.currentPage } ������
						</p>
					</div>
				</div>
				<div class="row" style="margin-bottom:5px;">
					<div class="col-md-6 text-left">
						<div class="form-group">
							<label class="sr-only" for="searchKeyword">�˻���</label>
							<input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="�˻���" value="${ ! empty search.searchKeyword ? search.searchKeyword : '' }">
						</div>
						<button type="button" class="btn btn-default">�˻�</button>
						<!-- PageNavigation ���� ������ ���� ������ �κ� -->
						<input type="hidden" id="currentPage" name="currentPage" value="" />
					</div>
				</div>
			</form>
			<!-- table ���� �˻� End ///////////////////////////////////// -->
			
			<!-- table Start ///////////////////////////////////// -->
			<table class="table table-hover table-striped">
				<thead>
					<tr>
						<th align="center">No</th>
						<th align="center">��ǰ��</th>
						<th align="center">��ǰ����</th>
						<th align="center">�ۼ���</th>
						<th align="center">������</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="i" value="0" />
					<c:forEach var="review" items="${list}">
						<c:set var="i" value="${ i+1 }" />
						<tr>
							<td align="center">${ i }</td>
							<td align="left">
								<span style="cursor:pointer">${review.trans.purchaseProd.prodName}</span>
							</td>
							<td align="right">
								<span style="cursor:pointer">${review.content}</span>
							</td>
							<td align="right">
								<span style="cursor:pointer">${review.trans.buyer.userId}</span>
							</td>
							<td align="center">${review.good}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- table End ///////////////////////////////////// -->
		</div>
		<!-- ȭ�鱸�� div End ///////////////////////////////////// -->
		
		<!-- PageNavigation Start... -->
		<jsp:include page="../common/pageNavigator_new.jsp" />
		<!-- PageNavigation End... -->
	</body>
</html>