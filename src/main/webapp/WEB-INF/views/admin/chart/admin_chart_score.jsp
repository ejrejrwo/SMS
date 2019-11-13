<%@page import="com.boot.finalpro.admin.util.SportsScoreDto"%>
<%@page import="com.sun.mail.imap.protocol.ListInfo"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

Map<String,SportsScoreDto> sportsScore = new HashMap<>();
sportsScore = (Map<String,SportsScoreDto>)request.getAttribute("sportsScore"); 
SportsScoreDto soccer = sportsScore.get("soccer");
SportsScoreDto basketBall = sportsScore.get("basketBall");
SportsScoreDto baseBall = sportsScore.get("baseBall");
SportsScoreDto badminton = sportsScore.get("badminton");
SportsScoreDto pingpong = sportsScore.get("pingpong");
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
		<button type="button" class="btn btn-primary">선호 종목</button>&nbsp;
		<button type="button" class="btn btn-primary" disabled="disabled">종목 점수</button>&nbsp;
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
                <div class="card-body" id="sportsSocre" style="height: 650px">
                </div>
              </div>
            </div>				
			</div>
		</div>
	</div>
  </div>
<script type="text/javascript">
Highcharts.chart('sportsSocre', {
    title: {
        text: null
    },
    xAxis: {
        categories: ['축구', '농구', '야구', '배드민턴', '탁구']
    },
    yAxis: {
        title: {
            text: '점수'
        },
	    labels: {
	        formatter: function () {
	            return this.value + '점';
	        }
	    }    
    },

    series: [{
        type: 'column',
        name: '최고점',
        data: [<%=soccer.getMax()%>,<%=basketBall.getMax()%>,<%=baseBall.getMax()%>,<%=badminton.getMax()%>,<%=pingpong.getMax()%>]
    }, {
        type: 'column',
        name: '최저점',
        data: [<%=soccer.getMin()%>,<%=basketBall.getMin()%>,<%=baseBall.getMin()%>,<%=badminton.getMin()%>,<%=pingpong.getMin()%>]
    }, {
        type: 'spline',
        name: '평균점',
        data: [<%=soccer.getAvg()%>,<%=basketBall.getAvg()%>,<%=baseBall.getAvg()%>,<%=badminton.getAvg()%>,<%=pingpong.getAvg()%>],
        marker: {
            lineWidth: 2,
            lineColor: Highcharts.getOptions().colors[3],
            fillColor: 'white'
        }
    }]
});
$(".btn-primary").click(function() {

	if($(this).html() == '선호 종목'){
		location.href = "admin_chart_category.do";
	}

});
</script>  
</body>
</html>