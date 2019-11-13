package com.boot.finalpro.teambbs.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.model.GameParam;
import com.boot.finalpro.game.service.GameService;
import com.boot.finalpro.member.model.AuthoritiesDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.member.service.MemberService;
import com.boot.finalpro.team.service.TeamService;
import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.teambbs.model.ReportBBSDTO;
import com.boot.finalpro.teambbs.model.SubDTO;
import com.boot.finalpro.teambbs.model.TeamBBSDTO;
import com.boot.finalpro.teambbs.model.TeamBBSParam;
import com.boot.finalpro.teambbs.service.TeamBbsService;
import com.boot.finalpro.teambbscomment.model.TeamBBSCommentDTO;
import com.boot.finalpro.teambbscomment.service.TeamBbsCommentService;
import com.boot.finalpro.util.FUpUtil;
import com.boot.finalpro.util.utilMethod;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value = "/member/*")
public class TeamBbsController {
	@Autowired
	TeamBbsService teamBbsSerivce;
	
	@Autowired
	TeamBbsCommentService tbcs;
	
	@Autowired
	GameService gameService;
	//5차 추가
	@Autowired
	MemberService memberservice;
	
	@RequestMapping(value="Bbswrite.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String Bbswrite(Model model, Principal pcp) throws Exception{
		
		String id = pcp.getName();
		
		String team_name = teamBbsSerivce.getTeamName(id);
		model.addAttribute("InsertTitle", "SMS 팀 게시판 글쓰기");
		model.addAttribute("team_name", team_name);
		
		return "TeamBbsWrite.tiles";
	}//5차 추가
	@RequestMapping(value="BbswriteAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void BbswriteAf(TeamBBSDTO teamBBSDTO, HttpServletResponse resp) throws Exception {
		
		log.info("TeamBbsController BbswriteAf()" + new Date());
		
		String team_name = teamBBSDTO.getTeam_name();
		if(team_name == null || team_name == "") {
			teamBBSDTO.setTeam_name("없음");
		}
		System.out.println("폼 : " +teamBBSDTO.toString());
		boolean insertBbs = teamBbsSerivce.BbsWrite(teamBBSDTO);
//		System.out.println(insertBbs);
		if(insertBbs) {
			memberservice.WritePointPlus(teamBBSDTO.getId());
			resp.setCharacterEncoding("utf-8");
			resp.setContentType("text/html; charset=utf-8");
			PrintWriter out = resp.getWriter();
			
			out.println("<script type='text/javascript'>alert('글 작성에 성공했습니다.'); "
					+ "location.href='../common/teamBbs.do'</script>" );
			out.flush();
		}else {	
		}
	}
	
	@RequestMapping(value="teamBbsdetail.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String BbsDetail(Model model, @RequestParam(value="seq")int seq, 
					OverlapDTO OverDto, Principal pcp) throws Exception{
	
		log.info("TeamBbsController BbswriteAf()" + new Date());
		
		TeamBBSDTO teamBBSDTO = teamBbsSerivce.BbsDetail(seq);
		List<TeamBBSCommentDTO> BbsCommentDto = tbcs.getTeamBbsComment(seq);
		
		for (TeamBBSCommentDTO teamBBSCommentDTO : BbsCommentDto) {
			String date = utilMethod.dateEdit(teamBBSCommentDTO.getWdate());
			teamBBSCommentDTO.setWdate(date);
			String replace = teamBBSCommentDTO.getContent();
			replace.replace("\n", "<br>");
			teamBBSCommentDTO.setContent(replace);
		}	
		
		String id = pcp.getName();
		OverDto.setSeq(seq);
		OverDto.setId(id);
		OverlapDTO dto = teamBbsSerivce.BbsViewsPickId(OverDto);
		OverlapDTO likedto = teamBbsSerivce.BbsLikePickId(OverDto);
		
		System.out.println("teamBbsDto : " + teamBBSDTO);
		//조회수 +1
		if(dto == null) {
		teamBbsSerivce.BbsViewsCount(OverDto);
		teamBbsSerivce.BbsReadCount(seq);
		}
		model.addAttribute("InsertTitle", "SMS 팀 게시판 상세내역");
		model.addAttribute("likedto", likedto);
		model.addAttribute("bbsdto", teamBBSDTO);
		model.addAttribute("bbscommentdto", BbsCommentDto);
		return "TeamBbsDetail.tiles";
	}
	//5차 추가
	@RequestMapping(value="teamBbsDelete.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void BbsDelete(HttpServletResponse resp ,@RequestParam(value="seq")int seq
			,@RequestParam(value="id")String id) throws Exception{
		log.info("TeamBbsController BbsDelete()" + new Date());
		
		boolean BbsDelete = teamBbsSerivce.BbsDelete(seq);
		System.out.println("아이디는 : " + id);
		if(BbsDelete) {
			memberservice.WritePointMinus(id);
			resp.setCharacterEncoding("utf-8");
			resp.setContentType("text/html; charset=utf-8");
			PrintWriter out = resp.getWriter();
			
			out.println("<script type='text/javascript'>alert('글 삭제 완료.'); "
					+ "location.href='../common/teamBbs.do'</script>" );
			out.flush();
		}
	}
	
