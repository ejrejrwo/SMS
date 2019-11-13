package com.boot.finalpro.teambbscomment.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
DROP TABLE TEAM_BBS_COMMENT
CASCADE CONSTRAINTS;

DROP SEQUENCE TEAM_BBS_COMMENT_SEQ;

CREATE TABLE TEAM_BBS_COMMENT(
	SEQ 			NUMBER(10) PRIMARY KEY,
	ID 				VARCHAR2(50) NOT NULL,
	REPLY_ID		VARCHAR2(50) NOT NULL,
	CONTENT			VARCHAR2(2000) NOT NULL,
	REF				NUMBER(10) NOT NULL,
	STEP			NUMBER(10) NOT NULL,
	DEPTS			NUMBER(10) NOT NULL,
	PARENT			NUMBER(10) NOT NULL,
	DEL				NUMBER(1) NOT NULL,
	REPORT_COUNT	NUMBER(10) NOT NULL,
	WDATE			DATE NOT NULL
);

CREATE SEQUENCE TEAM_BBS_COMMENT_SEQ
START WITH 1
INCREMENT BY 1

SELECT * FROM TEAM_BBS_COMMENT
*/
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class TeamBBSCommentDTO {

	private int seq;
	private String id;
	private String reply_id;
	private String content;
	private int ref;
	private int step;
	private int depts;
	private int parent;
	private int del;
	private int like_count;
	private int report_count;
	private String wdate;
	
}
