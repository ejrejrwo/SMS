<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
table{
	border-collapse: collapse;
	font-size: 16px;
}
th{
	text-align: center;
}
td{
	border-bottom: 1px solid #A2AAC1;
	text-align: center;
	height: 51px;
}


</style>
<meta charset="UTF-8">
<title>경기 결과 등록</title>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<style type="text/css">
/* Modal Css */
.modal{
	display: none;		/* Hidden by default */
	position: fixed;	/* Stay in place */
	z-index: 100;			/* Sit on top */
	left: 0;
	top: 0;
	width: 100%;		/* Full width */
	height: 100%;		/* Full height */
	overflow: hidden;	/* Enable scroll if needed */
	background-color: rgb(0,0,0);		/* Fallback color */
	background-color: rgba(0,0,0,0.4);	/* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content{
	background-color: #fefefe;
	margin: 10% auto;	/* 10% from the top and centered */
	padding: 50px;
	border: 1px solid #888;
	width: 550px;			/* Could be more or less, depending on screen size */
}

.modaltable{
	border-bottom: 1px solid #A2AAC1;
	/* font-size: 20px; */
}
.modaltable th{
	background-color: #f5f5f5;
	font-weight: normal;
	text-align: center;
	border-top: 1px solid #A2AAC1;
	border-bottom: 1px solid #A2AAC1;
	
}
.modaltable td{
	border-top: 1px solid #A2AAC1;
	border-bottom: 1px solid #A2AAC1;
}


/* The Close Button */
.close{
	color: #042E6F;
	float: right;
	text-align: right;
	font-size: 28px;
	font-weight: bold;
}
.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}


</style>

</head>
<body>

<div class="container" style="width: 1200px;">
<!-- 글목록 -->
<form id="_frm">
<!-- security -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<table class="table table-hover table-responsive" style="width: 1170px;">

<thead>
	<tr>
		<td colspan="6">
			<select id="sort" name="sort" onchange="sortList()" class="form-control" style="width: 170px; float: right;">
				<option value="0">정렬</option>
				<option value="4" <c:if test="${gparam.sorting == 4}">selected='selected'</c:if>>결과 미등록순</option>
				<option value="1" <c:if test="${gparam.sorting == 1}">selected='selected'</c:if>>경기일 최근순</option>
				<option value="2" <c:if test="${gparam.sorting == 2}">selected='selected'</c:if>>경기일 오래된순</option>
				<option value="3" <c:if test="${gparam.sorting == 3}">selected='selected'</c:if>>토너먼트만</option>
			</select>
		</td>
	</tr>
	<tr>
		<th style="width: 100px;">번호</th>
		<th style="width: 130px;">종목</th>
		<th style="width: 410px;">경기명</th>
		<th style="width: 180px;">경기장</th>
		<th style="width: 200px;">경기일</th>
		<th style="width: 150px;">결과 등록 여부</th>
	</tr>
</thead>

