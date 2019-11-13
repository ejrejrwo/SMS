package com.boot.finalpro.league.dao;

import java.util.List;

import com.boot.finalpro.game.model.BookingDTO;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.league.model.LeagueMatchDTO;
import com.boot.finalpro.league.model.NoChatDTO;
import com.boot.finalpro.member.model.AuthoritiesDTO;
import com.boot.finalpro.mypage.model.MessageDTO;
import com.boot.finalpro.team.model.TeamDTO;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;

public interface LeagueMatchDAO {
	
	//현재리그를 가져오는 메소드
	public List<GameDTO> nowdata();
	
	//예전리그를 가져오는 메소드
	public List<GameDTO> olddata(String yyyymm);
	
	//랭커들 가져오는 메소드
	public List<TeamDetailDTO> Ranksearch(String category);
	
	//리그참가팀들(수락한 팀들) 가져오는 메소드
	public List<LeagueMatchDTO> acceptlist();
	
	//메세지 보내는 메소드
	public boolean messagesend(MessageDTO dto);
	
	//8강전만 등록하는 메소드
	public boolean write8league(GameDTO dto);
	
	//4강 결승 등록하는 메소드
	public boolean writeleague(GameDTO dto);
	
	//경기장 예약하는 메소드
	public boolean writebooking(BookingDTO dto);
	
	//현재 진행중인 리그가 있는지 없는지 체크하는 메소드
	public int leaguecheck();
	
	//리그추가가 완료되면 리그참가수락팀리스트 삭제하기
	public boolean LeagueMatchDelete();
	
	//리그 신청을 했는지 알아보기
	public int LeagueMatchSearch(String id);
	
	//리그신청하기
	public boolean LeagueMatchWrite(LeagueMatchDTO dto);
	
	//팀정보 가져오기
	public TeamDTO TeamSearch(String id);
	
	//게임데이터 가져오기
	public GameDTO GameSearch(String league);
	
	//리그결과에따라 업데이트하기
	public boolean leagueUpdate1(GameDTO dto);
	public boolean leagueUpdate2(GameDTO dto);
	
	//리그가 끝났을때
	public boolean leagueEnd(String yyyymm);
	
	//팀장권한인지 체크 하기 위해 권한가져오기
	public AuthoritiesDTO AuthSearch(String id);
	
	//리그신청 취소하기
	public boolean LeagueMatchCancel(String id);
	
	//팀채팅방들어가기전 팀에 소속되어있는지 체크
	public TeamDTO ChatTeamCheck(String id);
	
	//채팅금지인지 검색하기
	public NoChatDTO NoChatSearch(String id);
	
	//처음채팅금지 입력
	public boolean NoChatWrite(NoChatDTO dto);
	
	//2번이상 채팅금지 입력
	public boolean NoChatUpdate(NoChatDTO dto);
	
	//채팅금지 풀기
	public boolean NoChatEnd(NoChatDTO dto);
	
}
