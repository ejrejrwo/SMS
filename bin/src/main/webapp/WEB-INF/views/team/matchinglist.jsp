<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>  
<sec:authentication var="user" property="principal" />
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	table{
	border-collapse: collapse;
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
}
#jb-container {
	width: 1200px;
	margin: 0px auto;
	padding: 20px;
	
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div id="jb-container">
<form action="" name="frmForm2" id="_frmFormSearch2" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<table class="table table-hover table-responsive">
<colgroup>
	<col width="30px"><col width="80px"><col width="50px">
	<col width="30px"><col width="30px"><col width="80px">
	<col width="60px">
</colgroup>

<thead>
	<tr>
		<th>
			<select id="_sport" name="sport" onchange="chageSelectedValue()" style="background-color: #042e6f; font-weight: 600; font-size: 14px; border: none; outline: none; cursor: pointer;">
				<option value=""<c:if test="${empty sport }">selected='selected'</c:if>>모든종목</option>
				<option value="축구" <c:if test="${sport == '축구'}">selected='selected'</c:if> >축구</option>
				<option value="야구" <c:if test="${sport == '야구'}">selected='selected'</c:if>>야구</option>
				<option value="농구" <c:if test="${sport == '농구'}">selected='selected'</c:if>>농구</option>
				<option value="탁구" <c:if test="${sport == '탁구'}">selected='selected'</c:if>>탁구</option>	
				<option value="배드민턴" <c:if test="${sport == '배드민턴'}">selected='selected'</c:if>>배드민턴</option>				
			</select>
		</th>
		<th>제목</th><th>경기장</th>
		<th>
			<select id="_league" name="league" onchange="chageSelectedValue()" style="background-color: #042e6f; font-weight: 600; font-size: 14px; border: none; outline: none; cursor: pointer;">
				<option value=""<c:if test="${empty league }">selected='selected'</c:if>>경기</option>
				<option value="일반게임" <c:if test="${league == '일반게임'}">selected='selected'</c:if>>일반게임</option>
				<option value="리그경기" <c:if test="${league == '리그경기'}">selected='selected'</c:if>>리그경기</option>				
			</select>
		</th>
		<th>날짜</th>
		<th>
		<select id="_game_result" name="game_result" onchange="chageSelectedValue()" style="background-color: #042e6f; font-weight: 600; font-size: 14px; border: none; outline: none; cursor: pointer;">
			<option value=""<c:if test="${empty game_result }">selected='selected'</c:if>>모든경기</option>
			<option value="승리한경기" <c:if test="${game_result == '승리한경기'}">selected='selected'</c:if>>승리한경기</option>
			<option value="패배한경기" <c:if test="${game_result == '패배한경기'}">selected='selected'</c:if>>패배한경기</option>
			<option value="경기전" <c:if test="${game_result == '경기전'}">selected='selected'</c:if>>경기전</option>				
		</select>
		</th>
		<th>확인</th>
	</tr>
	</thead>
	<c:if test="${empty gamelist }">
		<tbody>
		<tr>
			<td colspan="8">작성된 글이 없습니다</td>
		</tr>
		</tbody>
	</c:if>
	<c:forEach items="${gamelist }" var="game" varStatus="vs">
	<tbody>
	<tr height="50px;">
		<td>
			<c:if test="${game.category == '축구'}"><img alt="" src="../image/soccer.png" style="width: 22px; height: 22px;"></c:if>
			<c:if test="${game.category == '농구'}"><img alt="" src="../image/basketball.png" style="width: 22px; height: 22px;"></c:if>
			<c:if test="${game.category == '야구'}"><img alt="" src="../image/baseball.png" style="width: 22px; height: 22px;"></c:if>
			<c:if test="${game.category == '배드민턴'}"><img alt="" src="../image/badminton.png" style="width: 22px; height: 22px;"></c:if>
			<c:if test="${game.category == '탁구'}"><img alt="" src="../image/ping-pong.png" style="width: 22px; height: 22px;"></c:if>
		</td>
		<td>
		<c:choose>
			<c:when test="${fn:length(game.title) gt 10 }">
			${fn:substring(game.title,0,9) }...
			</c:when>
			<c:otherwise>
			${game.title }
			</c:otherwise>						
		</c:choose>
		</td>
		<td>${game.name_stadium }</td>  
		<td>
			<c:if test="${empty game.league }">일반게임</c:if>
			<c:if test="${not empty game.league }">리그게임</c:if>
		</td>
		<td><fmt:formatDate value="${game.wdate }" pattern="yyyy-MM-dd"/></td>
		
			<c:if test="${empty game.name_team2 }">
			<td>경기상대구하는중 </td>
			<td>
			<c:if test="${teamgameparam.check eq 1 }">
			<sec:authorize access="hasRole('ROLE_TEAMLEADER')">
			<a href="getmatchinglist.do?seq_game=${game.seq_game }" onclick="window.open(this.href, '_blank', 'width=550px,height=500px,toolbars=no,scrollbars=no'); return false;">신청메세지보기</a>
			</sec:authorize>
			</c:if>
			<c:if test="${teamgameparam.check eq 0 }">
			<sec:authorize access="!hasRole('ROLE_TEAMLEADER')">
			대기중
			</sec:authorize>
			</c:if>
			

			</td>
			
			</c:if>
			<c:if test="${not empty game.name_team2 }">
				<c:if test="${empty game.game_result }">
					<td>
						경기 성사 완료
						<input type="hidden" id="_name_team2" value="${game.name_team2 }">
						<input type="hidden" id="_name_team1" value="${game.name_team1 }">
						<input type="hidden" id="_id" value="${user.username }">
					</td>
					<td><button type="button" id="_stateBtn" game_seq="${game.seq_game }" class="btn btn-primary">현황</button></td>
					
				</c:if>
				<c:if test="${not empty game.game_result }">
				
					<td>경기 끝
					<c:choose>
					<c:when test="${team_name eq game.game_result }">
					승
					</c:when>
					<c:otherwise>
					패
					</c:otherwise>
					</c:choose></td>
					<td>
					<button type="button" id="_resultBtn" game_seq="${game.seq_game }" class="btn btn-danger">경기결과</button>
					</td>
				</c:if>
			</c:if>
	</tr>
	</tbody>
	</c:forEach>
