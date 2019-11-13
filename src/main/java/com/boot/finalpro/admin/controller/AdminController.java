package com.boot.finalpro.admin.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
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

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.boot.finalpro.admin.model.NoticeDTO;
import com.boot.finalpro.admin.model.NoticeSubDTO;
import com.boot.finalpro.admin.service.AdminService;
import com.boot.finalpro.admin.service.NoticeService;
import com.boot.finalpro.admin.util.LocationStadiumDto;
import com.boot.finalpro.admin.util.PagingUtill;
import com.boot.finalpro.admin.util.PagingUtillDto;
import com.boot.finalpro.admin.util.SearchUtillDto;
import com.boot.finalpro.admin.util.SearchUtill_ExchangeDto;
import com.boot.finalpro.admin.util.SportsScoreDto;
import com.boot.finalpro.betting.model.BettingDTO;
import com.boot.finalpro.betting.model.MMRRankingDTO;
import com.boot.finalpro.betting.service.BettingService;
import com.boot.finalpro.game.model.BookingDTO;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.model.GameParams;
import com.boot.finalpro.game.service.GameService;
import com.boot.finalpro.league.service.LeagueMatchService;
import com.boot.finalpro.member.model.AuthoritiesDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.mypage.model.ExchangeDTO;
import com.boot.finalpro.team.model.ReportTeamDTO;
import com.boot.finalpro.team.model.TeamApplicationDTO;
import com.boot.finalpro.team.service.TeamService;
import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.teambbs.model.ReportBBSDTO;
import com.boot.finalpro.teambbs.model.TeamBBSDTO;
import com.boot.finalpro.teambbs.model.TeamBBSParam;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;
import com.boot.finalpro.teambbs.model.TeamDetailParam;
import com.boot.finalpro.teambbs.service.TeamBbsService;
import com.boot.finalpro.teambbscomment.model.ReportCommentDTO;
import com.boot.finalpro.teambbscomment.model.TeamBBSCommentDTO;
import com.boot.finalpro.teambbscomment.service.TeamBbsCommentService;
import com.boot.finalpro.util.utilMethod;
import com.boot.finalpro.video.model.VideoCommentDTO;
import com.boot.finalpro.video.model.VideoDTO;
import com.boot.finalpro.video.model.VideoReportDTO;
import com.boot.finalpro.video.service.VideoService;

import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;

@Log
@Controller
@Slf4j
@RequestMapping("/admin/*")
public class AdminController {
	private String month[] = { "19/01", "19/02", "19/03", "19/04", "19/05", "19/06", "19/07", "19/08", "19/09", "19/10",
			"19/11", "19/12" };
	private String category[] = { "축구", "야구", "농구", "탁구", "배드민턴" };
	@Autowired
	AdminService adminService;
	@Autowired
	NoticeService noticeService;

	@Autowired
	TeamBbsService teamBbsSerivce;
	@Autowired
	TeamBbsCommentService tbs;

	@Autowired
	TeamService teamService;

	@Autowired
	BettingService bettingService;
	
	@Autowired
	GameService gameService;

	@Autowired
	LeagueMatchService leagueService;

	@Autowired
	VideoService videoService;

	// 보경누나 비디오부분

///////////////////////////////////	video
	@RequestMapping(value = "admin_report.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String admin_report(Model model) {

// 신고글의 VideoReportDTO
		List<VideoReportDTO> vr = videoService.getVideoReport();
//log.info(vr.toString());

		List<VideoDTO> video = new ArrayList<VideoDTO>();
		List<VideoCommentDTO> vc = new ArrayList<VideoCommentDTO>();
				
		for (int i = 0; i < vr.size(); i++) {
			if (vr.get(i).getCategory() == 1) {
// VideoDTO
				VideoDTO vdto = videoService.getVideoReportList(vr.get(i).getParent());
//log.info(vdto.toString());
				video.add(vdto);

			} else if (vr.get(i).getCategory() == 2) {
// VideoCommentDTO
				VideoCommentDTO vcdto = videoService.getCommentReportList(vr.get(i).getParent());
//log.info(vcdto.toString());
				vc.add(vcdto);
			}
		}

		model.addAttribute("video", video);
		model.addAttribute("vc", vc);

		return "admin_report.tiles";
	}

	@RequestMapping(value = "admin_report_detail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String admin_report_detail(int seq_video, Model model) {
		videoService.videoRead(seq_video);

// 영상dto		
		VideoDTO video = videoService.videodetail(seq_video);
//log.info(video.toString());

// 댓글가져오기
		List<VideoCommentDTO> comment = videoService.commentlist(video);
//log.info(comment.toString());

//신고내역
		List<VideoDTO> r_video = videoService.getDetailVideoReport(seq_video);
//log.info(r_video.toString());

		List<VideoCommentDTO> r_comment = videoService.getDetailCommentReport(seq_video);
//log.info(r_comment.toString());

		model.addAttribute("r_comment", r_comment);
		model.addAttribute("r_video", r_video);
		model.addAttribute("comment", comment);
		model.addAttribute("video", video);

		return "admin_report_detail.tiles";
	}

	@RequestMapping(value = "video_report_delete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String video_report_delete(String v_check[], String c_check[]) {

		if (v_check != null) {
			for (int i = 0; i < v_check.length; i++) {
				System.out.println(v_check[i]);
				int seq_video = Integer.parseInt(v_check[i]);
				videoService.videoDelete(seq_video);
			}
		}

		if (c_check != null) {
			for (int i = 0; i < c_check.length; i++) {
				System.out.println(c_check[i]);
				int seq = Integer.parseInt(c_check[i]);
				videoService.videoCommentDelete(seq);
			}
		}

		return "redirect:/admin/admin_report.do";
	}

// video 삭제
	@RequestMapping(value = "admin_video_delete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String video_delete(int seq_video) {
//log.info(seq_video + "");		
		videoService.videoDelete(seq_video);

		return "redirect:/admin/admin_report.do";
	}

// comment 삭제
	@RequestMapping(value = "admin_comment_delete.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String commen_delete(int seq, int seq_video) {
//log.info(seq_video + "");		
		videoService.videoCommentDelete(seq);

		return "redirect:/admin/admin_report_detail.do?seq_video=" + seq_video;
	}

	@RequestMapping(value = "delete_report.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String delete_report(int seq_video, String id, String r_id) {
		log.info(seq_video + id + r_id);

		videoService.videoReportCancel(seq_video);
		videoService.memberReportCancel(id);
		videoService.memberReportPlus(r_id);

		OverlapDTO over = new OverlapDTO();
		over.setId(r_id);
		over.setVideo_report(seq_video);

		videoService.overDelete(over);
		videoService.videoReportDelete(over);

		return "redirect:/admin/admin_report_detail.do?seq_video=" + seq_video;
	}

