package com.boot.finalpro.mypage.util;

import lombok.Setter;
import lombok.ToString;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class MyBetParam {

	private String category;		// 종목
	private String name_team1;		// 팀1
	private String name_team2;		// 팀2
	private String gdate;			// 게임 일
	private double payout_r1;		// 1팀 배당율
	private double payout_r2;		// 2팀 배당율
	private String game_result;		// 경기 승리팀
	
	private String team_name;		// 배팅 팀
	private String betting_money;	// 배팅한 금액
	
}
