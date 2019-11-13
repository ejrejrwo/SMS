<%@page import="com.boot.finalpro.teambbscomment.model.TeamBBSCommentDTO"%>
<%@page import="com.boot.finalpro.teambbs.model.TeamBBSDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="user" property="principal" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<style type="text/css">
@charset "UTF-8";

.content-area {
	padding: 20px 0 20px 20px;
	height: 1000px;
}

.top-category {
	padding: 0 15px;
	border-bottom: 1px solid #dddddd;
	font-family: 'Musinsa', "gulim", "굴림", sans-serif;
	line-height: 49px;
	text-align: left;
}

.mainBbsList {
	/* border: 1px solid; */
	
}

.BbsListTable {
	width: 100%;
	margin: 0 10px 0 0;
}

.Bbspaging {
	width: 98%;
	border: 0;
	margin-left: auto;
	margin-right: auto;
	margin-top: 10px;
}

.serach-category {
	width: 98%;
	border-width: 1px;
	border-style: solid;
	border-color: #EFEFEF;
	background-color: #FFFFFF;
	text-align: right;
	padding: 2px;
	margin-top: 5px;
	margin-bottom: 10px;
	margin-left: auto;
	margin-right: auto;
}

.detail-content {
	width: 60%;
	margin: auto;
}

.detail-top {
	display: block;
	border-top: 3px solid black;
	margin-top: 5px;
	border-bottom: 1px solid #ddd;
	padding: 7px 25px;
	height: 40px;
	margin-top: 5px;
}

.detail-middle {
	display: block;
	border-bottom: 1px solid #ddd;
	padding: 20px 17px;
	margin-bottom: 15px;
	height: 20px;
	color: #b2b2b2;
	height: 20px;
}

.detail-like {
	
}

.detail-bottom {
	padding: 10px 10px 0 10px;
	height: 30px;
	position: relative;
	font-size: 15px;
}

button {
	cursor: pointer;
}

.detail-border {
	/* border: 1px solid #ddd; */
	position: relative;
}

.detail-comment {
	padding-bottom: 30px;
}

.detail-comment-count {
	float: left;
	width: 100%;
	font-size: 14px;
	line-height: 21px;
	margin-top: 5px;
	margin-bottom: 14.5px;
	display: inline-block;
	vertical-align: top;
	font-family: auto;
	text-align: left;
	padding: 15px 10px;
	border-bottom: 1px solid #ddd;
}

.detail-comment-submit {
	height: 150px;
	width: 95%;
	overflow: hidden;
	padding: 5px 10px;
	position: relative;
	/* border: 1px solid #e5e5e5; */
	cursor: pointer;
}

.comment-submit-hide {
	width: 100%;
	height: 120px;
	background: #fff;
	padding: 0;
	vertical-align: top;
}

#dropdown:hover #dropdown-menu {
	display: block;
	margin-top: 0;
}

.fucking-table>tbody>tr>td {
	border-top: 0;
	border-bottom: 1px solid #ddd;
	padding: 16px;
	line-height: 1.4285;
	vertical-align: top;
}

textarea {
	outline: none;
	border-bottom: 1px solid #5D5D5D;
	resize: none;
	overflow: hidden;
	padding: 10px;
	width: 100%;
}

.rep_input{
    border-top: 1px solid #ccc;
    background: #fafafa;
    padding: 10px;
}

#_tooBar{
    width: 100%;
    height: auto;
    padding: 0% 0 3% 0;
    text-align: center;
    font-size: 40px;
}
#_tooBar::after{
    content: "";
    display: block;
    width: 50px;
    border-bottom: 1px solid #bcbcbc;
    margin: 5px auto;
}

</style>


<%
	TeamBBSDTO bbsdto = (TeamBBSDTO) request.getAttribute("bbsdto");
%>
<!-- arrow 생성 -->
<jsp:useBean id="ubbs" class="com.boot.finalpro.teambbs.util.TeamBbsArrow" scope="page" />

