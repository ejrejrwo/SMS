<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
table {
	border-collapse: collapse;
}

th {
	background-color: #042E6F;
	color: white;
	padding: 15px;
	text-align: center;
}

td {
	border-bottom: 1px solid #A2AAC1;
	padding: 12px;
}
</style>

<meta charset="UTF-8">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" />
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>

	<h2 align="center">경기 일정</h2>



	<div class="container" style="width: 1200px;">
		<div align="right">
			<button type="button" class="btn btn-default" onclick="location.href='getgamelist.do'">게임신청목록</button>
		</div>
		<!-- 글목록 -->
		<form id="_frm">
			<table class="table table-hover table-responsive" style="width: 1170px;">

				<thead>
					<tr>
						<th style="width: 100px;">번호</th>
						<th style="width: 130px;">종목</th>
						<th style="width: 410px;">경기명</th>
						<th style="width: 180px;">경기장</th>
						<th style="width: 200px;">경기일</th>
						<th style="width: 150px;">베팅 여부</th>
					</tr>
				</thead>

				<tbody>
					<c:if test="${empty gamelist }">
						<tr>
							<td colspan="6" style="text-align: center;">경기 일정이 없습니다.</td>
						</tr>
					</c:if>

					<c:forEach items="${gamelist }" var="game" varStatus="vs">
						<!-- 시작 : 1 -->

						<tr class="_hover_tr">
							<td>${game.seq_game }</td>
							<td><c:if test="${game.category == '축구'}">
									<img alt="" src="../image/soccer.png" style="width: 22px; height: 22px;">
								</c:if> <c:if test="${game.category == '농구'}">
									<img alt="" src="../image/basketball.png" style="width: 22px; height: 22px;">
								</c:if> <c:if test="${game.category == '야구'}">
									<img alt="" src="../image/baseball.png" style="width: 22px; height: 22px;">
								</c:if> <c:if test="${game.category == '배드민턴'}">
									<img alt="" src="../image/badminton.png" style="width: 22px; height: 22px;">
								</c:if> <c:if test="${game.category == '탁구'}">
									<img alt="" src="../image/ping-pong.png" style="width: 22px; height: 22px;">
								</c:if></td>
							<td style="text-align: left;"><c:if test="${game.del eq 0 }">
									<a href="getbetting.do?seq_game=${game.seq_game }&bet=${game.bet }&teamcheck=${game.teamcheck }" style="text-decoration: none;">${game.name_team1 }
										VS. ${game.name_team2 }</a>
								</c:if></td>
							<td>${game.name_stadium }</td>
							<td>${game.gdate }</td>
							<td><c:if test="${game.bet }">
				베팅완료
			</c:if> <c:if test="${not game.bet && not game.teamcheck }">
				베팅가능
			</c:if> <c:if test="${game.teamcheck }">
				베팅불가
			</c:if></td>
						</tr>

					</c:forEach>

					<tr align="center" class="trfoot">
						<td colspan="6" style="height: 30px;">
							<ul class="pagination pagination-sm">
								<c:if test="${gparam.prev }">
									<li class="page-item"><a class="page-link"
										href="getbettinglist.do?choice=${gparam.choice}&keyword=${gparam.keyword}&pageNum=${gparam.startPage-1}">prev</a></li>
								</c:if>

								<c:forEach begin="${gparam.startPage }" end="${gparam.endPage }" step="1" var="index">
									<c:if test="${gparam.pageNum eq index }">
										<li class="page-item active"><a class="page-link">${index }</a></li>
									</c:if>

									<c:if test="${gparam.pageNum ne index }">
										<li class="page-item"><a class="page-link" href="getbettinglist.do?choice=${gparam.choice}&keyword=${gparam.keyword}&pageNum=${index}">${index}</a></li>
									</c:if>
								</c:forEach>

								<c:if test="${gparam.next }">
									<li class="page-item"><a class="page-link" href="getbettinglist.do?choice=${gparam.choice}&keyword=${gparam.keyword}&pageNum=${gparam.endPage+1}">next</a></li>
								</c:if>
							</ul>
						</td>
					</tr>

					<tr align="center" class="trfoot">
						<td colspan="6">
							<div class="container" style="width: 364px;">
								<select id="choice" name="choice" class="form-control" style="width: 130px; float: left;" onchange="func1()">
									<option value="선택">선택</option>
									<option value="category" <c:if test="${gparam.choice == 'category' }">selected='selected'</c:if>>경기 종목</option>
									<option value="stadium" <c:if test="${gparam.choice == 'stadium' }">selected='selected'</c:if>>경기장</option>
									<option value="team_name" <c:if test="${gparam.choice == 'team_name' }">selected='selected'</c:if>>팀명</option>
								</select> <input type="text" id="str" name="keyword" class="form-control" placeholder="검색" maxlength="30" style="width: 150px; float: left;"
									value="${gparam.keyword }"> <select id="choice2" name="choice2" class="form-control" style="width: 150px; float: left; display: none;">
									<option value="선택">종목 선택</option>
									<option value="축구" <c:if test="${gparam.keyword == '축구'}">selected='selected'</c:if>>축구</option>
									<option value="농구" <c:if test="${gparam.keyword == '농구'}">selected='selected'</c:if>>농구</option>
									<option value="야구" <c:if test="${gparam.keyword == '야구'}">selected='selected'</c:if>>야구</option>
									<option value="배드민턴" <c:if test="${gparam.keyword == '배드민턴'}">selected='selected'</c:if>>배드민턴</option>
									<option value="탁구" <c:if test="${gparam.keyword == '탁구'}">selected='selected'</c:if>>탁구</option>
								</select> <select id="choice3" name="choice3" class="form-control" style="width: 150px; float: left; display: none;">
									<option value="선택">경기장 선택</option>
									<option value="잠실" <c:if test="${gparam.keyword == '잠실'}">selected='selected'</c:if>>잠실</option>
									<option value="한밭" <c:if test="${gparam.keyword == '한밭'}">selected='selected'</c:if>>한밭</option>
									<option value="부산" <c:if test="${gparam.keyword == '부산'}">selected='selected'</c:if>>부산</option>
									<option value="광주" <c:if test="${gparam.keyword == '광주'}">selected='selected'</c:if>>광주</option>
									<option value="강릉" <c:if test="${gparam.keyword == '강릉'}">selected='selected'</c:if>>강릉</option>
								</select>
								<!-- <input type="hidden" name="keyword" value=""> -->

								<input type="button" id="searchBtn" class="btn btn-default" style="float: left;" value="검색">
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
		$("#str").css("display", "");
		$("#choice2").css("display", "none");
		$("#choice3").css("display", "none");
	}
	else if(${gparam.choice == 'category'}){
		$("#str").css("display", "none");
		$("#choice3").css("display", "none");
		$("#choice2").css("display", "");
	}
	else if(${gparam.choice == 'stadium'}){
		$("#str").css("display", "none");
		$("#choice2").css("display", "none");
		$("#choice3").css("display", "");
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
		else if($("#choice").val() == "stadium"){
			if($("#choice3").val() == "선택"){
				alert("경기장을 선택해주십시오.");
				return;
			}
			else{
				$('input:hidden[name=keyword]').val($("#choice3").val());
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
	//	alert("choice:" + $("#choice").val() + " keyword:" + $('input:hidden[name=keyword]').val());
		
		$("#_frm").attr("action", "../common/getbettinglist.do").submit();
		
	});
	
});

function func1() {
	var choice = $("#choice").val();
	
	if(choice == "선택"){
		$("#str").css("display", "");
		$("#str").val("");
		$("#choice2").css("display", "none");
		$("#choice3").css("display", "none");
	}	
	else if(choice == "team_name"){
		$("#str").val("");
		$("#str").css("display", "");
		$("#choice2").css("display", "none");
		$("#choice3").css("display", "none");
	}
	else if(choice == "category"){
		$("#choice2").css("display", "");
		$("#str").css("display", "none");
		$("#choice3").css("display", "none");
	}
	else if(choice == "stadium"){
		$("#choice3").css("display", "");
		$("#str").css("display", "none");
		$("#choice2").css("display", "none");
	}
}


</script>


</body>
</html>