<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
table {
	border-collapse: collapse;
	font-size: 20px;
}

th {
	background-color: #f5f5f5;
	font-weight: normal;
	text-align: center;
	border: 1px solid #A2AAC1;
}

td {
	border-bottom: 1px solid #A2AAC1;
}

.btn-primary {
	background-color: #042E6F;
	border-color: #042E6F;
}

.bet_td {
	background-color: #f5f5f5;
}
</style>

<!-- security ajax -->
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<meta charset="UTF-8">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" />
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
	<div class="container" style="width: 800px;">
		<div style="text-align: right;">
			<button type="button" id="req_btn" class="btn btn-default">가져오기</button>
			<button type="button" id="list_btn" class="btn btn-default">목록</button>
			<input type="hidden" id="game_data" value="${game.gdate }">
			<input type="hidden" id="game_stadium" value="${game.name_stadium }">
		</div>
		<table class="table table-responsive">
			<col width="300">
			<col width="200">
			<col width="300">

			<tr style="text-align: left;">
				<td colspan="3" style="color: #747474;"># ${game.category }</td>
			</tr>

			<tr>
				<td style="padding: 20px;" colspan="3">${game.gdate }&nbsp; | &nbsp; ${game.name_stadium }</td>
			</tr>

			<tr>
				<td style="font-size: 24px;">${game.name_team1 }</td>
				<th style="padding: 50px;">TEAM</th>
				<td style="font-size: 24px;">${game.name_team2 }</td>
			</tr>

			<tr>
				<td style="padding: 20px;">${mmr1 }</td>
				<th style="padding: 20px;">MMR</th>
				<td style="padding: 20px;">${mmr2 }</td>
			</tr>

			<tr>
				<td style="padding: 20px;">${win_rate1 }%</td>
				<th style="padding: 20px; font-size: 18px;">예상 승률</th>
				<td style="padding: 20px;">${win_rate2 }%</td>
			</tr>

			<tr>
				<td style="padding: 20px;">${payout_r1 }</td>
				<th style="padding: 20px; font-size: 18px;">현재 배당률 <img alt="" src="../image/search.png" title="배당률은 소수점 셋째 자리에서 반올림 합니다."
					style="width: 22px; height: 22px;"></th>
				<td style="padding: 20px;">${payout_r2 }</td>
			</tr>

			<tr>
				<td style="padding: 20px; font-size: 18px;">베팅 마감일</td>
				<td colspan="2" style="padding: 20px; text-align: left;">${game.gdate }</td>
			</tr>

			<tr>
				<td class="bet_td" style="padding: 20px; font-size: 18px;">베팅시 유의사항</td>
				<td colspan="2" class="bet_td" style="text-align: left; padding-top: 20px; padding-bottom: 20px; font-size: 14px;">- 단위 베팅금액(최소 구매가능 금액)은 1,000원이며, 최대
					5만원까지<br>&nbsp;&nbsp;구매 가능합니다.<br> - 베팅완료 후 베팅내역은 <b>수정 · 취소가 불가</b>하오니 유의하여 주십시오.<br> - 대상 경기 취소시 해당 회차는 발매 무효로 처리되어 환불됩니다.<br> - 베팅
					성공시 총 금액의 5%를 차감한 금액이 지급됩니다.
				</td>
			</tr>

			</tbody>
		</table>
	</div>


	<div class="container" style="width: 800px;">
		<form id="_frmBet" method="post">
			<!-- security -->
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

			<table class="table table-responsive" style="width: 770px;">
				<col width="240">
				<col width="510">
				<tr>
					<c:if test="${id == 'guest'}">
						<td colspan="2" class="bet_td" style="padding: 20px; text-align: center; border-top: 1px solid #A2AAC1;">로그인 후 베팅에 참가하실 수 있습니다.</td>
					</c:if>
					<c:if test="${game.teamcheck }">
						<td colspan="2" class="bet_td" style="padding: 20px; text-align: center; border-top: 1px solid #A2AAC1;">본인이 속한 팀의 경기에는 베팅하실 수 없습니다.</td>
					</c:if>

					<c:if test="${game.bet }">
						<td colspan="2" class="bet_td" style="padding: 20px; text-align: center; border-top: 1px solid #A2AAC1;">베팅이 완료되었습니다.<br> 베팅 상세내역은 <a
							href="../mypage/myPageBet.do">마이페이지 〉 내 베팅내역</a>에서 확인하실 수 있습니다.
						</td>
					</c:if>

					<c:if test="${not game.bet && not game.teamcheck && id != 'guest'}">
						<td class="bet_td" style="padding: 20px; border-top: 1px solid #A2AAC1;"><b>BETTING</b><br>
						<br>
						<%-- <b>보유 금액 : <fmt:formatNumber value="${now_money }" pattern="#,###"/>원 </b> --%></td>
						<td class="bet_td" style="padding: 20px; border-top: 1px solid #A2AAC1;">
							<div style="text-align: left;">
								<input type="radio" name="team_name" value="${game.name_team1 }">&nbsp;${game.name_team1 }&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio"
									name="team_name" value="${game.name_team2 }">&nbsp;${game.name_team2 }<br>
							</div> <input type="text" id="bmoney" name="betting_money" class="form-control" placeholder="베팅할 금액 입력 (최대 50,000원)" maxlength="6"
							onkeypress="return fn_press(event,'numbers');" onkeyup="inputNumberFormat(this);" style="width: 237px; float: left;">
							<div style="padding: 6px;">
								보유 금액 :
								<fmt:formatNumber value="${now_money }" pattern="#,###" />
								원
							</div>
							<br> <font style="font-size: 13px; float: left;">※ 회원님의 안전한 정보 보호를 위하여 비밀번호 입력 후 베팅이 진행됩니다.<br></font> <input type="password" id="pwd"
							name="pwd" class="form-control" placeholder="비밀번호 입력" maxlength="20" style="width: 237px; float: left;"> <input type="button" id="bettingBtn"
							class="btn btn-primary" style="margin-left: 5px; float: left;" value="BETTING"> <input type="hidden" name="seq_game" value="${game.seq_game }">
							<input type="hidden" name="id" value="${id }">
						</td>
					</c:if>
				</tr>

			</table>

		</form>

	</div>
	<script type="text/javascript">
$(document).ready(function(){
	$("#menu5").css("background-color","#e60013");
	
	$("#list_btn").on('click', function () {
		location.href="../common/getbettinglist.do";
	});
	
	$("#req_btn").click(function () {
 		var game_data = document.getElementById("game_data").value;
 		var game_stadium = document.getElementById("game_stadium").value; 
 		var data = game_data + " " + game_stadium; 
		window.opener.document.getElementById("fromInput").value = data;
		window.close();
	});
});
</script>
</body>
</html>