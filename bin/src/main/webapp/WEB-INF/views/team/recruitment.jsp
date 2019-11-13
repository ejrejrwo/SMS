<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authentication var="user" property="principal" /> 
<!DOCTYPE html>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

<link rel="stylesheet" href="/css/bootstrap.css">

<script type="text/javascript" src="/js/jquery.cookie.js"></script>

<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" />

<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>

<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
  <!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    

<meta charset="UTF-8">
<title>팀 모집 글 쓰기</title>
</head>
<body>
<form action="recruitmentAf.do" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<table class="table table-hover">

<tr>
	<th>팀이름</th>
	<td>
		<input type="text" readonly="readonly" class="form-control" name="team_name" id="_team_name" value="${teamdetail.team_name }">
	</td>
</tr>
<tr>
	<th>팀장</th>
	<td>
		<input type="text" readonly="readonly" class="form-control" name="id" id="_id" value="${user.username}">
	</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" class="form-control" name="content" id="_content">
	</td>
</tr>
<tr>
	<td colspan="2">
		<!-- <input id="_btn" type="submit" value="팀모집글 작성"> -->
		<button type="button" class="btn btn-primary" id="_btn1">팀모집글 작성</button>
	</td>
</tr>

</table>

</form>

<script type="text/javascript">
	
$(document).ready(function () {
	$(document).on("click", "#_btn1", function () {
		var team_name = $("#_team_name").val();
		var id = $("#_id").val();
		var content = $("#_content").val();
		if( content == "" ){
			alert("내용을 입력해주세요.");
		}else{
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$(document).ajaxSend(function(e, xhr, options) {
			    xhr.setRequestHeader(header, token);
			});
		 	$.ajax({
				url: "recruitmentAf.do",
				type: "POST",
				data: {team_name:team_name, id:id, content:content},
				dataType: "text",
				success:function (data){
					if(data.trim() == "저장완료"){
						alert("팀원 모집글 작성 완료");
						opener.parent.location.reload();
						window.close();
					}
				},
				error: function () {
					alert("error");
				}
			}); 
			
		
		}
		/* location.href="recruitmentAf.do?team_name=" + team_name + "&id=" + id
				+ "&title=" + title + "&content=" + content;
		opener.parent.location.reload();
		window.close();  */ 
	});	
});

</script>

</body>
</html>