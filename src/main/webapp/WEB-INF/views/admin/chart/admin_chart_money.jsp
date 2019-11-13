<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<Integer> yearProfit = new ArrayList<>();
	List<Integer> yearSpend = new ArrayList<>();
	List<Integer> yPminusyS = new ArrayList<>();
	yearProfit = (List<Integer>)request.getAttribute("yearProfit");
	yearSpend = (List<Integer>)request.getAttribute("yearSpend");
	yPminusyS = (List<Integer>)request.getAttribute("yPminusyS");
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
		<button type="button" class="btn btn-primary"disabled="disabled">연간 통계</button>&nbsp;
		<button type="button" class="btn btn-primary">월간 통계</button>&nbsp;
		<!-- <button type="button" class="btn btn-primary">일간 통계</button> -->
	</div>
</div>	
  <div class="card-body">
    <div class="table-responsive">
		<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">		
			<div class="row">
            <div class="col-xl-8 col-lg-7">
              <div class="card shadow mb-4">
                <!-- Card Body -->
                <div class="card-body" id="yearMoneyChart" style="height: 650px">
                </div>
              </div>
            </div>				
			</div>
		</div>
	</div>
  </div>
<script type="text/javascript">
var datePick = new Date();
var mm = datePick.getMonth()+1;
if(mm.length<2){
	mm = "0"+mm;
}
Highcharts.chart('yearMoneyChart', {

    title: {
        text: null
    },
    
    xAxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    },    
    yAxis: {
        title: {
            text: 'Money'
        },
	    labels: {
	        formatter: function () {
	            return this.value + '원';
	        }
	    }    
    },
    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle'
    },

    series: [{
        name: '총 수입',
        color: 'blue',
        data:[
        	<%
        	for(int i=0 ; i<yearProfit.size(); i++){
        		if(i==11){
        			%><%=yearProfit.get(i)%><%
        		}
        		else{
        			%><%=yearProfit.get(i)%>,<%
        		}
        	}
        	%>
        	]
    },
    {
        name: '수입-지출',
        color: 'black',
        data:[
        	<%
        	for(int i=0 ; i<yPminusyS.size(); i++){
        		if(i==11){
        			%><%=yPminusyS.get(i)%><%
        		}
        		else{
        			%><%=yPminusyS.get(i)%>,<%
        		}
        	}
        	%>
        	]
    },
    {
        name: '총 지출',
        color: 'red',
        data: [
        	<%
        	for(int i=0 ; i<yearSpend.size(); i++){
        		if(i==11){
        			%><%=yearSpend.get(i)%><%
        		}
        		else{
        			%><%=yearSpend.get(i)%>,<%
        		}
        	}
        	%>
        	]
    }],

    responsive: {
        rules: [{
            condition: {
                maxWidth: 500
            },
            chartOptions: {
                legend: {
                    layout: 'horizontal',
                    align: 'center',
                    verticalAlign: 'bottom'
                }
            }
        }]
    }

});

$(".btn-primary").click(function() {
	var dt = new Date();
	var month = dt.getMonth()+1;
	var day = dt.getDate();
	if(month<10) month = "0"+month;
	if(day<10) day = "0"+day;
	
	/* alert($(this).html()); */
	if($(this).html() == '월간 통계'){
		/* alert("월"); */
		location.href = "admin_chart_monthly_money.do?month="+month;
	}
/* 	else if($(this).html() == '일간 통계'){
		alert("일"); 
		location.href = "admin_chart_daily_money.do?day="+day;
	} */
});
</script>  
</body>
</html>