	@RequestMapping(value = "delete_comment_report.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String delete_comment_report(int seq, String id, String r_id, int seq_video) {
		log.info(seq + id + r_id + seq_video);

		videoService.videoCommentCancel(seq);
		videoService.memberReportCancel(id);
		videoService.memberReportPlus(r_id);

		OverlapDTO over = new OverlapDTO();
		over.setId(r_id);
		over.setVideo_comment_report(seq);

		videoService.overCommentDelete(over);
		boolean b = videoService.videoReportCommentDelete(over);

		return "redirect:/admin/admin_report_detail.do?seq_video=" + seq_video;
	}

// 보경누나 비디오부분 끝

	// 일우꺼

	@GetMapping(value = "admin.do")
	public String admin(Model model) {
		int dailyProfitMoney = 0;
		int monthlyProfitMoney = 0;
		Map<String, List<TeamDetailDTO>> mmrRanking = new HashMap<String, List<TeamDetailDTO>>();
		List<Integer> yearProfit = new ArrayList<Integer>();
		List<Integer> yearSpend = new ArrayList<Integer>();
		List<Integer> yPminusyS = new ArrayList<Integer>();
		Map<String, Integer> getGameCategoryCount = new HashMap<String, Integer>();
		List<GameDTO> recentlyGame =  new ArrayList<GameDTO>();
		List<ExchangeDTO> dontExchangeTop10 = new ArrayList<ExchangeDTO>();
		
		Date Tdate = new Date();
		SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
		String today = date.format(Tdate);
		String ym = today.substring(2, 4) + "/" + today.substring(4, 6);

		dailyProfitMoney = adminService.dailyProfitMoney(); //오늘 수입
		monthlyProfitMoney = adminService.monthlyProfitMoney(ym); //이번달 수입
		yearProfit = adminService.yearProfitMoney(month); //월별 소득(통계용)
		yearSpend = adminService.yearSpendMoney(month);	  //월별 지출(통계용)
		for (int i = 0; i < yearProfit.size(); i++) { // 월별 소득-지출 (통계용)
			if(yearProfit.get(i)==null && yearSpend.get(i)==null) {
				yPminusyS.add(null); 
			}
			else if(yearProfit.get(i)!=null && yearSpend.get(i)==null) {
				yPminusyS.add(yearProfit.get(i)); 
			}
			else if(yearProfit.get(i)==null && yearSpend.get(i)!=null) {
				yPminusyS.add(yearSpend.get(i)*(-1)); 
			}
			else {
				yPminusyS.add(yearProfit.get(i)-yearSpend.get(i));
			}
		}
		
		getGameCategoryCount = adminService.getGameCategoryCount(category); // 이번달 선호종목(통계용)
		recentlyGame =  adminService.recentlyGame(); // 경기개시 임박한 10경기
		dontExchangeTop10 = adminService.dontExchangeTop10();
		mmrRanking = adminService.mmrRanking();
		TeamDetailDTO firstTeam = new TeamDetailDTO(); 
		TeamDetailDTO lastTeam = new TeamDetailDTO();
		if(mmrRanking.get("first") != null && mmrRanking.get("first").size() != 0) {
			for (int i = 0; i < mmrRanking.get("first").size(); i++) {
				if(i == mmrRanking.get("first").size()) firstTeam.setTeam_name(mmrRanking.get("first").get(i).getTeam_name());
				else firstTeam.setTeam_name(mmrRanking.get("first").get(i).getTeam_name());
			}
			firstTeam.setTotal_mmr(mmrRanking.get("first").get(0).getSoccer_mmr()+mmrRanking.get("first").get(0).getBasketball_mmr()+mmrRanking.get("first").get(0).getBaseball_mmr()+mmrRanking.get("first").get(0).getPingpong_mmr()+mmrRanking.get("first").get(0).getBadminton_mmr());
		}
		
		if(mmrRanking.get("last") != null && mmrRanking.get("last").size() != 0) {
			for (int i = 0; i < mmrRanking.get("last").size(); i++) {
				if(i == mmrRanking.get("last").size()) lastTeam.setTeam_name(mmrRanking.get("last").get(i).getTeam_name());
				else lastTeam.setTeam_name(mmrRanking.get("last").get(i).getTeam_name());
			}
			lastTeam.setTotal_mmr(mmrRanking.get("last").get(0).getSoccer_mmr()+mmrRanking.get("last").get(0).getBasketball_mmr()+mmrRanking.get("last").get(0).getBaseball_mmr()+mmrRanking.get("last").get(0).getPingpong_mmr()+mmrRanking.get("last").get(0).getBadminton_mmr());
		}
		System.out.println("controller:"+firstTeam.toString());
		System.out.println("controller:"+lastTeam.toString());
		model.addAttribute("firstTeam", firstTeam);
		model.addAttribute("lastTeam", lastTeam);
		model.addAttribute("dontExchangeTop10", dontExchangeTop10);
		model.addAttribute("recentlyGame", recentlyGame);
		model.addAttribute("getGameCategoryCount", getGameCategoryCount);
		model.addAttribute("yPminusyS", yPminusyS);
		model.addAttribute("yearProfit",yearProfit);
		model.addAttribute("yearSpend",yearSpend);
		model.addAttribute("dailyProfitMoney", dailyProfitMoney);
		model.addAttribute("monthlyProfitMoney", monthlyProfitMoney);
		model.addAttribute("doc_title", "SMS ADMIN");
		
		model.addAttribute("InsertTitle", "SMS 관리자메인");
		
		return "admin.main";
	}

	@GetMapping(value = "admin_noticeWrite.do")
	public String noticeWrite(Model model, Principal pcp) {
		String adminId = pcp.getName();

		model.addAttribute("adminId", adminId);
		model.addAttribute("doc_title", "공지사항");
		model.addAttribute("doc_sub_title", "공지사항 작성");
		model.addAttribute("InsertTitle", "SMS 관리자공지사항");
		return "admin_notice_Write";
	}

	@PostMapping(value = "noticeWriteAf.do")
	public void noticeWriteAf(MultipartHttpServletRequest mtfReq, NoticeDTO notice, HttpServletResponse resp)
			throws Exception {
		resp.setContentType("text/html;charset=utf-8");
		List<MultipartFile> fileList = new ArrayList<MultipartFile>();
		fileList = mtfReq.getFiles("file");

		if (fileList == null || fileList.size() == 0) { // 파일이 없을경우
			notice.setFile_on("N");
			adminService.writeNotice(notice, null);
		} else { // 파일이 있을경우
			notice.setFile_on("Y");
			adminService.writeNotice(notice, fileList);
		}

		resp.getWriter()
				.println("<script>alert('게시물 작성에 성공하였습니다.'); location.href='admin_noitceList.do?page=1'; </script>");
		resp.getWriter().flush();
		resp.getWriter().close();
	}

