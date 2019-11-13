<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="css/TeamBbsCSS.css">

<div class="content-area">
	<form id="deleteForm" method="post">
		<input type="hidden" value="${commentSeq }" name="commentseq">
		<input type="hidden" value="${commentId }" name="commentid">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<table class="table table-bordered dataTable">
			<thead>
				<tr>
					<th>신고자 아이디</th>
					<th>신고 내용</th>
					<th><input type="checkbox" id="parentcheck"> 허위신고 반환</th>
				</tr>
			</thead>
			<c:if test="${empty commentreportlist }">
				<tbody>
					<tr>
						<td colspan="2">신고 내용이 없습니다.</td>
					</tr>
				</tbody>
			</c:if>
			<c:if test="${not empty commentreportlist }">
				<c:forEach items="${commentreportlist }" var="Rlist" varStatus="vs">
					<tbody>
						<tr>
							<td>${Rlist.id }</td>
							<td>${Rlist.content }</td>
							<td align="center"><input type="checkbox" value="${Rlist.seq }" name="childcheck" style="cursor: pointer">
						</tr>
					</tbody>
				</c:forEach>
			</c:if>
		</table>
	</form>
	<div align="right">
		<button type="button" id="_muldel" class="btn btn-primary">삭제</button>
	</div>
</div>

<script>
//추가
         $(window).on('beforeunload', function(){
        	 opener.parent.location.reload();
            //return '변경된 사항이 있습니다. 페이지에서 나가시겠습니까?';
         });
	// 체크 하면 전체 체크 됐다가 안됐다가 하는 jquery문
	$("#parentcheck").click(function() {
		if ($("#parentcheck").prop("checked")) {
			$("input[name=childcheck]").prop("checked", true);
		} else {
			$("input[name=childcheck]").prop("checked", false);
		}
	});
	$("#_muldel").on('click', function() {
				//  alert("클릭");
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
				$("#deleteForm").attr("action" , "AdminBbsCommentReportReply.do").submit();
			});
	
</script>
