<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>模型记录管理</title>
		<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
		<link href="<%=basePath%>css/themify-icons.css" rel="stylesheet">
		<link href="<%=basePath%>css/simdahs.css" rel="stylesheet">
		<link href="<%=basePath%>css/sidebar.css" rel="stylesheet">
		<link href="<%=basePath%>css/style.css" rel="stylesheet">
		<script src="<%=basePath%>js/jquery-2.2.3.min.js"></script><!-- jquery vendor -->
		<script src="<%=basePath%>js/jquery.nanoscroller.min.js"></script><!-- nano scroller -->
		<script src="<%=basePath%>js/sidebar.js"></script><!-- sidebar -->
		<script src="<%=basePath%>js/bootstrap.min.js"></script><!-- bootstrap -->
		<script type="text/javascript" src="<%=basePath%>js/syssmp.js"></script>
		<script type="text/javascript">
			$(function(){
				var modalHeight = $(window).height() / 2 - $('#gldiv .modal-dialog').height() / 2;
				$("#gldiv").find('.modal-dialog').css({
					'margin-top': modalHeight
				});
			});
			
			//取消
			function rst(){
				window.location.href="<%=basePath%>tb_hmark/tb_users_apage?pnum=${pagenum}";
			}
			function delsbt(){
				var ids="";
				$("input:checkbox").each(
					function(){
						if($(this).prop("checked")){
							var nm=$(this).prop("name");
							if(nm.indexOf("delid")==0){
								ids+=$(this).val()+",";
							}
						}
					}
				);
				if(ids==""){
					alert("请选择所要删除的数据.");
					return;
				};
				$.ajax({
					url:'<%=basePath%>tb_hmark/del',
					type:'post',
					dataType:'json',
					data:{"ids":ids},
					success:function(data){
						alert(data.msg);
						rst();
					}
				});
			}
		</script>
	</head>
	<body>
		<div class="main">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-4 p-0">
						<div class="page-header">
							<div class="page-title">
								<h1>模型记录管理</h1>
							</div>
						</div>
					</div><!-- /# column -->
					<div class="col-lg-8 p-0">
						<div class="page-header">
							<div class="page-title">
								&nbsp;
							</div>
						</div>
					</div><!-- /# column -->
				</div><!-- /# row -->
				<div class="main-content">
					<div class="row">
						<div class="col-lg-12">
							<div class="card alert">
								<div class="card-header">
								<form action="<%=basePath%>tb_hmark/tb_users_ck" method="post">
									<div class="form-group" style="">
										<label for="cktb_model_id" class="control-label" style="width: 70px;float: left;">所属项目：</label>
										<select id="cktb_model_id" name='tb_iterms_id' class="form-control input-sm" style="float: left;width: 100px;margin-right: 5px;">
											<option value='0'>所有项目</option>
											<c:forEach var="a" items="${tb_itermslist }">
												<option value="${a.id}">${a.itname}</option>
											</c:forEach>
										</select>
									</div>
									
									<div class="form-group">
										<input class="btn btn-warning" type="submit" onclick="cktj();" value="查询"/>
										<input class="btn btn-warning" type="button" onclick="delsbt();" value="删除"/>
									</div>
								</form>
								</div>
								<div class="card-body">
									<table class="table table-bordered table-hover ">
										<thead>
											<tr>
												<th style="width:5%;"></th>
												<th>模型名称</th>
												<th>工号</th>
												<th>姓名</th>
												<th>操作标识</th>
												<th>ip地址</th>
												<th>时间</th>
												<th style="width:1%;"></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="a" items="${alist }">
											<tr>
												<td style="width:5%;"><input name="delid" type="checkbox" value="${a.id }"/></td>
												<td>${a.mname }</td>
												<td>${a.uno }</td>
												<td>${a.uname }</td>
												<td>${a.hflag }</td>
												<td>${a.ipaddr }</td>
												<td>${fn:substring(a.htime,0,10) }</td>
												<td></td>
											</tr>
											</c:forEach>
										</tbody>
										<tfoot>
											<tr>
												<td colspan="20">
													当前第${pagenum}页,共${pagenums}页 
													<span style="float: right;margin-right: 60px;">
														<a class="btn btn=warning" href="<%=basePath%>tb_hmark/tb_users_apage?pnum=1">首页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_hmark/tb_users_apage?pnum=${pagenum-1}">上一页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_hmark/tb_users_apage?pnum=${pagenum+1}">下一页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_hmark/tb_users_apage?pnum=${pagenums}">尾页</a>
													</span>
												</td>
											</tr>
										</tfoot>
									</table>
								</div>
							</div>
						</div><!-- /# column -->
					</div><!-- /# row -->
				</div>
			</div><!-- /# container-fluid -->
		</div><!-- /# main -->
		<script type="text/JavaScript" src="<%=basePath %>js/My97DatePicker/WdatePicker.js"></script>
	</body>
</html>