	@GetMapping(value="Previous.do")
	   public void Previous(@RequestParam(value="seq")int seq, HttpServletResponse resp, Principal pcp) throws Exception{
	      
	      log.info("TeamBbsController Previous()" + new Date());
	      //System.out.println("seq번호 : " + seq);
	      
	      resp.setCharacterEncoding("utf-8");
	      resp.setContentType("text/html; charset=utf-8");
	      PrintWriter out;
	      
	      TeamBBSDTO dto = new TeamBBSDTO();
	      dto.setSeq(seq);
	      
	      String id = pcp.getName();
	      String team_name = teamBbsSerivce.getTeamName(id);
	      
	      dto.setTeam_name(team_name);
	      System.out.println("이전글 dto : " + dto.toString());
	      try {
	         out = resp.getWriter();
	         dto = teamBbsSerivce.Previous(dto);
	         int Preseq = dto.getSeq();
	         if(dto != null) {
	            out.println("<script type='text/javascript'>"
	                  + "location.href='teamBbsdetail.do?seq="+Preseq+"'</script>" );
	            out.flush();
	         }
	      } catch (Exception e) {
	         try {
	            out = resp.getWriter();
	            out.println("<script type='text/javascript'>alert('이전글이 없습니다.'); "
	                  + "location.href='teamBbsdetail.do?seq="+seq+"'</script>" );
	            out.flush();
	         } catch (IOException e1) {
	            e1.printStackTrace();
	         }

	      }
	   }

	
	   @GetMapping(value="Next.do")
	   public void Next(@RequestParam(value="seq")int seq, HttpServletResponse resp, Principal pcp) throws Exception{
	      log.info("TeamBbsController Next()" + new Date());
	      //System.out.println("seq번호 : " + seq);
	      
	      resp.setCharacterEncoding("utf-8");
	      resp.setContentType("text/html; charset=utf-8");
	      PrintWriter out;
	      
	      TeamBBSDTO dto = new TeamBBSDTO();
	      dto.setSeq(seq);
	      
	      String id = pcp.getName();
	      String team_name = teamBbsSerivce.getTeamName(id);
	      
	      dto.setTeam_name(team_name);
	      try {
	         out = resp.getWriter();
	         dto = teamBbsSerivce.Next(dto);
	         int Preseq = dto.getSeq();
	         if(dto != null) {
	            out.println("<script type='text/javascript'>"
	                  + "location.href='teamBbsdetail.do?seq="+Preseq+"'</script>" );
	            out.flush();
	         }
	      } catch (Exception e) {
	         try {
	            out = resp.getWriter();
	            out.println("<script type='text/javascript'>alert('다음글이 없습니다.'); "
	                  + "location.href='teamBbsdetail.do?seq="+seq+"'</script>" );
	            out.flush();
	         } catch (IOException e1) {
	            e1.printStackTrace();
	         }

	      }
	   }
	
