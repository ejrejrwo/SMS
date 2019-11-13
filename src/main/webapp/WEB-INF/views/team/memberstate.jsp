<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="user" property="principal" />   
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
<table class="table table-hover table-responsive">
<thead>
	<tr>
		<th>아이디</th><th>이름</th><th>생일</th><th>이메일</th>
		<th>키</th><th>몸무게</th><th>신고수</th><th>전화번호</th>
		<c:choose>
			<c:when test="${user.username eq teamdetail.leader }">
				<th>탈퇴</th>
			</c:when>
			<c:otherwise>
				<th>직급</th>
			</c:otherwise>			
		</c:choose>
		
	</tr>
</thead>
	<c:if test="${empty memberlist }">
		<tbody>
		<tr>
			<td colspan="8">작성된 글이 없습니다</td>
		</tr>
		</tbody>
	</c:if>
	
	<c:forEach items="${memberlist }" var="member" varStatus="vs">
		<c:if test="${member.id == user.username}">
			<input type="hidden" id="_test" value="1"></input>	
		</c:if>
	<tbody>
	
	<tr style="height: 50px;">
		<td><a onclick="_go_send_message('${member.id }')" href="#">${member.id }</a></td>
		<td>${member.name }</td>
		<td>${member.birthday }</td>
		<td>${member.email }</td>
		<td>${member.height }</td>
		<td>${member.weight }</td>
		<td>${member.report_count}</td>
		<td>${member.phone }</td>
		<%-- <td>
		
		<c:if test="${user.username eq teamdetail.leader }">
           	 팀장
         </c:if>
         <c:if test="${user.username ne teamdetail.leader }">
            <button type="button" id="_del_btn" user_id="${member.id }" >내보내기</button>         
         </c:if>
         <input type="hidden" id="_team_name" value="${member.team_name }">
		</td> --%>
		
		<c:choose>
			<c:when test="${user.username eq teamdetail.leader }">
				<td>
					<c:if test="${user.username eq member.id }">
			           	 팀장
			         </c:if>
			         <c:if test="${user.username ne member.id }">
			            <button type="button" id="_del_btn" user_id="${member.id }" class="btn btn-danger" >내보내기</button>         
			         </c:if>
			         <input type="hidden" id="_team_name" value="${member.team_name }">
				</td>
			</c:when>
			<c:otherwise>
				<td>
					<c:if test="${member.id eq teamdetail.leader }">
			           	 팀장
			         </c:if>
			         <c:if test="${member.id ne teamdetail.leader }">
						팀원
			         </c:if>
				</td>
			</c:otherwise>
		</c:choose>
		
	</tr>
	</tbody>
	</c:forEach>
	
</table>
<form action="" name="frmForm3" id="_frmFormSearch3" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
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
<input type="hidden" name="team_name" value="${teamdetail.team_name }">
</form>

</div>
<jsp:include page="include/BbssendMessage2.jsp"/>


<script type="text/javascript">
$(document).ready(function () {
	var test1 = $("#_test").val();
	//alert(test1);
	if(test1 == 1){
		$("#menu1").css("background-color", "#e60013");	
	}else{
		$("#menu3").css("background-color", "#e60013");	
	}
	
	
	$(document).on("click", "#_del_btn", function () {
		var team_name = $("#_team_name").val();
		var id = $(this).attr("user_id");
		location.href="teamout.do?team_name=" + team_name + "&id=" + id; 
	});
});
function goPage( pageNumber ) {
	$("#_pageNumber").val(pageNumber);
	$("#_frmFormSearch3").attr("action", "memberstate.do").submit();
}

</script>

</body>
</html>