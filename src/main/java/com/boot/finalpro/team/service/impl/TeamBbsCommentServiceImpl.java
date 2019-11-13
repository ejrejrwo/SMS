package com.boot.finalpro.team.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.teambbscomment.dao.TeamBbsCommentDao;
import com.boot.finalpro.teambbscomment.model.ReportCommentDTO;
import com.boot.finalpro.teambbscomment.model.TeamBBSCommentDTO;
import com.boot.finalpro.teambbscomment.service.TeamBbsCommentService;

@Service
public class TeamBbsCommentServiceImpl implements TeamBbsCommentService {

	@Autowired
	private TeamBbsCommentDao TeamBbsCommentDao;

	@Override
	public List<TeamBBSCommentDTO> getTeamBbsComment(int seq) {
		return TeamBbsCommentDao.getTeamBbsComment(seq);
	}

	@Override
	public boolean TeamBbsCommentInsert(TeamBBSCommentDTO CommentDto) {
		return TeamBbsCommentDao.TeamBbsCommentInsert(CommentDto);
	}

	@Override
	public boolean TeamBbsCommentUpdate(TeamBBSCommentDTO CommentDto) {
		return TeamBbsCommentDao.TeamBbsCommentUpdate(CommentDto);
	}

	@Override
	public boolean TeamBbsCommentDelete(int seq) {
		return TeamBbsCommentDao.TeamBbsCommentDelete(seq);
	}

	@Override
	public boolean TeamBbsCommentReplyUpdate(TeamBBSCommentDTO CommentDto) {
		return TeamBbsCommentDao.TeamBbsCommentReplyUpdate(CommentDto);
	}

	@Override
	public boolean TeamBbsCommentReplyInsert(TeamBBSCommentDTO CommentDto) {
		return TeamBbsCommentDao.TeamBbsCommentReplyInsert(CommentDto);
	}

	@Override
	public void CommentReportCount(int seq) {
		TeamBbsCommentDao.CommentReportCount(seq);
		
	}

	@Override
	public void CommentReportInsert(OverlapDTO OverDto) {
		TeamBbsCommentDao.CommentReportInsert(OverDto);
		
	}

	@Override
	public OverlapDTO CommentReportPickId(OverlapDTO OverDto) {
		return TeamBbsCommentDao.CommentReportPickId(OverDto);
	}

	@Override
	public boolean CommentReportSend(ReportCommentDTO ReportCommentDto) {
		return TeamBbsCommentDao.CommentReportSend(ReportCommentDto);
	}

	@Override
	public int CommentReportGetCount(int seq) {
		return TeamBbsCommentDao.CommentReportGetCount(seq);
	}

	@Override
	public List<ReportCommentDTO> getCommentReportList(int seq) {
		return TeamBbsCommentDao.getCommentReportList(seq);
	}

	@Override
	public String CommentWriteGetId(int seq) {
		return TeamBbsCommentDao.CommentWriteGetId(seq);
	}
}
