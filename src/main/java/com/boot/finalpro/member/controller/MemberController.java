package com.boot.finalpro.member.controller;

import java.security.Principal;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value = "/member/*")
public class MemberController {
	
	
	
	@RequestMapping(value = "teamtest.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String teamtest(Principal pcp, HttpServletRequest req) {
		UserDetails ud = (UserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Iterator<?> it = ud.getAuthorities().iterator();
		while(it.hasNext()) {
			System.out.println(it.next().toString());
		}
		
		SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		/*
		//spring security가 관리하고 있던 auth(인가) 정보를 가져왔다 
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		log.info(auth.toString());
		
		//auth가 갖는 권한정보 list를 가져옴
		List<GrantedAuthority> updatedAuth = new ArrayList<GrantedAuthority>(auth.getAuthorities());
		
		//새로운 권한 설정
		for(GrantedAuthority g : updatedAuth) {
			log.info("----------------------------------------");
			log.info(g.toString());
		}
		updatedAuth.clear();
		//updatedAuth.add(new SimpleGrantedAuthority("ROLE_TEAMLEADER"));
		updatedAuth.add(new SimpleGrantedAuthority("ROLE_TEAMLEADER"));
		
		//새로운 권한정보를 설정한 객체를 생성
		Authentication newAuth = new UsernamePasswordAuthenticationToken(auth.getPrincipal(), auth.getCredentials(), updatedAuth);
		
		//새 권한정보를 갖는 객체를 현재 시큐리티 세션에 알려줌
		SecurityContextHolder.getContext().setAuthentication(newAuth);
		
		//SecurityContextHolder.setContext( SecurityContextHolder.getContext() );
		
		auth = SecurityContextHolder.getContext().getAuthentication();
		updatedAuth = new ArrayList<GrantedAuthority>(auth.getAuthorities());
		log.info("auth size : " + updatedAuth.size());
		for(GrantedAuthority g : updatedAuth) {
			log.info(g.toString());
		}
				
		log.info("권한설정 끝");
		/**/
		//return "main.do";
		
		return "redirect:/common/main.do";
		
	}
	
	
	
}
