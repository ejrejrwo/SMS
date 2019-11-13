<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
	<title>Insert title here</title>

	<% String ctx = request.getContextPath(); %>

	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script type="text/javascript" src="<%=ctx%>/js/myPage/info/myPageInfo.js"></script>
	<link rel="stylesheet" href="<%=ctx%>/css/myPage/info/myPageInfo.css">
	
</head>
<body>

	
	<input type="hidden" id="TName" value="${member.team_name}">
	
	<form id="infoFrm">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<table class="table table-bordered">
			<tr>
				<th>비밀번호</th>
				<td style="text-align: center;">
					<input type="password"  class="form-control" placeholder="비밀번호 입력" id="pwd"
							name="pwd">
					<font color="red" id="pwdfont" size="2px">8~15자리의 특수,영문+숫자로 등록해주십시오</font>
				</td>
			</tr>
			<tr>
					<th>이름</th>
					<td><input type="text" class="form-control" placeholder="이름 입력" id="name" name="name"
						value="${member.name}"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" class="form-control" placeholder="주소입력" id="address"
						name="address" value="${member.address }" maxlength="20" onclick="sample6_execDaumPostcode()" onkeyup="sample6_execDaumPostcode()">
					</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="text" class="form-control" placeholder="생년월일(예 : 19920305)"
						id="birthday" name="birthday" maxlength="8"
						onkeypress="return fn_press(event,'numbers');"
						onkeydown="fn_press_han(this);" style="ime-mode: disabled;"
						value="${member.birthday }"></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td><input type="text" class="form-control" placeholder="전화번호(예 : 01012345678)"
						id="phone" name="phone" maxlength="11"
						onkeypress="return fn_press(event,'numbers');"
						onkeydown="fn_press_han(this);" style="ime-mode: disabled;"
						value="${member.phone }"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" class="form-control" placeholder="이메일(예 : abc@naver.com)"
						id="email" name="email" onkeydown="fn_press_han(this);"
						style="ime-mode: disabled;" value="${member.email }"></td>
				</tr>
				<tr>
					<th>신장</th>
		  			<td>
		  				<input type="text" class="form-control" placeholder="신장(예 : 165.3)" id="height" name="height" maxlength="5"
		  				  onkeydown="fn_press_han(this);" style="ime-mode:disabled;" value="${member.height }">
		  			</td>
		  		</tr>
		  		<tr>
		  			<th>체중</th>
		  			<td>
		  				<input type="text" class="form-control" placeholder="체중(예 : 63.4)" id="weight" name="weight" maxlength="4"
		  				 onkeydown="fn_press_han(this);" style="ime-mode:disabled;" value="${member.weight }">
		  			</td>
		  		</tr>
		  		<tr>
		  			<th colspan="2" style="text-align: center; align-items: center; height: 80px; border: none;">
		  				<div style="margin-top: 10px; margin: auto;">
		  					<button type="button" class="btn btn-primary" id="updateBtn">변경하기</button>
		  					<button type="button" id="deletebtn" class="btn btn-default">계정삭제</button>
		  				</div>
		  			</th>
		  		</tr>
		</table>
	</form>
</body>
</html>