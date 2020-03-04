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
		<title>DVP数字整车平台</title>
		<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet"/>
		<link href="<%=basePath%>css/themify-icons.css" rel="stylesheet"/>
		<link href="<%=basePath%>css/simdahs.css" rel="stylesheet"/>
		<link href="<%=basePath%>css/sidebar.css" rel="stylesheet"/>
		<link href="<%=basePath%>css/style.css" rel="stylesheet"/>
		<link href="<%=basePath%>css/irons.css" rel="stylesheet"/>
		<style type="text/css">
			#sideLogo a{
			font-size: 20px;
			color: white;
			}
		</style>
	</head>
	<body>
		<!-- menu start -->
		<div class="sidebar sidebar-hide-to-small sidebar-shrink sidebar-gestures">
			<div class="nano">
				<div class="nano-content">
					<c:if test="${not empty myinfo}">
					<c:if test="${myinfo.utype=='管理员'}">
					<ul>
						<li><a class="sidebar-sub-toggle"><i class="ti-panel"></i> 用户管理 <span class="sidebar-collapse-icon ti-angle-down"></span></a>
							<ul>
								<li><a href="<%=basePath%>tb_users/tb_users_init" target="subfrm">用户信息管理</a></li>
							</ul>
						</li>
						<li><a class="sidebar-sub-toggle"><i class="ti-panel"></i> 项目管理 <span class="sidebar-collapse-icon ti-angle-down"></span></a>
							<ul>
								<li><a href="<%=basePath%>tb_node/tb_users_show" target="subfrm">项目信息管理</a></li>
								<li><a href="<%=basePath%>tb_node/tb_users_init" target="subfrm">项目节点管理</a></li>
								<li><a href="<%=basePath%>tb_task/tb_users_init" target="subfrm">仿真任务管理</a></li>
								<li><a href="<%=basePath%>tb_tasktime/tb_users_init" target="subfrm">工时统计管理</a></li>
								<li><a href="<%=basePath%>tb_ips/tb_users_init" target="subfrm">IPS项目</a></li>		
							</ul>
						</li>
						<li><a class="sidebar-sub-toggle"><i class="ti-panel"></i> 结构树 <span class="sidebar-collapse-icon ti-angle-down"></span></a>
							<ul>
								<li><a href="<%=basePath%>views/tb_users/mtb_tree.jsp" target="subfrm">声学结构树</a></li>
							</ul>
						</li>
						<li><a class="sidebar-sub-toggle"><i class="ti-panel"></i> 模型管理 <span class="sidebar-collapse-icon ti-angle-down"></span></a>
							<ul>
								<li><a href="<%=basePath%>tb_model/tb_users_init" target="subfrm">模型信息管理</a></li>
								<li><a href="<%=basePath%>tb_hmark/tb_users_init" target="subfrm">模型记录管理</a></li>
							</ul>
						</li>
						<li><a class="sidebar-sub-toggle"><i class="ti-panel"></i> 仿真标准管理<span class="sidebar-collapse-icon ti-angle-down"></span></a>
						<ul>
								<li><a href="<%=basePath%>tb_content/tb_users_init" target="subfrm">建模标准管理</a></li>
							</ul>
						</li>
						<li><a class="sidebar-sub-toggle"><i class="ti-panel"></i> 报表管理<span class="sidebar-collapse-icon ti-angle-down"></span></a>
						</li>
						<li><a href="<%=basePath%>login/logout"><i class="ti-close"></i> 安全退出</a></li>
					</ul>
					</c:if>
					<c:if test="${myinfo.utype=='普通用户'}">
					<ul>
						<li><a href="<%=basePath%>views/myinfo.jsp" target="subfrm"><i class="ti-panel"></i> 我的信息 </a>
							
						</li>
						<li><a class="sidebar-sub-toggle"><i class="ti-panel"></i> 项目查看 <span class="sidebar-collapse-icon ti-angle-down"></span></a>
							<ul>
								<li><a href="<%=basePath%>tb_iterms/tb_users_init" target="subfrm">项目信息查看</a></li>
								<li><a href="<%=basePath%>tb_node/tb_users_init" target="subfrm">项目节点查看</a></li>
								<li><a href="<%=basePath%>tb_task/tb_users_init" target="subfrm">仿真任务查看</a></li>
								<li><a href="<%=basePath%>tb_erst/tb_users_init" target="subfrm">第一层查看</a></li>
							</ul>
						</li>
						<li><a href="<%=basePath%>tb_model/tb_users_init" target="subfrm"><i class="ti-panel"></i> 模型管理 </a>
						</li>
						<li><a class="sidebar-sub-toggle"><i class="ti-panel"></i> 仿真标准<span class="sidebar-collapse-icon ti-angle-down"></span></a>
						</li>
						<li><a class="sidebar-sub-toggle"><i class="ti-panel"></i> 自动生成报表<span class="sidebar-collapse-icon ti-angle-down"></span></a>
						</li>
						<li><a href="<%=basePath%>login/logout"><i class="ti-close"></i> 安全退出</a></li>
					</ul>
					</c:if>
					</c:if>
				</div>
			</div>
		</div>
		<!-- /# sidebar -->
		<!-- header start -->
		<div style="background: #337ab7" class="header">
			<div class="pull-left" style="width: 30%;">
				<div style="background: #337ab7" class="logo" id="sideLogo">
					<a href="javascript:void(0);" onclick="return false;">
						CAE模型资源管理系统
					</a>
					<!-- <span class="mesg">
						<a href=""><i class="ti-email"></i></a>
					</span> -->
				</div>
			</div>
			<div class="pull-right p-r-15">
				<ul>
					<li class="header-icon dib"><a href="<%=basePath%>tb_message/tb_message_show"  target="subfrm"  class="nav"><i class="ti-email"></i></a></li> 
>				</ul>
			</div>
		</div>
		<!-- header end -->
		<div class="content-wrap">
			<iframe frameborder="0" scrolling="no" id="subfrm" name="subfrm" onload="changeFrameHeight();" style="width: 100%;min-height: 500px;" src="<%=basePath%>tb_node/tb_users_show" ></iframe>
		</div><!-- /# content wrap -->
		<script src="<%=basePath%>js/jquery-2.2.3.min.js"></script><!-- jquery vendor -->
		<script src="<%=basePath%>js/jquery.nanoscroller.min.js"></script><!-- nano scroller -->
		<script src="<%=basePath%>js/sidebar.js"></script><!-- sidebar -->
		<script src="<%=basePath%>js/bootstrap.min.js"></script><!-- bootstrap -->
		<script type="text/javascript">
			function changeFrameHeight(){
				var ifm= document.getElementById("subfrm");
				var ifmw=ifm.contentWindow;
				ifm.height=ifmw.document.documentElement.scrollHeight || ifmw.document.body.scrollHeight;
				$("#subfrm").css("min-height","700px");
			}
			window.onresize=function(){
				changeFrameHeight();
			}
			function getMessageCount() {
				$('document').ready(function() {
					$.ajax({
						type:'GET',
						url: 'tb_message/getCount',
						dataType:'json',
						success:function(data){
							$('.nav').remove(".nav-counter nav-counter-blue");
							if(data<=99){
								$('.nav').append("<div class='nav-counter nav-counter-blue'>"+data+"</div>");
							}else if(data>99){
								$('.nav').append("<div class='nav-counter nav-counter-blue'>"+"99+"+"</div>");
							}
						}
					});
				});
			}
			/* setInterval(()=>{
				getMessageCount();
			}, 1000); */
			window.onload=getMessageCount;
		</script>
	</body>
</html>