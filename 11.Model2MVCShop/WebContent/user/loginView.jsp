<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

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
		
		<!-- ///////////////////////// CSS ///////////////////////// -->
		<style>
			body > div.container { 
				border : 3px solid #D6CDB7;
				margin-top : 10px;
			}
		</style>
		
		<!-- ///////////////////////// JavaScript ///////////////////////// -->
		<script type="text/javascript">
			//============= "�α���" Event ���� =============
			$( function(){
				$("#userId").focus();
				
				//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2. (#id) : 3. $(.className)
				$("#button").on("click", function(){
					var id = $("input:text").val();
					var pw = $("input:password").val();
					
					if(id == null || id.length < 1) {
						alert('ID �� �Է����� �����̽��ϴ�.');
						$("#userId").focus();
						return;
					}
					
					if(pw == null || pw.length < 1) {
						alert('�н����带 �Է����� �����̽��ϴ�.');
						$("#password").focus();
						return;
					}
					
					/* $("form").attr("method", "POST").attr("action", "/user/login").attr("target", "_parent").submit(); */
					$.ajax( 
							{
								url : "/user/json/login",
								method : "POST",
								dataType : "json",
								headers : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								},
								data : JSON.stringify({
									userId : id,
									password : pw
								}),
								success : function(JSONData, status){
									// Debug...
									// alert(status);
									// alert("JSONData : \n"+JSONData);
									// alert("JSON.stringify(JSONData) : \n"+JSON.stringify(JSONData));
									// alert(JSONData != null);
									
									if(JSONData.userId != null) {
										$(window.parent.document.location).attr("href", "/index.jsp");
									}else {
										alert("���̵�, �н����带 Ȯ���Ͻð� �ٽ� �α����ϼ���.");
									}
								}
							}
					);
				});
			});
			
			//============= ȸ������ ȭ���̵� =============
			$( function(){
				//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$("a[href='#']").on("click", function(){
					self.location = "/user/addUser";
				});
			});
		</script>
		
		<script>
			var checkLoginStatus = function(response) {
				console.log(response);
				// statusChangeCallback(response);
				if(response.status === 'connected'){
					document.querySelector('#authBtn').value = 'Logout';
					FB.api('/me', 'POST', {"fields":"id,name,email,birthday,gender,picture"}, function(response) {
						// console.log(response);
						document.querySelector('#name').innerHTML = 'Welcome, ' + response.name + '<br>'
																	+ response.id + response.email + response.birthday + response.gender
																	+ response.picture.data.url;
						}
					);
				}else{
					document.querySelector('#authBtn').value = 'Login';
					document.querySelector('#name').innerHTML = '';
				}
			}
		
			window.fbAsyncInit = function() {
				FB.init({
					appId      : '448518875932242',
					cookie     : true,  // enable cookies to allow the server to access 
					                    // the session
					xfbml      : true,  // parse social plugins on this page
					version    : 'v3.3' // The Graph API version to use for the call
				});
				
				// Now that we've initialized the JavaScript SDK, we call 
				// FB.getLoginStatus().  This function gets the state of the
				// person visiting this page and can return one of three states to
				// the callback you provide.  They can be:
				//
				// 1. Logged into your app ('connected')
				// 2. Logged into Facebook, but not your app ('not_authorized')
				// 3. Not logged into Facebook and can't tell if they are logged into
				//    your app or not.
				//
				// These three cases are handled in the callback function.
				
				/*
				FB.getLoginStatus(function(response) {
					statusChangeCallback(response);
				});
				*/
				
				FB.getLoginStatus(checkLoginStatus);
			};
		
			// Load the SDK asynchronously
			(function(d, s, id) {
				var js, fjs = d.getElementsByTagName(s)[0];
				if (d.getElementById(id)) return;
				js = d.createElement(s); js.id = id;
				js.src = "https://connect.facebook.net/en_US/sdk.js";
				fjs.parentNode.insertBefore(js, fjs);
			}(document, 'script', 'facebook-jssdk'));
		</script>
	</head>
	
	<body>
		<input type="button" id="authBtn" value="checking..." onclick="
			if(this.value === 'Login'){
				// now logout
				FB.login(function(response){
					console.log('login => ', response);
					checkLoginStatus(response);
				});
			}else{
				// now login
				FB.logout(function(response){
					console.log('logout => ', response);
					checkLoginStatus(response);
				});
			}
		"><span id="name"></span>
	
		<!-- ToolBar Start ///////////////////////////////////// -->
		<div class="navbar navbar-default">
			<div class="container">
				<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
			</div>
		</div>
		<!-- ToolBar End ///////////////////////////////////// -->	
		
		<!-- ȭ�鱸�� div Start ///////////////////////////////////// -->
		<div class="container">
			<!-- row Start ///////////////////////////////////// -->
			<div class="row">
				<div class="col-md-6">
					<img src="/images/logo-spring.png" class="img-rounded" width="100%" />
				</div>
				<div class="col-md-6">
					<br/><br/>
					<div class="jumbotron">	 	 	
						<h1 class="text-center">��&nbsp;&nbsp;��&nbsp;&nbsp;��</h1>
						<form class="form-horizontal">
							<div class="form-group">
								<label for="userId" class="col-sm-4 control-label">�� �� ��</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" name="userId" id="userId" placeholder="���̵�">
								</div>
							</div> 
							<div class="form-group">
								<label for="password" class="col-sm-4 control-label">�� �� �� ��</label>
								<div class="col-sm-6">
									<input type="password" class="form-control" name="password" id="password" placeholder="�н�����">
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-offset-4 col-sm-6 text-center">
									<button type="button" class="btn btn-primary">��&nbsp;��&nbsp;��</button>
									<a class="btn btn-primary btn" href="#" role="button">ȸ&nbsp;��&nbsp;��&nbsp;��</a>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- row Start ///////////////////////////////////// -->
		</div>
		<!-- ȭ�鱸�� div End ///////////////////////////////////// -->
	</body>
</html>