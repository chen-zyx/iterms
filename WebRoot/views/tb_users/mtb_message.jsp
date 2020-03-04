<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<meta charset="UTF-8">
<title>消息通知</title>
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath%>css/themify-icons.css" rel="stylesheet">
<link href="<%=basePath%>css/simdahs.css" rel="stylesheet">
<link href="<%=basePath%>css/sidebar.css" rel="stylesheet">
<link href="<%=basePath%>css/style.css" rel="stylesheet">
<link href="<%=basePath%>css/dialog.css" rel="stylesheet">
<script src="<%=basePath%>js/jquery-2.2.3.min.js"></script>
<!-- jquery vendor -->
<script src="<%=basePath%>js/jquery.nanoscroller.min.js"></script>
<!-- nano scroller -->
<script src="<%=basePath%>js/sidebar.js"></script>
<!-- sidebar -->
<script src="<%=basePath%>js/bootstrap.min.js"></script>
<!-- bootstrap -->
<script type="text/javascript" src="<%=basePath%>js/syssmp.js"></script>
<!-- jquery vendor -->
<script type="text/javascript">
	function sendMsg() {
		$("#sender").val("${user.uemail}");
		var sender=$("#sender").val();
		var receiver=$("#receiver").val();
		var title=$("#title").val();
		var content=$("#content").val();
		if(receiver==null||receiver==""){
			alert("请填写收件人!");
			return;
		}
		if(!ckEmail(receiver)){
			alert("請輸入正確的郵箱!");
			return;
		}
		if(title==""||title==null){
			alert("请填写标题!");
			return;
		}
		if(content==""||content==null){
			alert("请完善邮件内容!");
			return;
		}
		$.ajax({
			url:'<%=basePath%>tb_message/tb_message_add',
			type:'post',
			data:{"sender":sender,"receiver":receiver,"title":title,"content":content},
			dataType:'json',
			success:function(data){
				alert(data.msg);
				rst();
			}
		});
	}
	//取消
	function rst(){
			window.location.href="<%=basePath%>tb_message/tb_message_show";
	}
	//回复
	function reply(sender) {
		if(sender!=null && sender!=""){
			$("#receiver").val(sender);
		}else{
			$("#receiver").val("");
		}
		$("#sender").val("${user.uemail}");
	}
</script>
</head>
<body>
	<div class="main">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-4 p-0" style="width: 200px;">
					<div class="page-header">
						<div class="page-title">
							<h1>我的郵件</h1>
						</div>
					</div>
				</div>
				<!-- /# column -->
				<div class="col-lg-8 p-0">
					<div class="page-header">
						<div class="page-title">
							<a class="btn btn=warning" href="<%=basePath%>tb_message/tb_message_unread" style="margin-top: 10px;" target="msgfrm">未查看</a> 
							<a class="btn btn=warning" href="<%=basePath%>tb_message/tb_message_read" style="margin-top: 10px;" target="msgfrm">已查看</a> 
							<a class="btn btn=warning" data-toggle="modal" data-target="#msgdiv" onclick="reply();" style="margin-top: 10px;" target="msgfrm">发邮件</a>
							<a class="btn btn=warning" href="<%=basePath%>tb_message/tb_message_send" style="margin-top: 10px;" target="msgfrm">已发送</a> 
						</div>
					</div>
				</div>
				<!-- /# column -->
			</div>
		</div>
		<div class="content-wrap">
			<iframe frameborder="0" scrolling="no" id="msgfrm" name="msgfrm"
				onload="changeFrameHeight();"
				style="width: 100%; min-height: 500px;" <c:if test="${sessionScope.count==0}"> src="<%=basePath%>tb_message/tb_message_read"</c:if>
				<c:if test="${sessionScope.count!=0}">src="<%=basePath%>tb_message/tb_message_unread"</c:if> > </iframe>
		</div>
		<!-- 弹窗 -->
		<div class="modal fade" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" data-backdrop="static"
			aria-hidden="true" id="msgdiv">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">发邮件</h4>
					</div>
					<div class="modal-body">
						<div class="row"
							style="width: 750px; height: 400px; margin-left: 30px;">
							<span>發&nbsp;&nbsp;件&nbsp;&nbsp;人 :</span>&nbsp;&nbsp;<input
								type="text" id="sender" disabled="disabled" size="25"> <br>
							<br> <span>收&nbsp;&nbsp;件&nbsp;&nbsp;人 :</span>&nbsp;&nbsp;<input
								type="text" id="receiver" size="25"> <br> <br>
							<span>邮件标题 :</span>&nbsp;&nbsp;<input type="text" id="title"
								size="25"> <br> <br> <span
								style="vertical-align: top;">邮件内容 :</span>&nbsp;&nbsp;
							<textarea rows="10" cols="100%" id="content"></textarea>
							<br> <br>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-warning" onclick="sendMsg()">发送</button>
							<button type="button" class="btn btn-warning" onclick="rst()">退出</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal -->
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function changeFrameHeight() {
			var ifm = document.getElementById("msgfrm");
			var ifmw = ifm.contentWindow;
			ifm.height = ifmw.document.documentElement.scrollHeight
					|| ifmw.document.body.scrollHeight;
			$("#msgfrm").css("min-height", "700px");
		}
		window.onresize = function() {
			changeFrameHeight();
		}
	</script>
</body>
</html>