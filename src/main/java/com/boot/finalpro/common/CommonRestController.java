package com.boot.finalpro.common;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.boot.finalpro.admin.service.MainService;
import com.boot.finalpro.admin.service.NoticeService;
import com.boot.finalpro.game.service.GameService;
import com.boot.finalpro.league.service.LeagueMatchService;
import com.boot.finalpro.member.model.AuthoritiesDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.member.service.MemberService;
import com.boot.finalpro.mypage.service.MyPageService;
import com.boot.finalpro.mypage.util.SendEmail;
import com.boot.finalpro.team.model.TeamDTO;
import com.boot.finalpro.video.service.VideoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping(value = "/common/*")
public class CommonRestController {

	@Autowired
	BCryptPasswordEncoder bc;

	@Autowired
	MemberService memberSerivce;

	@Autowired
	LeagueMatchService leagueMatchService;

	@Autowired
	MainService mainService;

	@Autowired
	NoticeService noticeService;

	@Autowired
	GameService gameService;

	@Autowired
	MyPageService myPageService;

	@Autowired
	VideoService videoService;
	
	@GetMapping(value = {"/idCheck.do", "/api/idcheck/isusable"})
	public String idCheck(String id) {

		log.info("CommonController idCheck in");
		log.info("id = " + id);

		int count = memberSerivce.idCheck(id);

		if (count == 1) {
			// 데이터가 있는경우
			return "false";
		}
		// 데이터가 없는경우

		return "true";
	}
	
	@GetMapping("/eamilCheck.do")
	public String emailCheck(MemberDTO member) {

		log.info("CommonController emailCheck()");
		log.info("member :" + member.toString());

		SendEmail email = new SendEmail();
		email.senamail(member.getEmail(), member.getCerNumber());

		return "true";

	}
	
	@GetMapping("/findPwd.do")
	public String findPwd(MemberDTO member) {

		log.info("CommonController findPwd()");
		log.info("member :" + member.toString());

		member.setEmail(myPageService.findOneMemberById(member.getId()).getEmail());

		if (member.getEmail() == null && member.getEmail().trim().equals("")) {
			return "false";
		}

		SendEmail email = new SendEmail();
		email.senamail(member.getEmail(), member.getCerNumber());

		return "true";

	}
	
	@RequestMapping(value = "/weather.do", method = RequestMethod.GET)
	public Map<String, String> getWeather(String location) throws Exception {
		Map<String, String> data = new HashMap<String, String>();
		data = mainService.AjaxWeather(location);

		return data;
	}

	@RequestMapping(value = "/userleagueapplyAf.do", method = RequestMethod.GET)
	public String userleagueapplyAf(Principal pcp) {

		if (pcp == null) {
			// log.info("pcp is null ---------------------------------------");
			return "로그인을 해주세요";
		}

		String id = pcp.getName();

		AuthoritiesDTO adto = leagueMatchService.AuthSearch(id);

		if (!adto.getAuthority().equals("ROLE_TEAMLEADER")) {
			return "팀장만 신청해주세요";
		}

		int n = leagueMatchService.LeagueMatchSearch(id);

		if (n > 0) {
			return "이미 신청하셧습니다";
		}

		boolean b = leagueMatchService.LeagueMatchWrite(id);

		return b ? "신청이 완료되었습니다." : "신청에 실패하였습니다.";
	}
	
	@RequestMapping(value = "/leagueapplycancel.do", method = RequestMethod.GET)
	public String leagueapplycancel(Principal pcp) {

		if (pcp == null) {
			// log.info("pcp is null ---------------------------------------");
			return "로그인을 해주세요";
		}

		String id = pcp.getName();

		AuthoritiesDTO adto = leagueMatchService.AuthSearch(id);

		if (!adto.getAuthority().equals("ROLE_TEAMLEADER")) {
			return "팀장만 신청해주세요";
		}

		int n = leagueMatchService.LeagueMatchSearch(id);
		boolean b = false;

		if (n > 0) {
			b = leagueMatchService.LeagueMatchCancel(id);
		} else {
			return "신청내역이 없습니다.";
		}

		return b ? "취소가 완료되었습니다." : "취소에 실패하였습니다.";
	}
	
	@RequestMapping(value = "/ChatTeamCheck.do", method = RequestMethod.GET)
	public String ChatTeamCheck(Principal pcp) {

		if (pcp == null) {
			// log.info("pcp is null ---------------------------------------");
			return "로그인전";
		}

		String id = pcp.getName();

		TeamDTO dto = leagueMatchService.ChatTeamCheck(id);

		if (dto == null) {
			return "팀없음";
		}

		return "팀있음";
	}
	
	@RequestMapping(value = "/ChatPublicCheck.do", method = RequestMethod.GET)
	public String ChatPublicCheck(Principal pcp) {

		// log.info("ChatPublicCheck ======================= : ");

		if (pcp == null) {
			// log.info("pcp is null ---------------------------------------");
			return "로그인전";
		}

		return "로그인후";
	}
	
}
