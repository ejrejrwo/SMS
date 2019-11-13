package com.boot.finalpro.teambbs.model;

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
public class SubDTO {

	private int seq;
	private String id;
	private String team_name;
	private String title;
	private String game_info;
	private String content;
	private String subject_category;
	private String wdate;
	
}
