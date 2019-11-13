package com.boot.finalpro.chating;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.finalpro.league.model.NoChatDTO;
import com.boot.finalpro.league.service.LeagueMatchService;
import com.boot.finalpro.team.model.TeamDTO;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value = "/member/*")
public class ChatingController {
	
	@Autowired
	LeagueMatchService leagueMatchService;
	
	@RequestMapping(value = "publicChat.do", method=RequestMethod.GET)
	public String publicChat(Principal pcp, Model model) {
		
		log.info("ChatingController publicChat in : " + pcp.getName());
		
		String id = pcp.getName();
		
		NoChatDTO dto = leagueMatchService.NoChatSearch(id);
		
		if(dto == null) {
			dto = new NoChatDTO(id, 0, 0);
		}
		
		model.addAttribute("id", id);
		model.addAttribute("nochat", dto);
		
		return "chat.tiles";
	}
	
	@RequestMapping(value = "teamChat.do", method=RequestMethod.GET)
	public String teamChat(Principal pcp, Model model) {
		
		log.info("ChatingController teamChat in : " + pcp.getName());
		
		String id = pcp.getName();
		
		TeamDTO dto = leagueMatchService.ChatTeamCheck(id);
		
		model.addAttribute("id", id);
		model.addAttribute("teaminfo", dto);
		
		return "teamchat.tiles";
	}
	
	@ResponseBody
	@GetMapping("/nochatstart.do")
	public String nochatstart(NoChatDTO dto) {
		
		log.info("nochatstart 들어옴");
		
		boolean b = leagueMatchService.NoChatStart(dto);
		
		return b ? "금지완료" : "금지실패";
	}
	
	@ResponseBody
	@GetMapping("/nochatend.do")
	public String nochatend(NoChatDTO dto) {
		
		log.info("nochatend 들어옴");
		
		boolean b = leagueMatchService.NoChatEnd(dto);
		
		return b ? "해방완료" : "해방실패";
	}
	
	
}
