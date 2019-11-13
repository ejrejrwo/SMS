<%@page import="com.boot.finalpro.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>


</head>
<body>

<!-- arrow 생성 -->
<jsp:useBean id="ubbs" class="com.boot.finalpro.util.VideoArrow" scope="page" />
		
<div class="container" style="width: 1500px;">
	<div style="float: left; width: 500px;">
		<div>
			<video width="500" height="300" controls autoplay="autoplay" style="outline: none;">
				<source src="<%=request.getContextPath() %>/upload/${video.file_name }" type="video/mp4">
			</video>
		</div>
		<div style="padding-top: 20px; text-align: left; width: 500px;">
		<input type="hidden" id="seq_video" value="${video.seq_video}">
		
			<font style="font-size: 18px; font-weight: 600;">${video.title }</font><br>
			${video.id } | ${video.read_count }회 | <fmt:formatDate value="${video.wdate }" pattern="yyyy-MM-dd kk:mm"/>
												
			<button type="button" id="list_btn" class="btn btn-default btn-sm" style="float: right;">목록</button>					
			<button type="button" id="delete_btn" class="btn btn-default btn-sm" style="float: right;">삭제</button>	
							
			<hr style="border-color: #BDBDBD;">
					
			<div>
				${video.content }
			</div>
		</div>
	</div>
	<div style="width: 500px; float: left; margin-left: 20px; margin-top: 20px;" >
	<h3>영상신고내역(${video.report_count })</h3>
	
	<table class="table" style="width: 500px;">
	<tr>
		<th>번호</th><th>신고자</th><th>신고내용</th><th>신고취소</th>
	</tr>
	<c:forEach items="${r_video }" var="rv" varStatus="i">
		<tr>
			<td>${i.count }</td><td>${rv.r_id }</td><td>${rv.r_content }</td>
			<td>
				<button type="button" onclick="delete_report('${video.seq_video}', '${video.id }', '${rv.r_id }')" class="btn btn-default btn-sm" style="border: 1px solid black;">취소</button>	
			</td>
		</tr>
	</c:forEach>
	
	</table>
</div>
	
</div>
	
<br>
<hr style="border-color: #BDBDBD;">
<br>
	

<div class="container" style="width: 1500px;">
	<div style="float: left; width: 450px;" align="left">
		<c:forEach items="${comment }" var="vc">
		
		<c:if test="${vc.del eq 1 }">
			삭제된 게시물 입니다
		</c:if>
				
		<c:if test="${vc.del eq 0 }">
			<div>
				<jsp:setProperty property="depth" name="ubbs" value="${vc.depth }" />
				<jsp:getProperty property="arrow" name="ubbs" />							
				<font style="font-size: 13px; font-weight: 600; color: #0d0d0d;">${vc.id}</font>&nbsp;				
				<font style="font-size: 14px; color: #606060;"><fmt:formatDate value="${vc.wdate }" pattern="yyyy-MM-dd kk:mm"/></font>
				
				<span>신고수(${vc.report_count })	</span>
								
				<button type="button" onclick="delete_comment(${vc.seq}, ${video.seq_video})" class="btn btn-default btn-sm">삭제</button>
				<br>	
				
				<jsp:getProperty property="arrow" name="ubbs" />		
				${vc.content }						
			</div>
		</c:if>	
		<br>	 	
		</c:forEach> 
	</div>
	
	<div style="float: left; width: 600px">
		<h3>댓글신고내역</h3>
		
		<table class="table" style="width: 600px;">
		<tr>
			<th>번호</th><th>댓글내용</th><th>신고자</th><th>신고내용</th><th>신고취소</th>
		</tr>
		
		<c:if test="${empty r_comment }">
		<tr>
			<td colspan="4">
			신고된 글이 없습니다
			</td>
		</tr>
		</c:if>
		
		<c:forEach items="${r_comment }" var="rc" varStatus="i">		
			<tr>
				<td style="width: 60px;">${i.count }</td><td style="width: 150px;">${rc.content }</td>
				<td style="width: 100px;">${rc.r_id }</td><td style="width: 230px;">${rc.r_content }</td>
				<td>
					<button type="button" onclick="delete_comment_report(${rc.seq}, '${rc.id }','${rc.r_id }', ${video.seq_video})" 
							class="btn btn-default btn-sm" style="border: 1px solid black; width: 70px;">취소</button>
				</td>
			</tr>
		</c:forEach>	
		</table>
	</div>
</div>






<script type="text/javascript">

$("#list_btn").click(function () {
	location.href="admin_report.do";
});

$("#delete_btn").click(function () {
	var seq_video = $("#seq_video").val();	
	location.href="admin_video_delete.do?seq_video="+seq_video;	
});

function delete_comment(seq, seq_video) {
//	alert(seq);
	location.href="admin_comment_delete.do?seq="+seq + "&seq_video=" + seq_video;	
}

function delete_report(seq_video, id, r_id) {
// 동영상 seq, 글쓴이 id, 신고자 id	
//	alert(seq_video + id + r_id);
	
	location.href="delete_report.do?seq_video="+seq_video+"&id="+id+"&r_id="+r_id;
	
}

function delete_comment_report(seq, id, r_id, seq_video) {
// 댓글 seq, 글쓴이 id, 신고자 id	
//	alert(parent + id + r_id);

	location.href="delete_comment_report.do?seq="+seq+"&id="+id+"&r_id="+r_id+"&seq_video="+seq_video;
}


</script>

</body>
</html>





