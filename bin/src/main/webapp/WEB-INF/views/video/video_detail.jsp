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

<style type="text/css">
textarea {
	outline: none;
	border: none;
	border-bottom: 1px solid #5D5D5D;
	resize: none;
	overflow: hidden;
}

</style>	
</head>
<body>

<!-- arrow 생성 -->
<jsp:useBean id="ubbs" class="com.boot.finalpro.video.util.VideoArrow" scope="page" />
		
<div class="container" style="width: 1200px;">

	<div style="float: left; width: 600px;">
		<video width="500" height="300" controls autoplay="autoplay" style="outline: none;">
			<source src="<%=request.getContextPath() %>/upload/${video.file_name }" type="video/mp4">
		</video>
	</div>
	<div style="float: left; padding-top: 20px; text-align: left; width: 500px;">
		<font style="font-size: 18px; font-weight: 600;">${video.title }</font><br>
		${video.id } | ${video.read_count }회 | <fmt:formatDate value="${video.wdate }" pattern="yyyy-MM-dd kk:mm"/>
		
		<div style="padding-top: 10px;">
		<input type="hidden" id="seq_video" value="${video.seq_video}">
		
			<c:if test="${not empty over }">
				<img alt="" src="/image/like_heart.png" id="like_img"  onclick="like(${video.seq_video})" width="20" style="cursor: pointer;">
			</c:if>
			<c:if test="${empty over }">
				<img alt="" src="/image/unlike_heart.png" id="like_img"  onclick="like(${video.seq_video})" width="20" style="cursor: pointer;">
			</c:if>	
			<span style="color: #909090;">좋아요</span>
			<span id="video_like" style="font-weight: bold;">${video.like_count }</span>&nbsp;&nbsp;			
			<span onclick="VideoReport('${video.seq_video}', '${video.id}', '${id}')" style="cursor: pointer; color: #909090;">신고</span>
			<%-- <span id="video_like" style="font-weight: bold;">${video.report_count }</span>&nbsp;&nbsp; --%>
		
			<button type="button" id="list_btn" class="btn btn-default btn-sm" style="float: right;">목록</button>			
			<c:if test="${video.id eq id }">
				<button type="button" id="delete_btn" class="btn btn-default btn-sm" style="float: right;">삭제</button>	
			</c:if>				
		</div>	

		<hr style="border-color: #BDBDBD;">
				
		<div>
			${video.content }
		</div>
	</div>
	
</div>
	
<br>
<hr style="border-color: #BDBDBD; width: 1200px;">
<br>
	
<div class="container" style="width: 900px;">
	<form id="cFrm">
		<div align="left">		
			<textarea rows="1" cols="100" id="content" name="content" class="autosize" placeholder="댓글 추가"></textarea>	
			<input type="hidden" id="id" name="id" value="${id}">
			<input type="hidden" name="parent" value="${video.seq_video}">			

			<button type="button" onclick="writeComment(${video.seq_video})" class="btn btn-default btn-sm">댓글</button>
		</div>	
	</form>
</div>
<br>
<div class="container" style="width: 900px;">
	<div align="left">
	
		<c:forEach items="${comment }" var="vc">				
			
			<div>	
				<jsp:setProperty property="depth" name="ubbs" value="${vc.depth }" />
				<jsp:getProperty property="arrow" name="ubbs" />					
							
				<c:if test="${vc.del eq 1 }">
					<jsp:getProperty property="arrow" name="ubbs" />
					삭제된 게시글입니다
				</c:if>	
			
				<c:if test="${vc.del eq 0 }">						
					<font style="font-size: 13px; font-weight: 600; color: #0d0d0d;">${vc.id}</font>&nbsp;				
					<font style="font-size: 14px; color: #606060;"><fmt:formatDate value="${vc.wdate }" pattern="yyyy-MM-dd kk:mm"/></font><br>	
					
					<jsp:getProperty property="arrow" name="ubbs" />		
					${vc.content }<br>
					
					<jsp:getProperty property="arrow" name="ubbs" />			
					<c:choose>
						<c:when test="${vc.oid eq id}">
							<img alt="" src="/image/like_heart.png" id="comment_like_img${vc.seq }"  onclick="Commentlike(${vc.seq})" width="20" style="cursor: pointer;">
						</c:when>
						
						<c:otherwise>
							<img alt="" src="/image/unlike_heart.png" id="comment_like_img${vc.seq }"  onclick="Commentlike(${vc.seq})" width="20" style="cursor: pointer;">					
						</c:otherwise>				
					</c:choose>
							
					<span style="color: #909090;">좋아요</span>
					<span id="comment_like${vc.seq }" style="font-weight: bold;">${vc.like_count }</span>&nbsp;&nbsp;
					
					<span onclick="CommentReport('${vc.seq}', '${vc.id}', '${id}')" style="cursor: pointer; color: #909090;">신고</span>
												
					<c:if test="${vc.depth eq 0 }">
						<span onclick="reply(${vc.seq})" style="cursor: pointer; color: #909090;">답글</span>
					</c:if>	
					
					<c:if test="${vc.id eq id }">
						<button type="button" onclick="delete_comment(${vc.seq}, ${video.seq_video})" class="btn btn-default btn-sm">삭제</button>	
					</c:if>		
				</c:if>					
			</div>
			<div id="reply${vc.seq}" class="reply">
				<form id="rFrm">							
					<div>		
						<textarea rows="1" cols="100" id="r_comment${vc.seq}" name="content" class="autosize" placeholder="답글 추가"></textarea>	
						<input type="hidden" id="id" name="id" value="${id}">
						<input type="hidden" name="parent" value="${video.seq_video}">			
					
						<button type="button" onclick="reply_comment(${video.seq_video}, ${vc.seq})" class="btn btn-default btn-sm">답글</button>
					</div>					
				</form>	
				<br><br>			
			</div>							
			<br>						 	
		</c:forEach> 		
	</div>
