package com.boot.finalpro.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

	@Override
	public void onLogoutSuccess(HttpServletRequest req, HttpServletResponse resp, Authentication auth)
			throws IOException, ServletException {

		if(auth != null && auth.getDetails() != null) {
			try {
				req.getSession().invalidate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		log.info("logoutSuc redirect to loginPage");
		
		resp.setStatus(HttpServletResponse.SC_OK);
		
		resp.sendRedirect("/member/loginPage.do");
	}

}