	@GetMapping(value = "admin_noitceList.do")
	public String admin_noitceList(Model model, SearchUtillDto dto, @RequestParam("page") int page) {
		dto.setPage(page);
		/* System.out.println("notice.do dto:"+dto.toString()); */
		int count = 0;
		count = noticeService.totalCount(dto);
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		list = noticeService.getNoticeList(dto);
		PagingUtillDto pDto = new PagingUtillDto();
		pDto = PagingUtill.getPageCount(count, dto.getPage());

		model.addAttribute("totalCount", count);
		model.addAttribute("doc_title", "공지사항");
		model.addAttribute("pDto", pDto);
		model.addAttribute("search", dto);
		model.addAttribute("list", list);
		model.addAttribute("doc_sub_title", "공지사항 리스트");
		model.addAttribute("InsertTitle", "SMS 관리자공지사항리스트");
		return "admin_notice_list";
	}

	@GetMapping(value = "admin_notice_delete.do")
	public void admin_notice_delete(@RequestParam("seqs") String seqs[], HttpServletResponse resp) throws Exception {
		resp.setContentType("text/html;charset=utf-8");
		for (int i = 0; i < seqs.length; i++) {
			adminService.deleteNotice(Integer.parseInt(seqs[i]));
		}

		resp.getWriter()
				.println("<script>alert('게시물 삭제에 성공하였습니다.'); location.href='admin_noitceList.do?page=1'; </script>");
		resp.getWriter().flush();
		resp.getWriter().close();
	}

	@GetMapping(value = "admin_notice_detail.do")
	public String admin_notice_detail(@RequestParam("seq") int seq, Model model) {
		Map<String, Object> notice = new HashMap<String, Object>();
		NoticeDTO dto = new NoticeDTO();
		notice = noticeService.noticeDetail(seq);
		dto = (NoticeDTO) notice.get("notice");
		model.addAttribute("dto", dto);

		if (notice.get("fileList") != null) {
			List<NoticeSubDTO> fileList = new ArrayList<NoticeSubDTO>();
			fileList = (List<NoticeSubDTO>) notice.get("fileList");
			model.addAttribute("fileList", fileList);
		}
		model.addAttribute("doc_title", "공지사항");
		model.addAttribute("doc_sub_title", "공지사항 상세보기");
		model.addAttribute("InsertTitle", "SMS 관리자 공지사항 상세보기");
		return "admin_notice_detail";
	}

	@GetMapping(value = "admin_notice_update.do")
	public String admin_notice_update(@RequestParam("seq") int seq, Model model) {
		Map<String, Object> notice = new HashMap<String, Object>();
		NoticeDTO dto = new NoticeDTO();
		notice = noticeService.noticeDetail(seq);
		dto = (NoticeDTO) notice.get("notice");
		model.addAttribute("dto", dto);

		if (notice.get("fileList") != null) {
			List<NoticeSubDTO> fileList = new ArrayList<NoticeSubDTO>();
			fileList = (List<NoticeSubDTO>) notice.get("fileList");
			model.addAttribute("fileList", fileList);
		}
		model.addAttribute("doc_title", "공지사항");
		model.addAttribute("doc_sub_title", "공지사항 수정");
		model.addAttribute("InsertTitle", "SMS 관리자 공지사항 수정");
		return "admin_notice_update";
	}

	@PostMapping("/admin_notice_updateAf.do")
	public void notice_update(MultipartHttpServletRequest mtfReq, NoticeDTO notice, String seq, String seqDel,
			HttpServletResponse resp) throws Exception {
		resp.setContentType("text/html;charset=utf-8");
		if (seqDel != null && !seqDel.equals("")) { // 삭제 할 파일이 있을경우
			seqDel += ",";
			int count = StringUtils.countMatches(seqDel, ",");

			for (int i = 0; i < count; i++) {
				adminService.notice_file_del(Integer.parseInt(seqDel.split(",")[i]));
			}
		}

		int file_count = adminService.notice_file_account(Integer.parseInt(seq));

		List<MultipartFile> fileList = new ArrayList<MultipartFile>();
		fileList = mtfReq.getFiles("file");

		if (fileList == null || fileList.size() == 0) { // 업로드 파일이 없을경우
			System.out.println("파일 없는곳 들어옴");
			if (file_count == 0)
				notice.setFile_on("N");
			adminService.notice_update(notice, null);
		} else { // 업로드 파일이 있을경우
			System.out.println("파일 있는곳 들어옴");
			for (MultipartFile multipartFile : fileList) {
				/* System.out.println(multipartFile.getOriginalFilename()); */
			}
			notice.setFile_on("Y");
			adminService.notice_update(notice, fileList);
		}

		resp.getWriter()
				.println("<script>alert('게시물 작성에 성공하였습니다.'); location.href='admin_noitceList.do?page=1'; </script>");
		resp.getWriter().flush();
		resp.getWriter().close();
	}

	@PostMapping(value = "imgUpload.do")
	public void imgUpload(HttpServletRequest req, HttpServletResponse resp, @RequestParam MultipartFile upload) {

		OutputStream out = null;
		PrintWriter printWriter = null;

		resp.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");

		String fileName = System.currentTimeMillis() + upload.getOriginalFilename();
		/* System.out.println("filename : " +fileName); */

		// upload 경로설정 .. tomcat 경로
		String uploadPath = req.getServletContext().getRealPath("uploadImg");
		// String uploadPath = "D:\\tmp";
		/* System.out.println("uploadPath : " + uploadPath); */

		// 파일 업로드 할때에는 경로와 파일 네임을 같이 올린다..
		byte[] bytes;
		try {
			bytes = upload.getBytes();
			out = new FileOutputStream(new File(uploadPath + "\\" + fileName));
			out.write(bytes);

			String callback = req.getParameter("CKEditorFuncNum");

			printWriter = resp.getWriter();
			// String fileUrl = request.getServletContext().getRealPath("upload") + "\\"+
			// fileName;
			String fileUrl = "/uploadImg/" + fileName;

			// System.out.println("fileUrl : " + fileUrl);

			printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction(" + callback
					+ ",'" + fileUrl + "','이미지를 업로드 하였습니다.'" + ")</script>");
			// System.out.println("collback : " + callback );
			printWriter.flush();

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
		}
	}

	@GetMapping(value = "admin_memberList.do")
	public String admin_memberList(Model model, SearchUtillDto dto, @RequestParam("page") int page) {
		dto.setPage(page);
		int count = 0;
		count = adminService.memberTotalCount(dto);

		List<MemberDTO> list = new ArrayList<>();
		list = adminService.getMemberList(dto);

		PagingUtillDto pDto = new PagingUtillDto();
		pDto = PagingUtill.getPageCount(count, dto.getPage());

		model.addAttribute("totalCount", count);
		model.addAttribute("pDto", pDto);
		model.addAttribute("search", dto);
		model.addAttribute("list", list);
		model.addAttribute("doc_title", "회원관리");
		model.addAttribute("doc_sub_title", "회원목록 리스트");
		model.addAttribute("InsertTitle", "SMS 관리자 회원관리");
		return "admin_member_list";
	}
	
