package com.boot.finalpro.admin.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.boot.finalpro.admin.dao.AdminDAO;
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
@Repository
public class AdminDAOImpl implements AdminDAO {

	@Autowired
	SqlSession sqlSession;
	
	String ns = "Admin.";

	
	@Override
	public void writeNotice(NoticeDTO dto) {
		sqlSession.insert(ns + "noticeWrite", dto);
	}

	@Override
	public void noticeFile(NoticeSubDTO dto) {
		sqlSession.insert(ns + "noticeFile", dto);
		
	}

	@Override
	public void deleteNotice(int seq) {
		sqlSession.delete(ns + "noticeDelete", seq);
	}

	@Override
	public void deleteNoticeFile(int seq) {
		sqlSession.delete(ns + "noticeFileDelete", seq);		
	}

	@Override
	public void notice_file_del(int seq) {
		sqlSession.delete(ns+"notice_file_del",seq);
		
	}

	@Override
	public int notice_file_account(int seq) {
		int account = 0;
		account =  sqlSession.selectOne(ns+"notice_file_account", seq);
		return account;
	}

	@Override
	public void notice_update(NoticeDTO dto) {
		sqlSession.update(ns + "notice_file_update", dto);
	}

	@Override
	public void notice_File_update(NoticeSubDTO dto) {
		sqlSession.insert(ns + "notice_File_update", dto);
		
	}
	
	@Override
	public List<GameDTO> monthlyGame(String ym) {
		List<GameDTO> gDto = new ArrayList<GameDTO>();
		gDto = sqlSession.selectList(ns + "monthlyGame", ym);
		return gDto;
	}
	
	

	@Override
	public List<GameDTO> dailyGame(String ymd) {
		List<GameDTO> gDto = new ArrayList<GameDTO>();
		gDto = sqlSession.selectList(ns + "dailyGame", ymd);
		return gDto;
	}
	
	@Override
	public int memberTotalCount(SearchUtillDto dto) {
		int count = 0;
		count = sqlSession.selectOne(ns + "allMemberCount", dto);
		return count;
	}

	@Override
	public List<MemberDTO> getMemberList(SearchUtillDto dto) {
		List<MemberDTO> memberList = new ArrayList<MemberDTO>();
		memberList = sqlSession.selectList(ns+"memberListGet", dto);
		return memberList;
	}

	@Override
	public MemberDTO memberDetail(String id) {
		MemberDTO mem = new MemberDTO();
		mem = sqlSession.selectOne(ns + "memberDetail", id);
		return mem;
	}

	@Override
	public int dailyProfitMoney() {
		int dailyProfit;
		dailyProfit = sqlSession.selectOne(ns+"dailyProfitMoney");
		return dailyProfit;
	}

	@Override
	public int dailySpendMoney() {
		int dailySpendMoney = 0;
		dailySpendMoney = sqlSession.selectOne(ns+"dailySpendMoney");
		return dailySpendMoney;
	}

	@Override
	public int monthlyProfitMoney(String ym) {
		int monthlyProfitMoney = 0;
		monthlyProfitMoney = sqlSession.selectOne(ns + "monthlyProfitMoney", ym);
		return monthlyProfitMoney;
	}

	@Override
	public int monthlySpendMoney(String ym) {
		int monthlySpendMoney = 0;
		monthlySpendMoney = sqlSession.selectOne(ns + "monthlySpendMoney", ym);
		return monthlySpendMoney;
	}

	@Override
	public List<Integer> yearProfitMoney(String month[]) {
		List<Integer> yearProfit = new ArrayList<Integer>();
		for (int i = 0; i < month.length; i++) {
			yearProfit.add(sqlSession.selectOne(ns + "monthlyProfitMoney", month[i]));
		}
		
		return yearProfit;
	}

	@Override
	public List<Integer> yearSpendMoney(String month[]) {
		List<Integer> yearSpend = new ArrayList<Integer>();
		for (int i = 0; i < month.length; i++) {
			yearSpend.add(sqlSession.selectOne(ns + "monthlySpendMoney", month[i]));
		}
		
		return yearSpend;
	}

	@Override
	public Map<String, Integer> getGameCategoryCount(String[] category) {
		Map<String, Integer> getGameCategoryCount = new HashMap<String, Integer>();
		for (int i = 0; i < category.length; i++) {
			getGameCategoryCount.put(category[i], sqlSession.selectOne(ns + "getGameCategoryCount", category[i]));
		}
		return getGameCategoryCount;
	}

	@Override
	public List<GameDTO> recentlyGame() {
		List<GameDTO> recentlyGame = new ArrayList<GameDTO>();
		recentlyGame = sqlSession.selectList(ns+"recentlyGame");
		return recentlyGame;
	}

