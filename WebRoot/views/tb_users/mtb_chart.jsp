<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.iterms.been.Modell"
	import="com.iterms.been.ExcelData" import="java.util.List"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	session.setAttribute("bpath", basePath);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<base href="<%=basePath%>">
<title>echarts显示Excel节点</title>
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
<script type="text/javascript" src="<%=basePath%>js/echarts.js"></script>
</head>
<body>
	<div id="main" style="width: 1200px; height: 600px;"></div>
	<div> 
		<input type="button" onclick="pre();" value="上一页"/>
		<input type="button" onclick="next();" value="下一页"/>
		<a href="<%=basePath%>tb_tasktime/tb_tasktime_show" target="subfrm">工时显示</a>
		<a href="<%=basePath%>tb_tasktime/tb_tasktime_tochart2" target="subfrm">Lamando NF</a>
	</div>
	<script type="text/javascript">
		var data =
	<%=session.getAttribute("data")%>
		;
		//console.log(data);
		var arr = [];
		var i=0;
		
		for (i; i < 10; i++) {
			arr.push(data[i]);
		}
		//console.log(arr);
	 	function next(){
	 		if(i>data.length-10){
	 			return;
	 		}
			k=i+10;
			arr.splice(0,arr.length);
			for (i; i < k; i++) {
				arr.push(data[i]);
			}
			showChart();
		} 
	 	function pre(){
			if(i<=10){
				return;
			}
			k=i-10;
			i=i-20;
			arr.splice(0,arr.length);
			for (i; i < k; i++) {
				arr.push(data[i]);
			}
			showChart();
		}
		function showChart(){
			//x軸年份數組
			var yearData = [];
			var yData = [];
			//x軸月份數組
			var monthData = [];
			//名字數組
			var nameData = [];
			//BF坐标数组
			var pointBData=[];
			//LF坐标数组
			var pointLData=[];
			//VFF坐标数组
			var pointVData=[];
			//PVS坐標數組
			var pointPData = [];
			//OS坐標數組
			var pointOData = [];
			//SOP坐標數組
			var pointSData = [];
			//轉儲數據
			for (var i = 0; i < arr.length; i++) {
				//先將年份數據放在一塊，之後在去重
				if (arr[i].bdate != null && arr[i].bdate.length != 0) {
					yearData.push(arr[i].bdate.substring(0, 4));
				}
				if (arr[i].ldate != null && arr[i].ldate.length != 0) {
					yearData.push(arr[i].ldate.substring(0, 4));
				}
				if (arr[i].vdate != null && arr[i].vdate.length != 0) {
					yearData.push(arr[i].vdate.substring(0, 4));
				}
				if (arr[i].pdate != null && arr[i].pdate.length != 0) {
					yearData.push(arr[i].pdate.substring(0, 4));
				}
				if (arr[i].odate != null && arr[i].odate.length != 0) {
					yearData.push(arr[i].odate.substring(0, 4));
				}
				if (arr[i].sdate != null && arr[i].sdate.length != 0) {
					yearData.push(arr[i].sdate.substring(0, 4));
				}
				nameData.push(arr[i].name);
				pointBData.push([ arr[i].bdate, arr[i].name, arr[i].BF ]);
				pointLData.push([ arr[i].ldate, arr[i].name, arr[i].LF ]);
				pointVData.push([ arr[i].vdate, arr[i].name, arr[i].VFF ]);
				pointPData.push([ arr[i].pdate, arr[i].name, arr[i].PVS ]);
				pointOData.push([ arr[i].odate, arr[i].name, arr[i].OS ]);
				pointSData.push([ arr[i].sdate, arr[i].name, arr[i].SOP ]);
			}
			//去重數據
			for (var i = 0; i < yearData.length; i++) {
				if (yData.indexOf(yearData[i]) === -1) {
					yData.push(yearData[i]);
				}
			}
			for (var i = 0; i < yData.length; i++) {
				var year;
				for (var j = i; j < yData.length; j++) {
					if(parseInt(yData[i])>parseInt(yData[j])){
						year=yData[i];
						yData[i]=yData[j];
						yData[j]=year;
					}
				}
			}
			for (var i = 0; i < yData.length; i++) {
				for (var j = 1; j <= 12; j++) {
					if (j < 10) {
						monthData.push(yData[i] + "-" + "0" + j);
					} else {
						monthData.push(yData[i] + "-" + j);
					}
				}
			}
			//折綫配置項數據的數組
			var series = [];
			//先存儲散點坐標
			series.push({
				name : 'BF',
				type : 'scatter',
				symbol : "triangle",
				symbolSize : 13,
				xAxisIndex : 1,
				yAxisIndex : 1,
				label : {
					show : true,
					position : 'bottom',
					formatter : 'BF \n{@[2]}'
				},
				data : pointBData
			},{
				name : 'LF',
				type : 'scatter',
				symbol : "triangle",
				symbolSize : 14,
				xAxisIndex : 1,
				yAxisIndex : 1,
				label : {
					show : true,
					position : 'bottom',
					formatter : 'LF \n{@[2]}'
				},
				data : pointLData
			},{
				name : 'VFF',
				type : 'scatter',
				symbol : "triangle",
				symbolSize : 15,
				xAxisIndex : 1,
				yAxisIndex : 1,
				label : {
					show : true,
					position : 'bottom',
					formatter : 'VFF \n{@[2]}'
				},
				data : pointVData
			}, {
				name : 'PVS',
				type : 'scatter',
				symbol : "triangle",
				symbolSize : 16,
				xAxisIndex : 1,
				yAxisIndex : 1,
				label : {
					show : true,
					position : 'bottom',
					formatter : 'PVS \n{@[2]}'
				},
				data : pointPData
			}, {
				name : 'OS',
				type : 'scatter',
				symbol : "triangle",
				symbolSize : 16,
				xAxisIndex : 1,
				yAxisIndex : 1,
				label : {
					show : true,
					position : 'bottom',
					formatter : 'OS \n{@[2]}'
				},
				data : pointOData
			}, {
				name : 'SOP',
				type : 'scatter',
				symbol : "triangle",
				symbolSize : 16,
				xAxisIndex : 1,
				yAxisIndex : 1,
				label : {
					show : true,
					position : 'bottom',
					formatter : 'SOP \n{@[2]}'
				},
				data : pointSData
			});
			for (var i = 0; i < arr.length; i++) {
				series.push({
					type : 'line',
					xAxisIndex : 1,
					yAxisIndex : 1,
					lineStyle : {
						width : 12,
						type : 'solid'
					},
					tooltip : {
						show : false,
					},
					data : [ [ arr[i].bdate, arr[i].name ],
								[ arr[i].ldate, arr[i].name ],
								[ arr[i].vdate, arr[i].name ],
								[ arr[i].pdate, arr[i].name ],
							    [ arr[i].odate, arr[i].name ],
							    [ arr[i].sdate, arr[i].name ] ]
				});
			}
			//准备dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('main'));
			//指定图表的配置项和数据
			var option = {
				title : {
					text : 'CAE模型结构图'
				},
				tooltip : {
					trigger : 'item',
					 axisPointer : {
						type:'cross'
					}, 
					show : true,
				},
				legend : {
					icon : "triangle",
					data : [ 'BF','LF','VFF','PVS', 'OS', 'SOP' ]
				},
				grid : [ {
					left : 150,
					right : 60,
					height : '5%',
					top:'10',
				}, {
					left : 150,
					right : 60,
					top : '18%',
					height : '70%',
					containLabel : false
				} ],
				xAxis : [ {
					//name:'年份'，
					type : "category",
					name : 'year',
					nameTextStyle:{
						verticalAlign:'middle',
						lineHeight:30,
						width:20
					},
					axisLabel : {
						margin : 5,
						fontSize : 15,
						height : 30
					},
					data : yData
				}, {
					type : "category",
					name : 'month',
					gridIndex : 1,
					position : "top",
					logBase : 1,
					axisLabel : {
						interval : '0',
						rotate : 30
					},
					axisTick : {
						interval : 0,
					},
					data : monthData
				} ],
				yAxis : [ {
					axisLine : {
						show : false
					}
				}, {
					gridIndex : 1,
					axisLabel : {
						interval : '0',
						rotate : 30,
						margin : 10
					},
					inverse : true, //反轉
					logBase : 1,
					axisLabel : {
						show : true,
						margin : 10
					},
					axisLine : {
						symbolSize : [ 10, 15 ]
					},
					axisTick : {
						opacity : 100,
						interval : 0,
						length : 5
					},
					data : nameData
				} ],
				//用鼠標進行數據縮放
				/* dataZoom:[{
					type:'inside',
					xAxisIndex:[0,1],
					yAxisIndex:[1],
					
				}], */
				series : series
			};
			//将配置项和数据放在实例中
			myChart.setOption(option);
			//跳转代码
			myChart.on('click', function (params) { 
			console.log(params);
			//window.open('https://www.baidu.com/s?wd=' + encodeURIComponent(params.seriesName));
			window.location.href="<%=basePath%>tb_node/tb_users_init";
			});
		}
		window.onload=showChart;
		
	</script>

</body>
</html>