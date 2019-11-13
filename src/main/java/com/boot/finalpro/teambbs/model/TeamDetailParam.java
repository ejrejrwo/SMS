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
public class TeamDetailParam {

	private String old_team_name;
	private String team_name;
	private String title;
	private String sport_category;
	private String content;
	private String file_name;

	private String id;

	// 검색용 변수
	private String s_category;
	private String s_keyword;
	

	// 페이징
	private int pageNumber = 0;
	private int recordCountPerPage = 6;

	// db용 변수
	private int start = 1;
	private int end = 6;

}
