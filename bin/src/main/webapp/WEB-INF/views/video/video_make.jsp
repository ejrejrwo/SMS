<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="user" property="principal" /> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.filebox input[type="file"] { 
	position: absolute; 
	width: 1px; 
	height: 1px; 
	padding: 0; 
	margin: -1px; 
	overflow: hidden; 
	clip:rect(0,0,0,0); 
	border: 0; 
} 
.filebox label { 
	display: inline-block; 
	padding: .5em .75em; 
	color: #fff; 
	font-size: inherit; 
	line-height: normal; 
	vertical-align: middle; 
	background-color: #428bca; 
	cursor: pointer; 
	border: 1px solid #ebebeb; 
	border-bottom-color: #e2e2e2; 
	border-radius: .25em; 
} 

/* named upload */ 
.filebox .upload-name { 
	display: inline-block; 
	padding: .5em .75em; /* label의 패딩값과 일치 */ 
	font-size: inherit; 
	font-family: inherit; 
	line-height: normal; 
	vertical-align: middle; 
/* 	background-color: #f5f5f5;  */
	border: 1px solid #BDBDBD;  
	border-radius: .25em; 
	-webkit-appearance: none; /* 네이티브 외형 감추기 */ 
	-moz-appearance: none; 
	appearance: none; 
}

.title{
	display: inline-block; 
	width: 395px; 
	height: 32px;  
	outline: none;
	line-height: normal;
	border: 1px solid #BDBDBD;  
	border-radius: .25em;
	margin-top: 10px;
}

textarea {
	width: 500px; 
	height: 150px;
	margin-top: 10px; 
	border: 1px solid #BDBDBD;  
	resize: none;
}

h3{
	color: black;
    font-size: 35px;
    text-align: center;
    padding-bottom: 50px;
    font-weight: 400;
}
</style>

</head>
<body>

<div id="_top">
	동영상 올리기
</div>

<div class="container" style="width: 600px; height: 300px" align="left">

	<form action="" id="frmVmake" method="post" enctype="multipart/form-data">
	<!-- 시큐리티 -->
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	
	<table>
	<tr>
		<td>
			<div class="filebox">
				<input class="upload-name" value="파일선택" style="float: left;">
			
				<label for="ex_filename" style="float: left;">업로드</label>
				<input type="file" id="ex_filename" name="fileload" class="upload-hidden" style="float: left;" accept="video/*">
				<div style="float: left;">
				&nbsp;※ 파일은 50MB까지 가능합니다  <br> &nbsp;※ mp4, avi, mpeg 파일 가능합니다
				</div>
			</div>
		</td>
	</tr>
	
	<tr>
		<td>
			<select id="category" name="category" style="width: 100px; outline: none; height: 32px; border-radius: .25em; ">
				<option value="default">종목선택</option>
				<option value="축구">축구</option>
				<option value="야구">야구</option>
				<option value="농구">농구</option>
				<option value="탁구">탁구</option>
				<option value="배드민턴">배드민턴</option>	
				<option value="토너먼트">토너먼트</option>			
			</select>
			
			<input type="text" class="title" name="title">
			<input type="hidden" name="id" value="${user.username}">
		</td>
	</tr>

	<tr>
		<td>
			<textarea name="content" style="border-radius: .25em;"></textarea>
		</td>
	</tr>
	
	
	</table>
	
	<button type="button" id="vmBtn" class="btn btn-default">올리기</button>
	
	</form>
</div>

<script type="text/javascript">
$("#menu4").css("background-color","#e60013");

var fileTarget = $('.filebox .upload-hidden');

fileTarget.on('change', function(){
    if(window.FileReader){
        var filename = $(this)[0].files[0].name;
    } else {
        var filename = $(this).val().split('/').pop().split('\\').pop();
    }

    $(this).siblings('.upload-name').val(filename);
        
});


$("#vmBtn").click(function () {
	var filename = $(".upload-name").val();
//	alert(filename);
	
	var ex = filename.split(".")[1];
//	alert(ex);
	if(ex == 'mp4' || ex == 'avi' || ex == 'mpeg'){
		$("#frmVmake").attr("action","videomakeAf.do").submit();
	}else{
		alert("확장자명을 확인해주세요");
		return;
	}
		
})





</script>


</body>
</html>