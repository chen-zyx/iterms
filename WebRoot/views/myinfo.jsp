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
			
	</head>
	<body>		
		<div style="margin-top: 300px;" role="dialog" aria-labelledby="myModalLabel" data-backdrop="static" aria-hidden="true" id="gldiv" >
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">
							我的信息
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
													<div class="col-sm-8" style="line-height: 40px;">
														${myinfo.uno }
													</div>
												</div>
												<div class="form-group">
													<label for="guname" class="col-sm-4 control-label">姓名：</label>
													<div class="col-sm-8" style="line-height: 40px;">
														${myinfo.uname }
													</div>
												</div>
												<div class="form-group">
													<label for="guemail" class="col-sm-4 control-label">邮箱：</label>
													<div class="col-sm-8" style="line-height: 40px;">
														${myinfo.uemail }
													</div>
												</div>
												<div class="form-group">
													<label for="gupwd" class="col-sm-4 control-label">密码：</label>
													<div class="col-sm-8" style="line-height: 40px;">
														${myinfo.upwd }
													</div>
												</div>
												
												<div class="form-group">
													<label for="gutype" class="col-sm-4 control-label">用户权限：</label>
													<div class="col-sm-8" style="line-height: 40px;">
														${myinfo.utype }
													</div>
												</div>
												<div class="form-group">
													<label for="guflag" class="col-sm-4 control-label">上传次数：</label>
													<div class="col-sm-8" style="line-height: 40px;">
														${myinfo.upnums }
													</div>
												</div>
												<div class="form-group">
													<label for="guflag" class="col-sm-4 control-label">下载次数：</label>
													<div class="col-sm-8" style="line-height: 40px;">
														${myinfo.dnums }
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
						<!-- 
						<button type="button" class="btn btn-warning" onclick="gltj()">保存</button>
						<button type="button" class="btn btn-warning" onclick="rst()">退出</button>
						 -->
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal -->
		</div>
	</body>
</html>
