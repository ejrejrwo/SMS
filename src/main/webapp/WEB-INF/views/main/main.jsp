<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.boot.finalpro.common.util.CalDateDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.boot.finalpro.game.model.GameDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  

<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<link rel="stylesheet" type="text/css" href="/css/Main.css">
<style>
<!--
#caldiv a{
	color: white;
}
.satday a{
	color: blue;
}
.sunday a{
	color: red;
}
-->
</style> 

<%! 
// 메소드 선언
public String WeekdayCallist(int year,int month, int day,List<GameDTO>gDto){	
	String s="";
	String dates=(year + "-") + two(month+"")+"-" + two(day + "");//년월일 8글자 만드는거
	Date today = new Date();
	SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
	String today_ =date.format(today).substring(0,4)+"-"+date.format(today).substring(4,6)+"-"+date.format(today).substring(6);
	//1.오늘이 평일
	if(today_.equals(dates)){
		for(GameDTO dto : gDto){
			//1-1.일정이 있으면
			if(dto.getGdate().equals(dates)){
				s += "<a href='#none' class='calTitle' style='color:black;border:2px solid skyblue; background-color:skyblue; border-radius:10px 10px 10px 10px'>";
				s += two(day+"");
				s += "</a>";
				return s;
			}
		}
		
		//1-2.일정이 없으면
		s += "<font style='color:black;border:2px solid skyblue; background-color:skyblue; border-radius:10px 10px 10px 10px'>";
		s += two(day+"");
		s += "</font>";
		return s;		
	}
	
	//2.오늘이 아닌 평일
	else{
		for(GameDTO dto : gDto){
			//2-1.일정이 있으면
			if(dto.getGdate().equals(dates) ){
				s += "<a href='#none' class='calTitle' style='color:black;border:2px solid white; background-color:white; border-radius:10px 10px 10px 10px'>";
				s += two(day+"");
				s += "</a>";
				return s;
			}
		}
		//2-2.일정이 없으면
		s += "<font style='color:black;'>";
		s += two(day+"");
		s += "</font>";
		return s;
	
		}		
}

public String saturdayCallist(int year,int month, int day,List<GameDTO>gDto){	
	String s="";
	String dates=(year + "-") + two(month+"")+"-"+ two(day + "");//년월일 8글자 만드는거
	Date today = new Date();
	SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
	String today_ =date.format(today).substring(0,4)+"-"+date.format(today).substring(4,6)+"-"+date.format(today).substring(6);
	//1.오늘이 토요일
	if(today_.equals(dates)){
		for(GameDTO dto : gDto){
			//1-1.일정이 있으면
			if(dto.getGdate().equals(dates)){
				s += "<a href='#none'class='calTitle' style='color:blue;border:2px solid skyblue; background-color:skyblue; border-radius:10px 10px 10px 10px'>";
				s += two(day+"");
				s += "</a>";
				return s;
			}
		}
		
		//1-2.일정이 없으면
			s += "<font style='color:blue;border:2px solid skyblue; background-color:skyblue; border-radius:10px 10px 10px 10px'>";
			s += two(day+"");
			s += "</font>";
			return s;		
	}
	
	//2.오늘이 아닌 토요일
	else{
		for(GameDTO dto : gDto){
			//2-1.일정이 있으면
			if(dto.getGdate().equals(dates)){
				s += "<a href='#none'class='calTitle' style='color:blue;border:2px solid white; background-color:white; border-radius:10px 10px 10px 10px'>";
				s += two(day+"");
				s += "</a>";
				return s;
			}
	
		}
		//2-2.일정이 없으면

		s += "<font style='color:blue;'>";
		s += two(day+"");
		s += "</font>";
		return s;		
	}
}
public String sundayCallist(int year,int month, int day,List<GameDTO>gDto){	
	String s="";
	String dates=(year + "-") + two(month+"")+"-"+ two(day + "");//년월일 8글자 만드는거
	Date today = new Date();
	SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
	String today_ =date.format(today).substring(0,4)+"-"+date.format(today).substring(4,6)+"-"+date.format(today).substring(6);
	//1.오늘이 일요일
	if(today_.equals(dates)){
		for(GameDTO dto : gDto){
			//1-1.일정이 있으면
			if(dto.getGdate().equals(dates)){
				s += "<a href='#none' class='calTitle'style='color:red;border:2px solid skyblue; background-color:skyblue; border-radius:10px 10px 10px 10px'>";
				s += two(day+"");
				s += "</a>";
				return s;
			}
		}
		
		//1-2.일정이 없으면
		s += "<font style='color:red;border:2px solid skyblue; background-color:skyblue; border-radius:10px 10px 10px 10px'>";
		s += two(day+"");
		s += "</font>";
		return s;
		
	}
	
	//2.오늘이 아닌 일요일
	else{
		for(GameDTO dto : gDto){
			//2-1.일정이 있으면
			if(dto.getGdate().equals(dates)){
				s += "<a href='#none'class='calTitle' style='color:red;border:2px solid white; background-color:white; border-radius:10px 10px 10px 10px'>";
				s += two(day+"");
				s += "</a>";
				return s;
			}
		}
		//2-2.일정이 없으면
		s += "<font style='color:red;'>";
		s += two(day+"");
		s += "</font>";
		return s;		
	}
}

