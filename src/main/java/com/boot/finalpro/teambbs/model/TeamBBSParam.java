package com.boot.finalpro.teambbs.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Data
public class TeamBBSParam {

	// 팀이름 조건을 넣기위한 변수
	private String team_name;
	
	// 검색 키워드
	private String s_category;			// 작성자, 제목, 내용
	private String s_keyword;			// 검색어
	private String subject_category;	// 공지, 일반, 후기, 전술.
	private String sub_keyword;			// 분류 검색어
	
	// 페이징
	private int pageNumber = 0;
	private int recordCountPerPage = 10;
	
	// DB용 변수
	private int start = 1;
	private int end = 10;
	
	
	
}
