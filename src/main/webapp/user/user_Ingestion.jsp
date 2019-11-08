<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 섭취 정보</title>
<c:set var="totalCalory" value="0"/>
<c:set var="totalCarbo" value="0"/>
<c:set var="totalProtein" value="0"/>
<c:set var="totalFat" value="0"/>
<c:forEach items="${list}" var="item" varStatus="i">
	<c:forEach items="${info}" var="information" varStatus="i">
		<c:if test="${item.code==information.code}">
			<c:set var="totalCalory" value="${totalCalory+information.quantity*item.calory}"/>
			<c:set var="totalCarbo" value="${totalCarbo+information.quantity*item.carbo}"/>
			<c:set var="totalProtein" value="${totalProtein+information.quantity*item.protein}"/>
			<c:set var="totalFat" value="${totalFat+information.quantity*item.fat}"/>
		</c:if>
	</c:forEach>
</c:forEach>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
		integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
	
	<style>
		.table td {min-width : 100px; word-break: break-all; }
	</style>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<script src="https://code.highcharts.com/modules/export-data.js"></script>
	<script type="text/javascript">
		/* 
		탄수화물 55-65%
		단백질 7-20%
		지방 15-30%
		*/
		var userIngestion = [];
		var totalCarbo;
		var totalProtein;
		var totalFat;
		var totalCalory;
		$(function (){
			refreshPage();
			graphWrite();
			alert(totalCarbo+" "+totalProtein);
			
			$(document).on("click", "#deleteCart", deleteCartStorage);
		})
		function deleteCartStorage(){
			var y=confirm($(this).val() +"을 삭제하시겠습니까?");
			if(y){
				localStorage.removeItem($(this).val());
				refreshPage();
			}
		}
		function graphWrite(){
			Highcharts.chart('graph', {
			    chart: {
			        type: 'bar'
			    },
			    title: {
			        text: '영양 분석'
			    },
			    xAxis: {
			        categories: ['기준치', '현재량']
			    },
			    yAxis: {
			        min: 0,
			        title: {
			            text: '3대 영양소'
			        }
			    },
			    legend: {
			        reversed: true
			    },
			    plotOptions: {
			        series: {
			            stacking: 'normal'
			        }
			    },
			    series: [{
			    	name: '지방',
			        data: [totalFat]
			    }, {
			        name: '단백질',
			        data: [totalProtein]
			    }, {
				    name: '탄수화물',
			        data: [totalCarbo]
			    }]
			});
		}
		function refreshPage(){
			totalCarbo=0;
			totalProtein=0;
			totalFat=0;
			totalCalory=0;
			var html ='';
			var totalPrice =0;
			userIngestion = [];
			for(var key in localStorage){
				if(key=='length') break;
				var data =  localStorage.getItem(key).split(",");
				userIngestion.push({
					code:key,
					name:data[0],
					maker:data[1],
					img:data[2],
					allergy:data[3],
					supportpereat:data[4],
					calory:data[5],
					carbo:data[6],
					protein:data[7],
					fat:data[8],
					sugar:data[9],
					natrium:data[10],
					chole:data[11],
					fattyacid:data[12],
					transfat:data[13],
					quantity:data[14]
				});
				totalCalory+=Number(data[5]);
				totalCarbo+=Number(data[6]);
				totalProtein+=Number(data[7]);
				totalFat+=Number(data[8]);
			}
			$("#jjimList").empty();
			var html = '';
			for(var i = 0; i < userIngestion.length;i++){
				html+="<tr>";
				html+='<td><img src="${pageContext.request.contextPath}/'+userIngestion[i].img+'" style="width: 150px; height: 150px"/></td>';
				html+="<td>"+userIngestion[i].code+"</td>";
				html+="<td>"+userIngestion[i].name+"</td>";
				html+="<td>"+userIngestion[i].maker+"</td>";
				html+="<td><button   id='deleteCart' value='"+userIngestion[i].code+"'>삭제</button><td>";
				html+="</tr>";
			}
			$("#jjimList").append(html);
			html ='';
		}
		/* $(function() {
			var totalCalory = <c:out value="${totalCalory}"></c:out>; 
			var totalCarbo = <c:out value="${totalCarbo}"></c:out>;
			var totalProtein = <c:out value="${totalProtein}"></c:out> ;
			var totalFat = <c:out value="${totalFat}"></c:out>;
			
			$("#ingestionInfo").append("<p> 총 칼로리 : "+totalCalory+" kcal</p><p> 총 탄수화물 : "+totalCarbo+"g </p><p> 총 단백질 : "+totalProtein+"g</p><p> 총 지방 : "+totalFat+"g</p>");
			
			var CPF = totalCarbo + totalProtein + totalFat;
			var carboRate = totalCarbo/CPF*100;
			var proteinRate = totalProtein/CPF*100;
			var fatRate = totalFat/CPF*100;
			
			Highcharts.chart('graph', {
			    chart: {
			        type: 'bar'
			    },
			    title: {
			        text: '영양 분석'
			    },
			    xAxis: {
			        categories: ['기준치', '현재량']
			    },
			    yAxis: {
			        min: 0,
			        title: {
			            text: '3대 영양소'
			        }
			    },
			    legend: {
			        reversed: true
			    },
			    plotOptions: {
			        series: {
			            stacking: 'normal'
			        }
			    },
			    series: [{
			    	name: '지방',
			        data: [25, fatRate]
			    }, {
			        name: '단백질',
			        data: [15, proteinRate]
			    }, {
				    name: '탄수화물',
			        data: [60, carboRate]
			    }]
			});
			
			$("#metabolism").click(function(){
				var sex = $('input[name="sex"]:checked').val();
				var weight = $('#weight').val();
				var result = 0;
				if(sex=="male"){
					result = weight*1.0*24;
				}else{
					result = weight*0.9*24;
				}
				var warm = "";
				var over = "";
				if(result > totalCalory){
					warm="<p>안전 합니다.</p>";
				}else{
					warm='<p style="color:red;">칼로리'+(-(result-totalCalory))+'kcal 초과!!</p>';
					over='<p>달리기 :'+1000*(-(result-totalCalory))/5/3.5/weight/10/60+'시간을 달려야 됩니다!</p>';
				}
				$("#metabolismInfo").html("<p>"+result+"kcal</p><p>"+warm+"</p>");
				$("#training").html(over);
			});
		});
		function forViewPage(code) {
			//alert(code);
			var path ="FoodServlet?command=view&code="+code;
			//alert(path);
			location.href=path;
		} */
	</script>
</head>
<body>
<c:import url="${pageContext.request.contextPath}/header.jsp"></c:import>
<section>
	<article class="container">
	<table id="jjimList" class="table table-hover">
	
	</table>
	
	</article>
	<article class="container">
		<div id="graph">
		</div>
	</article>
</section>


<c:import url="${pageContext.request.contextPath}/footer.jsp"></c:import>
</body>
</html>