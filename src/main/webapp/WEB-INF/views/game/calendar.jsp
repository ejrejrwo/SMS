<%@page import="com.boot.finalpro.game.model.StadiumDTO"%>
<%@page import="com.boot.finalpro.util.DateUtil"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>    


<style type="text/css">


</style>  
     
<%
Calendar cal = Calendar.getInstance();
int toyear = cal.get(Calendar.YEAR);	
int tomonth = cal.get(Calendar.MONTH) + 1;
int todate = cal.get(Calendar.DATE);
//System.out.println("오늘날짜=======" + toyear + " " + tomonth + " " + todate);

cal.set(Calendar.DATE, 1);	// 그 달의 1일

String syear = request.getParameter("year");
String smonth = request.getParameter("month"); 

int year = cal.get(Calendar.YEAR);		// 처음 들어왔을때
if(DateUtil.nvl(syear) == false){	// 파라미터가 넘어온 경우 
	year = Integer.parseInt(syear);
}

int month = cal.get(Calendar.MONTH) + 1;
if(DateUtil.nvl(smonth) == false){
	month = Integer.parseInt(smonth);
} 

if(month < 1){
	month = 12;
	year--;
}

if(month > 12){
	month = 1;
	year++;
}

cal.set(year, month-1, 1);		// 연월일 세팅

//System.out.println("들어온 날짜=======" + year + " " + month);
// 요일구하기
int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);

/* 
//<		month--
String p = String.format("<img src='image/prec.gif' onclick='pmonth(" + year + "," + (month-1) + ")'>");	
//>		month++	
String n = String.format("<img src='image/prec.gif' onclick='nmonth(" + year + "," + (month+1) + ")'>");	
 */

String action = (String)request.getAttribute("action");
//int num = (int)request.getAttribute("num"); 
//System.out.println(action + " " +num);

// <		month--
String p = String.format("<a href='%syear=%d&month=%d'>"
							+ "<img src='../image/arrow-point-to-left.png'></a>", 
							action, year, month-1);	
// >		month++	
String n = String.format("<a href='%syear=%d&month=%d'>"
							+ "<img src='../image/arrow-point-to-right.png'></a>", 
							action, year, month+1);	
		
%>


<div align="center">

<table>
<col width="100"><col width="100"><col width="100"><col width="100">
<col width="100"><col width="100"><col width="100">

<tr height="30">
	<td colspan="7" align="center">
		<%=p %>&nbsp;&nbsp;
		<font color="black" style="font-size: 25px">
			<%=String.format("%d년&nbsp;%2d월", year, month) %>
		</font>
		&nbsp;&nbsp;<%=n %>
	</td>
</tr>

<tr height="50">
	<th align="center">일</th>
	<th align="center">월</th>
	<th align="center">화</th>
	<th align="center">수</th>
	<th align="center">목</th>
	<th align="center">금</th>
	<th align="center">토</th>
</tr>

<tr height="60" align="left" valign="top">
<%
//위쪽 빈칸
for(int i = 1; i < dayOfWeek; i++){
	%>
	<td>&nbsp;</td>
	<%
}
%>

<%--날짜 --%>
<%
int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
for(int i = 1; i <= lastDay; i++){
	int dow = (i + dayOfWeek - 1) % 7;	
		if(year == toyear && month == tomonth && i == todate){
			%>
			<td class="day<%=i %>" style="vertical-align: top; text-align: left; cursor: pointer; color: #042e6f;" onclick="calselect(<%=year%>, '<%=DateUtil.two(month + "")%>', '<%=DateUtil.two(i + "")%>', <%=dow%>)">	
				<%=i %>	<br> 오늘		
			</td>	
			<%
		}else if(year == toyear && month == tomonth && i < todate){
			%>
			<td class="day" style="vertical-align: top; text-align: left; color: #e4e4e4;">	
				<%=i %>			
			</td>	
			<%
		}else if((year == toyear && month < tomonth) || year < toyear){
			%>
			<td class="day" style="vertical-align: top; text-align: left; color: #e4e4e4;">	
				<%=i %>			
			</td>	
			<%		
		}else{
			%>	
			<td class="day<%=i %>" style="vertical-align: top; text-align: left; cursor: pointer;" onclick="calselect(<%=year%>, '<%=DateUtil.two(month + "")%>', '<%=DateUtil.two(i + "")%>', <%=dow%>)">	
				<%=i %>			
			</td>	
			<%	
		}
		if((i + dayOfWeek - 1) % 7 == 0 && i != lastDay){
			%>
			</tr><tr height="60" align="left" valign="top">
			<%
		}	
}
%>
<%
//아래 빈칸
for(int i = 0; i < (7 - (dayOfWeek + lastDay - 1) % 7) % 7; i++){
	%>
	<td>&nbsp;</td>
	<%
}
%>
</tr>

</table>
</div>

<script type="text/javascript">


</script>






