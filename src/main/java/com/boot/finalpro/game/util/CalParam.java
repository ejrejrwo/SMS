package com.boot.finalpro.game.util;

import java.io.Serializable;
import java.util.Calendar;

public class CalParam implements Serializable{
	
	private String id;
	private String year;
	private String month;
	private String day;
		
	public CalParam() {			
	}

	public CalParam(String id, String year, String month, String day) {
		super();
		this.id = id;
		this.year = year;
		this.month = month;
		this.day = day;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	@Override
	public String toString() {
		return "CalParam [id=" + id + ", year=" + year + ", month=" + month + ", day=" + day + "]";
	}

	



	
	
	
	
}