	@GetMapping(value = "admin_member_delete.do")
	public void admin_member_delete(@RequestParam("ids")String ids[],HttpServletResponse resp)throws Exception {
		resp.setContentType("text/html;charset=utf-8");
		adminService.deleteMember(ids);
		resp.getWriter()
		.println("<script>alert('회원정보 삭제에 성공하였습니다.'); location.href='admin_memberList.do?page=1'; </script>");
		resp.getWriter().flush();
		resp.getWriter().close();
	}
	@GetMapping(value = "admin_member_detail.do")
	public String admin_member_detail(@RequestParam("id") String id, Model model) {
		MemberDTO member = new MemberDTO();
		member = adminService.memberDetail(id);

		model.addAttribute("member", member);
		model.addAttribute("doc_title", "회원관리");
		model.addAttribute("doc_sub_title", "회원정보 상세보기");
		model.addAttribute("InsertTitle", "SMS 관리자 회원 상세보기");
		return "admin_member_detail";
	}

	@GetMapping(value = "admin_exchange_list.do")
	public String admin_exchange_list(Model model, @RequestParam("page") int page, SearchUtill_ExchangeDto dto) {
		/* System.out.println("admin_exchange_list 들어왔슴니다"); */
		dto.setPage(page);
		int count = 0;
		count = adminService.exchangeListCount(dto);
		/* System.out.println("admin_exchange_list:"+dto.toString()); */
		List<ExchangeDTO> list = new ArrayList<ExchangeDTO>();
		list = adminService.exchangeList(dto);

		PagingUtillDto pDto = new PagingUtillDto();
		pDto = PagingUtill.getPageCount(count, dto.getPage());

		model.addAttribute("doc_title", "회원관리");
		model.addAttribute("doc_sub_title", "환전신청");
		model.addAttribute("totalCount", count);
		model.addAttribute("pDto", pDto);
		model.addAttribute("search", dto);
		model.addAttribute("list", list);

		model.addAttribute("InsertTitle", "SMS 관리자 환전신청관리");

		return "admin_exchange_list";
	}

	@GetMapping(value = "admin_exchange_detail.do")
	public String admin_exchange_detail(Model model, @RequestParam("seq") int seq) {
		ExchangeDTO exchangeDetail = new ExchangeDTO();
		exchangeDetail = adminService.exchangeDetail(seq);

		model.addAttribute("doc_title", "회원관리");
		model.addAttribute("doc_sub_title", "환전신청 상세보기");
		model.addAttribute("exchangeDetail", exchangeDetail);

		model.addAttribute("InsertTitle", "SMS 관리자 환전 상세보기");
		return "admin_exchange_detail";
	}

	@GetMapping(value = "admin_exchange_update.do")
	public String admin_exchange_update(@RequestParam("seq") int seq) {
		adminService.exchangeUpdate(seq);

		return "redirect:/admin/admin_exchange_list.do?page=1";
	}
	@GetMapping(value = "admin_game_list.do")
	public String admin_game_list(Model model,@RequestParam("page")int page,SearchUtillDto dto) {
		dto.setPage(page);
		//System.out.println("admin_game_list.do dto:"+dto.toString()); 
		int count = 0;
		count = adminService.gameListCount(dto);
		//System.out.println("admin_game_list.do count:"+count); 		
		List<GameDTO> list = new ArrayList<GameDTO>();
		list = adminService.gameList(dto);
		PagingUtillDto pDto = new PagingUtillDto();
		pDto = PagingUtill.getPageCount(count, dto.getPage());
		model.addAttribute("totalCount", count);
		model.addAttribute("doc_title", "경기 관리");
		model.addAttribute("pDto", pDto);
		model.addAttribute("search", dto);
		model.addAttribute("list", list);
		model.addAttribute("doc_sub_title", "경기 일정");
		
		model.addAttribute("InsertTitle", "SMS 관리자 경기 일정");
		return "admin_game_list";
	}

	@GetMapping(value = "admin_game_detail.do")
	public String admin_game_detail(Model model,@RequestParam("game_seq")int seq) {
		GameDTO gameDetail =  new GameDTO();
		gameDetail =  adminService.gameDetail(seq);
		//log.info("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! gameDetail:"+gameDetail.toString());
		model.addAttribute("doc_title","경기 관리");
		model.addAttribute("doc_sub_title", "경기일정 상세보기");
		model.addAttribute("gameDetail", gameDetail);
		
		model.addAttribute("InsertTitle", "SMS 관리자 경기 일정 상세보기");
		return "admin_game_detail";
	}
	
	@GetMapping(value = "admin_chart_money.do")
	public String admin_chart(Model model) {
		List<Integer> yearProfit = new ArrayList<Integer>();
		List<Integer> yearSpend = new ArrayList<Integer>();
		List<Integer> yPminusyS = new ArrayList<Integer>();
		yearProfit = adminService.yearProfitMoney(month); //월별 소득(통계용)
		yearSpend = adminService.yearSpendMoney(month);	  //월별 지출(통계용)
		for (int i = 0; i < yearProfit.size(); i++) { // 월별 소득-지출 (통계용)
			if(yearProfit.get(i)==null && yearSpend.get(i)==null) {
				yPminusyS.add(null); 
			}
			else if(yearProfit.get(i)!=null && yearSpend.get(i)==null) {
				yPminusyS.add(yearProfit.get(i)); 
			}
			else if(yearProfit.get(i)==null && yearSpend.get(i)!=null) {
				yPminusyS.add(yearSpend.get(i)*(-1)); 
			}
			else {
				yPminusyS.add(yearProfit.get(i)-yearSpend.get(i));
			}
		}
		
		model.addAttribute("doc_title","소득 통계");
		model.addAttribute("doc_sub_title", "연간 소득 통계");
		model.addAttribute("yPminusyS", yPminusyS);
		model.addAttribute("yearProfit",yearProfit);
		model.addAttribute("yearSpend",yearSpend);
		
		model.addAttribute("InsertTitle", "SMS 관리자 연간 소득통계");
		return "admin_chart_money";
	}
	
	
	@GetMapping(value = "admin_chart_monthly_money.do")
	public String admin_chart_monthly_money(Model model,@RequestParam("month")String month) {
		/* log.info("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!month:"+month); */
		Calendar cal = Calendar.getInstance();
		/* log.info("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!이번년도:"+cal.get(Calendar.YEAR)); */
		cal.set(cal.get(Calendar.YEAR), Integer.parseInt(month)-1, 1); 
		//log.info("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!maximumday:"+cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		String month_day[] = new String[cal.getActualMaximum(Calendar.DAY_OF_MONTH)];
		for (int i = 1; i <= month_day.length; i++) {
			String day ="";
			if(i<10) {
				day = "0"+i;
			}
			else {
				day = i+"";
			}
			month_day[i-1] = month+"/"+day;
		}
		Map<String , List<Integer>> monthMap = new HashMap<String, List<Integer>>();
		monthMap = adminService.monthly_day(month_day);
		
		model.addAttribute("doc_title","소득 통계");
		model.addAttribute("doc_sub_title", "월간 소득 통계");		
		model.addAttribute("monthMap", monthMap);
		model.addAttribute("month_day", month_day);
		
		model.addAttribute("InsertTitle", "SMS 관리자 월간 소득통계");
		return "admin_chart_monthly_money";
	}
	
