<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="user" property="principal" />

<div id="top_menu_wrap">
	<div id="_top_menu">

		<nav class="navbar navbar-default">
			<div class="container-fluid">

				<!-- 웹 크기가 일정크기 이하로 작아질때 반응...  -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>

				</div>

				<!--  웹 크기가 일정크기 이상일때  -->
				<div class="collapse navbar-collapse"
					id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">

						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false">사업소개<span
								class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">

								<li><a href="../common/common1.do">인사말</a></li>
								<li><a href="../common/phoneguide.do">문의전화</a></li>
								<li><a href="../common/notice.do?page=1">공지사항</a></li>
								<li><a href="../common/stadium.do?num=1">경기장소개</a></li>


							</ul></li>


						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false">경기정보
								<span class="caret"></span>
						</a>
							<ul class="dropdown-menu" role="menu">

								<li><a href="../common/gamelist.do">경기신청</a></li>
								<li><a href="../common/bettinglist.do">경기일정</a></li>
								<li><a href="../common/gameResultList.do">경기결과</a></li>
								<li><a href="../common/video.do">하이라이트</a></li>
								<li><a href="../common/MMRRankList.do">랭킹</a></li>

							</ul></li>

						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false">팀
								정보 <span class="caret"></span>
						</a>
							<ul class="dropdown-menu" role="menu">

								<li><a href="../mypage/teamapplication.do">팀 등록 및 내팀</a></li>
								<li><a href="../mypage/recruitlist.do">팀 모집</a></li>
								<li><a href="../mypage/teamlist.do">팀 목록</a></li>
								<li><a href="../common/teamBbs.do">팀 게시판</a></li>
								<li><a href="../common/subBbs.do">용병 게시판</a></li>

							</ul></li>

						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false">토너먼트
								<span class="caret"></span>
						</a>
							<ul class="dropdown-menu" role="menu">

								<li><a href="../common/userleagueapply.do">토너먼트 신청</a></li>
								<li><a href="../common/userleaguepage.do">토너먼트 일정</a></li>

							</ul></li>

						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false">채팅방
								<span class="caret"></span>
						</a>
							<ul class="dropdown-menu" role="menu">

								<li><a href="#" onclick="publicChat()">전체채팅</a></li>
								<li><a href="#" onclick="teamChat()">팀 채팅방</a></li>

							</ul></li>

					</ul>


				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid -->
		</nav>

	</div>
</div>

<script type="text/javascript">
	function publicChat() {

		$
				.ajax({
					url : "../common/ChatPublicCheck.do",
					type : "get",
					success : function(data) {
						//alert(data);

						if (data == "로그인후") {
							window
									.open("../member/publicChat.do", "전체채팅",
											"width=550px, height=400px, left=200px, top=200px");
						} else {
							alert("로그인을 해주세요");
						}

					},
					error : function(req, status, error) {
						alert("error");
					}
				});
	}
	function teamChat() {

		$
				.ajax({
					url : "../common/ChatTeamCheck.do",
					type : "get",
					success : function(data) {
						//alert(data);
						if (data == "팀있음") {
							window
									.open("../member/teamChat.do", "팀채팅",
											"width=550px, height=400px, left=200px, top=200px");
						} else if (data == "로그인전") {
							alert("로그인을 해주세요");
						} else {
							alert("소속된 팀이 없습니다");
						}
					},
					error : function(req, status, error) {
						alert("error");
					}
				});

	}
</script>
