package com.boot.finalpro.team.model;

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
public class TeamApplicationDTO {

	private int seq;
	private String id;
	private String team_name;
	private String content;
	
}
