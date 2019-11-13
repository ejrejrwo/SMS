package com.boot.finalpro.teambbs.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class RecruitTeamParam {

	private String sport_category;
	
	private String s_category;
	private String s_keyword;
	
	private int pageNumber = 0;
	private int recordCountPerPage = 10;

	// db용 변수
	private int start = 1;
	private int end = 10;
}
