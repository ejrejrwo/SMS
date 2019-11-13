<%@page import="com.boot.finalpro.util.DateUtil"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.boot.finalpro.game.model.StadiumDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
 
         
<%
//List<StadiumDTO> slist = (List<StadiumDTO>)request.getAttribute("slist");
//String name_stadium = slist.get(0).getName_stadium().substring(0, 2);
//System.out.println(name_stadium);

Calendar cal = Calendar.getInstance();
int toyear = cal.get(Calendar.YEAR);	
int tomonth = cal.get(Calendar.MONTH) + 1;
int todate = cal.get(Calendar.DATE);
//System.out.println("오늘날짜=======" + toyear + " " + tomonth + " " + todate);

String bdate = toyear + "-" + DateUtil.two(tomonth + "") + "-" + DateUtil.two(todate + "");
%>

<style type="text/css">
.s_btn{
	width: 17%;
	height: 50px;
	background-color: #042e6f;
	color: #fff;
	font-size: 18px;
	outline: none;	
    border-radius: 4px;
    border: 1px solid transparent;   
}

th{
	text-align: center;
}

.title{
	font-family: 'nsk','Dotum','arial','sans-serif';
	font-size: 20px;
	color: #282828;
	font-weight: 600;
}
.content{
	margin: 3px 0 3px 0px;
    padding-left: 12px;
    line-height: 23px;
    color: #545454;
    font-size: 15px;

}

</style>

<div id="_top">
	경기장소개
</div>

<div>	
	<table class="table table-bordered" style="text-align: left; width: 1400px;">
	<col width="100">		
		<tr style="background: #f8f8f8;">
			<td>
				<img alt="" src="../image/jamsil_main.jpg" width="250px" height="150px">
			</td>
			<td>
				<h3 class="title">잠실종합운동장</h3>
				<div class="content">
					- 위치: 서울특별시 송파구 올림픽로 25 (잠실동 10)<br>
					- 시설현황:<br>
					- 문의전화: 02-2240-8800
				</div>
			</td>
			
			<td rowspan="5" style="width: 540px;">
				<table class="table table-bordered">
					<tr>
						<td colspan="6" style="text-align: center;">
							<h2>사용료</h2>														
						</td>
					</tr>
					<tr>
						<th>경기장</th>
						<th>야구장</th><th>축구장</th><th>농구장</th><th>탁구장</th><th>배드민턴장</th>				
					</tr>
					<tr style="text-align: center;">
						<th>금액</th>
						<td>100,000원</td><td>100,000원</td><td>50,000원</td><td>10,000원</td><td>10,000원</td>	
					</tr>
					<tr>
						<th>이용<br>수칙</th>
						<td colspan="5">
						1. 시간은 3시간 단위. 모든 구장 동일금액<br> &nbsp; ※ 조명사용은 별도 부과<br>
						2. 등급별 차등 금액 적용<br>
						3. 취사  및 과도한 음주행위 금지<br>
						4. 사용중 파손(고장)시에는 사용자 부담으로 보수 및 원상회복해야 함<br>
						</td>
					</tr>
				</table>
			
			</td>
		</tr>
		
		<tr style="background: #f8f8f8;">
			<td>
				<img alt="" src="../image/stadium_photo01.jpg" width="250px" height="150px;">
			</td>
			<td>
				<h3 class="title">한밭운동장</h3>
				<div class="content">
					- 위치: 대전광역시 중구 대종로 373<br>
					- 시설현황:<br>
					- 문의전화: 042-610-4900
				</div>
			</td>
		</tr>
		
		<tr style="background: #f8f8f8;">
			<td>
				<img alt="" src="../image/stadium_photo02.jpg" width="250px" height="150px;">
			</td>
			<td>
				<h3 class="title">부산주경기장</h3>
				<div class="content">
					- 위치: 부산광역시 동래구 사직로 55-32<br>
					- 시설현황:<br>
					- 문의전화: 051-500-2121
				</div>
			</td>
		</tr>
		
		<tr style="background: #f8f8f8;">
			<td>
				<img alt="" src="../image/stadium_photo03.jpg" width="250px" height="150px;">
			</td>
			<td>
				<h3 class="title">광주경기장</h3>
				<div class="content">
					- 위치: 광주 북구 서림로 10<br>
					- 시설현황:<br>
					- 문의전화: 070-7686-8000
				</div>
			</td>
		</tr>
		
		<tr style="background: #f8f8f8;">
			<td>
				<img alt="" src="../image/stadium_photo04.jpg" width="250px" height="150px;">
			</td>
			<td>
				<h3 class="title">강릉체육단지</h3>
				<div class="content">
					- 위치: 강원도 강릉시 종합운동장길 69(교동)<br>
					- 시설현황:<br>
					- 문의전화: 033-647-2004
				</div>
			</td>
		</tr>	
	
	</table>

