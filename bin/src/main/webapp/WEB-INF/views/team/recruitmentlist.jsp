<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>       
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
table{
	border-collapse: collapse;
}
th{
	background-color: #042E6F;
	color: white;
	padding: 15px;
	text-align: center;
}
td{
	border-bottom: 1px solid #A2AAC1;
	padding: 12px;
}

#jb-container {
	width: 1200px;
	margin: 0px auto;
	padding: 20px;
	
}

</style>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="jb-container">
<form action="" name="frmForm3" id="_frmFormSearch3" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<table class="table table-hover table-responsive">
<colgroup>
	<col width="80px"><col width="80px"><col width="100px"><col width="300px"><col width="100px">
</colgroup>

<thead>
<tr>
	<th>팀장명</th>
	<th>
	<select id="_sport" name="sport_category" onchange="chageSelectedValue()" style="background-color: #042e6f; font-weight: 600; font-size: 14px; border: none; outline: none; cursor: pointer;">
				<option value=""<c:if test="${empty sport_category }">selected='selected'</c:if>>모든종목</option>
				<option value="축구" <c:if test="${sport_category == '축구'}">selected='selected'</c:if> >축구</option>
				<option value="야구" <c:if test="${sport_category == '야구'}">selected='selected'</c:if>>야구</option>
				<option value="농구" <c:if test="${sport_category == '농구'}">selected='selected'</c:if>>농구</option>
				<option value="탁구" <c:if test="${sport_category == '탁구'}">selected='selected'</c:if>>탁구</option>	
				<option value="배드민턴" <c:if test="${sport_category == '배드민턴'}">selected='selected'</c:if>>배드민턴</option>				
			</select>	
	</th>
	<th>팀명</th><th>제목</th><th>날짜</th>
</tr>
</thead>
<c:if test="${empty recruitmentlist }">
	<tbody>
	<tr>
	<td colspan="5">
		작성된 글이 없습니다
	</td>
	</tr>
	</tbody>
</c:if>

<c:forEach items="${recruitmentlist }" var="relist" varStatus="vs">
<tbody>


<tr>
	<td>${relist.id }</td>
	<td>${relist.sport_category }</td>
	<td><a href="teamdetail.do?team_name=${relist.team_name }">${relist.team_name }</a></td>
	<td><a href="teamdetail.do?team_name=${relist.team_name }">${relist.content }</a></td>
	<td><fmt:formatDate value="${relist.wdate }" pattern="yyyy-MM-dd"/></td>
</tr>
</tbody>
</c:forEach>

</table>
<div id="paging_wrap">
	<jsp:include page="include/paging.jsp" flush="false">
		<jsp:param name="pageNumber" value="${pageNumber }" />
		<jsp:param name="totalRecordCount" value="${totalRecordCount }" />
		<jsp:param name="pageCountPerScreen" value="${pageCountPerScreen }" />
		<jsp:param name="recordCountPerPage" value="${recordCountPerPage }" />	
	</jsp:include>
	</div>
<input type="hidden" name="pageNumber" id="_pageNumber" value="${(empty pageNumber)?0:pageNumber }">
<input type="hidden" name="recordCountPerPage" id="_recordCountPerPage" value="${(empty recordCountPerPage)?0:recordCountPerPage }">
</form>
</div>

<script type="text/javascript">
$(document).ready(function name() {
	$("#menu2").css("background-color","#e60013");
});

function goPage( pageNumber ) {
	$("#_pageNumber").val(pageNumber);
	$("#_frmFormSearch3").attr("action", "recruitlist.do").submit();
}

function chageSelectedValue(){
    var sport = document.getElementById("_sport").value;
    $("#_frmFormSearch3").attr("action", "recruitlist.do").submit();
}

</script>

</body>
</html>