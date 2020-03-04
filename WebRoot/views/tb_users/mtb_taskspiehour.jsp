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
	<h2>各任务工时</h2>
	<div id="main" style="width: 100%; height: 600px;"></div>
	<script type="text/javascript">
		var taskshour =[[{"rhour" : 6,"tname" : "preprocess"}, {"rhour" : 8,"tname" : "calcuv1"}, {"rhour" : 10,"tname" : "calcuv2"}, {"rhour" : 16,"tname" : "report"},{"totalhour":60,"taskname":"Wassermanagement"}],
						[{"rhour" : 7,"tname" : "preprocess"}, {"rhour" : 6,"tname" : "calcuv1"}, {"rhour" : 8,"tname" : "calcuv2"}, {"rhour" : 15,"tname" : "report"},{"totalhour":54,"taskname":"Karoseriedichtigkeit"}],
						[{"rhour" : 5,"tname" : "preprocess"}, {"rhour" : 10,"tname" : "calcuv1"}, {"rhour" : 12,"tname" : "calcuv2"}, {"rhour" : 18,"tname" : "report"},{"totalhour":67,"taskname":"IPS"}],
						[{"rhour" : 7,"tname" : "preprocess"}, {"rhour" : 7,"tname" : "calcuv1"}, {"rhour" : 10,"tname" : "calcuv2"}, {"rhour" : 16,"tname" : "report"},{"totalhour":61,"taskname":"Gewicht"}],
						[{"rhour" : 5,"tname" : "preprocess"}, {"rhour" : 10,"tname" : "calcuv1"}, {"rhour" : 12,"tname" : "calcuv2"}, {"rhour" : 18,"tname" : "report"},{"totalhour":67,"taskname":"Energiemanagement"}],
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
		 for (var i = 0; i <taskshour.length; i++) {
			 if(taskshour[i][taskshour[i].length-1].taskname=="Wassermanagement"){
				 for (var j = 0; j < taskshour[i].length-1; j++) {
					wData.push({
						value : taskshour[i][j].rhour,
						name : taskshour[i][j].tname
					});
				 }
			 }else if(taskshour[i][taskshour[i].length-1].taskname=="Karoseriedichtigkeit"){
				 for (var j = 0; j < taskshour[i].length-1; j++) {
						kData.push({
							value : taskshour[i][j].rhour,
							name : taskshour[i][j].tname
						});
				 }
			 }else  if(taskshour[i][taskshour[i].length-1].taskname=="IPS"){
				 for (var j = 0; j < taskshour[i].length-1; j++) {
						iData.push({
							value : taskshour[i][j].rhour,
							name : taskshour[i][j].tname
						});
				 }
			  }else if(taskshour[i][taskshour[i].length-1].taskname=="Gewicht"){
				  for (var j = 0; j < taskshour[i].length-1; j++) {
						gData.push({
							value : taskshour[i][j].rhour,
							name : taskshour[i][j].tname
						});
				 }
			  }else if(taskshour[i][taskshour[i].length-1].taskname=="Energiemanagement"){
				  for (var j = 0; j < taskshour[i].length-1; j++) {
						eData.push({
							value : taskshour[i][j].rhour,
							name : taskshour[i][j].tname
						});
				 }
			  }
		} 
		
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
			series :[{
				name : '项目A实际工时',
				type : 'pie',
				radius : [ 0, '20%' ],
				center : [ '15%', '30%' ],
				data : wData
			},{
				name : '项目A实际工时',
				type : 'pie',
				radius : [ 0, '20%' ],
				center : [ '45%', '30%' ],
				data : kData
			},{
				name : '项目A实际工时',
				type : 'pie',
				radius : [ 0, '20%' ],
				center : [ '75%', '30%' ],
				data : iData
			},{
				name : '项目A实际工时',
				type : 'pie',
				radius : [ 0, '20%' ],
				center : [ '25%', '80%' ],
				data : gData
			},{
				name : '项目A实际工时',
				type : 'pie',
				radius : [ 0, '20%' ],
				center : [ '65%', '80%' ],
				data : eData
			}]
		};
		//将配置项和数据放在实例中
		myChart.setOption(option);
	</script>
</body>
</html>