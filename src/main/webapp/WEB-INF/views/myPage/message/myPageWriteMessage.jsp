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
						<input type="text" class="form-control" name="receive_id" id="receiveId" placeholder="아이디">
						<font id="id_font"></font>
					</th>
					<td rowspan="2" style="vertical-align: bottom; width: 60px;">
						<!-- 최대 입력자 카운팅 -->
						<font style="font: inherit; font-size:8pt;" id="contentLength">0/500자</font>
					</td>
				</tr>
				<tr>	
					<th>
						내용
						<textarea class="form-control" rows="15" cols="41" name="content" id="writeContent" maxlength="500"></textarea>
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
		var count = false;		// 데이터 최종 전송시 중간 체크 변수
		var lengCheck = true;	// 데이터 길이 확인용 변수
		var contentLength = ""; // 현재 입력한 내용의 Length 저장용 변수
		
		$(function() {
			
			$("#receiveId").autocomplete({
				source : function(req, resp) {
					$.ajax({
						type : "get",
						url : "msgAutocompleate.do",
						dataType : "json",
						data : {
							value : req.term
						},
						success : function(data) {
							console.log(data);
							console.log(typeof(data));
							resp($.each(data, function(index, item) {
								return {
									label : item,
									value : item
								}
							}));
						}
					});
				},
				// 최소 autocomplete 되는 글자 수 이다.
				// ( 최소 한글자 이상 입력해야 작동한다.)
				minLength : 1,
				select : function(event, ui) {
					
				}
			});
				
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
				if(keycode === 8){ // backspace 입력시 문자 길이 최신화 후 keyup 에서 벗어난다.
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
					// 본문 길이가 500자가 넘어갈 경우 확인 변수를 false 로 바꿔준다.
					lengCheck = false;
					return ;
				}
			});
			
			$("#receiveId").change(function() {
				console.log("idcheck in");
				// autocomplete 혹은 사용자가 직접 입력한 아이디를 db에서 존재하는 아이디 인지 확인해준다.
				var receive_id = $("#receiveId").val();
				var send_id = $("#id").val();
				
				$.ajax({
					url : "receiveIdCheck.do",
					type : "get",
					data : {
						receive_id : receive_id, send_id : send_id
					},
					success : function(b) {
						if(b == "true") {
							console.log("트루" + b);
							$("#id_font").html("<b>전송 가능한 아이디</b>");
							count = true;
						} else {
							console.log("펄스" + b);
							$("#id_font").html("<b>발신 불가능한 아이디 입니다.</b>");
							count = false;
						}
					},
					error : function() {
						console.log("idCheck() ajax 오류 In");
					}
				});
			});
			
			$("#writeBtn").click(function () {
				if(count == false) {
					alert("아이디를 확인해 주세요.");
					return ;
				}else if($("#writeContent").val().trim() == ""){
					alert("메세지 내용을 입력해 주세요.");
					return ;
				}else if (lengCheck == false) {
					alert("메세지 내용이 500자가 넘습니다.")					
				}else {
					
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
								opener.location.reload();
								self.close();
							} else {
								alert("예기치 못한 오류로 메세지를 전송하지 못했습니다.");
								self.close();
							}
						},
						error : function() {
							console.log("myPageWriteMessageSuc() ajax 오류 In");
							alert("예기치 못한 오류로 메세지를 전송하지 못했습니다.");
						}
					});
					
				}
			});

		});
		
	});
	
	</script>
</body>
</html>