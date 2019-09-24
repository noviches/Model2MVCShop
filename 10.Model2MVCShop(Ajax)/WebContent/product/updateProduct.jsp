<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
	<head>
		<title>��ǰ����</title>
		
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	
		<!-- <script type="text/javascript" src="../javascript/calendar.js"></script> -->
		
		<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
		<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
		<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
		<script type="text/javascript">
			function fncUpdateProduct() {
				// Form ��ȿ�� ����
			 	// var name = document.detailForm.prodName.value;
				// var detail = document.detailForm.prodDetail.value;
				// var manuDate = document.detailForm.manuDate.value;
				// var price = document.detailForm.price.value;
				var name = $("input[name='prodName']").val();
				var detail = $("input[name='prodDetail']").val();
				var manuDate = $("input[name='manuDate']").val();
				var price = $("input[name='price']").val();
			
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
				
				// document.detailForm.action = '/product/updateProduct';
				// document.detailForm.submit();
				$("form").attr("method", "post").attr("action", "/product/updateProduct").attr("enctype", "multipart/form-data").submit();
			}
			//===========================================//
			
			$( function(){
				$("input[name='manuDate']").datepicker({
				    dateFormat:'yy-mm-dd'
				});
				
				$("td.ct_btn01:contains('����')").on("click", function(){
					// Debug..
					// alert($("td.ct_btn01:contains('����')").html());
					fncUpdateProduct();
				});
				
				$("td.ct_btn01:contains('���')").on("click", function(){
					// Debug..
					// alert($("td.ct_btn01:contains('���')").html());
					history.go(-1);
				});
			});
		</script>
	</head>
	
	<body bgcolor="#ffffff" text="#000000">
		<div style="width:98%; margin-left:10px;">
			<form name="detailForm">
				<input type="hidden" name="prodNo" value="${product.prodNo}" />
				<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="15" height="37">
						<img src="/images/ct_ttl_img01.gif" width="15" height="37" />
					</td>
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">��ǰ����</td>
							<td width="20%" align="right">&nbsp;</td>
						</tr>
						</table>
					</td>
					<td width="12" height="37">
						<img src="/images/ct_ttl_img03.gif" width="12" height="37" />
					</td>
				</tr>
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:13px;">
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="105">
								<input type="text" name="prodName" class="ct_input_g" style="width:150px; height:19px;" maxLength="20" value="${product.prodName}">
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						��ǰ������ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="prodDetail" value="${product.prodDetail}" class="ct_input_g" style="width:150px; height:19px;" maxLength="10"	minLength="6">
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						�������� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" readonly="readonly" name="manuDate" value="${product.manuDate}" class="ct_input_g" style="width:100px; height:19px;" maxLength="10" minLength="6">
						&nbsp;
						<!-- <img src="../images/ct_icon_date.gif" width="15" height="15" onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)" /> -->
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						���� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="price" value="${product.price}" class="ct_input_g" style="width:100px; height:19px;" maxLength="50" />&nbsp;��
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						���� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="number" name="reQuantity" value="${product.reQuantity}" class="ct_input_g" style="width:30px;" min="1">&nbsp;��
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">�������̹���</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="file" name="fileTitle" class="ct_input_g" style="width:200px; height:19px;" maxLength="13" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">��ǰ���̹���</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="file" name="file" class="ct_input_g" style="width:200px; height:19px;" maxLength="13" multiple />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
				<tr>
					<td width="53%"></td>
					<td align="right">
						<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23" />
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
								<!-- <a href="javascript:fncUpdateProduct();">����</a> -->
								<span style="cursor:pointer;">����</span>
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23" />
							</td>
							<td width="30"></td>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif"width="17" height="23" />
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
								<a href="javascript:history.go(-1);">���</a>
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23" />
							</td>
						</tr>
						</table>
					</td>
				</tr>
				</table>
			</form>
		</div>
	</body>
</html>