<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
table {
	border-collapse: collapse;
}

th {
	background-color: #042E6F;
	color: white;
	padding: 15px;
	text-align: center;
}

td {
	border-bottom: 1px solid #A2AAC1;
	padding: 12px;
}

#jb-container {
	width: 1200px;
	margin: 0px auto;
	padding: 20px;
}

#jb-header {
	padding: 20px;
	margin-bottom: 20px;
	margin-left: auto;
	margin-right: auto;
}

#_search #_s_category, #_s_keyword, #_btnSearch {
	float: right;
	margin-left: 10px;
}

#paging_wrap {
	margin: 0;
}

#jb-footer {
	clear: both;

}

#jb-content1 {
	width: 1200px;
	margin-left: 3px;
	margin: 0;
}

#jb-content11 {
	/* width: 380px; */
	margin-top: 30px;
	padding-top: 30px; margin-left : 30px;
	padding-left: 30px;
	margin: 0;
	float: left;
	margin-left: 30px;
}

#jb-header-btn {
	float: left;
}

.snip1361 {
	position: relative;
	overflow: hidden;
	margin: 10px;
	min-width: 230px;
	max-width: 315px;
	width: 100%;
	color: #141414;
	text-align: left;
	line-height: 1.4em;
	font-size: 16px;
}

.snip1361 * {
	-webkit-box-sizing: border-box;
	box-sizing: border-box;
	-webkit-transition: all 0.35s ease;
	transition: all 0.35s ease;
}

.snip1361 img {
	width: 300px;
	height: 250px;
	vertical-align: top;
}

.snip1361 figcaption {
	position: absolute;
	top: calc(77%);
	width: 100%;
	background-color: #ffffff;
	padding: 15px 25px 65px;
}

