
<%@page import="com.boot.finalpro.teambbs.model.SubDTO"%>
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
input:focus { outline: 2px solid white;}

#_tooBar{
    width: 100%;
    height: auto;
    padding: 0 0 3% 0;
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
	SubDTO bbsdto = (SubDTO) request.getAttribute("bbsdto");
%>

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
			<b id="_send_id" style="position: relative; left: 10px; bottom: 8px; cursor: pointer;"><%=bbsdto.getId()%></b> <span
				style="font-size: 12px; position: relative; left: 10px; text-align: left; bottom: 8px"> <%=bbsdto.getWdate()%> | 댓글 | <a href="../common/subBbs.do"
				style="text-decoration: none; font-size: 12px; color: #b2b2b2">목록으로</a>
			</span> 
			<!-- 아이디 사용자 정의 변수로 해서 세션 아이디 넣기 -->
		</div>
	</div>
	<div style="text-align: left; padding-left: 25px">
		<span style="float: left;">
		<c:if test="${bbsdto.game_info ne null }">
		<input type="text" readonly="readonly" placeholder="일시 : <%=bbsdto.getGame_info() %>" style="border: none; width: 500px;">
		</c:if>
		</span><br><br>
		<c:if test="${bbsdto.content ne null }">
			<%=bbsdto.getContent()%>
		</c:if>
		
	</div>
	<div class="detail-comment-count" style="margin-bottom: 150px; margin-top: 150px;">
		<span style="float: left; padding-left: 15px;">
		<input type="text" readonly="readonly" placeholder="아이디를 눌러 팀장에게 쪽지를 보내세요." style="border: none; width: 500px;">
		</span>
		<span style="float: right;">
			<button class="btn btn-primary" type="button" id="_backList">목록으로</button>
			 <c:if test="${bbsdto.id eq user.username}">
				<button class="btn btn-primary" type="button" id="_update" seq="<%=bbsdto.getSeq()%>">수정</button>
				<button class="btn btn-primary" type="button" id="_delete" seq="<%=bbsdto.getSeq()%>" user_id="<%=bbsdto.getId() %>">삭제</button>
			</c:if>
		</span>
	</div>
</div>

<jsp:include page="include/BbssendMessage.jsp"/>

<script type="text/javascript">
$("#menu5").css("background-color","#e60013");

$("#_backList").on('click', function () {
	location.href="../common/subBbs.do";
});

$("#_update").on('click', function () {
	var seq = $("#_update").attr("seq");
	location.href="../member/teamBbsupdate2.do?seq="+seq;
});
$("#_delete").on('click', function () {
	var seq = $(this).attr("seq");
	var user_id = $(this).attr("user_id");
	location.href="../member/teamBbsdelete2.do?seq="+seq+"&id="+user_id;
});


</script>