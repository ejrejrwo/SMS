<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="user" property="principal" />

<!-- ajax 통신을 위한 meta tag -->
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<style type="text/css">
table {
	border-collapse: collapse;
}

th {
	background-color: #042E6F;
	color: white;
	padding: 12px;
	text-align: center;
}

td {
	border-bottom: 1px solid #A2AAC1;
	padding: 15px;
}

#jb-container {
	width: 1200px;
	margin: 0px auto;
	padding: 20px;
}

#jb-content1 {
	width: 380px;
	padding: 20px;
	margin-bottom: 20px;
	float: left;
	/* border: 1px solid #bcbcbc; */
}

#jb-content2 {
	width: 550px;
	padding: 20px;
	margin-bottom: 20px;
	margin-left: 20px;
	float: left;
}

#jb-sidebar {
	width: 200px;
	padding: 20px;
	margin-bottom: 20px;
	float: right;
	/* border: 1px solid #bcbcbc; */
	text-align: left;
}

#jb-footer {
	clear: both;
	padding: 20px;
}

#_list_group h4 {
	text-align: left;
	margin: 0;
}

#_list_group p {
	text-align: right;
	font-size: 15px;
	margin: 0;
}

#_tab_content {
	text-align: left;
	height: 500px;
	white-space: pre-wrap;
	background-color: white;
}
</style>
<%-- <div  style="width: 1200px;">
	<div class="col-md-7" style="width: 600px; display: block;">
		<div class="col-md-3">
			<h5>팀이름:<a class="badge badge-primary">${teamdetail.team_name }</a></h5>
			<c:if test="${empty teamdetail.file_name }">
			<img alt="" src="/image/team.png" style="width: 60px; height: 60px;" class="card-img">
			</c:if>
		</div>
		<div class="col-md-4" style="width: 600px; text-align: left;">
			<div class="card-body">
				
				<p class="card-text">팀장명:${teamdetail.leader }</p>
				<p class="card-text">주종목:${teamdetail.sport_category }</p>
				<p class="card-text">창단일:<fmt:formatDate value="${teamdetail.fdate }" pattern="yyyy-MM-dd"/></p>
			</div>
		</div>
		<div class="col-md-4" style="width: 600px; text-align: left;">
			<div class="card-body">
				<div>팀소개:${teamdetail.title }</div>
				<div>팀원수:${memcount }</div>
				<div style="margin-top: 42px;">신고수:${teamdetail.report_count } / 좋아요수:${teamdetail.like_count }</div>
			</div>
		</div>
	</div>
	<div class="col-md-5" style="width: 600px; float: right;">
		<img alt="" src="/image/team.png" style="width: 120px; height: 120px;">		
	</div>
</div> --%>

