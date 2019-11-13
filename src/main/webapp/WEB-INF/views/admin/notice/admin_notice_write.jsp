<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<link rel="stylesheet" type="text/css" href="/css/bbsWrite.css">
</head>
<body>

	<div class="card-body">
		<div class="table-responsive"
			style="display: flex; justify-content: center; align-items: center;">
			<form action="noticeWriteAf.do" id="_frmForm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
				<table class="table table-bordered" id="dataTable"
					style="width: 50%; margin-top: 3%" cellspacing="0">
					<colgroup>
						<col width="15%">
						<col width="85%">
					</colgroup>
					<tr>
						<th style="text-align: center">작성자</th>
						<td><input type="text" class="form-control"
							readonly="readonly" value="${adminId }" name="id" style="width: auto;"></td>
					</tr>
					<tr>
						<th style="text-align: center">제목</th>
						<td><input type="text" name="title" class="form-control"></td>
					</tr>
					<tr id="_fileTr">
						<td colspan="2"><button type="button" id="_fileUpload"
								class="btn btn-default">파일 추가하기</button>
							<br></td>
					</tr>
					<tr>
						<td colspan="2">
							<p>내용</p> <textarea rows="10" cols="50" name="content"
								id="p_content"></textarea> <script type="text/javascript">
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
						<th colspan="2"><button type="button" id="_submit"class="btn btn-primary">작성</button>
							<button type="button" style="float: right;"class="btn btn-danger">취소</button></th>
					</tr>
				</table>
			</form>
		</div>
	</div>



	<script src="/admin-js/admin-noticeWrite.js"></script>
</body>
</html>