package com.boot.finalpro.teambbs.model;

import java.io.Serializable;
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
public class TeamDetailDTO implements Serializable{
	
	private String team_name;
	private String leader;
	private String title;
	private String content;
	private int like_count;
	private int deadline;
	private int soccer_mmr;
	private int basketball_mmr;
	private int baseball_mmr;
	private int badminton_mmr;
	private int pingpong_mmr;
	private int report_count;
	private Date fdate;
//	private String fdate;
	private String sport_category;
	private String file_name;
	
	private int total_mmr;
	
}
