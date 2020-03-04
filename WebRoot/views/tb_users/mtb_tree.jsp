<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
		<title>结构树</title>
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
		<link rel="stylesheet" href="<%=basePath%>css/dtree.css" type="text/css" />	
		<script src="<%=basePath%>js/dtree.js"></script>	
		<script type="text/javascript" type="text/javascript">
		</script>
</head>
<body>
		<div class="main">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-4 p-0">
						<div class="page-header">
							<div class="page-title">
								<h1>结构树</h1>
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


<div class="dtree">

<p> <a href="javascript: d.openAll();" >展开所有</a> | <a href="javascript: d.closeAll();">关闭所有</a></p>
 
    <script type="text/javascript">
    <!--

	d = new dTree('d');

	d.add(0,-1,'Akustik Simulation Data','<%=basePath%>tb_iterms/tb_users_init');
	d.add(1,0,'SA C SUV','example01.html');
	d.add(2,0,'SA A+ SUVe','example01.html');
	d.add(3,1,'KF','example01.html');
	d.add(4,0,'Lavida NF','example01.html');
	d.add(5,3,'component model','example01.html');
	d.add(6,5,'TB&Mode','example01.html');
	d.add(7,2,'Serie','example01.html');
	d.add(8,5,'Seat','example01.html');
	d.add(9,4,'VPT','example01.html');
	d.add(10,4,'BST','example01.html');
	d.add(11,4,'Serie','example01.html');
	d.add(12,2,'BST','example01.html');
	d.add(13,1,'VPT','example01.html');
	d.add(14,1,'BST','example01.html');
	d.add(15,1,'Serie','example01.html');
	d.add(16,3,'Load','example01.html');
	d.add(17,3,'ASPT Konfigration','example01.html');
	d.add(18,3,'Whole vehicle model','example01.html');
	d.add(19,16,'Road spectrum','example01.html');
	d.add(20,16,'Powertrain Load','example01.html');
	d.add(21,5,'Cavity&Mode','example01.html');
	d.add(22,5,'Chasis','example01.html');
	d.add(23,5,'Tire','example01.html');
	d.add(24,5,'Other','example01.html');
	d.add(25,18,'10000','example01.html');
	d.add(26,18,'20000','example01.html');
	d.add(27,18,'30000','example01.html');
	d.add(28,18,'40000','example01.html');
	d.add(29,18,'50000','example01.html');
	d.add(30,18,'Other','example01.html');
	d.add(31,18,'Vgfa Report','example01.html');

	document.write(d);

	//-->
    </script>
   
</div> 
</div> 
</div> 
</div> 
</div> 
</div> 
</div> 


</body>
</html>