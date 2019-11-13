package com.boot.finalpro.session;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class HttpSession implements HttpSessionListener{

	@Override
	public void sessionCreated(HttpSessionEvent se) {
		// session timeout
		se.getSession().setMaxInactiveInterval(60*15);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
	}
	
}
