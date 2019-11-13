<%@page import="com.boot.finalpro.game.model.GameDTO"%>
<%@page import="com.boot.finalpro.admin.util.SportsScoreDto"%>
<%@page import="com.sun.mail.imap.protocol.ListInfo"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	List<GameDTO> monthlyStadiumCount = new ArrayList<>();
	monthlyStadiumCount = (List<GameDTO>)request.getAttribute("monthlyStadiumCount");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<style type="text/css">
.col-xl-8{
	    flex: 0 0 100%;
	    max-width: 100%;
}
</style>
</head>
<body>
<div style="display: flex; margin-top: 1%; align-items: center; justify-content: space-between; padding:0 1.25em 0 1.25em">
	<div>
		<button type="button" class="btn btn-primary" disabled="disabled">월간 통계</button>&nbsp;
		<button type="button" class="btn btn-primary">지역 통계</button>
	</div>
	<div>
		<select class="form-control">
			<c:forEach var="i" begin="1" end="12">
				<c:if test="${selectMonth eq i }">
					<option selected="selected" value="${i }">${i }월</option>
				</c:if>
					<option value="${i }">${i }월</option>			
			</c:forEach>
		</select>
	</div>	
</div>	
  <div class="card-body">
    <div class="table-responsive">
		<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">		
			<div class="row">
            <div class="col-xl-8 col-lg-7">
              <div class="card shadow mb-4">
                <!-- Card Body -->
                <div class="card-body" id="stadiumCount" style="height: 650px">
                </div>
              </div>
            </div>				
			</div>
		</div>
	</div>
  </div>
<script type="text/javascript">
Highcharts.chart('stadiumCount', {
    chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
    },
    title: {
        text: null
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}건</b>'
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: false
            },
            showInLegend: true
        }
    },
    series: [{
        name: '이용 건수',
        colorByPoint: true,
        data:[
        	<%
        	for(int i=0; i<monthlyStadiumCount.size(); i++){
        		if(i == 0){
        			%>{name:<%=monthlyStadiumCount.get(i).getName_stadium()%>,y:<%=monthlyStadiumCount.get(i).getRead_count()%>,sliced: true,selected: true},<%
        		}
        		else if(i == monthlyStadiumCount.size()){
        			%>{name:<%=monthlyStadiumCount.get(i).getName_stadium()%>,y:<%=monthlyStadiumCount.get(i).getRead_count()%>}<%
        		}
        		else{
        			%>{name:<%=monthlyStadiumCount.get(i).getName_stadium()%>,y:<%=monthlyStadiumCount.get(i).getRead_count()%>},<%
        		}
        	}
        	%>
        ] 

    }]
});
$(".btn-primary").click(function() {	
	if($(this).html() == '지역 통계'){
		location.href = "admin_chart_location.do?location="+"잠실";
	}
});

$("select").change(function() {
	var month = $(this).val();
	if(month<10) month = "0"+month;
	location.href = "admin_chart_stadiumCount.do?month="+month;
});
</script>  
</body>
</html>