	@GetMapping(value = "admin_chart_category.do")
	public String admin_chart_category(Model model) {
		GameDTO dto = new GameDTO();
		Map<String, List<Integer>>monthlyFavoriteSports = new HashMap<String, List<Integer>>();
		monthlyFavoriteSports = adminService.monthlyFavoriteSports(dto);
		
				
		model.addAttribute("monthlyFavoriteSports", monthlyFavoriteSports);
		model.addAttribute("doc_title","종목 통계");
		model.addAttribute("doc_sub_title", "월간 선호 종목");
		
		model.addAttribute("InsertTitle", "SMS 관리자 월간 선호 종목");
		return "admin_chart_category";
	}
	
	@GetMapping(value = "admin_chart_score.do")
	public String admin_chart_ranking(Model model) {
		Map<String, SportsScoreDto> sportsScore =  new HashMap<String, SportsScoreDto>();
		sportsScore = adminService.sportsScore();
		System.out.println(sportsScore.get("soccer").toString());
		
		
		model.addAttribute("sportsScore", sportsScore);
		model.addAttribute("doc_title","종목 통계");
		model.addAttribute("doc_sub_title", "종목별 점수");	
		
		model.addAttribute("InsertTitle", "SMS 관리자 종목별 점수");
		return "admin_chart_score";		
	}
	
	@GetMapping(value = "admin_chart_stadiumCount.do")
	public String admin_chart_stadiumCount(Model model,@RequestParam("month")String month) {
		System.out.println("admin_chart_stadiumCount 들어옴");
		Map<String, List<GameDTO>> monthlyStadiumCount = new HashMap<String, List<GameDTO>>();
		LocationStadiumDto dto = new LocationStadiumDto();
		String ym = "2019-"+month;
		dto.setMonth(ym);
		System.out.println("admin_chart_stadiumCount dto:"+dto.toString());
		monthlyStadiumCount = adminService.monthlyStadiumCount(dto);
		System.out.println("admin_chart_stadiumCount monthlyStadiumCount:"+monthlyStadiumCount.size());
		model.addAttribute("selectMonth", month);
		model.addAttribute("monthlyStadiumCount", monthlyStadiumCount);
		model.addAttribute("doc_title","경기장 통계");
		model.addAttribute("doc_sub_title", "월간 이용 현황");
		
		model.addAttribute("InsertTitle", "SMS 관리자 월간 경기장 이용 현황");
		return "admin_chart_stadiumCount";		
	}

	//일우꺼어어어 끝/////////////////////////////////////////////////////////////


	// 민호꺼
	// 민호 4차이후 추가
		@PostMapping("AdminBbsReportReply.do")
		public String AdminBbsReportReply(HttpServletRequest req) throws Exception {

			log.info("AdminController AdminBbsReportReply()" + new Date());

			String id = req.getParameter("user_id");
			String seq = req.getParameter("bbs_seq");

			String[] Schildcheck = req.getParameterValues("childcheck");
			int[] childcheck = new int[Schildcheck.length];
			for (int i = 0; i < childcheck.length; i++) {
				System.out.println("시퀀스 : " + Schildcheck[i]);
				teamBbsSerivce.DeleteMemberReportCount(id);
				teamBbsSerivce.DeleteBbsReportCount(Integer.parseInt(seq));
				teamBbsSerivce.DeleteBbsReport(Integer.parseInt(Schildcheck[i]));
			}
			return "redirect:/admin/AdminTeamBbsReportContent.do?seq=" + seq;

		}

		// 민호 4차이후 추가
		@PostMapping("AdminBbsCommentReportReply.do")
		public String AdminBbsCommentReportReply(HttpServletRequest req) throws Exception {

			log.info("AdminController AdminBbsCommentReportReply()" + new Date());

			String id = req.getParameter("commentid");
			String commentseq = req.getParameter("commentseq");

			String[] Schildcheck = req.getParameterValues("childcheck");
			int[] childcheck = new int[Schildcheck.length];
			for (int i = 0; i < childcheck.length; i++) {
				// System.out.println("신고글에 대한 시퀀스 : " + Schildcheck[i]);
				// System.out.println("댓글에 대한 시퀀스 : " + commentseq);
				// System.out.println("댓글에 대한 아이디 : " + id);
				teamBbsSerivce.DeleteMemberReportCount(id);
				teamBbsSerivce.DeleteBbsCommentReportCount(Integer.parseInt(commentseq));
				teamBbsSerivce.DeleteBbsCommentReport(Integer.parseInt(Schildcheck[i]));
			}
			return "redirect:/admin/AdminTeamBbsCommentReportContent.do?seq=" + commentseq;
		}

		// 민호 4차이후 추가
		@PostMapping("AdminTeamReportReply.do")
		public String AdminTeamReportReply(HttpServletRequest req) throws Exception {

			log.info("AdminController AdminTeamReportReply()" + new Date());

			String team_name = req.getParameter("team_name");

			String[] Schildcheck = req.getParameterValues("childcheck");
			int[] childcheck = new int[Schildcheck.length];
			for (int i = 0; i < childcheck.length; i++) {
			//	System.out.println("신고글에 대한 시퀀스 : " + Schildcheck[i]);
			//	System.out.println("신고 당한 팀 이름 : " + team_name);
				teamBbsSerivce.DeleteTeamReport(Integer.parseInt(Schildcheck[i]));
				teamBbsSerivce.DeleteTeamReportCount(team_name);
			}
			return "redirect:/admin/AdminTeamReportContent.do?team_name=" + URLEncoder.encode(team_name, "UTF-8");
		}

	@GetMapping("admin_bbs.do")
	public String admin_bbs(Model model, TeamBBSParam param) throws Exception {
		log.info("AdminController admin_bbs()" + new Date());
		// paging
		int sn = param.getPageNumber(); // 현재 페이지 번호 ex) 0, 1, 2
		int start = sn * param.getRecordCountPerPage() + 1;
		int end = (sn + 1) * param.getRecordCountPerPage();

		param.setStart(start);
		param.setEnd(end);

		List<TeamBBSDTO> bbsList = teamBbsSerivce.allBbsList(param);
		// System.out.println("list의 갯수는 : " + bbsList.size());

		for (TeamBBSDTO teamBBSDTO : bbsList) {
			String date = utilMethod.dateEdit(teamBBSDTO.getWdate());
			teamBBSDTO.setWdate(date);
		}

		int totalRecordCount = teamBbsSerivce.getBbsCount(param);

		System.out.println("totalRecordCount : " + totalRecordCount);

		model.addAttribute("bbsList", bbsList);
		model.addAttribute("doc_title", "팀 게시판 관리");
		model.addAttribute("doc_sub_title", "팀 게시판 리스트");
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);
		model.addAttribute("recordCountPerPage", param.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("s_keyword", param.getS_keyword());
		model.addAttribute("s_category", param.getS_category());

		model.addAttribute("InsertTitle", "SMS 관리자 팀게시판");

		return "admin_bbs_list.tiles";
	}