//오늘 날짜 구하기
public String getToday(){
	Date today = new Date();
	SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
	/* String today_ =date.format(today).substring(0,4)+"-"+date.format(today).substring(4,6)+"-"+date.format(today).substring(6); */
	return date.format(today);
}

//1자라면 0을 붙여 두자로 만들기 1->01
public String two(String msg){
	return msg.trim().length()<2?"0"+msg:msg.trim();
}//
//15자 이상되면 ... 를 이용하여 줄임표시
public String dot3(String msg){
	String s="";
	if(msg.length()>=15){
		s=msg.substring(0,15);
		s+="...";
	}else{
		s=msg.trim();
	}
	return s;
}
public String makeTable(int year,int month, int day,
		List<GameDTO> lcdtos){
	String s="";
	String dates=(year + "-") + two(month + "")+"-" + two(day + "");//년월일 8글자 만드는거
	for(int i=0; i<lcdtos.size(); i++){
		if(lcdtos.get(i).getGdate().equals(dates)){
			s+=String.format("<input type='hidden' value='%s' gDate='%s'>",lcdtos.get(i).getTitle(),lcdtos.get(i).getGdate());
		}
	}
	return s;
}
%>

<%

List<GameDTO> list = new ArrayList<GameDTO>();
Object oflist = request.getAttribute("gDto");
if(oflist != null){
	list = (List<GameDTO>)oflist;
}

/* System.out.println("list 길이:"+list.size()); */

CalDateDto jcal = (CalDateDto)request.getAttribute("jcal");

int dayOfWeek = jcal.getDayOfWeek();	// 1 ~ 7
int lastDayOfMonth = jcal.getLastDay();

int year = jcal.getYear();
int month = jcal.getMonth();


// < 월을 -1
String p = String.format("<a href='%s?year=%d&month=%d'><img src='/image/left-arrow.png'/></a>", 
							"main.do", year, month-1);

// > 월을 +1
String n = String.format("<a href='%s?year=%d&month=%d'><img src='/image/right-arrow.png'/></a>", 
							"main.do", year, month+1);
