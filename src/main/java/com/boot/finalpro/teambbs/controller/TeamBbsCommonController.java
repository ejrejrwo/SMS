package com.boot.finalpro.teambbs.controller;

import java.io.PrintWriter;
import java.security.Principal;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.boot.finalpro.betting.service.BettingService;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.model.GameMatchDTO;
import com.boot.finalpro.game.model.GameParam;
import com.boot.finalpro.game.model.GameParams;
import com.boot.finalpro.game.service.GameService;
import com.boot.finalpro.member.model.AuthoritiesDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.member.service.MemberService;
import com.boot.finalpro.teambbs.model.SubDTO;
import com.boot.finalpro.teambbs.model.TeamBBSDTO;
import com.boot.finalpro.teambbs.model.TeamBBSParam;
import com.boot.finalpro.teambbs.service.TeamBbsService;
import com.boot.finalpro.teambbscomment.model.TeamBBSCommentDTO;
import com.boot.finalpro.teambbscomment.service.TeamBbsCommentService;
import com.boot.finalpro.util.utilMethod;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value = "/common/*")
public class TeamBbsCommonController {

	@Autowired
	TeamBbsService teamBbsSerivce;

	@Autowired
	MemberService memberService;

	@Autowired
	TeamBbsCommentService tbcs;
	
	@Autowired
	GameService gameService;
	
	@Autowired
	BettingService bettingService;

	@RequestMapping(value = "teamBbs.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String teamBbs(Model model, TeamBBSParam param, Principal pcp) throws Exception {
		// lombok Controller log 사용법
		log.info("TeamBbsController teamBbs()" + new Date());

		String id = "guest";
		Object principal2 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (principal2 != "anonymousUser") {
			id = pcp.getName();
		} else {
			return "redirect:/common/loginPage.do";
		}
		String team_name = teamBbsSerivce.getTeamName(id);
		param.setTeam_name(team_name);

		if (team_name == null) {
			return "redirect:/mypage/teamlist.do";
		} else {
			// paging
			int sn = param.getPageNumber(); // 현재 페이지 번호 ex) 0, 1, 2
			int start = sn * param.getRecordCountPerPage() + 1;
			int end = (sn + 1) * param.getRecordCountPerPage();

			param.setStart(start);
			param.setEnd(end);

			System.out.println("param : " + param);

			List<TeamBBSDTO> bbsList = teamBbsSerivce.allBbsList(param);
			// System.out.println("list의 갯수는 : " + bbsList.size());

			for (TeamBBSDTO teamBBSDTO : bbsList) {
				String date = utilMethod.dateEdit(teamBBSDTO.getWdate());
				teamBBSDTO.setWdate(date);
			}

			int totalRecordCount = teamBbsSerivce.getBbsCount(param);

			System.out.println("totalRecordCount : " + totalRecordCount);

			model.addAttribute("InsertTitle", "SMS 팀 게시판 리스트");
			model.addAttribute("bbsList", bbsList);

			model.addAttribute("pageNumber", sn);
			model.addAttribute("pageCountPerScreen", 10);
			model.addAttribute("recordCountPerPage", param.getRecordCountPerPage());
			model.addAttribute("totalRecordCount", totalRecordCount);
			model.addAttribute("s_keyword", param.getS_keyword());
			model.addAttribute("s_category", param.getS_category());
			model.addAttribute("subject_category", param.getSubject_category());
			model.addAttribute("sub_keyword", param.getSub_keyword());
			return "TeamBbs.tiles";
		}
	}
	
	@RequestMapping(value = "subBbs.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String subBbs(Model model, TeamBBSParam param, Principal pcp) throws Exception {
		// lombok Controller log 사용법
		log.info("TeamBbsController subBbs()" + new Date());

		String id = "guest";
		Object principal2 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (principal2 != "anonymousUser") {
			id = pcp.getName();
		} else {
			return "redirect:/common/loginPage.do";
		}

			// paging
			int sn = param.getPageNumber(); // 현재 페이지 번호 ex) 0, 1, 2
			int start = sn * param.getRecordCountPerPage() + 1;
			int end = (sn + 1) * param.getRecordCountPerPage();

			param.setStart(start);
			param.setEnd(end);

			System.out.println("param : " + param);

			List<SubDTO> bbsList = teamBbsSerivce.allBbsList2(param);
			// System.out.println("list의 갯수는 : " + bbsList.size());

			for (SubDTO subBBSDTO : bbsList) {
				String date = utilMethod.dateEdit(subBBSDTO.getWdate());
				subBBSDTO.setWdate(date);
			}

			int totalRecordCount = teamBbsSerivce.getBbsCount2(param);

			System.out.println("totalRecordCount : " + totalRecordCount);
			model.addAttribute("InsertTitle", "SMS 용병 게시판 리스트");
			model.addAttribute("bbsList", bbsList);

			model.addAttribute("pageNumber", sn);
			model.addAttribute("pageCountPerScreen", 10);
			model.addAttribute("recordCountPerPage", param.getRecordCountPerPage());
			model.addAttribute("totalRecordCount", totalRecordCount);
			model.addAttribute("s_keyword", param.getS_keyword());
			model.addAttribute("s_category", param.getS_category());
			model.addAttribute("subject_category", param.getSubject_category());
			model.addAttribute("sub_keyword", param.getSub_keyword());
			return "SubBbs.tiles";
		}
	
