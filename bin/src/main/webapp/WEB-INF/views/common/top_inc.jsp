<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8" />
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="user" property="principal" />
<script type="text/javascript" src="/js/top_inc.js"></script>

<div id="top_wrap">
	<div id="top_sub">

		<div id="_title_image"
			style="width: 350px; float: left; display: inline;">
			<a href="../common/main.do"><img alt="사진없음"
				src="../image/mainlogo.png" style="height: 120px; width: 350px;"></a>
		</div>


		<div id="_title_menu" style="width: 50%; float: left;">
			<div style="position: relative;">
				<jsp:include page="top_menu.jsp" />
			</div>
		</div>


		<div id="_title_today"
			style="width: 20%; float: right; text-align: right; padding-right: 50px; height: 100%;padding-top: 30px;">
<!-- 			<div
				style="position: relative; top: 35px; margin-right: 5%; width: 350px;"> -->

				<c:if test="${user eq 'anonymousUser'}">
				<button type="button" class="btn btn-primary" title="로그인" style="font-size: 25px"><strong>SMS</strong> 로그인</button>
<!-- 					<a href="../common/loginPage.do" title="로그인">로그인</a>&nbsp;&nbsp;&nbsp;
					<a href="../common/regiPage.do" title="회원가입">회원가입</a> -->
				</c:if>
				
				<c:if test="${user ne 'anonymousUser'}">
					<%-- <input type="text" readonly="readonly" value="${user.username}" class="form-control" style="width: auto;">님 환영합니다!<br> --%>
					<strong>[${user.username}]</strong>님 환영합니다!<br>
					<c:forEach var="auth" items="${user.authorities}" varStatus="c">
					<c:choose>
						<c:when test="${auth eq 'ROLE_ADMIN' }">
							<button type="button" class="btn btn-info admin">관리자메인</button>
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-info member">마이페이지</button>
						</c:otherwise>
					</c:choose>
					</c:forEach>
					 <button type="button" class="btn btn-danger" id="logout" title="로그아웃">로그아웃</button>
					<!-- <a href="../mypage/myPageMain.do">마이페이지</a>&nbsp;&nbsp;&nbsp;
					<button type="button" id="logout" title="로그아웃" class="btn btn-outline-secondary">로그아웃</button>
 -->
<%-- 					<c:forEach var="auth" items="${user.authorities}" varStatus="c">
								
						<c:if test="${auth eq 'ROLE_ADMIN'}">
							<a href="../admin/admin.do">관리자메인</a>
						</c:if>
						 
					</c:forEach> --%>
				</c:if>


				<form id="frm" method="post">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</form>

			<!-- </div> -->
		</div>

	</div>
</div>
<script>
$(".btn-primary").click(function(){
	/* alert("클릭됨"); */
	location.href = "../common/loginPage.do";
});
$(".member").click(function(){
	/* alert("클릭됨"); */
	location.href="../mypage/myPageMain.do";
})
$(".admin").click(function(){
	location.href="../admin/admin.do";
})
</script>
<!-- top_wrap -->
