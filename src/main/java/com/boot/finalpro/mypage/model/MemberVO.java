package com.boot.finalpro.mypage.model;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Entity(name = "member")
public class MemberVO {
	
	@Id
	private String id;
	private String name;
	private String address;
	private String birthday;
	private String phone;
	private String email;
	private String team_name;
	private String regidate;
	
	private int now_money;
	private int total_money;
	private int now_point;
	private int total_point;
	private int report_count;
	
	private double height;
	private double weight;
	
}
