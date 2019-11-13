package com.boot.finalpro.game.model;

import java.io.Serializable;

public class GameParam implements Serializable {
	
	private String keyword;		// 검색어
	private String choice;	// 제목, 팀명
	private int sorting;
	
	private int nowpage;		// 현재페이지
	private int totalCount;		// row전체의 수(get)
	private int beginPage;		// 출력시작
	private int endPage;		// 출력끝
	private int displayRow = 5;		// 한페이지의 글 수(set)
	private int displayPage = 3;    // 한 번에 몇 개의 페이지(set)
	private int startNum;
	private int endNum;
	boolean prev;
	boolean next;
	
	public GameParam() {
	}

	public GameParam(String keyword, String choice) {
		super();
		this.keyword = keyword;
		this.choice = choice;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getchoice() {
		return choice;
	}

	public void setchoice(String choice) {
		this.choice = choice;
	}
		
	public int getSorting() {
		return sorting;
	}

	public void setSorting(int sorting) {
		this.sorting = sorting;
	}

	public int getNowpage() {
		return nowpage;
	}

	public void setNowpage(int nowpage) {
		this.nowpage = nowpage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		paging();
	}

	public int getBeginPage() {
		return beginPage;
	}

	public void setBeginPage(int beginPage) {
		this.beginPage = beginPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getDisplayRow() {
		return displayRow;
	}

	public void setDisplayRow(int displayRow) {
		this.displayRow = displayRow;
	}

	public int getDisplayPage() {
		return displayPage;
	}

	public void setDisplayPage(int displayPage) {
		this.displayPage = displayPage;
	}

	public int getStartNum() {
		startNum = (nowpage-1)*displayRow+1;
		return startNum;
	}

	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}

	public int getEndNum() {
		endNum = nowpage*displayRow;
		return endNum;
	}

	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}
	
	private void paging() {
		// nowpage= 3  --> 1,2,3..10
		endPage = ((int)Math.ceil(nowpage / (double)displayPage)) * displayPage;
		beginPage = endPage - (displayPage - 1);
//		System.out.println("beginPage: " + beginPage + " endPage: " + endPage);
		
		int totalPage = (int)Math.ceil(totalCount / (double)displayRow);
//		System.out.println("totalPage: " + totalPage);
		
		if(totalPage <= endPage) {
			endPage = totalPage;
			next = false;
		}else {
			next = true;
		}
		prev = (beginPage == 1)?false:true;
		
//		System.out.println("beginPage: " + beginPage + " endPage: " + endPage);
	}

	@Override
	public String toString() {
		return "GameParam [keyword=" + keyword + ", choice=" + choice + ", sorting=" + sorting + ", nowpage=" + nowpage
				+ ", totalCount=" + totalCount + ", beginPage=" + beginPage + ", endPage=" + endPage + ", displayRow="
				+ displayRow + ", displayPage=" + displayPage + ", startNum=" + startNum + ", endNum=" + endNum
				+ ", prev=" + prev + ", next=" + next + "]";
	}


	
	
	

}











