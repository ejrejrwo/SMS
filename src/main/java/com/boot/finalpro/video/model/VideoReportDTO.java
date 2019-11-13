package com.boot.finalpro.video.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
--------------video_report---------------
DROP TABLE VIDEO_REPORT
CASCADE CONSTRAINTS;

DROP SEQUENCE VIDEO_REPORT_SEQ

CREATE TABLE VIDEO_REPORT(
	SEQ 		NUMBER(10) PRIMARY KEY,
	ID 			VARCHAR2(50) NOT NULL,
	CONTENT 	VARCHAR2(2000) NOT NULL,
	PARENT 		NUMBER(10) NOT NULL,
	CATEGORY	NUMBER(1) NOT NULL
);

CREATE SEQUENCE VIDEO_REPORT_SEQ
START WITH 1
INCREMENT BY 1;
*/

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class VideoReportDTO {
	
	private int seq;		// 신고seq
	private String id;		// 신고자id
	private String content;	// 신고사유
	private int parent;		// 신고된 게시물 seq
	private int category;		// 1:Video	2:VideoComment

}
