<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">

	<% String ctx = request.getContextPath(); %>

	<script type="text/javascript" src="<%=ctx%>/js/myPage/message/myPageSendMessage.js"></script>
	<link rel="stylesheet" href="<%=ctx%>/css/myPage/message/myPageSendMessage.css">
<title>Insert title here</title>
</head>
<body>
	
	<!-- <button type="button" id="sendBtn" class="btn btn-default">쪽지작성</button>
		<button type="button" id="myReceiveBtn" class="btn btn-default">수신함</button> -->
	
	<div id="msg-li">
		<div style="width: 50%; margin: 0px auto;">
			<div class="col-xs-6 col-md-6" style="padding: 0 0;">
		       	<label class="form-control" id="receiveMsg">수신함</label>
		   	</div>
		   	<div class="col-xs-6 col-md-6" style="padding: 0 0 ;">
				<label class="form-control" id="sendMsg">송신함</label>
		   	</div>
		</div>
	</div>	
	
	<div id="sendLetter" style="display: block;">
		<form id="deleteFrm" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<table class="table table-hover table-responsive">
				<col width="10%"><col width="25%"><col width="40%"><col width="25%">
				<tr>
					<td style="border: none">
						<button type="button" class="btn btn-danger" style="width: 92.8%;" id="delBtn">삭제</button>
					</td>
					<td colspan="4" style="border: none; text-align: right;">
						<button type="button" class="btn btn-default" id="sendBtn">쪽지작성</button>				
					</td>
				</tr>
				<tr>
					<th>
						<p>전체선택</p>
						<input type="checkbox" id="msgAllCheck">
					</th>
					<th>
						쪽지 번호
					</th>
					<th>
						받는이
					</th>
					<th>
						작성날짜
					</th>
				</tr>
			<c:if test="${empty msgList}">
				<tr>
					<td colspan="4">
						작성한 쪽지가 없습니다.
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty msgList}">
				<c:forEach items="${msgList}" var="msg" varStatus="vs">
						<tr>
							<td class="check-box">
								<input type="checkbox" value="${msg.seq}" name="msgCheck">
							</td>
							<td align="center"  class="detail" seq="${msg.seq}">
								${vs.count}
							</td>
							<td align="center"  class="detail" seq="${msg.seq}">
								${msg.receive_id}
							</td>
							<td align="center"  class="detail" seq="${msg.seq}">
								${msg.wdate}
							</td>
						</tr>
				</c:forEach>
			</c:if>		
			</table>
		</form>
	<br>
	
	<div>
		<jsp:include page="/WEB-INF/views/common/paging.jsp" flush="false">
			<jsp:param name="pageNumber" value="${pageNumber }" />
			<jsp:param name="totalRecordCount" value="${totalRecordCount }" />
			<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }" />
			<jsp:param name="recordCountPerPage" value="${recordCountPerPage }" />	
		</jsp:include>
	</div>
		
	<br><br>
		
		<form id="_frmFormSearch" method="post">
			<input type="hidden" value="${s_category}" id="category">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			<div>
				<table class="search-table">
					<col width="30%"><col width="50%"><col width="25%">
					<tr>
						<td style="padding-left: 5px">
							<select id="_s_category" name="s_category" class="form-control">
								<option value="" selected="selected">선택</option>
								<option value="contents">내용</option>
								<option value="writer">받는이</option>
							</select>
						<td style="padding-left: 5px">
							<input type="text" class="form-control" id="_s_keyword" name="s_keyword" value="${(empty s_keyword)?'':s_keyword}">
						</td>
						<td style="padding-left: 5px">
							<span class="button blue">
								<button type="button" id="_btnSearch" class="btn btn-default">검색</button>
							</span>
						</td>			
					</tr>
				</table>
			</div>
				<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber }">
				<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage)?0:recordCountPerPage }">
				<input type="hidden" name="id" value="${id}">
		</form>
	
	</div>
	

	
</body>
</html>