	@PostMapping("DeleteTeamBbs.do")
	public String DeleteTeamBbs(HttpServletRequest req) throws Exception {

		log.info("AdminController DeleteTeamBbs()" + new Date());

		String[] Schildcheck = req.getParameterValues("childcheck");
		int[] childcheck = new int[Schildcheck.length];
		for (int i = 0; i < childcheck.length; i++) {
			childcheck[i] = Integer.parseInt(Schildcheck[i]);
			System.out.println("거래게시판 시퀀스 : " + childcheck[i]);

			boolean a = teamBbsSerivce.BbsDelete(childcheck[i]);
			if (a) {
				teamBbsSerivce.AdminCommentDelete(childcheck[i]);
				// System.out.println("관리자 게시글 및 댓글 삭제 성공");
			}
		}
		return "redirect:/admin/admin_bbs.do";
	}

	@GetMapping("AdminteamBbsdetail.do")
	public String AdminteamBbsdetail(@RequestParam(value = "seq") int seq, Model model) throws Exception {

		log.info("AdminController AdminteamBbsdetail()" + new Date());
		System.out.println("seq : " + seq);

		TeamBBSDTO teamVo = teamBbsSerivce.BbsDetail(seq);
		List<TeamBBSCommentDTO> CommentList = tbs.getTeamBbsComment(seq);

		for (TeamBBSCommentDTO teamBBSCommentDTO : CommentList) {
			String date = utilMethod.dateEdit(teamBBSCommentDTO.getWdate());
			teamBBSCommentDTO.setWdate(date);
		}

		model.addAttribute("teamVo", teamVo);
		model.addAttribute("bbscommentdto", CommentList);
		model.addAttribute("doc_title", "팀 게시판 관리");
		model.addAttribute("doc_sub_title", "팀 게시판 상세글");

		model.addAttribute("InsertTitle", "SMS 관리자 팀 게시판 상세글");

		return "admin_bbs_detail.tiles";
	}

	// 민호 4차이후 변경
	@GetMapping("AdminTeamBbsReportContent.do")
	public String AdminTeamBbsReportContent(Model model, @RequestParam(value = "seq") int seq) throws Exception {
		log.info("AdminController AdminTeamBbsReportContent()" + new Date());
		// System.out.println("시퀀스 : " +seq);

		List<ReportBBSDTO> Rlist = teamBbsSerivce.GetReportList(seq);
		TeamBBSDTO teamVo = teamBbsSerivce.BbsDetail(seq);
		
		model.addAttribute("InsertTitle", "SMS 관리자 팀 게시판 신고 리스트");
		model.addAttribute("doc_title", "팀 게시판 관리");
		model.addAttribute("doc_sub_title", "게시글 신고 내역");
		model.addAttribute("reportlist", Rlist);
		model.addAttribute("teamVo", teamVo);
		model.addAttribute("bbsseq", seq);
		return "admin_bbs_report.tiles";
	}

	// 민호 4차이후 변경
	@GetMapping("AdminTeamBbsCommentReportContent.do")
	public String AdminTeamBbsCommentReportContent(Model model, @RequestParam(value = "seq") int seq) throws Exception {
		log.info("AdminController AdminTeamBbsReportContent()" + new Date());

		System.out.println("시퀀스 : " + seq);

		List<ReportCommentDTO> CRlist = tbs.getCommentReportList(seq);
		String id = tbs.CommentWriteGetId(seq);

		model.addAttribute("InsertTitle", "SMS 관리자 팀 게시판 댓글 신고 리스트");
		model.addAttribute("doc_title", "팀 게시판 관리");
		model.addAttribute("doc_sub_title", "댓글 신고 내역");
		model.addAttribute("commentreportlist", CRlist);
		model.addAttribute("commentSeq", seq);
		model.addAttribute("commentId", id);

		return "admin_bbs_comment_report.tiles";
	}

	@GetMapping("DeleteTeamBbsComment.do")
	public String DeleteTeamBbsComment(HttpServletRequest req) throws Exception {

		log.info("AdminController DeleteTeamBbsComment()" + new Date());

		String[] Schildcheck = req.getParameterValues("childcheck");
		int[] childcheck = new int[Schildcheck.length];

		for (int i = 0; i < childcheck.length; i++) {
			childcheck[i] = Integer.parseInt(Schildcheck[i]);
			System.out.println("댓글 시퀀스 번호 : " + childcheck[i]);
			tbs.TeamBbsCommentDelete(childcheck[i]);
		}
		return "redirect:/admin/admin_bbs.do";
	}

	// TeamList 시작

	@GetMapping("admin_team.do")
	public String admin_team(Model model, TeamDetailParam teamdetailparam) {

		log.info("AdminController DeleteTeamBbsComment()" + new Date());

		System.out.println("teamdetaildto : " + teamdetailparam);

		int sn = teamdetailparam.getPageNumber();
		int start = sn * teamdetailparam.getRecordCountPerPage() + 1;
		int end = (sn + 1) * teamdetailparam.getRecordCountPerPage();

		teamdetailparam.setStart(start);
		teamdetailparam.setEnd(end);

		List<TeamDetailDTO> teamlist = teamBbsSerivce.teamlist(teamdetailparam);

		int totalRecordCount = teamBbsSerivce.teamlistCount();
		model.addAttribute("doc_title", "팀 관리");
		model.addAttribute("doc_sub_title", "팀 리스트");
		model.addAttribute("teamlist", teamlist);
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);
		model.addAttribute("recordCountPerPage", teamdetailparam.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("s_keyword", teamdetailparam.getS_keyword());
		model.addAttribute("s_category", teamdetailparam.getS_category());

		model.addAttribute("InsertTitle", "SMS 관리자 팀 리스트");

		return "admin_team_list.tiles";
	}

	@PostMapping("AdminTeamDelete.do")
	public void AdminTeamDelete(HttpServletRequest req, HttpServletResponse resp) throws Exception {

		log.info("AdminController DeleteTeamBbsComment()" + new Date());

		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		int count = 0;
		String[] Schildchkeck = req.getParameterValues("childcheck");
		boolean a = false;
		for (int i = 0; i < Schildchkeck.length; i++) {
			System.out.println(Schildchkeck[i]);
			count = teamService.tdel_check(Schildchkeck[i]);
			if (count > 0) {
				a = true;
				break;
			}
		}
		if(a) {
			out.println("<script>alert('남아있는 경기일정이 있습니다.'); location.href='admin_team.do';</script>");
			out.flush();
		}else {
			for (int i = 0; i < Schildchkeck.length; i++) {
				teamService.tdel_all(Schildchkeck[i]);
				out.println("<script>location.href='admin_team.do';</script>");
				out.flush();
			}
		}
		
	}

