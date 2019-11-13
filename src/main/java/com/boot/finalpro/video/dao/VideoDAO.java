package com.boot.finalpro.video.dao;

import java.util.List;

import com.boot.finalpro.game.model.GameParam;
import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.video.model.VideoCommentDTO;
import com.boot.finalpro.video.model.VideoDTO;
import com.boot.finalpro.video.model.VideoReportDTO;

public interface VideoDAO {
	
	public boolean videoUpload(VideoDTO video);
	
	public List<VideoDTO> videolist(GameParam gp);
	
	public int getVideoCount(GameParam gp);
	
	public VideoDTO videodetail(int seq_video);
	
	public void videoRead(int seq_video);
	
	public List<VideoCommentDTO> commentlist(VideoDTO video);
	
	public boolean commentWrite(VideoCommentDTO vc);
	
	public void replyUpdate(VideoCommentDTO vc);
	
	public void replyComment(VideoCommentDTO vc);
	
	public List<VideoDTO> mainVideo();
	
	////////////////// video 좋아요
	public void videoLike(int seq_video);
	
	public void videoLikeOver(VideoDTO video);
	
	public int videoLikeCount(int seq_video);
	
	public OverlapDTO videoLikeCheck(OverlapDTO over);
	
	public void videoUnlike(int seq_video);
	
	public void videoUnlikeOver(VideoDTO video);
	
	///////////// video comment 좋아요
	public void commentVideoLike(int seq);
	
	public void commentVideoLikeOver(VideoCommentDTO vc);
	
	public int commentVideoLikeCount(int seq);
	
	public OverlapDTO commentVideoLikeCheck(OverlapDTO over);
	
	public void commentVideoUnlike(int seq);
	
	public void commentVideoUnlikeOver(VideoCommentDTO vc);
	
	////////////////////////video 신고
	public void videoReport(VideoDTO vdto);
	
	public void memberReportUpdate(String write_id);	// 추가
	
	public void VideoReportInsert(VideoDTO vdto);
	
	public OverlapDTO VideoReportCheck(VideoDTO vdto);
	
	public void VideoReportAdmin(VideoReportDTO vr);
	
	public int VideoReportCount(VideoDTO vdto);
	
	public VideoDTO getVideoReportList(int seq_video);
	////////////////////////video 신고
	
	//////////////////////// comment 신고
	public void videoCommentReport(VideoCommentDTO vc);
	
	public void CommentReportInsert(VideoCommentDTO vc);
	
	public OverlapDTO CommentReportCheck(VideoCommentDTO vc);
	
	public void CommentReportAdmin(VideoReportDTO vr);
	
	public int CommentReportCount(VideoCommentDTO vc);
	
	public VideoCommentDTO getCommentReportList(int seq);
	////////////////////////comment 신고
	
	/////////////// admin_report
	public List<VideoReportDTO> getVideoReport();
	
	public List<VideoDTO> getDetailVideoReport(int seq_video);
	
	public List<VideoCommentDTO> getDetailCommentReport(int seq);
	
	public void videoDelete(int seq_video);
	
	public void videoCommentDelete(int seq);
	
	
	///////////////////////
	public void videoReportCancel(int seq_video);
	
	public void memberReportCancel(String id);
	
	public void memberReportPlus(String id);
	
	public void overDelete(OverlapDTO over);
	
	public void videoReportDelete(OverlapDTO over);
	
	public void videoCommentCancel(int seq);
	
	public void overCommentDelete(OverlapDTO over);
	
	public boolean videoReportCommentDelete(OverlapDTO over);
	

}







