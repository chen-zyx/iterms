<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
session.setAttribute("bpath", basePath);%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>CAE模型资源管理系统登录</title>
		<link href="<%=basePath%>css/simdahs.css" rel="stylesheet"/>
		<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet"/>
		<link href="<%=basePath%>css/style.css" rel="stylesheet"/>
		<script type="text/javascript" src="<%=basePath%>js/jquery-2.2.3.min.js"></script>
		<script type="text/javascript">
			function lgbt(){
				var uname=$("#uname").val();
				var upassword=$("#upassword").val();
				if(uname==""||upassword==""){
					alert("请输入完整的登录信息");
					return;
				}
				$.ajax({
					url:'<%=basePath%>login/login',
					type:'post',
					dataType:'json',
					data:{"uname":uname,"upassword":upassword,"utype":"tb_users"},
					success:function(data){
						if(data.msg==1){
							window.location.href="<%=basePath%>views/main.jsp";
						}else{
							alert(data.msg);
							
						}
					}
				});
			}
		</script>
	</head>
	<body style="background: url(<%=basePath%>css/bg2.jpg)" class="bg-primary">
		<div class="unix-login">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 col-lg-offset-3">
						<div class="login-content">
							<div class="login-logo">
							</div>
							<div class="login-form">
								<h4>CAE模型资源管理系统</h4>
								<form>
								<div class="form-group">
									<label for="uname">账号</label>
									<input id="uname" name="uname" type="text" class="form-control" placeholder="用户账号"/>
								</div>
								<div class="form-group">
									<label for="upassword">密码</label>
									<input id="upassword" name="upassword" type="password" class="form-control" placeholder="登录密码"/>
								</div>
								<button type="button" class="btn btn-primary btn-flat m-b-30 m-t-30" onclick="lgbt();">登录</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
