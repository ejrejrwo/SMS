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
	Map<String,List<GameDTO>> monthlyStadiumCount = new HashMap<>();
	monthlyStadiumCount = (Map<String,List<GameDTO>>)request.getAttribute("monthlyStadiumCount");
	List<GameDTO> stadiumCount = new ArrayList<>();
	stadiumCount = monthlyStadiumCount.get("stadiumCount");
	for(int i=0; i<stadiumCount.size(); i++){
		System.out.println("@@@@@@@@@@@@@jsp:"+stadiumCount.get(i).toString());
	}
 	List<GameDTO> busanStadium = new ArrayList<>();
 	List<GameDTO> jamsilStadium= new ArrayList<>();
 	List<GameDTO> hanbatStadium = new ArrayList<>();
 	List<GameDTO> gwangzuStadium = new ArrayList<>();
 	List<GameDTO> kangreungStadium = new ArrayList<>();
 	
	if(monthlyStadiumCount.get("부산") != null){
		busanStadium = monthlyStadiumCount.get("부산");	
	}
	if(monthlyStadiumCount.get("잠실") != null){
		jamsilStadium = monthlyStadiumCount.get("잠실");	
	}
	if(monthlyStadiumCount.get("한밭") != null){
		hanbatStadium = monthlyStadiumCount.get("한밭");	
	}
	if(monthlyStadiumCount.get("광주") != null){
		gwangzuStadium = monthlyStadiumCount.get("광주");	
	}
	if(monthlyStadiumCount.get("강릉") != null){
		kangreungStadium = monthlyStadiumCount.get("강릉");	
	}

%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>
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
		<select class="form-control" style="width: 125px">
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
        type: 'pie'
    },
    title: {
        text: null
    },
    subtitle: {
        text: null
    },
    plotOptions: {
        series: {
            dataLabels: {
                enabled: true,
                format: '{point.name}: {point.y:.1f}건'
            }
        }
    },

    tooltip: {
        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.1f}건</b> of total<br/>'
    },

    series: [
        {
            name: "Browsers",
            colorByPoint: true,
            data:[
            	<%
            	for(int i=0; i<stadiumCount.size(); i++){
            		 if(i == stadiumCount.size()-1){
            			%>{name:"<%=stadiumCount.get(i).getName_stadium()%>",y:<%=stadiumCount.get(i).getRead_count()%>,drilldown:"<%=stadiumCount.get(i).getName_stadium()%>"}<%
            		}
            		else{
            			%>{name:"<%=stadiumCount.get(i).getName_stadium()%>",y:<%=stadiumCount.get(i).getRead_count()%>,drilldown:"<%=stadiumCount.get(i).getName_stadium()%>"},<%
            		}
            	}
            	%>
            ] 
        }
    ],
    drilldown: {
        series: [
        	{
        		name:"부산",
        		id:"부산",
        		data:[
          			<%
          			for(int i=0; i<busanStadium.size(); i++){
          				if(i == busanStadium.size()){
          					%>["<%=busanStadium.get(i).getCategory()%>장",<%=busanStadium.get(i).getRead_count()%>]<%
          				}
          				else{
          					%>["<%=busanStadium.get(i).getCategory()%>장",<%=busanStadium.get(i).getRead_count()%>],<%
          				}
          			}
          			%>	
        		]
        	},
        	{
        		name:"잠실",
        		id:"잠실",
        		data:[
          			<%
          			for(int i=0; i<jamsilStadium.size(); i++){
          				if(i == jamsilStadium.size()){
          					%>["<%=jamsilStadium.get(i).getCategory()%>장",<%=jamsilStadium.get(i).getRead_count()%>]<%
          				}
          				else{
          					%>["<%=jamsilStadium.get(i).getCategory()%>장",<%=jamsilStadium.get(i).getRead_count()%>],<%
          				}
          			}
          			%>	
        		]
        	}, 
        	{
        		name:"한밭",
        		id:"한밭",
        		data:[
          			<%
          			for(int i=0; i<hanbatStadium.size(); i++){
          				if(i == hanbatStadium.size()){
          					%>["<%=hanbatStadium.get(i).getCategory()%>장",<%=hanbatStadium.get(i).getRead_count()%>]<%
          				}
          				else{
          					%>["<%=hanbatStadium.get(i).getCategory()%>장",<%=hanbatStadium.get(i).getRead_count()%>],<%
          				}
          			}
          			%>	
        		]
        	},
        	{
        		name:"광주",
        		id:"광주",
        		data:[
          			<%
          			for(int i=0; i<gwangzuStadium.size(); i++){
          				if(i == gwangzuStadium.size()){
          					%>["<%=gwangzuStadium.get(i).getCategory()%>장",<%=gwangzuStadium.get(i).getRead_count()%>]<%
          				}
          				else{
          					%>["<%=gwangzuStadium.get(i).getCategory()%>장",<%=gwangzuStadium.get(i).getRead_count()%>],<%
          				}
          			}
          			%>	
        		]
        	},
        	{
        		name:"강릉",
        		id:"강릉",
        		data:[
          			<%
          			for(int i=0; i<kangreungStadium.size(); i++){
          				if(i == kangreungStadium.size()){
          					%>["<%=kangreungStadium.get(i).getCategory()%>장",<%=kangreungStadium.get(i).getRead_count()%>]<%
          				}
          				else{
          					%>["<%=kangreungStadium.get(i).getCategory()%>장",<%=kangreungStadium.get(i).getRead_count()%>],<%
          				}
          			}
          			%>	
        		]
        	}        	
        ]
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