<!-- 히든영역 -->
<input type="hidden" id="seqNum" seq="<%=bbsdto.getSeq()%>">
<div class="detail-content">
	<div id="_tooBar">
		게시판 상세글
	</div>
	<div class="detail-border">
		<div class="detail-top" style="height: 70%">
			<h3 style="text-align: left; position: relative; bottom: 4px;"><%=bbsdto.getTitle()%></h3>
		</div>
		<div class="detail-middle" style="text-align: left;">
			<b onclick="Info_id()" style="position: relative; left: 10px; bottom: 8px; cursor: pointer;"><%=bbsdto.getId()%></b> <span
				style="font-size: 12px; position: relative; left: 10px; text-align: left; bottom: 8px"> 조회<%=bbsdto.getRead_count()%> | <%=bbsdto.getWdate()%> | 댓글${bbscommentdto.size() } |
				<a href="../common/teamBbs.do" style="text-decoration: none; font-size: 12px; color: #b2b2b2">목록으로</a>
			</span> <span id="_report" style="float: right; font-size: 16px; cursor: pointer; position: relative; bottom: 10px;" onclick="report()" seq="<%=bbsdto.getSeq() %>"
				user_id=<%=bbsdto.getId() %> report_id='${user.username }'> <img alt="" src="/image/report.jpg"
				style="width: 30px; height: 40px; padding-bottom: 10px">
			</span>
			<!-- 아이디 사용자 정의 변수로 해서 세션 아이디 넣기 -->
		</div>
	</div>
	<div style="text-align: left; padding-left: 25px">
		<c:if test="${bbsdto.content ne null }">
			<%=bbsdto.getContent()%>
		</c:if>
		<div class="detail-bottom" style="height: 50px; margin-top: 170px" align="center">
			<!-- 수정 삭제 로그인 세션 아이디와 여기 아이디가 다를 경우 안보이도록 -->
			<c:if test="${empty likedto }">
				<img alt="" src="/image/like2.png" id="_like" onclick="like()" seq="<%=bbsdto.getSeq() %>" user_id="${user.username }" style="width: 40px; height: 40px; cursor: pointer;">
				<br>
				<span id="_like_count"><%=bbsdto.getLike_count()%></span>
			</c:if>
			<c:if test="${not empty likedto }">
				<img alt="" src="/image/like.png" id="_like" onclick="like()" seq="<%=bbsdto.getSeq() %>" user_id="${user.username }" style="width: 40px; height: 40px; cursor: pointer;">
				<br>
				<span id="_like_count"><%=bbsdto.getLike_count()%></span>
			</c:if>
		</div>
		<div class="detail-comment">
			<div class="detail-comment-count">
				<span style="float: right;"> <c:if test="${bbsdto.id eq user.username}">
						<button class="btn btn-primary" type="button" id="_update" seq="<%=bbsdto.getSeq()%>">수정</button>
						<button class="btn btn-primary" type="button" id="_delete" seq="<%=bbsdto.getSeq()%>" user="<%=bbsdto.getId() %>">삭제</button>
					</c:if>
				</span>
			</div>
			<ul class="pager">
				<li class="previous"><a href="Previous.do?seq=<%=bbsdto.getSeq()%>"><span aria-hidden="true">&larr;</span>이전 글</a></li>
				<li class="middle"><a href="../common/teamBbs.do">목록으로</a></li>
				<li class="next"><a href="Next.do?seq=<%=bbsdto.getSeq()%>">다음 글 <span aria-hidden="true">&rarr;</span></a></li>
			</ul>
			<div style="border-bottom: 1px solid #ddd; padding-bottom: 12px;">
				<span style="position: relative; left: 15px; top: 5px; height: 20px; margin-bottom: 10px">댓글 ${bbscommentdto.size() }개</span>
			</div>
			<div class="detail-comment-list" style="padding-top: 20px;">
				<div class="detail-comment-line" align="left">
					<c:forEach items="${bbscommentdto }" var="bbscomment" varStatus="vs">
						<jsp:setProperty property="depth" name="ubbs" value="${bbscomment.depts }" />
						<table class="fucking-table">
							<col width="150px">
							<col width="1050px">
							<col width="10px">
							<tr>
								<c:if test="${bbscomment.del eq 0}">
									<td><strong>${bbscomment.id }</strong></td>
									<td><jsp:getProperty property="arrow" name="ubbs" /> <span style="color: gray">${bbscomment.reply_id }</span> ${bbscomment.content }<br> <span
										style="font-size: 12px; color: #ddd">${bbscomment.wdate } | <a style="color: pink" seq="${bbscomment.seq }"
											onclick="CommentReport('${bbscomment.seq}', '${user.username}', '${bbscomment.id }', '${bbscomment.content }')">신고하기</a></span></td>
									<td><div class="btn-group">
											<!-- <img alt="" src="/image/사랑해.gif" style="width: 40px; height: 20px;" class="imghide"> -->
											<img class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" alt="" src="/image/more.png"
												style="width: 40px; height: 30px; border: 0">

											<ul class="dropdown-menu">
												<c:if test="${bbscomment.id eq user.username }">
													<li><a class="dropdown-item" seq="${bbscomment.seq }" onclick="CommentUpdate('${bbscomment.seq }')">수정</a></li>
													<li><a class="dropdown-item" seq="${bbscomment.seq }" onclick="CommentDelete('${bbscomment.seq}','${bbsdto.seq }','${bbscomment.id }')">삭제</a></li>
												</c:if>
												<li><a class="dropdown-item" seq="${bbscomment.seq }" onclick="CommentReply('${bbscomment.seq}', '${bbsdto.seq }', '${bbscomment.id }')">답글달기</a></li>
											</ul>
										</div></td>
								</c:if>
								<c:if test="${bbscomment.del eq 1 }">
									<td colspan="2" style="text-align: center">이 글은 작성자에 의해 삭제되었습니다.</td>
								</c:if>
							</tr>
						</table>
					</c:forEach>
					<div class="rep_input">
						<textarea rows="5" cols="100" id="_content" name="content" class="autosize" placeholder="저작권 등 다른 사람의 권리를 침해하거나 명예를 훼손하는 게시물은 이용약관 및 관련 법률에 의해 제재를 받을 수 있습니다. 건전한 토론문화와 양질의 댓글 문화를 위해, 동참해 주세요"></textarea>
						<input type="hidden" id="id" name="id" value="${id}"> <input type="hidden" name="parent" value="${video.seq_video}">
						<div align="right">
						<button type="button" onclick="commentSubmit(${bbsdto.seq})" class="btn btn-default btn-sm">등록</button>
						</div>
					</div>
				</div>
				<div class="container" style="width: 900px;"></div>
			</div>

		</div>
	</div>
