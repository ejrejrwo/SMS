<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<% String ctx = request.getContextPath(); %>

	<link rel="stylesheet" href="<%=ctx%>/css/myPage/common/myPageLeftMenu.css">
	
<div class="col-sm-2" style="width: 170px;">
    <nav class="nav-sidebar">
		<ul class="nav tabs" id="mypage-ul">
		  <!-- <li id="li-main"><a href="myPageMain.do"><img src="/image/home.png" alt="myPage"> MyPage</a> -->
		  <li id="li-pay"><a href="myPagePay.do"><img src="<%=ctx%>/image/money.png" alt="myPay"> 결제</a></li>
          <li id="li-msg"><a href="myPageReceiveMessage.do"><img src="<%=ctx%>/image/message.png" alt="myMsg"> 쪽지 함</a></li>
          <li id="li-info"><a href="myPageInfo.do"><img src="<%=ctx%>/image/information.png" alt="myInfo"> 개인정보 수정</a></li>
          <li id="li-exchange"><a href="myPageExchangePage.do" ><img src="<%=ctx%>/image/save-money.png" alt="myExchange"> 환전신청/여부</a></li>                               
		  <li id="li-like"><a href="myPageLike.do"><img src="<%=ctx%>/image/myPageLike.png" alt="myLike"> 내 좋아요</a></li>
		  <li id="li-bbs"><a href="myPageBBS.do"><img src="<%=ctx%>/image/contract.png" alt="myBBS"> 내 작성 게시물</a></li>
		  <li id="li-bet"><a href="myPageBet.do"><img src="<%=ctx%>/image/casino-chip.png" alt="myBet"> 내 배팅 목록</a></li>
		  <li id="li-payInfo"><a href="myPagePayInfo.do"><img src="<%=ctx%>/image/bars.png" alt="myPayInfo"> 내 결제 내역</a>
		  <li id="li-teamApp"><a href="myPageTeamAppInfo.do"><img src="<%=ctx%>/image/myPageTeam.png" alt="myTeamApp"> 팀 신청목록</a>
		</ul> 
	</nav>
</div>

