<%@page import="com.boot.finalpro.util.utilMethod"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">

<style type="text/css">
table td {
	text-align: center;
}

</style>

<div class="card-body">
	<div class="table-responsive">
		<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
			<div class="row">
				<div class="col-sm-12">
					<form id="deleteForm" method="post">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
						<table class="table table-bordered dataTable">
							<colgroup>

							</colgroup>
							<thead align="center">
								<tr>
									<th>분류</th>
									<th>팀명</th>
									<th>제목</th>
									<th>ID</th>
									<th>등록일</th>
									<th>좋아요</th>
									<th>조회수</th>
									<th>신고수</th>
									<th>댓글 신고수</th>
									<th><input type="checkbox" id="parentcheck"></th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty bbsList }">
									<tr>
										<td colspan="6" align="center">등록 된 글이 없습니다.</td>
									</tr>
								</c:if>

								<c:forEach items="${bbsList }" var="bbs" varStatus="vs">

									<tr>
										<td>${bbs.subject_category}</td>
										<td>
										${bbs.team_name }
										</td>
										<td><a href="AdminteamBbsdetail.do?seq=${bbs.seq }">${bbs.title }</a>
										</td>
										<td>${bbs.id }</td>
										<td>${bbs.wdate }</td>
										<td>${bbs.like_count }</td>
										<td>${bbs.read_count }</td>
										<td><a
											href="AdminTeamBbsReportContent.do?seq=${bbs.seq }"
											onclick="window.open(this.href, '_blank', 'width=1000px,height=800px,toolbars=no,scrollbars=no'); return false;">신고내역
												보기 ${bbs.report_count }회</a> <%-- <a href="getmatchinglist.do?seq_game=${game.seq_game }" onclick="window.open(this.href, '_blank', 'width=500px,height=500px,toolbars=no,scrollbars=no'); return false;">신청메세지보기</a> --%>
										</td>
										<td>${bbs.comment_report_count }</td>
										<td align="center"><input type="checkbox"
											value="${bbs.seq }" name="childcheck" style="cursor: pointer"></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</form>
					<div align="right">
						<button type="button" id="_muldel" class="btn btn-primary">삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="Bbspaging" style="font-size: 25px">
	<jsp:include page="/WEB-INF/views/teamBbs/adminpaging2.jsp" flush="false">
		<jsp:param name="pageNumber" value="${pageNumber }" />
		<jsp:param name="totalRecordCount" value="${totalRecordCount }" />
		<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }" />
		<jsp:param name="recordCountPerPage" value="${recordCountPerPage }" />
	</jsp:include>
</div>
<div class="serach-category"
	style="margin-top: 5px; margin-bottom: 10px">

	<form name="frmForm1" id="_frmFormSearch" method="get">
		<table
			style="margin-left: auto; margin-right: auto; margin-top: 3px; margin-bottom: 3px">
			<tr>
				<td style="padding-left: 5px"><select id="_subject_category" name="s_category" style="height: 2.8em;">
						<option value="" selected="selected">선택</option>
						<option value="title">제목</option>
						<option value="contents">내용</option>
						<option value="writer">작성자</option>
				</select></td>
					<td style="padding-left: 5px"><input type="text" id="_s_keyword" name="s_keyword" class="form-control" style="height: 2.8em" placeholder="검색어" <c:if test="${s_category ne 'subjectcategory'}">value='${s_keyword }' </c:if>></td>
					<td style="padding-left: 5px"><span class="button blue">
							<button type="button" id="_btnSerach" class="btn btn-default" style="height: 2.8em">검색</button>
					</span></td>
			</tr>
		</table>
		<input type="hidden" name="pageNumber" id="_pageNumber"
			value="${(empty pageNumber)?0: pageNumber}"> <input
			type="hidden" name="recordCountPerPage" id="_recordCountPerPage"
			value="${(empty recordCountPerPage)?0:recordCountPerPage }">
	</form>
</div>



<script type="text/javascript">
	$("#_s_category").val("${s_category}").attr("selected", "selected");

	$("#_s_keyword").val("${s_keyword}");

	$(document).ready(function() {
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
			$("#deleteForm").attr("action", "DeleteTeamBbs.do").submit();
		});

	});
	function goPage(pageNumber) {
		$("#_pageNumber").val(pageNumber);
		$("#_frmFormSearch").attr("action", "admin_bbs.do").submit();
	}

	$("#_btnSerach").on('click', function() {
		var category = $("#_s_category").val();
		var keyword = $("#_s_keyword").val();
		if (category == "") {
			$("#_pageNumber").val("0");
			$("#_frmFormSearch").attr("action", "admin_bbs.do").submit();
		} else if (keyword == null || keyword == "") {
			//	alert("클릭");
			alert("검색 할 내용이 없습니다.");
			$("#_s_keyword").focus();
		} else {
			$("#_pageNumber").val("0");
			$("#_frmFormSearch").attr("action", "admin_bbs.do").submit();
		}
	});
</script>