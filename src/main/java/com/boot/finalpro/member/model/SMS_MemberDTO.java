package com.boot.finalpro.member.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@SuppressWarnings("serial")
public class SMS_MemberDTO implements Serializable{

	private int seq;
	private String userid;
	private String userpw;
	
//	private boolean isAccountNonExpired = true;
//	private boolean isAccountNonLock = true;
//	private boolean isCredentialsIsNonExpired = true;	
//	private boolean enabled;
	private List<AuthoritiesDTO> authList;
	private Date rdate;
	private int enabled;
	
}
