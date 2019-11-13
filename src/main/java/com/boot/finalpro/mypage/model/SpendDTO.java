package com.boot.finalpro.mypage.model;

import lombok.AllArgsConstructor;

import lombok.ToString;

import lombok.Setter;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class SpendDTO {

	private int seq;
	private String id;
	private String sdate;
	private int spend_money;
	
}