</div>

<div id="_top" style="margin-top: 50px;">
	대관일정
</div>	


<div>
	<table class="table table-bordered" style="width: 1400px;">
	<col width="600px"><col width="600px">	
		<tr>
			<td colspan="2">
			<input type="hidden" id="name_stadium" value="잠실">
				<button type="button" onclick="stadiumSelect('잠실', 1)" id="stadium1" class="s_btn">잠실경기장</button>
				<button type="button" onclick="stadiumSelect('한밭', 2)" id="stadium2" class="s_btn">한밭경기장</button>
				<button type="button" onclick="stadiumSelect('부산', 3)" id="stadium3" class="s_btn">부산경기장</button>
				<button type="button" onclick="stadiumSelect('광주', 4)" id="stadium4" class="s_btn">광주경기장</button>
				<button type="button" onclick="stadiumSelect('강릉', 5)" id="stadium5" class="s_btn">강릉경기장</button>
			</td>
		</tr>		
		<tr>
			<td>
				<jsp:include page="calendar.jsp"/>
			</td>
			<td style="width: 600px;" valign="top">
				<div id="selectDate" style="font-size: 20px; font-weight: 500; text-align: left; margin-bottom: 10px;">
				대관현황
				</div>
				
				<table class="table table-bordered" border="1" id="bookstadium">																			
				</table>							
			</td>
		</tr>
	</table>
</div>

<script type="text/javascript">
$(document).ready(function () {
	$("#menu4").css("background-color","#e60013");
	
	$("#stadium1").css("background-color","#e60013");
	$("#stadium1").css("color","#fff");
	
// 달력			
	var week = new Array('일', '월', '화', '수', '목', '금', '토');
	
	var today = new Date().getDay();
	var dow = week[today];

	var bdate = '<%=bdate%>' + " " + dow;
//	alert(bdate);
	var name_stadium = $("#name_stadium").val();
//	alert(name_stadium);
	$(".day" + parseInt('<%=todate%>')).css("background-color","#d5d5d5"); 
	
	$("#selectDate").text(bdate + " 대관현황");
		
 	$.ajax({		
		url:'bookstadium.do',
		async:true,
		type: 'get',
		data: 'bdate=' + bdate + '&name_stadium=' + name_stadium,
		success:function(data){							
		var book = data.blist;
					
		var str = '<tr style="height: 40px; font-size: 15px;"><td style="width: 150px;">경기장</td><td style="width: 150px;">이용시간</td><td style="width: 150px;">예약팀</td></tr>';
		if(book == ""){
			str += '<tr style="height: 40px; font-size: 15px;">';			
			str += '<td colspan="3" style="width: 400px; height: 30px;">등록된 일정이 없습니다</td>';						
			str += '</tr>';				
		}  		
		
		$.each(book, function (i) {
			str += '<tr style="height: 40px; font-size: 15px;">';
			
			str += '<td style="width: 150px;">' + book[i].name_stadium + '</td>';
			str += '<td style="width: 150px;">' + book[i].book_time + '시 ~' + (parseInt(book[i].book_time) + 3) + '시</td>';			
			str += '<td style="width: 150px;">' + book[i].name_team1 + '</td>';
			
			str += '</tr>';	
		});
			$("#bookstadium").append(str);
																
		},
		error:function(){
			alert("error");
		}						
	}); 
})

