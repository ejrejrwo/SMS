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

/* Modal Css */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: hidden; /* Enable scroll if needed */
	background-color: rgb(0,0,0); /* Fallback color */
	background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 10% auto; /* 10% from the top and centered */
	padding: 20px;
	border: 1px solid #888;
	width: 500px; /* Could be more or less, depending on screen size */                          
}
/* The Close Button */
.close {
	color: #aaa;
	float: right;
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

<div id="_top">
	경기매칭내용
</div>

<div class="container" style="width: 800px">
	<form id="frmForm">
		<div style="text-align: right;">
		
			<!-- 상대팀 팀장view  -->		
			<c:if test="${mem.team_name ne game.name_team1 && auth.authority eq 'ROLE_TEAMLEADER'}"	>
				<c:if test="${empty glist }">
					<button type="button" id="req_btn" class="btn btn-default">매칭신청</button>				
				</c:if> 
				<c:forEach items="${glist }" var="g">		
					<c:if test="${mem.id ne g.id && game.seq_game eq g.seq_game}">					
						<button type="button" id="req_btn" class="btn btn-default">매칭신청</button>					
					</c:if>
				</c:forEach>
				
			<div id="detail-modal" class="modal">
				<div class="modal-content" align="center">
				<span class="close">&times;</span><br>
				<h2>경기매칭신청</h2>	
					<div align="center">
						<textarea rows="5" cols="50" id="message" name="message" placeholder="메세지를 입력해주세요"></textarea>
						<br><br>						
						<button type="button" id="submit_btn" class="btn btn-default">신청</button>		
					</div>
				</div> <!-- modal-content -->
			</div>	<!-- detail-modal -->
			
			</c:if>
			
			<!-- 신청한 팀 팀장view -->
			<c:if test="${mem.team_name eq game.name_team1 && auth.authority eq 'ROLE_TEAMLEADER' }">			
				<button type="button" id="delete_btn" class="btn btn-default">삭제</button>				
			</c:if>
			
			<!-- 팀원은 여기부터 보이게 -->	
			<button type="button" id="list_btn" class="btn btn-default">목록</button>
		</div>
						
						
		<div>						
			<table class="table">	
			<col width="80"><col width="100"><col width="80"><col width="100">
			<tr>
				<td colspan="4" id="category" align="left" style="font-size: 16px; color: #747474; border-top: none;"># ${game.category }</td>
			</tr>	
			<tr>
				<td colspan="4" align="left" style="font-size: 20px; font-weight: 900;">${game.title }</td>
			</tr>									

			<tr>
				<td colspan="4" id="name_team1" align="left">${game.name_team1 } | <fmt:formatDate value="${game.wdate }" pattern=" yyyy-MM-dd kk:mm"/> | ${game.read_count }</td>
			</tr>
			
			<tr>
				<td style="background-color: #042e6f; color: #fff;">경기일시</td>
				<td id="gdate" style="border: 1px solid #d5d5d5;">${game.gdate }</td>
				<td style="background-color: #042e6f; color: #fff;">경기장</td>
				<td id="name_stadium" style="border-left: 1px solid #d5d5d5;">${game.name_stadium }</td>
			</tr>

			<tr>
				<td colspan="4" id="content" align="left" style="padding-top: 30px; height: 300px;">${game.content }
				 	<!-- Modal로 값 넘기기 -->
					<input type="hidden" id="seq_game" name="seq_game" value="${game.seq_game }">
					<input type="hidden" id="name_team2" name="name_team2" value="${mem.team_name }">
					<input type="hidden" id="id" name="id" value="${mem.id }">
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
		location.href="gamelist.do";			
	});
	
	$("#delete_btn").click(function () {
		var seq_game = $("#seq_game").val();
		var id = $("#id").val();

		location.href="gamedelete.do?seq_game=" + seq_game + "&id=" + id;			
	});
	
	//modal 열기
	$("#req_btn").click(function () {
//		alert("click");
		$("#detail-modal").css("display", "block");
	});
	
	//modal 닫기
	$(".close").on("click", function () {
		$(".modal").css("display", "none");
	});
	
 	//modal 메세지 보내기
	$("#submit_btn").click(function () {
		if($("#message").val()==""){
 			alert("메세지를 입력해주세요");
 			return;
 		}
		
		var seq_game = $("#seq_game").val();
		var id =  $("#id").val();
		var name_team2 =  $("#name_team2").val();
		var message =  $("#message").val();
			
//		alert(seq_game + " " + id + " " + name_team2 + " " + message);
		
  		$.ajax({
			url:'reqGame.do',
			async:true,
			data:'seq_game=' + seq_game + '&id=' + id + '&name_team2=' + name_team2 + '&message=' + message,
			success:function(){
				alert("전송에 성공하였습니다");
								
				var message =  $("#message").val("");
				$(".modal").css("display", "none");	
				location.href="gamelist.do";
				
			},
			error:function(){
				alert("error");
			}			
		}) 			
	});

	
});


</script>				

</body>
</html>



