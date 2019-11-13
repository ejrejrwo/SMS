
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>전체채팅</title>

<link href="/webjars/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- <link href="/main.css" rel="stylesheet"> -->
<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>

<style type="text/css">
html, body {
	height: 100%;
}

#main-content {
	margin-left: auto;
	margin-right: auto;
	/* margin-top: 10px; */
	background-color: #B2C7D9;
	width: 100%;
	height: 100%;
}

#greetings {
	margin-left: auto;
	margin-right: auto;
	margin-top: 10px;
	width: 70%;
	height: 340px;
	padding-top: 5px;
	padding-right: 5px;
	float: left;
	white-space: pre-line;
	/* overflow: scroll; */
	overflow-x: hidden;
	overflow-y: scroll;
	word-break: break-all;
}

#userlist {
	margin-left: auto;
	margin-right: auto;
	margin-top: 10px;
	width: 30%;
	height: 340px;
	/* overflow: scroll; */
	/* white-space: pre-line; */
	overflow-x: hidden;
	overflow-y: scroll;
	word-break: break-all;
	padding-left: 5px;
	float: left;
}

::-webkit-scrollbar {
	width: 10px;
} /* 스크롤바 넓이 */
::-webkit-scrollbar-track {
	background-color: #B2C7D9;
} /* 트랙 배경색상 */
::-webkit-scrollbar-thumb {
	background-color: #c8c8c8;
	border-radius: 10px;
} /* 바 색상 */
::-webkit-scrollbar-thumb:hover {
	background: #a0a0a0;
} /*바에 마우스 올려놨을떄 색상 */
::-webkit-scrollbar-button:start:decrement, ::-webkit-scrollbar-button:end:increment
	{
	width: 10px;
	height: 16px;
	background: #B2C7D9;
} /* 버튼넓이 밑 색상 */
#chatMessage {
	width: 80%;
	float: left;
	margin-top: 10px;
}

#chatSend {
	float: left;
	margin-top: 10px;
	width: 20%;
}

.label {
	font-size: 15px;
}

/* 말풍선 관련 css */
.balloon {
	position: relative;
	display: inline-block;
}

.balloon span {
	display: inline-block;
	padding: 5px;
	color: #000;
	background: #fff;
	border-radius: 10px;
}

.balloon:after {
	content: '';
	position: absolute;
	width: 0;
	height: 0;
	border-style: solid;
}

.balloon.left:after, .balloon.right:after {
	border-width: 10px 15px;
	top: 50%;
	margin-top: -10px;
}

.balloon.left:after {
	border-color: transparent #fff transparent transparent;
	left: -25px;
}

.balloon.right:after {
	border-color: transparent transparent transparent #fff;
	right: -25px;
}

.balloon.left {
	float: left;
	margin-left: 10px;
	margin-bottom: 5px;
}