	@RequestMapping(value="teamBbsUpdate.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String teamBbsUpdate(Model model ,@RequestParam(value="seq")int seq) throws Exception{
		log.info("TeamBbsController teamBbsUpdate()" + new Date());

		TeamBBSDTO teamBBSDTO = teamBbsSerivce.BbsDetail(seq);
		String s_category = teamBBSDTO.getSubject_category();
		model.addAttribute("InsertTitle", "SMS 팀 게시판 수정하기");
		model.addAttribute("dto", teamBBSDTO);
		model.addAttribute("s_category", s_category);
		
		return "TeamBbsUpdate.tiles";
	}
	
	@RequestMapping(value="teamBbsUpdateAf.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void teamBbsUpdateAf(TeamBBSDTO Bbsdto, HttpServletResponse resp) throws Exception{
		log.info("TeamBbsController teamBbsUpdateAf()" + new Date());
		
		boolean update = teamBbsSerivce.BbsUpdate(Bbsdto);
		
		if(update) {
			resp.setCharacterEncoding("utf-8");
			resp.setContentType("text/html; charset=utf-8");
			PrintWriter out = resp.getWriter();
			
			out.println("<script type='text/javascript'>alert('글 수정 완료.'); "
					+ "location.href='../common/teamBbs.do'</script>" );
			out.flush();
		}
	}
	
