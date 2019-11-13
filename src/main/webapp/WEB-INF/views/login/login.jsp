<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" />

<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/js/login/login.js"></script>
<link rel="stylesheet" href="/css/login/login.css">
<title>Insert title here</title>
</head>
<body>
	<form class="form-horizontal" id="frm">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<div class="form-content">
	    	<img alt="사진없음" src="/image/main_logo.jpg" class="log-img">
		    <div class="form-group" id="id-div">
		    	<input type="text" class="form-control" id="id" name="username" placeholder="아이디">
		    </div>
		    <div class="caps-div">
		    	<font id="capslock"><b>CapsLock</b>키가 눌려있습니다.</font>
		    </div>
		    <div class="form-group">
		     	<input type="password" class="form-control" id="pwd" name="password" placeholder="비밀번호" required="required" onkeypress="caps_lock(event);">
		    </div>
		    <div class="form-group">
		    	<c:if test="${not empty SPRING_SECURITY_LAST_EXCEPTION}">
				    <font color="red" id="security-login-font">
				        아이디 혹은 비밀번호를 다시 확인해 주세요.
				    </font>
				</c:if>
				<font id="login-info-font"></font>
		    </div>
		    <div class="form-group">
		    	<div class="checkbox" style="text-align: left">
		    		<label>
			          <input type="checkbox" id="chk_save_id"> 아이디 기억
			        </label>
		    	</div>
			</div>
			<div class="form-group">
		     	<button type="submit" class="btn btn-default" style="width: 100%;" id="loginbtn">로그인</button>
		    </div>
		    <div class="form-group">
		     	<button type="button" class="btn btn-default" style="width: 100%;" id="pwdBtn">비밀번호 찾기</button>
		    </div>
		    <div class="form-group">
		     	<button type="button" class="btn btn-info" style="width: 100%; height: 44px;" id="regiBtn">회원가입</button>
		    </div>
		</div>
	</form>
</body>
</html>