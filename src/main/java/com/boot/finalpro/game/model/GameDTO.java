package com.boot.finalpro.game.model;
/*
DROP TABLE GAME
CASCADE CONSTRAINTS;

DROP SEQUENCE GAME_SEQ;

CREATE TABLE GAME(
	SEQ_GAME NUMBER(10) PRIMARY KEY,
	CATEGORY VARCHAR2(50),
	NAME_TEAM1 VARCHAR2(50),
	NAME_TEAM2 VARCHAR2(50),
	GDATE VARCHAR2(50),
	NAME_STADIUM VARCHAR2(50),
	
	TITLE VARCHAR2(500),
	CONTENT VARCHAR2(2000),
	
	DEL NUMBER(1),
	PAYOUT_R1 NUMBER(5,2),
	PAYOUT_R2 NUMBER(5,2),
	SCORE1 NUMBER(10),
	SCORE2 NUMBER(10),
	GAME_RESULT VARCHAR2(50),
	
	LEAGUE VARCHAR2(50),
	READ_COUNT NUMBER(10),
	WDATE DATE
);

CREATE SEQUENCE GAME_SEQ
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
public class GameDTO {

	private int seq_game;
	private String category;
	private String name_team1;
	private String name_team2;
	private String gdate;
//	private Date gdate;
	private String name_stadium;
	private String title;
	private String content;
	private int del;
	private double payout_r1;
	private double payout_r2;
	private int score1;
	private int score2;
	private String game_result;
	private String league;
	private int read_count;
	private Date wdate;
	
	private boolean bet;		// betting 했는지 여부
	private boolean teamcheck;	// betting할 경기 팀에 속해있는지 여부
	
	private String id;			// betting 성공한 유저 id
	
	private int mmr1;			// 경기 후 변경할 team1 mmr
	private int mmr2;			// 경기 후 변경할 team2 mmr
	
	// 경기 insert용
	public GameDTO(int seq_game, String category, String name_team1, String gdate, String name_stadium, String title,
			String content) {
		super();
		this.seq_game = seq_game;
		this.category = category;
		this.name_team1 = name_team1;
		this.gdate = gdate;
		this.name_stadium = name_stadium;
		this.title = title;
		this.content = content;
	}

	//경기 bbs,detail용
	public GameDTO(int seq_game, String category, String name_team1, String gdate, String name_stadium, String title,
			String content, int del, int read_count, Date wdate) {
		super();
		this.seq_game = seq_game;
		this.category = category;
		this.name_team1 = name_team1;
		this.gdate = gdate;
		this.name_stadium = name_stadium;
		this.title = title;
		this.content = content;
		this.del = del;
		this.read_count = read_count;
		this.wdate = wdate;
	}

	// 리그용 (동욱)
	public GameDTO(String category, String name_team1, String name_team2, String gdate, String name_stadium,
			String title, String content, String league) {
		super();
		this.category = category;
		this.name_team1 = name_team1;
		this.name_team2 = name_team2;
		this.gdate = gdate;
		this.name_stadium = name_stadium;
		this.title = title;
		this.content = content;
		this.league = league;
	}
	
	
	// 베팅할 팀에 속해있는지 체크
	public GameDTO(String name_team1, String name_team2, String id) {
		super();
		this.name_team1 = name_team1;
		this.name_team2 = name_team2;
		this.id = id;
	}

	
	
			
}




