%>

  
<div id="bodydiv"> 
	<div id="background_div">
		<div id="wrap_div">
			<div id="title_div"><strong style="color:#1E90FF; ">스포츠</strong>와<strong style="color:#1E90FF; "> 문화 예술</strong>을 만날 수 있는 곳!</div>
			<div id="titlesub_div">서울특별시 잠실 종합운동장</div>
		</div>
	<div id="subdiv">
      <div id="caldiv">
      	<div id="_calTitleDiv">
      		 <%=p %>&nbsp;&nbsp;<%=year%>년 <%=month %>월&nbsp;&nbsp;<%=n %>
      	</div>
      	<div style="width: 40%; height: 85%; float: left; color: white;">
      		<table style="color: white;">
      			<colgroup>
     			<col width="20px"><col width="20px"><col width="20px"><col width="20px"><col width="20px"><col width="20px"><col width="20px">
				</colgroup>
				<thead>
					<tr height="50px">
						<th class="days3" style="color: red">일</th>
						<th class="days3">월</th>
						<th class="days3">화</th>
						<th class="days3">수</th>
						<th class="days3">목</th>
						<th class="days3">금</th>
						<th class="days3" style="color: blue">토</th>
					</tr>			
				</thead>
				<tbody>
				<tr height="20px">
				<%
				for(int i = 1;i < dayOfWeek; i++){
					out.println("<td>&nbsp;</td>");
				}
				
				for(int i = 1;i <= lastDayOfMonth; i++){
					
					
					if((i + dayOfWeek - 1) % 7 == 0){	// 토요일
						%>
						<td class="satday"><%=saturdayCallist(year, month, i,list)%><%=makeTable(year, month, i, list)%>
						</td>
						<%
					}
					else if((i + dayOfWeek - 1) % 7 == 1){	// 일요일
						%>
						<td class="sunday"><%=sundayCallist(year, month, i,list) %><%=makeTable(year, month, i, list)%>
						</td>
						<%
					}
					else{
						%>
						<td class="otherday"><%=WeekdayCallist(year, month, i,list) %><%=makeTable(year, month, i, list)%>
						</td>
						<%
					}	
					
					if((i + dayOfWeek - 1) % 7 == 0 && i != lastDayOfMonth){
						%>
						</tr><tr height="20px">
						<%
					}
				}
				
				for(int i = 0;i < (7 - (dayOfWeek + lastDayOfMonth - 1)%7)%7; i++){
					out.println("<td>&nbsp;</td>");
				}
				
				%>
				</tr>
				</tbody>
      		</table>
      	</div>
      	<div id="_scheduleDiv" style=" width: 60%; height: 85%; float: left;">
      		<table>
      			<colgroup><col width="10%"><col width="90%"></colgroup>
      			<thead>
      				<tr>
      				<th colspan="2" id="_scheduleTitle">
					<%=getToday().substring(0, 4) %>년 <%=getToday().substring(4, 6) %>월 <%=getToday().substring(6, 8) %>일 경기 일정
      				</th>
      				</tr>
      			</thead>
      			<tbody id="_scheduleTbody">
					<c:choose>
						<c:when test="${not empty gDaily }">
							<c:forEach var="i" items="${gDaily }" varStatus="vs">
								<c:if test="${vs.count <= 5 }">
								<tr><th colspan="2">${vs.count }. ${i.title }</th></tr>
								</c:if>
							</c:forEach>
						</c:when>
						<c:otherwise>
						<tr>
						<th colspan="2" style="text-align: center;">경기 일정이 없습니다.</th>
						</tr>						
						</c:otherwise>					
					</c:choose>
      			</tbody>
      		</table>
      	</div>
      </div>
      <div id="weatherdiv">
         	<table>
         		<colgroup><col width="50%"><col width="50%"></colgroup>
         			<tr style="height:12.5% ">
         				<th colspan="2" style="text-align: center; font-size: 18px">오늘의 날씨 (<c:out value="${weather['hour'] }"/>시 기준)</th>
         			</tr>
         			<tr style="height: 12.5%">
         				<th id="_loc">서울특별시</th>
         				<td style="text-align: right;">		
         				<select style="float: right; width: 100px; height: 28px; padding: 3px 3px" id="_selectbox" class="form-control">
         					<option selected="selected">서울특별시</option>
         					<option>대전광역시</option><option>강원강릉시</option><option>광주광역시</option><option>부산광역시</option>
         				</select> 
         				</td>
         			</tr>
         			<tr style="height: 12.5%;">
         				<td style="border-top: 1px solid white; text-align: left;">온도</td>
         				<td style="border-top: 1px solid white; text-align: right;" id="_temp">${weather['T3H'] }도</td>
         			</tr>
         			<tr style="height: 12.5%">
         				<td style="text-align: left;">습도</td>
         				<td style="text-align: right;" id="_htum"><c:out value="${weather['REH'] }"/>%</td>
         			</tr>
         			<tr style="height: 12.5%">
         				<td style="text-align: left;">강수확률</td>
         				<td style="text-align: right;" id="_rain"><c:out value="${weather['POP'] }"/>%</td>
         			</tr>
         			<tr style="height: 12.5%">
         				<td style="border-bottom: 1px solid white; text-align: left;">하늘</td>
         				<td style="border-bottom: 1px solid white; text-align: right;" class="skyimg" id="_sky">${weather['SKY'] }</td>
         			</tr>
         			<tr style="height: 12.5%">
         				<td style="text-align: left;">미세먼지</td>
         				<td style="text-align: right;" id="_pm10">
							${weather['pm25Grade1h']}						
         				</td>
         			</tr>
         			<tr style="height: 12.5%">
         				<td style="text-align: left;">초미세먼지</td>
         				<td style="text-align: right;" id="_pm25">
							${weather['pm10Grade1h'] }
         				</td>
         			</tr>
         	</table>
      </div>
   </div>
	</div>
	
	<div id="middlediv">
		<div id="wrapdiv">
			<div id="bbsdiv">
				<table id="bbsdiv_table">
				<colgroup><col width="20%"><col width="55%"><col width="25%"></colgroup>
				<tr style="height: 20%">
					<td colspan="3" style="border-bottom: 3px solid blue; text-align: left;"><span>공지사항</span><button type="button" id="_noticeBtn" title="공지사항 게시판">자세히보기</button></td>
				</tr>
				<c:forEach var="i" items="${noticeList }" end="4">
					<tr style="height:16%" seq="${i.seq }" class="notice_tr">
						<th class="categoryTd" style="text-align: left; padding-left: 10px">${i.id }</th>
						<td style="text-align: left;">
						<c:choose>
							<c:when test="${fn:length(i.title) gt 26 }">
							${fn:substring(i.title,0,25) }...
							</c:when>
							<c:otherwise>
							${i.title }
							</c:otherwise>						
						</c:choose>
						</td>
						<td style="text-align: right;"class="noticeDate" ">${fn:substring(i.wdate,0,10) }</td>
					</tr>
				</c:forEach>
				</table>
			</div>
			
			
			<div id="_stadiumDiv">
				<table>
					<colgroup>
						<col width="260px">
						<col width="10px">
						<col width="260px">
					</colgroup>
					<tr>
						<td><video width="250px" height="180px" controls
								autoplay="autoplay" style="outline: none;">
								<source
									src="<%=request.getContextPath() %>/upload/${video[0].file_name }"
									type="video/mp4">
							</video></td>
						<td></td>
						<td><video width="250px" height="180px" controls
								style="outline: none;">
								<source
									src="<%=request.getContextPath() %>/upload/${video[1].file_name }"
									type="video/mp4">
							</video></td>
					</tr>
					<tr id="_galleryTr">
						<th style="text-align: center;">동영상</th>
						<td></td>
						<th style="text-align: center;">동영상</th>
					</tr>
					<tr>
						<th style="text-align: center;">${video[0].title }</th>
						<td></td>
						<th style="text-align: center;">${video[1].title }</th>
					</tr>
					<tr id="_dateTr">
						<th style="text-align: center;"><fmt:formatDate value="${video[0].wdate }" pattern="yyyy-MM-dd" /></th>
						<td></td>
						<th style="text-align: center;"><fmt:formatDate	value="${video[1].wdate }" pattern="yyyy-MM-dd" /></th>
					</tr>
					<tr id="_btnTr">
						<th style="text-align: center;"><button title="갤러리"
								onclick="location.href='video.do'">더보기</button></th>
						<td></td>
						<th style="text-align: center;"><button title="갤러리"
								onclick="location.href='video.do'">더보기</button></th>
					</tr>
				</table>
			</div>
			
			
			
		</div>
	</div>
	<div id="_footerDiv">
		<div id="_wrapDiv2">
			<table>
			<colgroup><col width="25%"><col width="25%"><col width="25%"><col width="25%"></colgroup>
				<tr style="height: 50%;" id="_footUpTr">
					<th style="text-align: center;">
						<div><img alt="" src="/image/placeholder.png" onclick="pagemove('../common/stadium.do?num=1')"><br>오시는 길</div>
					</th>
					<th style="text-align: center;">
						<div><img alt="" src="/image/test.png" onclick="pagemove('../common/stadium.do?num=1')"><br>대관안내</div>
					</th>
					<th style="text-align: center;">
						<div><img alt="" src="/image/cal-clock.png" onclick="pagemove('../common/stadium.do?num=1')"><br>대관일정</div>
					</th>
					<th style="text-align: center;">
						<div><img alt="" src="/image/phone-call.png" onclick="pagemove('../common/phoneguide.do')"><br>문의전화</div>
					</th>
				</tr>
				<tr style="height: 50%;">
					<th style="text-align: center;">
						<div><img alt="" src="/image/support.png" onclick="pagemove('../mypage/teamlist.do')"><br>팀 매칭</div>
					</th>
					<th style="text-align: center;">
						<div><img alt="" src="/image/podium.png" onclick="pagemove('../mypage/teamapplication.do')"><br>팀 순위</div>
					</th>
					<th style="text-align: center;">
						<div><img alt="" src="/image/group.png" onclick="pagemove('../common/gamelist.do')"><br>상대찾기</div>
					</th>
					<th style="text-align: center;">
						<div><img alt="" src="/image/tournament-.png" onclick="pagemove('../common/userleagueapply.do')"><br>토너먼트</div>
					</th>
				</tr>
			</table>
		</div>
	</div>
