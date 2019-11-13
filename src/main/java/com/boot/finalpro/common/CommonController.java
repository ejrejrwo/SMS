package com.boot.finalpro.common;

import java.io.File;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.boot.finalpro.admin.model.NoticeDTO;
import com.boot.finalpro.admin.model.NoticeSubDTO;
import com.boot.finalpro.admin.service.MainService;
import com.boot.finalpro.admin.service.NoticeService;
import com.boot.finalpro.admin.util.PagingUtill;
import com.boot.finalpro.admin.util.PagingUtillDto;
import com.boot.finalpro.admin.util.SearchUtillDto;
import com.boot.finalpro.common.util.CalDateDto;
import com.boot.finalpro.common.util.CalendarUtil;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.service.GameService;
import com.boot.finalpro.league.service.LeagueMatchService;
import com.boot.finalpro.member.model.AuthoritiesDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.member.model.SMS_MemberDTO;
import com.boot.finalpro.member.service.MemberService;
import com.boot.finalpro.mypage.service.MyPageService;
import com.boot.finalpro.mypage.util.SendEmail;
import com.boot.finalpro.team.model.TeamDTO;
import com.boot.finalpro.video.model.VideoDTO;
import com.boot.finalpro.video.service.VideoService;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value = "/common/*")
public class CommonController {

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

	@RequestMapping(value = "main.do", method = RequestMethod.GET)
	public String mainlayout(Model model, CalDateDto jcal) throws Exception {

		Map<String, String> weather = new HashMap<String, String>();
		List<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
		SearchUtillDto dto = new SearchUtillDto();
		dto.setPage(1);
		noticeList = noticeService.getNoticeList(dto);

		weather = mainService.MainWeather();

		model.addAttribute("noticeList", noticeList);
		model.addAttribute("weather", weather);

		log.info("calculate ======================= 전 : " + jcal.toString());

		jcal.calculate();

		log.info("calculate ======================= 후 : " + jcal.toString());
		String yyyy = jcal.getYear() + "";
		String mm = CalendarUtil.two(jcal.getMonth());
		String ym = yyyy + "-" + mm;
		String yyyymm = CalendarUtil.yyyymm(jcal.getYear(), jcal.getMonth());
		Date date = new Date();
		SimpleDateFormat simple = new SimpleDateFormat("yyyyMMdd");
		String dd = simple.format(date).substring(6);
		String today = simple.format(date).substring(0, 4) + "-" + simple.format(date).substring(4, 6) + "-"
				+ simple.format(date).substring(6);

		// 토너먼트 일정 찾는부분 여기다 넣기
		List<GameDTO> gDto = new ArrayList<GameDTO>();
		List<GameDTO> gDaily = new ArrayList<GameDTO>();
		gDto = mainService.monthlyGame(ym);
		gDaily = mainService.dailyGame(today);

		for (GameDTO g : gDto) {
			g.setGdate(g.getGdate().substring(0, 10));
		}

		// 동영상가져오기
		List<VideoDTO> video = videoService.mainVideo();
		//log.info(video.toString());

		model.addAttribute("video", video);

		model.addAttribute("jcal", jcal);
		model.addAttribute("gDto", gDto);
		model.addAttribute("gDaily", gDaily);

		model.addAttribute("InsertTitle", "SMS 메인페이지");

		return "main.tiles";
	}

	@GetMapping("/loginPage.do")
	public ModelAndView loginPage() {

		log.info("CommonController loginPage in");

		ModelAndView loginPageMav = new ModelAndView();
		loginPageMav.addObject("InsertTitle", "SMS 로그인페이지");
		loginPageMav.setViewName("loginPage.tiles");

		return loginPageMav;
	}

	@GetMapping("/regiPage.do")
	public ModelAndView regPage(Model model) {

		log.info("CommonController regiPage in");

		ModelAndView regiPagemav = new ModelAndView();
		regiPagemav.addObject("InsertTitle", "SMS 회원가입");
		regiPagemav.setViewName("regiPage.tiles");

		return regiPagemav;
	}

