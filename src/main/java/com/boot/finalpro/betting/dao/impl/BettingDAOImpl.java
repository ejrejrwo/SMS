package com.boot.finalpro.betting.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.boot.finalpro.betting.dao.BettingDAO;
import com.boot.finalpro.betting.model.BettingDTO;
import com.boot.finalpro.betting.model.MMRRankingDTO;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.model.GameParams;
import com.boot.finalpro.member.model.MemberDTO;

@Repository
public class BettingDAOImpl implements BettingDAO {

	@Autowired
	SqlSession sqlSession;
	
	String ns = "Betting.";


	@Override
	public List<GameDTO> getBettingList(GameParams gparam) {
		return sqlSession.selectList(ns + "getBettingList", gparam);
	}

	@Override
	public int getBettingCount(GameParams gparam) {
		return sqlSession.selectOne(ns + "getBettingCount", gparam);
	}
	
	@Override
	public int isBet(BettingDTO bdto) {
		return sqlSession.selectOne(ns + "isBet", bdto);
	}

	@Override
	public GameDTO getBetting(GameDTO game) {
		return sqlSession.selectOne(ns + "getBetting", game);
	}

	@Override
	public int getMMR1(GameDTO game) {
		return sqlSession.selectOne(ns + "getMMR1", game);
	}

	@Override
	public int getMMR2(GameDTO game) {
		return sqlSession.selectOne(ns + "getMMR2", game);
	}

	@Override
	public String getTeamFile1(GameDTO game) {
		return sqlSession.selectOne(ns + "getTeamFile1", game);
	}

	@Override
	public String getTeamFile2(GameDTO game) {
		return sqlSession.selectOne(ns + "getTeamFile2", game);
	}

	@Override
	public int getBettingMoney1(GameDTO game) {
		return sqlSession.selectOne(ns + "getBettingMoney1", game);
	}

	@Override
	public int getBettingMoney2(GameDTO game) {
		return sqlSession.selectOne(ns + "getBettingMoney2", game);
	}

	@Override
	public int getMoney(String id) {
		return sqlSession.selectOne(ns + "getMoney", id);
	}
	
	@Override
	public int betTeamCheck(GameDTO game) {
		return sqlSession.selectOne(ns + "betTeamCheck", game);
	}

	@Override
	public String getPassword(String pwd) {
		return sqlSession.selectOne(ns + "getPassword", pwd);
	}

	@Override
	public void betting(BettingDTO bdto) {
		sqlSession.insert(ns + "betting", bdto);
	}

	@Override
	public void subtractMoney(BettingDTO bdto) {
		sqlSession.update(ns + "subtractMoney", bdto);
	}

	@Override
	public List<GameDTO> getGameResultList(GameParams gparam) {
		return sqlSession.selectList(ns + "getGameResultList", gparam);
	}

	@Override
	public int getGameResultCount(GameParams gparam) {
		return sqlSession.selectOne(ns + "getGameResultCount", gparam);
	}

	@Override
	public List<GameDTO> getResultAdminList(GameParams gparam) {
		return sqlSession.selectList(ns + "getResultAdminList", gparam);
	}

	@Override
	public int getResultAdminCount(GameParams gparam) {
		return sqlSession.selectOne(ns + "getResultAdminCount", gparam);
	}

	@Override
	public void resultAdmin(GameDTO game) {
		sqlSession.update(ns + "resultAdmin", game);
	}

	@Override
	public List<String> getPayId(GameDTO game) {
		return sqlSession.selectList(ns + "getPayId", game);
	}

	@Override
	public void payBettingMoney(GameDTO game) {
		sqlSession.update(ns + "payBettingMoney", game);
	}

	@Override
	public void payAdminMoney(GameDTO game) {
		sqlSession.update(ns + "payAdminMoney", game);
	}

	@Override
	public void changeMMR1(GameDTO game) {
		sqlSession.update(ns + "changeMMR1", game);
	}

	@Override
	public void changeMMR2(GameDTO game) {
		sqlSession.update(ns + "changeMMR2", game);
	}

	@Override
	public List<BettingDTO> getBetInfo(BettingDTO bet) {
		return sqlSession.selectList(ns + "getBetInfo", bet);
	}

	@Override
	public void refundBet(BettingDTO bet) {
		sqlSession.update(ns + "refundBet", bet);
	}

	@Override
	public void deleteBet(BettingDTO bet) {
		sqlSession.delete(ns + "deleteBet", bet);
	}

	@Override
	public String getLeader(String team_name) {
		return sqlSession.selectOne(ns + "getLeader", team_name);
	}

	@Override
	public List<MMRRankingDTO> getSoccerRank(MMRRankingDTO mdto) {
		return sqlSession.selectList(ns + "getSoccerRank", mdto);
	}

	@Override
	public List<MMRRankingDTO> getBasketballRank(MMRRankingDTO mdto) {
		return sqlSession.selectList(ns + "getBasketballRank", mdto);
	}

	@Override
	public List<MMRRankingDTO> getBaseballRank(MMRRankingDTO mdto) {
		return sqlSession.selectList(ns + "getBaseballRank", mdto);
	}

	@Override
	public List<MMRRankingDTO> getBadmintonRank(MMRRankingDTO mdto) {
		return sqlSession.selectList(ns + "getBadmintonRank", mdto);
	}

	@Override
	public List<MMRRankingDTO> getPingpongRank(MMRRankingDTO mdto) {
		return sqlSession.selectList(ns + "getPingpongRank", mdto);
	}

	@Override
	public int getRankCount(MMRRankingDTO mdto) {
		return sqlSession.selectOne(ns + "getRankCount", mdto);
	}
	
	@Override
	public List<MMRRankingDTO> getAllRank(MMRRankingDTO mdto) {
		return sqlSession.selectList(ns + "getAllRank", mdto);
	}
		
	
}
