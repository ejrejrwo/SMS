package com.boot.finalpro.game.model;

public class BookBean {
	
	private String name_team1;
	private String name_stadium;
	private String bdate;
	private String book_time;
	
	public BookBean(String name_team1, String name_stadium, String bdate, String book_time) {
		super();
		this.name_team1 = name_team1;
		this.name_stadium = name_stadium;
		this.bdate = bdate;
		this.book_time = book_time;
	}
	public String getName_team1() {
		return name_team1;
	}
	public void setName_team1(String name_team1) {
		this.name_team1 = name_team1;
	}
	public String getName_stadium() {
		return name_stadium;
	}
	public void setName_stadium(String name_stadium) {
		this.name_stadium = name_stadium;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
	public String getBook_time() {
		return book_time;
	}
	public void setBook_time(String book_time) {
		this.book_time = book_time;
	}
	@Override
	public String toString() {
		return "BookBean [name_team1=" + name_team1 + ", name_stadium=" + name_stadium + ", bdate=" + bdate
				+ ", book_time=" + book_time + "]";
	}
	
	

}
