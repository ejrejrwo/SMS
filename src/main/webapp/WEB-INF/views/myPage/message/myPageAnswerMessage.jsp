<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 
 
	<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<style type="text/css">
		td, th {
			text-align: left
		}
	</style>
</head>
<body>
	<div id="writeLetter">
		<form id="writeFrm">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<input type="hidden" name="send_id" value="${id}" id="id">
			<table style="margin: 10px auto;">
				<tr>
					<th>
						아이디
						<input type="text" class="form-control" placeholder="아이디" id="receiveId" value="${receive_id}" readonly="readonly">
					</th>
					<td rowspan="2" style="vertical-align: bottom; width: 60px;">
						<font style="font: inherit; font-size:8pt;" id="contentLength">0/500자</font>
					</td>
				</tr>
				<tr>	
					<th>
						내용
						<textarea class="form-control" rows="15" cols="41" id="writeContent" maxlength="500"></textarea>
					</th>
				</tr>
			</table>
			<table style="margin: 10px auto;">
				<tr>
					<td style="text-align: center;">
						<button type="button" id="writeBtn" class="btn btn-default">전송</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<script type="text/javascript">
	$(function () {
		var lengCheck = true;
		var contentLength = "";
			
		$("#writeContent").change(function () {
			var contentLength = $("#writeContent").val().length;
			$("#contentLength").html( contentLength + "/500자" );
			if(contentLength > 500 ) {
				lengCheck = false;
				return ;
			}
		});
		
		$("#writeContent").keyup(function (event) {
			
			var keycode = event.which?event.which:event.keyCode;
			console.log(keycode);
			if(keycode === 8){
				contentLength = $("#writeContent").val().length;
				$("#contentLength").html( contentLength + "/500자" );
				return;
			}
			
			var contentLength = $("#writeContent").val().length;
			$("#contentLength").html( contentLength + "/500자" );
			if(contentLength > 500 ) {
				alert("내용 최대 입력은 500자 까지 가능합니다.");
				
				if(contentLength > 500) {
					$(this).val( $(this).val().substr(0, 500) );
					contentLength = $("#writeContent").val().length;
					$("#contentLength").html( contentLength + "/500자" );
				}
				
				lengCheck = false;
				return ;
			}
		});
		
		$("#writeBtn").click(function () {
			if($("#writeContent").val().trim() == ""){
				alert("메세지 내용을 입력해 주세요.");
			} else {
				var receive_id = $("#receiveId").val();
				var send_id = $("#id").val();
				var content = $("#writeContent").val();
				
				$.ajax({
					url : "myPageWriteMessageSuc.do",
					type : "get",
					data : {
						receive_id : receive_id, send_id : send_id, content : content
					},
					success : function(b) {
						if(b == "true") {
							$("#writeFrm").attr({"action":"myPageWriteMessageSuc.do", "method":"post"}).submit();
							self.close();
						} else {
							alert("예기치 못한 오류로 메세지를 전송하지 못했습니다.");
							self.close();
						}
					},
					error : function() {
						console.log("myPageWriteMessageSuc() ajax 오류 In");
					}
				});
			}
		});

		
	});
	
	</script>
</body>
</html>