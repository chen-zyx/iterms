<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<base href="<%=basePath%>">
<title>工时模块</title>
<script src="<%=basePath%>js/jquery-2.2.3.min.js"></script>
<!-- jquery vendor -->
<script type="text/javascript" src="<%=basePath%>js/echarts.js"></script>
</head>
<body>
	<h2 class="h"></h2>
	<div id="main" style="width: 800px; height: 600px;"></div>
	<script type="text/javascript">
		var tasktime =<%=session.getAttribute("tasktime")%>;
		console.log(tasktime);
		var name = tasktime[0].taskname;
		$('.h').html(name + "实际工时");
		//任务名称数组
		var taskname = [];
		//实际工时
		var actualtime = [];
		//工时
		var time = [];
		for (var i = 0; i < tasktime.length; i++) {
			taskname.push(tasktime[i].tname);
			actualtime.push({
				value : tasktime[i].rhour,
				name : taskname[i]
			});
			time.push( tasktime[i].rhour);
		}
		//准备dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('main'));
		//指定图表的配置项和数据
		option = {
			title : [ {
				text : '1、' + name + '各任务工时(百分比)',
				left : '25%',
				textAlign : 'center'
			}, {
				text : '2、' + name + '各任务工时(数值)',
				left : '75%',
				textAlign : 'center'
			} ],
			tooltip : [ {
				trigger : 'item',
				formatter : '{a} <br/>{b} : {c} ({d}%)'
			} ],
			grid : [ {
				left : '75%',
				right : 'auto',
				top : '12%',
				height : '25%',
				containLabel : false
			} ],
			xAxis : [ {
				type : 'value',
				show : false
			} ],
			yAxis : [ {
				type : 'category',
				boundaryGap : false,
				axisLabel : {
					show : true,
					margin : 10,
				},
				axisLine : {
					show : false
				},
				axisTick : {
					show : false
				},
				splitLine : {
					show : false
				},
				data : taskname.reverse()
			} ],
			series : [ {
				name : '项目A实际工时',
				type : 'pie',
				radius : [ 0, '30%' ],
				center : [ '25%', '25%' ],
				data : actualtime
			}, {
				type : 'bar',
				itemStyle : { //显示数值
					normal : {
						barBorderRadius : 7,
						label : {
							show : true, //开启显示
							position : 'inside',
							textStyle : { //数值样式
								color : 'white',
								fontSize : 16
							}
						}
					},

				},
				barWidth : 20,
				data : time.reverse(),
			} ]
		};
		//将配置项和数据放在实例中
		myChart.setOption(option);
	</script>
</body>
</html>