	@RequestMapping(value = "getgamedetail.do", method={RequestMethod.GET, RequestMethod.POST})
	public String gamedatail(int seq_game, Model model, Principal pcp) {
//		log.info(seq_game + "");
		gameService.readCount(seq_game);
		
		/* String id = pcp.getName(); */
		String id = "guest";
		
		Object principal2 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(principal2 != "anonymousUser") {
			id = pcp.getName();
		}
		
		MemberDTO mem = gameService.getMember(id);
		AuthoritiesDTO auth = gameService.getAuth(id);
		
		GameDTO game = gameService.updateGame(seq_game);
		
		// 게임신청 했는지 여부
		List<GameMatchDTO> glist = gameService.subGame(seq_game);
//		log.info(glist.toString());
		model.addAttribute("InsertTitle", "테스트1");
		model.addAttribute("glist", glist);
		model.addAttribute("mem", mem);
		model.addAttribute("auth", auth);
		model.addAttribute("game", game);
								
		return "teamBbs/game_detail";
	}
	
	///// 테스트
	@RequestMapping(value = "getgamelist.do", method={RequestMethod.GET, RequestMethod.POST})
	public String gamelist(String page, GameParam gp, Model model, Principal pcp) {
		String id = "guest";
		
		Object principal2 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(principal2 != "anonymousUser") {
			id = pcp.getName();
		}
		
		MemberDTO mem = gameService.getMember(id);
		AuthoritiesDTO auth = gameService.getAuth(id);
		
		// 전체 리스트 받아오기		
		int nowpage = 1;
		
		if(page != null) {
			nowpage = Integer.parseInt(page);
		}
		
		gp.setNowpage(nowpage);
		
		int count = gameService.getGameCount(gp);
//		log.info("count==============" + count);
		gp.setTotalCount(count);
		
		List<GameDTO> gamelist = gameService.getGamelist(gp);
//		log.info("gamelist=============" + gamelist.toString());
		
		model.addAttribute("gamelist", gamelist);
		model.addAttribute("paging", gp);
		model.addAttribute("mem", mem);
		model.addAttribute("auth", auth);
		model.addAttribute("InsertTitle", "테스트2");
		return "teamBbs/game_list";
	}
	@RequestMapping(value = "common1.do", method={RequestMethod.GET, RequestMethod.POST})
	public String common1(Model model) {
		log.info("TeamBbsController common1()" + new Date());
		model.addAttribute("InsertTitle", "인사말");
		return "common1.tiles";
	}
	
	@RequestMapping(value = "getbettinglist.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String bettinglist(Model model, GameParams gparam, HttpServletRequest req, Principal pcp) {
		log.info("BettingController bettinglist");

//		String id = ((MemberDTO) req.getSession().getAttribute("login")).getId();
		/* String id = pcp.getName(); */
		String id = "guest";
		
		Object principal2 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		log.info("idididid : " + principal2 );
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
		
		log.info("gp : " + gp.toString());
		log.info("count : " + count);
		model.addAttribute("InsertTitle", "테스트3");
		model.addAttribute("gamelist", glist);
		model.addAttribute("count", count);
		model.addAttribute("gparam", gp);

		// 로그인한 사람 Session 정보 넘겨주기
	//	MemberDTO login = (MemberDTO) req.getSession().getAttribute("login");
	//	model.addAttribute("login", login);

		return "teamBbs/BettingList";
	}
	
	@RequestMapping(value = "getbetting.do", method = { RequestMethod.GET, RequestMethod.POST })
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
		log.info("idididid : " + principal2 );
		if(principal2 != "anonymousUser") {
			id = pcp.getName();
			now_money = bettingService.getMoney(id);
		}
		model.addAttribute("InsertTitle", "테스트4");
		model.addAttribute("id", id);
		model.addAttribute("now_money", now_money);
		
		return "teamBbs/Betting";
	}
}
