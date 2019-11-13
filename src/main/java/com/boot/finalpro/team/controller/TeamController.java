package com.boot.finalpro.team.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.boot.finalpro.betting.model.BettingDTO;
import com.boot.finalpro.betting.service.BettingService;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.model.GameMatchDTO;
import com.boot.finalpro.member.model.AuthoritiesDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.member.service.MemberService;
import com.boot.finalpro.mypage.model.MessageDTO;
import com.boot.finalpro.team.model.ReportTeamDTO;
import com.boot.finalpro.team.model.TeamApplicationDTO;
import com.boot.finalpro.team.model.TeamDTO;
import com.boot.finalpro.team.model.TeamGameParam;
import com.boot.finalpro.team.model.TeamMemberParam;
import com.boot.finalpro.team.service.TeamService;
import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.teambbs.model.RecruitTeamDTO;
import com.boot.finalpro.teambbs.model.RecruitTeamParam;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;
import com.boot.finalpro.teambbs.model.TeamDetailParam;
import com.boot.finalpro.util.FUpUtil;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/mypage/*")
public class TeamController {

	@Autowired
	TeamService teamService;
	
	@Autowired
	MemberService memberSerivce;
	
	@Autowired
	BettingService bettingService;
	
	@RequestMapping(value = "teamapplication.do", method=RequestMethod.GET)
	public String teamapplication(Principal pcp, Model model)throws Exception {
		
		String userid = pcp.getName();
		String team_name = teamService.getTeamcount(userid);
		int appcount = teamService.getAppCount(userid);
		
		if(team_name == "" || team_name == null) {
			if(appcount > 0) {
				return "redirect:/mypage/teamlist.do";
			}
			model.addAttribute("InsertTitle", "SMS 팀 만들기");
			return "teamapplication.tiles";
		}else {
			return "redirect:/mypage/teamdetail.do?team_name=" + URLEncoder.encode(team_name, "UTF-8");
		}
	}
	
	//@RequestMapping(value = "teamapplicationAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	@PostMapping(value = "teamapplicationAf.do")
	public String teamapplicationAf(TeamDetailDTO teamdetaildto, TeamDTO teamdto,MultipartHttpServletRequest mtfReq, HttpServletRequest request)throws Exception {
		String uploadPath = request.getServletContext().getRealPath("/teamimg/");
		
		MultipartFile file;
		file = mtfReq.getFile("file");
		
		if (file == null) { // 파일이 없을경우
		 teamService.teamapplicationAf(teamdetaildto, null , null);
		} else { // 파일이 있을경우
		 teamService.teamapplicationAf(teamdetaildto, file, uploadPath);
		}
		
		return "redirect:/mypage/teamlist.do";
	}

	
	@RequestMapping(value = "teamlist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String teamlist(Model model, TeamDetailParam teamdetailparam) {
		
		int sn = teamdetailparam.getPageNumber();
		int start = sn * teamdetailparam.getRecordCountPerPage() + 1;
		int end = (sn + 1) * teamdetailparam.getRecordCountPerPage();
		
		teamdetailparam.setStart(start);
		teamdetailparam.setEnd(end);
		
		List<TeamDetailDTO> teamlist = teamService.teamlist(teamdetailparam);
		int teamlistcount = teamService.teamlistCount(teamdetailparam);
		log.info("====" + teamdetailparam.toString());
		model.addAttribute("teamlist", teamlist);
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);
		model.addAttribute("recordCountPerPage", teamdetailparam.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", teamlistcount);
		model.addAttribute("s_category", teamdetailparam.getS_category());
		model.addAttribute("s_keyword", teamdetailparam.getS_keyword());
		model.addAttribute("sport_category", teamdetailparam.getSport_category());
		
		model.addAttribute("InsertTitle", "SMS 팀 목록");
		
		return "teamlist.tiles";
	}
	
	@RequestMapping(value = "teamdetail.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String teamdetail(Model model, TeamDetailDTO teamdetaildto, Principal pcp, OverlapDTO overlapdto) {
		
		TeamDetailDTO teamdetail = teamService.teamdetail(teamdetaildto);
		List<TeamApplicationDTO> memappstate = teamService.memappstate(teamdetaildto);
		int memcount = teamService.memcount(teamdetaildto);
		log.info("====" + memcount);
		
		String id = pcp.getName();
		TeamDetailParam teamdetailparam = new TeamDetailParam();
	    teamdetailparam.setId(id);
	    teamdetailparam.setTeam_name(teamdetaildto.getTeam_name());
	    
	    System.out.println("teamdetail dto : " + overlapdto);
	    overlapdto.setId(id);
		OverlapDTO likedto = teamService.TeamLikePickId(overlapdto);
		
		MemberDTO mem = teamService.getMemberById(id);
	    AuthoritiesDTO auth = teamService.getAuth(id);
	    
	    int teamappcount = teamService.TeamAppCount(teamdetailparam);
	    int teamappcheck = teamService.TeamAppcheck(teamdetailparam);
	    log.info("=======" + teamappcheck);
	    
	    TeamMemberParam teammemberparam = new TeamMemberParam();
	    teammemberparam.setTeam_name(teamdetaildto.getTeam_name());
	    List<MemberDTO> memberlist = teamService.memberstate(teammemberparam);
	    for (int i = 0; i < memberlist.size(); i++) {
			log.info(memberlist.get(i).toString());
		}
	    log.info("detail==========================" + teamdetail.toString());
	    model.addAttribute("teamappcheck", teamappcheck);
	    model.addAttribute("likedto", likedto);
		model.addAttribute("memberlist", memberlist);
		model.addAttribute("teamdetail", teamdetail);
		model.addAttribute("memapplist", memappstate);
		model.addAttribute("memcount", memcount);
		model.addAttribute("mem", mem);
		model.addAttribute("auth", auth);
		model.addAttribute("appcount", teamappcount);
		
		model.addAttribute("InsertTitle", "SMS 팀 상세보기");
		
		return "teamdetail.tiles";
	}
	
	@RequestMapping(value = "memappwrite.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String memappwrite(TeamDetailDTO teamdetaildto, Model model) {
		
		model.addAttribute("team_name", teamdetaildto);
		
		model.addAttribute("InsertTitle", "SMS 팀원 신청");
		
		return "memberapplication.tiles";
	}
	
	@RequestMapping(value = "memberapplicationAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void memberapplicationAf(TeamApplicationDTO teamappdto, HttpServletResponse resp)throws Exception {
		
		teamService.memberapplicationAf(teamappdto);
		
		resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.println("완료");
		out.flush();
	}
	
	@RequestMapping(value = "accept.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void accept(TeamApplicationDTO teamappdto,String leader, HttpServletResponse resp)throws Exception {
		
		teamService.teamacceptall(teamappdto);
		
		MessageDTO mdto = new MessageDTO();
		mdto.setSend_id(leader);
	    mdto.setReceive_id(teamappdto.getId());
	    mdto.setContent(teamappdto.getTeam_name() +"팀에서 수락했습니다");
		
	    teamService.appmsg(mdto);
		
		resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.println("수락");
		out.flush();
	}
	
	@RequestMapping(value = "reject.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void reject(TeamApplicationDTO teamappdto,String leader, HttpServletResponse resp)throws Exception {
		System.out.println(teamappdto.toString());
		
		teamService.teamreject(teamappdto);
		
		MessageDTO mdto = new MessageDTO();
		mdto.setSend_id(leader);
	    mdto.setReceive_id(teamappdto.getId());
	    mdto.setContent(teamappdto.getTeam_name() +"팀에서 거절당하셨습니다");
		
	    teamService.appmsg(mdto);
	    
		resp.setCharacterEncoding("utf-8");
        resp.setContentType("text/html; charset=utf-8");
		PrintWriter out = resp.getWriter();
		out.println("거절");
		out.flush();
	}
	
	@RequestMapping(value = "matchinglist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String matchinglist(Model model, TeamGameParam teamgameparam) {
		
		int sn = teamgameparam.getPageNumber();
		int start = sn * teamgameparam.getRecordCountPerPage() + 1;
		int end = (sn + 1) * teamgameparam.getRecordCountPerPage();
		
		teamgameparam.setStart(start);
		teamgameparam.setEnd(end);
		
		List<GameDTO> gamelist = teamService.getgamelist(teamgameparam);
		int gamelistcount = teamService.getgamelistCount(teamgameparam);
		
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);
		model.addAttribute("recordCountPerPage", teamgameparam.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", gamelistcount);
		model.addAttribute("gamelist", gamelist);
		model.addAttribute("team_name", teamgameparam.getName_team1());
		model.addAttribute("sport", teamgameparam.getSport());
		model.addAttribute("league", teamgameparam.getLeague());
		model.addAttribute("game_result", teamgameparam.getGame_result());
		
		model.addAttribute("teamgameparam", teamgameparam);
		
		model.addAttribute("InsertTitle", "SMS 경기목록");
		System.out.println(teamgameparam.toString());
		return "matchinglist.tiles";
	}
	
	
	@RequestMapping(value = "getmatchinglist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String getmatchinglist(GameDTO gamedto, HttpServletResponse resp, Model model)throws Exception {
		
		List<GameMatchDTO> matchinglist = teamService.getmatchinglist(gamedto);
		
		model.addAttribute("matchinglist", matchinglist);
		
		model.addAttribute("InsertTitle", "SMS 경기신청현황");
		
		return "team/matchstate";
	}
	
	@RequestMapping(value = "matchappect.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String matchappect(GameMatchDTO gamematchdto) {
//		int seq = Integer.parseInt(seq_game); 
//		GameMatchDTO gamematchdto = new GameMatchDTO();
//		gamematchdto.setSeq_game(seq);
//		gamematchdto.setTeam_name2(team_name2);
		log.info("matchappect==========" + gamematchdto.toString());
		log.info("========================================여기임");
		teamService.matchappect(gamematchdto);
		
		return "redirect:/mypage/teamapplication.do";
	}
	
	@RequestMapping(value = "matchreject.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String matchreject(GameMatchDTO gamematchdto) {
		log.info("--------------------------여기");
		teamService.matchreject(gamematchdto);
		
		return "redirect:/mypage/teamapplication.do";
	}
	
	@RequestMapping(value = "memberstate.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String memberstate(TeamMemberParam teammemberparam, Model model, TeamDetailDTO teamdetaildto) {
		
		int sn = teammemberparam.getPageNumber();
		int start = sn * teammemberparam.getRecordCountPerPage() + 1;
		int end = (sn + 1) * teammemberparam.getRecordCountPerPage();
		
		teammemberparam.setStart(start);
		teammemberparam.setEnd(end);
		
		List<MemberDTO> memberlist = teamService.memberstate(teammemberparam);
		TeamDetailDTO teamdetail = teamService.teamdetail(teamdetaildto);
		int memcount = teamService.memberstateCount(teammemberparam);
		
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);
		model.addAttribute("recordCountPerPage", teammemberparam.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", memcount);
		model.addAttribute("memberlist", memberlist);
		model.addAttribute("teamdetail", teamdetail);
		
		model.addAttribute("InsertTitle", "SMS 팀원 현황");
		return "memberstate.tiles";
	}
	
	/**
	 * @param memberdto
	 * @return id값과 team_name가져와서 팀 탈퇴 시킨 후 다시 멤버현황페이지로
	 * @throws Exception
	 */
	@RequestMapping(value = "teamout.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String teamout(MemberDTO memberdto)throws Exception {
		log.info("memdto" + memberdto.toString());
		log.info("memdto=-=-=-=-" + memberdto.getTeam_name());
		teamService.teamout(memberdto);

		String team_name = URLEncoder.encode(memberdto.getTeam_name(), "UTF-8");
		return "redirect:/mypage/memberstate.do?team_name=" + team_name;
	}
	
	/**
	 * @param memberdto
	 * @return
	 * id값으로 팀탈퇴후 리스트
	 */
	@RequestMapping(value = "teamSecession.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String teamSecession(MemberDTO memberdto) {
		teamService.teamout(memberdto);
		return "redirect:/mypage/teamlist.do";
	}
	
	@RequestMapping(value = "detailup.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String detailup(TeamDetailDTO teamdetaildto, Model model) {
		
		model.addAttribute("teamdetail", teamdetaildto);
		
		model.addAttribute("InsertTitle", "SMS 팀 상세정보 수정");
		return "teamdetailup.tiles";
	}
	
	//@RequestMapping(value = "teamupAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	@PostMapping(value = "teamupAf.do")
	public String teamupAf(TeamDetailParam teamdetailparam, MultipartHttpServletRequest mtfReq, HttpServletRequest request)throws Exception {
		String uploadPath = request.getServletContext().getRealPath("/teamimg/");
		
		MultipartFile file;
		file = mtfReq.getFile("file");
		
			if (file == null) { // 파일이 없을경우
			 teamService.teamupAf(teamdetailparam, null , null);
			} else { // 파일이 있을경우
			 teamService.teamupAf(teamdetailparam, file, uploadPath);
			}
		
		String team_name = URLEncoder.encode(teamdetailparam.getTeam_name(), "UTF-8");
		return "redirect:/mypage/teamdetail.do?team_name=" + team_name; 
	}
	
	@RequestMapping(value = "recruitment.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String recruitment(TeamDetailDTO teamdetaildto, Model model) {
		
		model.addAttribute("teamdetail", teamdetaildto);
		
		model.addAttribute("InsertTitle", "SMS 팀 모집글 작성");
		
		return "team/recruitment";
	}
	
	@RequestMapping(value = "recruitmentAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void recruitmentAf(RecruitTeamDTO recruitteamdto, HttpServletResponse resp)throws Exception {
		log.info("====" + recruitteamdto.toString());
		teamService.recruitmentAf(recruitteamdto);
		
		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		out.println("저장완료");
		out.flush();
//		String team_name = URLEncoder.encode(recruitteamdto.getTeam_name(), "UTF-8");
//		return "redirect:/mypage/teamdetail.do?team_name=" + team_name; 
	}
	
	@RequestMapping(value = "recruitlist.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String recruitlist(Model model, RecruitTeamParam recruitparam) {
		
		int sn = recruitparam.getPageNumber();
		int start = sn * recruitparam.getRecordCountPerPage() + 1;
		int end = (sn + 1) * recruitparam.getRecordCountPerPage();
		
		recruitparam.setStart(start);
		recruitparam.setEnd(end);
		
		int count = teamService.recruitmencount(recruitparam);
		List<RecruitTeamDTO> recruitmentlist = teamService.recruitmentlist(recruitparam);
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);
		model.addAttribute("recordCountPerPage", recruitparam.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", count);
		model.addAttribute("recruitmentlist", recruitmentlist);
		model.addAttribute("sport_category", recruitparam.getSport_category());
		
		model.addAttribute("InsertTitle", "SMS 팀 모집글 목록");
		
		return "recruitmentlist.tiles";
	}
	
	/**
	 * @param team_name
	 * @return 마감했을때
	 * @throws Exception
	 */
	@RequestMapping(value = "deadline.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String deadline(String team_name)throws Exception {
		
		teamService.deadlineall(team_name);
		
		return "redirect:/mypage/teamdetail.do?team_name=" + URLEncoder.encode(team_name, "UTF-8");
	}
	
	@ResponseBody
	@RequestMapping(value = "get_tname.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String tnamecheck(String team_name) {
		int count = teamService.tnamecheck(team_name);
		
		String msg = "";
		if(count > 0) {
			msg = "YES";
		}else {
			msg = "NO";
		}
		return msg;
	}
	
	@RequestMapping(value = "tdel.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void tdel(String team_name, HttpServletResponse resp)throws Exception {
		int count = teamService.tdel_check(team_name);
		
		resp.setContentType("text/html; charset=UTF-8");
		 
		PrintWriter out = resp.getWriter();
		 
		if(count > 0) {
			out.println("<script>alert('남아있는 경기일정이 있습니다.'); location.href='teamlist.do';</script>");
		}else {
			teamService.tdel_all(team_name);
			out.println("<script>alert('삭제되었습니다.'); location.href='teamlist.do';</script>");
		}
		
		out.flush();
	}
	
