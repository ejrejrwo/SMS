package com.boot.finalpro.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.boot.finalpro.member.model.SMS_MemberDTO;


@SuppressWarnings("serial")
public class CustomUser extends User{

	@SuppressWarnings("unused")
	private SMS_MemberDTO dto;
	
	public CustomUser(String username, String password, boolean enabled, boolean accountNonExpired,
			boolean credentialsNonExpired, boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
	}
	
	public CustomUser(SMS_MemberDTO dto) {
		super(dto.getUserid(), dto.getUserpw(), dto.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuthority())).collect(Collectors.toList()));
		this.dto = dto;
	}
	
}
