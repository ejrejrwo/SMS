package com.boot.finalpro.mypage.util;

import java.io.Serializable;

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
public class BbsParam implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// id
	private String id;
	
	// search
	private String s_category;	// 제목, 내용, 작성자 3개중 하나의 값이 들어온다.
	private String s_keyword;	// 검색어
	
	// paging
	private int pageNumber = 0;			// 햔재 페이지 
	private int recordCountPerPage = 10;// 표현할 한 페이지의 글수

	// [1] -> 1~10 DB용
	private int start = 1;
	private int end = 10;

}
