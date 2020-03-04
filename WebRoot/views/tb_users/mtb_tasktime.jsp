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
		<title>工时模块</title>
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
		function updbt(id){
			$.ajax({
				url:'<%=basePath%>tb_tasktime/getdata',
				type:'post',
				dataType:'json',
				data:{"id":id},
				success:function(data){
					var ob=data.ob;
					$("#flagi").val("upd");
					$("#idi").val(id);
					$("#gtname").val(ob.tname);
					$("#gsstime ").val(ob.sstime);
					$("#gpnumber ").val(ob.pnumber);
					$("#gsrtime ").val(ob.srtime);
					$("#gostime ").val(ob.ostime);
					$("#gortime ").val(ob.ortime);
					$("#gtb_task_id").val(ob.tb_task_id);
					}
			});
		}
		function gltj(){
			var tname=$("#gtname").val();
			var pnumber =$("#gpnumber").val();
			var srtime =$("#gsrtime").val();
			var sstime =$("#gsstime").val();
			var ortime =$("#gortime").val();
			var ostime =$("#gostime").val();
			var tb_task_id=$("#gtb_task_id").val();	
			var id          =$("#idi").val();
			var flag        =$("#flagi").val();
			if(tname==""||pnumber=="0"||tb_task_id==""){
				alert('项目节点信息不完整。');
				return;
			}
			
			if("upd"==flag){
				$.ajax({
					url:'<%=basePath%>tb_tasktime/tb_users_upd',
					type:'post',
					data:{"tname":tname,"pnumber":pnumber,"srtime":srtime,"sstime":sstime,"ortime":ortime,"ostime":ostime,"tb_task_id":tb_task_id,"id":id},
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
			window.location.href="<%=basePath%>tb_tasktime/tb_users_apage?pnum=${pagenum}";
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
								<h1>工时统计</h1>
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
								<form action="<%=basePath%>tb_erst/tb_users_ck" method="post">
									<div class="form-group" style="">
										<label for="cktname" class="control-label" style="width: 70px;float: left;">项目名称：</label>
										<input id="cktname" name="tname" type="text" class="form-control input-sm" style="float: left;width: 100px;margin-right: 5px;"/>
									</div>
									<div class="form-group">
										<input class="btn btn-warning" type="submit" onclick="cktj();" value="查询"/>
										<c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
											<input class="btn btn-warning" type="button" onclick="delsbt();" value="删除"/>
										</c:if>
										<a class="btn btn-warning" style="margin-left: 30px;" href="<%=basePath%>tb_tasktime/tb_tasktime_showmore" target="subfrm">多项目工时显示</a>
										<a class="btn btn-warning" style="margin-left: 30px;" href="<%=basePath%>tb_tasktime/tb_tasktime_totasksbarhour" target="subfrm">项目各任务工时显示</a>
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
												<th>名称</th>
												<th>任务</th>
												<th>计划工时</th>
												<th>实际工时</th>
												<th>任务风险</th>
												<th>项目控制</th>
												
												<th style="width:5%;"></th>
											
											</tr>
										</thead>
										<tbody>
											<c:forEach var="a" items="${alist }">
											<tr>
											<c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
												<td style="width:5%;"><input name="delid" type="checkbox" value="${a.id }"/></td>
												</c:if>
												<td>${a.tname }</td>
												<td>${a.project }-${a.name }-${a.taskname }</td>
												<td>${a.shour }</td>
												<td>${a.rhour }</td>
												<td>${a.sminus }</td>
												<td>${a.rminus }</td>
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
														<a class="btn btn=warning" href="<%=basePath%>tb_tasktime/tb_users_apage?pnum=1">首页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_tasktime/tb_users_apage?pnum=${pagenum-1}">上一页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_tasktime/tb_users_apage?pnum=${pagenum+1}">下一页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_tasktime/tb_users_apage?pnum=${pagenums}">尾页</a>
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
							时间编辑
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
													<label for="gpnumber" class="col-sm-4 control-label">选择人数：</label>
													<div class="col-sm-8">
														<select name="gpnumber" id="gpnumber" class="form-control input-sm">
														<option value="">选择人数</option>
															<option >1</option>
															<option >2</option>
															<option >3</option>
															<option >4</option>
															<option >5</option>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label for="gsstime" class="col-sm-4 control-label">计划开始时间：</label>
													<div class="col-sm-8">
														<input type="date" name="gsstime" id="gsstime" class="form-control input-sm" />
													</div>
												</div>
												<div class="form-group">
													<label for="gsrtime" class="col-sm-4 control-label">实际开始时间：</label>
													<div class="col-sm-8">
														<input type="date" name="gsrtime" id="gsrtime" class="form-control input-sm" />
													</div>
												</div>
												<div class="form-group">
													<label for="gostime" class="col-sm-4 control-label">计划结束时间：</label>
													<div class="col-sm-8">
														<input type="date" name="gostime" id="gostime" class="form-control input-sm" />
													</div>
												</div>
												<div class="form-group">
													<label for="gortime" class="col-sm-4 control-label">实际结束时间：</label>
													<div class="col-sm-8">
														<input type="date" name="gortime" id="gortime" class="form-control input-sm" />
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