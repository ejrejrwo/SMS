<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%

Calendar cal = Calendar.getInstance();

int nyear = cal.get(Calendar.YEAR);

int year = (Integer)request.getAttribute("year");
int month = (Integer)request.getAttribute("month");

%>
<style type="text/css">

#leaguetable_user{
	margin-left: auto;
	margin-right: auto;
	width: 80%;
}

#leaguetable_user2{
	margin-left: auto;
	margin-right: auto;
	width: 80%;
	height: 600px;
	/* border: 1px solid; */
	margin-top: 10px;
	border-collapse: separate;
	border-spacing: inherit;
	table-layout: fixed;
}

#leaguetable_user2 th, #leaguetable_user2 td{
	/* border: 1px solid; */
	padding: 1px;
}

/* 
.leaguebox{
	border-collapse: separate;
	border-spacing: inherit;
	border: 1px solid;
}
  */
.leagueline{
	/* border-collapse: separate;
	border-spacing: inherit; */
	border-left: 1px solid;
	border-right: 1px solid;
	border-top: 1px solid;
}

.leagueline2{
	/* border-collapse: separate;
	border-spacing: inherit; */
	border-right: 1px solid;
}
 
</style>

<form action="userleaguepage.do" method="get">
	<table id="leaguetable_user">
		<tr>
			<td class="leaguebox">
				시즌리그
				<select name="year" id="year">
					
				<%
					for(int i=nyear-5; i<=nyear; i++){
						%>
						<option <%=(year+"").equals(i+"")? "selected='selected'":"" %> value="<%=i%>"><%=i%></option>
						<%
						
					}
				%>
				</select>년
				<select name="month" id="month">
					
				<%
					for(int i=1; i<13; i++){
						%>
						<option <%=(month+"").equals(i+"")? "selected='selected'":"" %> value="<%=i%>"><%=i%></option>
						<%
					}
				%>
				</select>월
				
				<button type="submit">검색</button>
				
			</td>
		</tr>
		<tr>
			<td class="leaguebox">대진표</td>
		</tr>
		
	</table>
	<table id="leaguetable_user2">
		<tr>
			<td colspan="14"></td>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[6].game_result }">
					${leaguelist[6].game_result }
				</c:if>
			</td>
			<td colspan="14"></td>
		</tr>
		<tr>
			<td colspan="15" class="leagueline2"></td>
			<td colspan="15"></td>
		</tr>
		<tr>
			<td colspan="7"></td>
			<td colspan="16" class="leagueline">
				<c:if test="${not empty leaguelist[6].gdate }">
					${leaguelist[6].gdate }<br>
				</c:if>
				<c:if test="${not empty leaguelist[6].name_stadium }">
					${leaguelist[6].name_stadium }
				</c:if>
			</td>
			<td colspan="7"></td>
		</tr>
		<tr>
			<td colspan="6"></td>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[6].name_team1 }">
					${leaguelist[6].name_team1 }
				</c:if>
			</td>
			<td colspan="14"></td>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[6].name_team2 }">
					${leaguelist[6].name_team2 }
				</c:if>
			</td>
			<td colspan="6"></td>
		</tr>
		<tr>
			<td colspan="7" class="leagueline2"></td>
			<td colspan="16" class="leagueline2"></td>
			<td colspan="7"></td>
		</tr>
		<tr>
			<td colspan="3"></td>
			<td colspan="8" class="leagueline">
				<c:if test="${not empty leaguelist[4].gdate }">
					${leaguelist[4].gdate }<br>
				</c:if>
				<c:if test="${not empty leaguelist[4].name_stadium }">
					${leaguelist[4].name_stadium }
				</c:if>
			</td>
			<td colspan="8"></td>
			<td colspan="8" class="leagueline">
				<c:if test="${not empty leaguelist[5].gdate }">
					${leaguelist[5].gdate }<br>
				</c:if>
				<c:if test="${not empty leaguelist[5].name_stadium }">
					${leaguelist[5].name_stadium }
				</c:if>
			</td>
			<td colspan="3"></td>
		</tr>
		<tr>
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[4].name_team1 }">
					${leaguelist[4].name_team1 }
				</c:if>
			</td>
			<td colspan="6"></td>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[4].name_team2 }">
					${leaguelist[4].name_team2 }
				</c:if>
			</td>
			<td colspan="6"></td>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[5].name_team1 }">
					${leaguelist[5].name_team1 }
				</c:if>
			</td>
		 	<td colspan="6"></td>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[5].name_team2 }">
					${leaguelist[5].name_team2 }
				</c:if>
			</td>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td colspan="3" class="leagueline2"></td>
			<td colspan="8" class="leagueline2"></td>
			<td colspan="8" class="leagueline2"></td>
			<td colspan="8" class="leagueline2"></td>
			<td colspan="3"></td>
		</tr>
		<tr>
			<td></td>
			<td colspan="4" class="leagueline">
				<c:if test="${not empty leaguelist[0].gdate }">
					${leaguelist[0].gdate }<br>
				</c:if>
				<c:if test="${not empty leaguelist[0].name_stadium }">
					${leaguelist[0].name_stadium }
				</c:if>
			</td>
			<td colspan="4"></td>
			<td colspan="4" class="leagueline">
				<c:if test="${not empty leaguelist[1].gdate }">
					${leaguelist[1].gdate }<br>
				</c:if>
				<c:if test="${not empty leaguelist[1].name_stadium }">
					${leaguelist[1].name_stadium }
				</c:if>
			</td>
			<td colspan="4"></td>
			<td colspan="4" class="leagueline">
				<c:if test="${not empty leaguelist[2].gdate }">
					${leaguelist[2].gdate }<br>
				</c:if>
				<c:if test="${not empty leaguelist[2].name_stadium }">
					${leaguelist[2].name_stadium }
				</c:if>
			</td>
			<td colspan="4"></td>
			<td colspan="4" class="leagueline">
				<c:if test="${not empty leaguelist[3].gdate }">
					${leaguelist[3].gdate }<br>
				</c:if>
				<c:if test="${not empty leaguelist[3].name_stadium }">
					${leaguelist[3].name_stadium }
				</c:if>
			</td>
			<td></td>
		</tr>
		<tr>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[0].name_team1 }">
					${leaguelist[0].name_team1 }
				</c:if>
			</td>
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[0].name_team2 }">
					${leaguelist[0].name_team2 }
				</c:if>
			</td>
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[1].name_team1 }">
					${leaguelist[1].name_team1 }
				</c:if>
			</td>
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[1].name_team2 }">
					${leaguelist[1].name_team2 }
				</c:if>
			</td>
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[2].name_team1 }">
					${leaguelist[2].name_team1 }
				</c:if>
			</td>
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[2].name_team2 }">
					${leaguelist[2].name_team2 }
				</c:if>
			</td>
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[3].name_team1 }">
					${leaguelist[3].name_team1 }
				</c:if>
			</td>
			
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<c:if test="${not empty leaguelist[3].name_team2 }">
					${leaguelist[3].name_team2 }
				</c:if>
			</td>
		</tr>
		<%-- 
		<tr>
			<td></td>
			<td colspan="4">
				<c:if test="${not empty leaguelist[0].gdate }">
					${leaguelist[0].gdate }
				</c:if>
			</td>
			<td colspan="4"></td>
			<td colspan="4">
				<c:if test="${not empty leaguelist[1].gdate }">
					${leaguelist[1].gdate }
				</c:if>
			</td>
			<td colspan="4"></td>
			<td colspan="4">
				<c:if test="${not empty leaguelist[2].gdate }">
					${leaguelist[2].gdate }
				</c:if>
			</td>
			<td colspan="4"></td>
			<td colspan="4">
				<c:if test="${not empty leaguelist[3].gdate }">
					${leaguelist[3].gdate }
				</c:if>
			</td>
			<td></td>
		</tr>
		 --%>
	</table>
</form>

<script type="text/javascript">

$("#menu2").css("background-color","#e60013");

</script>

