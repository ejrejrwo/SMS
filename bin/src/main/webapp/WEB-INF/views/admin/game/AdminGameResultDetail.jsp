<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
table{
	border-bottom: 1px solid #A2AAC1;
	font-size: 20px;
}
th{
	background-color: #f5f5f5;
	font-weight: normal;
	text-align: center;
	border: 1px solid #A2AAC1;
}
td{
	border-bottom: 1px solid #A2AAC1;
	text-align: center;
}

</style>
<meta charset="UTF-8">
<title>경기결과</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

</head>
<body>
<div class="container" style="width: 820px;">
<table class="table table-responsive">
<col width="300"><col width="220"><col width="300">

<tr style="">
	<td colspan="3" style="color: #747474; text-align: left;"># ${game.category }
		<c:if test="${not empty game.league }">
			<c:if test="${fn:length(game.league) < 3}">
				<c:if test="${game.league eq '21' }">
					[결승전]
				</c:if>
				<c:if test="${game.league ne '21' }">
					[${fn:substring(game.league,0,1) }강
					${fn:substring(game.league,1,2) }라운드]
				</c:if>
			</c:if>
			<c:if test="${fn:length(game.league) > 3}">
				[${game.league }리그]
			</c:if>
		</c:if>
	</td>
</tr>

<tr>
	<td style="padding: 20px;" colspan="3">${game.gdate } &nbsp; | &nbsp; ${game.name_stadium }</td>
</tr>

<tr style="background-color: #f5f5f5;">
	<td style="padding: 20px; font-size: 24px;">${game.name_team1 }<br><br>
	<c:choose>
		<c:when test="${empty file1 }">
			<img alt="" src="/image/team.png" style="width: 120px; height: 120px;">
		</c:when>
		<c:otherwise>
			<img alt="" src="/teamimg/${file1 }" style="width: 120px; height: 120px;">
		</c:otherwise>
	</c:choose>
	</td>
	<td style="padding-top: 50px; padding-bottom: 50px;">
	<c:if test="${game.score1 < 100 && game.score2 < 100}">
		<c:if test="${game.game_result == game.name_team1}">
			<p style="font-size: 56px; color: #e60013; display: inline;">${game.score1 }</p><p style="font-size: 56px; display: inline;"> : ${game.score2 }</p>
		</c:if>
		<c:if test="${game.game_result == game.name_team2}">
			<p style="font-size: 56px; display: inline;">${game.score1 } : </p><p style="font-size: 56px; color: #e60013; display: inline;">${game.score2 }</p>
		</c:if>
	</c:if>
	<c:if test="${game.score1 >= 100 || game.score2 >= 100}">
		<c:if test="${game.game_result == game.name_team1}">
				<p style="font-size: 40px; color: #e60013; display: inline;">${game.score1 }</p><p style="font-size: 40px; display: inline;"> : ${game.score2 }</p>
		</c:if>
		<c:if test="${game.game_result == game.name_team2}">
			<p style="font-size: 40px; display: inline;">${game.score1 } : </p><p style="font-size: 40px; color: #e60013; display: inline;">${game.score2 }</p>
		</c:if>
	</c:if>
	</td>
	<td style="padding: 20px; font-size: 24px;">${game.name_team2 }<br><br>
	<c:choose>
		<c:when test="${empty file2 }">
			<img alt="" src="/image/team.png" style="width: 120px; height: 120px;">
		</c:when>
		<c:otherwise>
			<img alt="" src="/teamimg/${file2 }" style="width: 120px; height: 120px;">
		</c:otherwise>
	</c:choose>
	</td>
</tr>

<tr>
	<td style="padding: 20px;"><fmt:formatNumber value="${total_money1 }" pattern="#,###"/>원 </td>
	<th style="padding: 20px;">총 베팅 금액</th>
	<td style="padding: 20px;"><fmt:formatNumber value="${total_money2 }" pattern="#,###"/>원</td>
</tr>

<tr>	
	<td style="padding: 20px;">${mmr1 }</td>
	<th style="padding: 20px;">MMR</th>
	<td style="padding: 20px;">${mmr2 }</td>
</tr>

<tr>
	<td style="padding: 20px;">${game.payout_r1 }</td>
	<th style="padding: 20px;">배당률</th>
	<td style="padding: 20px;">${game.payout_r2 }</td>
</tr>

</table>

<input type="button" id="listBtn" class="btn btn-primary" value="목록으로">
</div>
<br>


<script type="text/javascript">
$(document).ready(function(){
	
	$("#listBtn").click(function() {
		location.href = "gameResultAdmin.do";
	});
	
});


</script>


</body>
</html>