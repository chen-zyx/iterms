<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>用户信息管理</title>
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
			/**
			$(function(){
				var modalHeight = $(window).height() / 2 - $('#gldiv .modal-dialog').height() / 2;
				$("#gldiv").find('.modal-dialog').css({
					'margin-top': modalHeight
				});
			});
			**/
			function addbt(){
				$("#flagi").val("add");
				$("#guno").val('');
				$("#guname").val('');
				$("#guemail").val('');
				$("#gupwd").val('');
				$("#guflag").val('是');
				$("#gutype").val('普通用户');
			}
			function updbt(id){
				$.ajax({
					url:'<%=basePath%>tb_users/getdata',
					type:'post',
					dataType:'json',
					data:{"id":id},
					success:function(data){
						var ob=data.ob;
						$("#flagi").val("upd");
						$("#idi").val(id);
						$("#guno").val(ob.uno);
						$("#guname").val(ob.uname);
						$("#guemail").val(ob.uemail);
						$("#gupwd").val(ob.upwd);
						$("#guflag").val(ob.uflag);
						$("#gutype").val(ob.utype);
					}
				});
			}
			//保存
			function gltj(){
				var uno=$("#guno").val();
				var uname=$("#guname").val();
				var uemail=$("#guemail").val();
				var upwd=$("#gupwd").val();
				var uflag=$("#guflag").val();
				var utype=$("#gutype").val();
				var id=$("#idi").val();
				var flag=$("#flagi").val();
				if(uno==""||uname==""||uemail==""||upwd==""||uflag==""||utype==""){
					alert('用户信息不完整。');
					return;
				}
				if(!ckEmail(uemail)){
					alert("邮箱输入有误");
					return;
				}
				if("add"==flag){
					$.ajax({
						url:'<%=basePath%>tb_users/tb_users_add',
						type:'post',
						data:{"uno":uno,"uname":uname,"uemail":uemail,"upwd":upwd,"uflag":uflag,"utype":utype},
						dataType:'json',
						success:function(data){
							alert(data.msg);
							window.location.href="<%=basePath%>tb_users/tb_users_apage?pnum=${pagenum}";
						}
					});
				}
				if("upd"==flag){
					$.ajax({
						url:'<%=basePath%>tb_users/tb_users_upd',
						type:'post',
						data:{"uno":uno,"uname":uname,"uemail":uemail,"upwd":upwd,"uflag":uflag,"utype":utype,"id":id},
						dataType:'json',
						success:function(data){
							alert(data.msg);
							window.location.href="<%=basePath%>tb_users/tb_users_apage?pnum=${pagenum}";
						}
					});
				}
			}
			//取消
			function rst(){
				window.location.href="<%=basePath%>tb_users/tb_users_apage?pnum=${pagenum}";
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
					url:'<%=basePath%>tb_users/del',
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
								<h1>用户信息编辑</h1>
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
								<form action="<%=basePath%>tb_users/tb_users_ck" method="post">
									<div class="form-group" style="">
										<label for="ckuno" class="control-label" style="width: 70px;float: left;">工号：</label>
										<input id="ckuno" name="uno" type="text" class="form-control input-sm" style="float: left;width: 100px;margin-right: 5px;"/>
									</div>
									<div class="form-group" style="">
										<label for="ckuname" class="control-label" style="width: 70px;float: left;">姓名：</label>
										<input id="ckuname" name="uname" type="text" class="form-control input-sm" style="float: left;width: 100px;margin-right: 5px;"/>
									</div>
									<div class="form-group">
										<input class="btn btn-warning" type="submit" onclick="cktj();" value="查询"/>
										<input class="btn btn-warning" type="button" onclick="addbt();" data-toggle="modal" data-target="#gldiv" value="添加"/>
										<input class="btn btn-warning" type="button" onclick="delsbt();" value="删除"/>
									</div>
								</form>
								</div>
								<div class="card-body">
									<table class="table table-bordered table-hover ">
										<thead>
											<tr>
												<th style="width:5%;"></th>
												<th>工号</th>
												<th>姓名</th>
												<th>邮箱</th>
												<th>密码</th>
												<th>可用</th>
												<th>用户权限</th>
												<th>上传次数</th>
												<th>下载次数</th>
												<th style="width:5%;"></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="a" items="${alist }">
											<tr>
												<td style="width:5%;"><input name="delid" type="checkbox" value="${a.id }"/></td>
												<td>${a.uno }</td>
												<td>${a.uname }</td>
												<td>${a.uemail }</td>
												<td>${a.upwd }</td>
												<td>${a.uflag }</td>
												<td>${a.utype }</td>
												<td>${a.upnums }</td>
												<td>${a.dnums }</td>
												<td><input class="btn btn-warning" type="button" data-toggle="modal" data-target="#gldiv" onclick="updbt('${a.id}');" value="修改"/></td>
											</tr>
											</c:forEach>
										</tbody>
										<tfoot>
											<tr>
												<td colspan="20">
													当前第${pagenum}页,共${pagenums}页 
													<span style="float: right;margin-right: 60px;">
														<a class="btn btn=warning" href="<%=basePath%>tb_users/tb_users_apage?pnum=1">首页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_users/tb_users_apage?pnum=${pagenum-1}">上一页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_users/tb_users_apage?pnum=${pagenum+1}">下一页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_users/tb_users_apage?pnum=${pagenums}">尾页</a>
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
		<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" aria-hidden="true" id="gldiv" >
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">
							用户信息编辑
						</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-lg-3">
								&nbsp;
							</div><!-- /# column -->
							<div class="col-lg-6">
								<div class="card alert">
									<div class="card-body">
										<div class="input-sizes">
											<form class="form-horizontal">
												<div class="form-group">
													<label for="guno" class="col-sm-4 control-label">工号：</label>
													<div class="col-sm-8">
														<input name="guno" id="guno" class="form-control input-sm"/>
													</div>
												</div>
												<div class="form-group">
													<label for="guname" class="col-sm-4 control-label">姓名：</label>
													<div class="col-sm-8">
														<input name="guname" id="guname" class="form-control input-sm"/>
													</div>
												</div>
												<div class="form-group">
													<label for="guemail" class="col-sm-4 control-label">邮箱：</label>
													<div class="col-sm-8">
														<input name="guemail" id="guemail" class="form-control input-sm"/>
													</div>
												</div>
												<div class="form-group">
													<label for="gupwd" class="col-sm-4 control-label">密码：</label>
													<div class="col-sm-8">
														<input name="gupwd" id="gupwd" class="form-control input-sm"/>
													</div>
												</div>
												<div class="form-group">
													<label for="guflag" class="col-sm-4 control-label">可用：</label>
													<div class="col-sm-8">
														<select name="guflag" id="guflag" class="form-control input-sm">
															<option>是</option>
															<option>否</option>
														</select>
													</div>
												</div>
												<div class="form-group">
													<fieldset>
													<label for="gutype" class="col-sm-4 control-label">用户权限：</label>
														<label><input type="radio" name="gutype" id="gutype" >管理员</label>
														<label><input type="radio" name="gutype" id="gutype" >普通用户</label>
													</fieldset>	
												</div>
											</form>
										</div>
									</div>
								</div>
							</div><!-- /# column -->
							<div class="col-lg-3">
								&nbsp;
							</div>
						</div>
						<input type="hidden" id="idi"/>
						<input type="hidden" id="flagi"/>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-warning" onclick="gltj()">保存</button>
						<button type="button" class="btn btn-warning" onclick="rst()">退出</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal -->
		</div>
	</body>
</html>
