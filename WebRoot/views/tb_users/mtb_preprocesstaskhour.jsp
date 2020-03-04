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
<title>各项目同类型任务工时</title>
<script type="text/javascript" src="<%=basePath%>js/echarts.js"></script>
</head>
<body>
	<h2>各人员任务工时</h2>
	<div id="main" style="width: 100%; height: 600px;"></div>
	<script type="text/javascript">
		var taskshour =[[{"rhour" : 6,"name" : "陈涛"}, {"rhour" : 8,"name" : "孙涛"}, {"rhour" : 10,"name" : "余鸿成"}, {"rhour" : 16,"name" : "谌壮"},{"totalhour":60,"taskname":"Wassermanagement"}],
						[{"rhour" : 7,"name" : "陈涛"}, {"rhour" : 6,"name" : "孙涛"}, {"rhour" : 8,"name" : "余鸿成"}, {"rhour" : 15,"name" : "谌壮"},{"totalhour":54,"taskname":"Karoseriedichtigkeit"}],
						[{"rhour" : 5,"name" : "陈涛"}, {"rhour" : 10,"name" : "孙涛"}, {"rhour" : 12,"name" : "余鸿成"}, {"rhour" : 18,"name" : "谌壮"},{"totalhour":67,"taskname":"IPS"}],
						[{"rhour" : 7,"name" : "陈涛"}, {"rhour" : 7,"name" : "孙涛"}, {"rhour" : 10,"name" : "余鸿成"}, {"rhour" : 16,"name" : "谌壮"},{"totalhour":61,"taskname":"Gewicht"}],
						[{"rhour" : 5,"name" : "陈涛"}, {"rhour" : 10,"name" : "孙涛"}, {"rhour" : 12,"name" : "余鸿成"}, {"rhour" : 18,"name" : "谌壮"},{"totalhour":67,"taskname":"Energiemanagement"}],
						];
		//名称数组
		var nameData=[];
		//Wassermanagement任务数组
		var wData=[];
		//Karoseriedichtigkeit任务数组
		var kData=[];
		//IPS任务数组
		var iData=[];
		//Gewicht任务数组
		var gData=[];
		//Energiemanagement任务数组
		var eData=[];
		//颜色集合
		var colorData=[];
		var cData=[];
		//xAxis
		var xAxis=[];
		//yaxis
		var yAxis=[];
		//数据集
		var series=[];
		 for (var i = 0; i <taskshour.length; i++) {
			 if(taskshour[i][taskshour[i].length-1].taskname=="Wassermanagement"){
				 for (var j = 0; j < taskshour[i].length-1; j++) {
					wData.push(taskshour[i][j].rhour);
					nameData.push(taskshour[i][j].name);
					cData.push(0);
				 }
			 }else if(taskshour[i][taskshour[i].length-1].taskname=="Karoseriedichtigkeit"){
				 for (var j = 0; j < taskshour[i].length-1; j++) {
						kData.push(taskshour[i][j].rhour);
				 }
			 }else  if(taskshour[i][taskshour[i].length-1].taskname=="IPS"){
				 for (var j = 0; j < taskshour[i].length-1; j++) {
						iData.push(taskshour[i][j].rhour);
				 }
			  }else if(taskshour[i][taskshour[i].length-1].taskname=="Gewicht"){
				  for (var j = 0; j < taskshour[i].length-1; j++) {
						gData.push(taskshour[i][j].rhour);
				 }
			  }else if(taskshour[i][taskshour[i].length-1].taskname=="Energiemanagement"){
				  for (var j = 0; j < taskshour[i].length-1; j++) {
						eData.push(taskshour[i][j].rhour);
				 }
			  }
			 var r = Math.floor(Math.random()*256);
				var g = Math.floor(Math.random()*256);
				var b = Math.floor(Math.random()*256);
				var color = '#'+r.toString(16)+g.toString(16)+b.toString(16);
				colorData.push(color);
			 xAxis.push( {
					type : 'category',
					gridIndex : i,
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
					data : nameData
				} );
			yAxis.push({
				type : 'value',
				gridIndex : i,
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
			});
			series.push({
					type : 'line',
					xAxisIndex : i,
					yAxisIndex : i,
					 itemStyle:{ 
	                  normal:{ 
	                    color:'black', //折点颜色
	                    lineStyle:{ 
	                       color:'black' //折线颜色
	                            } 
	                   } 
	             },
					data : cData
			});
		} 
		series.push({
				type : 'bar',
				itemStyle : { //显示数值
					normal : {
						color : function(params) {
							var colorList = colorData;
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
				xAxisIndex : 0,
				yAxisIndex : 0,
				barWidth : 30,
				emphasis : {
					barGap : '30%',
				},
				data : wData
			},{
				type : 'bar',
				itemStyle : { //显示数值
					normal : {
						color : function(params) {
							var colorList = colorData;
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
				xAxisIndex : 1,
				yAxisIndex : 1,
				barWidth : 30,
				emphasis : {
					barGap : '30%',
				},
				data : kData
			},{
				type : 'bar',
				itemStyle : { //显示数值
					normal : {
						color : function(params) {
							var colorList = colorData;
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
				xAxisIndex : 2,
				yAxisIndex : 2,
				barWidth : 30,
				emphasis : {
					barGap : '30%',
				},
				data : iData
			},{
				type : 'bar',
				itemStyle : { //显示数值
					normal : {
						color : function(params) {
							var colorList = colorData;
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
				xAxisIndex : 3,
				yAxisIndex : 3,
				barWidth : 30,
				emphasis : {
					barGap : '30%',
				},
				data : gData
			},{
				type : 'bar',
				itemStyle : { //显示数值
					normal : {
						color : function(params) {
							var colorList = colorData;
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
				xAxisIndex : 4,
				yAxisIndex : 4,
				barWidth : 30,
				emphasis : {
					barGap : '30%',
				},
				data : eData
			});
		
		
		//准备dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('main'));
		//指定图表的配置项和数据
		option = {
			title : [ {
				text : '1、Wassermanagement任务',
				left : '15%',
				top : '8%',
				textAlign : 'center'
			},{
				text : '2、Karoseriedichtigkeit任务',
				left : '45%',
				top : '8%',
				textAlign : 'center'
			},{
				text : '3、IPS任务',
				left : '75%',
				top : '8%',
				textAlign : 'center'
			},{
				text : '4、Gewicht任务',
				left : '25%',
				top : '55%',
				textAlign : 'center'
			},{
				text : '5、Energiemanagement任务',
				left : '65%',
				top : '55%',
				textAlign : 'center'
			} ],
			tooltip : {}, 
			grid : [ {
				left : '10%',
				right : 'auto',
				top : '20%',
				width : '20%',
				height : '25%',
			},{
				left : '40%',
				right : 'auto',
				top : '20%',
				width : '20%',
				height : '25%',
			},{
				left : '70%',
				right : 'auto',
				top : '20%',
				width : '20%',
				height : '25%',
			},{
				left : '20%',
				right : 'auto',
				top : '65%',
				width : '20%',
				height : '25%',
			},{
				left : '60%',
				right : 'auto',
				top : '65%',
				width : '20%',
				height : '25%',
			}],
			xAxis : xAxis,
			yAxis :yAxis,
			series :series
		};
		//将配置项和数据放在实例中
		myChart.setOption(option);
	</script>
</body>
</html>