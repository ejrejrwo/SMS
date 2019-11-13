<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="user" property="principal" />

<!-- ckeditor 가져오기 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" type="text/css" href="/css/bbsWrite.css">
<style type="text/css">
#_s_category {
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
	background: url(이미지 경로) no-repeat 95% 50%; /* 화살표 모양의 이미지 */
} /* IE 10, 11의 네이티브 화살표 숨기기 */
select::-ms-expand {
	display: none;
}

#_s_category {
	width: 100px; /* 원하는 너비설정 */
	padding: .4em .3em; /* 여백으로 높이 설정 */
	font-family: inherit; /* 폰트 상속 */
	background:
		url(https://farm1.staticflickr.com/379/19928272501_4ef877c265_t.jpg)
		no-repeat 95% 50%; /* 네이티브 화살표 대체 */
	border: 1px solid #999;
	border-radius: 0px; /* iOS 둥근모서리 제거 */
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
}

.table>tbody>tr>th{
	text-align: center;
	vertical-align: middle;
}

#_tooBar{
    width: 100%;
    height: auto;
    padding: 0 0 3% 0;
    text-align: center;
    border-bottom: 3px solid black;
    font-size: 40px;
}
#_tooBar::after{
    content: "";
    display: block;
    width: 50px;
    border-bottom: 1px solid #bcbcbc;
    margin: 5px auto;
}
</style>


<div class="card-body">
	<div id="_tooBar">
		팀 게시글 작성
	</div>
	<div class="table-responsive" style="display: flex; justify-content: center; align-items: center;">
		<form class="form-horizontal" role="form" id="editorForm" method="post" action="/">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<!-- 팀 이름과 아이디를 넣어야 할 곳 -->
			<input type="hidden" name="id" value='${user.username}'> <input type="hidden" name="team_name" value="${team_name }">

			<table class="table table-bordered" style="width: 100%; margin-top: 3%" cellspacing="0">
				<col width="100em">
				<col width="800em">
				<tr>
					<th>카테고리</th>
					<td align="left" style="padding-left: 5px"><select name="subject_category" id="_s_category" style="width: 150px;">
							<option value="선택" selected="selected">선택</option>
							<option value="공지">공지</option>
							<option value="일반">일반</option>
							<option value="후기">후기</option>
							<option value="전술">전술</option>
					</select></td>
				</tr>
				<tr>
					<th>제 &nbsp;&nbsp;&nbsp;&nbsp; 목</th>
					<td align="left" style="padding-left: 5px"><input type="text" name="title" size="50px" class="form-control"></td>
				</tr>
				<tr>
					<th colspan="2" align="center">내&nbsp;&nbsp;&nbsp;용</th>
				</tr>
				<tr>
					<th colspan="2"><textarea name="content" id="ckeditor"></textarea></th>
				</tr>
				<tr>
					<td colspan="2" style="text-align: left">
						<button type="button" id="confirm" class="btn btn-primary" >글 쓰기</button>
						<button type="button" id="cancel" class="btn btn-danger" style="float: right;">돌아가기</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>





<script>
$("#menu4").css("background-color","#e60013");
	$(function() {
		CKEDITOR
				.replace(
						'ckeditor',
						{//해당 이름으로 된 textarea에 에디터를 적용
							width : '100%',
							height : '400px',
							filebrowserImageUploadUrl : '${path }teambbsupload.do?${_csrf.parameterName}=${_csrf.token}'
						});
		CKEDITOR.editorConfig = function(config) {
			config.removePlugins = 'easyimage, cloudservices';
			config.language = 'ko';
		};
	});

	$("#confirm").on('click', function() {
		var title = $("input[name='title']").val();
		var category = $("#_s_category").val();
		if (category == "선택") {
			alert("카테고리를 선택 해 주세요");
			$("#_s_category").focus();
		} else if (title == null || title == "") {
			alert("제목을 입력 해 주세요");
			$("input[name='title']").focus();
		} else if (title.length < 4){
			alert("제목은 4글자 이상 입력해 주세요");
			$("input[name='title']").focus();
		} else if (title.length > 40){
			alert("제목은 40글자 이하로 입력해 주세요");
			$("input[name='title']").focus();
		}
		else {
			$("#editorForm").attr('action', 'BbswriteAf.do').submit();
		}
	});

	$("#cancel").on('click', function() {
		//	alert("취소 클릭");
		location.href = '../common/teamBbs.do';
	});
</script>