<div id="jb-container">

	<div id="jb-content1">
		<div class="card mb-3">
			<div class="panel panel-default">
				<div class="panel-heading" style="font-size: 20px;">${teamdetail.team_name }</div>
				
			</div>
			<ul class="list-group list-group-flush" id="_list_group">
				<li class="list-group-item">
					<c:choose>
						<c:when test="${empty teamdetail.file_name }">
							<img alt="qqwe" src="/image/teamlist.png"
								style="width: 100%; height: 100%;">
						</c:when>
						<c:otherwise>
							<img alt="" src="/teamimg/${teamdetail.file_name }"
								style="width: 100%; height: 100%;">
						</c:otherwise>
					</c:choose>
				</li>
				<li class="list-group-item">
					<h4>팀장</h4>
					<p>${teamdetail.leader }</p>
				</li>
				<li class="list-group-item">
					<h4>팀원수</h4>
					<p>${memcount }명</p>
				</li>
				<li class="list-group-item">
					<h4>주종목</h4>
					<p>${teamdetail.sport_category }
						<c:if test="${teamdetail.sport_category eq '축구' }">
				    		/ MMR:${teamdetail.soccer_mmr }
				    	</c:if>
						<c:if test="${teamdetail.sport_category eq '농구' }">
				    		/ MMR:${teamdetail.basketball_mmr }
				    	</c:if>
						<c:if test="${teamdetail.sport_category eq '야구' }">
				    		/ MMR:${teamdetail.baseball_mmr }
				    	</c:if>
						<c:if test="${teamdetail.sport_category eq '탁구' }">
				    		/ MMR:${teamdetail.pingpong_mmr }
				    	</c:if>
						<c:if test="${teamdetail.sport_category eq '배드민턴' }">
				    		/ MMR:${teamdetail.badminton_mmr }
				    	</c:if>
					</p>
				</li>
				<li class="list-group-item">
					<h4>창단일</h4>
					<p>
						<fmt:formatDate value="${teamdetail.fdate }" pattern="yyyy-MM-dd" />
					</p>
				</li>
				<li class="list-group-item">	
					<c:if test="${empty likedto }">
						<img alt="" src="/image/like2.png" id="_like"
							onclick="TeamLike('${teamdetail.team_name}','${user.username }')"
							style="width: 35px; height: 35px;">
						<span id="_like_count">좋아요:${teamdetail.like_count }</span>
					</c:if>
					<c:if test="${not empty likedto }">
						<img alt="" src="/image/like.png" id="_like"
							onclick="TeamLike('${teamdetail.team_name}','${user.username }')"
							style="width: 35px; height: 35px;">
						<span id="_like_count">좋아요:${teamdetail.like_count }</span>
					</c:if>/<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" /> <input type="hidden"
						id="parentTeam_name" value="${teamdetail.team_name }"> <input
						type="hidden" id="parentId" value="${user.username }"> <a
						href="teamReport.do?team_name=${teamdetail.team_name }&id=${user.username }"
						onclick="window.open(this.href, '_blank', 'width=500px,height=400px,toolbars=no,scrollbars=no'); return false;">
						<img alt="" src="/image/report.jpg"
						style="width: 40px; height: 40px; padding-bottom: 10px">
					</a> 신고하기
				</li>
			</ul>

		</div>
		
	</div>

	<div id="jb-content2">

		<ul class="nav nav-tabs">
			<li class="active"><a class="nav-link" data-toggle="tab"
				href="#profile">팀내용</a></li>
			<li class="nav-item"><a class="nav-link" data-toggle="tab"
				href="#member">팀원</a></li>
			<li class="nav-item"><a class="nav-link" data-toggle="tab"
				href="#mmr">MMR</a></li>
		</ul>
		<div id="myTabContent" class="tab-content">

			<div class="tab-pane fade active in" id="profile" >
				<pre id="_tab_content" style="border-top: hidden;">${teamdetail.content }</pre>
			</div>

			<div class="tab-pane fade" id="member">
				<table class="table table-hover table-responsive">
					<thead>
						<tr>
							<th>번호</th>
							<th>아이디</th>
							<th>이름</th>
							<th>키</th>
							<th>몸무게</th>
							<th>직책</th>
						</tr>
					</thead>

					<c:forEach items="${memberlist }" var="member" begin="0" end="9"
						step="1" varStatus="vs">
						<tbody>
							<tr>
								<td>${vs.count }</td>
								<td>${member.id }</td>
								<td>${member.name }</td>
								<td>${member.height }</td>
								<td>${member.weight }</td>
								<td><c:if test="${teamdetail.leader eq member.id }">팀장</c:if>
									<c:if test="${teamdetail.leader ne member.id }">팀원</c:if> <input
									type="hidden" id="_team_name" value="${member.team_name }">
								</td>
							</tr>
						</tbody>
					</c:forEach>

				</table>
			</div>

			<div class="tab-pane fade" id="mmr">
				<table class="table table-hover table-responsive">
					<thead>
						<tr>
							<th>종목</th>
							<th>MMR</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>축구</td>
							<td>${teamdetail.soccer_mmr }</td>
						</tr>
						<tr>
							<td>농구</td>
							<td>${teamdetail.basketball_mmr }</td>
						</tr>
						<tr>
							<td>야구</td>
							<td>${teamdetail.baseball_mmr }</td>
						</tr>
						<tr>
							<td>배드민턴</td>
							<td>${teamdetail.badminton_mmr }</td>
						</tr>
						<tr>
							<td>탁구</td>
							<td>${teamdetail.pingpong_mmr }</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

	</div>

	<div id="jb-sidebar">
		<h2>메뉴</h2>

		<div class="list-group">
			<c:choose>
				<c:when
					test="${ teamdetail.deadline eq 1 && empty mem.team_name && appcount eq 0 }">
					<jsp:include page="include/memappinclude.jsp" />
				</c:when>
				<c:otherwise>
					<c:if test="${teamappcheck > 0 }">
						<a class="list-group-item list-group-item-action disable">신청한
							팀입니다.</a>
					</c:if>
				</c:otherwise>
			</c:choose>


			<c:choose>
				<c:when
					test="${mem.team_name eq teamdetail.team_name && auth.authority eq 'ROLE_TEAMLEADER' }">
					<c:if test="${teamdetail.deadline eq 0 }">
						<a href="recruitment.do?team_name=${teamdetail.team_name }"
							class="list-group-item list-group-item-action"
							onclick="window.open(this.href, '_blank', 'width=500px,height=500px,toolbars=no,scrollbars=no'); return false;">팀원모집하기</a>
					</c:if>
					<c:if test="${teamdetail.deadline eq 1 }">
						<a href="deadline.do?team_name=${teamdetail.team_name }"
							class="list-group-item list-group-item-action">팀원모집마감하기</a>
					</c:if>
					<jsp:include page="include/memappstate.jsp" />
					<a href="#" class="list-group-item list-group-item-action"
						id="_teamup">팀상세정보 수정</a>
					<input type="hidden" id="_team_name"
						value="${teamdetail.team_name }">
					<input type="hidden" id="_sport_category"
						value="${teamdetail.sport_category }">
					<input type="hidden" id="_title" value="${teamdetail.title }">
					<input type="hidden" id="_content" value='${teamdetail.content }'>
					<input type="hidden" id="_file_name"
						value="${teamdetail.file_name }">
					<a
						href="matchinglist.do?name_team1=${teamdetail.team_name }&check=1"
						class="list-group-item list-group-item-action"
						data-toggle="tooltip" data-placement="left" title=""
						data-original-title="Tooltip on left">매칭관리</a>
					<a href="memberstate.do?team_name=${teamdetail.team_name }"
						class="list-group-item list-group-item-action">팀원관리</a>

				</c:when>

				<c:otherwise>
					<c:if test="${teamdetail.deadline eq 0 }">
						<a class="list-group-item list-group-item-action disabled">팀원모집하기</a>
					</c:if>
					<c:if test="${teamdetail.deadline eq 1 }">
						<a class="list-group-item list-group-item-action disabled">팀원모집마감하기</a>
					</c:if>
					<a class="list-group-item list-group-item-action disabled">팀원신청관리</a>
					<a class="list-group-item list-group-item-action disabled">팀상세정보
						수정</a>

					<a
						href="matchinglist.do?name_team1=${teamdetail.team_name }&check=0"
						class="list-group-item list-group-item-action"
						data-toggle="tooltip" data-placement="left" title=""
						data-original-title="Tooltip on left">매칭정보</a>

					<a href="memberstate.do?team_name=${teamdetail.team_name }"
						class="list-group-item list-group-item-action">전체팀원</a>

					<c:choose>
						<c:when
							test="${mem.team_name eq teamdetail.team_name && auth.authority eq 'ROLE_TEAMMEMBER' }">
							<a href="teamSecession.do?id=${user.username }"
								class="list-group-item list-group-item-action">팀탈퇴</a>
						</c:when>
						<c:otherwise>
							<a href="#"
								class="list-group-item list-group-item-action disabled">팀탈퇴</a>
						</c:otherwise>
					</c:choose>

				</c:otherwise>

			</c:choose>
			<%-- <c:if test="${mem.team_name eq teamdetail.team_name && auth.authority eq 'ROLE_TEAMLEADER' }">
				<c:if test="${teamdetail.deadline eq 0 }">
					<a href="recruitment.do?team_name=${teamdetail.team_name }"
						class="list-group-item list-group-item-action"
						onclick="window.open(this.href, '_blank', 'width=500px,height=500px,toolbars=no,scrollbars=no'); return false;">팀원모집하기</a>
				</c:if>
				<c:if test="${teamdetail.deadline eq 1 }">
					<a href="deadline.do?team_name=${teamdetail.team_name }"
						class="list-group-item list-group-item-action">팀원모집마감하기</a>
				</c:if>

				<jsp:include page="include/memappstate.jsp" />

				<a href="matchinglist.do?name_team1=${teamdetail.team_name }"
					class="list-group-item list-group-item-action"
					data-toggle="tooltip" data-placement="left" title=""
					data-original-title="Tooltip on left">매칭관리</a>
				<a href="memberstate.do?team_name=${teamdetail.team_name }"
					class="list-group-item list-group-item-action">팀원관리</a>
				<a href="#" class="list-group-item list-group-item-action" id="_teamup">팀상세정보 수정</a>
					<input type="hidden" id="_team_name" value="${teamdetail.team_name }">
					<input type="hidden" id="_sport_category" value="${teamdetail.sport_category }">
					<input type="hidden" id="_title" value="${teamdetail.title }">
					<input type="hidden" id="_content" value='${teamdetail.content }'>
			</c:if> --%>

		</div>
	</div>
	<div id="jb-footer">
		<input type="hidden" id="_mem_team" value="${mem.team_name }">
	</div>
