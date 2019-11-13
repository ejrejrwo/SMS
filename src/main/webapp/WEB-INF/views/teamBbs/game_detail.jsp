<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" />

<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

</head>
<body>

	<div class="container" style="width: 800px; margin-top: 50px;">
		<form id="frmForm">
			<div style="text-align: right;">
				<button type="button" id="req_btn" class="btn btn-default">가져오기</button>
				<button type="button" id="list_btn" class="btn btn-default">목록</button>
			</div>

			<div>
				<table class="table">
					<col width="80">
					<col width="100">
					<col width="80">
					<col width="100">
					<tr>
						<td colspan="4" id="category" align="left" style="font-size: 16px; color: #747474; border-top: none;"># ${game.category }</td>
					</tr>
					<tr>
						<td colspan="4" align="left" style="font-size: 20px; font-weight: 900;">${game.title }</td>
					</tr>

					<tr>
						<td colspan="4" id="name_team1" align="left">${game.name_team1 }| <fmt:formatDate value="${game.wdate }" pattern=" yyyy-MM-dd kk:mm" /> |
							${game.read_count }
						</td>
					</tr>

					<tr>
						<td style="background-color: #042e6f; color: #fff;">경기일시</td>
						<td id="gdate" style="border: 1px solid #d5d5d5;">${game.gdate }</td>
						<td style="background-color: #042e6f; color: #fff;">경기장</td>
						<td id="name_stadium" style="border-left: 1px solid #d5d5d5;">${game.name_stadium }</td>
					</tr>

					<tr>
						<td colspan="4" id="content" align="left" style="padding-top: 30px; height: 300px;">${game.content }<!-- Modal로 값 넘기기 --> <input type="hidden"
							id="seq_game" name="seq_game" value="${game.seq_game }"> <input type="hidden" id="name_team2" name="name_team2" value="${mem.team_name }">
							<input type="hidden" id="id" name="id" value="${mem.id }"> <input type="hidden" id="game_data" name="id" value="${game.gdate}"> <input
							type="hidden" id="game_stadium" name="id" value="${game.name_stadium }">
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>


	<script type="text/javascript">
$(document).ready(function () {	
	$("#menu1").css("background-color","#e60013");	

	$("#list_btn").click(function () {
		location.href="getgamelist.do";			
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



