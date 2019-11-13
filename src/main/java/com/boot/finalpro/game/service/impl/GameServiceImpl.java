package com.boot.finalpro.game.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.finalpro.game.dao.GameDAO;
import com.boot.finalpro.game.model.BookBean;
import com.boot.finalpro.game.model.BookingDTO;
import com.boot.finalpro.game.model.GameBean;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.model.GameMatchDTO;
import com.boot.finalpro.game.model.GameParam;
import com.boot.finalpro.game.model.StadiumDTO;
import com.boot.finalpro.game.service.GameService;
import com.boot.finalpro.member.model.AuthoritiesDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.video.model.VideoCommentDTO;
import com.boot.finalpro.video.model.VideoDTO;

@Service
public class GameServiceImpl implements GameService {

	@Autowired
	GameDAO gameDAO;

	@Override
	public int getprice(StadiumDTO stadium) {
		return gameDAO.getprice(stadium);
	}

	@Override
	public boolean writeGame(GameDTO game) {
		return gameDAO.writeGame(game);
	}

	@Override
	public boolean bookGame(BookingDTO book) {
		return gameDAO.bookGame(book);
	}

	@Override
	public List<Integer> getTime(BookingDTO book) {
		return gameDAO.getTime(book);
	}

	@Override
	public List<GameDTO> getGamelist(GameParam gp) {
		return gameDAO.getGamelist(gp);
	}

	@Override
	public int getGameCount(GameParam gp) {
		return gameDAO.getGameCount(gp);
	}

	@Override
	public boolean reqGame(GameMatchDTO gm) {
		return gameDAO.reqGame(gm);
	}

	@Override
	public GameDTO updateGame(int seq_game) {
		return gameDAO.updateGame(seq_game);
	}

	@Override
	public List<BookingDTO> updateBooking(int seq_game) {
		return gameDAO.updateBooking(seq_game);
	}

	@Override
	public boolean deleteGame(int seq_game) {
		return gameDAO.deleteGame(seq_game);
	}

	@Override
	public boolean deleteBooking(int seq_game) {
		return gameDAO.deleteBooking(seq_game);
	}

	@Override
	public void readCount(int seq_game) {
		gameDAO.readCount(seq_game);		
	}

	@Override
	public MemberDTO getMember(String id) {
		return gameDAO.getMember(id);
	}

	@Override
	public void payMoney(MemberDTO mem) {
		gameDAO.payMoney(mem);
	}

	@Override
	public BookingDTO backMoney(int seq_game) {
		return gameDAO.backMoney(seq_game);
	}

	@Override
	public boolean refund(MemberDTO mem) {
		return gameDAO.refund(mem);
	}

	@Override
	public List<GameMatchDTO> subGame(int seq_game) {
		return gameDAO.subGame(seq_game);
	}

	@Override
	public List<StadiumDTO> getStadium(GameBean gb) {
		return gameDAO.getStadium(gb);
	}

	@Override
	public List<BookingDTO> getBookStadium(String name_stadium) {
		return gameDAO.getBookStadium(name_stadium);
	}

	@Override
	public List<BookBean> getBookList(BookingDTO book) {
		return gameDAO.getBookList(book);
	}

	@Override
	public AuthoritiesDTO getAuth(String id) {
		return gameDAO.getAuth(id);
	}


	
	
}
