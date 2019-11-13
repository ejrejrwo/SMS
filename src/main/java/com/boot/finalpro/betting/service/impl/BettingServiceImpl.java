package com.boot.finalpro.betting.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.finalpro.betting.dao.BettingDAO;
import com.boot.finalpro.betting.model.BettingDTO;
import com.boot.finalpro.betting.model.MMRRankingDTO;
import com.boot.finalpro.betting.service.BettingService;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.model.GameParams;
import com.boot.finalpro.member.model.MemberDTO;

@Service
public class BettingServiceImpl implements BettingService {

	@Autowired
	BettingDAO bettingDAO;
	
	// 여기서 편집
	public List<GameDTO> getBettingAllList(GameParams gparam, String id){
		
		// 모든 베팅 목록을 가져온다
		List<GameDTO> list = bettingDAO.getBettingList(gparam);
		
		// 베팅 가능한지를 정리해서 넘겨줄 리스트
		List<GameDTO> blist = new ArrayList<GameDTO>();
		
		for (GameDTO game : list) {
			int seq_game = game.getSeq_game();
			
			int num = bettingDAO.isBet(new BettingDTO(seq_game, id));
			if(num >= 1) {	// 베팅을 한 경우
				game.setBet(true);
			}
			else {	// 베팅을 하지 않은 경우
				game.setBet(false);
			}
			
			int check = bettingDAO.betTeamCheck(new GameDTO(game.getName_team1(), game.getName_team2(), id));
			
			if(check >= 1) {	// 로그인한 사람이 경기하는 팀에 속해있음
				game.setTeamcheck(true);
			}
			else {	// 로그인한 사람이 경기하는 팀에 속하지 않음
				game.setTeamcheck(false);
			}
			
			blist.add(game);
		}
		return blist;		
	}
	
	@Override
	public List<GameDTO> getBettingList(GameParams gparam) {
		return bettingDAO.getBettingList(gparam);
	}

	@Override
	public int getBettingCount(GameParams gparam) {
		return bettingDAO.getBettingCount(gparam);
	}

	@Override
	public int isBet(BettingDTO bdto) {
		return bettingDAO.isBet(bdto);
	}

	@Override
	public GameDTO getBetting(GameDTO game) {
		return bettingDAO.getBetting(game);
	}

	@Override
	public int getMMR1(GameDTO game) {
		return bettingDAO.getMMR1(game);
	}

	@Override
	public int getMMR2(GameDTO game) {
		return bettingDAO.getMMR2(game);
	}

	@Override
	public String getTeamFile1(GameDTO game) {
		return bettingDAO.getTeamFile1(game);
	}

	@Override
	public String getTeamFile2(GameDTO game) {
		return bettingDAO.getTeamFile2(game);
	}
	
	@Override
	public int getBettingMoney1(GameDTO game) {
		return bettingDAO.getBettingMoney1(game);
	}

	@Override
	public int getBettingMoney2(GameDTO game) {
		return bettingDAO.getBettingMoney2(game);
	}

	@Override
	public int getMoney(String id) {
		return bettingDAO.getMoney(id);
	}

	@Override
	public int betTeamCheck(GameDTO game) {
		return bettingDAO.betTeamCheck(game);
	}
	
	@Override
	public String getPassword(String pwd) {
		return bettingDAO.getPassword(pwd);
	}

	@Override
	public void betting(BettingDTO bdto) {
		bettingDAO.betting(bdto);
	}

	@Override
	public void subtractMoney(BettingDTO bdto) {
		bettingDAO.subtractMoney(bdto);
	}

	@Override
	public List<GameDTO> getGameResultList(GameParams gparam) {
		return bettingDAO.getGameResultList(gparam);
	}

	@Override
	public int getGameResultCount(GameParams gparam) {
		return bettingDAO.getGameResultCount(gparam);
	}

	@Override
	public List<GameDTO> getResultAdminList(GameParams gparam) {
		return bettingDAO.getResultAdminList(gparam);
	}

	@Override
	public int getResultAdminCount(GameParams gparam) {
		return bettingDAO.getResultAdminCount(gparam);
	}

	@Override
	public void resultAdmin(GameDTO game) {
		bettingDAO.resultAdmin(game);
	}
	
	// 여기서 편집
	public void payBetting(GameDTO game) {
		// betting 성공한 유저 id List 가져오기
		List<String> list = bettingDAO.getPayId(game);
		
		for (int i = 0; i < list.size(); i++) {
			String id = list.get(i);
			
			game.setId(id);
			
			// betting 성공한 유저에게 bettingMoney 지급
			bettingDAO.payBettingMoney(game);
		}
		
		// Admin에게 5% 지급
		bettingDAO.payAdminMoney(game);
		
	}
	
	@Override
	public List<String> getPayId(GameDTO game) {
		return bettingDAO.getPayId(game);
	}

	@Override
	public void payBettingMoney(GameDTO game) {
		bettingDAO.payBettingMoney(game);
	}

	@Override
	public void payAdminMoney(GameDTO game) {
		bettingDAO.payAdminMoney(game);
	}

	public void changeMMR(GameDTO game) {
		bettingDAO.changeMMR1(game);
		bettingDAO.changeMMR2(game);
	}

	@Override
	public void changeMMR1(GameDTO game) {
		bettingDAO.changeMMR1(game);
	}

	@Override
	public void changeMMR2(GameDTO game) {
		bettingDAO.changeMMR2(game);
	}
	
	// 경기 취소시 베팅한 금액 환불
	public void refundBetting(BettingDTO bet) {
		// betting한 유저 id List 가져오기
		List<BettingDTO> blist = bettingDAO.getBetInfo(bet);
		
		for (int i = 0; i < blist.size(); i++) {
			BettingDTO bdto = blist.get(i);
			System.out.println("BettingDTO:" + bdto.toString());
			bettingDAO.refundBet(bdto);
			bettingDAO.deleteBet(bdto);
		}
		
	}

	@Override
	public List<BettingDTO> getBetInfo(BettingDTO bet) {
		return bettingDAO.getBetInfo(bet);
	}

	@Override
	public void refundBet(BettingDTO bet) {
		bettingDAO.refundBet(bet);
	}

	@Override
	public void deleteBet(BettingDTO bet) {
		bettingDAO.deleteBet(bet);
	}

	@Override
	public String getLeader(String team_name) {
		return bettingDAO.getLeader(team_name);
	}

	@Override
	public List<MMRRankingDTO> getSoccerRank(MMRRankingDTO mdto) {
		return bettingDAO.getSoccerRank(mdto);
	}

	@Override
	public List<MMRRankingDTO> getBasketballRank(MMRRankingDTO mdto) {
		return bettingDAO.getBasketballRank(mdto);
	}

	@Override
	public List<MMRRankingDTO> getBaseballRank(MMRRankingDTO mdto) {
		return bettingDAO.getBaseballRank(mdto);
	}

	@Override
	public List<MMRRankingDTO> getBadmintonRank(MMRRankingDTO mdto) {
		return bettingDAO.getBadmintonRank(mdto);
	}

	@Override
	public List<MMRRankingDTO> getPingpongRank(MMRRankingDTO mdto) {
		return bettingDAO.getPingpongRank(mdto);
	}

	@Override
	public int getRankCount(MMRRankingDTO mdto) {
		return bettingDAO.getRankCount(mdto);
	}
	
	@Override
	public List<MMRRankingDTO> getAllRank(MMRRankingDTO mdto) {
		return bettingDAO.getAllRank(mdto);
	}
		
	
}
