package com.boot.finalpro.league.model;

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
public class LeagueMatchDTO {

	private int seq;
	private String team_name;
	private String leader_id;

}
