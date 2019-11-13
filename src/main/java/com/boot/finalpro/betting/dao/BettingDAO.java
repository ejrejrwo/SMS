package com.boot.finalpro.betting.dao;

import java.util.List;

import com.boot.finalpro.betting.model.BettingDTO;
import com.boot.finalpro.betting.model.MMRRankingDTO;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.model.GameParams;


public interface BettingDAO {
	
	// 검색 결과를 포함한 경기 일정 List 가져오기
	public List<GameDTO> getBettingList(GameParams gparam);
	
	// 검색 결과를 포함한 총 경기 일정 글의 갯수
	public int getBettingCount(GameParams gparam);
	
	// 베팅 했는지 여부
	public int isBet(BettingDTO bdto);
	
	// 경기 상세 페이지
	public GameDTO getBetting(GameDTO game);
	
	// team1 MMR
	public int getMMR1(GameDTO game);
	
	// team2 MMR
	public int getMMR2(GameDTO game);
	
	// team1 File(로고)
	public String getTeamFile1(GameDTO game);
	
	// team2 File(로고)
	public String getTeamFile2(GameDTO game);
	
	// team1 betting point
	public int getBettingMoney1(GameDTO game);
	
	// team2 betting point
	public int getBettingMoney2(GameDTO game);
	
	// 머니 가져오기
	public int getMoney(String id);
	
	// 로그인한 사람이 경기하는 팀에 속해있는지 확인
	public int betTeamCheck(GameDTO game);
	
	// 베팅시 비밀번호 확인하기
	public String getPassword(String pwd);
	
	// 베팅하기
	public void betting(BettingDTO bdto);
	
	// 베팅한 머니 차감
	public void subtractMoney(BettingDTO bdto);
	
	// 검색 결과를 포함한 경기 결과 List 가져오기
	public List<GameDTO> getGameResultList(GameParams gparam);
	
	// 검색 결과를 포함한 총 경기 결과 글의 갯수
	public int getGameResultCount(GameParams gparam);
	
	// 검색 결과를 포함한 경기 결과 Admin List 가져오기
	public List<GameDTO> getResultAdminList(GameParams gparam);
	
	// 검색 결과를 포함한 총 경기 결과 Admin 글의 갯수
	public int getResultAdminCount(GameParams gparam);
	
	// 관리자가 경기 결과 입력
	public void resultAdmin(GameDTO game);
	
	// betting 성공한 유저 id List 가져오기
	public List<String> getPayId(GameDTO game);
	
	// betting 성공한 유저에게 money 지급하기 -> 5% 차감, 10단위 버림
	public void payBettingMoney(GameDTO game);
	
	// 5% Admin 계정에 넣기
	public void payAdminMoney(GameDTO game);
	
	// 각 팀의 승률을 반영하여 MMR 조정
	public void changeMMR1(GameDTO game);
	public void changeMMR2(GameDTO game);
	
	// 경기 취소시 베팅한 금액 환불
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
	
	public int getRankCount(MMRRankingDTO mdto);
	
	public List<MMRRankingDTO> getAllRank(MMRRankingDTO mdto);
	
	
	
}
