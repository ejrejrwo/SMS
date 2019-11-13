package com.boot.finalpro.security;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.boot.finalpro.member.dao.impl.MemberDAOImpl;
import com.boot.finalpro.member.model.SMS_MemberDTO;
import com.boot.finalpro.security.domain.CustomUser;

import lombok.extern.slf4j.Slf4j;

/*
 db에서 사용자 정보를 가져오는 역활입니다. 
*/

@Slf4j
public class CustomUserDetailesSerivce implements UserDetailsService {

	@Autowired
	private MemberDAOImpl memberDao;
	
	// 인코더
	@Autowired
	BCryptPasswordEncoder bc;
	
	@Autowired
	HttpSession session;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		log.warn("username == " + username);
		// 여기서 dao 실행
		
		SMS_MemberDTO member = memberDao.getOneMemberByMemberId(username);
		
		//session.setAttribute("", member);
		
		log.info("username == " + bc.encode(username));
		//log.info("!!!!!!!!!!!!!!!!!!!!!!!!username == " + bc.encode("admin"));
		log.info("member :" + member.toString());
		
		return member == null ? null : new CustomUser(member);
	}

}
