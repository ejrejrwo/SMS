package com.boot.finalpro.admin.util;

import java.io.Serializable;

public class SearchUtillDto implements Serializable {

	private String category;
	private String searchText;
	private String begin;
	private String end;
	private int g_result;
	private int page;
	
	public SearchUtillDto() {
		// TODO Auto-generated constructor stub
	}

	public SearchUtillDto(String category, String searchText, String begin, String end, int g_result, int page) {
		super();
		this.category = category;
		this.searchText = searchText;
		this.begin = begin;
		this.end = end;
		this.g_result = g_result;
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

	public int getG_result() {
		return g_result;
	}

	public void setG_result(int g_result) {
		this.g_result = g_result;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	@Override
	public String toString() {
		return "SearchUtillDto [category=" + category + ", searchText=" + searchText + ", begin=" + begin + ", end="
				+ end + ", g_result=" + g_result + ", page=" + page + "]";
	}
	
	
	
}