	@GetMapping("Adminteamdetail.do")
	public String Adminteamdetail(Model model, TeamDetailDTO teamdetaildto, Principal pcp) {

		log.info("AdminController Adminteamdetail()" + new Date());
		// System.out.println("team_name : " + teamdetaildto.toString());

		TeamDetailDTO teamdetail = teamService.teamdetail(teamdetaildto);
		List<TeamApplicationDTO> memappstate = teamService.memappstate(teamdetaildto);
		int memcount = teamService.memcount(teamdetaildto);
		log.info("====" + memcount);

		String id = pcp.getName();
		MemberDTO mem = teamService.getMemberById(id);
		AuthoritiesDTO auth = teamService.getAuth(id);

		model.addAttribute("doc_title", "팀 관리");
		model.addAttribute("teamdetail", teamdetail);
		model.addAttribute("memapplist", memappstate);
		model.addAttribute("memcount", memcount);
		model.addAttribute("mem", mem);
		model.addAttribute("auth", auth);
		model.addAttribute("doc_sub_title", "팀 상세내용");

		model.addAttribute("InsertTitle", "SMS 관리자 팀 상세내용");

		return "admin_team_detail.tiles";
	}

	// 민호 팀 신고 수정
	@RequestMapping(value = "AdminTeamReportContent.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String AdminTeamReportContent(Model model, @RequestParam(value = "team_name")String team_name) {

		log.info("AdminController AdminTeamReportContent()" + new Date());
		List<ReportTeamDTO> reportteamList = teamService.GetTeamReportList(team_name);
		model.addAttribute("reportlist", reportteamList);
		
		model.addAttribute("InsertTitle", "SMS 관리자 팀 신고 리스트");
		model.addAttribute("doc_title", "팀 관리");
		model.addAttribute("doc_sub_title", "팀 신고 내역");
		model.addAttribute("team_name", team_name);
		return "admin_team_report.tiles";
	}

	@RequestMapping(value = "adminMMRRankList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MMRRankList(Model model, MMRRankingDTO mdto, HttpServletRequest req) {
		log.info("AdminController adminMMRRankList");

		model.addAttribute("doc_title", "팀 랭킹");
		model.addAttribute("doc_sub_title", "팀 랭킹 현황");

		model.addAttribute("InsertTitle", "SMS 관리자 팀 랭킹");
		return "adminMMRRankList.tiles";
	}

	@RequestMapping(value = "MMRRankList1.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MMRRankList1(Model model, MMRRankingDTO mdto, HttpServletRequest req) {
		log.info("AdminController MMRRankList1");

		// MMR RANKING
		List<MMRRankingDTO> mlist1 = bettingService.getSoccerRank(mdto);

		// TEAM_DETAIL 갯수
		int count = bettingService.getRankCount(mdto);

		MMRRankingDTO dto = new MMRRankingDTO();
		dto.setPageNum(mdto.getPageNum());
		dto.setTotalCount(count);
		dto.setKeyword(mdto.getKeyword());

		log.info("MMRRankList1 dto : " + dto.toString());
		log.info("MMRRankList1 count : " + count);

		model.addAttribute("ranklist1", mlist1);

		model.addAttribute("count", count);
		model.addAttribute("gparam", dto);

		return "/admin/rank/MMRRankList1";
	}

	@RequestMapping(value = "MMRRankList2.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MMRRankList2(Model model, MMRRankingDTO mdto, HttpServletRequest req) {
		log.info("AdminController MMRRankList2");

		// MMR RANKING
		List<MMRRankingDTO> mlist2 = bettingService.getBasketballRank(mdto);

		// TEAM_DETAIL 갯수
		int count = bettingService.getRankCount(mdto);

		MMRRankingDTO dto = new MMRRankingDTO();
		dto.setPageNum(mdto.getPageNum());
		dto.setTotalCount(count);
		dto.setKeyword(mdto.getKeyword());

		log.info("MMRRankList2 dto : " + dto.toString());
		log.info("MMRRankList2 count : " + count);

		model.addAttribute("ranklist2", mlist2);

		model.addAttribute("count", count);
		model.addAttribute("gparam", dto);

		return "/admin/rank/MMRRankList2";
	}

	@RequestMapping(value = "MMRRankList3.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MMRRankList3(Model model, MMRRankingDTO mdto, HttpServletRequest req) {
		log.info("AdminController MMRRankList3");

		// MMR RANKING
		List<MMRRankingDTO> mlist3 = bettingService.getBaseballRank(mdto);

		// TEAM_DETAIL 갯수
		int count = bettingService.getRankCount(mdto);

		MMRRankingDTO dto = new MMRRankingDTO();
		dto.setPageNum(mdto.getPageNum());
		dto.setTotalCount(count);
		dto.setKeyword(mdto.getKeyword());

		log.info("MMRRankList3 dto : " + dto.toString());
		log.info("MMRRankList3 count : " + count);

		model.addAttribute("ranklist3", mlist3);

		model.addAttribute("count", count);
		model.addAttribute("gparam", dto);

		return "/admin/rank/MMRRankList3";
	}

	@RequestMapping(value = "MMRRankList4.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MMRRankList4(Model model, MMRRankingDTO mdto, HttpServletRequest req) {
		log.info("AdminController MMRRankList4");

		// MMR RANKING
		List<MMRRankingDTO> mlist4 = bettingService.getBadmintonRank(mdto);

		// TEAM_DETAIL 갯수
		int count = bettingService.getRankCount(mdto);

		MMRRankingDTO dto = new MMRRankingDTO();
		dto.setPageNum(mdto.getPageNum());
		dto.setTotalCount(count);
		dto.setKeyword(mdto.getKeyword());

		log.info("MMRRankList4 dto : " + dto.toString());
		log.info("MMRRankList4 count : " + count);

		model.addAttribute("ranklist4", mlist4);

		model.addAttribute("count", count);
		model.addAttribute("gparam", dto);

		return "/admin/rank/MMRRankList4";
	}

	@RequestMapping(value = "MMRRankList5.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MMRRankList5(Model model, MMRRankingDTO mdto, HttpServletRequest req) {
		log.info("AdminController MMRRankList5");

		// MMR RANKING
		List<MMRRankingDTO> mlist5 = bettingService.getPingpongRank(mdto);

		// TEAM_DETAIL 갯수
		int count = bettingService.getRankCount(mdto);

		MMRRankingDTO dto = new MMRRankingDTO();
		dto.setPageNum(mdto.getPageNum());
		dto.setTotalCount(count);
		dto.setKeyword(mdto.getKeyword());

		log.info("MMRRankList5 dto : " + dto.toString());
		log.info("MMRRankList5 count : " + count);

		model.addAttribute("ranklist5", mlist5);

		model.addAttribute("count", count);
		model.addAttribute("gparam", dto);

		return "/admin/rank/MMRRankList5";
	}

