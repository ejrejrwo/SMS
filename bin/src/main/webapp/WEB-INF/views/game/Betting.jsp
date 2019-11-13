<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
table{
	border-collapse: collapse;
	font-size: 20px;
}
th{
	background-color: #DCE2FF;
	font-weight: normal;
	text-align: center;
	border: 1px solid #A2AAC1;
}
td{
	border-bottom: 1px solid #A2AAC1;
}
.btn-primary{
	background-color: #042E6F;
	border-color: #042E6F;
}
.bet_td{
	background-color: #DCE2FF;
}

</style>

<!-- security ajax -->
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<meta charset="UTF-8">
<title>경기 일정</title>

<!-- <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
 -->
</head>
<body>
<div class="container" style="width: 820px;">
<table class="table table-responsive">
<col width="300"><col width="220"><col width="300">

<tr style="text-align: left;">
	<td colspan="3" style="color: #747474;"># ${game.category }
		<c:if test="${not empty game.league }">
			<c:if test="${game.league eq '21' }">
				[결승전]
			</c:if>
			<c:if test="${game.league ne '21' }">
				[토너먼트 ${fn:substring(game.league,0,1) }강
				${fn:substring(game.league,1,2) }라운드]
			</c:if>
		</c:if>
	</td>
</tr>

<tr>
	<td style="padding: 20px;" colspan="3">${game.gdate } &nbsp; | &nbsp; ${game.name_stadium }</td>
</tr>

<tr>
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
	<th style="vertical-align: middle;">TEAM</th>
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
	<th style="padding: 20px; font-size: 18px;">현재 배당률 <img alt="" src="../image/search.png" title="배당률은 소수점 셋째 자리에서 반올림 합니다." style="width: 22px; height: 22px;"></th>
	<td style="padding: 20px;">${payout_r2 }</td>
</tr>

<tr>
	<td style="padding: 20px; font-size: 18px;">베팅 마감일</td>
	<td colspan="2" style="padding: 20px; text-align: left;">${game.gdate }</td>
</tr>

<tr>
	<td class="bet_td" style="padding: 20px; font-size: 18px;">베팅시 유의사항</td>
	<td colspan="2" class="bet_td" style="text-align: left; padding-top: 20px; padding-bottom: 20px; font-size: 14px;">
	- 단위 베팅금액(최소 구매가능 금액)은 1,000원이며, 최대 5만원까지<br>&nbsp;&nbsp;구매 가능합니다.<br>
	- 베팅완료 후 베팅내역은 <b>수정 · 취소가 불가</b>하오니 유의하여 주십시오.<br>
	- 대상 경기 취소시 해당 회차는 발매 무효로 처리되어 환불됩니다.<br>
	- 베팅 성공시 총 금액의 5%를 차감한 금액이 지급됩니다.
	</td>
</tr>

</tbody>
</table>
</div>


<div class="container" style="width: 820px;">
<form id="_frmBet" method="post">
<!-- security -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<table class="table table-responsive" style="width: 790px;">
<col width="240"><col width="550">
<tr>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<td colspan="2" class="bet_td" style="padding: 20px; font-size: 18px; text-align: center; border-top: 1px solid #A2AAC1;">
			관리자는 베팅에 참가하실 수 없습니다.
		</td>
	</sec:authorize>
	
	<sec:authorize access="!hasRole('ROLE_ADMIN')">
	<c:if test="${id == 'guest'}">
		<td colspan="2" class="bet_td" style="padding: 20px; font-size: 18px; text-align: center; border-top: 1px solid #A2AAC1;">
			로그인 후 베팅에 참가하실 수 있습니다.
		</td>
	</c:if>	
	<c:if test="${game.teamcheck }">
		<td colspan="2" class="bet_td" style="padding: 20px; font-size: 18px; text-align: center; border-top: 1px solid #A2AAC1;">
			본인이 속한 팀의 경기에는 베팅하실 수 없습니다.
		</td>
	</c:if>	

	<c:if test="${game.bet }">
		<td colspan="2" class="bet_td" style="padding: 20px; font-size: 18px; text-align: center; border-top: 1px solid #A2AAC1;">
			베팅이 완료되었습니다.<br>
			베팅 상세내역은 <a href="../mypage/myPageBet.do">마이페이지 〉 내 베팅내역</a>에서 확인하실 수 있습니다.
		</td>
	</c:if>
	
	<c:if test="${not game.bet && not game.teamcheck && id != 'guest'}">
		<td class="bet_td" style="padding: 20px; border-top: 1px solid #A2AAC1;">
			<b>BETTING</b><br><br>
		</td>
		<td class="bet_td" style="padding: 20px; border-top: 1px solid #A2AAC1;">
			<div style="text-align: left; font-size: 18px; font-weight: bold;">
				<input type="radio" name="team_name" value="${game.name_team1 }">&nbsp;${game.name_team1 }&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="team_name" value="${game.name_team2 }">&nbsp;${game.name_team2 }<br>
			</div>
			<input type="text" id="bmoney" name="betting_money" class="form-control" placeholder="베팅할 금액 입력 (최대 50,000원)" maxlength="6"
				onkeypress="return fn_press(event,'numbers');" onkeyup="inputNumberFormat(this);" style="width: 237px; float: left;">
			<%-- <div style="padding: 6px; font-size: 18px;"><b>보유 금액 : <fmt:formatNumber value="${now_money }" pattern="#,###"/>원</b></div> --%>
			
				<div class="well well-sm" style="margin-left: 5px; padding: 5.5px;  font-size: 18px; width: 220px; height: 34px; float: left; ">
					<b>보유 금액 : <fmt:formatNumber value="${now_money }" pattern="#,###"/>원</b><br>
				</div>
			

			<font style="font-size: 13px; float: left;">※ 회원님의 안전한 정보 보호를 위하여 비밀번호 입력 후 베팅이 진행됩니다.<br></font>
			<input type="password" id="pwd" name="pwd" class="form-control" placeholder="비밀번호 입력" maxlength="20" style="width: 237px; float: left;">
			<input type="button" id="bettingBtn" class="btn btn-primary" style="margin-left: 5px; float: left;" value="BETTING">
			<input type="hidden" name="seq_game" value="${game.seq_game }">
			<input type="hidden" name="id" value="${id }">
		</td>
	</c:if>
	</sec:authorize>