<tbody>
	<c:if test="${empty gamelist }">
	<tr>
		<td colspan="6" style="text-align: center;">경기 결과 목록이 없습니다.</td>
	</tr>
	</c:if>
	
	<c:forEach items="${gamelist }" var="game" varStatus="vs">	<!-- 시작 : 1 -->
	
	<tr class="_hover_tr">
	<c:if test="${game.del eq 0 }">
		<td>${game.seq_game }</td>
		<td>
			<c:if test="${game.category == '축구'}"><img alt="" src="../image/soccer.png" style="width: 22px; height: 22px;"></c:if>
			<c:if test="${game.category == '농구'}"><img alt="" src="../image/basketball.png" style="width: 22px; height: 22px;"></c:if>
			<c:if test="${game.category == '야구'}"><img alt="" src="../image/baseball.png" style="width: 22px; height: 22px;"></c:if>
			<c:if test="${game.category == '배드민턴'}"><img alt="" src="../image/badminton.png" style="width: 22px; height: 22px;"></c:if>
			<c:if test="${game.category == '탁구'}"><img alt="" src="../image/ping-pong.png" style="width: 22px; height: 22px;"></c:if>
		</td>
		<td style="text-align: left;">
		<c:if test="${empty game.game_result }">
			${game.name_team1 } VS. ${game.name_team2 }
			
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
			
		</c:if>
		
		<c:if test="${not empty game.game_result }">	
			<a href="AdminGameResultDetail.do?seq_game=${game.seq_game }" style="text-decoration: none;">${game.name_team1 } VS. ${game.name_team2 }</a>
			
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
			
		</c:if>
		</td>
		<td>${game.name_stadium }</td>
		<td>${game.gdate }</td>
		<td>
			<c:if test="${empty game.game_result }">
				<input type="button" class="btn btn-primary btn-sm" value="결과 등록하기" onclick="resultAdmin(${game.seq_game}, '${game.category }', '${game.name_team1 }', '${game.name_team2 }', '${game.gdate }', '${game.name_stadium }', '${game.league }')">
				<input type="hidden" id="seq_game" name="seq_game" value="">
				<input type="hidden" name="game_result" value="">
				<input type="hidden" name="name_team1" value="">
				<input type="hidden" name="name_team2" value="">
				<input type="hidden" name="category" value="">
				<input type="hidden" name="league" value="">
			</c:if>
			<c:if test="${not empty game.game_result }">
				등록 완료
			</c:if>
			
			<!-- Modal -->
			<div id="detail-modal" class="modal">
				<div class="modal-content">
					<span class="close">&times;</span>
					<h3 id="title">경기 결과 입력</h3>
					
					<table class="modaltable">
						<col width="130px"><col width="160px"><col width="130px"><col width="120px">
						<tr>
							<th>경기명</th>
							<td colspan="3" id="_name_team"></td>
						</tr>
						
						<tr>
							<th>경기 종목</th>
							<td colspan="3" id="_category"></td>
						</tr>
						
						<tr>
							<th>경기일</th>
							<td colspan="3" id="_gdate"></td>
						</tr>
						
						<tr>
							<th>경기장</th>
							<td colspan="3" id="_name_stadium"></td>
						</tr>
						
						<tr>
							<th style="padding: 20px;">TEAM 1</th>
							<td id="_name_team1" style="padding: 20px;"></td>
							<th style="padding: 20px;">SCORE 1</th>
							<td><input type="text" id="score1" name="score1" class="form-control input-sm" size="6px;" maxlength="3" style="text-align: center;" onkeypress="return fn_press(event,'numbers')" onkeyup="removeChar(event)" onblur="removeChar(event)"></td>
						</tr>
							
						<tr>	
							<th style="padding: 20px;">TEAM 2</th>
							<td id="_name_team2" style="padding: 20px;"></td>
							<th style="padding: 20px;">SCORE 2</th>
							<td><input type="text" id="score2" name="score2" class="form-control" size="6px;" maxlength="3" style="text-align: center;" onkeypress="return fn_press(event,'numbers')" onkeyup="removeChar(event)" onblur="removeChar(event)"></td>
						</tr>
					
					</table>
					<br>
					<input type="button" id="submitBtn" class="btn btn-primary" value="결과 등록">
				</div>
		
			</div>
			
		</td>
	</c:if>
	</tr>
	
	</c:forEach>
	
	<tr align="center" class="trfoot">
		<td colspan="6">
		<ul class="pagination pagination-sm">
		<c:if test="${gparam.prev }">
			<li class="page-item"><a class="page-link" href="gameResultAdmin.do?choice=${gparam.choice}&keyword=${gparam.keyword}&pageNum=${gparam.startPage-1}&sorting=${gparam.sorting}">prev</a></li>
		</c:if>
		
		<c:forEach begin="${gparam.startPage }" end="${gparam.endPage }" step="1" var="index">
			<c:if test="${gparam.pageNum eq index }">
				<li class="page-item active"><a class="page-link">${index }</a></li>
			</c:if>
			
			<c:if test="${gparam.pageNum ne index }">
				<li class="page-item"><a class="page-link" href="gameResultAdmin.do?choice=${gparam.choice}&keyword=${gparam.keyword}&pageNum=${index}&sorting=${gparam.sorting}">${index}</a></li>
			</c:if>
		</c:forEach>
		
		<c:if test="${gparam.next }">
			<li class="page-item"><a class="page-link" href="gameResultAdmin.do?choice=${gparam.choice}&keyword=${gparam.keyword}&pageNum=${gparam.endPage+1}&sorting=${gparam.sorting}">next</a></li>
		</c:if>
		</ul>
		</td>
	</tr>
	
	<tr align="center" class="trfoot">
		<td colspan="6">
		<div class="container" style="width: 386px;"> 
			<select id="choice" name="choice" class="form-control" style="width: 130px; float: left;" onchange="func1()">
				<option value="선택">선택</option>
				<option value="category" <c:if test="${gparam.choice == 'category'}">selected='selected'</c:if>>경기 종목</option>
				<option value="team_name" <c:if test="${gparam.choice == 'team_name'}">selected='selected'</c:if>>팀명</option>
			</select>

			<input type="text" id="str" name="keyword" class="form-control" placeholder="검색" maxlength="30" style="width: 150px; float: left;" value="${gparam.keyword }">
			<select id="choice2" name="choice2" class="form-control" style="width: 150px; float: left; display: none;">
				<option value="선택">종목 선택</option>
				<option value="축구" <c:if test="${gparam.keyword == '축구'}">selected='selected'</c:if>>축구</option>
				<option value="농구" <c:if test="${gparam.keyword == '농구'}">selected='selected'</c:if>>농구</option>
				<option value="야구" <c:if test="${gparam.keyword == '야구'}">selected='selected'</c:if>>야구</option>
				<option value="배드민턴" <c:if test="${gparam.keyword == '배드민턴'}">selected='selected'</c:if>>배드민턴</option>
				<option value="탁구" <c:if test="${gparam.keyword == '탁구'}">selected='selected'</c:if>>탁구</option>
			</select>
			<!-- <input type="hidden" name="keyword" value=""> -->
			<input type="button" id="searchBtn" class="btn btn-primary" style="float: left;" value="검색">
		</div>
		</td>
	</tr>

