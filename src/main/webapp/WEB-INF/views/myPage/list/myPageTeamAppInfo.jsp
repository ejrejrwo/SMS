<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<% String ctx = request.getContextPath(); %>
	
	<script type="text/javascript" src="<%=ctx%>/js/myPage/list/myPageTeamAppInfo.js"></script>
	<link rel="stylesheet" href="<%=ctx%>/css/myPage/list/myPageTeamAppInfo.css">
</head>
<body>
	<table class="table table-responsive">
		<col width="10%"><col width="20%"><col width="50%"><col width="20%">
		<tr>
			<th>번호</th>
			<th>팀 이름</th>
			<th>내용</th>
			<th>삭제</th>
		</tr>
		<c:if test="${empty teamAppList}">
			<tr>
				<td colspan="4" align="center">신청 내역이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty teamAppList}">
			<c:forEach items="${teamAppList}" var="teamApp" varStatus="vs">
				<tr>
					<td>
						${vs.count}
					</td>
					<td>
						${teamApp.team_name}
					</td>
					<td>
						${teamApp.content}
					</td>
					<td>
						<button type="button" id="delBtn" class="btn btn-danger" onclick="teamAppDelete('${teamApp.team_name}', '${teamApp.seq}')">삭제</button>
					</td>
				</tr>	
			</c:forEach>
		</c:if>
	</table>
	
	<form id="_frmFormSearch" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber }">
		<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage)?0:recordCountPerPage }">
		<input type="hidden" name="id" value="${id}">
	</form>
	
	<div>
		<jsp:include page="/WEB-INF/views/common/paging.jsp" flush="false">
			<jsp:param name="pageNumber" value="${pageNumber }" />
			<jsp:param name="totalRecordCount" value="${totalRecordCount }" />
			<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }" />
			<jsp:param name="recordCountPerPage" value="${recordCountPerPage }" />	
		</jsp:include>
	</div>
	
</body>
</html>