package com.boot.finalpro.betting.service;

import java.util.List;

import com.boot.finalpro.betting.model.BettingDTO;
import com.boot.finalpro.betting.model.MMRRankingDTO;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.model.GameParams;
import com.boot.finalpro.member.model.MemberDTO;


public interface BettingService {
	
	// Service에서 편집
	public List<GameDTO> getBettingAllList(GameParams gparam, String id);
	
	public List<GameDTO> getBettingList(GameParams gparam);
	
	public int getBettingCount(GameParams gparam);
	
	public int isBet(BettingDTO bdto);
	
	public GameDTO getBetting(GameDTO game);
	
	public int getMMR1(GameDTO game);
	
	public int getMMR2(GameDTO game);
	
	// team1 File(로고)
	public String getTeamFile1(GameDTO game);
	
	// team2 File(로고)
	public String getTeamFile2(GameDTO game);
	
	public int getBettingMoney1(GameDTO game);
	
	public int getBettingMoney2(GameDTO game);
	
	public int getMoney(String id);
	
	public int betTeamCheck(GameDTO game);
		
	public String getPassword(String pwd);
	
	public void betting(BettingDTO bdto);
	
	public void subtractMoney(BettingDTO bdto);
	
	public List<GameDTO> getGameResultList(GameParams gparam);
	
	public int getGameResultCount(GameParams gparam);
	
	// 검색 결과를 포함한 경기 결과 Admin List 가져오기
	public List<GameDTO> getResultAdminList(GameParams gparam);
	
	// 검색 결과를 포함한 총 경기 결과 Admin 글의 갯수
	public int getResultAdminCount(GameParams gparam);

	public void resultAdmin(GameDTO game);
	
	// betting 정산
	public void payBetting(GameDTO game);
	
	// betting 성공한 유저 id List 가져오기
	public List<String> getPayId(GameDTO game);
	
	// betting 성공한 유저에게 money 지급하기 -> 5% 차감, 10단위 버림
	public void payBettingMoney(GameDTO game);
	
	// 5% admin 계정에 넣기
	public void payAdminMoney(GameDTO game);
	
	// 각 팀의 승률을 반영하여 MMR 조정
	public void changeMMR(GameDTO game);
	public void changeMMR1(GameDTO game);
	public void changeMMR2(GameDTO game);
	
	// 경기 취소시 베팅한 금액 환불
	public void refundBetting(BettingDTO bet);
	public List<BettingDTO> getBetInfo(BettingDTO bet);
	public void refundBet(BettingDTO bet);
	public void deleteBet(BettingDTO bet);
	public String getLeader(String team_name);
	
	// MMR RANKING
	public List<MMRRankingDTO> getSoccerRank(MMRRankingDTO mdto);
	public List<MMRRankingDTO> getBasketballRank(MMRRankingDTO mdto);
	public List<MMRRankingDTO> getBaseballRank(MMRRankingDTO mdto);
	public List<MMRRankingDTO> getBadmintonRank(MMRRankingDTO mdto);
	public List<MMRRankingDTO> getPingpongRank(MMRRankingDTO mdto);
	public List<MMRRankingDTO> getAllRank(MMRRankingDTO mdto);
	
	public int getRankCount(MMRRankingDTO mdto);

}
