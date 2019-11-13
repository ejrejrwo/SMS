package com.boot.finalpro.teambbscomment.dao.impl;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.teambbscomment.dao.TeamBbsCommentDao;
import com.boot.finalpro.teambbscomment.model.ReportCommentDTO;
import com.boot.finalpro.teambbscomment.model.TeamBBSCommentDTO;

@Repository
public class TeamBbsCommentDaoImpl implements TeamBbsCommentDao {

	@Autowired
	SqlSession SqlSession;
	
	String ns = "teambbscomment.";
	@Override
	public List<TeamBBSCommentDTO> getTeamBbsComment(int seq) {
		return SqlSession.selectList(ns + "getBbsTeamComment", seq);
	}

	@Override
	public boolean TeamBbsCommentInsert(TeamBBSCommentDTO CommentDto) {
		int n = SqlSession.insert(ns + "TeamBbsCommentInsert", CommentDto);
		return n>0?true:false;
	}

	@Override
	public boolean TeamBbsCommentUpdate(TeamBBSCommentDTO CommentDto) {
		int n = SqlSession.update(ns + "TeamBbsCommentUpdate", CommentDto);
		return n>0?true:false;
	}

	@Override
	public boolean TeamBbsCommentDelete(int seq) {
		int n = SqlSession.update(ns + "TeamBbsCommentDelete", seq);
		return n>0?true:false;
	}

	@Override
	public boolean TeamBbsCommentReplyUpdate(TeamBBSCommentDTO CommentDto) {
		int n =SqlSession.update(ns + "TeamBbsCommentReplyUpdate", CommentDto);
		return n>0?true:false;
	}

	@Override
	public boolean TeamBbsCommentReplyInsert(TeamBBSCommentDTO CommentDto) {
		int n = SqlSession.insert(ns + "TeamBbsCommentReplyInsert", CommentDto);
		return n>0?true:false;
	}

	@Override
	public void CommentReportCount(int seq) {
		SqlSession.update(ns + "CommentReportCount", seq);
		
	}

	@Override
	public void CommentReportInsert(OverlapDTO OverDto) {
		SqlSession.insert(ns + "CommentReportInsert", OverDto);
		
	}

	@Override
	public OverlapDTO CommentReportPickId(OverlapDTO OverDto) {
		System.out.println("daoimpl overDto" + OverDto.toString());
		return SqlSession.selectOne(ns + "CommentReportPickId", OverDto);
		
	}

	@Override
	public boolean CommentReportSend(ReportCommentDTO ReportCommentDto) {
		int n = SqlSession.insert(ns + "CommentReportSend", ReportCommentDto);
		return n>0?true:false;
	}

	@Override
	public int CommentReportGetCount(int seq) {
		int ReportCount = SqlSession.selectOne(ns + "CommentReportGetCount", seq);
		return ReportCount;
	}

	@Override
	public List<ReportCommentDTO> getCommentReportList(int seq) {
		return SqlSession.selectList(ns + "getCommentReportList", seq);
	}

	@Override
	public String CommentWriteGetId(int seq) {
		return SqlSession.selectOne(ns + "CommentWriteGetId", seq);
	}
	
}
