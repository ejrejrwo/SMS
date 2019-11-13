package com.boot.finalpro.game.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.boot.finalpro.game.dao.GameDAO;
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

@Repository
public class GameDAOImpl implements GameDAO{

	@Autowired
	SqlSession sqlSession;
	
	String ns = "Game.";

	@Override
	public int getprice(StadiumDTO stadium) {		
		return sqlSession.selectOne(ns + "getprice", stadium);
	}

	@Override
	public boolean writeGame(GameDTO game) {
		int n = sqlSession.insert(ns + "writeGame", game);
		return n>0?true:false;
	}

	@Override
	public boolean bookGame(BookingDTO book) {
		int n = sqlSession.insert(ns + "bookGame", book);
		return n>0?true:false;
	}

	@Override
	public List<Integer> getTime(BookingDTO book) {
		return sqlSession.selectList(ns + "getTime", book);
	
	}

	@Override
	public List<GameDTO> getGamelist(GameParam gp) {
		return sqlSession.selectList(ns + "getGamelist", gp);
	}

	@Override
	public int getGameCount(GameParam gp) {
		
		//System.out.println("게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임게임");
		return sqlSession.selectOne(ns + "getGameCount", gp);
	}

	@Override
	public boolean reqGame(GameMatchDTO gm) {
		int n = sqlSession.insert(ns + "reqGame", gm);
		return n>0?true:false;
	}

	@Override
	public GameDTO updateGame(int seq_game) {
		return sqlSession.selectOne(ns + "updateGame", seq_game);
	}

	@Override
	public List<BookingDTO> updateBooking(int seq_game) {
		return sqlSession.selectList(ns + "updateBooking", seq_game);
	}

	@Override
	public boolean deleteGame(int seq_game) {
		int n = sqlSession.update(ns + "deleteGame", seq_game);
		return n>0?true:false;
	}

	@Override
	public boolean deleteBooking(int seq_game) {
		int n = sqlSession.delete(ns + "deleteBooking", seq_game);
		return n>0?true:false;
	}

	@Override
	public void readCount(int seq_game) {
		sqlSession.update(ns + "readCount", seq_game);
	}

	@Override
	public MemberDTO getMember(String id) {
		return sqlSession.selectOne(ns + "getMember", id);
	}

	@Override
	public void payMoney(MemberDTO mem) {
		sqlSession.update(ns + "payMoney", mem);
		
	}

	@Override
	public BookingDTO backMoney(int seq_game) {
		return sqlSession.selectOne(ns + "backMoney", seq_game);
	}

	@Override
	public boolean refund(MemberDTO mem) {
		int n = sqlSession.update(ns + "refund", mem);
		return n>0?true:false;
	}

	@Override
	public List<GameMatchDTO> subGame(int seq_game) {
		return sqlSession.selectList(ns + "subGame", seq_game);
	}

	@Override
	public List<StadiumDTO> getStadium(GameBean gb) {
		return sqlSession.selectList(ns + "getStadium", gb);
	}

	@Override
	public List<BookingDTO> getBookStadium(String name_stadium) {
		return sqlSession.selectList(ns + "getBookStadium", name_stadium);
	}

	@Override
	public List<BookBean> getBookList(BookingDTO book) {
		return sqlSession.selectList(ns + "getBookList", book);
	}

	@Override
	public AuthoritiesDTO getAuth(String id) {
		return sqlSession.selectOne(ns + "getAuth", id);
	}


	
	
}
