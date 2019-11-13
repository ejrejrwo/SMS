<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	
	<style type="text/css">
		td, th {
			text-align: left
		}
	</style>
</head>
<body>
	<input type="hidden" id="seq" value="${seq}">
	<table style="margin: 10px auto;">
		<tr>
			<th>
				받은이 <label class="form-control" >${msgDTO.send_id}</label>
			</th>
		</tr>	
		<tr>
			<th>
				읽은시간
				<c:if test="${empty msgDTO.rdate}">
				<label class="form-control">미열람</label>
				</c:if>
				<c:if test="${not empty msgDTO.rdate}">
					<label class="form-control">${msgDTO.rdate}</label>
				</c:if>
			</th>
		</tr>
		<tr>
			<th>
				내용
				<textarea class="form-control" cols="41" rows="13" readonly="readonly">${msgDTO.content}</textarea>
			</th>
		</tr>
	</table>
	
	<table style= "margin: 10px auto;">
		<tr>
			
			<td style="text-align: center;">
				<button type="button" id="delBtn" class="btn btn-danger">삭제</button>
			</td>
		</tr>
	</table>
	<script type="text/javascript">
		$(function() {
			
			var seq = $("#seq").val();
			
			$("#delBtn").click(function () {
				location.href="myPageSendMessageDelete.do?seq=" + seq
			});
	
		});
	</script>
</body>
</html>