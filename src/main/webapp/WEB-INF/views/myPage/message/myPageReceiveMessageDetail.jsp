<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	
	<% String ctx = request.getContextPath(); %>
	
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	
	<style type="text/css">
		td, th {
			text-align: left
		}
		#block-img {
			margin-left: 10px;
			cursor: pointer;
		}
	</style>
</head>
<body>
	<input type="hidden" id="seq" value="${seq}">
	<input type="hidden" id="send_id" value="${msgDTO.send_id}">
	<table style="margin: 10px auto;">
		<tr>
			<th>
				작성자
				<c:if test="${empty block}">
					<img src="<%=ctx%>/image/read.png" alt="수신거부" id="block-img">
				</c:if>
				
				<c:if test="${not empty block}">
					<img src="<%=ctx%>/image/blocked.png" alt="수신거부" id="block-img">
				</c:if>
				<label class="form-control" >${msgDTO.send_id}</label>
			</th>
		</tr>	
		<tr>
			<th>
				보낸시간<label class="form-control">${msgDTO.wdate}</lable>
			</th>
		</tr>
		<tr>
			<th>
				내용
				<textarea class="form-control" cols="41" rows="13" readonly="readonly">${msgDTO.content}</textarea>
			</th>
		</tr>
	</table>
	
	<table style= "margin: 10px auto;">
		<tr>
			<td style="text-align: left;">
				<button type="button" id="answerBtn" class="btn btn-default">답장</button>
			</td>
			<td style="text-align: left;">
				<button type="button" id="delBtn" class="btn btn-danger">삭제</button>
			</td>
		</tr>
	</table>
	<script type="text/javascript">
		$(function() {
			
			$("#block-img").click(function () {
				
			});
			
			var seq = $("#seq").val();
			
			$("#delBtn").click(function () {
				location.href="myPageReseiveMessageDelete.do?seq=" + seq
			});
	
			var sendId = $("#send_id").val();
			
			$("#answerBtn").click(function () {
				
				location.href="myPageAnswerMessage.do?send_id=" + sendId;
				
				/* window.open("/mypage/myPageAnswerMessage.do?send_id=" + sendId, "answerMessage", "width=380, height=500,left=35%, top=35%");
				self.close(); */
			});
			$("#block-img").click(function () {
				var send_id = $("#send_id").val();
				$.ajax({
					url : "mypageMessageReceiveStat.do",
					type : "get",
					data : {
						send_id : send_id
					},
					success : function(b) {
						if(b == "Y") {
							alert("수신거부 했습니다.");
							$("#block-img").attr("src", "/image/blocked.png");
						} else {
							alert("수신거부를 해제했습니다.");
							$("#block-img").attr("src", "/image/read.png");
						}
					},
					error : function() {
						console.log("mypageMessageReceiveStat() ajax 오류 In");
					}
				});
			});
			
		});
	</script>
</body>
</html>