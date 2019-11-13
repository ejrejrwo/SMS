package com.boot.finalpro.game.model;

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
public class BookingSubDTO {

	private int seq_booksub;
	private int seq_book;
	private int book_time;
}
