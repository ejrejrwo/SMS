package com.boot.finalpro.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest req, HttpServletResponse resp, Authentication auth) throws IOException, ServletException {
	
		log.warn("login Suc");
	
		List<String> roleNames = new ArrayList<String>();
		
		// auth을 통하여 권한이름을 roleNames 리스트에 저장	람다식 ->  매게변수 {실행문} (함수 선언없이 이런식으로 함수를 사용하게 만들어준다.)
		auth.getAuthorities().forEach(member_auth -> {roleNames.add(member_auth.getAuthority());});
	
		log.warn("ROLE NAMES : " + roleNames);
		
		if(roleNames.contains("ROLE_ADMIN")) {
			resp.sendRedirect("/common/main.do");
			return;
		}
		else if(roleNames.contains("ROLE_MEMBER")) {
			resp.sendRedirect("/common/main.do");
			return;
		}else if(roleNames.contains("ROLE_TEAMLEADER")) {
			resp.sendRedirect("/common/main.do");
			return;
		}else if(roleNames.contains("ROLE_TEAMMEMBER")) {
			resp.sendRedirect("/common/main.do");
			return;
		}else if(roleNames.contains("ROLE_DELETE")) {
			resp.sendRedirect("/common/delete.do");
		}
		else {
			resp.sendRedirect("/welcome.do");
			return;
		}
	
	}

}
