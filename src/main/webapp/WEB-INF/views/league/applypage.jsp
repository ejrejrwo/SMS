<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
#applyBtn {
	background-color: #0085ca;
}
</style>

<form>
	<h2>안녕하세요 SMS 토너먼트 운영본부입니다.</h2>
	<h3>매달 개최되는 아마추어 토너먼트 대회가 다가옵니다</h3>
	<h3>항상 많은 성원 부탁드리고 대회 안내사항 전해드리겠습니다.</h3>



	<img alt="" src="../image/leagueinfo.png">
	<!-- 
	<p>-참가신천은 대회 2주일전부터 일주일전까지 이뤄집니다.-</p>
	<p>일시: 8강전 매달 2주째 일요일</p>
		 <p>4강전 매달 3주째 일요일</p>
		 <p>결승전 매달 4주째 일요일</p>
		 
	<p>참가비 : 무료</p>
	
	<p>장소 : 잠실 종합체육관</p>
	 -->
	<br> <br> <br>
	<c:if test="${user ne 'anonymousUser'}">
		<button type="button" id="applyBtn" class="btn btn-primary">신청하기</button>

		<button type="button" id="cancelBtn" class="btn btn-danger">취소하기</button>
	</c:if>

</form>

<script type="text/javascript">
	$("#menu1").css("background-color", "#e60013");

	$(function() {
		$("#applyBtn").click(function() {

			$.ajax({
				url : "userleagueapplyAf.do",
				type : "get",
				success : function(data) {
					alert(data);
				},
				error : function(req, status, error) {
					alert("error");
				}
			});

		});
		$("#cancelBtn").click(function() {

			$.ajax({
				url : "leagueapplycancel.do",
				type : "get",
				success : function(data) {
					alert(data);
				},
				error : function(req, status, error) {
					alert("error");
				}
			});

		});
	});
</script>