</table>
	<div id="paging_wrap">
	<jsp:include page="include/paging.jsp" flush="false">
		<jsp:param name="pageNumber" value="${pageNumber }" />
		<jsp:param name="totalRecordCount" value="${totalRecordCount }" />
		<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }" />
		<jsp:param name="recordCountPerPage" value="${recordCountPerPage }" />	
	</jsp:include>
	</div>
<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber }">
<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage)?0:recordCountPerPage }">
<input type="hidden" name="name_team1" id="_name_team1" value="${team_name }">
<input type="hidden" name="check" id="_check" value="${teamgameparam.check }">
</form>
</div>

<script type="text/javascript">
$(document).ready(function () {
	
	//alert($("#_check").val());
	
	if($("#_check").val() == 0){
		$("#menu3").css("background-color", "#e60013");	
	}else{
		$("#menu1").css("background-color", "#e60013");	
	}
	
	
	$(document).on("click", "#_stateBtn", function () {
		var seq = $(this).attr("game_seq");
		var name_team1 = $("#_name_team1").val();
		var name_team2 = $("#_name_team2").val();
		var id = $("#_id").val();
		location.href="matstate.do?seq_game=" + seq +"&name_team1=" + name_team1 +
				"&name_team2=" + name_team2 + "&id=" + id;
	});

	
	$(document).on("click", "#_resultBtn", function () {
		var seq = $(this).attr("game_seq");
		location.href="../common/gameResultDetail.do?seq_game=" + seq;
	});
});

function goPage( pageNumber ) {
	$("#_pageNumber").val(pageNumber);
	$("#_frmFormSearch2").attr("action", "matchinglist.do").submit();
}

function chageSelectedValue(){
    var sport = document.getElementById("_sport").value;
    var league = document.getElementById("_league").value;
    var game_result = document.getElementById("_game_result").value;
    $("#_frmFormSearch2").attr("action", "matchinglist.do").submit();
}




</script>

</body>
</html>