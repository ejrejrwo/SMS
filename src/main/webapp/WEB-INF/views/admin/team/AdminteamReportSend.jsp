<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="/css/bootstrap.css">
<script type="text/javascript" src="/js/jquery.cookie.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" />
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
</head>
<body>

	<div style="background-color: #f6f6f5">
	<label for="DetailReport" style="padding-left: 15px"><h3>팀 신고 사유</h3></label>
	</div>
	<div class="form-group" style="margin: auto" align="center">
		<div align="left" style="border-bottom: 1px solid #ddd; padding-bottom: 7px; border-top: 1px solid #ddd; padding-top: 7px;">
			<div style="margin-left: 10px">
				<strong>신고 팀 이름 :</strong> &nbsp;&nbsp;<span id="_team_name"></span><br><br>
				<strong>사유 선택 :</strong> &nbsp;&nbsp;<span style="color: gray">여러 사유에 해당될 경우 대표적인 사유 1개를 선택 해 주세요</span>
			</div>
		</div>
		<div class="row" align="left" style="margin-top: 5px; margin-left: 120px; font-size: 15px">
			<div style="padding-left: 25px">
				<input type="radio" name="redioSelect" value="홍보성 글을 올렸습니다." id="ch1" class="pointer"> <label for="ch1" class="pointer"
					style="padding-left: 10px; padding-top: 5px;">홍보성 글을 올렸습니다.</label><br>
			</div>
			<div style="padding-left: 25px">
				<input type="radio" name="redioSelect" value="욕설이 심한 게시글 입니다." id="ch2" class="pointer"> <label for="ch2" class="pointer"
					style="padding-left: 10px; padding-top: 5px;">욕설이 심한 게시글 입니다.</label><br>
			</div>
			<div style="padding-left: 25px">
				<input type="radio" name="redioSelect" value="음란성 글을 올렸습니다." id="ch3" class="pointer"> <label for="ch3" class="pointer"
					style="padding-left: 10px; padding-top: 5px;">음란성 글을 올렸습니다.</label><br>
			</div>
		</div>
		<small id="reportHelp" class="form-text text-muted">관리자가 검토 하여 처리하겠습니다.</small><br>
		<button style="margin-top: 15px" class="btn btn-primary" onclick="TeamReportAf()" type="button">신고 하기</button>
		<button style="margin-top: 15px" class="btn btn-primary" type="button">취소</button>
	</div>

<script type="text/javascript">
var id = window.opener.document.getElementById("parentId").value;
var team_name = window.opener.document.getElementById("parentTeam_name").value;
document.getElementById("_team_name").innerHTML = team_name;

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$(document).ajaxSend(function(e, xhr, options) {
    xhr.setRequestHeader(header, token);
});

function TeamReportAf() {
	var radio_btn = document.getElementsByName("redioSelect");
	var radio_btn_check = 0;
	var radio_content;
	for (var i = 0; i < radio_btn.length; i++) {
		if(radio_btn[i].checked==true){
			radio_content = radio_btn[i].value;
			radio_btn_check++;
		}
	}
	
	if(radio_btn_check == 0){
		alert("선택 한 값이 없습니다.");
		return;
	}
	
	$.ajax({
		url: "../mypage/TeamReportAf.do",
		type: "POST",
		data : {id:id, team_name:team_name, content:radio_content, parent:team_name},
		dayaType : "text",
		success: function (resp) {
			alert(resp);
			window.close();
		},
		error: function () {
			alert("fail");
		}
	})
}
</script>
</body>
</html>

