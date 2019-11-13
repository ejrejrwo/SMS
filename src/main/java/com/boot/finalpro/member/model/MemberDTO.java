package com.boot.finalpro.member.model;

import java.util.Date;

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
public class MemberDTO {

	private String id;
	
	private String pwd;		// security 용 pwd;
	
	private String name;
	private String address;
	private String birthday;
	private String phone;
	private String email;
	private String team_name;
	private int now_money;
	private int total_money;
	private int now_point;
	private int total_point;
	private double height;
	private double weight;
	private int report_count;
	//private Date regidate;
	private String regidate;
	
	// 예외 머니
	private int money;
//	private String reg_date;
	
	// 이메일 인증용
	private String cerNumber;
	
	
	// 경기장 결제용
	public MemberDTO(String id, int now_money, int total_money, int now_point, int total_point) {
		super();
		this.id = id;
		this.now_money = now_money;
		this.total_money = total_money;
		this.now_point = now_point;
		this.total_point = total_point;
	}
	
	
}
