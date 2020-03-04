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
		<title>仿真任务管理</title>
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
				$("#gtaskname").val('');
				$("#gsitu").val('');
				$("#gperson").val('');
				$("#gstarttime").val('');
				
				$("#gtb_node_id").val('0');
			}
			function updbt(id){
				$.ajax({
					url:'<%=basePath%>tb_task/getdata',
					type:'post',
					dataType:'json',
					data:{"id":id},
					success:function(data){
						var ob=data.ob;
						$("#flagi").val("upd");
						$("#idi").val(id);
						$("#gtaskname").val(ob.taskname);
						$("#gsitu ").val(ob.situ);
						$("#gperson ").val(ob.person);
						$("#gstarttime ").val(ob.starttime);
						$("#gtb_node_id").val(ob.tb_node_id);
						}
				});
			}
			function gltj(){
				var task=$("#gtaskname").val();
				
				var taskarray=task.split("-");
				var taskname=taskarray[0];
				var taskflag=taskarray[1];
				
			
				var situ =$("#gsitu").val();
				var person =$("#gperson").val();
				var starttime =$("#gstarttime").val();
				var tb_node_id=$("#gtb_node_id").val();	
				var id          =$("#idi").val();
				var flag        =$("#flagi").val();
				if(taskname==""||tb_node_id=="0"||tb_node_id==""){
					alert('项目节点信息不完整。');
					return;
				}
				if("add"==flag){
					$.ajax({
						url:"<%=basePath%>tb_task/tb_users_add",
						type:'post',
						data:{"taskname":taskname,"taskflag":taskflag,"situ":situ,"person":person,"starttime":starttime,"tb_node_id":tb_node_id},
						dataType:'json',
						success:function(data){
							alert(data.msg);
							rst();
						}
					});
				}
				if("upd"==flag){
					$.ajax({
						url:'<%=basePath%>tb_task/tb_users_upd',
						type:'post',
						data:{"taskname":taskname,"situ":situ,"person":person,"starttime":starttime,"tb_node_id":tb_node_id,"id":id},
						dataType:'json',
						success:function(data){
							alert(data.msg);
							rst();
						}
					});
				}
			}
			//取消
			function rst(){
				window.location.href="<%=basePath%>tb_task/tb_users_apage?pnum=${pagenum}";
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
					url:'<%=basePath%>tb_task/del',
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
								<h1>仿真任务管理</h1>
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
								<form action="<%=basePath%>tb_task/tb_users_ck" method="post">
									<div class="form-group" style="">
										<label for="cktaskname" class="control-label" style="width: 70px;float: left;">任务名称：</label>
										<select id="cktaskname" name="taskname" class="form-control input-sm" style="float: left;width: 100px;margin-right: 5px;"/>
										
											<option value="">选择任务</option>
															<option >Akustik Schwingungskomfort</option>
															<option >Bauteiltemperaturen</option>
															<option >Lastkollektive fuer Pruefszenarien</option>
															<option>Bodenfreigang</option>
															<option >Wassermanagerment</option>
															<option >Karosseriedichtigkeit</option>
															<option >Klappern</option>
															<option >IPS</option>
										</select>
									</div>
									<div class="form-group" style="">
										<label for="cktb_node_id" class="control-label" style="width: 70px;float: left;">所属节点：</label>
										<select id="cktb_node_id" name='tb_node_id' class="form-control input-sm" style="float: left;width: 100px;margin-right: 5px;">
											<option value='0'>所有节点</option>
											<c:forEach var="a" items="${tb_nodelist }">
												<option value="${a.id}">${a.project}-${a.name}</option>
											</c:forEach>
										</select>
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
												<th>所属项目</th>
												<th>所属节点</th>
												<th>仿真任务名称</th>
												<th>任务状态</th>
												<th>负责人</th>
												<th>开始时间</th>
												<th>结束时间</th>
												<th style="width:10%;"></th>
												<th style="width:5%;"></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="a" items="${alist }" >
											
											<tr>
												<c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
												<td style="width:5%;"><input name="delid" type="checkbox" value="${a.id }"/></td>
												</c:if>
												<td>${a.project }-${a.name }</td>
												<td>${a.wochestr }</td>
												<td>${a.taskname }</td>
												<td>${a.situ }</td>
												<td>${a.person }</td>
												<td>${a.starttime }</td>
												<td>${a.overtime }</td>
												<td>
												<form action="<%=basePath%>tb_erst/tb_users_pro" method="post">
												<input type="hidden" name="vatername" value="${a.taskname }">
												<input type="hidden" name="nodei" value="${nodei}">
												<input class="btn btn-warning" type="submit" onclick="cktj();" value="结构树"/>
												</form>
												</td>
												<td>
												<c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
												<input class="btn btn-warning" type="button" data-toggle="modal" data-target="#gldiv" onclick="updbt('${a.id}');" value="修改"/>
												</c:if>
												</td>
											</tr>
											
											</c:forEach>
										</tbody>
										<tfoot>
											<tr>
												<td colspan="20">
													当前第${pagenum}页,共${pagenums}页 
													<span style="float: right;margin-right: 60px;">
														<a class="btn btn=warning" href="<%=basePath%>tb_task/tb_users_apage?pnum=1">首页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_task/tb_users_apage?pnum=${pagenum-1}">上一页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_task/tb_users_apage?pnum=${pagenum+1}">下一页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_task/tb_users_apage?pnum=${pagenums}">尾页</a>
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
							仿真任务编辑
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
													<label for="gtb_node_id" class="col-sm-4 control-label">所属项目：</label>
													<div class="col-sm-8">
														<select name="gtb_node_id" class="form-control input-sm" id="gtb_node_id">
															<option value="0">选择所属项目节点</option>
															<c:forEach var="a" items="${tb_nodelist }">
																<option value="${a.id}">${a.project}-${a.name }</option>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label for="gtaskname" class="col-sm-4 control-label">任务名称：</label>
													<div class="col-sm-8">
														<select name="gtaskname" id="gtaskname" class="form-control input-sm">
														<option value="">选择任务</option>
															<option value="Akustik Schwingungskomfort-0" >Akustik Schwingungskomfort</option>
															<option value=" Bauteiltemperaturen-1">Bauteiltemperaturen</option>
															<option value="Lastkollektive fuer Pruefszenarien-2">Lastkollektive fuer Pruefszenarien</option>
															<option value="Bodenfreigang-3">Bodenfreigang</option>
															<option value="Wassermanagerment-4">Wassermanagerment</option>
															<option value="Karosseriedichtigkeit-5">Karosseriedichtigkeit</option>
															<option value="Klappern-6">Klappern</option>
															<option value="IPS-7">IPS</option>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label for="gsitu" class="col-sm-4 control-label">状态：</label>
													<div class="col-sm-8">
														<select name="gsitu" id="gsitu" class="form-control input-sm">
														<option value="">选择状态</option>
															<option >计划</option>
															<option >绿灯</option>
															<option >黄灯</option>
															<option >红灯</option>
															<option >VW</option>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label for="gperson" class="col-sm-4 control-label">工程师：</label>
													<div class="col-sm-8">
														<select name="gperson" id="gperson" class="form-control input-sm">
														<option value="">选择负责人</option>
															<option >钱郁</option>
															<option >柳伟</option>
															<option >朴玉华</option>
															<option >余鸿成</option>
															<option >孙滔</option>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label for="gstarttime" class="col-sm-4 control-label">开始时间：</label>
													<div class="col-sm-8">
														<input type="date" name="gstarttime" id="gstarttime" class="form-control input-sm" />
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