	// 값이 제대로 넘어왔을경우 회원가입
	@PostMapping("/regi.do")
	public ModelAndView regi(MemberDTO member) {

		log.info("회원가입 애프터 들어옴 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

		ModelAndView regiMav = new ModelAndView();
		regiMav.setViewName("redirect:/mypage/loginPage.do");

		Date now = new Date();
		member.setRegidate(now + "");

		log.info("지금 시간 :" + now);
		log.info("tos" + member.toString());

		SMS_MemberDTO SMS = new SMS_MemberDTO();
		SMS.setUserpw(bc.encode(member.getPwd()));
		SMS.setUserid(member.getId());
		log.info("sms :" + SMS.toString());

		// save smsmember
		memberSerivce.saveSMSMember(SMS);
		// save member
		memberSerivce.saveMember(member);
		// auth save
		memberSerivce.saveAuth(member.getId());

		return regiMav;
	}

	@GetMapping("findPwdPage.do")
	public String findPwdPage(Model model) {

		log.info("CommonController findPwdPage() ");

		model.addAttribute("InsertTitle", "SMS 비밀번호찾기");

		return "findPwd.tiles";
	}

	@PostMapping("findPwdAf.do")
	public String findPwdAf(MemberDTO member) {

		log.info("CommonController findPwdAf()" + member.toString());

		// 암호화
		String pwd = bc.encode(member.getPwd());
		member.setPwd(pwd);

		memberSerivce.updatePwd(member);

		log.info("updatePwd Af" + bc.encode(member.getPwd()));

		return "redirect:/common/loginPage.do";
	}

	/* 동욱꺼 리그 페이지 */
	@GetMapping("/userleaguepage.do")
	public String user_league_page(Model model, String year, String month) {

		log.info("user_league_page 들어옴");

		if (year == null || month == null || year.equals("") || month.equals("")) {

			Calendar cal = Calendar.getInstance();

			year = cal.get(Calendar.YEAR) + ""; // 현재 년도를 구함
			month = cal.get(Calendar.MONTH) + 1 + ""; // 0 ~ 11 현재 월을 구함

		}

		List<GameDTO> list = leagueMatchService.leaguedata(year, month);

		model.addAttribute("year", Integer.parseInt(year));
		model.addAttribute("month", Integer.parseInt(month));

		model.addAttribute("leaguelist", list);

		model.addAttribute("InsertTitle", "SMS 리그페이지");

		return "userleaguepage.tiles";
	}

	@GetMapping(value = "notice.do")
	public String notice(Model model, SearchUtillDto dto, @RequestParam("page") int page) {
		dto.setPage(page);
		/* System.out.println("notice.do dto:"+dto.toString()); */
		int count = 0;
		count = noticeService.totalCount(dto);
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		list = noticeService.getNoticeList(dto);
		PagingUtillDto pDto = new PagingUtillDto();
		pDto = PagingUtill.getPageCount(count, dto.getPage());
		model.addAttribute("totalCount", count);
		model.addAttribute("pDto", pDto);
		model.addAttribute("search", dto);
		model.addAttribute("list", list);

		model.addAttribute("InsertTitle", "SMS 공지사항");

		return "notice.list";
	}

	@GetMapping(value = "noticeDetail.do")
	public String noticeDetail(@RequestParam("seq") int seq, Model model,SearchUtillDto sdto) {
		/* System.out.println("noticeDetail seq:"+seq); */
		Map<String, Object> notice = new HashMap<String, Object>();
		NoticeDTO dto = new NoticeDTO();
		notice = noticeService.noticeDetail(seq);
		/* System.out.println(sdto.toString()); */
		dto = (NoticeDTO) notice.get("notice");
		model.addAttribute("dto", dto);


		model.addAttribute("previousNotice",notice.get("previousNotice"));
		model.addAttribute("nextNotice",notice.get("nextNotice"));

		if (notice.get("fileList") != null) {
			List<NoticeSubDTO> fileList = new ArrayList<NoticeSubDTO>();
			fileList = (List<NoticeSubDTO>) notice.get("fileList");
			model.addAttribute("fileList", fileList);
		}
		
		model.addAttribute("search", sdto);
		model.addAttribute("InsertTitle", "SMS 상세공지사항");

		return "notice.detail";
	}

	@GetMapping(value = "noticeFileDown.do")
	public String noticeFileDown(@RequestParam("file_seq") int file_seq, Model model, HttpServletResponse resp,
			HttpServletRequest req) throws Exception {
		NoticeSubDTO dto = new NoticeSubDTO();
		dto = noticeService.noticeFileDetail(file_seq);
		File downloadFile = new File(dto.getUploadName());
		model.addAttribute("downloadFile", downloadFile);
		model.addAttribute("dto", dto);

		return "downloadView";

	}
	@GetMapping(value = "userleagueapply.do")
	public String userleagueapply(Model model) {

		model.addAttribute("InsertTitle", "SMS 리그추가");

		return "userleagueapply.tiles";

	}

	@GetMapping(value = "phoneguide.do")
	public String phoneguide(Model model) {

		model.addAttribute("InsertTitle", "SMS 문의전화");

		return "phoneguide.tiles";

	}

}
