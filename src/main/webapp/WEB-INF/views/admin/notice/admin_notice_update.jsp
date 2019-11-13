<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" type="text/css" href="/css/bbsWrite.css">
</head>
<body>

	<div class="card-body">
		<div class="table-responsive"
			style="display: flex; justify-content: center; align-items: center;">
			<form action="admin_notice_updateAf.do" id="_frmForm" method="post"
				enctype="multipart/form-data">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input type="hidden" name="seq"
					value="${dto.seq }">
				<table class="table table-bordered" id="dataTable"
					style="width: 50%; margin-top: 3%" cellspacing="0">
					<colgroup>
						<col width="15%">
						<col width="85%">
					</colgroup>
					<tr>
						<th style="text-align: center">작성자</th>
						<td><input type="text" class="form-control"
							readonly="readonly" value="${dto.id }" name="id" style="width: auto;"></td>
					</tr>
					<tr>
						<th style="text-align: center">제목</th>
						<td><input type="text" name="title" class="form-control"
							value="${dto.title }"></td>
					</tr>
					<tr id="_fileTr">
						<td colspan="2"><button type="button" id="_fileUpload"
								class="btn btn-default">파일 추가하기</button>
							<br> <c:if test="${not empty fileList }">
								<c:forEach var="i" items="${fileList }" varStatus="vs">
									<div class='filebox delDiv' id="_del${vs.count }Dive"
										seq="${i.file_seq }">
										<br>
										<input class='upload-name bs3-primary'
											value='${i.originalName }' disabled='disabled'>
										<button type='button' class='fileDelBtn btn btn-danger'
											style='width: 100px; height: 41px; margin-left: 5%;'>삭제하기</button>
										<br>
									</div>
								</c:forEach>
							</c:if></td>
					</tr>
					<tr>
						<td colspan="2">
							<p>내용</p> <textarea rows="10" cols="50" name="content"
								id="p_content">${dto.content }</textarea> <script
								type="text/javascript">
									CKEDITOR
											.replace(
													'p_content',
													{
														height : 300,
														width : 600,
														filebrowserImageUploadUrl : '${path }imgUpload.do?${_csrf.parameterName}=${_csrf.token}'
													});
									CKEDITOR.editorConfig = function(config) {
										config.removePlugins = 'easyimage, cloudservices';
										config.language = 'ko';
									};
								</script>
						</td>
					</tr>
					<tr>
						<th colspan="2"><button type="button" id="_submit"
								class="btn btn-primary">수정</button>
							<button type="button" style="float: right;"
								class="btn btn-danger">뒤로가기</button></th>
					</tr>
				</table>
				<input type="hidden" name="seqDel">
			</form>
		</div>
	</div>



	<script src="/admin-js/admin-noticeUpdate.js"></script>
	<script type="text/javascript">
		$(".fileDelBtn").click(function() {
			/* alert(file_seq); */
			$(this).parent().css("display", "none");
			/* 	if(file_seq != null){
			 $.ajax({
			 type: "get",
			 url: "notice_file_delete.do",
			 data : "seq="+file_seq,
			 success:function(result){
			 alert('통신성공');
			 },
			 error:function(){
			 alert('통신실패');
			 }
			 });
			 } */

		});
	</script>
</body>
</html>