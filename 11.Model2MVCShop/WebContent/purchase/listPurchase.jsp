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
		
		<!-- jQuery UI toolTip ��� CSS-->
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
			function fncGetList(currentPage) {
				$("#currentPage").val(currentPage);
			   	$("form").attr("method", "POST").attr("action", "/purchase/listPurchase").submit();
			}
			
			$( function(){
				$("select[name='searchCode']").on("change", function(){
					fncGetList(1);
				});
				
				$("td:nth-child(1)").on("click", function(){
					self.location = "/purchase/getPurchase?tranNo="+$("input:hidden[name='tranNo']").val();
				});
				
				$("td:nth-child(2)").on("click", function(){
					self.location = "/user/getUser?userId="+$(this).text().trim();
				});
				
				$("#orderRemove").on("click", function(){
					fncGetList(1);
				});
				
				$("td:nth-child(8) span:contains('����ϱ�')").on("click", function(){
					self.location = "/purchase/updateTranCode?tranNo="+$(this).parent().find($("input:hidden[name='tranNo']")).val()+"&tranCode=2";
				});
				
				$("td:nth-child(8) span:contains('�����������')").on("click", function(){
					self.location = "/purchase/updatePurchase?tranNo="+$(this).parent().find($("input:hidden[name='tranNo']")).val();
				});
				
				$("td:nth-child(8) span:contains('���ǵ���')").on("click", function(){
					self.location = "/purchase/updateTranCode?tranNo="+$(this).parent().find($("input:hidden[name='tranNo']")).val()+"&tranCode=3";
				});
				
				$("td:nth-child(8) span:contains('�ֹ����')").on("click", function(){
					self.location = "/purchase/deletePurchase?tranNo="+$(this).parent().find($("input:hidden[name='tranNo']")).val()+"&tranCode=4";
				});
			});
			
			//==> �߰��� �κ� : "����" Event ó�� �� ����
			$( function(){
				/*
				$("td:nth-child(9) span:contains('���亸��')").on("click", function(){
					window.open("/review/getReview?tranNo="+$(this).parent().find($("input:hidden[name='tranNo']")).val(), "getReviewPopup", "width=600, height=400, left=100, top=50");
				});
				
				$("td:nth-child(9) span:contains('���侲��')").on("click", function(){
					window.open("/review/addReview?tranNo="+$(this).parent().find($("input:hidden[name='tranNo']")).val(), "addReviewPopup", "width=600, height=400, left=100, top=50");
				});
				*/
				$("#rev span").on("click", function(){
					var tranNo = $(this).parent().find($("input:hidden[name='tranNo']")).val();
					
					if($.trim($(this).text()) == '���亸��') {
						window.open("/review/getReview?tranNo="+tranNo, "getReviewPopup", "width=600, height=400, left=100, top=50");
					}else {
						window.open("/review/addReview?tranNo="+tranNo, "addReviewPopup", "width=600, height=400, left=100, top=50");
					}
				});
			});
			
			function reviewList(tranNo) {
				$.ajax( 
						{
							url : "/review/json/getReview/"+tranNo,
							method : "GET",
							dataType : "json",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData, status){
								if(JSONData.reviewNo != null) {
									$("td:nth-child(9) span").text("���亸��");
								}
						}
				});
			}
		</script>
	</head>
	
	<body>
		<!-- ToolBar Start ///////////////////////////////////// -->
		<jsp:include page="/layout/toolbar.jsp" />
		<!-- ToolBar End ///////////////////////////////////// -->
		
		<!-- ȭ�鱸�� div Start ///////////////////////////////////// -->
		<div class="container">
			<div class="page-header text-info">
				<h3>
					<c:if test="${sessionScope.user.role eq 'admin'}">
						���Ż��� ��ȸ
					</c:if>
					<c:if test="${sessionScope.user.role ne 'admin'}">
						���Ÿ�� ��ȸ
					</c:if>
				</h3>
			</div>
			
			<!-- table ���� �˻� Start ///////////////////////////////////// -->
			<div class="row" style="margin-bottom:5px;">
				<div class="col-md-6 text-left">
					<p class="text-primary">
						��ü  ${ resultPage.totalCount } �Ǽ�, ���� ${ resultPage.currentPage } ������
					</p>
				</div>
				<div class="col-md-6 text-right">
					<form class="form-inline" name="detailForm">
						<div class="form-group">
							<c:if test="${sessionScope.user.role eq 'user'}">
								<span id="orderRemove" class="btn btn-primary">�ֹ���ҳ���</span>
								<input type="hidden" name="searchCode" value="4" />
							</c:if>
							<c:if test="${sessionScope.user.role eq 'admin'}">
								<select name="searchCode" class="form-control" onchange="javascript:fncGetList('1');">
									<option value="" ${ ! empty search.searchCode ? "selected" : "" }>��ü����</option>
									<option value="1" ${ ! empty search.searchCode && search.searchCode eq 1 ? "selected" : "" }>���ſϷ� ��ǰ</option>
									<option value="2" ${ ! empty search.searchCode && search.searchCode eq 2 ? "selected" : "" }>������� ��ǰ</option>
									<option value="3" ${ ! empty search.searchCode && search.searchCode eq 3 ? "selected" : "" }>��ۿϷ� ��ǰ</option>
								</select>
							</c:if>
						</div>
						<!-- PageNavigation ���� ������ ���� ������ �κ� -->
						<input type="hidden" id="currentPage" name="currentPage" value="" />
					</form>
				</div>
			</div>
			<!-- table ���� �˻� End ///////////////////////////////////// -->
			
			<!-- table Start ///////////////////////////////////// -->
			<table class="table table-hover table-striped">
				<thead>
					<tr>
						<th align="center">No</th>
						<th align="center">ȸ�� ID</th>
						<th align="center">�����ڸ�</th>
						<th align="center">��ȭ��ȣ</th>
						<th align="center">��������</th>
						<th align="center">�����Ȳ</th>
						<th align="center">�ֹ���</th>
						<th align="center">��������</th>
						<th align="center">����ı�</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="i" value="0" />
					<c:forEach var="purchase" items="${list}">
						<c:set var="i" value="${ i+1 }" />
						<tr>
							<td align="center">
								<span style="cursor:pointer">${ i }</span>
							</td>
							<td align="left">
								<span style="cursor:pointer">${purchase.buyer.userId}</span>
							</td>
							<td align="left">${purchase.receiverName}</td>
							<td align="center">${purchase.receiverPhone}</td>
							<td align="center">${purchase.divyDate}</td>
							<td align="center">
								����
								<c:if test="${purchase.tranCode eq null || purchase.tranCode eq '0'}">
									�Ǹ� ��
								</c:if>
								<c:if test="${purchase.tranCode eq '1'}">
									���ſϷ�
								</c:if>
								<c:if test="${purchase.tranCode eq '2'}">
									��� ��
								</c:if>
								<c:if test="${purchase.tranCode eq '3'}">
									��ۿϷ�
								</c:if>
								���� �Դϴ�.
							</td>
							<td align="center">${purchase.orderDate}</td>
							<td align="center">
								<input type="hidden" name="tranNo" class="tranNo" value="${purchase.tranNo}">
								<c:if test="${sessionScope.user.role eq 'admin'}">
									<c:if test="${purchase.tranCode eq '1'}">
										<span style="cursor:pointer">����ϱ�</span>
									</c:if>
								</c:if>
								<c:if test="${sessionScope.user.role ne 'admin'}">
									<c:if test="${purchase.tranCode eq '1'}">
										<span style="cursor:pointer">�����������</span>
										&nbsp;&nbsp;
										<span style="cursor:pointer">�ֹ����</span>
									</c:if>
									<c:if test="${purchase.tranCode eq '2'}">
										<span style="cursor:pointer">���ǵ���</span>
									</c:if>
								</c:if>
							</td>
							<td align="center" id="rev">
								<input type="hidden" name="tranNo" class="tranNo" value="${purchase.tranNo}">
								<c:if test="${purchase.reviewCount ne 0}">
									<span style="cursor:pointer">���亸��</span>
								</c:if>
								<c:if test="${sessionScope.user.role eq 'user' and purchase.reviewCount eq 0 and purchase.tranCode eq '3'}">
									<span style="cursor:pointer">���侲��</span>
								</c:if>
							</td>
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