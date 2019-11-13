package com.boot.finalpro.greeting.util;

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
public class Chat {
	
	private String team;
	private String name;
	private String message;
	
	
	public Chat(String name, String message) {
		super();
		this.name = name;
		this.message = message;
	}
	
	

}
