package com.boot.finalpro.teambbs.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class RecruitTeamDTO {

	private int seq;
	private String id;
	private String team_name;
	private String title;
	private String content;
	private Date wdate;
//	private String wdate;
	private int parent;
	private int del;
	private int read_count;
	private String sport_category;

}
