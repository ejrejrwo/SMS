package com.boot.finalpro.video.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.finalpro.game.model.GameParam;
import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.video.dao.VideoDAO;
import com.boot.finalpro.video.model.VideoCommentDTO;
import com.boot.finalpro.video.model.VideoDTO;
import com.boot.finalpro.video.model.VideoReportDTO;
import com.boot.finalpro.video.service.VideoService;

@Service
public class VideoServiceImpl implements VideoService {
	
	@Autowired
	VideoDAO videoDAO;
	
	@Override
	public boolean videoUpload(VideoDTO video) {
		return videoDAO.videoUpload(video);
	}

	@Override
	public List<VideoDTO> videolist(GameParam gp) {
		return videoDAO.videolist(gp);
	}

	@Override
	public VideoDTO videodetail(int seq_video) {
		return videoDAO.videodetail(seq_video);
	}


	@Override
	public int getVideoCount(GameParam gp) {
		return videoDAO.getVideoCount(gp);
	}

	@Override
	public void videoRead(int seq_video) {
		videoDAO.videoRead(seq_video);
		
	}

	@Override
	public List<VideoCommentDTO> commentlist(VideoDTO video) {
		return videoDAO.commentlist(video);
	}

	@Override
	public boolean commentWrite(VideoCommentDTO vc) {
		return videoDAO.commentWrite(vc);
	}

	@Override
	public void replyUpdate(VideoCommentDTO vc) {
		videoDAO.replyUpdate(vc);		
	}

	@Override
	public void replyComment(VideoCommentDTO vc) {
		videoDAO.replyComment(vc);		
	}

	@Override
	public List<VideoDTO> mainVideo() {
		return videoDAO.mainVideo();
	}

	@Override
	public void videoLike(int seq_video) {
		videoDAO.videoLike(seq_video);		
	}

	@Override
	public void videoLikeOver(VideoDTO video) {
		videoDAO.videoLikeOver(video);		
	}

	@Override
	public int videoLikeCount(int seq_video) {
		return videoDAO.videoLikeCount(seq_video);
	}

	@Override
	public OverlapDTO videoLikeCheck(OverlapDTO over) {
		return videoDAO.videoLikeCheck(over);
	}
	
	@Override
	public void videoUnlike(int seq_video) {
		videoDAO.videoUnlike(seq_video);
	}

	@Override
	public void videoUnlikeOver(VideoDTO video) {
		videoDAO.videoUnlikeOver(video);
	}

//////////////////////////////////////////////
	@Override
	public void videoReport(VideoDTO vdto) {
		videoDAO.videoReport(vdto);
	}
	
	@Override
	public void memberReportUpdate(String write_id) {
		videoDAO.memberReportUpdate(write_id);
	}

	@Override
	public void VideoReportInsert(VideoDTO vdto) {
		videoDAO.VideoReportInsert(vdto);
	}

	@Override
	public OverlapDTO VideoReportCheck(VideoDTO vdto) {
		return videoDAO.VideoReportCheck(vdto);
	}

	@Override
	public void VideoReportAdmin(VideoReportDTO vr) {
		videoDAO.VideoReportAdmin(vr);
	}

	@Override
	public int VideoReportCount(VideoDTO vdto) {
		return videoDAO.VideoReportCount(vdto);
	}

	@Override
	public VideoDTO getVideoReportList(int seq_video) {
		return videoDAO.getVideoReportList(seq_video);
	}
	
	
//////////////////////////////////////////////
	@Override
	public void videoCommentReport(VideoCommentDTO vc) {
		videoDAO.videoCommentReport(vc);
	}

	@Override
	public void CommentReportInsert(VideoCommentDTO vc) {
		videoDAO.CommentReportInsert(vc);
	}

	@Override
	public OverlapDTO CommentReportCheck(VideoCommentDTO vc) {
		return videoDAO.CommentReportCheck(vc);
	}

	@Override
	public void CommentReportAdmin(VideoReportDTO vr) {
		videoDAO.CommentReportAdmin(vr);
	}

	@Override
	public int CommentReportCount(VideoCommentDTO vc) {
		return videoDAO.CommentReportCount(vc);
	}
	
	@Override
	public VideoCommentDTO getCommentReportList(int seq) {
		return videoDAO.getCommentReportList(seq);
	}
//////////////////////////////////////////////

	@Override
	public List<VideoReportDTO> getVideoReport() {
		return videoDAO.getVideoReport();
	}

	@Override
	public void commentVideoLike(int seq) {
		videoDAO.commentVideoLike(seq);
	}

	@Override
	public void commentVideoLikeOver(VideoCommentDTO vc) {
		videoDAO.commentVideoLikeOver(vc);
	}

	@Override
	public int commentVideoLikeCount(int seq) {
		return videoDAO.commentVideoLikeCount(seq);
	}

	@Override
	public OverlapDTO commentVideoLikeCheck(OverlapDTO over) {
		return videoDAO.commentVideoLikeCheck(over);
	}

	@Override
	public void commentVideoUnlike(int seq) {
		videoDAO.commentVideoUnlike(seq);
	}

	@Override
	public void commentVideoUnlikeOver(VideoCommentDTO vc) {
		videoDAO.commentVideoUnlikeOver(vc);
	}

	@Override
	public List<VideoDTO> getDetailVideoReport(int seq_video) {
		return videoDAO.getDetailVideoReport(seq_video);
	}

	@Override
	public List<VideoCommentDTO> getDetailCommentReport(int seq) {
		return videoDAO.getDetailCommentReport(seq);
	}

	@Override
	public void videoDelete(int seq_video) {
		videoDAO.videoDelete(seq_video);
	}

	@Override
	public void videoCommentDelete(int seq) {
		videoDAO.videoCommentDelete(seq);
	}

	@Override
	public void videoReportCancel(int seq_video) {
		videoDAO.videoReportCancel(seq_video);
	}

	@Override
	public void memberReportCancel(String id) {
		videoDAO.memberReportCancel(id);
	}

	@Override
	public void memberReportPlus(String id) {
		videoDAO.memberReportPlus(id);
	}

	@Override
	public void overDelete(OverlapDTO over) {
		videoDAO.overDelete(over);
	}

	@Override
	public void videoReportDelete(OverlapDTO over) {
		videoDAO.videoReportDelete(over);
	}

	@Override
	public void videoCommentCancel(int seq) {
		videoDAO.videoCommentCancel(seq);
	}

	@Override
	public void overCommentDelete(OverlapDTO over) {
		videoDAO.overCommentDelete(over);
	}

	@Override
	public boolean videoReportCommentDelete(OverlapDTO over) {
		return videoDAO.videoReportCommentDelete(over);
	}
	
	

}
