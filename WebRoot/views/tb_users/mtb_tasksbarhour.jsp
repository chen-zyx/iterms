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
	<h2>多项目实际工时</h2>
	<div id="main" style="width: 100%; height: 200px;"></div>
	<div id="main1" style="width: 100%; height: 600px;"></div>
	<script type="text/javascript">
		var taskshour =[[{"rhour" : 6,"tname" : "Wassermanagement"}, {"rhour" : 8,"tname" : "Karoseriedichtigkeit"}, {"rhour" : 10,"tname" : "IPS"}, {"rhour" : 16,"tname" : "Gewicht"},{"rhour" : 20,"tname" : "Energiemanagement"},{"totalhour":60,"taskname":"Lamando NF"}],
						[{"rhour" : 7,"tname" : "Wassermanagement"}, {"rhour" : 6,"tname" : "Karoseriedichtigkeit"}, {"rhour" : 8,"tname" : "IPS"}, {"rhour" : 15,"tname" : "Gewicht"},{"rhour" : 18,"tname" : "Energiemanagement"},{"totalhour":54,"taskname":"Csuv"}],
						[{"rhour" : 5,"tname" : "Wassermanagement"}, {"rhour" : 10,"tname" : "Karoseriedichtigkeit"}, {"rhour" : 12,"tname" : "IPS"}, {"rhour" : 18,"tname" : "Gewicht"},{"rhour" : 22,"tname" : "Energiemanagement"},{"totalhour":67,"taskname":"AIL"}],
						[{"rhour" : 7,"tname" : "Wassermanagement"}, {"rhour" : 7,"tname" : "Karoseriedichtigkeit"}, {"rhour" : 10,"tname" : "IPS"}, {"rhour" : 16,"tname" : "Gewicht"},{"rhour" : 21,"tname" : "Energiemanagement"},{"totalhour":61,"taskname":"AtSuve"}],
						];
		//项目数组
		var taskData=[];
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
		//项目总实际工时
		var tatalhourData=[];
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
			 for (var j = 0; j < taskshour[i].length-1; j++) {
				 if(taskshour[i][j].tname=="Wassermanagement"){
					 wData.push(taskshour[i][j].rhour);
					}else if(taskshour[i][j].tname=="Karoseriedichtigkeit"){
					 kData.push(taskshour[i][j].rhour);
					}else if(taskshour[i][j].tname=="IPS"){
					 iData.push(taskshour[i][j].rhour);
					}else if(taskshour[i][j].tname=="Gewicht"){
					 gData.push(taskshour[i][j].rhour);
					}else if(taskshour[i][j].tname=="Energiemanagement"){
					 eData.push(taskshour[i][j].rhour);
					}
			}
			 taskData.push(taskshour[i][taskshour[i].length-1].taskname);
			 tatalhourData.push(taskshour[i][taskshour[i].length-1].totalhour);
			 var r = Math.floor(Math.random()*256);
				var g = Math.floor(Math.random()*256);
				var b = Math.floor(Math.random()*256);
				var color = '#'+r.toString(16)+g.toString(16)+b.toString(16);
				colorData.push(color);
				cData.push(0);
		} 
		 for (var i = 0; i < 5; i++) {
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
					data : taskData
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
			barWidth : 30,
			emphasis : {
				barGap : '30%',
			},
			xAxisIndex : 0,
			yAxisIndex : 0,
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
			barWidth : 30,
			emphasis : {
				barGap : '30%',
			},
			xAxisIndex : 1,
			yAxisIndex : 1,
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
			barWidth : 30,
			emphasis : {
				barGap : '30%',
			},
			xAxisIndex : 2,
			yAxisIndex : 2,
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
			barWidth : 30,
			emphasis : {
				barGap : '30%',
			},
			xAxisIndex : 3,
			yAxisIndex : 3,
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
			barWidth : 30,
			emphasis : {
				barGap : '30%',
			},
			xAxisIndex : 4,
			yAxisIndex : 4,
			data : eData
		});
		//准备dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('main'));
		option = {
				title : [ {
					text : '各项目实际总工时展示',
					left : '25%',
					textAlign : 'center'
				} ],
				tooltip : {}, 
				xAxis : {
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
					axisLabel :{  
					    interval:0   
					}, 
					data : taskData
				},
				yAxis :{
					type : 'value',
					show : false,
			},
				series :[{
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
					barWidth : 30,
					emphasis : {
						barGap : '30%',
					},
					xAxisIndex : 0,
					yAxisIndex : 0,
					data : tatalhourData
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
					data : cData
			}]
			};
			//将配置项和数据放在实例中
			myChart.setOption(option);
			
		//准备dom，初始化echarts实例
		var myChart1 = echarts.init(document.getElementById('main1'));
		//指定图表的配置项和数据
		option1 = {
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
		myChart1.setOption(option1);
	</script>
</body>
</html>