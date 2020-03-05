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
<style type="text/css">
table  td,th {
	width: 150px;
	text-align: center;
}
table tr{
	height: 50px;
	text-align: center;
}
table.imagetable {
    font-family: verdana,arial,sans-serif;
    font-size:15px;
    color:#333333;
    border-width: 1px;
    border-color: #999999;
    border-collapse: collapse;
}
table.imagetable th {
    background:#b5cfd2 url('cell-blue.jpg');
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #999999;
}
table.imagetable td {
    background:#dcddc0 url('cell-grey.jpg');
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #999999;
}
</style>
</head>
<body>
	<div>
		<div style="margin-top: 20px;">
			<span style="font-size: 40px; font-style: oblique; font-family: cursive; margin-left: 500px;">Lamando NF</span>
		</div>
		<!-- 图 -->
		<div id="main" style="height: 200px;"></div>
		<!-- 工时图 -->
		<div id="tasktime" style="height: 250px;"></div>
		<!-- 表 -->
		<div style="height:800px;">
			<div>
				<table border="1" class="imagetable">
				<caption style="text-align: center;font-size: 20px; font-style: oblique; font-family: cursive;">Lamando NF各阶段详情表</caption>
					<thead>
						<tr>
							<th></th>
							<th>AkusticSchwingKomfort</th>
							<th>Bodenfreigang</th>
							<th>Wassermanagement</th>
							<th>Karoseriedichtigkeit</th>
							<th>IPS</th>
							<th>Gewicht</th>
							<th style="text-align: center;">Energiemanagement</th>
						</tr>
					</thead>
					<tbody>
						<tr style="height: 150px;">
							<td>状态</td>
							<td><img  src="<%=basePath%>css/red.jpg"></td>
							<td><img  src="<%=basePath%>css/red.jpg"></td>
							<td><img  src="<%=basePath%>css/red.jpg"></td>
							<td><img  src="<%=basePath%>css/red.jpg"></td>
							<td><img  src="<%=basePath%>css/red.jpg"></td>
							<td><img  src="<%=basePath%>css/red.jpg"></td>
							<td style="text-align: center;"><img src="<%=basePath%>css/red.jpg"></td>
						</tr>
						<tr>
							<td>VW(BST)</td>
							<td>无</td>
							<td>无</td>
							<td><a href="<%=basePath%>tb_content/openfileonbrower">1_灵活工作方案（试行稿）</a></td>
							<td><a href="<%=basePath%>tb_content/openfileonbrower">1_灵活工作方案（试行稿）</a></td>
							<td><a href="<%=basePath%>tb_content/openfileonbrower">1_灵活工作方案（试行稿）</a></td>
							<td><a href="<%=basePath%>tb_content/openfileonbrower">1_灵活工作方案（试行稿）</a></td>
							<td style="text-align: center;"><a href="<%=basePath%>tb_content/openfileonbrower">1_灵活工作方案（试行稿）</a></td>
						</tr>
						<tr>
							<td>SVW</td>
							<td>无</td>
							<td>无</td>
							<td>计划</td>
							<td>计划</td>
							<td>计划</td>
							<td>计划</td>
							<td style="text-align: center;">计划</td>
						</tr>
						<tr>
							<td>工时</td>
							<td>无</td>
							<td>无</td>
							<td>12</td>
							<td>15</td>
							<td>18</td>
							<td>25</td>
							<td style="text-align: center;">20</td>
						</tr>
						<tr>
							<td>负责人</td>
							<td>无</td>
							<td>无</td>
							<td>钱雨</td>
							<td>钱雨</td>
							<td>钱雨</td>
							<td>钱雨</td>
							<td style="text-align: center;">钱雨</td>
						</tr>
						<tr>
							<td>参与人员</td>
							<td>无</td>
							<td>无</td>
							<td>钱雨，余鸿成</td>
							<td>钱雨，柳伟</td>
							<td>钱雨，朴玉华</td>
							<td>钱雨，孙涛</td>
							<td style="text-align: center;">钱雨，余鸿成，朴玉华</td>
						</tr>
						<tr>
							<td>报告</td>
							<td colspan="8" style="text-align: center;"><a href="<%=basePath%>tb_content/openfileonbrower">1_灵活工作方案（试行稿）V1_EPGA20200209v2</a></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var arr =[{"sdate":"2021-10","bdate":"2020-01","BF":"KW05/20","OS":"KW29/21","pdate":"2021-01","vdate":"2020-11","PVS":"KW02/21","SOP":"KW42/21","odate":"2021-07","VFF":"KW46/20","name":"Lamando NF","LF":"KW31/20","ldate":"2020-07"}];
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
				/* title : {
					text : 'Lamando NF 节点'
				}, */
				tooltip : {
					trigger : 'item',
					 axisPointer : {
						type:'cross'
					}, 
					show : true,
				},
				/* legend : {
					icon : "triangle",
					data : [ 'BF','LF','VFF','PVS', 'OS', 'SOP' ]
				}, */
				grid : [ {
					left : 100,
					right : 60,
					height : '5%',
					top:'10',
				}, {
					left : 100,
					right : 60,
					top : '50%',
					height : '20%',
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
		window.onload = showChart;

		//工时图表
		var tasktime = [ {
			"rhour" : 6,
			"taskname" : "Lamando NF",
			"tname" : "Wassermanagement"
		}, {
			"rhour" : 8,
			"taskname" : "Lamando NF",
			"tname" : "Karoseriedichtigkeit"
		}, {
			"rhour" : 10,
			"taskname" : "Lamando NF",
			"tname" : "IPS"
		}, {
			"rhour" : 16,
			"taskname" : "Lamando NF",
			"tname" : "Gewicht"
		},{
			"rhour" : 20,
			"taskname" : "Lamando NF",
			"tname" : "Energiemanagement"
		}];
		var taskhour=[{"rhour":6,"tname":"preprocess"},{"rhour":8,"tname":"calcuv1"},{"rhour":10,"tname":"calcuv2"},{"rhour":16,"tname":"report"}];
		console.log(tasktime);
		var pname = tasktime[0].taskname;
		$('.h').html(pname + "实际工时");
		//任务名称数组
		var taskname = [];
		//实际工时
		var actualtime = [];
		//工时
		var time = [];
		for (var i = 0; i < tasktime.length; i++) {
			taskname.push(tasktime[i].tname);
			time.push(tasktime[i].rhour);
		}
		for (var i = 0; i < taskhour.length; i++) {
			actualtime.push({
				value : taskhour[i].rhour,
				name : taskhour[i].tname
			});
		}
		
		//前处理
		var preprocess =[{name:"陈涛",rhour:6},{name:"孙涛",rhour:12},{name:"余鸿成",rhour:10},{name:"谌壮",rhour:6}];
		//人员数组
		var pData=[];
		//任务工时
		var tasktimeData=[];
		//颜色数组
		var colorData=[];
		var cData=[];
		for (var i = 0; i < preprocess.length; i++) {
			pData.push(preprocess[i].name);
			tasktimeData.push(preprocess[i].rhour);
			var r = Math.floor(Math.random()*256);
			var g = Math.floor(Math.random()*256);
			var b = Math.floor(Math.random()*256);
			var color = '#'+r.toString(16)+g.toString(16)+b.toString(16);
			colorData.push(color);
			cData.push(0);
		}
		
		//准备dom，初始化echarts实例
		var myChart1 = echarts.init(document.getElementById('tasktime'));
		//指定图表的配置项和数据
		option1 = {
			title : [ {
				text : '1、' + pname + '各任务工时(数值)',
				left : '18%',
				textAlign : 'center'
			}, {
				text : '2、' + pname + '各任务工时(百分比)',
				left : '50%',
				textAlign : 'center'
			},{
		        subtext: '查看详情',
		        sublink:'<%=basePath%>tb_tasktime/tb_tasktime_totaskspiehour',
		        subtarget:'self',
		        left: '50%',
		        top: '82%',
		        textAlign: 'center',
		        subtextStyle:{
		        	fontSize:15
		        }
		    }, {
				text : '3、' +  '前处理各人员工时',
				left : '75%',
				textAlign : 'center'
			},{
				subtext: '查看详情',
		        sublink:'<%=basePath%>tb_tasktime/tb_tasktime_topreprocesstaskhour',
		        subtarget:'self',
		        left: '80%',
		        top: '82%',
		        textAlign: 'center',
		        subtextStyle:{
		        	fontSize:15
		        }
		    }],
			tooltip : {
				trigger : 'item',
				formatter : function(params) {
					if(params.componentSubType=="pie"){
						return params.name+" : "+params.value+" ("+params.percent+"%)" ;
					}else{
						return params.name+" : "+params.data ;
					}
				}
			},
			grid : [ {
				left : '12%',
				right : 'auto',
				width:	"25%",
				top : '25%',
				height : '50%',
				containLabel : false
			} ,{
				left : '70%',
				right : 'auto',
				width:	"25%",
				top : '25%',
				height : '50%',
				containLabel : false
			}],
			xAxis : [ {
				type : 'value',
				show : false
			} , {
				type : 'category',
				boundaryGap : true,
				gridIndex : 1,
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
				data : pData
			}],
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
			},{
				type : 'value',
				show : false,
				gridIndex : 1,
			} ],
			series : [ {
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
			}, {
				name : '项目A实际工时',
				type : 'pie',
				radius : [ 0, '50%' ],
				center : [ '50%', '50%' ],
				data : actualtime
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
				data : tasktimeData
			}, {
				type : 'line',
				xAxisIndex : 1,
				yAxisIndex : 1,
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
		myChart1.setOption(option1);
	</script>

</body>
</html>