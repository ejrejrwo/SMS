package com.boot.finalpro.betting.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.finalpro.betting.model.BettingDTO;
import com.boot.finalpro.betting.model.MMRRankingDTO;
import com.boot.finalpro.betting.service.BettingService;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.model.GameParams;
import com.boot.finalpro.member.model.MemberDTO;

import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/common/*")
public class BettingController {

	@Autowired
	BettingService bettingService;
	 
	@Autowired
	BCryptPasswordEncoder bc;
	  
	@RequestMapping(value = "bettinglist.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String bettinglist(Model model, GameParams gparam, HttpServletRequest req, Principal pcp) {
		log.info("BettingController bettinglist");

//		String id = ((MemberDTO) req.getSession().getAttribute("login")).getId();
		/* String id = pcp.getName(); */
		String id = "guest";
		
		Object principal2 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		log.info("idididid : " + principal2 );
		if(principal2 != "anonymousUser") {
			id = pcp.getName();
		}
		 
		// 검색 결과를 포함한 총 글 List
		// List<GameDTO> glist = bettingService.getBettingList(gparam);
		List<GameDTO> glist = bettingService.getBettingAllList(gparam, id);

		// 검색 결과를 포함한 총 글의 갯수
		int count = bettingService.getBettingCount(gparam);
		
		GameParams gp = new GameParams();
		gp.setPageNum(gparam.getPageNum());
		gp.setTotalCount(count);
		gp.setChoice(gparam.getChoice());
		gp.setKeyword(gparam.getKeyword());
		gp.setSorting(gparam.getSorting());
		
		model.addAttribute("gamelist", glist);
		model.addAttribute("count", count);
		model.addAttribute("gparam", gp);
		
		model.addAttribute("InsertTitle", "SMS 경기일정");

		// 로그인한 사람 Session 정보 넘겨주기
	//	MemberDTO login = (MemberDTO) req.getSession().getAttribute("login");
	//	model.addAttribute("login", login);

		return "bettinglist.tiles";
	}

	@RequestMapping(value = "betting.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String betting(Model model, GameDTO game, HttpServletRequest req, Principal pcp) {
		log.info("BettingController betting");

		// 경기 상세 페이지
		GameDTO gdto = bettingService.getBetting(game);
		
		gdto.setBet(game.isBet());
		gdto.setTeamcheck(game.isTeamcheck());
		
		model.addAttribute("game", gdto);

		log.info(gdto.toString());

		// team1, team2 MMR
		int mmr1 = bettingService.getMMR1(gdto);
		int mmr2 = bettingService.getMMR2(gdto);

		model.addAttribute("mmr1", mmr1);
		model.addAttribute("mmr2", mmr2);
		
		// team1, team2 File(로고)
		String file1 = bettingService.getTeamFile1(gdto);
		String file2 = bettingService.getTeamFile2(gdto);
		
		model.addAttribute("file1", file1);
		model.addAttribute("file2", file2);

		// team1, team2 betting money
		int betmoney1 = bettingService.getBettingMoney1(gdto);
		int betmoney2 = bettingService.getBettingMoney2(gdto);

		log.info("betmoney1:" + betmoney1 + " betmoney2:" + betmoney2);

		// 예상 승률 구하기
		double win_rate1 = Math.round((mmr1 / (double)(mmr1 + mmr2)) * 100);
		double win_rate2 = Math.round((mmr2 / (double)(mmr1 + mmr2)) * 100);

		model.addAttribute("win_rate1", win_rate1);
		model.addAttribute("win_rate2", win_rate2);

		// 각 팀의 배당률 구하기 - 소수점 둘째 자리 반올림
		double payout_r1 = 0.00;
		double payout_r2 = 0.00;

		if (betmoney1 == 0) {
			payout_r1 = 0;
		} else {
			payout_r1 = Math.round(((betmoney1 + betmoney2) / (double)betmoney1) * 100) / 100.0;
		}

		if (betmoney2 == 0) {
			payout_r2 = 0;
		} else {
			payout_r2 = Math.round(((betmoney1 + betmoney2) / (double)betmoney2) * 100) / 100.0;
		}

		log.info("payout_r1:" + payout_r1 + " payout_r2:" + payout_r2);

		model.addAttribute("payout_r1", payout_r1);
		model.addAttribute("payout_r2", payout_r2);

		// 현재 머니 가져오기
		/* String id = pcp.getName(); */
		String id = "guest";
		int now_money = 0;
		
		Object principal2 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		log.info("idididid : " + principal2 );
		if(principal2 != "anonymousUser") {
			id = pcp.getName();
			now_money = bettingService.getMoney(id);
		}
		
		model.addAttribute("id", id);
		model.addAttribute("now_money", now_money);
		
		model.addAttribute("InsertTitle", "SMS 베팅");
		
		return "betting.tiles";
	}

	@RequestMapping(value = "bettingAf.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String bettingAf(BettingDTO bdto, HttpServletRequest req) {
		log.info("BettingController bettingAf");

		log.info("betting dto : " + bdto.toString());

		// 베팅 정보 입력
		bettingService.betting(bdto);

		// 베팅한 머니 차감
		bettingService.subtractMoney(bdto);

		return "redirect:/common/bettinglist.do";
	}

	@ResponseBody // 빼먹지 말것!
	@RequestMapping(value="getPassword.do", method=RequestMethod.POST)
	public String getPassword(MemberDTO mem) {
		log.info("mem : " + mem.toString());
		
		boolean isPwd = bc.matches(mem.getPwd(), bettingService.getPassword(mem.getId()));
		
	//	System.out.println(bc.matches("testid123", "$2a$10$r5AZlzl7JMxff/K6iRM28u31cEYID.xGNmiZjDhoNTFpaFdeZDDjO"));
		
	//	int count = bettingService.getPassword(pwd);
		
		String msg = "";
		if(isPwd == true) {		// 비밀번호 일치 
			msg = "YES";
		}
		else {				// 비밀번호 불일치
			msg = "NO";
		}
		
		return msg;
	}
	
	@RequestMapping(value = "gameResultList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String gameResultList(Model model, GameParams gparam, HttpServletRequest req, Principal pcp) {
		log.info("BettingController gameResultList");

	//	String id = ((MemberDTO) req.getSession().getAttribute("login")).getId();
	//	String id = pcp.getName();
		
		// 검색 결과를 포함한 총 글 List
		List<GameDTO> glist = bettingService.getGameResultList(gparam);

		// 검색 결과를 포함한 총 글의 갯수
		int count = bettingService.getGameResultCount(gparam);
		
		GameParams gp = new GameParams();
		gp.setPageNum(gparam.getPageNum());
		gp.setTotalCount(count);
		gp.setChoice(gparam.getChoice());
		gp.setKeyword(gparam.getKeyword());
		gp.setSorting(gparam.getSorting());
		
		model.addAttribute("gamelist", glist);
		model.addAttribute("count", count);
		model.addAttribute("gparam", gp);
		
		model.addAttribute("InsertTitle", "SMS 경기결과");

		// 로그인한 사람 Session 정보 넘겨주기
	//	MemberDTO login = (MemberDTO) req.getSession().getAttribute("login");
	//	model.addAttribute("login", login);

		return "gameResultList.tiles";
	}
	
	@RequestMapping(value = "gameResultDetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String gameResultDetail(Model model, GameDTO game, HttpServletRequest req) {
		log.info("BettingController gameResultDetail");

		// 경기 결과 상세 페이지
		GameDTO gdto = bettingService.getBetting(game);
		
		// team1, team2 총 베팅 머니
		int total_money1 = bettingService.getBettingMoney1(gdto);
		int total_money2 = bettingService.getBettingMoney2(gdto);

		model.addAttribute("total_money1", total_money1);
		model.addAttribute("total_money2", total_money2);
		
		// team1, team2 MMR
		int mmr1 = bettingService.getMMR1(gdto);
		int mmr2 = bettingService.getMMR2(gdto);
		
		model.addAttribute("mmr1", mmr1);
		model.addAttribute("mmr2", mmr2);
		
		// team1, team2 File(로고)
		String file1 = bettingService.getTeamFile1(gdto);
		String file2 = bettingService.getTeamFile2(gdto);
		
		model.addAttribute("file1", file1);
		model.addAttribute("file2", file2);

		
		model.addAttribute("game", gdto);
		
		model.addAttribute("InsertTitle", "SMS 경기결과 상세페이지");

		log.info("result dto : " + gdto.toString());

		return "gameResultDetail.tiles";
	}
	
	
	
	@RequestMapping(value = "MMRRankList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MMRRankList(Model model, MMRRankingDTO mdto, HttpServletRequest req) {
		log.info("BettingController MMRRankList");
	
		model.addAttribute("InsertTitle", "SMS 랭킹");
		return "MMRRankList.tiles";
	}
	
	
	@RequestMapping(value = "MMRRankList1.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MMRRankList1(Model model, MMRRankingDTO mdto, HttpServletRequest req) {
		log.info("BettingController MMRRankList1");
		
		// MMR RANKING
		List<MMRRankingDTO> mlist1 = bettingService.getSoccerRank(mdto);
		
		// TEAM_DETAIL 갯수
		int count = bettingService.getRankCount(mdto);
		
		MMRRankingDTO dto = new MMRRankingDTO();
		dto.setPageNum(mdto.getPageNum());
		dto.setTotalCount(count);
		dto.setKeyword(mdto.getKeyword());
		
		model.addAttribute("ranklist1", mlist1);
		
		model.addAttribute("count", count);
		model.addAttribute("gparam", dto);
		
		return "/game/MMRRankList1";
	}
	
	@RequestMapping(value = "MMRRankList2.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MMRRankList2(Model model, MMRRankingDTO mdto, HttpServletRequest req) {
		log.info("BettingController MMRRankList2");
		
		// MMR RANKING
		List<MMRRankingDTO> mlist2 = bettingService.getBasketballRank(mdto);
		
		// TEAM_DETAIL 갯수
		int count = bettingService.getRankCount(mdto);
		
		MMRRankingDTO dto = new MMRRankingDTO();
		dto.setPageNum(mdto.getPageNum());
		dto.setTotalCount(count);
		dto.setKeyword(mdto.getKeyword());
		
		model.addAttribute("ranklist2", mlist2);
		
		model.addAttribute("count", count);
		model.addAttribute("gparam", dto);
		
		return "/game/MMRRankList2";
	}
	
	@RequestMapping(value = "MMRRankList3.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MMRRankList3(Model model, MMRRankingDTO mdto, HttpServletRequest req) {
		log.info("BettingController MMRRankList3");
		
		// MMR RANKING
		List<MMRRankingDTO> mlist3 = bettingService.getBaseballRank(mdto);
		
		// TEAM_DETAIL 갯수
		int count = bettingService.getRankCount(mdto);
		
		MMRRankingDTO dto = new MMRRankingDTO();
		dto.setPageNum(mdto.getPageNum());
		dto.setTotalCount(count);
		dto.setKeyword(mdto.getKeyword());
		
		model.addAttribute("ranklist3", mlist3);
		
		model.addAttribute("count", count);
		model.addAttribute("gparam", dto);
		
		return "/game/MMRRankList3";
	}
	
	@RequestMapping(value = "MMRRankList4.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MMRRankList4(Model model, MMRRankingDTO mdto, HttpServletRequest req) {
		log.info("BettingController MMRRankList4");
		
		// MMR RANKING
		List<MMRRankingDTO> mlist4 = bettingService.getBadmintonRank(mdto);
		
		// TEAM_DETAIL 갯수
		int count = bettingService.getRankCount(mdto);
		
		MMRRankingDTO dto = new MMRRankingDTO();
		dto.setPageNum(mdto.getPageNum());
		dto.setTotalCount(count);
		dto.setKeyword(mdto.getKeyword());
		
		model.addAttribute("ranklist4", mlist4);
		
		model.addAttribute("count", count);
		model.addAttribute("gparam", dto);
		
		return "/game/MMRRankList4";
	}
	
	@RequestMapping(value = "MMRRankList5.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MMRRankList5(Model model, MMRRankingDTO mdto, HttpServletRequest req) {
		log.info("BettingController MMRRankList5");
		
		// MMR RANKING
		List<MMRRankingDTO> mlist5 = bettingService.getPingpongRank(mdto);
		
		// TEAM_DETAIL 갯수
		int count = bettingService.getRankCount(mdto);
		
		MMRRankingDTO dto = new MMRRankingDTO();
		dto.setPageNum(mdto.getPageNum());
		dto.setTotalCount(count);
		dto.setKeyword(mdto.getKeyword());
		
		model.addAttribute("ranklist5", mlist5);
		
		model.addAttribute("count", count);
		model.addAttribute("gparam", dto);
		
		return "/game/MMRRankList5";
	}
	
	
	
}
