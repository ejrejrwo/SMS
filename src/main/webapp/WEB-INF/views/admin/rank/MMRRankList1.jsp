<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 

<link rel="stylesheet" href="/css/bootstrap.css">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" />
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>

<style type="text/css">
table{
	border-collapse: collapse;
	text-align: center;
	margin-left: -15px;
}
th{
	background-color: #042E6F;
	color: white;
	padding: 15px;
	text-align: center;
}
td{
	border-bottom: 1px solid #A2AAC1;
	padding: 12px;
	height: 39px;
}

</style>

<meta charset="UTF-8">

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

</head>
<body>

<div class="container" style="width: 250px;">

<!-- RANKING 목록 -->
<form id="_frm1">
<table class="table table-hover table-responsive" style="width: 250px; border: 0;">

<thead>
	<tr>
		<td colspan="3" style="padding: 2px;">
			<input type="image" src="/image/search.png" style="width: 23px; height: 23px; margin-left: 5px; margin-top: 5px; float: right;" onclick="search1()">
			<input type="text" name="keyword" class="form-control" placeholder="TEAM 검색" maxlength="20" style="width: 130px; float: right;">
		</td>
	</tr>
	<tr>
		<th colspan="3">SOCCER <img alt="" src="../image/soccer.png" style="width: 22px; height: 22px;"></th>
	</tr>
	<tr>
		<th style="width: 70px;">RANK</th>
		<th style="width: 110px;">TEAM NAME</th>
		<th style="width: 70px;">MMR</th>
	</tr>
</thead>

<tbody>
	<c:if test="${empty ranklist1 }">
	<tr>
		<td colspan="3" style="text-align: center;">랭킹 목록이 없습니다.</td>
	</tr>
	</c:if>
	
	<c:forEach items="${ranklist1 }" var="rank">
	
		<tr class="_hover_tr">
		<c:choose>
			<c:when test="${rank.ranking == 1}">
				<td><img src="../image/goldmedal.png" style="width: 22px; height: 22px;"></td>
			</c:when>
			<c:when test="${rank.ranking == 2}">
				<td><img src="../image/silvermedal.png" style="width: 22px; height: 22px;"></td>
			</c:when>
			<c:when test="${rank.ranking == 3}">
				<td><img src="../image/bronzemedal.png" style="width: 22px; height: 22px;"></td>
			</c:when>
			<c:otherwise>
				<td><b>${rank.ranking }</b></td>
			</c:otherwise>
		</c:choose>
			<td>${rank.team_name }</td>
			<td>${rank.soccer_mmr }</td>
		</tr>
	
	</c:forEach>
	
	<tr align="center" class="trfoot">
		<td colspan="3">
		<ul class="pagination pagination-sm">
		<c:if test="${gparam.prev }">
			<li class="page-item"><a class="page-link" href="MMRRankList1.do?keyword=${gparam.keyword }&pageNum=${gparam.startPage-1}">prev</a></li>
		</c:if>
		
		<c:forEach begin="${gparam.startPage }" end="${gparam.endPage }" step="1" var="index">
			<c:if test="${gparam.pageNum eq index }">
				<li class="page-item active"><a class="page-link">${index }</a></li>
			</c:if>
			
			<c:if test="${gparam.pageNum ne index }">
				<li class="page-item"><a class="page-link" href="MMRRankList1.do?keyword=${gparam.keyword }&pageNum=${index}">${index}</a></li>
			</c:if>
		</c:forEach>
		
		<c:if test="${gparam.next }">
			<li class="page-item"><a class="page-link" href="MMRRankList1.do?keyword=${gparam.keyword }&pageNum=${gparam.endPage+1}">next</a></li>
		</c:if>
		</ul>
		</td>
	</tr>
</tbody>

</table>
</form>
</div>


<script type="text/javascript">

function search1() {
	$("#_frm1").attr("action", "MMRRankList1.do").submit();
}


</script>


</body>
</html>