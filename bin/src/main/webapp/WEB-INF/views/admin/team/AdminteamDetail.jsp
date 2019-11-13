<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style type="text/css">

#mmrtb th{
	text-align: center;
}

</style>
<h1>팀 디테일</h1>
<div class="card-mb-3" style="max-width: 1000px;">
	<div class="row no-gutters">
		<div class="col-md-3">
			<h5>팀이름:<a class="badge badge-primary">${teamdetail.team_name }</a></h5>
			<img alt="사진없음" src="" class="card-img">
		</div>
		<div class="col-md-4">
			<div class="card-body">
				
				<p class="card-text">팀장명:${teamdetail.leader }</p>
				<p class="card-text">주종목:${teamdetail.sport_category }</p>
				<p class="card-text">창단일:<fmt:formatDate value="${teamdetail.fdate }" pattern="yyyy-MM-dd"/></p>
			</div>
		</div>
		<div class="col-md-4">
			<div class="card-body">
				<div>팀소개:${teamdetail.title }</div>
				<div>팀원수:${memcount }</div>
				<div style="margin-top: 42px;">신고수:${teamdetail.report_count } / 좋아요수:${teamdetail.like_count }</div>
			</div>
		</div>
	</div>
</div>


<div class="allcls">

<div class="headercls">
	
</div>




<div >
	<table class="table table-striped">
	<tr id="mmrtb">
		<th>축구mmr</th><th>농구mmr</th><th>야구mmr</th><th>베드민턴mmr</th><th>탁구mmr</th>
	</tr>
	<tr>
		<td>${teamdetail.soccer_mmr }</td>
		<td>${teamdetail.basketball_mmr }</td>
		<td>${teamdetail.baseball_mmr }</td>
		<td>${teamdetail.badminton_mmr }</td>
		<td>${teamdetail.pingpong_mmr }</td>
	</tr>
</table>
</div>

<div class="contentcls">
팀설명:
	<div class="contextcls">
		${teamdetail.content }
	</div>
</div>
<c:if test="${ teamdetail.deadline eq 1 && empty mem.team_name && appcount eq 0 }">
	<jsp:include page="include/memappinclude.jsp" />
</c:if>

<c:if test="${mem.team_name eq teamdetail.team_name && auth.authority eq 'ROLE_TEAMLEADER' }">
<div class="leadercls">
	<c:if test="${teamdetail.deadline eq 0 }">
		<a href="recruitment.do?team_name=${teamdetail.team_name }" onclick="window.open(this.href, '_blank', 'width=500px,height=500px,toolbars=no,scrollbars=no'); return false;">팀원모집하기</a>
	</c:if>
	<c:if test="${teamdetail.deadline eq 1 }">
		<a href="deadline.do?team_name=${teamdetail.team_name }">팀원모집마감하기</a>
	</c:if>
	<jsp:include page="include/memappstate.jsp"/>
	<a href="matchinglist.do?name_team1=${teamdetail.team_name }">매칭관리</a>
	<a href="memberstate.do?team_name=${teamdetail.team_name }">팀원현황</a>
	<a href="#">팀일정</a>
	<form action="detailup.do" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="hidden" name="team_name" value="${teamdetail.team_name }">
		<input type="hidden" name="sport_category" value="${teamdetail.sport_category }">
		<input type="hidden" name="title" value="${teamdetail.title }">
		<input type="hidden" name="content" value='${teamdetail.content }'>
		<input type="submit" value="팀상세정보 수정">
	</form>
<%-- <a href="detailup.do?team_name=${teamdetail.team_name }">팀디테일수정</a> --%>
</div>

</c:if>

</div>

<script type="text/javascript">


	
</script>