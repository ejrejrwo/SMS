package com.boot.finalpro.league.service;

import java.util.List;

import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.league.model.LeagueMatchDTO;
import com.boot.finalpro.league.model.NoChatDTO;
import com.boot.finalpro.league.util.LeagueParamDTO;
import com.boot.finalpro.member.model.AuthoritiesDTO;
import com.boot.finalpro.mypage.model.MessageDTO;
import com.boot.finalpro.team.model.TeamDTO;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;

public interface LeagueMatchService {
	
	//리그데이터를 가져오는 서비스
	public List<GameDTO> leaguedata(String year, String month);
	
	//랭커들 가져오는 서비스
	public List<TeamDetailDTO> Ranksearch(String category);
	
	//리그수락한 팀들 가져오는 서비스
	public List<LeagueMatchDTO> acceptlist();
	
	//메세지 보내는 서비스
	public boolean messagesend(MessageDTO dto);
	
	//8강부터 결승까지 리그 추가하는 서비스
	public boolean addleague(LeagueParamDTO dto);
	
	//현재 진행중인 리그가 있는지 체크하는 서비스
	public int leaguecheck();
	
	//리그 신청을 했는지 알아보기
	public int LeagueMatchSearch(String id);
	
	//리그신청하기
	public boolean LeagueMatchWrite(String id);
	
	//리그결과(게임결과)에 따라 후속처리해주기
	public boolean LeagueResult(GameDTO dto);
	
	//팀장권한인지 체크하기
	public AuthoritiesDTO AuthSearch(String id);
	
	//리그신청 취소하기
	public boolean LeagueMatchCancel(String id);
	
	//팀채팅방들어가기전 팀에 소속되어있는지 체크
	public TeamDTO ChatTeamCheck(String id);
	
	//채팅금지인지 검색하기
	public NoChatDTO NoChatSearch(String id);
	
	//채팅금지 시작
	public boolean NoChatStart(NoChatDTO dto);
	
	//채팅금지 풀기
	public boolean NoChatEnd(NoChatDTO dto);

}
