<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>郵件</title>
<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath%>css/themify-icons.css" rel="stylesheet">
<link href="<%=basePath%>css/simdahs.css" rel="stylesheet">
<link href="<%=basePath%>css/sidebar.css" rel="stylesheet">
<link href="<%=basePath%>css/style.css" rel="stylesheet">
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
		window.location.href="<%=basePath%>tb_message/tb_message_read";
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
		<div class="main-content">
			<div class="card-header">
				<span>發件人 :</span>&nbsp;&nbsp;<input type="text"
					value="${sessionScope.message.sender}" disabled="disabled"
					size="20"><br>
				<br> <span>收件人 :</span>&nbsp;&nbsp;<input type="text"
					value="${sessionScope.message.receiver}" disabled="disabled"
					size="20"><br>
				<br> <span>時間:</span>&nbsp;&nbsp;<%=session.getAttribute("receivetime")%><br><br>
			</div>
			<div class="card-body" style="border: 1px solid grey;">
					<div style="width:100%;text-align: center;">
						<h4>${sessionScope.message.title}</h4>
					</div>
					<hr>
					<div style="width:100%;height:300px;text-align: center;margin: 0 auto;line-height: 80px;">
						<p style="font-size: 12;">${sessionScope.message.content}</p>
					</div>
			</div>
			<c:if test="${flag!='send'}">
				<div class="card-footer" style="text-align: center;margin-top: 15px;">
					<input type="button" class="btn btn-warning" data-toggle="modal" data-target="#msgdiv" onclick="reply('${sessionScope.message.sender}')" value="回复" />
				</div>
			</c:if>
		</div>
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
								type="text" id="receiver" disabled="disabled" size="25"> <br> <br>
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
</body>
</html>