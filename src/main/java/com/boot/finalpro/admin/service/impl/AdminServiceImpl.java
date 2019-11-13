package com.boot.finalpro.admin.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.boot.finalpro.admin.dao.AdminDAO;
import com.boot.finalpro.admin.dao.NoticeDAO;
import com.boot.finalpro.admin.model.NoticeDTO;
import com.boot.finalpro.admin.model.NoticeSubDTO;
import com.boot.finalpro.admin.service.AdminService;
import com.boot.finalpro.admin.util.LocationStadiumDto;
import com.boot.finalpro.admin.util.SearchUtillDto;
import com.boot.finalpro.admin.util.SearchUtill_ExchangeDto;
import com.boot.finalpro.admin.util.SportsScoreDto;
import com.boot.finalpro.game.dao.GameDAO;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.mypage.model.ExchangeDTO;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDao;
	
	@Autowired
	NoticeDAO noticeDao;
	

	@Autowired
	GameDAO gameDAO;
	
	
	private String path = "D:\\tmp\\";


	@Override
	public void writeNotice(NoticeDTO dto, List<MultipartFile> fileList)throws Exception {
		//String path = "D:\\SpringSample\\finalupdate.zip_expanded\\FinalPro\\src\\main\\resources\\static\\uploadFIle\\";
		//String path = "D:\\tmp\\";
		adminDao.writeNotice(dto);
		if(fileList != null) {
			NoticeSubDTO subDto = new NoticeSubDTO();
			for (MultipartFile mf : fileList) {
				String oriName = mf.getOriginalFilename();	// 파일 실제이름
				subDto.setOriginalName(oriName);
				String uploadName = path + System.currentTimeMillis() + oriName;	//파일 저장공간 + 이름바꾸기
				mf.transferTo(new File(uploadName));
				subDto.setUploadName(uploadName);
				adminDao.noticeFile(subDto);
			}
		}
	}

	@Override
	public void deleteNotice(int seq) {
		
		List<NoticeSubDTO> fileList = new ArrayList<NoticeSubDTO>();
		fileList = noticeDao.noticeFileDetail(seq);
		
		for (NoticeSubDTO noticeSubDTO : fileList) {
			//String path = "D:\\SpringSample\\finalupdate.zip_expanded\\FinalPro\\src\\main\\resources\\static\\uploadFIle\\";
			path += noticeSubDTO.getUploadName();
			
			File file = new File(path);
			
			if(file.exists()) {
				file.delete();
			}
		}
		
	
		adminDao.deleteNoticeFile(seq);
		adminDao.deleteNotice(seq);
	}

	@Override
	public void notice_file_del(int seq) {
		List<NoticeSubDTO> fileList = new ArrayList<NoticeSubDTO>();
		fileList = noticeDao.noticeFileDetail(seq);
		
		for (NoticeSubDTO noticeSubDTO : fileList) {
			//String path = "D:\\SpringSample\\finalupdate.zip_expanded\\FinalPro\\src\\main\\resources\\static\\uploadFIle\\";
			path += noticeSubDTO.getUploadName();
			
			File file = new File(path);
			
			if(file.exists()) {
				file.delete();
			}
		}		
		adminDao.notice_file_del(seq);
	}

	@Override
	public int notice_file_account(int seq) {
		int count = 0;
		count = adminDao.notice_file_account(seq);
		return count;
	}

	@Override
	public void notice_update(NoticeDTO dto, List<MultipartFile> fileList) throws Exception {
		//String path = "D:\\SpringSample\\finalupdate.zip_expanded\\FinalPro\\src\\main\\resources\\static\\uploadFIle\\";
		adminDao.notice_update(dto);
		if(fileList != null) {
			NoticeSubDTO subDto = new NoticeSubDTO();
			for (MultipartFile mf : fileList) {
				String oriName = mf.getOriginalFilename();	// 파일 실제이름
				subDto.setOriginalName(oriName);
				String uploadName = path + System.currentTimeMillis() + oriName;	//파일 저장공간 + 이름바꾸기
				mf.transferTo(new File(uploadName));
				subDto.setUploadName(uploadName);
				subDto.setSeq(dto.getSeq());
				adminDao.notice_File_update(subDto);
			}
		}
		
	}
	
	@Override
	public int memberTotalCount(SearchUtillDto dto) {
		int count  = 0 ;
		count = adminDao.memberTotalCount(dto);
		return count;
	}

	@Override
	public List<MemberDTO> getMemberList(SearchUtillDto dto) {
		List<MemberDTO> memberList = new ArrayList<MemberDTO>();
		memberList = adminDao.getMemberList(dto);
		return memberList;
	}

	@Override
	public MemberDTO memberDetail(String id) {
		MemberDTO member = new MemberDTO();
		member =  adminDao.memberDetail(id);
		return member;
	}

	@Override
	public int dailyProfitMoney() {
		int dailyProfitMoney = 0;
		dailyProfitMoney = adminDao.dailyProfitMoney() - adminDao.dailySpendMoney();		
		return dailyProfitMoney;
	}

	@Override
	public int monthlyProfitMoney(String ym) {
		int monthlyProfitMoney = 0;
		monthlyProfitMoney = adminDao.monthlyProfitMoney(ym)-adminDao.monthlySpendMoney(ym);
		return monthlyProfitMoney;
	}

	@Override
	public List<Integer> yearProfitMoney(String[] month) {
		List<Integer> yearProfit = new ArrayList<Integer>();
		yearProfit = adminDao.yearProfitMoney(month);
		return yearProfit;
	}

	@Override
	public List<Integer> yearSpendMoney(String[] month) {
		List<Integer> yearSpend = new ArrayList<Integer>();
		yearSpend = adminDao.yearSpendMoney(month);
		return yearSpend;
	}

	@Override
	public Map<String, Integer> getGameCategoryCount(String[] category) {
		Map<String, Integer> getGameCategoryCount = new HashMap<String, Integer>();
		getGameCategoryCount = adminDao.getGameCategoryCount(category);
		return getGameCategoryCount;
	}

	@Override
	public List<GameDTO> recentlyGame() {
		List<GameDTO> recentlyGame = new ArrayList<GameDTO>();
		recentlyGame = adminDao.recentlyGame();
		return recentlyGame;
	}

	@Override
	public List<ExchangeDTO> dontExchangeTop10() {
		List<ExchangeDTO> dontExchangeTop10 = new ArrayList<ExchangeDTO>();
		dontExchangeTop10 = adminDao.dontExchangeTop10();
		return dontExchangeTop10;
	}

	@Override
	public int exchangeListCount(SearchUtill_ExchangeDto dto) {
		int exchangeListCount = 0;
		exchangeListCount = adminDao.exchangeListCount(dto);
		return exchangeListCount;
	}

	@Override
	public List<ExchangeDTO> exchangeList(SearchUtill_ExchangeDto dto) {
		List<ExchangeDTO> exchangeList = new ArrayList<ExchangeDTO>();
		exchangeList = adminDao.exchangeList(dto);
		return exchangeList;
	}

	@Override
	public ExchangeDTO exchangeDetail(int seq) {
		ExchangeDTO exchangeDetail = new ExchangeDTO();
		exchangeDetail = adminDao.exchangeDetail(seq);
		return exchangeDetail;
	}

	@Override
	public void exchangeUpdate(int seq) {
		adminDao.exchageUpdate(seq);
		adminDao.spendUpdate(seq);
	}
	
	@Override
	public int gameListCount(SearchUtillDto dto) {
		//System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!adminService gameListCount:"+dto.toString());
		int gameListCount = 0 ;
		gameListCount = adminDao.gameListCount(dto);
		return gameListCount;
	}

	@Override
	public List<GameDTO> gameList(SearchUtillDto dto) {
		List<GameDTO> gameList = new ArrayList<GameDTO>();
		gameList = adminDao.gameList(dto);
		return gameList;
	}

	@Override
	public GameDTO gameDetail(int game_seq) {
		GameDTO gameDetail = new GameDTO();
		gameDetail = adminDao.gameDetail(game_seq);
		return gameDetail;
	}

	@Override
	public Map<String, List<Integer>> monthly_day(String[] month_day) {
		Map<String, List<Integer>> monthMap = new HashMap<String, List<Integer>>();
		List<Integer> monthlyDayProfit = new ArrayList<Integer>();
		List<Integer> monthlyDaySpend = new ArrayList<Integer>();
		List<Integer> mdpMinusmds = new ArrayList<Integer>();
		
		monthlyDayProfit = adminDao.monthlyDayProfit(month_day);
		monthlyDaySpend = adminDao.monthlyDaySpend(month_day);
		
		for (int i = 0; i < monthlyDayProfit.size(); i++) {
			mdpMinusmds.add(monthlyDayProfit.get(i) - monthlyDaySpend.get(i));
		}
		
		monthMap.put("monthlyDayProfit", monthlyDayProfit);
		monthMap.put("monthlyDaySpend", monthlyDaySpend);
		monthMap.put("mdpMinusmds", mdpMinusmds);
		
		return monthMap;
	}

	@Override
	public Map<String,List<Integer>>monthlyFavoriteSports(GameDTO dto) {
		Map<String, List<Integer>>monthlyFavoriteSports = new HashMap<String, List<Integer>>();
		String category[] = {"축구","농구","야구","탁구","배드민턴"};
		for (int i = 0; i < category.length; i++) {
			dto.setCategory(category[i]);
			List<Integer> favoirteSports = new ArrayList<Integer>();
			favoirteSports = adminDao.monthlyFavoriteSports(dto);
			monthlyFavoriteSports.put(category[i], favoirteSports);
		}
		
		return monthlyFavoriteSports;
	}

	@Override
	public Map<String, List<TeamDetailDTO>> mmrRanking() {
		Map<String, List<TeamDetailDTO>> mmrRanking = new HashMap<String, List<TeamDetailDTO>>();
		List<TeamDetailDTO> F_rank = new ArrayList<TeamDetailDTO>();
		List<TeamDetailDTO> L_rank = new ArrayList<TeamDetailDTO>();
		F_rank = adminDao.mainRankFirst(); 
		L_rank = adminDao.mainRankLast();
		mmrRanking.put("first", F_rank); 
		mmrRanking.put("last",L_rank);
		
		return mmrRanking;
	}

	@Override
	public Map<String, SportsScoreDto> sportsScore() {
		Map<String, SportsScoreDto> sportsScore = new HashMap<String, SportsScoreDto>();
		sportsScore.put("soccer", adminDao.sportsScore("SOCCER_MMR"));		
		sportsScore.put("basketBall", adminDao.sportsScore("BASKETBALL_MMR"));
		sportsScore.put("baseBall", adminDao.sportsScore("BASEBALL_MMR"));
		sportsScore.put("badminton", adminDao.sportsScore("BADMINTON_MMR"));
		sportsScore.put("pingpong", adminDao.sportsScore("PINGPONG_MMR"));
		return sportsScore;
	}

	
	@Override
	public Map<String, List<GameDTO>> monthlyStadiumCount(LocationStadiumDto dto) {
		Map<String, List<GameDTO>> monthlyStadiumCount = new HashMap<String, List<GameDTO>>();
		List<GameDTO> stadiumCount = new ArrayList<GameDTO>();
		stadiumCount = adminDao.monthlyStadiumCount(dto);
		monthlyStadiumCount.put("stadiumCount", adminDao.monthlyStadiumCount(dto));
		System.out.println("adminserviceimpl monthlyStadiumCount:"+stadiumCount.size());
		List<GameDTO> locationStadiumCount = new ArrayList<>();
		for (int i = 0; i < stadiumCount.size(); i++) {
			dto.setLocation(stadiumCount.get(i).getName_stadium());
			locationStadiumCount = adminDao.locationStadiumCount(dto);
			monthlyStadiumCount.put(dto.getLocation(), locationStadiumCount);
			System.out.println("@@@@@@@@@@@@@@@@서비스임플:"+locationStadiumCount.toString());
		}
		return monthlyStadiumCount;
	}

	@Override
	public void deleteMember(String[] ids) {
		for (int i = 0; i < ids.length; i++) {
			adminDao.deleteMember(ids[i]);
		}
	}

	
}
