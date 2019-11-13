package com.boot.finalpro.mypage.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MessageDTO {

	private int seq;
	private String send_id;
	private String receive_id;
	private String content;
	private int reading;
//	private Date wdate;
//	private Date rdate;
	private String wdate;
	private String rdate;
	private int send_del;
	private int receive_del;
	
}
