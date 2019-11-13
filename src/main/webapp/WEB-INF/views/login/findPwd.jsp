<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="/css/login/findPwd.css">
	<script type="text/javascript" src="/js/login/findPwd.js"></script>
	
</head>
<body>
	
<form name="signUpForm" class="form" role="form" id="regiFrm">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
  <div class="form-content">
  	<img alt="사진없음" src="/image/main_logo.jpg" class="log-img">
    <div class="col-xs-6 col-md-9">
		<input type="text" class="form-control" id="userid" name="id" placeholder="아이디">
    	<font color="red" id="idFont">없는 아이디 입니다.</font>
    </div>
    <div class="col-xs-6 col-md-3">
        <button type="button" class="btn btn-default" id="fincPwdBtn">인증</button>
    </div>
    <span style="opacity: 0">공간지정</span>
    <input type="text" class="form-control" placeholder="인증번호" id="cernum" onkeypress="return fn_press(event,'numbers');" onkeydown="fn_press_han(this);"> <br>
	<input type="password" class="form-control" placeholder="바꾸실비밀번호" id="pwd" name="pwd"> <br>
   	<font color="red" id="pwdFont">영문, 숫자, 특수기호 8~15자리로 구성해야 합니다.</font>
    <div class="form-group">
    	<input type="button" value="비밀번호 변경" class="btn btn-info" id="changBtn">
    </div>
    <div class="form-group">
    	<input type="button" value="로그인 하러가기" class="btn btn-default" id="loginBtn">	
    </div>
   </div>
</form>
	
</body>
</html>