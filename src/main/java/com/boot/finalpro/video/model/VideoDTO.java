package com.boot.finalpro.video.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
  CREATE TABLE VIDEO(
	SEQ_VIDEO 		NUMBER(10) PRIMARY KEY,
	CATEGORY 		VARCHAR2(100),
	ID 				VARCHAR2(50),
	TITLE 			VARCHAR2(1000),
	CONTENT 		VARCHAR2(4000),
	LIKE_COUNT 		NUMBER(10),
	READ_COUNT 		NUMBER(10),
	REPORT_COUNT	NUMBER(10),
	FILE_NAME 		VARCHAR2(1000),
	DEL				NUMBER(1),
	WDATE 			DATE
);

CREATE SEQUENCE VIDEO_SEQ
START WITH 1
INCREMENT BY 1;
 
 */


@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class VideoDTO {
	
	private int seq_video;
	private String category;
	private String id;
	private String title;
	private String content;
	private int like_count;	
	private int read_count;
	private int report_count;
	private String file_name;
	private int del;
	private Date wdate;
	
	
	private int seq;		// 신고seq
	private String r_id;		// 신고자id
	private String r_content;	// 신고사유
	private int parent;		// 신고된 게시물 seq
	private int r_category;		
	

}





