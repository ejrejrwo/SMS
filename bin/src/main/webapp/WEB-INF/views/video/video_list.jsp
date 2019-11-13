<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
h3{
	color: black;
    font-size: 35px;
    text-align: center;
    padding-bottom: 50px;
    font-weight: 400;
}

</style>

</head>
<body>

<div id="_top">
	하이라이트
</div>

<div class="container" style="width: 1200px;">
	<div align="right" style="margin-bottom: 20px; width: 1160px;">
	<input type="hidden" id="id" value="${id }">
		<button type="button" id="vBtn" class="btn btn-default">동영상올리기</button>
	</div>
	
	<c:forEach items="${video }" var="v">
	<c:if test="${v.del eq 0 }">
		<div style="float: left; width: 390px; height: 320px;">
			<div>	
				<img alt="" src="<%=request.getContextPath() %>/upload/${v.file_name }.jpg" width="380" height="230"
							onclick="godetail(${v.seq_video})" style="cursor: pointer;">
			</div>
			<div>
				<font style="color: #747474;"># ${v.category }</font>
				<font style="font-weight: 700">&nbsp;&nbsp;${v.title }</font><br>
				${v.id }<br>
				<fmt:formatDate value="${v.wdate }" pattern="yyyy-MM-dd kk:mm"/>&nbsp;&nbsp;| ${v.read_count }회
			</div>
		</div>
	</c:if>	
	</c:forEach>
</div>

	<form action="" name="frmForm1" id="_frmFormSearch" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		
		<!-- 페이징 -->
		<div style="margin-bottom: 10px;">
			<ul class="pagination">
				<c:if test="${paging.prev}">
					<li class="page-item"><a class="page-link" style="color: black;" href="${action}?page=${paging.beginPage-1}&choice=${paging.choice}&keyword=${paging.keyword}">prev</a></li>
				</c:if>
				
				<c:forEach begin="${paging.beginPage}" end="${paging.endPage}" step="1" var="index">
					<c:choose>
						<c:when test="${paging.nowpage==index}">
							<li class="page-item active"><a class="page-link">${index}<span class="sr-only">(current)</span></a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link" style="color: black;" 
									href="${action}?page=${index}&choice=${paging.choice}&keyword=${paging.keyword}">${index}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<c:if test="${paging.next}">
					<li class="page-item"><a class="page-link" style="color: black;" href="${action}?page=${paging.endPage+1}&choice=${paging.choice}&keyword=${paging.keyword}">next</a></li>
				</c:if>
			</ul>
		</div>
	
		<!-- 검색 -->
		<div class="container" style="width: 400px;">
			<select name="choice" class="form-control" style="width: 100px; float: left;">
				<option value="">선택</option>
				<option value="title" <c:if test="${paging.choice == 'title'}">selected='selected'</c:if>>제목</option>
				<option value="category" <c:if test="${paging.choice == 'category'}">selected='selected'</c:if>>종목</option>	
				<option value="id" <c:if test="${paging.choice == 'id'}">selected='selected'</c:if>>작성자</option>	
			</select>
			<input type="text" id="keyword" name="keyword" class="form-control" 
						style="width: 200px; float: left;" value='${paging.keyword }'>	
			
			<button type="button" id="searchBtn" style="float: left;" class="btn btn-default">검색</button>
		</div>
			
	</form>





<script type="text/javascript">
$("#menu4").css("background-color","#e60013");

function godetail(seq) {
//	alert(seq);	
	location.href="videodetail.do?seq_video="+seq;
}

$("#vBtn").click(function () {
	var id = $("#id").val()
	if(id=="guest"){
		alert("로그인해 주십시오");
		location.href="loginPage.do";
		return;
	}
	
	location.href="/common/videomake.do";
})

$("#searchBtn").click(function () {
		$("#_frmFormSearch").attr("action", "video.do").submit();
});



</script>





</body>
</html>

