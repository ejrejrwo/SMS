<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>

	<% String ctx = request.getContextPath(); %>

	<link rel="stylesheet" href="<%=ctx%>/css/myPage/common/myPageTopMenu.css">
	<script type="text/javascript" src="<%=ctx%>/js/myPage/common/myPageTopMenu.js"></script>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<!-- 전체 약간 회색 배경다이브 -->
	<div class="menu-background">
		<!-- 내용 전체 다이브 -->
		<div class="menu-container">
			<!-- 포인트, 머니 뿌려줄 리스트...? -->
			<ul>
				<li>
					<!-- 현 등급 및 등급보기 버튼있는 다이브 -->
					<div class="menu-content-grade-title">
						<div class="menu-content-grade-title_content1">
							<p class="grade-title-font">${member.name}님의 등급 </p>
						</div> 
						<div class="menu-content-grade-title_content2">
							<c:if test="${(member.total_point gt -1) and (member.total_point lt 1000)}">
								<p class="grade-font">
									SMS 비기너
									<img src="<%=ctx%>/image/grade1.png" width="16px" height="16px;">
								</p>
								 
							</c:if>
							<c:if test="${(member.total_point gt 1000) and (member.total_point lt 5000)}">
								<p class="grade-font">
									SMS 아머추어
									<img src="<%=ctx%>/image/grade2.png" width="16px" height="16px;">
								</p>
							</c:if>
							<c:if test="${(member.total_point gt 5000) and (member.total_point lt 20000)}">
								<p class="grade-font">
									SMS 세미프로
									<img src="<%=ctx%>/image/grade3.png" width="16px" height="16px;">
								</p>
							</c:if>
							<c:if test="${(member.total_point gt 20000) and (member.total_point lt 99999)}">
								<p class="grade-font">
									SMS 프로페셔널
									<img src="<%=ctx%>/image/grade4.png" width="16px" height="16px;">
								</p>
							</c:if>
							<c:if test="${(member.total_point gt 99999)}">
								<p class="grade-font">
									SMS 킹
									<img src="<%=ctx%>/image/crown.png" width="16px" height="16px;">
								</p>
							</c:if>
							
							<label id="grade">등급표 보기</label>
						</div>	
					</div>
				</li>
				<li>
					<!-- 토탈머니 -->
					<div class="menu-content-number">
						<div class="menu-content-number_content1">
							<b>Total Money</b>
						</div>
						<div class="menu-content-number_content2">
							<p>${member.total_money} <b>머니</b></p>
						</div>
					</div>
				</li>
				<li>
					<!-- 나우머니 -->
					<div class="menu-content-number">
						<div class="menu-content-number_content1">
							<b>Now Money</b>
						</div>
						<div class="menu-content-number_content2">
							<p>${member.now_money} <b>머니</b></p>
						</div>
					</div>
				</li>
				<li>
					<!-- 토탈포인트 -->				
					<div class="menu-content-number">
						<div class="menu-content-number_content1">
							<b>Total Point</b>
						</div>
						<div class="menu-content-number_content2">
							<p>${member.total_point} <b>포인트</b></p>
						</div>
					</div>				
				</li>
				<li>
					<!-- 나우포인트 -->
					<div class="menu-content-number" style="margin-right: 0px;">
						<div class="menu-content-number_content1">
							<b>Now Point</b>
						</div>
						<div class="menu-content-number_content2">
							<p>${member.now_point} <b>포인트</b></p>
						</div>
					</div>
				</li>				
			</ul>		
		</div>
	</div>
	
	<!-- 등급표 -->
	<div class="grade-container">
		<div class="grade-content">
			<ul>
				<li>
					<div class="menu-content-grade">
						<div class="menu-content-grade_content1">
							<p>SMS 비기너</p>
							<img src="/image/grade1.png">
						</div>
						<div class="menu-content-grade_content2">
							<p class="grade-cutline">0~1000</p>
						</div>
					</div>
				</li>
				<li>
					<div class="menu-content-grade">
						<div class="menu-content-grade_content1">
							<p>SMS 아마추어</p>
							<img src="/image/grade2.png">
						</div>
						<div class="menu-content-grade_content2">
							<p class="grade-cutline">1000~5000</p>
						</div>
					</div>
				</li>
				<li>
					<div class="menu-content-grade">
						<div class="menu-content-grade_content1">
							<p>SMS 세미프로</p>
							<img src="/image/grade3.png"> 
						</div>
						<div class="menu-content-grade_content2">
							<p class="grade-cutline">5000~20000</p>
						</div>
					</div>
				</li>
				<li>
					<div class="menu-content-grade">
						<div class="menu-content-grade_content1">
							<p>SMS 프로페셔널</p>
							<img src="/image/grade4.png">
						</div>
						<div class="menu-content-grade_content2">
							<p class="grade-cutline">20000~99999</p>
						</div>
					</div>
				</li>
				<li>
					<div class="menu-content-grade">
						<div class="menu-content-grade_content1">
							<p>SMS 킹</p>
							<img src="/image/crown.png">
						</div>
						<div class="menu-content-grade_content2">
							<p class="grade-cutline">99999~</p>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	
	
</body>
</html>