</tbody>


</table>

</form>
</div>


<script type="text/javascript">
$(document).ready(function(){
	$("#menu5").css("background-color","#e60013");
	
	if(${gparam.choice == 'team_name'}){
		$("#choice2").css("display", "none");
		$("#str").css("display", "");
	}
	else if(${gparam.choice == 'category'}){
		$("#str").css("display", "none");
		$("#choice2").css("display", "");
	}
	
	$("#searchBtn").click(function() {
		if($("#choice").val() == "category"){
			if($("#choice2").val() == "선택"){
				alert("경기 종목을 선택해주십시오.");
				return;
			}
			else{
				$('input:hidden[name=keyword]').val($("#choice2").val());
			}
		}
		
		else if($("#choice").val() == "team_name"){
			if($("#str").val().trim() == ""){
				alert("팀명을 입력해주십시오.");
				return;
			}
			else{
		//		$('input:hidden[name=keyword]').val($("#str").val().trim());
			}
		}
		$("#_frm").attr("action", "gameResultAdmin.do").submit();
	});
	
	$("#submitBtn").click(function() {
	//	alert($('input:hidden[name=seq_game]').val());
		var score1 = $("#score1").val();
		var score2 = $("#score2").val();
	//	alert("s1:" + score1 + " s2:" + score2); 
		
		if(parseInt(score1) == parseInt(score2)){
			alert("무승부는 입력할 수 없습니다.\nSCORE를 다시 입력해주십시오.");
			return;
		}
		else if(parseInt(score1) > parseInt(score2)){
		//	alert("team1 이김");
			$('input:hidden[name=game_result]').val($("#_name_team1").text());
		}
		else if(parseInt(score1) < parseInt(score2)){
		//	alert("team2 이김");
			$('input:hidden[name=game_result]').val($("#_name_team2").text());
		}
		else if(score1 == "" || score2 == ""){
			alert("SCORE를 모두 입력해주십시오.");
			return;
		}
		var seq_game = $('input:hidden[name=seq_game]').val();
		var category = $('input:hidden[name=category]').val();
		var name_team1 = $('input:hidden[name=name_team1]').val();
		var name_team2 = $('input:hidden[name=name_team2]').val();
		var game_result = $('input:hidden[name=game_result]').val();
		var league = $('input:hidden[name=league]').val();
	//	alert("seq_game=" + seq_game + "&category=" + category + "&name_team1=" + name_team1 + "&name_team2=" + name_team2 + "&score1=" + score1 + "&score2=" + score2 + "&game_result=" + game_result);
		
		if(confirm("[경기 결과] " + score1 + " : " + score2 + " \n결과를 등록하시겠습니까?")){
				alert("결과 등록이 완료되었습니다.");
				$(".modal").css("display", "none");
			//	$("#_frm").attr("action", "gameResultAdminAf.do").submit();
				location.href = "gameResultAdminAf.do?seq_game=" + seq_game + "&category=" + category + "&name_team1=" + name_team1 + "&name_team2=" + name_team2 + "&score1=" + score1 + "&score2=" + score2 + "&game_result=" + game_result + "&league=" + league;
		}
		else{
			return;
		}

	});
	
	$(".close").on("click", function(){
		$("#score1").val("");
		$("#score2").val("");
		$(".modal").css("display", "none");
	})
	
});

function resultAdmin(seq_game, category, name_team1, name_team2, gdate, name_stadium, league) {
	$("#seq_game").val(seq_game);
	
	$("#_category").text(category);
	$('input:hidden[name=category]').val(category);
	
	$("#_name_team").text(name_team1 + " VS. " + name_team2);
	
	$("#_name_team1").text(name_team1);
	$('input:hidden[name=name_team1]').val(name_team1);
	
	$("#_name_team2").text(name_team2);
	$('input:hidden[name=name_team2]').val(name_team2);
	
	$("#_gdate").text(gdate);
	$("#_name_stadium").text(name_stadium);
	
	$('input:hidden[name=league]').val(league);
	
	$("#detail-modal").css("display", "block");
}

function sortList() {
	var item = document.getElementById("sort");
	
	var selectItem = item.options[item.selectedIndex].value;
//	alert(selectItem);
	
	location.href="gameResultAdmin.do?sorting=" + selectItem + "&choice=" + $("#choice").val() + "&keyword=" + $("#str").val().trim();
}

function func1() {
	var choice = $("#choice").val();
	
	if(choice == "선택"){
		$("#str").css("display", "");
		$("#str").val("");
		$("#choice2").css("display", "none");
	}	
	else if(choice == "team_name"){
		$("#str").val("");
		$("#str").css("display", "");
		$("#choice2").css("display", "none");
	}
	else if(choice == "category"){
		$("#str").css("display", "none");
		$("#choice2").css("display", "");
	}
}

/* 숫자만 입력하게함 */
function fn_press(event, type) {
	if(type == 'numbers'){
		if((event.keyCode < 48) || (event.keyCode > 57)){
			return false;
		}
	}
}

function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which)?event.which:event.keyCode;
	if (keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39) 
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}


</script>


</body>
</html>