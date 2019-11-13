package com.boot.finalpro.betting.model;

import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class BettingDTO {

	private int seq_bet;
	private int seq_game;
	private String id;
	private String team_name;
	private String betting_money;
	private Date rdate;
//	private String rdate;

	public BettingDTO(int seq_game, String id) {
		super();
		this.seq_game = seq_game;
		this.id = id;
	}	
	
}
