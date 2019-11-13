<%@page import="com.boot.finalpro.game.model.GameParam"%>
<%@page import="com.boot.finalpro.game.model.GameDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<style type="text/css">

th{
	text-align: center;
	background-color: #042e6f;
	color: #fff;
}

h3{
	color: black;
    font-size: 35px;
    text-align: center;
    padding-bottom: 50px;
    font-weight: 400;
}
</style>


</head>
<body>

<div id="_top">
	경기매칭목록
</div>

<div class="container" style="width: 1200px">
	<c:if test="${auth.authority eq 'ROLE_TEAMLEADER'}"	>
		<div style="text-align: right;">		
			<button type="button" id="gBtn" class="btn btn-default">경기매칭신청</button>
		</div>
	</c:if>
		
	<table class="table table-bordered">
	<col width="50"><col width="100"><col width="400"><col width="100"><col width="180"><col width="100"><col width="150"><col width="60">
	
	<tr>
		<th>번호</th>
		
		<th>
			<select id="choice" name="category" onchange="cat()" style="background-color: #042e6f; font-weight: 600; font-size: 14px; border: none; outline: none; cursor: pointer;">
				<option value="">종목</option>
				<option value="축구" <c:if test="${paging.keyword == '축구'}">selected='selected'</c:if> >축구</option>
				<option value="야구" <c:if test="${paging.keyword == '야구'}">selected='selected'</c:if>>야구</option>
				<option value="농구" <c:if test="${paging.keyword == '농구'}">selected='selected'</c:if>>농구</option>
				<option value="탁구" <c:if test="${paging.keyword == '탁구'}">selected='selected'</c:if>>탁구</option>	
				<option value="배드민턴" <c:if test="${paging.keyword == '배드민턴'}">selected='selected'</c:if>>배드민턴</option>				
			</select>	
		</th>
		
		<th>제목</th>
		<th>
			<select id="stadium" name="name_stadium" onchange="stadium()" style="background-color: #042e6f; font-weight: 600; font-size: 14px; border: none; outline: none; cursor: pointer;">
				<option value="">지역</option>
				<option value="잠실" <c:if test="${paging.keyword == '잠실'}">selected='selected'</c:if> >잠실</option>
				<option value="한밭" <c:if test="${paging.keyword == '한밭'}">selected='selected'</c:if>>한밭</option>
				<option value="부산" <c:if test="${paging.keyword == '부산'}">selected='selected'</c:if>>부산</option>
				<option value="광주" <c:if test="${paging.keyword == '광주'}">selected='selected'</c:if>>광주</option>	
				<option value="강릉" <c:if test="${paging.keyword == '강릉'}">selected='selected'</c:if>>강릉</option>				
			</select>	
		</th>
		
		<th onclick="sortingDate()" style="cursor: pointer;">경기일</th>
		<th>팀</th><th>작성일</th><th>조회수</th>		
	</tr>

		<c:if test="${empty gamelist }">
			<tr>
				<td colspan="8">작성된 글이 없습니다</td>
			</tr>
		</c:if>
	
		
		<c:forEach items="${gamelist }" var="g" varStatus="i"> 
			<c:set var="n" value="${g.name_stadium }"/>
			<c:if test="${g.del eq 0 }">
				<tr>
					<td>${g.seq_game}</td>
					<td style="text-align: center;">
						<c:if test="${g.category == '축구'}"><img alt="" src="../image/soccer.png" style="width: 22px; height: 22px;"></c:if>
						<c:if test="${g.category == '농구'}"><img alt="" src="../image/basketball.png" style="width: 22px; height: 22px;"></c:if>
						<c:if test="${g.category == '야구'}"><img alt="" src="../image/baseball.png" style="width: 22px; height: 22px;"></c:if>
						<c:if test="${g.category == '배드민턴'}"><img alt="" src="../image/badminton.png" style="width: 22px; height: 22px;"></c:if>
						<c:if test="${g.category == '탁구'}"><img alt="" src="../image/ping-pong.png" style="width: 22px; height: 22px;"></c:if>
					</td>	
					
					<td onclick="gameDetail(${g.seq_game})" style="cursor: pointer;">${g.title }</td>
					
					<td>${fn:substring(n,0,2)}</td>
					<td>${g.gdate }</td>
					<td>
						<a href="../mypage/teamdetail.do?team_name=${g.name_team1 }">${g.name_team1 }</a>
					</td>
					<td><fmt:formatDate value="${g.wdate }" pattern="yyyy-MM-dd kk:mm"/></td>
					<td rowspan="1" id="${i.count}">${g.read_count }</td>	
				</tr>
			
			</c:if>
		</c:forEach> 
	
	</table>