//	@RequestMapping(value = "matstate.do", method = {RequestMethod.GET, RequestMethod.POST})
//	public String matstate(Model model, int seq_game) {
//		
//		boolean bet = false;
//		boolean teamcheck = true;
//		
//		return "redirect:/common/betting.do?seq_game=" + seq_game + "&bet=" + bet + "&teamcheck=" + teamcheck;
//	}
	
	@RequestMapping(value = "matstate.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String matstate(Model model, GameDTO game, BettingDTO bdto) {
		
		int betcount = bettingService.isBet(bdto);
		int teamcheckcount = bettingService.betTeamCheck(game);
		
		if(betcount >= 1) {	// 베팅을 한 경우
			game.setBet(true);
		}
		else {	// 베팅을 하지 않은 경우
			game.setBet(false);
		}
		
		if(teamcheckcount >= 1) {	// 로그인한 사람이 경기하는 팀에 속해있음
			game.setTeamcheck(true);
		}
		else {	// 로그인한 사람이 경기하는 팀에 속하지 않음
			game.setTeamcheck(false);
		}
		
		int seq_game = game.getSeq_game();
		boolean bet = game.isBet();
		boolean teamcheck = game.isTeamcheck();
		
		return "redirect:/common/betting.do?seq_game=" + seq_game + "&bet=" + bet + "&teamcheck=" + teamcheck;
	}
	
	   @RequestMapping(value = "teamupload.do", method = RequestMethod.POST)
	   public void communityImageUpload(HttpServletRequest request, HttpServletResponse response, 
	                              @RequestParam MultipartFile upload) {

	         System.out.println("communityImageUpload 도착");
	         
	          OutputStream out = null;
	          PrintWriter printWriter = null;
	          
	          response.setCharacterEncoding("utf-8");
	          response.setContentType("text/html;charset=utf-8");
	   
	              String fileName = upload.getOriginalFilename();
	              System.out.println("filename 변경 전 : " +fileName);
	              
	              fileName = FUpUtil.convertFileName(fileName);
	              System.out.println("filename 변경 후 : " +fileName);
	              
	              //upload 경로설정 .. tomcat 경로
	              String uploadPath = request.getServletContext().getRealPath("/upload");
	              System.out.println("uploadPath : " + uploadPath);
	   
	              //파일 업로드 할때에는 경로와 파일 네임을 같이 올린다..
	              byte[] bytes;
	         try {
	            bytes = upload.getBytes();
	            out = new FileOutputStream(new File(uploadPath + "\\" + fileName));
	            out.write(bytes);
	          
	              
	         //        System.out.println("out : "+out);
	              
	              String callback = request.getParameter("CKEditorFuncNum");
	              
	              printWriter = response.getWriter();
	              //String fileUrl = request.getServletContext().getRealPath("upload") + "\\"+ fileName;
	                String fileUrl = "/upload/" + fileName;
	             
	         //     System.out.println("fileUrl : " + fileUrl);
	        
	             printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
	                  + callback
	                  + ",'"
	                  + fileUrl
	                  + "','이미지를 업로드 하였습니다.'"
	                  + ")</script>");
	           //  System.out.println("collback : " + callback );
	           printWriter.flush();
	   
	          }catch(IOException e){
	              e.printStackTrace();
	          } finally {
	       }
	   }
	   /**/
		@ResponseBody
		@RequestMapping(value = "TeamLike.do", method = {RequestMethod.GET, RequestMethod.POST})
		public Map<String, Object> TeamLike(OverlapDTO overlapDto,
				@RequestParam(value="team_name")String team_name,
				TeamDetailDTO teamDto) {
			
			Map<String, Object> rmap = new HashMap<String, Object>();
			
			int count = 0;
			
			OverlapDTO dto = teamService.TeamLikePickId(overlapDto);
			
			if(dto == null) {
				teamService.TeamLikeOverlap(overlapDto);
				teamService.TeamLikePlus(team_name);
				TeamDetailDTO teamdto = teamService.teamdetail(teamDto);
				count = teamdto.getLike_count();
				rmap.put("msg", "팀 좋아요가 추가 되었습니다.");
				rmap.put("count", count);
				return rmap;
			}else {
				teamService.TeamLikeDel(overlapDto);
				TeamDetailDTO teamdto = teamService.teamdetail(teamDto);
				count = teamdto.getLike_count();
				rmap.put("msg", "팀 좋아요를 취소 하였습니다.");
				rmap.put("count", count);
				return rmap;
			}
		}
		
		
		@RequestMapping(value = "teamReport.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String teamReport(Model model) {
			
			model.addAttribute("InsertTitle", "SMS 팀 신고하기");
			
			return "team/include/teamreport";
		}
		
		@ResponseBody
		@RequestMapping(value = "TeamReportAf.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String TeamReportAf(OverlapDTO overlapDto, ReportTeamDTO reportteamDto) {
			
			OverlapDTO dto = teamService.TeamReportPickId(overlapDto);
			
			if(dto == null) {
				teamService.TeamReport(overlapDto);
				teamService.TeamReportSend(reportteamDto);
				return "관리자에게 신고 처리 하였습니다.";
			}else {
				return "이미 신고한 글입니다.";
			}
		}
}
