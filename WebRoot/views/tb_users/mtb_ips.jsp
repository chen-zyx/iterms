<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>ips仿真管理</title>
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
<script type="text/javascript" src="<%=basePath%>js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=basePath%>js/syssmp.js"></script>
<style type="text/css">
.t2 tr {
	height: 30px;
}

.t2 td {
	width: 250px;
	text-align: left;
}
.t2 tr td {
	text-align: left;
}
.a{
	font-family: serif;
	color:blue;
	text-decoration:underline;
}
</style>
<script type="text/javascript">
		function addbt(){
			$("#flagi").val("add");
			$("#gexcel").val('');
			$("#gproject").val('');
			$("#gtask").val('');
			$("#gname").val('');
			
			//$("#gcadjpg").val('');
			$("#gipstime").val('');
			$("#gtb_task_id").val('');
			$("#gtb_node_id").val('');
			
		}
		function updbt(id){
			$.ajax({
				url:'<%=basePath%>tb_ips/getdata',
				type:'post',
				dataType:'json',
				data:{"id":id},
				success:function(data){
					var ob=data.ob;
					$("#flagi").val("upd");
					$("#idi").val(id);
					$("#gipstime").val(ob.ipstime);
					$("#gtb_task_id").val(ob.tb_task_id);
					$("#gtb_node_id").val(ob.tb_node_id);
					}
			});
		}
		function gltj(){
			var excel=$("#gexcel").val();
			//var cadjpg=$("#gcadjpg").val();
			var ipstime=$("#gipstime").val();
			var nodetask=$("#gtb_task_id").val();
			var nodetaskarray=nodetask.split("-");
			var tb_task_id=nodetaskarray[0];
			var tb_node_id=nodetaskarray[1];
			var project=nodetaskarray[2];
			var name=nodetaskarray[3];
			var task=nodetaskarray[4];
			var id          =$("#idi").val();
			var flag        =$("#flagi").val();
			if(ipstime==""||tb_task_id=="0"||tb_node_id=="0"||excel==""){
				alert('项目节点信息不完整。');
				return;
			}
			if("add"==flag){
				$.ajaxFileUpload({
					url:"<%=basePath%>tb_ips/tb_users_add",
					secureuri:false,
					type:'post',
					fileElementId:["gexcel"],
					data:{"tb_task_id":tb_task_id, "tb_node_id":tb_node_id, "project":project,"name":name,"task":task,"ipstime":ipstime},
					dataType:'text',
					success:function(data){
						alert(data.msg);
						window.location.href="<%=basePath%>tb_ips/tb_users_apage?pnum=${pagenum}";
					}
				});
			}
			if("upd"==flag){
				$.ajax({
					url:'<%=basePath%>tb_ips/tb_users_upd',
					type:'post',
					data:{"tb_task_id":tb_task_id,"tb_node_id":tb_node_id, "ipstime":ipstime, "id":id},
					dataType:'json',
					success:function(data){
						alert(data.msg);
						window.location.href="<%=basePath%>tb_ips/tb_users_apage?pnum=${pagenum}";
					}
				});
			}
		}
		function rst(){
			window.location.href="<%=basePath%>tb_ips/tb_users_apage?pnum=${pagenum}";
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
				url:'<%=basePath%>tb_ips/del',
				type:'post',
				dataType:'json',
				data:{"ids":ids},
				success:function(data){
					alert(data.msg);
					rst();
				}
			});
		}
		//通过id查询信息
		function cktj() {
<%-- 			window.location.href="<%=basePath%>tb_ips/tb_users_show";
 --%>		}
		</script>
