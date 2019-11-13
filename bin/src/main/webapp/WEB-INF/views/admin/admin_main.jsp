<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%!
Date today = new Date();
SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
String today_ =date.format(today).substring(0,4)+"-"+date.format(today).substring(4,6)+"-"+date.format(today).substring(6);
%>    
<%
	List<Integer> yearProfit = new ArrayList<>();
	List<Integer> yearSpend = new ArrayList<>();
	List<Integer> yPminusyS = new ArrayList<>();
	Map<String,Integer> getGameCategoryCount = new HashMap<>();
	yearProfit = (List<Integer>)request.getAttribute("yearProfit");
	yearSpend = (List<Integer>)request.getAttribute("yearSpend");
	yPminusyS = (List<Integer>)request.getAttribute("yPminusyS");
	getGameCategoryCount = (Map<String,Integer>)request.getAttribute("getGameCategoryCount");
	pageContext.setAttribute("today_", today_);
%>
<style type="text/css">
th{
 text-align: center;
}
.notice_list_tr:hover {
	cursor: pointer;
}
</style>     
<c:set var="today" value="${pageScope.today_ }"/>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/series-label.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>    
          <!-- Content Row -->
          <div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">오늘의 수입</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">${dailyProfitMoney }원</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-success text-uppercase mb-1">이번달 수입</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">${monthlyProfitMoney }원</div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-info text-uppercase mb-1">최강팀</div>
                      <div class="row no-gutters align-items-center">
                        <div class="col-auto">
                          <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">
                          <c:choose>
                          	<c:when test="${empty firstTeam.team_name }">
                          		<h2>순위가 없습니다.</h2>
                          	</c:when>
                          	<c:otherwise>
       	                        ${firstTeam.team_name }<br>
                          		${firstTeam.total_mmr }
                          	</c:otherwise>
                          </c:choose>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-users fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Pending Requests Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">최약팀</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800">
                          <c:choose>
                          	<c:when test="${empty lastTeam.team_name }">
                          		<h2>순위가 없습니다.</h2>
                          	</c:when>
                          	<c:otherwise>
       	                        ${lastTeam.team_name }<br>
                          		${lastTeam.total_mmr }
                          	</c:otherwise>
                          </c:choose>                                        
                      </div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-users fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Content Row -->

          <div class="row">

            <!-- Area Chart -->
            <div class="col-xl-8 col-lg-7">
              <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">연간 소득</h6>
                </div>
                <!-- Card Body -->
                <div class="card-body" id="areaChart">
                </div>
              </div>
            </div>

            <!-- Pie Chart -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">이번달 선호 종목</h6>
                </div>
                <!-- Card Body -->
                <c:choose>
                	<c:when test="${empty getGameCategoryCount }">
		                 <div class="card-body" style="text-align: center;">
		                 		<h1>이번달 통계가 없습니다.</h1>
		             	</div>                	
                	</c:when>
                	<c:otherwise>
		                 <div class="card-body" id="circleChart">
		             	</div>                	
                	</c:otherwise>
                </c:choose>
            </div>
          </div>
		</div>
          <!-- Content Row -->
          <div class="row">

            <!-- Content Column -->
            <div class="col-lg-6 mb-4">

              <!-- Project Card Example -->
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">최근 경기 일정(10경기)</h6>
                </div>
				  <div class="card-body">
				    <div class="table-responsive">
						<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
							<div class="row">		
								<div class="col-sm-12">
									<table class="table table-bordered dataTable table-hover" id="dataTable" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
									<colgroup><col width="15%"><col width="15%"><col width="50%"><col width="20%"></colgroup>			
									<thead>
										<tr><th>종목</th><th>위치</th><th>제목</th><th>경기일</th></tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${empty recentlyGame }">	<!-- 경기 일정이 없을경우 -->
												<tr>
												<th colspan="4">
												<h1>예정된 경기 일정이 없습니다.</h1>
												</th>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach	var="i" items="${recentlyGame }" varStatus="vs">
													<tr class="notice_list_tr">
													<th>${i.category }</th><th>${i.name_stadium }</th>
													<td style="text-align: left;">
													<c:choose>
														<c:when test="${fn:length(i.title) gt 35 }">
															${fn:substring(i.title,0,34) }...
														</c:when>
														<c:otherwise>
															${i.title }
														</c:otherwise>
													</c:choose>
													<c:choose>
														<c:when test="${i.gdate eq today }">
														<th class="gdate_th" gdate="${i.gdate }" style="color: red">${i.gdate }</th>
														</c:when>
														<c:otherwise>
														<th class="gdate_th" gdate="${i.gdate }">${i.gdate }</th>
														</c:otherwise>
													</c:choose>
												</c:forEach>					
											</c:otherwise>
										</c:choose>
									</tbody> 					
									</table>
						        </div>
					       </div>						
						</div>
					</div>
				  </div>                
                </div>
			 </div>             
            <div class="col-lg-6 mb-4">

              <!-- 최근 환전 -->
              <div class="card shadow mb-4">
                <div class="card-header py-3">
                  <h6 class="m-0 font-weight-bold text-primary">최근 환전 신청(10건)</h6>
                </div>
				  <div class="card-body">
				    <div class="table-responsive">
						<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
							<div class="row">		
								<div class="col-sm-12">
									<table class="table table-bordered dataTable table-hover" id="dataTable" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%;">
									<colgroup><col width="20%"><col width="15%"><col width="25%"><col width="15%"><col width="35%"></colgroup>			
									<thead>
										<tr><th>아이디</th><th>은행</th><th>계좌번호</th><th>금액</th><th>신청일</th></tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${empty dontExchangeTop10 }">	<!-- 경기 일정이 없을경우 -->
												<tr>
												<th colspan="5">
												<h1>환전신청 내역이 없습니다.</h1>
												</th>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach	var="i" items="${dontExchangeTop10 }" varStatus="vs">
													<tr class="notice_list_tr">
													<th>${i.id }</th><th>${i.bank }</th><th>${i.bank_number }</th><th>${i.exchange_money }</th><th>${i.exdate }</th>
												</c:forEach>					
											</c:otherwise>
										</c:choose>
									</tbody> 					
									</table>
						        </div>
					       </div>						
						</div>
					</div>
				  </div>                
              </div>
            </div>
          </div>

<!-- Page level plugins -->
<script src="/vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<!-- <script src="/admin-js/demo/chart-area-demo.js"></script> -->
<!-- <script src="/admin-js/demo/chart-pie-demo.js"></script> -->
<script>
var datePick = new Date();
var mm = datePick.getMonth()+1;
if(mm.length<2){
	mm = "0"+mm;
}
Highcharts.chart('areaChart', {

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


Highcharts.chart('circleChart', {
    chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
    },
    title: {
        text: mm +'월 인기 종목'
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
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
        name: '비율',
        colorByPoint: true,
        data:[{
            name: '축구',
            y: <%=getGameCategoryCount.get("축구")%>
        }, {
            name: '농구',
            y: <%=getGameCategoryCount.get("농구")%>
        }, {
            name: '야구',
            y: <%=getGameCategoryCount.get("야구")%>
        }, {
            name: '탁구',
            y: <%=getGameCategoryCount.get("탁구")%>
        }, {
            name: '배드민턴',
            y: <%=getGameCategoryCount.get("배드민턴")%>
        }]
    }]
});

$(".gdate_th").click(function() {
	/* alert("클릭"); */
	alert($(this).attr("gdate"));
});

</script>
          