package com.boot.finalpro.game.model;

import com.boot.finalpro.util.DateUtil;

public class GameBean {
	
	// GameDTO
	private String category;
	private String name_team1;
	private String gdate;
	private String name_stadium;
	private String title;
	private String content;
	private String gtime;
	private String gday;
	
	// BookingDTO
	private String id;
	private String bdate;
	private int price;
	private String stadium;
	private String stadium1;
	private String stadium2;
	private String book_time;
	
	// MemeberDTO
	private int now_money;
	private int now_point;
	
	private int pay_point;
	
	// StadiumDTO
	private int startNum;
	private int endNum;
	
	
	public GameBean() {
	}		
				
	public GameBean(String name_team1, String name_stadium, String bdate, String book_time) {
		super();
		this.name_team1 = name_team1;
		this.name_stadium = name_stadium;
		this.bdate = bdate;
		this.book_time = book_time;
	}

	public GameBean(int startNum, int endNum) {
		super();
		this.startNum = startNum;
		this.endNum = endNum;
	}

	public int getstartNum() {
		return startNum;
	}

	public void setstartNum(int startNum) {
		this.startNum = startNum;
	}

	public int getendNum() {
		return endNum;
	}

	public void setendNum(int endNum) {
		this.endNum = endNum;
	}

	public int getNow_money() {
		return now_money;
	}

	public void setNow_money(int now_money) {
		this.now_money = now_money;
	}

	public int getPay_point() {
		return pay_point;
	}

	public void setPay_point(int pay_point) {
		this.pay_point = pay_point;
	}


	public int getNow_point() {
		return now_point;
	}

	public void setNow_point(int now_point) {
		this.now_point = now_point;
	}

	public String getCategory() {
		String category = stadium2;
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getName_team1() {
		return name_team1;
	}

	public void setName_team1(String name_team1) {
		this.name_team1 = name_team1;
	}

	public String getGdate() {
		String gdate = gday + " " + DateUtil.five(gtime);
		return gdate;
	}

	public void setGdate(String gdate) {
		this.gdate = gdate;
	}

	public String getStadium() {
		return stadium;
	}

	public void setStadium(String stadium) {
		this.stadium = stadium;
	}
		
	public String getBook_time() {
		return book_time;
	}

	public void setBook_time(String book_time) {
		this.book_time = book_time;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getGtime() {
		return gtime;
	}

	public void setGtime(String gtime) {
		this.gtime = gtime;
	}

	public String getGday() {
		return gday;
	}

	public void setGday(String gday) {
		this.gday = gday;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getBdate() {
		String bdate = gday;
		return bdate;
	}

	public void setBdate(String bdate) {
		this.bdate = bdate;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getName_stadium() {
		String name_stadium = stadium1 + stadium2 + "장";
		return name_stadium;
	}

	public void setName_stadium(String name_stadium) {
		this.name_stadium = name_stadium;
	}

	public String getStadium1() {
		return stadium1;
	}

	public void setStadium1(String stadium1) {
		this.stadium1 = stadium1;
	}

	public String getStadium2() {
		return stadium2;
	}

	public void setStadium2(String stadium2) {
		this.stadium2 = stadium2;
	}

	@Override
	public String toString() {
		return "GameBean [category=" + category + ", name_team1=" + name_team1 + ", gdate=" + gdate + ", stadium="
				+ stadium + ", title=" + title + ", content=" + content + ", gtime=" + gtime + ", gday=" + gday
				+ ", id=" + id + ", bdate=" + bdate + ", price=" + price + ", name_stadium=" + name_stadium
				+ ", book_time=" + book_time + "]";
	}

	
	
	
	

	
	
}

