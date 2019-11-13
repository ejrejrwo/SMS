package com.boot.finalpro.league.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.league.model.LeagueMatchDTO;
import com.boot.finalpro.league.service.LeagueMatchService;
import com.boot.finalpro.league.util.LeagueParamDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.mypage.model.MessageDTO;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/admin/*")
public class LeagueMatchController {

	@Autowired
	LeagueMatchService leagueMatchService;	
	
	@GetMapping("/adminleaguepage1.do")
	public String admin_league_page1(Model model, String category) {
		
		log.info("admin_league_page1 들어옴");
		
		String categorys[] = {"SOCCER_MMR","BASKETBALL_MMR","BASEBALL_MMR","BADMINTON_MMR","PINGPONG_MMR"};
		int n=0;
		
		if( category == null || category.equals("") ) {
			n = 0;
		}else {
			n = Integer.parseInt(category);
		}
		
		List<TeamDetailDTO> list = leagueMatchService.Ranksearch(categorys[n]);
		
		model.addAttribute("category", n+"");
		model.addAttribute("ranklist", list);
		model.addAttribute("doc_title", "리그관리");
		model.addAttribute("doc_sub_title", "리그참가권유");
		
		model.addAttribute("InsertTitle", "SMS 관리자 리그참가권유");
		
		return "adminleaguepage1.tiles";
	}
	
	@GetMapping("/adminleaguepage2.do")
	public String admin_league_page2(Model model) {
		
		log.info("admin_league_page2 들어옴");
		
		List<LeagueMatchDTO> list = leagueMatchService.acceptlist();
		
		model.addAttribute("acceptlist", list);
		model.addAttribute("doc_title", "리그관리");
		model.addAttribute("doc_sub_title", "리그만들기");
		
		model.addAttribute("InsertTitle", "SMS 관리자 리그만들기");
		
		return "adminleaguepage2.tiles";
	}
	
	@ResponseBody
	@GetMapping("/messagesend.do")
	public String messagesend(String id, String message, Principal pcp) {
		
		log.info("messagesend 들어옴");
		//log.info("id = " + id);
		//log.info("message = " + message);
		
		String userId = pcp.getName();
		
		MessageDTO mdto = new MessageDTO();
		
		mdto.setSend_id(userId);
		mdto.setReceive_id(id);
		mdto.setContent(message);
		
		//log.info(mdto.toString());
		
		boolean b = leagueMatchService.messagesend(mdto);
		
		return b?"성공":"실패";
	}
	
	
	@PostMapping("/addleague.do")
	public String add_league(Model model, LeagueParamDTO dto) {
		
		log.info("add_league 들어옴");
		
		leagueMatchService.addleague(dto);
		
		return "redirect:/admin/admin.do";
	}
	
	@ResponseBody
	@GetMapping("/leaguecheck.do")
	public String leaguecheck() {
		
		log.info("leaguecheck 들어옴");
		
		int n = leagueMatchService.leaguecheck();
		
		return n>0?"있음":"없음";
	}
	
	
}