	@RequestMapping(value = "MMRRankList6.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String MMRRankList6(Model model, MMRRankingDTO mdto, HttpServletRequest req) {
		log.info("AdminController MMRRankList6");

		// MMR RANKING
		List<MMRRankingDTO> mlist6 = bettingService.getAllRank(mdto);

		// TEAM_DETAIL 갯수
		int count = bettingService.getRankCount(mdto);

		MMRRankingDTO dto = new MMRRankingDTO();
		dto.setPageNum(mdto.getPageNum());
		dto.setTotalCount(count);
		dto.setKeyword(mdto.getKeyword());

		log.info("MMRRankList6 dto : " + dto.toString());
		log.info("MMRRankList6 count : " + count);

		model.addAttribute("ranklist6", mlist6);
		model.addAttribute("count", count);
		model.addAttribute("gparam", dto);

		return "/admin/rank/AllMMRankList6";
	}

	/////////////////////////////////////////////////////// 민호꺼 끝부분

	// 지현누나꺼
	@RequestMapping(value = "gameResultAdmin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String gameResultAdmin(Model model, GameParams gparam, HttpServletRequest req) {
		log.info("AdminController gameResultAdmin");

		// 검색 결과를 포함한 총 글 List
		List<GameDTO> glist = bettingService.getResultAdminList(gparam);

		// 검색 결과를 포함한 총 글의 갯수
		int count = bettingService.getResultAdminCount(gparam);

		GameParams gp = new GameParams();
		gp.setPageNum(gparam.getPageNum());
		gp.setTotalCount(count);
		gp.setChoice(gparam.getChoice());
		gp.setKeyword(gparam.getKeyword());
		gp.setSorting(gparam.getSorting());

		log.info("Admin RESULT gp : " + gp.toString());
		log.info("Admin RESULT count : " + count);

		model.addAttribute("gamelist", glist);
		model.addAttribute("count", count);
		model.addAttribute("gparam", gp);
		model.addAttribute("doc_title", "경기관리");
		model.addAttribute("doc_sub_title", "경기결과등록");

		model.addAttribute("InsertTitle", "SMS 관리자 경기관리");

		return "gameResultAdmin.tiles";
	}

	@RequestMapping(value = "gameResultAdminAf.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String gameResultAdmin(Model model, GameDTO game, HttpServletRequest req) {
		log.info("AdminController gameResultAdminAf ----------------------------------------------------------------");

		log.info(game.toString());

		// 최종 배당률 payout_r1, payout_r2 계산해서 DB에 입력
		// 1. team1, team2 betting money
		int betmoney1 = bettingService.getBettingMoney1(game);
		int betmoney2 = bettingService.getBettingMoney2(game);

		// 2. 각 팀의 배당률 구하기 - 소수점 둘째 자리 반올림
		double payout_r1 = 0.00;
		double payout_r2 = 0.00;

		if (betmoney1 == 0) {
			payout_r1 = 0.00;
		} else {
			payout_r1 = Math.round(((betmoney1 + betmoney2) / (double) betmoney1) * 100) / 100.0;
		}

		if (betmoney2 == 0) {
			payout_r2 = 0.00;
		} else {
			payout_r2 = Math.round(((betmoney1 + betmoney2) / (double) betmoney2) * 100) / 100.0;
		}

		game.setPayout_r1(payout_r1);
		game.setPayout_r2(payout_r2);

		log.info("AdminAf payout_r1:" + payout_r1 + " payout_r2:" + payout_r2);
		log.info("AdminAf : " + game.toString());

		// 3. DB에 입력
		bettingService.resultAdmin(game);

		// 각 팀의 승률을 반영하여 MMR 조정
		// 1. team1, team2 MMR
		int mmr1 = bettingService.getMMR1(game);
		int mmr2 = bettingService.getMMR2(game);
		log.info("원래 mmr1:" + mmr1 + " mmr2:" + mmr2);

		// 2. 승률 구하기
		double win_rate1 = Math.round((mmr1 / (double) (mmr1 + mmr2)) * 100) / 100.0;
		double win_rate2 = Math.round((mmr2 / (double) (mmr1 + mmr2)) * 100) / 100.0;
		log.info("승률1:" + win_rate1 + " 승률2:" + win_rate2);

		// 3. 변경할 MMR 계산
		if (game.getGame_result().equals(game.getName_team1())) { // team1이 승리
			mmr1 = (int) (mmr1 + 20 * (1 - (double) win_rate1));
			mmr2 = (int) (mmr2 + 20 * (0 - (double) win_rate2));
			if (mmr2 < 0) {
				mmr2 = 0;
			}
		} else { // team2가 승리
			mmr1 = (int) (mmr1 + 20 * (0 - (double) win_rate1));
			mmr2 = (int) (mmr2 + 20 * (1 - (double) win_rate2));
			if (mmr1 < 0) {
				mmr1 = 0;
			}
		}
		log.info("바뀐 mmr1:" + mmr1 + " mmr2:" + mmr2);
		game.setMmr1(mmr1);
		game.setMmr2(mmr2);

		// 4. DB에 입력
		bettingService.changeMMR(game);

		// betting Money 정산
		bettingService.payBetting(game);

		// 동욱꺼 리그 뒷처리... (상의해주세요)...
		if (game.getLeague() != null) {
			if (game.getLeague().equals("") == false) {
				log.info("리그다!!!   ----------------------------------------------------------------");
				leagueService.LeagueResult(game);
			}
		}

		return "redirect:/admin/gameResultAdmin.do";
	}

	@RequestMapping(value = "AdminGameResultDetail.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String gameResultDetail(Model model, GameDTO game, HttpServletRequest req) {
		log.info("AdminController gameResultDetail");

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

		model.addAttribute("doc_title", "경기관리");
		model.addAttribute("doc_sub_title", "경기결과 상세보기");

		model.addAttribute("InsertTitle", "SMS 관리자 경기결과 상세보기");

		log.info("result dto : " + gdto.toString());

		return "admingameResultDetail.tiles";
	}
	
	@RequestMapping(value = "deleteGame.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteGame(Model model, BettingDTO bet, String team_name, HttpServletRequest req) {
		// betting 환불
		bettingService.refundBetting(bet);
		
		// 경기장 예약 환불
		BookingDTO bdto = gameService.backMoney(bet.getSeq_game());
		String id = bettingService.getLeader(team_name);
		
		MemberDTO mem = new MemberDTO(id, bdto.getPrice(), 0, bdto.getPoint(), 0);
		
		gameService.refund(mem);
		
		boolean game = gameService.deleteGame(bet.getSeq_game());
		boolean book = gameService.deleteBooking(bet.getSeq_game());
		
		return "redirect:/common/bettinglist.do";
	}

	/////////////////////////////////// 지현누나꺼 끝부분

}
