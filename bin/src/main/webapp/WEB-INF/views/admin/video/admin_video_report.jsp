<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2 style="margin-top: 20px;">게시글 신고목록</h2>

<form action="" id="vFrm">
	<table class="table table-bordered">
	<col width="50"><col width="200"><col width="150"><col width="50">
	<tr style="background-color: #4e73df; color: #fff;">
		<th style="text-align: center;">
			<input type="checkbox" name="alldel" onclick="deleteAll(this.checked)">
		</th>
		
		<th>제목</th><th>작성자</th><th>신고수</th>
	</tr>
	
	<c:if test="${empty video }">
		<tr>
			<td style="text-align: center;" colspan="4"> 
			신고된 영상이 없습니다.
			</td>
		</tr>
	</c:if>
	<c:forEach items="${video }" var="v" varStatus="i">	
		<c:if test="${v.del eq 0 }">
			<tr>
				<td style="text-align: center;">
					<input type="checkbox" name="v_check" id="v_check${i.index }" value="${v.seq_video }">
				</td>
				<td>
					<a href="admin_report_detail.do?seq_video=${v.seq_video }">${v.title }</a>						
				</td>
				<td>${v.id }</td><td>${v.report_count }</td>	
			</tr>
		</c:if>
	</c:forEach>
	</table>
</form>

<div>
	<button type="button" id="v_delete" class="btn btn-primary" style="margin-left: 50px;">삭제</button>
</div>

<br><br>

<h2>댓글 신고목록</h2>

<form action="" id="cFrm">
	<table class="table table-bordered">
	<col width="50"><col width="200"><col width="150"><col width="50">
	<tr style="background-color: #4e73df; color: #fff;">
		<th style="text-align: center;">
			<input type="checkbox" name="c_alldel" onclick="c_deleteAll(this.checked)">
		</th>
		
		<th>내용</th><th>작성자</th><th>신고수</th>
	</tr>
	
	<c:if test="${empty vc }">
		<tr>
			<td style="text-align: center;" colspan="3"> 
			신고된 댓글이 없습니다.
			</td>
		</tr>
	</c:if>
	
	<c:forEach items="${vc }" var="vc" varStatus="i">
	<c:if test="${vc.del eq 0 }">
		<tr>
			<td style="text-align: center;"> 
				<input type="checkbox" name="c_check" id="c_check${i.index }" value="${vc.seq }">
			</td>
			<td>
				<a href="admin_report_detail.do?seq_video=${vc.parent }">${vc.content }</a>
			</td>
			<td>${vc.id }</td><td>${vc.report_count }</td>	
		</tr>	
	</c:if>		
	</c:forEach>
	
	</table>
</form>

<div>
	<button type="button" id="c_delete" class="btn btn-primary" style="margin-left: 50px; margin-bottom: 30px;">삭제</button>
</div>

<script type="text/javascript">
$("#v_delete").click(function () {
	$("#vFrm").attr("action", "video_report_delete.do").submit();	
});

$("#c_delete").click(function () {
	$("#cFrm").attr("action", "video_report_delete.do").submit();
});

function deleteAll( e ) {
	var arr = document.getElementsByName("v_check");
	
	for (var i = 0; i < arr.length; i++) {
		arr[i].checked = e;
	}
}

function c_deleteAll( e ) {
	var arr = document.getElementsByName("c_check");
	
	for (var i = 0; i < arr.length; i++) {
		arr[i].checked = e;
	}
}

</script>


</body>
</html>



