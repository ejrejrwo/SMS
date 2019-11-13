package com.boot.finalpro.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.boot.finalpro.admin.model.NoticeDTO;
import com.boot.finalpro.admin.util.LocationStadiumDto;
import com.boot.finalpro.admin.util.SearchUtillDto;
import com.boot.finalpro.admin.util.SearchUtill_ExchangeDto;
import com.boot.finalpro.admin.util.SportsScoreDto;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.mypage.model.ExchangeDTO;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;

public interface AdminService {

	public void writeNotice (NoticeDTO dto,List<MultipartFile>fileList)throws Exception;
	
	public void deleteNotice(int seq);
	
	public void notice_file_del(int seq);
	
	public int notice_file_account(int seq);
	
	public void notice_update(NoticeDTO dto,List<MultipartFile>fileList)throws Exception;
	
	//회원 관리
	public int memberTotalCount(SearchUtillDto dto);	// 멤버 카운트 가져오기
	
	public List<MemberDTO> getMemberList(SearchUtillDto dto);	// 멤버 리스트 가져오기
	
	public MemberDTO memberDetail(String id);	// 회원 디테일
	
	public void deleteMember(String ids[]);	//회원 삭제
	
	public int exchangeListCount(SearchUtill_ExchangeDto dto);	// 환전 리스트 카운트
	
	public List<ExchangeDTO> exchangeList(SearchUtill_ExchangeDto dto);	// 환전 리스트 가져오기
	
	public ExchangeDTO exchangeDetail(int seq);	// 환전내역 상세보기
	
	public void exchangeUpdate(int seq);
	//관리자 메인용
	
	public int dailyProfitMoney();	// 오늘의 소득;
	
	public int monthlyProfitMoney(String ym); // 월별 소득
	
	public List<Integer> yearProfitMoney(String month[]); // 연도별 수입
	
	public List<Integer> yearSpendMoney(String month[]); // 연도별 지출
	
	public Map<String, Integer> getGameCategoryCount(String category[]); // 종목별 카운트 갯수
	
	public List<GameDTO> recentlyGame(); // 경기개시 임박이 가장 가까운 10경기 선발
	
	public List<ExchangeDTO> dontExchangeTop10(); // 환전신청(미환전상태) 마지막것부터 10개리스트
	
	public Map<String, List<TeamDetailDTO>> mmrRanking();	// 메인화면 mmr 랭킹
	
	//경기 일정
	public int gameListCount(SearchUtillDto dto); // 경기 리스트 카운트
	
	public List<GameDTO> gameList(SearchUtillDto dto); // 경기 리스트 가져오기
	
	public GameDTO gameDetail(int game_seq);	// 경기 일정 디테일
	
	//통계용
	public Map<String, List<Integer>> monthly_day(String month_day[]); //월별 일간 수입,지출통계
	
	public Map<String,List<Integer>> monthlyFavoriteSports(GameDTO dto);// 월별 선호 종목 통계
	
	public Map<String, SportsScoreDto> sportsScore(); //종목별 점수 통계
	
	public Map<String, List<GameDTO>> monthlyStadiumCount(LocationStadiumDto dto); //월별 경기장 이용현황

	//public List<GameDTO> locationStadiumCount(String location);	// 지역별 경기장 이용현왕
}

