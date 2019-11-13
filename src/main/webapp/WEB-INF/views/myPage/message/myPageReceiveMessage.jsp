<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>Insert title here</title>
		
		<% String ctx = request.getContextPath(); %>
		
		<script type="text/javascript" src="<%=ctx%>/js/myPage/message/myPageReceiveMessage.js"></script>
		<link rel="stylesheet" href="<%=ctx%>/css/myPage/message/myPageReceiveMessage.css">
	</head>
<body>
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
	<form id="deleteFrm" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<table class="table table-hover table-responsive">
			<col width="10%"><col width="25%"><col width="40%"><col width="25%">
			<tr>
				<td style="border: none">
					<button type="button" class="btn btn-danger" style="width: 92.8%;" id="delBtn">삭제</button>
				</td>
				<td style="text-align: left; border: none;">
					<button type="button" class="btn btn-default" id="black-btn">수신거부 현황</button>
				</td>
				<td colspan="3" style="border: none; text-align: right;">
					<button type="button" class="btn btn-default" id="sendBtn">쪽지작성</button>				
				</td>
			</tr>
			<tr>
				<th>
					<p>전체선택</p>
					<div class="switch_box box_1">
						<input type="checkbox" class="switch_1" id="msgAllCheck">
					</div>
				</th>
				<th>
					쪽지 번호
				</th>
				<th>
					작성자
				</th>
				<th >
					받은날짜
				</th>
			</tr>
			<c:if test="${empty msgList}">
				<tr>
					<td colspan="4">
						받은 쪽지가 없습니다.
					</td>
				</tr>
			</c:if>
			<c:if test="${not empty msgList}">
				<c:forEach items="${msgList}" var="msg" varStatus="vs">
					<c:if test="${msg.receive_del eq 0 }">
						<tr>
							<td class="check-td">
								<input type="checkbox" value="${msg.seq}" name="msgCheck">
							</td>
							<td class="detail" seq="${msg.seq}">
								${vs.count}
							</td>
							<td class="detail" seq="${msg.seq}">
								${msg.send_id}
							</td>
							<td class="detail" seq="${msg.seq}">
								${msg.wdate}
							</td>
						</tr>
					</c:if>
				</c:forEach>
			</c:if>		
		</table>
	</form>
	<br>
	
	<div class="page-div">
		<jsp:include page="/WEB-INF/views/common/paging.jsp" flush="false">
			<jsp:param name="pageNumber" value="${pageNumber}" />
			<jsp:param name="totalRecordCount" value="${totalRecordCount}"/>
			<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen}"/>
			<jsp:param name="recordCountPerPage" value="${recordCountPerPage}"/>	
		</jsp:include>
	</div>
	
	<br><br>
	
	<form id="_frmFormSearch" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="hidden" value="${s_category}" id="category">
		<table class="search-table">
			<col width="30%"><col width="50%"><col width="25%">
			<tr>
				<td style="padding-left: 5px">
					<select id="_s_category" name="s_category" class="form-control">
						<option value="" selected="selected">선택</option>
						<option value="contents">내용</option>
						<option value="writer">작성자</option>
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
		
		<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber }">
		<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage)?0:recordCountPerPage }">
		<input type="hidden" name="id" value="${id}" id="id">
	</form>
	
</body>
</html>