</div>

<jsp:include page="VideoReport.jsp" />
<jsp:include page="VideoCommentReport.jsp" />

<script type="text/javascript">
$("#menu4").css("background-color","#e60013");

$(".reply").hide();

$("textarea.autosize").on('keydown keyup', function () {
	$(this).height(1).height( $(this).prop("scrollHeight")+1);
});

$("#list_btn").click(function () {
	location.href="/common/video.do";
});

$("#delete_btn").click(function () {
	var seq_video = $("#seq_video").val();
	
	location.href="video_delete.do?seq_video="+seq_video;	
});

function delete_comment(seq, seq_video) {
//	alert(seq);
	location.href="comment_delete.do?seq="+seq + "&seq_video=" + seq_video;	
}

function writeComment(seq) {	
	var id = $("#id").val();
	var content = $("#content").val();	
//	alert(seq + " " + id + " " + content);
	
	if(id=="guest"){
		alert("로그인해 주십시오");
		location.href="loginPage.do";
		return;
	}

	$.ajax({
		url:'writecomment.do',
		async:true,
		data:{parent:seq, id:id, content:content},
		dateType: 'text',
		success:function(){
//			alert('success');			
			location.reload();
			
		},
		error:function(){
			alert('error');
		}				
	})		
}

function reply(seq) {
//	alert(seq);
	$("#reply"+seq).toggle();				
}

function reply_comment(parent, seq) {
	var id = $("#id").val();
	var content = $("#r_comment"+seq).val();	
//	alert(seq + id + content + parent);

	if(id=="guest"){
		alert("로그인해 주십시오");
		location.href="loginPage.do";
		return;
	}

	$.ajax({
		url:'replycomment.do',
		async:true,
		data:{seq:seq, parent:parent, id:id, content:content},
		dateType: 'text',
		success:function(){
//			alert('success');			
			location.reload();
			
		},
		error:function(){
			alert('error');
		}				
	})		
}

//좋아요
function like(seq) {
	var id = $("#id").val();
//	alert(seq+ " " + id);
	
	if(id=="guest"){
		alert("로그인해 주십시오");
		location.href="loginPage.do";
		return;
	}

 	$.ajax({
		url:'videoLike.do',
		async:true,
		data:{seq_video:seq, id:id},
		dateType: 'text',
		success:function(resp){
//			alert(resp.count + " " + resp.num);				
			$("#video_like").text(resp.count);
			
			if(resp.num==0){
				$("#like_img").attr("src", "/image/like_heart.png");
			}else if(resp.num==1){
				$("#like_img").attr("src", "/image/unlike_heart.png");
			}			
		},
		error:function(){
			alert('error');
		}				
	})		 		
}  

// 댓글 좋아요
function Commentlike(seq) {
	var id = $("#id").val();
//	alert(seq+ " " + id);
	
	if(id=="guest"){
		alert("로그인해 주십시오");
		location.href="loginPage.do";
		return;
	}

 	$.ajax({
		url:'commentVideoLike.do',
		async:true,
		data:{seq:seq, id:id},
		dateType: 'text',
		success:function(resp){
//			alert(resp.count + " " + resp.num);				
			$("#comment_like"+seq).text(resp.count);
			
			if(resp.num==0){
				$("#comment_like_img"+seq).attr("src", "/image/like_heart.png");
			}else if(resp.num==1){
				$("#comment_like_img"+seq).attr("src", "/image/unlike_heart.png");
			}			
		},
		error:function(){
			alert('error');
		}				
	})		 		
}  


</script>

</body>
</html>