function stadiumSelect( str, num ) {
//	alert(str);
	$("#name_stadium").val(str);
	
	$(".s_btn").css("background-color","#042e6f");
	$(".s_btn").css("color","#fff");
	$(".s_btn").css("outline","none");
	$("#stadium"+num).css("background-color","#e60013");
	$("#stadium"+num).css("color","#fff");
		
	// 달력			
	var week = new Array('일', '월', '화', '수', '목', '금', '토');
	
	var today = new Date().getDay();
	var dow = week[today];

	var bdate = '<%=bdate%>' + " " + dow;
//	alert(bdate);
	
	var name_stadium = $("#name_stadium").val();
//	alert(name_stadium);
	
	$("#selectDate").text(bdate + " 대관현황");
		
	//달력 선택 색 초기화
 	for(var i = 0; i < 32; i++){
		$(".day" + i).css("background-color","#fff");
	} 
	$(".day" + parseInt('<%=todate%>')).css("background-color","#d5d5d5"); 
	
 	$.ajax({		
		url:'stadiumSelect.do',
		async:true,
		type: 'get',
		data: 'bdate=' + bdate + '&name_stadium=' + name_stadium,
		success:function(data){		
			
			$("#bookstadium *").remove();		
			var book = data.blist;
						
			var str = '<tr style="height: 30px; height: 40px; font-size: 15px;"><td style="width: 150px;">경기장</td><td style="width: 150px;">이용시간</td><td style="width: 150px;">예약팀</td></tr>';
			if(book == ""){
				str += '<tr style="height: 40px; font-size: 15px;">';			
				str += '<td colspan="3" style="width: 400px; height: 30px;">등록된 일정이 없습니다</td>';						
				str += '</tr>';				
			}  		
		
		$.each(book, function (i) {
			str += '<tr style="height: 40px; font-size: 15px;">';
			
			str += '<td style="width: 150px;">' + book[i].name_stadium + '</td>';
			str += '<td style="width: 150px;">' + book[i].book_time + '시 ~' + (parseInt(book[i].book_time) + 3) + '시</td>';			
			str += '<td style="width: 150px;">' + book[i].name_team1 + '</td>';
			
			str += '</tr>';	
		});
			$("#bookstadium").append(str);
																						
		},
		error:function(){
			alert("error");
		}						
	}); 
	
	
}



function calselect(y, m, d, w) {			
//	alert(y + " " + m  + " " + d + " " + w);
 	for(var i = 0; i < 32; i++){
		$(".day" + i).css("background-color","#fff");
	} 
	$(".day" + parseInt(d)).css("background-color","#d5d5d5");
	
	if(w == 1)w = '일';
	else if(w == 2)w = '월';
	else if(w == 3)w = '화';
	else if(w == 4)w = '수';
	else if(w == 5)w = '목';
	else if(w == 6)w = '금';
	else if(w == 0)w = '토';
	
	var day = y + "-" + m  + "-" + d;
	$("#selectDate").text(day + " " + w + " 대관현황");	
			
	var bdate = ($("#selectDate").text()).substring(0,12);
//	alert(bdate);

	var name_stadium = $("#name_stadium").val();
//	alert(name_stadium);

	
	$.ajax({		
		url:'bookstadium.do',
		async:true,
		type: 'get',
		data: 'bdate=' + bdate + '&name_stadium=' + name_stadium,
		success:function(data){
			
			$("#bookstadium *").remove();		
			var book = data.blist;
//			alert(book);
			
			var str = '<tr style="height: 30px; height: 40px; font-size: 15px;"><td style="width: 150px;">경기장</td><td style="width: 150px;">이용시간</td><td style="width: 150px;">예약팀</td></tr>';
			
	  		if(book == ""){
				str += '<tr style="height: 40px; font-size: 15px;">';			
				str += '<td colspan="3" style="width: 400px; height: 30px;">등록된 일정이 없습니다</td>';						
				str += '</tr>';	
				
			}  
					
			$.each(book, function (i) {
	//			alert(book[i].bdate);
						
				str += '<tr style="height: 40px; font-size: 15px;">';
				
				str += '<td style="width: 150px;">' + book[i].name_stadium + '</td>';
				str += '<td style="width: 150px;">' + book[i].book_time + '시 ~' + (parseInt(book[i].book_time) + 3) + '시</td>';			
				str += '<td style="width: 150px;">' + book[i].name_team1 + '</td>';
				
				str += '</tr>';	
		});
		
		$("#bookstadium").append(str);
	
																
		},
		error:function(){
			alert("error");
		}						
	});
	
}

</script>