</div>


<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function pagemove( url ) {
	location.href = url;
}

$(document).ajaxSend(function(e, xhr, options) {
    xhr.setRequestHeader(header, token);
});
	$("#_selectbox").on("change",function(){
		var select = $(this).val();
		/* alert(select); */
		$.ajax({
			type: "get",
			url: "weather.do",
			data: "location="+select,
			success:function(after){
				$("#_loc").html(select);
				$("#_rain").html(after.POP +"%");
				$("#_sky").html(after.SKY);
				$("#_temp").html(after.T3H +"도");
				$("#_htum").html(after.REH +"%");
				$("#_pm10").html(after.pm10Grade1h)
				$("#_pm25").html(after.pm25Grade1h);
				/* alert(after.location); */
				$("#background_div").css("background-image",after.location); 
			},
			error:function(){
				alert("error");
			}
		});
	});
	
$(".calTitle").on("click",function(){
	$("#_scheduleTbody").children().remove();
	var day = $(this).parent().children().eq(1).attr("gDate");
	var year = day.substr(0, 4);
	var month = day.substr(5, 2);
	var date = day.substr(8, 8);
	$("#_scheduleTitle").html(year+"년 "+month+"월 "+date+"일 경기 일정");
	var titleSize = $(this).parent().children("input[type='hidden']").length;
	var titleArray = new Array(titleSize);
	for (var i = 0; i < titleArray.length; i++) {
		if(i<5){
		$("#_scheduleTbody").append("<tr><th colspan='2'>"+(i+1)+". "+$(this).parent().children("input[type='hidden']").eq(i).val()+"<th></tr>")
		}
	}
	
});

$(".notice_tr").click(function() {
	var notice_seq = $(this).attr("seq");
	/* alert(notice_seq); */
	location.href = "noticeDetail.do?page=1&seq="+notice_seq;
});
$("#_noticeBtn").click(function() {
/* 	alert("클릭됨"); */
 	location.href = "notice.do?page=1"
});
	
</script>