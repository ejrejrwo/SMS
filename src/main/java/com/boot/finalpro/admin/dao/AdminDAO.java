package com.boot.finalpro.admin.dao;

import java.util.List;
import java.util.Map;

import com.boot.finalpro.admin.model.NoticeDTO;
import com.boot.finalpro.admin.model.NoticeSubDTO;
import com.boot.finalpro.admin.util.LocationStadiumDto;
import com.boot.finalpro.admin.util.SearchUtillDto;
import com.boot.finalpro.admin.util.SearchUtill_ExchangeDto;
import com.boot.finalpro.admin.util.SportsScoreDto;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.mypage.model.ExchangeDTO;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;

public interface AdminDAO {

	public void writeNotice(NoticeDTO dto);
	
	public void noticeFile(NoticeSubDTO dto);
	
	public void deleteNotice(int seq);	//글삭제
	
	public void deleteNoticeFile(int seq);	//글 seq에 따른 모든 uploadfile 삭제
	
	public void notice_file_del(int seq);	// 특정 uploadfile 삭제
	
	public int notice_file_account(int seq);	// 파일 갯수 찾기
	
	public void notice_update(NoticeDTO dto);	// 공지사항 업데이트
	
	public void notice_File_update(NoticeSubDTO dto);
	
	public List<GameDTO> monthlyGame(String ym);
	
	public List<GameDTO> dailyGame(String ymd);
	
	public int memberTotalCount(SearchUtillDto dto);	// 멤버 카운트 가져오기
	
	public List<MemberDTO> getMemberList(SearchUtillDto dto);	// 멤버 리스트 가져오기
	
	public void deleteMember(String id);	//회원 삭제
	
	public MemberDTO memberDetail(String id);	// 회원 디테일	
	
	public int dailyProfitMoney(); // 하루동안 수입
	
	public int dailySpendMoney(); // 하루동안 지출
	
	public int monthlyProfitMoney(String ym); // 월별 수입
	
	public int monthlySpendMoney(String ym); // 월별 지출	
	
	public List<Integer> yearProfitMoney(String month[]); // 연도별 수입
	
	public List<Integer> yearSpendMoney(String month[]); // 연도별 지출
	
	public Map<String, Integer> getGameCategoryCount(String category[]); // 종목별 카운트 갯수
	
	public List<GameDTO> recentlyGame(); // 경기개시 임박이 가장 가까운 10경기 선발
	
	public List<ExchangeDTO> dontExchangeTop10(); // 환전신청(미환전상태) 마지막것부터 10개리스트
	
	public int exchangeListCount(SearchUtill_ExchangeDto dto);	// 환전 리스트 카운트
	
	public List<ExchangeDTO> exchangeList(SearchUtill_ExchangeDto dto);	// 환전 리스트 가져오기
	
	public ExchangeDTO exchangeDetail(int seq);	// 환전내역 상세보기
	
	public void exchageUpdate(int seq);	// 환전체크 업데이트
	
	public void spendUpdate(int seq);	// spend 업데이트
	
	public int gameListCount(SearchUtillDto dto);	// 경기 일정 리스트 카운트
	
	public List<GameDTO> gameList(SearchUtillDto dto); //모든 경기 일정 리스트
	
	public GameDTO gameDetail(int game_seq);	// 경기 일정 디테일
	
	public List<Integer> monthlyDayProfit(String month_day[]); // 월간 일별 수입 통계
	
	public List<Integer> monthlyDaySpend(String month_day[]); // 월간 일별 지출 통계
	
	public List<Integer> monthlyFavoriteSports(GameDTO dto);	// 월간 선호 종목 통계;
	
	public List<TeamDetailDTO> mainRankFirst();	// admin main mmr1등팀

	public List<TeamDetailDTO> mainRankLast();	// admin main mmr꼴등팀

	public SportsScoreDto sportsScore(String category); // admin chart 종목별 최고점,최저점,평균점
	
	public List<GameDTO> monthlyStadiumCount(LocationStadiumDto dto);	// 월별 경기장 이용현황
	
	public List<GameDTO> locationStadiumCount(LocationStadiumDto dto);	// 지역별 경기장 이용현왕
}
