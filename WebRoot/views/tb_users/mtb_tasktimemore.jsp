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
<script type="text/javascript" src="<%=basePath%>js/echarts.js"></script>
</head>
<body>
	<h2>多项目实际工时</h2>
	<div id="main" style="width: 800px; height: 600px;"></div>
	<script type="text/javascript">
		var tasktimemore =<%=session.getAttribute("tasktimemore")%>;
		console.log(tasktimemore);
		//项目数组
		var pData=[];
		//任务数组
		var taskData=[];
		//项目总实际工时
		var tataltimeData=[];
		//任务工时
		var tasktimeData=[];
		//数据集
		var series=[];
		 for (var i = 0; i < tasktimemore.length; i++) {
			 var temp=[];
			 for (var j = 0; j < tasktimemore[i].length-1; j++) {
				 if(taskData.indexOf(tasktimemore[i][j].tname)==-1){
						taskData.push(tasktimemore[i][j].tname);
					}
				 temp.push(tasktimemore[i][j].rhour);
			}
			 tasktimeData.push(temp);
			 pData.push(tasktimemore[i][tasktimemore[i].length-1].taskname);
			 tataltimeData.push(tasktimemore[i][tasktimemore[i].length-1].totalhour);
		} 
		console.log(tasktimeData);
		for (var i = 0; i < tasktimemore.length; i++) {
			series.push({
					name : pData[i],
					type : 'bar',
					xAxisIndex : 1,
					yAxisIndex : 1,
					data : tasktimeData[i]
			});
		}
		series.push({
				type : 'bar',
				itemStyle : { //显示数值
					normal : {
						color : function(params) {
							var colorList = [ '#87CEEB', '#363636',
									'#68838B', '#EE9A00', '#EE3B3B'];
							return colorList[params.dataIndex]
						},
						label : {
							show : true, //开启显示
							position : 'top',
							textStyle : { //数值样式
								color : 'black',
								fontSize : 16
							}
						}
					}
				},
				barWidth : 30,
				emphasis : {
					barGap : '30%',
				},
				xAxisIndex : 0,
				yAxisIndex : 0,
				data : tataltimeData
			}, {
				type : 'line',
				xAxisIndex : 0,
				yAxisIndex : 0,
				 itemStyle:{ 
                     normal:{ 
                       color:'black', //折点颜色
                       lineStyle:{ 
                          color:'black' //折线颜色
                               } 
                      } 
                },
				data : [ 0, 0, 0, 0, 0 ]
		});
		//准备dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('main'));
		//指定图表的配置项和数据
		option = {
			title : [ {
				text : '多项目实际工时展示',
				left : '25%',
				textAlign : 'center'
			}, {
				text : '同类型任务实际工时展示',
				left : '75%',
				textAlign : 'center'
			} ],
			tooltip : {}, 
			legend : {
				left : '70%',
				right : 'auto',
				top : '45%',
				height : '25%',
				show : true,
				data : pData
			},
			grid : [ {
				left : '15%',
				right : 'auto',
				top : '12%',
				width : '35%',
				height : '25%',
			}, {
				left : '65%',
				right : 'auto',
				top : '12%',
				height : '25%',
				tooltip : {
					trigger : 'axis',
					 axisPointer : {
						type:'shadow'
					}, 
					show : true,
				},
			} ],
			xAxis : [ {
				type : 'category',
				boundaryGap : true,
				axisLine : {
					show : true,
					interval : 0,
					lineStyle : {
						color : 'black',
						width : 2,
					}
				},
				axisTick : {
					show : false,
					interval : 0,
					alignWithLabel : true,
				},
				data : pData
			}, {
				type : 'category',
				gridIndex : 1,
				lineStyle : {
					type : 'dashed',
				},
				axisLine : {
					show : true,
					interval : 0,
				},
				axisTick : {
					show : false,
				},
				axisLabel :{  
				    interval:0   
				}, 
				data : taskData
			} ],
			yAxis : [ {
				type : 'value',
				show : false,
			}, {
				type : 'value',
				gridIndex : 1,
				show : true,
				axisLabel : {
					show : true,
					margin : 10
				},
				axisLine : {
					show : false,
				},
				axisTick : {
					show : false,
				},
				splitLine : {
					show : true
				}
			} ],
			series :series
		};
		//将配置项和数据放在实例中
		myChart.setOption(option);
	</script>
</body>
</html>