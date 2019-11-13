<%@page import="com.sun.mail.imap.protocol.ListInfo"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

Map<String,List<Integer>> monthlyFavoriteSports = new HashMap<>();
monthlyFavoriteSports = (Map<String,List<Integer>>)request.getAttribute("monthlyFavoriteSports");
List<Integer> soccer = new ArrayList<>();
List<Integer> basketBall = new ArrayList<>();
List<Integer> baseBall = new ArrayList<>();
List<Integer> pingpong = new ArrayList<>();
List<Integer> badminton = new ArrayList<>();
List<Integer> Average = new ArrayList<>();
soccer = monthlyFavoriteSports.get("축구");
basketBall = monthlyFavoriteSports.get("농구");
baseBall = monthlyFavoriteSports.get("야구");
pingpong = monthlyFavoriteSports.get("탁구");
badminton = monthlyFavoriteSports.get("배드민턴");
int totalSoccer = 0; int totalBasketBall = 0; int totalBaseBall = 0;
int totalPingPong = 0; int totalBadminton = 0;
for(int i=0; i < soccer.size(); i++){
	Average.add((soccer.get(i)+basketBall.get(i)+baseBall.get(i)+pingpong.get(i)+badminton.get(i))/5);
	totalSoccer = totalSoccer + soccer.get(i);totalBasketBall = totalBasketBall + basketBall.get(i);
	totalBaseBall = totalBaseBall + baseBall.get(i);totalPingPong = totalPingPong + pingpong.get(i);
	totalBadminton = totalBadminton + badminton.get(i);
}
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
		<button type="button" class="btn btn-primary"disabled="disabled">선호 종목</button>&nbsp;
		<button type="button" class="btn btn-primary">종목 점수</button>&nbsp;
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
                <div class="card-body" id="monthlyFavoriteChart" style="height: 650px">
                </div>
              </div>
            </div>				
			</div>
		</div>
	</div>
  </div>
<script type="text/javascript">

Highcharts.chart('monthlyFavoriteChart', {
    title: {
        text: null
    },
    xAxis: {
        categories: ['1월', '2월', '3월', '4월', '5월','6월','7월','8월','9월','10월','11월','12월']
    },
    yAxis: {
        title: {
            text: '이용자 수'
        },
	    labels: {
	        formatter: function () {
	            return this.value + '명';
	        }
	    }    
    },
    labels: {
        items: [{
            html: '연간 총 이용자',
            style: {
                left: '77.5px',
                top: '5px',
                color: ( // theme
                    Highcharts.defaultOptions.title.style &&
                    Highcharts.defaultOptions.title.style.color
                ) || 'black'
            }
        }]
    },
    series: [{
        type: 'column',
        name: '축구',
        data: [
        	<%
        	for(int i=0; i<soccer.size(); i++){
        		if(i == soccer.size())%><%=soccer.get(i)%><%
        		else %><%=soccer.get(i)%>,<%
        	}
        	%>
        ]
    }, {
        type: 'column',
        name: '농구',
        data: [
        	<%
        	for(int i=0; i<basketBall.size(); i++){
        		if(i == basketBall.size())%><%=basketBall.get(i)%><%
        		else %><%=basketBall.get(i)%>,<%
        	}
        	%>
        ]
    }, {
        type: 'column',
        name: '야구',
        data: [
        	<%
        	for(int i=0; i<baseBall.size(); i++){
        		if(i == baseBall.size())%><%=baseBall.get(i)%><%
        		else %><%=baseBall.get(i)%>,<%
        	}
        	%>
        ]
    }, {
        type: 'column',
        name: '탁구',
        data: [
        	<%
        	for(int i=0; i<pingpong.size(); i++){
        		if(i == pingpong.size())%><%=pingpong.get(i)%><%
        		else %><%=pingpong.get(i)%>,<%
        	}
        	%>
        ]
    },{
        type: 'column',
        name: '배드민턴',
        data: [
        	<%
        	for(int i=0; i<badminton.size(); i++){
        		if(i == badminton.size())%><%=badminton.get(i)%><%
        		else %><%=badminton.get(i)%>,<%
        	}
        	%>
        ]
    }, {
        type: 'spline',
        name: '평균',
        data: [
        	<%
        	for(int i=0; i<Average.size(); i++){
        		if(i == Average.size())%><%=Average.get(i)%><%
        		else %><%=Average.get(i)%>,<%
        	}
        	%>        	
        ],
        marker: {
            lineWidth: 2,
            lineColor: Highcharts.getOptions().colors[3],
            fillColor: 'white'
        }
    }, {
        type: 'pie',
        name: '연간 총 이용자',
        data: [{
            name: '축구',
            y: <%=totalSoccer%>,
            color: Highcharts.getOptions().colors[0] // Jane's color
        }, {
            name: '농구',
            y: <%=totalBasketBall%>,
            color: Highcharts.getOptions().colors[1] // John's color
        }, {
            name: '야구',
            y: <%=totalBaseBall%>,
            color: Highcharts.getOptions().colors[2] // John's color
        }, {
            name: '탁구',
            y: <%=totalPingPong%>,
            color: Highcharts.getOptions().colors[3] // John's color
        }, {
            name: '배드민턴',
            y: <%=totalBadminton%>,
            color: Highcharts.getOptions().colors[4] // Joe's color
        }],
        center: [100, 80],
        size: 150,
        showInLegend: false,
        dataLabels: {
            enabled: false
        }
    }]
});
$(".btn-primary").click(function() {

	if($(this).html() == '종목 점수'){
		/* alert("월"); */
		location.href = "admin_chart_score.do";
	}

});
</script>  
</body>
</html>