	@Override
	public List<ExchangeDTO> dontExchangeTop10() {
		List<ExchangeDTO> dontExchangeTop10 = new ArrayList<ExchangeDTO>();
		dontExchangeTop10 = sqlSession.selectList(ns+"dontExchangeTop10");
		return dontExchangeTop10;
	}

	@Override
	public int exchangeListCount(SearchUtill_ExchangeDto dto) {
		int exchangeListCount = 0;
		exchangeListCount = sqlSession.selectOne(ns + "exchangeListCount", dto);
		return exchangeListCount;
	}

	@Override
	public List<ExchangeDTO> exchangeList(SearchUtill_ExchangeDto dto) {
		List<ExchangeDTO> exchangeList = new ArrayList<ExchangeDTO>();
		exchangeList = sqlSession.selectList(ns+"exchangeList", dto);
		return exchangeList;
	}

	@Override
	public ExchangeDTO exchangeDetail(int seq) {
		ExchangeDTO exchangeDetail =  new ExchangeDTO();
		exchangeDetail =  sqlSession.selectOne(ns + "exchangeDetail", seq);
		return exchangeDetail;
	}

	@Override
	public void exchageUpdate(int seq) {
		sqlSession.update(ns + "exchageUpdate", seq);
	}

	@Override
	public void spendUpdate(int seq) {
		sqlSession.update(ns +"spendUpdate", seq);
	}
	
	@Override
	public int gameListCount(SearchUtillDto dto) {
		int gameListCount = 0;
		gameListCount = sqlSession.selectOne(ns + "gameListCount", dto);
		return gameListCount;
	}

	@Override
	public List<GameDTO> gameList(SearchUtillDto dto) {
		List<GameDTO> gameList = new ArrayList<GameDTO>();
		gameList = sqlSession.selectList(ns+"gameList", dto);
		return gameList;
	}

	@Override
	public GameDTO gameDetail(int game_seq) {
		GameDTO gameDetail = new GameDTO();
		gameDetail = sqlSession.selectOne(ns+"gameDetail",game_seq);
		return gameDetail;
	}

	@Override
	public List<Integer> monthlyDayProfit(String month_day[]) {
		List<Integer> monthlyDayProfit = new ArrayList<Integer>();
		for (int i = 0; i < month_day.length; i++) {
			monthlyDayProfit.add(sqlSession.selectOne(ns + "monthlyDayProfit", month_day[i]));
		}
		return monthlyDayProfit;
	}

	@Override
	public List<Integer> monthlyDaySpend(String month_day[]) {
		List<Integer> monthlyDaySpend = new ArrayList<Integer>();
		for (int i = 0; i < month_day.length; i++) {
			monthlyDaySpend.add(sqlSession.selectOne(ns + "monthlyDaySpend", month_day[i]));
		}
		return monthlyDaySpend;
	}

	@Override
	public List<Integer> monthlyFavoriteSports(GameDTO dto) {
		List<Integer> monthlyFavoriteSports = new ArrayList<Integer>();
		for (int i = 1; i <= 12; i++) {
			String md = "";
			if(i<10) md = "2019-0"+i;
			else md = "2019-"+i+"";
			dto.setGdate(md);
			monthlyFavoriteSports.add(sqlSession.selectOne(ns+"monthlyFavoriteSports", dto));
		}
		return monthlyFavoriteSports;
	}

	@Override
	public List<TeamDetailDTO> mainRankFirst() {
		List<TeamDetailDTO> mainRankFirst = new ArrayList<TeamDetailDTO>();
		mainRankFirst = sqlSession.selectList(ns+"mainRankFirst");
		return mainRankFirst;
	}

	@Override
	public List<TeamDetailDTO> mainRankLast() {
		List<TeamDetailDTO> mainRankLast = new ArrayList<TeamDetailDTO>();
		mainRankLast = sqlSession.selectList(ns+"mainRankLast");
		return mainRankLast;
	}

	@Override
	public SportsScoreDto sportsScore(String category) {
		SportsScoreDto sportsScore =  new SportsScoreDto();
		sportsScore =  sqlSession.selectOne(ns+"sportsScore",category);
		return sportsScore;
	}

	@Override
	public List<GameDTO> monthlyStadiumCount(LocationStadiumDto dto) {
		List<GameDTO> monthlyStadiumCount = new ArrayList<GameDTO>();
		monthlyStadiumCount = sqlSession.selectList(ns + "monthlyStadiumCount", dto);
		return monthlyStadiumCount;
	}

	@Override
	public List<GameDTO> locationStadiumCount(LocationStadiumDto dto) {
		List<GameDTO> locationStadiumCount = new ArrayList<GameDTO>();
		locationStadiumCount = sqlSession.selectList(ns+"locationStadiumCount", dto);
		return locationStadiumCount;
	}

	@Override
	public void deleteMember(String id) {
		sqlSession.update(ns+"deleteMember", id);
	}	
	

}
