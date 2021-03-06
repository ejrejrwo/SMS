<%@page import="com.boot.finalpro.util.utilMethod"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/css/TeamBbsCSS.css">
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="user" property="principal" />

<style type="text/css">
th{
	text-align: center;
	background-color: #042e6f;
	color: #fff;
}

.table>tbody>tr>td{
	border-top: 0;
	border-bottom: 1px solid #e5e5e5;
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

<div class="content-area">
	<div id="_tooBar">
		팀 게시글 리스트
	</div>
	<div class="serach-category1" style="margin-top: 5px; margin-bottom: 20px; float: right;">
		<form name="frmForm1" id="_frmFormSearch" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<table style="margin-left: auto; margin-right: auto; margin-top: 5px; margin-bottom: 3px;">
				<tr>
					<td style="padding-left: 5px"><select id="_subject_category" name="s_category" style="height: 2.7em; width: 5.2em">
							<option value="">분류</option>
							<option value="title" <c:if test="${s_category == 'title'}">selected='selected'</c:if> >제목</option>
							<option value="contents"<c:if test="${s_category == 'contents'}">selected='selected'</c:if>>내용</option>
							<option value="writer"<c:if test="${s_category == 'writer'}">selected='selected'</c:if>>작성자</option>
					</select></td>
					<td style="padding-left: 5px"><input type="text" id="_s_keyword" name="s_keyword" class="form-control" style="height: 2.8em" placeholder="검색어" <c:if test="${s_category ne 'subjectcategory'}">value='${s_keyword }' </c:if>></td>
					<td style="padding-left: 5px"><span class="button blue">
							<button type="button" id="_btnSerach" class="btn btn-default" style="height: 2.8em">검색</button>
					</span></td>
				</tr>
			</table>
			<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0: pageNumber}"> <input type="hidden" name="recordCountPerPage"
				id="_recordCountPerPage" value="${(empty recordCountPerPage)?0:recordCountPerPage }">
			<input type="hidden" id="_sub_keyword" name="sub_keyword" value="${sub_keyword }">	
			<input type="hidden" id="_subject_category" name="subject_category" value="${subject_category }">
		</form>
	</div>
	<div class="mainBbsList">
		<form>
			<table class="table table-hover table-responsive">
				<colgroup>
					<col width="50">
					<col width="150">
					<col width="30">
					<col width="50">
					<col width="35">
					<col width="35">
				</colgroup>
				<thead align="center">
					<tr>
						<th style="border-top: 2px solid #373e48;">
							<select id="subjectcategory" name="subject_category" onchange="cat()" style="background-color: #042e6f; font-weight: 600; font-size: 14px; border: none; outline: none; cursor: pointer;">
								<option value="">분류</option>
								<option value="">All</option>
								<option value="공지" <c:if test="${sub_keyword == '공지'}">selected='selected'</c:if> >공지</option>
								<option value="일반" <c:if test="${sub_keyword == '일반'}">selected='selected'</c:if> >일반</option>
								<option value="후기" <c:if test="${sub_keyword == '후기'}">selected='selected'</c:if> >후기</option>
								<option value="전술" <c:if test="${sub_keyword == '전술'}">selected='selected'</c:if> >전술</option>
							</select>
						</th>
						<th style="border-top: 2px solid #373e48;">제목</th>
						<th style="border-top: 2px solid #373e48;">ID</th>
						<th style="border-top: 2px solid #373e48;">등록일</th>
						<th style="border-top: 2px solid #373e48;">좋아요</th>
						<th style="border-top: 2px solid #373e48;">조회수</th>
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
							<td><a href="../member/teamBbsdetail.do?seq=${bbs.seq }">${bbs.title }</a></td>
							<td>${bbs.id }</td>
							<td>${bbs.wdate }</td>
							<td>${bbs.like_count }</td>
							<td>${bbs.read_count }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
	</div>
	<div align="right">
		<button type="button" onclick="location.href='../member/Bbswrite.do'" class="btn btn-default" style="width: 6em; height: 3em">글쓰기</button>
	</div>
	<div class="Bbspaging" style="font-size: 25px;">
		<jsp:include page="/WEB-INF/views/teamBbs/paging.jsp" flush="false">
			<jsp:param name="pageNumber" value="${pageNumber }" />
			<jsp:param name="totalRecordCount" value="${totalRecordCount }" />
			<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }" />
			<jsp:param name="recordCountPerPage" value="${recordCountPerPage }" />
		</jsp:include>
	</div>
</div>

<script type="text/javascript">

	$("#menu4").css("background-color", "#e60013");
	function goPage(pageNumber) {
		$("#_pageNumber").val(pageNumber);
		$("#_frmFormSearch").attr("action", "teamBbs.do").submit();
	}

	$("#_btnSerach").on('click', function() {
		var category = $("#_s_category").val();
		var keyword = $("#_s_keyword").val();
		if (category == "") {
			$("#_pageNumber").val("0");
			$("#_frmFormSearch").attr("action", "teamBbs.do").submit();
		} else if (keyword == null || keyword == "") {
			//	alert("클릭");
			alert("검색 할 내용이 없습니다.");
			$("#_s_keyword").focus();
		} else {
			$("#_pageNumber").val("0");
			$("#_frmFormSearch").attr("action", "teamBbs.do").submit();
		}
	});
	
	function cat() {
		var sub_keyword = document.getElementById("subjectcategory").value;
		
		location.href="teamBbs.do?subject_category=subjectcategory&sub_keyword=" + sub_keyword;
	}
	

</script>