.balloon.right {
	float: right;
	margin-right: 10px;
	margin-bottom: 5px;
}
</style>
</head>
<body>

	<div id="main-content" class="container">
		<input type="hidden" id="name" value="${id }"> <input
			type="hidden" id="hiddenText"> <input type="hidden"
			id="NowStatus" value="${nochat.now_status }"> <input
			type="hidden" id="NoCount" value="${nochat.no_count }">

		<div id="greetings"></div>
		<div id="userlist">
			<b>접속중(</b><b id="usercount"></b><b>)</b>
		</div>
		<input type="text" id="chatMessage" class="form-control"
			onkeyup="enterkey();" autocomplete="off" placeholder="message.." />
		<button id="chatSend" class="btn btn-default" type="button">전송</button>
	</div>

	<script type="text/javascript">
		var stompClient = null; // 웹소켓 관련 변수

		var context = "Connected"; // 연결됫다고 받는 명령어
		var retcontext = "ReturnConnected"; // 잘 받았다고 되돌려주는 명령어
		var discontext = "Disconnected"; // 연결 끊어졌다고 알려주는 명령어

		var usercount = 1; // 현재 접속자수 카운트하는 변수

		var blackcount = 0; // 제한시간안에 메세지 전송을 몇번 했는지 세는 변수
		var time = 0; // 2초에 한번씩 초기화 하는 타임 인터벌 변수 ( blackcount 를 초기화 한다.)
		var stoptimer = 0; // 채팅금지가 됐을때 실행되는 시간을 재주는 인터벌 변수

		var nowstatus = $("#NowStatus").val(); // 채팅금지시 새로고침이나 바로 창을 닫았을 경우 다시 DB에서 데이터를 가져와 현재 금지상태인지 아닌지 보는 변수
		var nocount = $("#NoCount").val(); // 채팅금지가 지금까지 몇번이나 됐는지 보는 함수 아직 따로 기능은 없음 ... 카운터만 한 상태 아직은..
		var timecount = 30000; // 채팅금지시 새로고침이나 나갔다 들어왔을때 금지 시간을 늘려주는 변수 값에 따라 금지 시간이 조정된다. ms 단위

		var timestatus = false; // 처음 2초가 지났는지 안 지났는지 확인.

		var pattern = /<script>/; // 원하는 패턴 거르기...

		function setConnected(connected) {
			$("#connect").prop("disabled", connected);
			$("#disconnect").prop("disabled", !connected);
			if (connected) {
				$("#conversation").show();
			} else {
				$("#conversation").hide();
			}
			$("#greetings").html("");
		}

		function connect() {
			var socket = new SockJS('/websocket');
			stompClient = Stomp.over(socket);
			// SockJS와 stomp client를 통해 연결을 시도.
			stompClient.connect({}, function(frame) {
				setConnected(true);
				console.log('Connected: ' + frame);

				stompClient.subscribe('/topic/greetings', function(greeting) {
					showGreeting(JSON.parse(greeting.body).content);
				});
				/* 이 부분 추가 */
				stompClient.subscribe('/topic/chat', function(chat) {
					showChat(JSON.parse(chat.body));
				});

				frame = frame + "";

				var start = frame.indexOf("user-name:");

				var end = frame.lastIndexOf("heart-beat:");

				var userid = frame.substring(start + 10, end);

				$("#userlist").append(
						"<p id='" + userid + "'>" + userid + "</p>");

				$("#hiddenText").val(context);
				sendChatConnect();

				$("#usercount").text(usercount + "");
			});
		}

		function disconnect() {

			$("#hiddenText").val(discontext);
			sendChatConnect();

			if (stompClient !== null) {
				stompClient.disconnect();
			}
			setConnected(false);
			console.log(discontext);
			clearInterval(time);
			clearInterval(stoptimer);
		}

		function sendName() {
			// /app/hello로 JSON 파라미터를 메세지 body로 전송.
			stompClient.send("/app/hello", {}, JSON.stringify({
				'name' : $("#name").val()
			}));
		}

		function showGreeting(message) {

			$("#greetings").append("<p>" + message + "</p>");

		}

		/* Chat과 관련된 메서드 추가 */
		function sendChat() {

			if (!pattern.test($("#chatMessage").val())) {
				stompClient.send("/app/chat", {}, JSON.stringify({
					'name' : $("#name").val(),
					'message' : $("#chatMessage").val()
				}));
			} else {
				alert("스크립트 하지마!");

				$("#chatMessage").val("");
				$("#chatMessage").focus();
			}

		}
		/* 연결과 연결 끊기에 관해서 */
		function sendChatConnect() {
			stompClient.send("/app/chat", {}, JSON.stringify({
				'name' : $("#name").val(),
				'message' : $("#hiddenText").val()
			}));
		}
		function showChat(chat) {

			var id = $("#name").val();

			if (id == chat.name && chat.message != context
					&& chat.message != retcontext) {

				$("#greetings").append(
						"<div class='balloon right'><span>" + chat.message
								+ "</span></div><br><br>");

				$("#chatMessage").val("");
				$("#chatMessage").focus();

			} else if (id != chat.name && chat.message == context
					&& $("#" + chat.name).length == 0) {

				if (timestatus == true) {
					$("#greetings").append(
							"<p style='text-align: center;'>" + chat.name
									+ "님이 들어오셧습니다." + "</p>");
				}
				$("#userlist").append(
						"<p id='" + chat.name + "'>" + chat.name + "</p>");

				$("#hiddenText").val(retcontext);
				sendChatConnect();

				usercount++;
				$("#usercount").text(usercount + "");

			} else if (id != chat.name && chat.message == retcontext
					&& $("#" + chat.name).length == 0) {

				if (timestatus == true) {
					$("#greetings").append(
							"<p style='text-align: center;'>" + chat.name
									+ "님이 들어오셧습니다." + "</p>");
				}
				$("#userlist").append(
						"<p id='" + chat.name + "'>" + chat.name + "</p>");

				usercount++;
				$("#usercount").text(usercount + "");

			} else if (chat.message == discontext) {

				$("#greetings").append(
						"<p style='text-align: center;'>" + chat.name
								+ "님이 나가셨습니다." + "</p>");

				$("#" + chat.name).remove();
				usercount--;
				$("#usercount").text(usercount + "");

			} else if (chat.message == context) {

				return;

			} else if (chat.message == retcontext) {

				return;

			} else {

				$("#greetings").append(
						"<div class='balloon left'><span>" + chat.name + " : "
								+ chat.message + "</span></div><br><br>");
			}

			$("#greetings").scrollTop($("#greetings")[0].scrollHeight);

			console.log(blackcount);

		}

		function enterkey() {
			if (window.event.keyCode == 13) {

				if (stoptimer != 0) {
					//$("#greetings").append("<p style='text-align: center;'>" + (timecount/1000) +"초간 채팅금지입니다(도배금지)" + "</p>");
					$("#greetings").append(
							"<p style='text-align: center;'><span class='label label-warning'>"
									+ (timecount / 1000) + "초간 채팅금지입니다(도배금지)"
									+ "</span></p>");
					$("#greetings").scrollTop($("#greetings")[0].scrollHeight);
					return;
				}

				if (blackcount >= 5) {

					timecount = 10000;
					chatstop();
					//$("#greetings").append("<p style='text-align: center;'>" + (timecount/1000) +"초간 채팅금지입니다(도배금지)" + "</p>");
					$("#greetings").append(
							"<p style='text-align: center;'><span class='label label-warning'>"
									+ (timecount / 1000) + "초간 채팅금지입니다(도배금지)"
									+ "</span></p>");
					$("#greetings").scrollTop($("#greetings")[0].scrollHeight);
					return;

				}

				//alert("엔터키눌림");
				if ($("#chatMessage").val().trim() != "" && stoptimer == 0
						&& blackcount < 5) {
					sendChat();
					blackcount++;
				}
			}
		}

		// 채팅정지를 스타트하는 함수
		function chatstop() {
			clearInterval(stoptimer);
			stoptimer = setInterval("stopChatTimer()", timecount);

			$.ajax({
				url : "nochatstart.do",
				type : "get",
				data : "id=" + $("#name").val() + "&no_count=" + nocount,
				success : function(data) {
					//alert(data);
				},
				error : function(req, status, error) {
					alert("error");
				}
			});
		}
		//기다렸다가 채팅금지 풀어주는 함수
		function stopChatTimer() {

			clearInterval(stoptimer);
			stoptimer = 0;

			$.ajax({
				url : "nochatend.do",
				type : "get",
				data : "id=" + $("#name").val(),
				success : function(data) {
					//alert(data);
					alert("채팅금지가 풀렸습니다.");
				},
				error : function(req, status, error) {
					alert("error");
				}
			});
		}

		//2초간 재는 타이머 스타트시키는함수
		function chatinterval() {
			clearInterval(time);

			time = setInterval("chatTimer()", 3000);
		}
		// 2초에 한번씩 실행되는 함수
		function chatTimer() {

			blackcount = 0;
			timestatus = true;
		}

		$(function() {
			$("form").on('submit', function(e) {
				e.preventDefault();
			});
			connect();
			chatinterval();
			if (nowstatus != 0) {
				chatstop();
			}

			$("#chatSend").click(
					function() {
						if ($("#chatMessage").val().trim() != ""
								&& stoptimer == 0 && blackcount < 5) {
							sendChat();
							blackcount++;
						}
					});
			// 엑스버튼으로 채팅창 끌때 동작
			$(window).bind('beforeunload', function() {

				disconnect();
				//return '변경된 사항이 있습니다. 페이지에서 나가시겠습니까?';

			});

			


		});
		
	</script>


</body>
</html>





