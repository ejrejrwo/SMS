<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
	
	<% String ctx = request.getContextPath(); %>
	
	<script type="text/javascript" src="<%=ctx%>/js/myPage/list/myPageBet.js"></script>
	<link rel="stylesheet" href="<%=ctx%>/css/myPage/list/myPageBet.css">
</head>
<body>

<table class="table table-hover table-responsive">
	<col width="85px"><col width="70px"><col width="140px"><col width="140px">
	<col width="90px"><col width="140px"><col width="140px"><col width="85px">
	<tr>
		<th>번호</th>
		<th>주제</th>
		<th>팀 A</th>
		<th>팀 B</th>
		<th>경기 일시</th>
		<th>승리팀</th>
		<th>배팅 팀</th>
		<th>배팅금액</th>
	</tr>
	<c:if test="${empty betList}">
		<tr>
			<td colspan="8">베팅 목록이 없습니다.</td>
		</tr>
	</c:if>
	<c:if test="${not empty betList}">
		<c:forEach items="${betList}" var="bet" varStatus="vs">
			<tr>
				<td>
					<p>${vs.count}</p>
				</td>
				<td>
					<p>${bet.category}</p>
				</td>
				<td>
					<p>${bet.name_team1}</p>
					<p>배당 :${(bet.payout_r1 eq 0.0)?'미정':bet.payout_r1}</p>
				</td>
				<td>
					<p>${bet.name_team2}</p>
					<p>배당 :${(bet.payout_r2 eq 0.0)?'미정':bet.payout_r2}</
				</td>
				<td>
					<p>${bet.gdate}</p>
				</td>
				<td>
					<p>${(empty bet.game_result)?'미정':bet.game_result}</p>
				</td>
				<td>
					<p>${bet.team_name}</p>
				</td>
				<td>
					<p>${bet.betting_money}원</p>
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