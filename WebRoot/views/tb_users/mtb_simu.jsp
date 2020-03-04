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
												<th>项目节点</th>
												<th>时间节点</th>
												<th>底盘舒适性</th>
												<th>整车温度</th>
												<th>载荷提取</th>
												<th>通过性</th>
												<th>异响</th>
												<th>水管理</th>
												<th>密封性</th>
												<th>柔性管路</th>
												
												<th style="width:5%;"></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="a" items="${flist }">
											 
											<tr>
												<c:if test="${not empty myinfo && myinfo.utype=='管理员' }">
												<td style="width:5%;"><input name="delid" type="checkbox" value="${a.id }"/></td>
												</c:if>
												<td>${a.project }-${a.name }</td>
												<td>${a.wochestr }</td>	
												<td>${a.akusitu }</td>	
												<td>${a.bausitu }</td>	
												<td>${a.lassitu }</td>	
												<td>${a.bodensitu }</td>	
												<td>${a.klasitu }</td>	
												<td>${a.wassitu }</td>	
												<td>${a.karositu }</td>	
												<td>${a.ipssitu }</td>	
													
												
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
		
	</body>
</html>