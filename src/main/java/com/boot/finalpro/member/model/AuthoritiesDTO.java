package com.boot.finalpro.member.model;

import java.io.Serializable;

@SuppressWarnings("serial")

public class AuthoritiesDTO implements Serializable {

	private int seq;
	private String userid;
	private String authority;
	
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	@Override
	public String toString() {
		return "AuthDTO [seq=" + seq + ", userid=" + userid + ", authority=" + authority + "]";
	}
	public AuthoritiesDTO(int seq, String userid, String authority) {
		super();
		this.seq = seq;
		this.userid = userid;
		this.authority = authority;
	}
	
	public AuthoritiesDTO() {
	}

}
/*
CREATE TABLE `authorities` (
	`SEQ` INT(11) NOT NULL,
	`ID` VARCHAR(1000) NOT NULL,
	`AUTHORITY` VARCHAR(1000) NOT NULL
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;
ALTER TABLE AUTHORITIES ADD CONSTRAINT SEQ_NUM PRIMARY KEY (SEQ)
ALTER TABLE AUTHORITIES MODIFY COLUMN SEQ BIGINT NOT NULL AUTO_INCREMENT
*/

