package com.boot.finalpro.teambbs.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


/*

CREATE TABLE OVERLAP(
	SEQ NUMBER(10) PRIMARY KEY,
	ID VARCHAR2(50) NOT NULL,
	BBS_LIKE NUMBER(10),
	BBS_COOMENT_LIKE NUMBER(10),
	MEMBER_REPORT NUMBER(10),
	BBS_REPORT NUMBER(10),
	BBS_COMMENT_REPORT NUMBER(10)
)

DROP TABLE OVERLAP
CASCADE CONSTRAINTS;

DROP SEQUENCE OVERLAP_SEQ;

CREATE SEQUENCE OVERLAP_SEQ
INCREMENT BY 1
START WITH 1

*/
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class OverlapDTO {

	private int seq;
	private String team_name;
	private String id;					// 신고자 아이디
	private String report_id;			// 신고 대상 아이디
	private int overlap_like;
	private int bbs_like;				// 팀 게시판 좋아요 중복 확인
	private int bbs_comment_like;		// 팀 게시판 댓글 좋아요 중복 확인
	private int member_report;
	private int bbs_report;				// 팀 신고 수 중복 확인
	private int bbs_comment_report;		// 팀 신고 댓글 중복 확인
	private String team_like;				// 팀 좋아요 중복 확인
	private String team_report;			// 팀 신고 중복 확인
	
	private int video_like;
	private int video_comment_like;		
	private int video_report;			
	private int video_comment_report;
	
	private String content;
	
	// 좋아요 중복 체크
	public OverlapDTO(int seq, String id) {
		super();
		this.seq = seq;
		this.id = id;
	}
	
	
}
