package com.boot.finalpro.mypage.model;

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
public class ExchangeDTO {

	private int seq;
	private String id;
	private String bank;
	private String bank_number;
	private int exchange_money;
	private String exdate;
	private String sdate;
	private int ex_check;
}