.snip1361 figcaption:before {
	position: absolute;
	content: '';
	z-index: 2;
	bottom: 100%;
	left: 0;
	width: 100%;
	height: 80px;
	background-image: -webkit-linear-gradient(top, transparent 0%, #ffffff 100%);
	background-image: linear-gradient(to bottom, transparent 0%, #ffffff 100%);
}

.snip1361 h3, .snip1361 p {
	margin: 0 0 10px;
}

.snip1361 h3 {
	font-weight: 300;
	font-size: 1.4em;
	line-height: 1.2em;
	font-family: 'Oswald', Arial, sans-serif;
	text-transform: uppercase;
}

.snip1361 p {
	font-size: 0.9em;
	letter-spacing: 1px;
	opacity: 0.9;
}

.snip1361 a {
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	z-index: 2;
}

.snip1361:hover figcaption, .snip1361.hover figcaption {
	top: 80px;
}

#_sport_span {
	position: absolute;
	top: 0;
	left: 0;
	height: 22px;
	padding: 0 13px;
	background: #333;
	font-size: 13px;
	color: #fff;
	line-height: 22px;
}
</style>


<h1>팀리스트</h1>


<div id="jb-container">

	<form action="" name="frmForm1" id="_frmFormSearch" method="post">
		<div class="card mb-3" id="jb-content1">

			<div id="jb-header">
				<div id="jb-header-btn">
					<select id="_sport" name="sport_category"
						onchange="chageSelectedValue()" class="form-control"
						style="width: 110px;">
						<option value=""
							<c:if test="${empty sport_category }">selected='selected'</c:if>>모든종목</option>
						<option value="축구"
							<c:if test="${sport_category == '축구'}">selected='selected'</c:if>>축구</option>
						<option value="야구"
							<c:if test="${sport_category == '야구'}">selected='selected'</c:if>>야구</option>
						<option value="농구"
							<c:if test="${sport_category == '농구'}">selected='selected'</c:if>>농구</option>
						<option value="탁구"
							<c:if test="${sport_category == '탁구'}">selected='selected'</c:if>>탁구</option>
						<option value="배드민턴"
							<c:if test="${sport_category == '배드민턴'}">selected='selected'</c:if>>배드민턴</option>
					</select>
				</div>
				<div id="_search">
					<button type="button" id="_btnSearch" class="btn btn-primary"
						style="width: 60px;">검색</button>
					<input type="text" id="_s_keyword" name="s_keyword"
						class="form-control" style="width: 130px;"> <select
						id="_s_category" name="s_category" class="form-control"
						style="width: 90px;">
						<option value="">검색어</option>
						<option value="team_name">팀이름</option>
						<option value="leader">팀장</option>
						<option value="title">한줄소개</option>
					</select>
				</div>
			</div>
			<c:if test="${empty teamlist }">
				<div>
					<img alt="" src="/image/warning.png"
						style="width: 150px; height: 150px;">
				</div>
				<div>
					<h2>찾으시는 팀이 없습니다</h2>
				</div>
			</c:if>
			<c:forEach items="${teamlist }" var="team" varStatus="vs">
				<div id="jb-content11">

					<figure class="snip1361">
						<c:choose>
							<c:when test="${empty team.file_name }">
								<img alt="sample45" src="/image/teamlist.png">
							</c:when>
							<c:otherwise>
								<img alt="sample45" src="/teamimg/${team.file_name }">
							</c:otherwise>
						</c:choose>
						<!-- <img
							src="/image/team.png"
							alt="sample45" /> -->
						<span id="_sport_span">
						<c:if test="${team.sport_category == '축구'}">축구</c:if>
						<c:if test="${team.sport_category == '농구'}">농구</c:if>
						<c:if test="${team.sport_category == '야구'}">야구</c:if>
						<c:if test="${team.sport_category == '탁구'}">탁구</c:if>
						<c:if test="${team.sport_category == '배드민턴'}">배드민턴</c:if>
						</span>
						<figcaption>
							<h3 style="padding-bottom: 3px;">${team.team_name }</h3>
							<p>팀장명:${team.leader }</p>
							<p>창단일:<fmt:formatDate value="${team.fdate }" pattern="yyyy-MM-dd" /></p>
							<p>한줄소개:${team.title }</p>
						</figcaption>
						<a href="teamdetail.do?team_name=${team.team_name }"></a>
					</figure>
					
					<%-- <h3 class="card-header">${team.team_name }</h3>
					<div class="card-body">
						<h5 class="card-title">
							팀장명:<a onclick="_go_send_message('${team.leader}')" href="#">${team.leader }</a>
						</h5>
						<h6 class="card-subtitle text-muted">
							창단일:
							<fmt:formatDate value="${team.fdate }" pattern="yyyy-MM-dd" />
						</h6>
					</div>  --%>

					<%-- <a href="teamdetail.do?team_name=${team.team_name }"> 
						<c:choose>
							<c:when test="${empty team.file_name }">
								<img alt="" src="/image/team.png"
									style="width: 250px; height: 150px;">
							</c:when>
							<c:otherwise>
								<img alt="" src="/teamimg/${team.file_name }"
									style="width: 350px; height: 150px;">
							</c:otherwise>
						</c:choose>
					</a>
					<div id="jb-content22">
						<div id="jb-content22-1">
							<c:if test="${team.sport_category == '축구'}">
								<img alt="" src="../image/soccer.png"
									style="width: 60px; height: 60px;">
							</c:if>
							<c:if test="${team.sport_category == '농구'}">
								<img alt="" src="../image/basketball.png"
									style="width: 60px; height: 60px;">
							</c:if>
							<c:if test="${team.sport_category == '야구'}">
								<img alt="" src="../image/baseball.png"
									style="width: 60px; height: 60px;">
							</c:if>
							<c:if test="${team.sport_category == '배드민턴'}">
								<img alt="" src="../image/badminton.png"
									style="width: 60px; height: 60px;">
							</c:if>
							<c:if test="${team.sport_category == '탁구'}">
								<img alt="" src="../image/ping-pong.png"
									style="width: 60px; height: 60px;">
							</c:if>
						</div>
						<div id="jb-content22-2" style="text-align: left;">
							<p style="font-size: 25px; margin-bottom: 0px;">${team.team_name }</p>
							<p>
								팀장명:<a onclick="_go_send_message('${team.leader}')" href="#">${team.leader }</a>
							</p>
						</div>
					</div> --%>

				</div>
			</c:forEach>

		</div>

		<c:choose>
			<c:when test="${empty teamlist }"></c:when>
			<c:otherwise>

				<div id="paging_wrap">
					<jsp:include page="include/paging.jsp" flush="false">
						<jsp:param name="pageNumber" value="${pageNumber }" />
						<jsp:param name="totalRecordCount" value="${totalRecordCount }" />
						<jsp:param name="pageCountPerScreen"
							value="${pageCountPerScreen }" />
						<jsp:param name="recordCountPerPage"
							value="${recordCountPerPage }" />
					</jsp:include>
				</div>
			</c:otherwise>
		</c:choose>
		<jsp:include page="include/BbssendMessage2.jsp" />

		<div id="jb-footer">

			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> <input type="hidden" name="pageNumber"
				id="_pageNumber" value="${(empty pageNumber)?0:pageNumber }">
			<input type="hidden" name="recordCountPerPage"
				id="_recordCountPerPage"
				value="${(empty recordCountPerPage)?0:recordCountPerPage }">


		</div>
	</form>
</div>





<script type="text/javascript">
	$(document).ready(function() {
		$("#menu3").css("background-color", "#e60013");
		$("#_s_category").val("${s_category}");
		$("#_s_keyword").val("${s_keyword}");
	});

	function goPage(pageNumber) {
		$("#_pageNumber").val(pageNumber);
		$("#_frmFormSearch").attr("action", "teamlist.do").submit();
	}

	$("#_btnSearch").click(function() {
		//alert("click");
		$("#_pageNumber").val(0);
		$("#_frmFormSearch").attr("action", "teamlist.do").submit();
	});

	function chageSelectedValue() {
		/*   var sport = document.getElementById("_sport").value;
		  var league = document.getElementById("_league").value;
		  var game_result = document.getElementById("_game_result").value; */
		$("#_frmFormSearch").attr("action", "teamlist.do").submit();
	}

	$(".hover").mouseleave(function() {
		$(this).removeClass("hover");
	});
</script>
