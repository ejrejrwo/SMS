package com.boot.finalpro.video.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
 DROP TABLE VIDEO_COMMENT
CASCADE CONSTRAINTS;

DROP SEQUENCE VIDEO_COMMENT_SEQ;

CREATE TABLE VIDEO_COMMENT(
	SEQ 			NUMBER(10) PRIMARY KEY,
	ID 				VARCHAR2(50),
	CONTENT			VARCHAR2(2000),
	REF				NUMBER(10),
	STEP			NUMBER(10),
	DEPTH			NUMBER(10),
	PARENT			NUMBER(10),
	DEL				NUMBER(1),
	LIKE_COUNT 		NUMBER(10),
	REPORT_COUNT	NUMBER(10),
	WDATE			DATE
);

CREATE SEQUENCE VIDEO_COMMENT_SEQ
START WITH 1
INCREMENT BY 1;
 */

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class VideoCommentDTO {
	
	private int seq;
	private String id;
	private String content;
	private int ref;
	private int step;
	private int depth;
	private int parent;
	private int del;
	private int like_count;
	private int report_count;
	private Date wdate;
	
	private String oid;
	private int video_comment_like;
	
	private int r_seq;		// 신고seq
	private String r_id;		// 신고자id
	private String r_content;	// 신고사유
	private int r_parent;		// 신고된 게시물 seq
	private int category;	
	
	
		
}