</div>

<script type="text/javascript">
	$(document).ready(
			function name() {
				var team_name = $("#_team_name").val();
				var sport_category = $("#_sport_category").val();
				var title = $("#_title").val();
				var content2 = $("#_content").val();
				var content = encodeURI(decodeURI(content2));
				var mem_team = $("#_mem_team").val();
				var file_name = $("#_file_name").val();

				if (mem_team == team_name) {
					$("#menu1").css("background-color", "#e60013");
				} else {
					$("#menu3").css("background-color", "#e60013");
				}

				$(document).on(
						"click",
						"#_teamup",
						function() {
							location.href = "detailup.do?team_name="
									+ team_name + "&sport_category="
									+ sport_category + "&title=" + title
									+ "&content=" + content + "&file_name="
									+ file_name;
						});
			});

	function TeamLike(team_name, user_id) {

		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(header, token);
		});

		$.ajax({
			url : "../mypage/TeamLike.do",
			type : "POST",
			data : {
				team_name : team_name,
				id : user_id
			},
			async : true,
			success : function(resp) {
				$("#_like_count").text("좋아요: " + resp.count);
				alert(resp.msg);
				if (resp.msg == "팀 좋아요가 추가 되었습니다.") {
					$("#_like").attr("src", "/image/like.png");
				} else {
					$("#_like").attr("src", "/image/like2.png");
				}
			},
			error : function() {
				alert("error");
			}
		});
	}
</script>


</body>

