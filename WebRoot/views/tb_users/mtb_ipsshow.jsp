<%@page import="org.springframework.web.context.request.SessionScope"%>
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
<title>ips仿真项目详细信息</title>
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
.p {
	font-size: 20px;
	font-weight: bold;
}

.t2 tr {
	height: 30px;
}

.t2 td {
	width: 450px;
	text-align: left;
}
.t2 tr td {
	text-align: left;
}
.a{
	font-size:20px;
	margin-left: 800px;
	color:blue;
	text-decoration: none;
}
</style>
</head>
<body>
	<div class="main">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-4 p-0">
					<div class="page-header">
						<div class="page-title">
							<h1>ips仿真项目详细信息</h1>
						</div>
					</div>
				</div>
				<div class="main-content" style="margin-left: 50px;">
					<table>
						<tr>
							<table>
								<thead>
									<p class="p">1.基本信息</p>
								</thead>
								<tbody class="t2">
									<tr>
										<td>车型 &nbsp;:&nbsp;${ips.project}</td>
										<td style="text-align: left;">平台&nbsp;:&nbsp;${ips.platform}</td>
									</tr>
									<tr>
										<td>项目&nbsp;:&nbsp;${ips.project}</td>
										<td style="text-align: left;">激励源&nbsp;:&nbsp;${ips.inputsource}</td>
									</tr>
									<tr>
										<td>发动机&nbsp;:&nbsp;${ips.engine}</td>
										<td style="text-align: left;">变速箱&nbsp;:&nbsp;${ips.gearbox}</td>
									</tr>
									<tr>
										<td>时间 &nbsp;:&nbsp;${ips.ipstime}</td>
										<td style="text-align: left;">工程师 &nbsp;:&nbsp;${ips.uname}</td>
									</tr>
								</tbody>
							</table>
						</tr>
						<tr>
							<table>
								<thead>
									<p class="p">2.零件</p>
								</thead>
								<tbody class="t2">
									<tr>
										<td style="text-align: left;">风险零件号1 &nbsp;:&nbsp;${ips.riskpartid}</td>
										<td style="text-align: left;">TM &nbsp;:&nbsp;${ips.tm}</td>
									</tr>
									<tr>
										<td style="text-align: left;">风险零件号2&nbsp;:&nbsp;${ips.anriskpartid}</td>
										<td style="text-align: left;">TM &nbsp;:&nbsp;${ips.antm}</td>
									</tr>
									<tr>
										<td style="text-align: left;">管类 &nbsp;:&nbsp;${ips.pipe}</td>
									</tr>
								</tbody>
							</table>
						</tr>
						<tr>
							<table>
								<thead>
									<p class="p">3.CAD图示</p>
								</thead>
								<tbody>
									<tr>
										<td style="text-align: left;"><img  style="width: 1000px;height: 500px;" src="/img/${ips.path}/${ips.cadjpg}"> </td>
										<!-- <img src="/img/${ips.cadjpg}"> -->
									</tr>
									<tr>
										<td style="text-align: center;">CAD图示</td>
									</tr>
								</tbody>
							</table>
						</tr>
						<tr>
							<table>
								<thead>
									<p class="p">4.PMU照片</p>
								</thead>
								<tbody>
									<tr>
										<td style="width:400px;text-align: left;"><img style="width: 500px;height: 300px;"  src="/img/${ips.path}/${ips.pmujpg}"> </td>
									</tr>
									<tr>
										<td style="text-align: center;">PMU图示</td>
									</tr>
								</tbody>
							</table>
						</tr>
						<tr>
							<table>
								<thead>
									<p class="p">5.DL照片</p>
								</thead>
								<tbody>
									<tr>
										<td style="width:400px;text-align: left;"><img src="/img/${ips.path}/${ips.ojpg}"> </td>
									</tr>
									<tr>
										<td  style="text-align: center;">DL图示</td>
									</tr>
								</tbody>
							</table>
						</tr>
						<br><br>
						<tr>	
							<a href="<%=basePath%>tb_ips/tb_ips_download">输出word</a>
							<a class="a" href="<%=basePath%>tb_ips/tb_ips_download?filename=${ips.ipsfile}">下载</a>
						</tr>
						<br><br>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>