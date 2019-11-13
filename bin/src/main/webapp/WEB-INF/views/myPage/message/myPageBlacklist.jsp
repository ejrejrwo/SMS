<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<meta charset="UTF-8">
	<style type="text/css">
		td {
			text-align: center;
		}
	</style>
	<title>Insert title here</title>
	
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

</head>
<body>
	<table class="table">
		<tr>
			<th style="text-align: center;">차단 아이디</th>
			<th style="text-align: center;">차단 날짜</th>
			<th style="text-align: center;">차단해제</th>
		</tr>
		<c:if test="${empty blacklist}">
			<tr>
				<td colspan="4">
					차단목록이 비어있습니다.
				</td>
			</tr>
		</c:if>
		<c:if test="${not empty blacklist}">
			<c:forEach items="${blacklist}" var="black" varStatus="vs">
				<tr class="trLengh">
					<td>
						${black.black_id}		
					</td>
					<td>
						${black.bdate}
					</td>
					<td>
						<button type="button" class="btn btn-danger" send_id="${black.black_id}">해제</button>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	
	<div>
		<jsp:include page="/WEB-INF/views/common/paging.jsp" flush="false">
			<jsp:param name="pageNumber" value="${pageNumber}" />
			<jsp:param name="totalRecordCount" value="${totalRecordCount}" />
			<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen}" />
			<jsp:param name="recordCountPerPage" value="${recordCountPerPage}" />	
		</jsp:include>
	</div>
	
	<form id="_frmFormSearch" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<table class="search-table" style="margin: auto;">
			<tr>
				<td style="padding-left: 5px">
					<input type="text" class="form-control" id="_s_keyword" name="s_keyword" value="${(empty s_keyword)?'':s_keyword}">
				</td>
				<td style="padding-left: 5px">
					<span class="button blue">
						<button type="button" id="_btnSearch"  class="btn btn-default">검색</button>
					</span>
				</td>			
			</tr>
		</table>
		
		<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber }">
		<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage)?0:recordCountPerPage }">
		<input type="hidden" name="id" value="${id}">
	</form>
	
	<script type="text/javascript">
		
		// 페이징
		function goPage( pageNumber ) {
			$("#_pageNumber").val(pageNumber);
			$("#_frmFormSearch").attr("action", "myPageBlacklist.do").submit();	
		}
	
		$(function () {
			$(".btn-danger").click(function () {
				var send_id = $(this).attr('send_id');
				var tableData = $(this).parent().parent();
				
				var trLengh = $(".trLengh").length;
				
				console.log("trLengh" + trLengh);
				console.log("send_id:" + send_id)
				$.ajax({
					url : "myPageBlacklistDelete.do",
					type : "get",
					data : {
						send_id : send_id
					},
					success : function() {
						console.log("blacklistDelete() ajax Suc ");
						
						if(trLengh == 1) {
							window.location.reload();							
						}else {
							tableData.remove();
						}
					},
					error : function() {
						console.log("blacklistDelete() ajax 오류 In");
					}
				});
			});
			
			// 검색
			$("#_btnSearch").click(function () {
				//alert("_btnSearch click");
				$("#_pageNumber").val(0);
				$("#_frmFormSearch").attr("action", "myPageBlacklist.do").submit();	
			});
			
		});
	</script>
</body>
</html>