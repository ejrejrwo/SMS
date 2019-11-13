package com.boot.finalpro.video.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.boot.finalpro.game.model.GameParam;
import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.video.dao.VideoDAO;
import com.boot.finalpro.video.model.VideoCommentDTO;
import com.boot.finalpro.video.model.VideoDTO;
import com.boot.finalpro.video.model.VideoReportDTO;

@Repository
public class VideoDAOImpl implements VideoDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	String ns = "Video.";
	
	@Override
	public boolean videoUpload(VideoDTO video) {
		int n = sqlSession.insert(ns + "videoUpload", video);
		return n>0?true:false;
	}

	@Override
	public List<VideoDTO> videolist(GameParam gp) {
		return sqlSession.selectList(ns + "videolist", gp);
	}

	@Override
	public VideoDTO videodetail(int seq_video) {
		return sqlSession.selectOne(ns + "videodetail", seq_video);
	}

	@Override
	public int getVideoCount(GameParam gp) {
		return sqlSession.selectOne(ns + "getVideoCount", gp);
	}

	@Override
	public void videoRead(int seq_video) {
		sqlSession.update(ns + "videoRead", seq_video);
		
	}

	@Override
	public List<VideoCommentDTO> commentlist(VideoDTO video) {
		return sqlSession.selectList(ns + "commentlist", video);
	}

	@Override
	public boolean commentWrite(VideoCommentDTO vc) {
		int n = sqlSession.insert(ns + "commentWrite", vc);
		return n>0?true:false;
	}

	@Override
	public void replyUpdate(VideoCommentDTO vc) {
		sqlSession.update(ns + "replyUpdate", vc);		
	}

	@Override
	public void replyComment(VideoCommentDTO vc) {
		sqlSession.insert(ns + "replyComment", vc);
		
	}

	@Override
	public List<VideoDTO> mainVideo() {
		return sqlSession.selectList(ns + "mainVideo");
	}

	@Override
	public void videoLike(int seq_video) {
		sqlSession.update(ns + "videoLike", seq_video);
		
	}

	@Override
	public void videoLikeOver(VideoDTO video) {
		sqlSession.insert(ns + "videoLikeOver", video);
		
	}

	@Override
	public int videoLikeCount(int seq_video) {
		return sqlSession.selectOne(ns + "videoLikeCount", seq_video);
	}

	@Override
	public OverlapDTO videoLikeCheck(OverlapDTO over) {
		return sqlSession.selectOne(ns + "videoLikeCheck", over);
	}
	
	@Override
	public void videoUnlike(int seq_video) {
		sqlSession.update(ns + "videoUnlike", seq_video);
	}

	@Override
	public void videoUnlikeOver(VideoDTO video) {
		sqlSession.delete(ns + "videoUnlikeOver", video);
	}
	
	//////////////////////////////////
	
	@Override
	public void videoReport(VideoDTO vdto) {
		sqlSession.update(ns + "videoReport", vdto);
	}
	
	@Override
	public void memberReportUpdate(String write_id) {
		sqlSession.update(ns + "memberReportUpdate", write_id);
	}

	@Override
	public void VideoReportInsert(VideoDTO vdto) {
		sqlSession.insert(ns + "VideoReportInsert", vdto);
	}

	@Override
	public OverlapDTO VideoReportCheck(VideoDTO vdto) {
		return sqlSession.selectOne(ns + "VideoReportCheck", vdto);
	}

	@Override
	public void VideoReportAdmin(VideoReportDTO vr) {
		sqlSession.insert(ns + "VideoReportAdmin", vr);
	}

	@Override
	public int VideoReportCount(VideoDTO vdto) {
		return sqlSession.selectOne(ns + "VideoReportCount", vdto);
	}

	@Override
	public VideoDTO getVideoReportList(int seq_video) {
		return sqlSession.selectOne(ns + "getVideoReportList", seq_video);
	}

	//////////////////////////////////////////////
	@Override
	public void videoCommentReport(VideoCommentDTO vc) {
		sqlSession.update(ns + "videoCommentReport", vc);
	}

	@Override
	public void CommentReportInsert(VideoCommentDTO vc) {
		sqlSession.insert(ns + "CommentReportInsert", vc);
	}

	@Override
	public OverlapDTO CommentReportCheck(VideoCommentDTO vc) {
		return sqlSession.selectOne(ns + "CommentReportCheck", vc);
	}

	@Override
	public void CommentReportAdmin(VideoReportDTO vr) {
		sqlSession.insert(ns + "CommentReportAdmin", vr);
	}

	@Override
	public int CommentReportCount(VideoCommentDTO vc) {
		return sqlSession.selectOne(ns + "CommentReportCount", vc);
	}

	@Override
	public VideoCommentDTO getCommentReportList(int seq) {
		return sqlSession.selectOne(ns + "getCommentReportList", seq);
	}
//////////////////////////////////////////////

	@Override
	public List<VideoReportDTO> getVideoReport() {
		return sqlSession.selectList(ns + "getVideoReport");
	}
		
	@Override
	public void commentVideoLike(int seq) {
		sqlSession.update(ns + "commentVideoLike", seq);
	}

	@Override
	public void commentVideoLikeOver(VideoCommentDTO vc) {
		sqlSession.insert(ns + "commentVideoLikeOver", vc);
	}

	@Override
	public int commentVideoLikeCount(int seq) {
		return sqlSession.selectOne(ns + "commentVideoLikeCount", seq);
	}

	@Override
	public void commentVideoUnlike(int seq) {
		sqlSession.update(ns + "commentVideoUnlike", seq);
	}

	@Override
	public void commentVideoUnlikeOver(VideoCommentDTO vc) {
		sqlSession.delete(ns + "commentVideoUnlikeOver", vc);
	}

	@Override
	public OverlapDTO commentVideoLikeCheck(OverlapDTO over) {
		return sqlSession.selectOne(ns + "commentVideoLikeCheck", over);
	}

	@Override
	public List<VideoDTO> getDetailVideoReport(int seq_video) {
		return sqlSession.selectList(ns + "getDetailVideoReport", seq_video);
	}

	@Override
	public List<VideoCommentDTO> getDetailCommentReport(int seq) {
		return sqlSession.selectList(ns + "getDetailCommentReport", seq);
	}

	@Override
	public void videoDelete(int seq_video) {
		sqlSession.update(ns + "videoDelete", seq_video);
	}

	@Override
	public void videoCommentDelete(int seq) {
		sqlSession.update(ns + "videoCommentDelete", seq);
	}

	@Override
	public void videoReportCancel(int seq_video) {
		sqlSession.update(ns + "videoReportCancel", seq_video);
	}

	@Override
	public void memberReportCancel(String id) {
		sqlSession.update(ns + "memberReportCancel", id);
	}

	@Override
	public void memberReportPlus(String id) {
		sqlSession.update(ns + "memberReportPlus", id);
	}

	@Override
	public void overDelete(OverlapDTO over) {
		sqlSession.delete(ns + "overDelete", over);
	}

	@Override
	public void videoReportDelete(OverlapDTO over) {
		sqlSession.delete(ns + "videoReportDelete", over);
	}

	@Override
	public void videoCommentCancel(int seq) {
		sqlSession.update(ns + "videoCommentCancel", seq);
	}

	@Override
	public void overCommentDelete(OverlapDTO over) {
		sqlSession.delete(ns + "overCommentDelete", over);
	}

	@Override
	public boolean videoReportCommentDelete(OverlapDTO over) {
		int n = sqlSession.delete(ns + "videoReportCommentDelete", over);
		return n>0?true:false;
	}


	
	

}
