package com.boot.finalpro.game.model;

/*
 DROP TABLE BOOKING
CASCADE CONSTRAINTS;

DROP SEQUENCE BOOKING_SEQ;

CREATE TABLE BOOKING(
	SEQ_BOOK NUMBER(10) PRIMARY KEY,
	SEQ_GAME NUMBER(10),
	ID VARCHAR2(50),
	BDATE VARCHAR2(50),
	PRICE NUMBER(10),
	NAME_STADIUM VARCHAR2(50),
	WDATE DATE
);

CREATE SEQUENCE BOOKING_SEQ
START WITH 1
INCREMENT BY 1;
 */

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class BookingDTO {

	private int seq_book;
	private int seq_game;
	private String id;
	private String bdate;
//	private Date bdate;
	private int price;
	private int point;
	private String name_stadium;
	private String book_time;
	private Date wdate;
//	private String wdate
	
	private String category;
	
	public BookingDTO(int seq_book, int seq_game, String id, String bdate, int price, int point, String name_stadium,
			String book_time, Date wdate) {
		super();
		this.seq_book = seq_book;
		this.seq_game = seq_game;
		this.id = id;
		this.bdate = bdate;
		this.price = price;
		this.point = point;
		this.name_stadium = name_stadium;
		this.book_time = book_time;
		this.wdate = wdate;
	}
	
	
	
		
}
