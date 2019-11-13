<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Map<String,List<Integer>> monthMap = new HashMap<String, List<Integer>>();
	String month_day[] = (String[])request.getAttribute("month_day");
	monthMap = (Map<String,List<Integer>>)request.getAttribute("monthMap");
	List<Integer> monthlyDayProfit = new ArrayList<>();
	List<Integer> monthlyDaySpend = new ArrayList<>();
	List<Integer> mdpMinusmds = new ArrayList<>();
	monthlyDayProfit = monthMap.get("monthlyDayProfit");
	monthlyDaySpend = monthMap.get("monthlyDaySpend");
	mdpMinusmds = monthMap.get("mdpMinusmds");
	int thisMonth = Integer.parseInt(month_day[0].substring(0, 2));
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
		<button type="button" class="btn btn-primary">연간 통계</button>&nbsp;
		<button type="button" class="btn btn-primary"  disabled="disabled">월간 통계</button>&nbsp;
		<!-- <button type="button" class="btn btn-primary">일간 통계</button> -->
	</div>
	<div>
		<select class="form-control">
			<%
			for(int i=1; i<=12; i++){
				if(i==thisMonth){
					%>
					<option selected="selected" value="<%=i%>"><%=i %>월</option>
					<%
				}
				else{
					%>
					<option value="<%=i%>"><%=i %>월</option>
					<%
				}
			}
			%>
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
                <div class="card-body" id="monthMoneyChart" style="height: 650px">
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
Highcharts.chart('monthMoneyChart', {

    title: {
        text:null
    },
    
    xAxis: {
        categories: [
        	<%
        	for(int i=0 ; i<month_day.length ;i++){
        		if(i== month_day.length){
        			%>'<%=month_day[i].substring(3,5)%>일'<%
        		}
        		else{
        			%>'<%=month_day[i].substring(3,5)%>일',<%
        		}
        	}
        	%>
        ]
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
        	for(int i=0 ; i<monthlyDayProfit.size(); i++){
        		if(i==monthlyDayProfit.size()){
        			%><%=monthlyDayProfit.get(i)%><%
        		}
        		else{
        			%><%=monthlyDayProfit.get(i)%>,<%
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
        	for(int i=0 ; i<mdpMinusmds.size(); i++){
        		if(i==mdpMinusmds.size()){
        			%><%=mdpMinusmds.get(i)%><%
        		}
        		else{
        			%><%=mdpMinusmds.get(i)%>,<%
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
        	for(int i=0 ; i<monthlyDaySpend.size(); i++){
        		if(i==monthlyDaySpend.size()){
        			%><%=monthlyDaySpend.get(i)%><%
        		}
        		else{
        			%><%=monthlyDaySpend.get(i)%>,<%
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
	
	if($(this).html() == '연간 통계'){

		location.href = "admin_chart_money.do";
	}

});
$("select").change(function() {
	/* alert($(this).val()); */
	var month = $(this).val();
	if(month<10) month = "0"+month;
	/* alert(month); */
	location.href = "admin_chart_monthly_money.do?month="+month;
});
</script>  
</body>
</html>