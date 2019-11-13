package com.boot.finalpro.game.model;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class GameParams implements Serializable {
	
	// search
	private String choice;	// 검색 항목
	private String keyword;		// 검색어
	
	// paging
	private int pageNum = 1;	// 현재 페이지(get)
	private int totalCount;		// 전체 글 수(get)
	private int startPage;		// 한 페이지의 시작 페이지
	private int endPage;		// 한 페이지의 마지막 페이지
	private int pageSize = 10;		// 한 페이지당 글의 갯수
	private int displayPage = 5;	// 한 페이지에 들어갈 페이지 수
	
	boolean prev;	// prev 버튼이 보일지 여부
	boolean next;	// next 버튼이 보일지 여부
	
	private int sorting;		// 경기 결과가 등록되지 않은 글을 위로 정렬
		
	public void setTotalCount(int totalCount) {
		// setTotalCount()를 꼭 호출해야 paging이 되기 때문에 paging() 함수를 setTotalCount()를 호출했을 때 자동으로 호출되게 한다.
		this.totalCount = totalCount;
		paging();
	}
	
	private void paging() {
		// prev, next, startPage, endPage 계산
		endPage = ((int) Math.ceil(pageNum/(double)displayPage)) * displayPage;
		System.out.println("endPage : " + endPage);
		
		startPage = endPage - (displayPage - 1);
		System.out.println("startPage : " + startPage);
		
		int totalPage = (int) Math.ceil(totalCount/(double)pageSize);
		
		if(totalPage <= endPage) {
			endPage = totalPage;
			next = false;
		}
		else {
			next = true;
		}
		prev = (startPage == 1)?false:true;		// 시작 페이지가 1이면 안나옴
		
		System.out.println("endPage : " + endPage);
		System.out.println("totalPage : " + totalPage);
	}

}
