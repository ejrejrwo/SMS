package com.boot.finalpro.teambbscomment.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.boot.finalpro.member.service.MemberService;
import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.teambbs.service.TeamBbsService;
import com.boot.finalpro.teambbscomment.model.ReportCommentDTO;
import com.boot.finalpro.teambbscomment.model.TeamBBSCommentDTO;
import com.boot.finalpro.teambbscomment.service.TeamBbsCommentService;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping(value = "/member/*")
public class TeamBbsCommentController {

	@Autowired
	TeamBbsCommentService tbs;
	
	@Autowired
	TeamBbsService teambbsservice;
	//5차 추가
	@Autowired
	MemberService memberservice;
	//5차 추가
	@ResponseBody
	@RequestMapping(value="teamBbsCommentWrite.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String teamBbsCommentWrite(TeamBBSCommentDTO CommentDto) {
		
		log.info("TeamBbsCommentController teamBbsCommentWrite()" + new Date());
		
		System.out.println(CommentDto.toString());
		
		boolean a = tbs.TeamBbsCommentInsert(CommentDto);
		if(a) {
			memberservice.CommentPointPlus(CommentDto.getId());
			return "댓글 작성 완료";
		}else {
			return "댓글 작성 실패";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="teamBbsCommentUpdate.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String teamBbsCommentUpdate(TeamBBSCommentDTO CommentDto) {
		
		log.info("TeamBbsCommentController teamBbsCommentUpdate()" + new Date());
		
		System.out.println(CommentDto.toString());
		
		boolean a = tbs.TeamBbsCommentUpdate(CommentDto);
		if(a) {
			return "댓글 수정 완료";
		}else {
			return "댓글 수정 실패";
		}
	}
	//5차
	@RequestMapping(value="teamBbsCommentDelete.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String teamBbsCommentDelete(@RequestParam(value="seq")int seq
			, @RequestParam(value="bbsSeq")int bbsSeq
			, @RequestParam(value="id")String id) {
		
		log.info("TeamBbsCommentController teamBbsCommentDelete()" + new Date());
		
		System.out.println(seq);
		System.out.println(bbsSeq);
		
		boolean a = tbs.TeamBbsCommentDelete(seq);
		if(a) {
			memberservice.CommentPointMinus(id);
			return "redirect:/member/teamBbsdetail.do?seq="+bbsSeq;
		}else {
			return "redirect:/member/teamBbsdetail.do?seq="+bbsSeq;
		}
	}
	//5차
	@ResponseBody
	@RequestMapping(value="teamBbsCommentReply.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String teamBbsCommentReply(@RequestParam(value="seq")int seq
			, @RequestParam(value="parent")int parent, TeamBBSCommentDTO CommentDto) {
		
		System.out.println(CommentDto.toString());
		
		boolean update = tbs.TeamBbsCommentReplyUpdate(CommentDto);
		boolean a = tbs.TeamBbsCommentReplyInsert(CommentDto);
		if(a) {
			memberservice.CommentPointPlus(CommentDto.getId());
	//		System.out.println("여기4");
			return "성공";
		}else {
	//		System.out.println("여기5");
			return "실패";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="teamBbsReport2.do", method = {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> teamBbsReport2(HttpServletResponse resp, OverlapDTO OverDto,
			ReportCommentDTO ReportCommentDto) throws Exception{
		
	
		String id = OverDto.getReport_id();
		Map<String, Object> rmap = new HashMap<String, Object>();
		OverlapDTO dto = tbs.CommentReportPickId(OverDto);
		System.out.println("신고자 아이디 : " + OverDto.toString());
		
		if(dto == null) {
			tbs.CommentReportSend(ReportCommentDto);
			tbs.CommentReportInsert(OverDto);
			tbs.CommentReportCount(OverDto.getSeq());
			teambbsservice.MemberReportCount(id);
			// int ReportCount = tbs.CommentReportGetCount(OverDto.getSeq());
			rmap.put("msg", "[신고]관리자에게 신고 처리 하였습니다.");
			return rmap;
		}else {
			rmap.put("msg", "이미 신고한 글입니다.");
			return rmap;
		}
	}
}
