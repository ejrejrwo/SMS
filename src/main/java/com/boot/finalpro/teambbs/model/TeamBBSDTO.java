package com.boot.finalpro.teambbs.model;



/*

CREATE TABLE TEAM_BBS(
    SEQ 					NUMBER(10) PRIMARY KEY,
    ID 						VARCHAR2(50) NOT NULL,
    TEAM_NAME 				VARCHAR2(100) NOT NULL,
    TITLE 					VARCHAR2(500) NOT NULL,
    CONTENT 				VARCHAR2(4000) NOT NULL,
    LIKE_COUNT 				NUMBER(10) NOT NULL,
    REPORT_COUNT			NUMBER(10) NOT NULL,
    SUBJECT_CATEGORY 		VARCHAR2(50) NOT NULL,
    READ_COUNT 				NUMBER(10) NOT NULL,
    WDATE 					DATE NOT NULL,
    FILE_NAME 				VARCHAR2(1000),
    ORIGINAL_FILE_NAME 		VARCHAR2(1000)
);

*/



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
public class TeamBBSDTO {
	
	private int seq;
	private String id;
	private String team_name;
	private String title;
	private String content;
	private int like_count;
	private int report_count;
	private String subject_category;
	private int read_count;
	private String wdate;
	private String file_name;
	private String original_file_name;
	
	private double height;	// 조인용 키
	private double weight;	// 조인용 무게
	private String email;	// 조인용 이메일
	
	private int comment_report_count;
	
	// 게시판 글쓰기 생성자
	public TeamBBSDTO(String id, String team_name, String title, String content, String subject_category) {
		super();
		this.id = id;
		this.team_name = team_name;
		this.title = title;
		this.content = content;
		this.subject_category = subject_category;
	}
	// 게시판 수정 생성자
	public TeamBBSDTO(String title, String content, String subject_category) {
		super();
		this.title = title;
		this.content = content;
		this.subject_category = subject_category;
	}
}
