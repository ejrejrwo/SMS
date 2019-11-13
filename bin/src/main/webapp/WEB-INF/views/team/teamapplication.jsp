<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="user" property="principal" />

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/ckeditor/ckeditor.js" ></script>
<style type="text/css">
.filebox input[type="file"] { position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip:rect(0,0,0,0); border: 0; } 
.filebox label { display: inline-block; margin-top:8px; padding: .5em .75em; color: #fff; font-size: inherit; line-height: normal; vertical-align: middle; background-color: #337ab7; cursor: pointer; border: 1px solid #ebebeb; border-color: #2e6da4; border-radius: .25em; }
.filebox .upload-name { display: inline-block; padding: .5em .75em; /* label의 패딩값과 일치 */ font-size: inherit; font-family: inherit; line-height: normal; vertical-align: middle; background-color: #f5f5f5; border: 1px solid #ebebeb; border-bottom-color: #e2e2e2; border-radius: .25em; -webkit-appearance: none; /* 네이티브 외형 감추기 */ -moz-appearance: none; appearance: none; }
.filebox .bs3-primary label {color: #fff;background-color: #337ab7;border-color: #2e6da4;}

#jb-container {
	width: 1200px;
	margin: 0px auto;
	padding: 20px;
}

</style>


<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="jb-container">
<div class="well">
<form action="teamapplicationAf.do" method="post" id="_frm" class="bs-example form-horizontal" enctype="multipart/form-data">
<fieldset>
		<legend>팀만들기</legend>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

	<div class="form-group">
		<label for="inputEmail" class="col-lg-3 control-label">팀이름</label>
		<div class="col-lg-5">
			<input type="text" name="team_name" id="_team_name" class="form-control" maxlength="10">
			<input type="hidden" id="_check" value="yes">
			
		</div>
		<button type="button" id="_get_tname" class="btn btn-primary" style="float: left;">팀이름중복확인</button>
	</div>
	<div class="form-group">
		<label for="inputEmail" class="col-lg-3 control-label">팀사진</label>
		<div class="col-lg-6">
			<div class='filebox'><br><input class='upload-name bs3-primary' value='파일선택' disabled='disabled'>
			<label for='ex_file' id="_fileUpload">업로드</label>
			<input type='file' name='file' id='ex_file' class='upload-hidden'>
		</div>
		</div>
	</div>
	<div class="form-group">
		<label for="inputEmail" class="col-lg-3 control-label">팀장명</label>
		<div class="col-lg-6">
			<input type="text" id="_leader" name="leader" value="${user.username}" class="form-control" readonly="readonly">
		</div>
	</div>
     <div class="form-group">
       <label for="inputTeam" class="col-lg-3 control-label">주종목</label>
       <div class="col-lg-6">
		<input type="hidden" id="_sel_sport">
		<select name="sport_category" id="_sport_category" class="form-control">
			<option>축구</option>
			<option>농구</option>
			<option>야구</option>
			<option>배드민턴</option>
			<option>탁구</option>
		</select>         
       </div>
     </div>
     <div class="form-group">
		<label for="inputEmail" class="col-lg-3 control-label">한줄소개</label>
		<div class="col-lg-6">
			<input type="text" id="_title" name="title" class="form-control" maxlength="30">
		</div>
	</div>
	<div class="form-group">
       <label for="textArea" class="col-lg-3 control-label">팀소개</label>
       <div class="col-lg-6">
         <textarea name="content" id="ckeditor"></textarea>
         <span class="help-block">작성하신 글은 팀소개탭에서 그대로 적용됩니다.</span>
       </div>
     </div>
     <div class="form-group">
     	<div class="col-lg-6 col-lg-offset-3">
     		<input type="button" id="_submit" value="팀신청하기" class="btn btn-primary">
     	</div>
     </div>
</fieldset>
</form>
</div>
</div>


<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$(document).ajaxSend(function(e, xhr, options) {
    xhr.setRequestHeader(header, token);
});
$(document).ready(function () {
	CKEDITOR.replace( 'ckeditor', {//해당 이름으로 된 textarea에 에디터를 적용
        width:'100%',
        height:'400px',
        filebrowserImageUploadUrl: '${path }teamupload.do?${_csrf.parameterName}=${_csrf.token}'
    });
    CKEDITOR.editorConfig = function( config ) {
        config.removePlugins = 'easyimage, cloudservices';         
        config.language = 'ko';
     };
	
	$("#menu1").css("background-color","#e60013");
	
	
	$(document).on("click", "#_submit", function () {
		var check=$("#_check").val();
		var title=$("#_title").val();
		var content=$("#ckeditor").val();
		var desc = CKEDITOR.instances['ckeditor'].getData();
		alert($(".upload-name").val());
		if($(".upload-name").val() == "파일선택"){
			alert("들어옴");
			$("#ex_file").remove();
		}
		if(check == "yes"){
			alert("팀명중복체크해주세요");
		}else{
			if(title == "" || title == null || desc == "" || desc == null){
				alert("빈칸을 채워주세요");
			}else{
					
				$("#_frm").submit();
			}
		}
	});
	
	$("#_fileUpload").on("click",function(){
		var fileTarget = $('.filebox .upload-hidden');

		fileTarget.on('change', function(){ // 값이 변경되면 
			if(window.FileReader){ // modern browser 
				var filename = $(this)[0].files[0].name; } 
			else { // old IE 
				var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
				} 
			// 추출한 파일명 삽입 
			$(this).siblings('.upload-name').val(filename);
			});
		});
	
});

$("#_get_tname").click(function () {
	var team_name=$("#_team_name").val();
	if(team_name == "" || team_name == null){
		alert("팀명을 입력해주세요");
	}else{
		$.ajax({
			url:"get_tname.do",
			type:"post",
			data:{team_name:team_name},
			success:function(msg){
				
				if(msg == 'YES'){
					//alert("msg == YES");
					alert("사용불가능합니다.");
					$("#_team_name").val("");
				}else{
					//alert("msg == NO");
					alert("사용가능합니다.")
					$("#_check").val("no");
				}
			},
			error:function(){
				alert("error");
			}
		});
	}
});

</script>


</body>
</html>