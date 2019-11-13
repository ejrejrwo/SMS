package com.boot.finalpro.mypage.model;

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
public class ProfitDTO {

	private int seq;
	private String id;
	private String pdate;
	private int profit_money;
	
}
