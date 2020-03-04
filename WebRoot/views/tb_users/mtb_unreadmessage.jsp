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
<title>未读信息</title>
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
	 function del(id) {
		if(confirm("是否要刪除該郵件？")){
			$.ajax({
				url:'<%=basePath%>tb_message/del',
				type:'post',
				dataType:'json',
				data:{"id":id,"status":"不可查看"},
				success:function(data){
					alert(data.msg);
					window.location.href="<%=basePath%>tb_message/tb_message_unread";
				}
			});
		}	
 	} 
	function sendMsg(currentPage) {
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
				rst(currentPage);
			}
		});
	}
	//取消
	function rst(currentPage){
			window.location.href="<%=basePath%>tb_message/tb_message_unread?currentPage="+currentPage;
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
	//分页跳转
	function topage(oper) {
		var currentPage=${messages.currentPage};
		var pageCount=${messages.pageCount};
		switch (oper) {
		case 'start':
			currentPage=1;
			rst(currentPage);
			break;
		case 'pre':
			currentPage=currentPage-1;
			if(currentPage<1){
				currentPage=1;
			}
			rst(currentPage);
			break;
		case 'next':
			currentPage=currentPage+1;
			if(currentPage>pageCount){
				currentPage=pageCount;
			}
			rst(currentPage);
			break;
		case 'end':
			currentPage=pageCount;
			rst(currentPage);
			break;
		default:
			window.location.href="<%=basePath%>tb_message/tb_message_read";
			break;
		}
	}
</script>
</head>
<body>
<div class="main-content">
			<table class="table table-striped" style="width: 1000px;">
				<thead>
					<tr>
						<th scope="col">未读</th>
						<th scope="col">发送人</th>
						<th scope="col">标题</th>
						<th scope="col">發送時間</th>
						<th scope="col" rowspan="2">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="a" items="${messages.getResultList()}">
						<tr>
							<td style="width: 5%;"><input name="delid" class="classId"
								type="checkbox" value="${a.id }" /></td>
							<td style="width: 25%;">${a.sender }</td>
							<td style="width: 30%;">${a.title }</td>
							<td>${a.createtime }</td>
							<td><a class="btn btn-warning" type="button"
								onclick="javaScript:window.location.href='<%=basePath%>tb_message/tb_openMessage?id=${a.id}&status=${a.status}';"
								target="msgfrm">查看 </a></td>
							<%-- <td><input class="btn btn-warning" type="button" id="del"
								onclick="del('${a.id}');" value="刪除" /></td>
							<td><input class="btn btn-warning" type="button"
								data-toggle="modal" data-target="#msgdiv"
								onclick="reply('${a.sender}');" value="回復" /></td> --%>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="20">当前第${messages.currentPage}页,共${messages.pageCount}页
							<span style="float: right; margin-right: 60px;"> 
								<a class="btn btn=warning" onclick="topage('start');">首页</a>
								<a class="btn btn=warning" onclick="topage('pre');">上一页</a> 
								<a class="btn btn=warning" onclick="topage('next');">下一页</a> 
								<a class="btn btn=warning" onclick="topage('end');">尾页</a>
						</span>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		<hr>
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
							<button type="button" class="btn btn-warning" onclick="sendMsg('${messages.currentPage}')">发送</button>
							<button type="button" class="btn btn-warning" onclick="rst('${messages.currentPage}')">退出</button>
						</div>
					</div>
					<!-- /.modal-content -->
				</div>
				<!-- /.modal -->
			</div>
		</div>
</body>
</html>