package com.boot.finalpro.game.service;

import java.util.List;

import com.boot.finalpro.game.model.BookBean;
import com.boot.finalpro.game.model.BookingDTO;
import com.boot.finalpro.game.model.GameBean;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.model.GameMatchDTO;
import com.boot.finalpro.game.model.GameParam;
import com.boot.finalpro.game.model.StadiumDTO;
import com.boot.finalpro.member.model.AuthoritiesDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.video.model.VideoCommentDTO;
import com.boot.finalpro.video.model.VideoDTO;

public interface GameService {
	
	public int getprice(StadiumDTO stadium);
	
	public boolean writeGame(GameDTO game);
	
	public boolean bookGame(BookingDTO book);
	
	public void payMoney(MemberDTO mem);
	
	public BookingDTO backMoney(int seq_game);
	
	public List<Integer> getTime(BookingDTO book);
	
	public List<GameDTO> getGamelist(GameParam gp);
	
	public int getGameCount(GameParam gp);
	
	public boolean reqGame(GameMatchDTO gm);
	
	public GameDTO updateGame(int seq_game);
	
	public List<BookingDTO> updateBooking(int seq_game);
	
	public boolean deleteGame(int seq_game);
	
	public boolean refund(MemberDTO mem);
	
	public boolean deleteBooking(int seq_game);
	
	public void readCount(int seq_game);
	
	public MemberDTO getMember(String id);
	
	public AuthoritiesDTO getAuth(String id);
	
	public List<BookingDTO> getBookStadium(String name_stadium);
	
	public List<GameMatchDTO> subGame(int seq_game);
	
	public List<StadiumDTO> getStadium(GameBean gb);
	
	public List<BookBean> getBookList(BookingDTO book);
	
	
}
