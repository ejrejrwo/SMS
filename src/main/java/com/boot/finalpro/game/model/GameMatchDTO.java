package com.boot.finalpro.game.model;

import java.util.Date;

/*
DROP TABLE GAMEMATCH
CASCADE CONSTRAINTS;

DROP SEQUENCE GAMEMATCH_SEQ;

CREATE TABLE GAMEMATCH(
	SEQ_GAMEMATCH NUMBER(10) PRIMARY KEY,
	SEQ_GAME NUMBER(10),
	ID VARCHAR2(50),
	TEAM_NAME2 VARCHAR2(100),
	MESSAGE VARCHAR2(1000),
	WDATE DATE
);

CREATE SEQUENCE GAMEMATCH_SEQ
START WITH 1
INCREMENT BY 1;  
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
public class GameMatchDTO {

	private int seq_gamematch;
	private int seq_game;
	private String id;
	private String name_team2;
	private String message;
	private Date wdate;
}
