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
		<title>项目进度管理</title>
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
				$("#gwochestr").val('');
				$("#gproject").val('');
				$("#gname").val('');
			}
			function addpr(){
				$("#gproname").val('');
			}
			function updpr(){
				var pro=$("#gproname").val();
			}
			function updbt(id){
				$.ajax({
					url:'<%=basePath%>tb_node/getdata',
					type:'post',
					dataType:'json',
					data:{"id":id},
					success:function(data){
						var ob=data.ob;
						$("#flagi").val("upd");
						$("#idi").val(id);
						$("#gnodename").val(ob.nodename);
						$("#gnodemark").val(ob.nodemark);
						$("#gpep").val(ob.pep);
						$("#gnodedate").val(ob.nodedate);
						$("#gnodenowmark").val(ob.nodenowmark);
						$("#gtb_iterms_id").val(ob.tb_iterms_id);
						}
				});
			}
			//保存
			function gltj(){
				/*var nodee=$("#gnodename").val();
				var nodeeArray=nodee.split("-");
				var nodename=nodeeArray[0];
				var nodemark=nodeeArray[1];
				var nodedate=nodeeArray[2];
				var nodenowmark =$("#gnodenowmark").val();
				var tb_iterms_id=$("#gtb_iterms_id").val();				
				var pep         =$("#gpep").val();			
				var id          =$("#idi").val();*/
				var flag        =$("#flagi").val();
				var wochestr=$("#gwochestr").val();
				var project=$("#gproject").val();
				var name=$("#gname").val();
				if(project==""){
					alert('项目节点信息不完整。');
					return;
				}
				if("add"==flag){
					$.ajax({
						url:"<%=basePath%>tb_node/tb_users_add",
						type:'post',
						data:{"name":name,"project":project,"wochestr":wochestr},
						dataType:'json',
						success:function(data){
							alert(data.msg);
							window.location.href="<%=basePath%>tb_node/tb_users_apage?pnum=${pagenum}";
						}
					});
				}
				if("upd"==flag){
					$.ajax({
						url:'<%=basePath%>tb_node/tb_users_upd',
						type:'post',
						data:{"tb_iterms_id":tb_iterms_id,"nodename":nodename,"nodemark":nodemark,"nodenowmark":nodenowmark,"pep":pep,"nodedate":nodedate,"id":id},
						dataType:'json',
						success:function(data){
							alert(data.msg);
							window.location.href="<%=basePath%>tb_node/tb_users_apage?pnum=${pagenum}";
						}
					});
				}
			}
			//取消
			function rst(){
				window.location.href="<%=basePath%>tb_node/tb_users_apage?pnum=${pagenum}";
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
					url:'<%=basePath%>tb_node/del',
					type:'post',
					dataType:'json',
					data:{"ids":ids},
					success:function(data){
						alert(data.msg);
						rst();
					}
				});
			}
			function show() {
				window.location.href="<%=basePath%>tb_node/tb_users_show";
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
								<h1><a href="<%=basePath%>tb_node/tb_users_init" target="subfrm">项目节点管理</a></h1>
							</div>
						</div>
					</div><!-- /# column -->
					<div class="col-lg-4 p-0">
						<div class="page-header">
							<div class="page-title">
								<h1><a href="<%=basePath%>tb_node/tb_users_init2" target="subfrm">仿真项目概览</a></h1>
							</div>
						</div>
					</div><!-- /# column -->
					<div class="col-lg-48 p-0">
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
								<form action="<%=basePath%>tb_node/tb_users_ck" method="post">
									<div class="form-group" style="">
										<label for="ckname" class="control-label" style="width: 70px;float: left;">节点名称：</label>
										<div class="col-sm-8">
														DE<input type="radio" name="name" id="ckname" value="DE" />
														DF<input type="radio" name="name" id="ckname" value="DF" />
														PT<input type="radio" name="name" id="ckname" value="PT" />
														BF<input type="radio" name="name" id="ckname" value="BF" />
														LF<input type="radio" name="name" id="ckname" value="LF" />
														VFF<input type="radio" name="name" id="ckname" value="VFF" />
														PVS<input type="radio" name="name" id="ckname" value="PVS" />
														OS<input type="radio" name="name" id="ckname" value="OS" />
														SOP<input type="radio" name="name" id="ckname" value="SOP" />
													</div>	
										</div>
										<br><br>
									<div class="form-group" style="">
										<label for="ckjahr" class="control-label" style="width: 70px;float: left;">年份：</label>
										<div class="col-sm-8">
														2017<input type="radio" name="jahr" id="ckjahr" value="2017" />
														2018<input type="radio" name="jahr" id="ckjahr" value="2018"/>
														2019<input type="radio" name="jahr" id="ckjahr" value="2019"/>
														2020<input type="radio" name="jahr" id="ckjahr" value="2020"/>
														2021<input type="radio" name="jahr" id="ckjahr" value="2021"/>
														2022<input type="radio" name="jahr" id="ckjahr" value="2022"/>
														2023<input type="radio" name="jahr" id="ckjahr" value="2023"/>
														2024<input type="radio" name="jahr" id="ckjahr" value="2024"/>
														2025<input type="radio" name="jahr" id="ckjahr" value="2025"/>
													</div>	
										</div>
									<br><br>
									<div class="form-group" style="">
										<label for="ckproject" class="control-label" style="width: 70px;float: left;">所属项目：</label>
										<select id="ckproject" name='project' class="form-control input-sm" style="float: left;width: 100px;margin-right: 5px;">
											<option value=''>所有所属项目</option>
											<c:forEach var="a" items="${plist }">
												<option >${a.project}</option>
											</c:forEach>
										</select>
									</div>
									
									<div class="form-group">
										<input class="btn btn-warning" type="submit" value="查询"/>
										<c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
											<input class="btn btn-warning" type="button" onclick="addbt();" data-toggle="modal" data-target="#gldiv" value="添加"/>
											<!-- <input class="btn btn-warning" type="button" onclick="show();" value="显示"/> -->
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
												<th>所属项目</th>
												<th>节点名称</th>
												<th>节点简介</th>
												<th>时间节点</th>
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
												<td>${a.project }</td>
												<td>${a.name }</td>
												<td>${a.wochestr }</td>												
												<td>${a.date }</td>
												<td>
												<c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
												<input class="btn btn-warning" type="button" data-toggle="modal" data-target="#gldiv" onclick="updbt('${a.id}');" value="修改"/>
												</c:if>
												</td>
												<td>
												<form action="<%=basePath%>tb_task/tb_users_pro" method="post">
												<input type="hidden" name="tb_node_id" value="${a.id }">
												<input type="hidden" name="nodei" value="${a.id }">
												<input class="btn btn-warning" type="submit" onclick="cktj();" value="任务"/>
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
														<a class="btn btn=warning" href="<%=basePath%>tb_node/tb_users_apage?pnum=1">首页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_node/tb_users_apage?pnum=${pagenum-1}">上一页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_node/tb_users_apage?pnum=${pagenum+1}">下一页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_node/tb_users_apage?pnum=${pagenums}">尾页</a>
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
							节点编辑
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
													<label for="gproject" class="col-sm-4 control-label">所属项目：</label>
													<div class="col-sm-8">
														<select name="gproject" class="form-control input-sm" id="gproject">
															<option value="0">选择所属项目</option>
															<c:forEach var="a" items="${plist }">
																<option >${a.project}</option>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label  class="col-sm-4 control-label">HDBT节点：</label>
													<div class="col-sm-8">
														<select name="gname" class="form-control input-sm" id="gname">
															<option value="0">选择所属项目</option>
															<option >KF</option>
															<option >VPT</option>
															<option >BST</option>
															<option >Serie</option>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label for="gwochestr" class="control-label">周：</label>
													<div >
														<textarea name="gwochestr" id="gwochestr" rows="1" cols="40" class="form-control"></textarea>
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
		
		<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myProLabel" data-backdrop="static" aria-hidden="true" id="glpro" >
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myProLabel">
							信息编辑
						</h4>
					</div>
					<form action="<%=basePath%>tb_node/tb_users_pro" method="post">
					<div class="modal-body">						
						<label for="ckproname" class="control-label" style="width: 70px;float: left;">所属项目：</label>
										<select id="ckproname" name='pos' class="form-control input-sm" style="float: left;width: 100px;margin-right: 5px;">
											<option value='0'>所有所属项目</option>
											<c:forEach var="a" items="${elist }">
												<option value="${a.pos}">${a.projekt}</option>
											</c:forEach>
										</select>										
					</div>
					<div class="modal-footer">		
						<input class="btn btn-warning" type="submit"  value="提交"/>
						<button type="button" class="btn btn-warning" onclick="rst()">退出</button>
						</div>
					</form>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal -->
		
	</body>
</html>
