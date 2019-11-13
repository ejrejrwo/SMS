package com.boot.finalpro.admin.util;

import java.io.Serializable;

public class SearchUtill_ExchangeDto implements Serializable {

	private String category;
	private String searchText;
	private String begin;
	private String end;
	private String ex_check;
	private String sort;
	private int page;
	
	public SearchUtill_ExchangeDto() {
		// TODO Auto-generated constructor stub
	}

	public SearchUtill_ExchangeDto(String category, String searchText, String begin, String end, String ex_check,String sort,
			int page) {
		super();
		this.category = category;
		this.searchText = searchText;
		this.begin = begin;
		this.end = end;
		this.ex_check = ex_check;
		this.sort = sort;
		this.page = page;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	public String getBegin() {
		return begin;
	}

	public void setBegin(String begin) {
		this.begin = begin;
	}

	public String getEnd() {
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getEx_check() {
		return ex_check;
	}

	public void setEx_check(String ex_check) {
		this.ex_check = ex_check;
	}

	
	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	@Override
	public String toString() {
		return "SearchUtill_ExchangeDto [category=" + category + ", searchText=" + searchText + ", begin=" + begin
				+ ", end=" + end + ", ex_check=" + ex_check + ", sort=" + sort + ", page=" + page + "]";
	}


	
	
}