	@ResponseBody
	@RequestMapping(value="teamBbsLike.do", method = {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> teamBbsLike(HttpServletResponse resp, OverlapDTO Overdto) throws Exception{
		Map<String, Object> rmap = new HashMap<String, Object>();
		
		OverlapDTO dto = teamBbsSerivce.BbsLikePickId(Overdto);
		
		if(dto == null) {
			teamBbsSerivce.BbsLikeCount(Overdto);			//over db insert
			teamBbsSerivce.BbsLikeCount(Overdto.getSeq());	//like count ++
			TeamBBSDTO dtoLikeCount = teamBbsSerivce.BbsDetail(Overdto.getSeq());
			int count = dtoLikeCount.getLike_count();
			rmap.put("msg", "게시글을 좋아요 하였습니다.");
			rmap.put("count", count);
			return rmap;
		}else {
			teamBbsSerivce.BbsLikeDelete(Overdto);
			teamBbsSerivce.BbsDisLike(Overdto.getSeq());
			TeamBBSDTO dtoLikeCount = teamBbsSerivce.BbsDetail(Overdto.getSeq());
			int count = dtoLikeCount.getLike_count();
			rmap.put("msg", "게시글을 좋아요 취소하였습니다.");
			rmap.put("count", count);
			return rmap;
		}
	}
	
	@ResponseBody
	@RequestMapping(value="teamBbsReport.do", method = {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> teamBbsReport(HttpServletResponse resp, OverlapDTO Overdto, ReportBBSDTO ReportDto) throws Exception{
		Map<String, Object> rmap = new HashMap<String, Object>();
		
		
		System.out.println("-------------reportDto : " + ReportDto.toString());
		System.out.println("-------------OverlapDTO : " + Overdto.toString());
		OverlapDTO dto = teamBbsSerivce.BbsReportPickId(Overdto);
		
		if(dto == null) {
			teamBbsSerivce.BbsReportSend(ReportDto);
			teamBbsSerivce.BbsReportCount(Overdto);
			teamBbsSerivce.BbsReportCount(Overdto.getSeq());
			teamBbsSerivce.MemberReportCount(Overdto.getId());
		//	TeamBBSDTO dtoReportCount = teamBbsSerivce.BbsDetail(Overdto.getSeq());
			// int count = dtoReportCount.getReport_count();
			rmap.put("msg", "[신고]관리자에게 신고 처리 하였습니다.");
			return rmap;
		}else {
			rmap.put("msg", "이미 신고한 글입니다.");
			return rmap;
		}
	}

	
   @RequestMapping(value = "teambbsupload.do", method = RequestMethod.POST)
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
			 
	           
	      //     	System.out.println("out : "+out);
	           
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
   
   
   /*용병*/

	@RequestMapping(value="Bbswrite2.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String Bbswrite2(Model model, Principal pcp) throws Exception{
		
		String id = pcp.getName();
		
		String team_name = teamBbsSerivce.getTeamName(id);
		model.addAttribute("InsertTitle", "SMS 용병 게시판 글쓰기");
		model.addAttribute("team_name", team_name);
		
		return "SubBbsWrite.tiles";
	}
	   //5차 추가
	@RequestMapping(value="BbswriteAf2.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void BbswriteAf2(SubDTO dto, HttpServletResponse resp) throws Exception {
		
		log.info("TeamBbsController BbswriteAf()" + new Date());

		System.out.println("폼 : " +dto.toString());
		boolean insertBbs = teamBbsSerivce.BbsWrite2(dto);
//		System.out.println(insertBbs);
		if(insertBbs) {
			memberservice.WritePointPlus(dto.getId());
			resp.setCharacterEncoding("utf-8");
			resp.setContentType("text/html; charset=utf-8");
			PrintWriter out = resp.getWriter();
			
			out.println("<script type='text/javascript'>alert('글 작성에 성공했습니다.'); "
					+ "location.href='../common/subBbs.do'</script>" );
			out.flush();
		}else {	
		}
	}
   
	@RequestMapping(value="teamBbsdetail2.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String BbsDetail2(Model model, @RequestParam(value="seq")int seq) throws Exception{
	
		log.info("TeamBbsController BbsDetail2()" + new Date());
		
		SubDTO dto = teamBbsSerivce.BbsDetail2(seq);
		model.addAttribute("InsertTitle", "SMS 용병 게시판 상세내역");
		model.addAttribute("bbsdto", dto);
		return "SubBbsDetail.tiles";
	}
	//5차
	@RequestMapping(value="teamBbsdelete2.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void teamBbsdelete2(@RequestParam(value="seq")int seq, HttpServletResponse resp
			, @RequestParam(value="id")String id) throws Exception{
	
		log.info("TeamBbsController teamBbsdelete2()" + new Date());
		boolean a = teamBbsSerivce.BbsDelete2(seq);
		
		if(a) {
			memberservice.WritePointMinus(id);
			resp.setCharacterEncoding("utf-8");
			resp.setContentType("text/html; charset=utf-8");
			PrintWriter out = resp.getWriter();
			
			out.println("<script type='text/javascript'>alert('글 삭제 완료.'); "
					+ "location.href='../common/subBbs.do'</script>" );
			out.flush();

		}
	}
	
	@RequestMapping(value="teamBbsupdate2.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String teamBbsupdate2(Model model, @RequestParam(value="seq")int seq) throws Exception{
	
		log.info("TeamBbsController teamBbsupdate2()" + new Date());
		
		SubDTO dto = teamBbsSerivce.BbsDetail2(seq);
		model.addAttribute("InsertTitle", "SMS 용병 게시판 수정 하기");
		model.addAttribute("bbsdto", dto);
		return "SubBbsUpdate.tiles";
	}
	
	@RequestMapping(value="teamBbsupdate2Af.do", method = {RequestMethod.GET, RequestMethod.POST})
	public void teamBbsupdate2Af(SubDTO dto, HttpServletResponse resp) throws Exception{
	
		log.info("TeamBbsController teamBbsupdate2Af()" + new Date());
		int seq = dto.getSeq();
		boolean update = teamBbsSerivce.BbsUpdate2(dto);
		if(update) {
			resp.setCharacterEncoding("utf-8");
			resp.setContentType("text/html; charset=utf-8");
			PrintWriter out = resp.getWriter();
			
			out.println("<script type='text/javascript'>alert('글 수정 완료.'); "
					+ "location.href='../member/teamBbsdetail2.do?seq="+seq+"'</script>" );
			out.flush();
		}
	}
}


