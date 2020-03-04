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
<title>已發送信息</title>
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
			data:{"id":id,"sendstatus":"不可查"},
			success:function(data){
				alert(data.msg);
				window.location.href="<%=basePath%>tb_message/tb_message_send";
			}
		});
	}	
	} 
//取消
function rst(currentPage){
		window.location.href="<%=basePath%>tb_message/tb_message_send?currentPage="+currentPage;
}
//分页跳转
function topage(oper) {
	var currentPage=${sendmessages.currentPage};
	var pageCount=${sendmessages.pageCount};
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
		window.location.href="<%=basePath%>tb_message/tb_message_send";
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
						<th scope="col">&nbsp;&nbsp;</th>
						<th scope="col">收件人</th>
						<th scope="col">标题</th>
						<th scope="col">發送時間</th>
						<th scope="col" rowspan="2">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="a" items="${sendmessages.getResultList()}">
						<tr>
							<td style="width: 5%;"><input name="delid" class="classId"
								type="checkbox" value="${a.id }" /></td>
							<td style="width: 25%;">${a.receiver }</td>
							<td style="width: 30%;">${a.title }</td>
							<td>${a.createtime }</td>
							<td><a class="btn btn-warning" type="button"
								onclick="javaScript:window.location.href='<%=basePath%>tb_message/tb_openMessage?id=${a.id}&status=${a.status}&flag='+'send';"
								target="msgfrm">查看 </a></td>
							<td><input class="btn btn-warning" type="button" id="del"
								onclick="del('${a.id}');" value="刪除" /></td>
							<td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="20">当前第${sendmessages.currentPage}页,共${sendmessages.pageCount}页
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
</body>
</html>