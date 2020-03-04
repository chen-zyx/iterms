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
		<title>模型信息管理</title>
		<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
		<link href="<%=basePath%>css/themify-icons.css" rel="stylesheet">
		<link href="<%=basePath%>css/simdahs.css" rel="stylesheet">
		<link href="<%=basePath%>css/sidebar.css" rel="stylesheet">
		<link href="<%=basePath%>css/style.css" rel="stylesheet">
		<script src="<%=basePath%>js/jquery-2.2.3.min.js"></script><!-- jquery vendor -->
		<script src="<%=basePath%>js/jquery.nanoscroller.min.js"></script><!-- nano scroller -->
		<script src="<%=basePath%>js/sidebar.js"></script><!-- sidebar -->
		<script src="<%=basePath%>js/bootstrap.min.js"></script><!-- bootstrap -->
		<script type="text/javascript" src="<%=basePath%>js/ajaxfileupload.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/syssmp.js"></script>
		<script type="text/javascript">
			function addbt(){
				$("#flagi").val("add");
				$("#gmname").val('');
				$("#gmfile").val('');
				$("#gmattr").val('');
				$("#gtb_iterms_id").val('0');
				$("#gtb_node_id").val('0');
				$("#gtb_zweit_id").val('0');
			}
			function updbt(id){
				$.ajax({
					url:'<%=basePath%>tb_model/getdata',
					type:'post',
					dataType:'json',
					data:{"id":id},
					success:function(data){
						var ob=data.ob;
						$("#flagi").val("upd");
						$("#idi").val(id);
						$("#gmname").val(ob.mname);
						$("#gmattr").val(ob.mattr);
						$("#gtb_iterms_id").val(ob.tb_iterms_id);
						$("#gtb_node_id").val(ob.tb_node_id);
						$("#gtb_zweit_id").val(ob.tb_zweit_id);
					}
				});
			}
			//保存
			function gltj(){
				var mname=$("#gmname").val();
				var mfile=$("#gmfile").val();
				var mattr=$("#gmattr").val();
				var tb_iterms_id=$("#gtb_iterms_id").val();
				var tb_node_id=$("#gtb_node_id").val();
				var tb_zweit_id=$("#gtb_zweit_id").val();
				var id=$("#idi").val();
				var flag=$("#flagi").val();
				if(mname==""||mattr==""||tb_iterms_id=="0"||tb_node_id=="0"||tb_zweit_id=="0"){
					alert('模型信息不完整。');
					return;
				}
				if("add"==flag){
					if(mfile==""){
						alert("选择模型文件");
						return;
					}
					$.ajaxFileUpload({
						url:"<%=basePath%>tb_model/tb_users_add",
						secureuri:false, 
						type:'post', 
						fileElementId:'gmfile', 
						data:{"mname":mname,"mattr":mattr,"tb_iterms_id":tb_iterms_id,"tb_node_id":tb_node_id,"tb_zweit_id":tb_zweit_id},
						dataType:'text',
						success:function(data){
							alert(data);
							window.location.href="<%=basePath%>tb_model/tb_users_apage?pnum=${pagenum}";
						}
					});
				}
				if("upd"==flag){
					$.ajaxFileUpload({
						url:"<%=basePath%>tb_model/tb_users_upd",
						secureuri:false,  
						type:'post',
						fileElementId:'gmfile',
						data:{"mname":mname,"mattr":mattr,"tb_iterms_id":tb_iterms_id,"tb_node_id":tb_node_id,"tb_zweit_id":tb_zweit_id,"id":id},
						dataType:'text',
						success:function(data){
							alert(data);
							window.location.href="<%=basePath%>tb_model/tb_users_apage?pnum=${pagenum}";
						}
					});
				}
			}
			//取消
			function rst(){
				window.location.href="<%=basePath%>tb_model/tb_users_apage?pnum=${pagenum}";
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
					url:'<%=basePath%>tb_model/del',
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
								<h1>模型信息管理</h1>
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
								<form action="<%=basePath%>tb_model/tb_users_ck" method="post">
									<div class="form-group" style="">
										<label for="ckmname" class="control-label" style="width: 70px;float: left;">模型名称：</label>
										<input id="ckmname" name="mname" type="text" class="form-control input-sm" style="float: left;width: 100px;margin-right: 5px;"/>
									</div>
									<div class="form-group" style="">
										<label for="cktb_node_id" class="control-label" style="width: 70px;float: left;">所属项目：</label>
										<select id="cktb_node_id" name='tb_node_id' class="form-control input-sm" style="float: left;width: 100px;margin-right: 5px;">
											<option value='0'>所有所属项目</option>
											<c:forEach var="a" items="${tb_nodelist }">
												<option value="${a.id}">${a.itname}-${a.nodename }</option>
											</c:forEach>
										</select>
									</div>
									<div class="form-group" style="">
										<label for="cktb_zweit_id" class="control-label" style="width: 70px;float: left;">所属项目：</label>
										<select id="cktb_zweit_id" name='tb_zweit_id' class="form-control input-sm" style="float: left;width: 100px;margin-right: 5px;">
											<option value='0'>所有所属项目</option>
											<c:forEach var="a" items="${tb_zweitlist }">
												<option value="${a.id}">${a.zweiterst}-${a.zweitname }</option>
											</c:forEach>
										</select>
									</div>
									<div class="form-group">
										<input class="btn btn-warning" type="submit" onclick="cktj();" value="查询"/>
										<input class="btn btn-warning" type="button" onclick="addbt();" data-toggle="modal" data-target="#gldiv" value="添加"/>
										<c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
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
												<th>模型名称</th>
												<th>模型文件</th>
												<th>属性</th>
												<th>所属项目节点</th>
												<th>所属底层</th>
												<th>创建者</th>
												<th>创建时间</th>
												<th style="width:5%;"></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="a" items="${alist }">
											<tr>
												<c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
												<td style="width:5%;">
												<input name="delid" type="checkbox" value="${a.id }"/>
												</td>
												</c:if>
												<td>${a.mname }</td>
												<td width="80px">
													<a href='<%=basePath%>tb_model/dfile?id=${a.id}'><b>下载</b></a>
												</td>
												<td>${a.mattr }</td>
												<td>${a.itname }-${a.nodename }</td>
												<td>${a.zweitname }</td>
												<td>${a.uname }</td>
												<td>${fn:substring(a.ctime,0,10) }</td>
												<td width="80px">
													<a href='<%=basePath%>tb_model/openfile?id=${a.id}'><b>打开</b></a>
												</td>
											</tr>
											</c:forEach>
										</tbody>
										<tfoot>
											<tr>
												<td colspan="20">
													当前第${pagenum}页,共${pagenums}页 
													<span style="float: right;margin-right: 60px;">
														<a class="btn btn=warning" href="<%=basePath%>tb_model/tb_users_apage?pnum=1">首页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_model/tb_users_apage?pnum=${pagenum-1}">上一页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_model/tb_users_apage?pnum=${pagenum+1}">下一页</a>
														<a class="btn btn=warning" href="<%=basePath%>tb_model/tb_users_apage?pnum=${pagenums}">尾页</a>
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
							模型信息编辑
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
													<label for="gtb_iterms_id" class="col-sm-4 control-label">所属项目：</label>
													<div class="col-sm-8">
														<select name="gtb_iterms_id" class="form-control input-sm" id="gtb_iterms_id">
															<option value="0">选择所属项目</option>
															<c:forEach var="a" items="${tb_itermslist }">
																<option value="${a.id}">${a.itname}</option>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label for="gtb_node_id" class="col-sm-4 control-label">所属节点：</label>
													<div class="col-sm-8">
														<select name="gtb_node_id" class="form-control input-sm" id="gtb_node_id">
															<option value="0">选择所属项目</option>
															<c:forEach var="a" items="${tb_nodelist }">
																<option value="${a.id}">${a.itname}-${a.nodename}</option>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label for="gtb_zweit_id" class="col-sm-4 control-label">所属底层：</label>
													<div class="col-sm-8">
														<select name="gtb_zweit_id" class="form-control input-sm" id="gtb_zweit_id">
															<option value="0">选择所属底层</option>
															<c:forEach var="a" items="${tb_zweitlist }">
																<option value="${a.id}">${a.zweiterst}-${a.zweitname}</option>
															</c:forEach>
														</select>
													</div>
												</div>
												<div class="form-group">
													<label for="gmname" class="col-sm-4 control-label">模型名称：</label>
													<div class="col-sm-8">
														<input name="gmname" id="gmname" class="form-control input-sm"/>
													</div>
												</div>
												<div class="form-group">
													<label for="gmfile" class="col-sm-4 control-label">模型文件：</label>
													<div class="col-sm-8">
														<input type="file" id="gmfile" name="gmfile" class="form-control input-sm"/>
													</div>
												</div>
												<div class="form-group">
													<label for="gmattr" class="col-sm-4 control-label">属性：</label>
													<div class="col-sm-8">
														<textarea name="gmattr" id="gmattr" rows="4" cols="40" class="form-control"></textarea>
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
		<script type="text/JavaScript" src="<%=basePath %>js/My97DatePicker/WdatePicker.js"></script>
	</body>
</html>
