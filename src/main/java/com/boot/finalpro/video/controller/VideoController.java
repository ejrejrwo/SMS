package com.boot.finalpro.video.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.boot.finalpro.game.model.GameParam;
import com.boot.finalpro.member.service.MemberService;
import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.video.model.VideoCommentDTO;
import com.boot.finalpro.video.model.VideoDTO;
import com.boot.finalpro.video.model.VideoReportDTO;
import com.boot.finalpro.video.service.VideoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/common/*")
public class VideoController {
	
	@Autowired
	VideoService videoService;
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value = "video.do", method={RequestMethod.GET, RequestMethod.POST})
	public String video(String page, GameParam gp, Model model, Principal pcp) {
//		log.info(gp.toString());
		String id = "guest";
		
		Object principal2 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(principal2 != "anonymousUser") {
			id = pcp.getName();
		}
		
		// 전체 리스트 받아오기		
		int nowpage = 1;
		
		if(page != null) {
			nowpage = Integer.parseInt(page);
		}
		
		gp.setNowpage(nowpage);
		gp.setDisplayRow(20);
		
		int count = videoService.getVideoCount(gp);
//		log.info("count==============" + count);
		gp.setTotalCount(count);
		
		List<VideoDTO> video = videoService.videolist(gp);
//		log.info(video.toString());
		
		model.addAttribute("id", id);
		model.addAttribute("video", video);
		model.addAttribute("paging", gp);
		
		model.addAttribute("InsertTitle", "SMS 하이라이트");
		
		return "videolist.tiles";
	}
	
	@RequestMapping(value = "videomake.do", method={RequestMethod.GET, RequestMethod.POST})
	public String videomake(Model model) {
		
		 model.addAttribute("InsertTitle", "SMS 하이라이트");
								
		return "videomake.tiles";
	}

	
	@RequestMapping(value = "videomakeAf.do", method={RequestMethod.GET, RequestMethod.POST})
	public String videomakeAf(MultipartHttpServletRequest multi, HttpServletRequest req, VideoDTO video, Model model)	{
//		System.out.println(video.toString());
				
		String path = req.getServletContext().getRealPath("/upload");

        System.out.println("path : " + path);
        String fileName = "";
      
        File dir = new File(path);
        if(!dir.isDirectory()) {
           dir.mkdir();
        }
        
        Iterator<String> files = multi.getFileNames();
        while(files.hasNext()) {
            String uploadFile = files.next();
            
            MultipartFile mFile = multi.getFile(uploadFile);
            fileName = mFile.getOriginalFilename();
            System.out.println("파일이름 : " + fileName);
            
            video.setFile_name(fileName);
                
        try {
            FileOutputStream fs = new FileOutputStream(path + "/" + fileName);
            fs.write(mFile.getBytes());
            fs.close();
          
         }catch(Exception e) {
            e.printStackTrace();
         }
      }

//        System.out.print(video.toString());       
        videoService.videoUpload(video);
        
        String id = video.getId();
        memberService.UploadPointPlus(id);
        
      //썸네일 생성
        String str = null;
        String[] cmd = new String[] {"" + path + "\\ffmpeg"
                , "-i", "" + path + "\\" + fileName, "-an", "-ss"
                , "00:00:05", "-r", "1", "-vframes", "1", "-y"
                , "" + path + "\\" + fileName+".jpg"};
        Process process = null;
        
		/*
		 * String[] cmd = new String[]
		 * {"C:\\Users\\bit\\Desktop\\Final_sms\\SMS_Project\\src\\main\\webapp\\upload\\ffmpeg"
		 * , "-i",
		 * "C:\\Users\\bit\\Desktop\\Final_sms\\SMS_Project\\src\\main\\webapp\\upload\\"+fileName, "
		 * -an", "-ss" , "00:00:05", "-r", "1", "-vframes", "1", "-y" ,
		 * "C:\\Users\\bit\\Desktop\\Final_sms\\SMS_Project\\src\\main\\webapp\\upload\\"+fileName+"
		 * .jpg"};
		 */
        
         
        try{            
            // 프로세스 빌더를 통하여 외부 프로그램 실행
            process = new ProcessBuilder(cmd).start();
            // 외부 프로그램의 표준출력 상태 버퍼에 저장
            BufferedReader stdOut = new BufferedReader( new InputStreamReader(process.getInputStream()) );
            // 표준출력 상태를 출력
            while( (str = stdOut.readLine()) != null ) {
 //               System.out.println(str);
                }         
        }
        catch (IOException e) {
            e.printStackTrace();
        }
       
        model.addAttribute("InsertTitle", "SMS 하이라이트");
        
		return "redirect:/common/video.do";
	}
	
	@RequestMapping(value = "videodetail.do", method={RequestMethod.GET, RequestMethod.POST})
	public String videodetail(int seq_video, Model model, Principal pcp) {
		videoService.videoRead(seq_video);
		
		String id = "guest";
		
		Object principal2 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(principal2 != "anonymousUser") {
			id = pcp.getName();
		}
		
		// 영상dto
		VideoDTO video = videoService.videodetail(seq_video);
				
		VideoDTO o_video = new VideoDTO();
//		log.info(video.toString());

		// 댓글가져오기		
		o_video.setId(id);
		o_video.setSeq_video(seq_video);
//		log.info(video.toString());
		
		List<VideoCommentDTO> comment = videoService.commentlist(o_video);		
//		log.info(comment.toString());
		
		// overlap
		OverlapDTO over = new OverlapDTO();
		over.setId(id);
		over.setVideo_like(seq_video);		
				
		over = videoService.videoLikeCheck(over);
					
		model.addAttribute("over", over);
		model.addAttribute("id", id);
		model.addAttribute("comment", comment);		
		model.addAttribute("video", video);
		
		model.addAttribute("InsertTitle", "SMS 하이라이트");
								
		return "videodetail.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "writecomment.do", method={RequestMethod.GET, RequestMethod.POST})
	public String writecomment(VideoCommentDTO vc) {
//		log.info(vc.toString());
		String id = vc.getId();
		
		// 댓글저장
		boolean b = videoService.commentWrite(vc);
		memberService.CommentPointPlus(id);
				
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "replycomment.do", method={RequestMethod.GET, RequestMethod.POST})
	public String replycomment(VideoCommentDTO vc) {
//		log.info(vc.toString());
		String id = vc.getId();
		memberService.CommentPointPlus(id);
		
		// 댓글저장
		videoService.replyUpdate(vc);
		videoService.replyComment(vc);
						
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value = "videoLike.do", method={RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> videoLike(VideoDTO video) throws Exception{
		Map<String, Object> rmap = new HashMap<String, Object>();

		// overlap
		OverlapDTO over = new OverlapDTO();
		over.setId(video.getId());
		over.setVideo_like(video.getSeq_video());	
//		log.info(over.toString());
				
		over = videoService.videoLikeCheck(over);

		if(over == null) {		
			// like+1
			videoService.videoLike(video.getSeq_video());
			// over insert
			videoService.videoLikeOver(video);			
			//like count
			int count = videoService.videoLikeCount(video.getSeq_video());
			
			rmap.put("count", count);
			rmap.put("num", 0);
			return rmap;
		}else {
			// like-1
			videoService.videoUnlike(video.getSeq_video());			
			
			// over delete
			videoService.videoUnlikeOver(video);			
			//like count
			int count = videoService.videoLikeCount(video.getSeq_video());			
			
			rmap.put("count", count);
			rmap.put("num", 1);
			return rmap;
		}					
	}
	
	@ResponseBody
	@RequestMapping(value = "commentVideoLike.do", method={RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> commentVideoLike(VideoCommentDTO vc) throws Exception{
		Map<String, Object> rmap = new HashMap<String, Object>();

		// overlap
		OverlapDTO c_over = new OverlapDTO();
		c_over.setId(vc.getId());
		c_over.setVideo_comment_like(vc.getSeq());	
//		log.info(c_over.toString());
				
		c_over = videoService.commentVideoLikeCheck(c_over);

		if(c_over == null) {				
			// like+1
			videoService.commentVideoLike(vc.getSeq());
			// over insert
			videoService.commentVideoLikeOver(vc);			
			//like count
			int count = videoService.commentVideoLikeCount(vc.getSeq());
			
			rmap.put("count", count);
			rmap.put("num", 0);
			return rmap;
			
		}else {
			// like-1
			videoService.commentVideoUnlike(vc.getSeq());						
			// over delete
			videoService.commentVideoUnlikeOver(vc);			
			//like count
			int count = videoService.commentVideoLikeCount(vc.getSeq());

//			System.out.println("좋아요-1:" + count);
			
			rmap.put("count", count);
			rmap.put("num", 1);
			return rmap;
		}
					
	}
	
///////////////////////////////////
	@ResponseBody
	@RequestMapping(value = "videoReport.do", method={RequestMethod.GET, RequestMethod.POST})
	public String videoReport(VideoDTO vdto, VideoReportDTO vr, String write_id) {
		log.info("VideoDTO=========" + vdto.toString());
		log.info("VideoReportDTO=========" + vr.toString());
	
		// video 신고 중복 체크
		OverlapDTO odto = videoService.VideoReportCheck(vdto);
		
		if(odto == null) {
			// 신고수 증가
			videoService.videoReport(vdto);
			
			// member 신고수 증가
			videoService.memberReportUpdate(write_id);
			
			// overlap 추가
			videoService.VideoReportInsert(vdto);
			
			// report 추가
			videoService.VideoReportAdmin(vr);
			
			return "신고 완료되었습니다.";
		}
		else {
			return "이미 신고한 글입니다.";
		}
	
	}
	
	@ResponseBody
	@RequestMapping(value = "videoCommentReport.do", method={RequestMethod.GET, RequestMethod.POST})
	public String videoCommentReport(VideoCommentDTO vc, VideoReportDTO vr, String write_id) {
		log.info("VideoCommentDTO=========" + vc.toString());
		log.info("VideoReportDTO=========" + vr.toString());
		
		// video comment 신고 중복 체크
		OverlapDTO odto = videoService.CommentReportCheck(vc);

		if(odto == null) {
			// 신고수 증가
			videoService.videoCommentReport(vc);
			
			// member 신고수 증가
			videoService.memberReportUpdate(write_id);
			
			// overlap 추가
			videoService.CommentReportInsert(vc);
			
			// report 추가
			videoService.CommentReportAdmin(vr);
			
			return "신고 완료되었습니다.";
		}
		else {
			return "이미 신고한 댓글입니다.";
		}
		
	}

	// video 삭제
	@RequestMapping(value = "video_delete.do", method={RequestMethod.GET, RequestMethod.POST})
	public String video_delete(int seq_video, Principal pcp) {
//		log.info(seq_video + "");		
		String id = "guest";
		
		Object principal2 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(principal2 != "anonymousUser") {
			id = pcp.getName();
		}
		
		memberService.UploadPointMinus(id);
		videoService.videoDelete(seq_video);
		
		return "redirect:/common/video.do";
	}
	
	// comment 삭제
	@RequestMapping(value = "comment_delete.do", method={RequestMethod.GET, RequestMethod.POST})
	public String commen_delete(int seq, int seq_video, Principal pcp) {
//		log.info(seq_video + "");		
		String id = "guest";
		
		Object principal2 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(principal2 != "anonymousUser") {
			id = pcp.getName();
		}
		
		memberService.CommentPointMinus(id);
		videoService.videoCommentDelete(seq);
		
		return "redirect:/common/videodetail.do?seq_video="+seq_video;
	}
	
	
	
	

}
