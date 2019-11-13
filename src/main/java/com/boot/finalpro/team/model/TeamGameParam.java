package com.boot.finalpro.team.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class TeamGameParam {

	private int seq_game;
	private String sport;
	private String name_team1;
	private String team_name;
	private String game_result;
	private String league;
	
	private boolean bet;		// betting 했는지 여부
	private boolean teamcheck;	// betting할 경기 팀에 속해있는지 여부
	
	private String id;			// betting 성공한 유저 id
	
	private int mmr1;			// 경기 후 변경할 team1 mmr
	private int mmr2;			// 경기 후 변경할 team2 mmr
	
	// 리그 변수
	private String league1;
	

	// 페이징
	private int pageNumber = 0;
	private int recordCountPerPage = 6;

	// db용 변수
	private int start = 1;
	private int end = 6;
	
	private int check;


	
}
