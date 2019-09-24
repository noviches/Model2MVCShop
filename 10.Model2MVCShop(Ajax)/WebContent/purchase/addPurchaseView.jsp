<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
	<head>
		<title>��ǰ����ȸ</title>
		
		<link rel="stylesheet" href="/css/admin.css" type="text/css">
		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		
		<!-- <script type="text/javascript" src="../javascript/calendar.js"></script> -->
		
		<!-- CDN(Content Delivery Network) ȣ��Ʈ ��� -->
		<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
		<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
		<script type="text/javascript">
			function fncAddPurchase() {
				// document.addPurchase.submit();
				$("form").attr("method", "post").attr("action", "/purchase/addPurchase").submit();
			}
			
			function totalPrice(price, quantity) {
				var total = price * quantity;
				
				$("input[name='totalPrice']").val(total);
				// $("input[name='totalPrice']").parent().append(total+" ��");
				$("span[name='total']").text(total+" ��");
			}
			
			$( function(){
				$("input[name='divyDate']").datepicker({
				    dateFormat:'yy-mm-dd'
				});
				
				$("input[name='quantity']").on("change", function(){
					totalPrice("${product.price}", $(this).val());
				});
				
				$("td.ct_btn01:contains('����')").on("click", function(){
					// Debug..
					// alert($("td.ct_btn01:contains('����')").html());
					fncAddPurchase();
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
			<form name="addPurchase">
				<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="15" height="37">
						<img src="/images/ct_ttl_img01.gif" width="15" height="37" />
					</td>
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">��ǰ����ȸ</td>
							<td width="20%" align="right">&nbsp;</td>
						</tr>
						</table>
					</td>
					<td width="12" height="37">
						<img src="/images/ct_ttl_img03.gif" width="12" height="37" />
					</td>
				</tr>
				</table>
				
				<table width="600" border="0" cellspacing="0" cellpadding="0" align="center" style="margin-top:13px;">
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="300" class="ct_write">
						��ǰ��ȣ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01" width="299">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="105">${product.prodNo}</td>
							<input type="hidden" name="prodNo" value="${product.prodNo}" />
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.prodName}</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						��ǰ������ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.prodDetail}</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">��������</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.manuDate}</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">����</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.price}&nbsp;��</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">��������</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.reQuantity}&nbsp;��</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">�������</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${product.regDate}</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">
						�����ھ��̵� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
					</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">${user.userId}</td>
					<input type="hidden" name="buyerId" value="${user.userId}" />
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">���Ź��</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<select name="paymentOption" class="ct_input_g" style="width:100px; height:19px;" maxLength="20">
							<option value="1">���ݱ���</option>
							<option value="2">�ſ뱸��</option>
						</select>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">�������̸�</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="receiverName" class="ct_input_g" style="width:150px; height:19px;" maxLength="20" value="${user.userName}" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">�����ڿ���ó</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="receiverPhone" class="ct_input_g" style="width:150px; height:19px;" maxLength="20" value="${user.phone}" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">�������ּ�</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="divyAddr" class="ct_input_g" style="width:150px; height:19px;" maxLength="20" value="${user.addr}" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">���ſ�û����</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="text" name="divyRequest" class="ct_input_g" style="width:150px; height:19px;" maxLength="20" />
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">���ż���</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="number" name="quantity" class="ct_input_g" style="width:30px;" min="1">&nbsp;��
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">����������</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td width="200" class="ct_write01">
						<input type="text" readonly="readonly" name="divyDate" class="ct_input_g" style="width:100px; height:19px;" maxLength="20" />
						<!-- <img src="../images/ct_icon_date.gif" width="15" height="15" onclick="show_calendar('document.addPurchase.divyDate', document.addPurchase.divyDate.value)" /> -->
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				<tr>
					<td width="104" class="ct_write">�ѱ��Աݾ�</td>
					<td bgcolor="D6D6D6" width="1"></td>
					<td class="ct_write01">
						<input type="hidden" name="totalPrice" />
						<span name="total"></span>
					</td>
				</tr>
				<tr>
					<td height="1" colspan="3" bgcolor="D6D6D6"></td>
				</tr>
				</table>
				
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
				<tr>
					<td width="53%"></td>
					<td align="center">
						<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23" />
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
								<!-- <a href="javascript:fncAddPurchase();">����</a> -->
								<span style="cursor:pointer">����</span>
							</td>
							<td width="14" height="23">
								<img src="/images/ct_btnbg03.gif" width="14" height="23" />
							</td>
							<td width="30"></td>
							<td width="17" height="23">
								<img src="/images/ct_btnbg01.gif" width="17" height="23" />
							</td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
								<!-- <a href="javascript:history.go(-1);">���</a> -->
								<span style="cursor:pointer">���</span>
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