</tr>

</table>

</form>

	<div style="text-align: center;">
		<input type="button" id="listBtn" class="btn btn-default" style="margin: auto; display: block;" value="목록으로">
	
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<input type="button" id="delBtn" class="btn btn-default" style="float: right;" value="삭제">
	</sec:authorize>
	</div>

</div>


<script type="text/javascript">

$(document).ready(function(){
	$("#menu2").css("background-color","#e60013");
	
	$('[data-toggle="tooltip"]').tooltip();
	

	$("#bettingBtn").click(function() {
		var betmoney = $("#bmoney").val().replace(/,/g, '');
		
		if($("input:radio[name='team_name']").is(':checked') == false){
			alert("베팅할 팀을 선택해주십시오.");
			return;
		}
		else if(betmoney == ""){
			alert("베팅할 금액을 입력해주십시오.");
			return;
		}
		else if(betmoney > 50000){
			alert("최대 베팅금액은 50,000원 입니다.");
			$("#bmoney").val("");
			return;
		}
		else if(betmoney % 1000 > 0 || betmoney == 0){
			alert("1,000원 단위로 입력 가능합니다.");
			$("#bmoney").val("");
			return;
		}
		else if(betmoney > ${now_money }){
			if(confirm("보유 머니가 부족합니다. 충전페이지로 이동하시겠습니까?")){
				location.href = "/mypage/myPagePay.do";
			}
			else{
				return;
			}
			$("#bmoney").val("");
			return;
		}

		else if($("#pwd").val() == ""){
			alert("비밀번호를 입력해주십시오.");
			return;
		}
		
		else{
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$(document).ajaxSend(function(e, xhr, options) {
			    xhr.setRequestHeader(header, token);
			});
			$.ajax({
				/* security */
				url:"getPassword.do",
				type:"post",
				data:{ id:$('input:hidden[name=id]').val(), pwd:$("#pwd").val() },
				async:true,	
				success:function(msg){
				//	alert("success");
					
 					if(msg == 'YES'){	// 비밀번호 일치
 						if(confirm("베팅 금액 : " + $("#bmoney").val() + "원 \n정말 베팅하시겠습니까?")){
 							alert("베팅이 완료되었습니다.");
 							$("#bmoney").val($("#bmoney").val().replace(/,/g, ''));
 							$("#_frmBet").attr("action", "/common/bettingAf.do").submit();
 						}
 						else{
 							return;
 						}
					}
					else{	// 비밀번호 불일치
						alert("비밀번호가 틀렸습니다.");
						$("#pwd").val("");
						return;
					}
				},
				error:function(){
					alert("error");
				}
			});
		} 
	});
	
	
	$("#delBtn").click(function(){
		if(confirm("정말 삭제하시겠습니까?")){
			alert("삭제가 완료되었습니다.");
			location.href = "/admin/deleteGame.do?seq_game=" + ${game.seq_game } + "&team_name=" + '${game.name_team1 }';
		}
		else{
			return;
		}
	});
	
	
	$("#listBtn").click(function() {
		location.href = "/common/bettinglist.do";
	});
});


/* 숫자만 입력하게함 */
function fn_press(event, type) {
//	alert("press");
	if(type == 'numbers'){
		if((event.keyCode < 48) || (event.keyCode > 57)){
			return false;
		}
	}
	else{
		return;
	}
}

/* 값 입력시 콤마찍기 */
function inputNumberFormat(obj) {
    obj.value = zerocheck(comma(uncomma(obj.value)));
}

/* 콤마찍기 */
function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

/* 콤마풀기 */
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}

/* 맨앞 0 입력 없애기 */
function zerocheck(str){
	str = String(str);
	return str.replace(/^0+/, '');
}


</script>


</body>
</html>