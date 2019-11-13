<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="/css/login/regi.css">
	
	<script type="text/javascript" src="/js/login/regi.js"></script>
	<script src="https://www.google.com/recaptcha/api.js" async="true"></script>
	
</head>
<body>

	<form name="signUpForm" class="form" role="form" id="regiFrm">
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	  <div class="form-content">
	  	<img alt="사진없음" src="/image/main_logo.jpg" class="log-img">
	    <input type="text" class="form-control" id="id" name="id" placeholder="아이디">
		<input type="hidden" id="idsave" value="">
		<font color="red" id="idfont">7 ~ 20글자의 영문+숫자로 등록해주십시오</font> <br>
	
		<input type="password" class="form-control" placeholder="비밀번호 입력" id="pwd" name="pwd" required="required" onkeypress="caps_lock(event);">	
	
	    <font color="red" id="pwdfont">8~15자리의 특수,영문+숫자로 등록해주십시오<!-- ( ~!@\#$%&lt;&gt;^&amp;* 만 지원합니다. ) --></font> <br>
	
		<input type="text" class="form-control"placeholder="이름 입력" id="name" name="name"> <br>
	    <input type="text" class="form-control"placeholder="주소입력" id="address" name="address" maxlength="20" onclick="sample6_execDaumPostcode();"> <br>
		<input type="text" class="form-control" placeholder="생년월일(예 : 19920305)" id="birthday" name="birthday" maxlength="8"
	  						onkeypress="return fn_press(event,'numbers');" onkeydown="fn_press_han(this);" style="ime-mode:disabled;"> <br>
		<input type="text" class="form-control" placeholder="전화번호(예 : 01012345678)" id="phone" name="phone" maxlength="11"
	  				 		onkeypress="return fn_press(event,'numbers');" onkeydown="fn_press_han(this);" style="ime-mode:disabled;"> <br>
	    <div class="col-xs-6 col-md-9">
			<input type="text" class="form-control" placeholder="이메일(예 : abc@naver.com)" id="email" name="email" onkeydown="fn_press_han(this);" style="ime-mode:disabled;">
	    </div>
	    <div class="col-xs-6 col-md-3">
	        <button type="button" class="btn btn-default" id="cernumbtn" style="width: 100%">인증</button>
	    </div>
	    <span style="opacity: 0">공간지정</span>
	  	<input type="text" class="form-control" placeholder="인증번호" id="cernum"> <br>
	  	<div class="form-group">
		  	<input type="text" class="form-control" placeholder="신장(예 : 165)" id="height" name="height" maxlength="5"
		  			     onkeydown="fn_press_han(this);" style="ime-mode:disabled;">
	  	</div>
	  	<div class="form-group">
		  	<input type="text" class="form-control" placeholder="체중(예 : 63)" id="weight" name="weight" maxlength="4"
		  				 onkeydown="fn_press_han(this);" style="ime-mode:disabled;">	 
	    </div>
	    <div class="form-group">
	   		<div class="g-recaptcha" data-theme="light" data-sitekey="6Lfjpr4UAAAAALc_fPhqWP8XrhQ2xglhhbA5fRNF" style="transform:scale(1.0);
	   		-webkit-transform:scale(1.0);transform-origin:0 0;-webkit-transform-origin:0 0;"></div>
	    </div>
	    <div class="form-group">
	    	<input type="button" value="회원가입하기" class="btn btn-info" id="accountbtn">
	    </div>
	    <div class="form-group">
	    	<input type="button" value="로그인 하러가기" class="btn btn-default" id="loginBtn">	
	    </div>
	   </div>
	</form>


</body>
</html>