</div>

	<form action="" name="frmForm1" id="_frmFormSearch" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		
		<!-- 페이징 -->
		<div style="margin-bottom: 10px;">
			<ul class="pagination">
				<c:if test="${paging.prev}">
					<li class="page-item"><a class="page-link" style="color: black;" href="${action}?page=${paging.beginPage-1}&choice=${paging.choice}&keyword=${paging.keyword}&sorting=${paging.sorting}">prev</a></li>
				</c:if>
				
				<c:forEach begin="${paging.beginPage}" end="${paging.endPage}" step="1" var="index">
					<c:choose>
						<c:when test="${paging.nowpage==index}">
							<li class="page-item active"><a class="page-link">${index}<span class="sr-only">(current)</span></a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" style="color: black;" 
									href="${action}?page=${index}&choice=${paging.choice}&keyword=${paging.keyword}&sorting=${paging.sorting}">${index}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<c:if test="${paging.next}">
					<li class="page-item"><a class="page-link" style="color: black;" href="${action}?page=${paging.endPage+1}&choice=${paging.choice}&keyword=${paging.keyword}&sorting=${paging.sorting}">next</a></li>
				</c:if>
			</ul>
		</div>
	
		<!-- 검색 -->
		<div class="container" style="width: 450px;">
			<select name="choice" class="form-control" style="width: 100px; float: left;">
				<option value="">선택</option>
				<option value="title" <c:if test="${paging.choice == 'title'}">selected='selected'</c:if>>제목</option>
				<option value="name_team1" <c:if test="${paging.choice == 'name_team1'}">selected='selected'</c:if>>팀명</option>	
			</select>
			<input type="text" id="keyword" name="keyword" class="form-control" style="width: 200px; float: left;"
						<c:if test="${paging.choice ne 'category' }">value='${paging.keyword }'</c:if>>	
			
			<button type="button" id="searchBtn" style="float: left;" class="btn btn-default">검색</button>
		</div>
			
	</form>




<script type="text/javascript">
$(document).ready(function () {	
	$("#menu1").css("background-color","#e60013");
	
	
	$("#searchBtn").click(function () {
		$("#_frmFormSearch").attr("action", "gamelist.do").submit();
	});

	$("#gBtn").click(function () {
		location.href="gamemake.do"		
	});
	
	$("#delete_btn").click(function () {
		var seq_game = $("#seq_game").val();		
		location.href="gamedelete.do?seq_game=" + seq_game;			
	});
	
});


// category선택시 검색
function cat() {
	var keyword = $("#choice option:selected").val();
//	alert(keyword);
	location.href="gamelist.do?choice=category&keyword=" + keyword;
}

function stadium() {
	var keyword = $("#stadium option:selected").val();
//	alert(keyword);
	
	location.href="gamelist.do?choice=name_stadium&keyword=" + keyword;
}


function sortingDate() {
	location.href="gamelist.do?sorting=1";						
} 

function gameDetail(seq_game) {		
//	alert(seq_game);

	location.href="gamedetail.do?seq_game="+seq_game;
}
		

</script>

</body>
</html>










