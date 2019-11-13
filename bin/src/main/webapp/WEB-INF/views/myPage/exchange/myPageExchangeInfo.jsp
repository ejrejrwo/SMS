<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<script type="text/javascript" src="/js/myPage/exchange/myPageExchangeInfo.js"></script>
	<link rel="stylesheet" href="/css/myPage/exchange/myPageTable.css">
</head>
<body>

	<table class="table table-hover table-responsive">
		<tr>
			<th>은행</th>
			<th>계좌번호</th>
			<th>환전금액</th>
			<th>요청날짜</th>
			<th>여부</th>
		</tr>
		<c:if test="${empty exchangeList}">
			<tr>
				<td colspan="5" align="center">환전 요청이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${not empty exchangeList}">
			<c:forEach items="${exchangeList}" var="ex" varStatus="vs">
				<tr>
					<td>
						${ex.bank}
					</td>
					<td>
						${ex.bank_number}
					</td>
					<td>
						${ex.exchange_money}원
					</td>
					<td>
						${ex.exdate}
					</td>
					<td>
						${ex.ex_check eq 0?'미지급':'지급'}
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