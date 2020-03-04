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
		<title>项目信息管理</title>
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
			function addbt(){
				$("#flagi").val("add");
				$("#gitname").val('');
				$("#gitmark").val('');
				$("#gkla").val('');
				$("#gprojekt").val('');
				$("#gbezeichnung").val('');
			}
			function updbt(id){
				$.ajax({
					url:'<%=basePath%>tb_iterms/getdata',
					type:'post',
					dataType:'json',
					data:{"id":id},
					success:function(data){
						var ob=data.ob;
						$("#flagi").val("upd");
						$("#idi").val(id);
						$("#gitname").val(ob.itname);
						$("#gitmark").val(ob.itmark);
					}
				});
			}
			//保存
			function gltj(){
				var iterm=$("#gitname").val();
				var itmark=$("#gitmark").val();
				var itermArray=iterm.split("*");
				var itname=itermArray[0];
				var kla=itermArray[1];
				var projekt=itermArray[2];
				var bezeichnung=itermArray[3];
				var id=$("#idi").val();
				var flag=$("#flagi").val();
				if(itname==""||itmark==""){
					alert('项目信息不完整。');
					return;
				}
				if("add"==flag){
					$.ajax({
						url:'<%=basePath%>tb_iterms/tb_users_add',
						type:'post',
						data:{"itname":itname,"itmark":itmark,"kla":kla,"projekt":projekt,"bezeichnung":bezeichnung},
						dataType:'json',
						success:function(data){
							alert(data.msg);
							window.location.href="<%=basePath%>tb_iterms/tb_users_apage?pnum=${pagenum}";
						}
					});
				}
				if("upd"==flag){
					$.ajax({
						url:'<%=basePath%>tb_iterms/tb_users_upd',
						type:'post',
						data:{"itname":itname,"itmark":itmark,"kla":kla,"projekt":projekt,"bezeichnung":bezeichnung,"id":id},
						dataType:'json',
						success:function(data){
							alert(data.msg);
							window.location.href="<%=basePath%>tb_iterms/tb_users_apage?pnum=${pagenum}";
						}
					});
				}
			}
			//取消
			function rst(){
				window.location.href="<%=basePath%>tb_iterms/tb_users_apage?pnum=${pagenum}";
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
					url:'<%=basePath%>tb_iterms/del',
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
								<h1>项目信息管理</h1>
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
								<form action="<%=basePath%>tb_iterms/tb_users_ck" method="post">
									<div class="form-group" style="">
										<label for="ckitname" class="control-label" style="width: 70px;float: left;">项目名称：</label>
										<input id="ckitname" name="itname" type="text" class="form-control input-sm" style="float: left;width: 100px;margin-right: 5px;"/>
									</div>
									<div class="form-group">
										<input class="btn btn-warning" type="submit" onclick="cktj();" value="查询"/>
										<c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
											<input class="btn btn-warning" type="button" onclick="addbt();" data-toggle="modal" data-target="#gldiv" value="添加"/>
											<input class="btn btn-warning" type="button" onclick="delsbt();" value="删除"/>
										</c:if>
									</div>
								</form>
								</div>
								<div class="card-body">
									<table class="table table-bordered table-hover ">
										<thead>
											<tr>
												<c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
												<th style="width:5%;"></th>
												</c:if>
												<th>项目名称</th>
												<th align="left">项目简介</th>
												<th>Kla.</th>
												<th>车型代号</th>
												<th>项目代号</th>
												<th style="width:5%;"></th>
												<th style="width:5%;"></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="a" items="${alist }">
											<tr>
												<c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
												<td style="width:5%;"><input name="delid" type="checkbox" value="${a.id }"/></td>
												</c:if>
												<td>${a.itname }</td>
												<td align="left">${a.itmark }</td>
												<td>${a.kla }</td>
												<td>${a.projekt }</td>
												<td>${a.bezeichnung }</td>
												<td>
												<c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
												<input class="btn btn-warning" type="button" data-toggle="modal" data-target="#gldiv" onclick="updbt('${a.id}');" value="修改"/>
												</c:if>
												</td>
												<td>
												<form action="<%=basePath%>tb_node/tb_users_ck" method="post">
												<input type="hidden" name="tb_iterms_id" value="${a.id }">
												<input class="btn btn-warning" type="submit" onclick="cktj();" value="节点"/>
												</form>
												</td>
											</tr>
											</c:forEach>
										</tbody>
										<tfoot>
											<tr>
												<td colspan="20">
													当前第${pagenum}页,共${pagenums}页 
													<span style="float: right;margin-right: 60px;">
														<a class="btn btn=warning" href="<%=basePath%>tb_iterms/tb_users_apage?pnum=1">首页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_iterms/tb_users_apage?pnum=${pagenum-1}">上一页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_iterms/tb_users_apage?pnum=${pagenum+1}">下一页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_iterms/tb_users_apage?pnum=${pagenums}">尾页</a>
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
							项目信息编辑
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
													<label for="gitname" class="col-sm-4 control-label">项目名称：</label>
													<div class="col-sm-8">
														<select name="gitname" id="gitname" class="form-control input-sm">
														<option value="0">选择所属项目</option>
															<c:forEach var="a" items="${elist }">
																<option value="${a.name}*${a.kla}*${a.projekt}*${a.bezeichnung}">${a.projekt}</option>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label for="gitmark" class="col-sm-4 control-label">项目简介：</label>
													<div class="col-sm-8">
														<textarea name="gitmark" id="gitmark" rows="4" cols="40" class="form-control"></textarea>
													</div>
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
