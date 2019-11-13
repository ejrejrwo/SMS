<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/TeamBbsCSS.css">

<!-- arrow 생성 -->
<jsp:useBean id="ubbs" class="com.boot.finalpro.teambbs.util.TeamBbsArrow"
	scope="page" />


<div class="card-body">
	<div class="table-responsive">
		<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
			<div class="row">
				<div class="col-sm-12">

					<table class="table table-bordered dataTable">
						<col width="10%"><col width="90%">
						<tr>
							<th>아이디</th>
							<td>${teamVo.wdate }</td>
						</tr>
						<tr>
							<th>작성 시간</th>
							<td>${teamVo.id }</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>${teamVo.content }</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div style="padding-top: 50px">
		<form method="get" id="commentMuldel">
			<table class="table table-bordered dataTable">
				<tr>
					<th>아이디</th>
					<th>내용</th>
					<th>작성시간</th>
					<th>신고수</th>
					<td align="center"><input type="checkbox" id="parentcheck"></td>
				</tr>
				<c:forEach items="${bbscommentdto }" var="comment" varStatus="vs">
					<c:if test="${comment.del eq 0 }">
						<jsp:setProperty property="depth" name="ubbs"
							value="${comment.depts }" />
						<tr>
							<td>${comment.id }</td>
							<td><jsp:getProperty property="arrow" name="ubbs" /> <span
								style="color: gray">${comment.reply_id } </span>
								${comment.content }</td>
							<td>${comment.wdate }</td>
							<td><a
								href="AdminTeamBbsCommentReportContent.do?seq=${comment.seq }"
								onclick="window.open(this.href, '_blank', 'width=1000px,height=800px,toolbars=no,scrollbars=no'); return false;">신고내역
									보기 ${comment.report_count }회</a></td>
							<td align="center"><input type="checkbox"
								value="${comment.seq }" name="childcheck"
								style="cursor: pointer"></td>
						</tr>
					</c:if>
					<c:if test="${comment.del eq 1 }">
						<tr>
							<td colspan="5">삭제 된 댓글입니다.</td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
		</form>
		<div align="right">
			<button type="button" id="_muldel" class="btn btn-primary">댓글
				삭제</button>
			<button type="button" id="_backList" class="btn btn-primary">돌아가기</button>
		</div>
	</div>
</div>



<script>
	$(document).ready(
			function() {

				// 체크 하면 전체 체크 됐다가 안됐다가 하는 jquery문
				$("#parentcheck").click(function() {
					if ($("#parentcheck").prop("checked")) {
						$("input[name=childcheck]").prop("checked", true);
					} else {
						$("input[name=childcheck]").prop("checked", false);
					}
				});

				$("#_backList").on('click', function() {
					location.href = 'admin_bbs.do';
				});

				$("#_muldel").on(
						'click',
						function() {
							alert("클릭");
							var checks = $("input[name='childcheck']");
							var isChecked = false;

							for (var i = 0; i < checks.length; i++) {
								if (checks.eq(i).prop("checked")) {
									isChecked = true;
								}
							}

							if (!isChecked) {
								alert("삭제 항목을 선택해 주세요");
								return;
							}
							$("#commentMuldel").attr("action",
									"DeleteTeamBbsComment.do").submit();
						});
			});
</script>