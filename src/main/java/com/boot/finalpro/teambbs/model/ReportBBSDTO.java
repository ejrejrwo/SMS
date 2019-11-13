package com.boot.finalpro.teambbs.model;


/*
CREATE TABLE REPORT_BBS(
	SEQ NUMBER(10) PRIMARY KEY,
	ID VARCHAR2(50) NOT NULL,
	CONTENT VARCHAR2(2000) NOT NULL,
	PARENT NUMBER(10) NOT NULL
);

CREATE SEQUENCE REPORT_BBS_SEQ
START WITH 1
INCREMENT BY 1

DROP TABLE REPORT_BBS
CASCADE CONSTRAINTS;

DROP SEQUENCE REPORT_BBS_SEQ

SELECT * FROM REPORT_BBS 
 
 */
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ReportBBSDTO {

	private int seq;
	private String id;
	private String content;
	private int parent;
	private String report_id;
}