</head>
<body>
	<div class="main">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-4 p-0">
					<div class="page-header">
						<div class="page-title">
							<h1>ips仿真管理</h1>
						</div>
					</div>
				</div>
				<!-- /# column -->
				<div class="col-lg-8 p-0">
					<div class="page-header">
						<div class="page-title">&nbsp;</div>
					</div>
				</div>
				<!-- /# column -->
			</div>
			<!-- /# row -->
			<div class="main-content">
				<div class="row">
					<div class="col-lg-12">
						<div class="card alert">
							<div class="card-header">
								<form action="<%=basePath%>tb_ips/tb_users_ck" method="post">
									<div class="form-group">
										<label for="ckplatform" class="control-label"
											style="width: 70px; float: left;">平台：</label>
										<div class="col-sm-8">
											MQB 27<input type="radio" name="platform" id="ckplatform"
												value="MQB 27" /> PQ34<input type="radio" name="platform"
												id="ckplatform" value="PQ34" /> PQ34L<input type="radio"
												name="platform" id="ckplatform" value="PQ34L" />
										</div>
									</div>
									<br>
									<br>
									<div>
										<label for="ckpipe" class="control-label "
											style="width: 70px; float: left;">管类：</label>
										<div class="col-sm-8">
											空调管<input type="radio" name="pipe" id="ckpipe" /> 水管<input
												type="radio" name="pipe" id="ckpipe" /> 制动管<input
												type="radio" name="pipe" id="ckpipe" /> 真空管<input
												type="radio" name="pipe" id="ckpipe" /> 通气管<input
												type="radio" name="pipe" id="ckpipe" /> 其他<input
												type="radio" name="pipe" id="ckpipe" />
										</div>
									</div>
									<br>
									<br>
									<div>
										<label for="ckgearbox" class="control-label"
											style="width: 70px; float: left;">变速箱：</label>
										<div class="col-sm-8">
											DQ200<input type="radio" name="gearbox" id="ckgearbox"
												value="DQ200" /> DQ381<input type="radio" name="gearbox"
												id="ckgearbox" value="DQ381" /> AQ<input type="radio"
												name="gearbox" id="ckgearbox" value="AQ" /> MQ<input
												type="radio" name="gearbox" id="ckgearbox" value="MQ" />
										</div>
									</div>
									<br>
									<br>
									<div>
										<label for="ckengine" class="control-label "
											style="width: 70px; float: left;">发动机：</label>
										<div class="col-sm-8">
											1.5<input type="radio" name="engine" id="ckengine"
												value="1.5" /> 1.2<input type="radio" name="engine"
												id="ckengine" value="1.2" /> 1.4<input type="radio"
												name="engine" id="ckengine" value="1.4" /> 2.0<input
												type="radio" name="engine" id="ckengine" value="2.0" /> 2.5<input
												type="radio" name="engine" id="ckengine" value="2.5" />
										</div>
									</div>
									<br>
									<br>
									<div class="form-group">
										<label for="cktb_iterms_id" class="control-label"
											style="width: 70px; float: left;">所属项目：</label> <select
											id="cktb_iterms_id" name='tb_iterms_id'
											class="form-control input-sm"
											style="float: left; width: 100px; margin-right: 5px;">
											<option value='0'>所有所属项目</option>
											<c:forEach var="a" items="${tb_itermslist }">
												<option value="${a.id}">${a.itname}</option>
											</c:forEach>
										</select>
									</div>
									<br>
									<br>
									<div class="form-group">
										<input class="btn btn-warning" type="submit" onclick="cktj();"
											value="查询" />
										<c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
											<input class="btn btn-warning" type="button"
												onclick="addbt();" data-toggle="modal" data-target="#gldiv"
												value="添加" />
											<input class="btn btn-warning" type="button"
												onclick="delsbt();" value="删除" />
										</c:if>
									</div>
								</form>
							</div>
							<div class="card-body">
								<table class="table table-bordered table-hover ">
									<thead>
										<tr>
											<%-- <c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
												<th style="width:5%;"></th>
												</c:if>
												<th>车型项目</th>
												<th>节点名称</th>
												<th>计算时间</th>
												<th>是否Aeko</th>
												<th>发动机</th>
												<th>变速箱</th>
												<th style="width:5%;"></th> --%>
											<th style="width: 5%; text-align: left;">——检索结果</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="a" items="${alist }">
											<tr>
												<td>
													<div style="border: 1px solid blue; height: 150px;">
														<div
															style="width: 25%; height: 120px; margin-top: 15px; margin-left: 10px; float: left;">
															<img style="width: 250px;height: 120px;" src="/img/${a.path}/${a.cadjpg}">
														</div>
														<div
															style="width: 65%; height: 120px; margin-top: 15px; margin-left: 40px; float: left;">
															<table class="t2">
																<tr>
																	<td>车型 &nbsp;:&nbsp;${a.project}</td>
																	<td style="text-align: left;">项目&nbsp;:&nbsp;${a.project}</td>
																	<td rowspan="3">当前状态:<c:if  test="${a.aekositu=='grün'}"><img style="width: 100px;height: 100px;" src="<%=basePath%>css/green.jpg"></c:if></td>
																</tr>
																<tr>
																	<td>是否Ako&nbsp;:&nbsp;${a.aekoid}</td>
																	<td style="text-align: left;">备注&nbsp;:&nbsp;${a.aekocom}</td>
																</tr>
																<tr>
																	<td>发动机&nbsp;:&nbsp;${a.engine}</td>
																	<td style="text-align: left;">变速箱&nbsp;:&nbsp;${a.gearbox}</td>
																</tr>
																<tr>
																	<td colspan="2">计算时间 &nbsp;:&nbsp;${a.ipstime}</td>
																	<td style="width:50px;text-align: right;"><a class="a"  href="<%=basePath%>tb_ips/tb_users_show?id=${a.id }&excel=${a.excel }">更多</a></td>
																</tr>
															</table>
														</div>
													</div>
												</td>
											</tr>
										</c:forEach>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="20">当前第${pagenum}页,共${pagenums}页 <span
												style="float: right; margin-right: 60px;"> <a
													class="btn btn=warning"
													href="<%=basePath%>tb_ips/tb_ips_apage?pnum=1">首页</a> <a
													class="btn btn=warning"
													href="<%=basePath%>tb_ips/tb_ips_apage?pnum=${pagenum-1}">上一页</a>
													<a class="btn btn=warning"
													href="<%=basePath%>tb_ips/tb_ips_apage?pnum=${pagenum+1}">下一页</a>
													<a class="btn btn=warning"
													href="<%=basePath%>tb_ips/tb_ips_apage?pnum=${pagenums}">尾页</a>
											</span>
											</td>
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
					</div>
					<!-- /# column -->
				</div>
				<!-- /# row -->
			</div>
		</div>
		<!-- /# container-fluid -->
	</div>
	<!-- /# main -->
	<div class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" data-backdrop="static"
		aria-hidden="true" id="gldiv">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">IPS编辑</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-lg-12">
							<div class="card alert">
								<div class="card-body">
									<div class="input-sizes">
										<form class="form-horizontal">
											<div class="form-group">
												<label for="gtb_node_id" class="control-label">节点名称：</label>
												<div>
													<select name="gtb_task_id" id="gtb_task_id"
														class="form-control input-sm">
														<option value="">选择所属节点</option>
														<c:forEach var="a" items="${tb_tasklist}">
															<option
																value="${a.id}-${a.tb_node_id}-${a.project}-${a.name}-${a.taskname}">${a.project}-${a.name}-${a.taskname}</option>
														</c:forEach>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label for="gipstime" class="control-label">计算时间：</label>
												<div>
													<input type="date" name="gipstime" id="gipstime" />
												</div>
											</div>
											<div class="form-group">
												<label for="gexcel" class="control-label">IPS属性excel文件：</label>
												<div>
													<input type="file" id="gexcel" name="gexcel"
														class="form-control input-sm" />
												</div>
											</div>

										</form>
									</div>
								</div>
							</div>
						</div>
						<!-- /# column -->

					</div>
					<input type="hidden" id="idi" /> <input type="hidden" id="flagi" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-warning" onclick="gltj()">保存</button>
					<button type="button" class="btn btn-warning" onclick="rst()">退出</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>

</body>
</html>