</div>

<jsp:include page="include/CommentUpdate.jsp" />
<jsp:include page="include/CommentReply.jsp" />
<jsp:include page="include/BbsReport.jsp" />
<jsp:include page="include/CommentReport.jsp" />
<jsp:include page="include/Detail_Id_Info.jsp" />

<%--
팝업 하는법 ex) 
<a href="getmatchinglist.do?seq_game=${game.seq_game }" onclick="window.open(this.href, '_blank', 'width=500px,height=500px,toolbars=no,scrollbars=no'); return false;">신청메세지보기</a> 
--%>

<script type="text/javascript">
		$("#menu4").css("background-color", "#e60013");

		function commentSubmit( seq ) {
			
			var bbsSeq = seq;
//			alert(bbsSeq);
			var content = document.getElementById("_content").value;
			//textarea 개행하기
			content = content.replace(/\n/gi, "<br>");
			
//			document.getElementById("exampleInputEmail1").focus();
			if(content == null || content == ""){
				alert("댓글 내용을 입력 해주세요");
			}else{
			var id = "${user.username }";
//			alert(id);
				$.ajax({
					url: "../member/teamBbsCommentWrite.do",
					type :"POST",
					data : {parent:bbsSeq, id:id, content:content},
					dataType : "text",
					success: function ( resp ) {
					//	alert("resp");
						location.reload();
					},
					error: function () {
					//	alert("error");
					}		
				});
			}
		}
		
		$(document).ready(function() {

			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$(document).ajaxSend(function(e, xhr, options) {
				xhr.setRequestHeader(header, token);
			});
			//5차 이후 추가
			$("#_delete").on('click', function() {
				var seq = $(this).attr("seq");
				var id = $(this).attr("user");
				// 확인 창 하기 juqery
				var result = confirm('정말 삭제하시겠습니까?');
				//	alert(seq);
				if (result) {
					location.href = "../member/teamBbsDelete.do?seq=" + seq + "&id="+id;
				} else {
					return;
				}
			});

			$("#_update").on('click', function() {
				var seq = $(this).attr("seq");

				//	alert(seq);
				location.href = "../member/teamBbsUpdate.do?seq=" + seq;
			});

		});
		// 게시판 찜 AJAX
		function like() {
			// javascript에서 사용자 정의 변수 가져오는 방법
			var seq = document.getElementById("_like").getAttribute("seq");
			var user_id = document.getElementById("_like").getAttribute(
					"user_id");
			
			$.ajax({
				url : "../member/teamBbsLike.do",
				type : "POST",
				data : {
					seq : seq,
					id : user_id
				},
				async : true,
				success : function(resp) {
					$("#_like_count").text(resp.count);
					alert(resp.msg);
					if(resp.msg == "게시글을 좋아요 하였습니다."){
						$("#_like").attr("src", "/image/like.png");
					}else{
						$("#_like").attr("src", "/image/like2.png");
					}
				},
				error : function() {
					alert("error");
				}

			});
		}
		function CommentDelete(v, s, i) {
			//	alert("comment seq : " + v);
			var bbsSeq = s;
			var CommentSeq = v;
			var user_id = i;
			
			var result = confirm('정말 삭제 하시겠습니까?');
			if (result) {
				location.href = "../member/teamBbsCommentDelete.do?seq="
						+ CommentSeq + "&bbsSeq=" + bbsSeq + "&id="+user_id;
			} else {
				return;
			}
		}
	</script>