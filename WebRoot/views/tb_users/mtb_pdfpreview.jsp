<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>PDF预览</title>
<script src="<%=basePath%>js/jquery-2.2.3.min.js"></script>
<script src="<%=basePath%>js/pdfobject.js"></script>
</head>
<body>
	<div id="example1" style="height:800px;margin-bottom: 20px;"></div>
	<script type="text/javascript">
		PDFObject.embed("/img/${ips.path}/${ips.aekofile}", "#example1");
	</script>
</body>
</html>