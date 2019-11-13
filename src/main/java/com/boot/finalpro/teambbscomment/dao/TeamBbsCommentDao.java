package com.boot.finalpro.teambbscomment.dao;

import java.util.List;

import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.teambbscomment.model.ReportCommentDTO;
import com.boot.finalpro.teambbscomment.model.TeamBBSCommentDTO;

public interface TeamBbsCommentDao {
	// 댓글 가져오기
	public List<TeamBBSCommentDTO> getTeamBbsComment(int seq);
	// 댓글 작성하기
	public boolean TeamBbsCommentInsert(TeamBBSCommentDTO CommentDto);
	// 댓글 수정하기
	public boolean TeamBbsCommentUpdate(TeamBBSCommentDTO CommentDto);
	// 댓글 삭제하기
	public boolean TeamBbsCommentDelete(int seq);
	// 대댓글 원본 리스트 업데이트
	public boolean TeamBbsCommentReplyUpdate(TeamBBSCommentDTO CommentDto);
	// 대댓글 작성
	public boolean TeamBbsCommentReplyInsert(TeamBBSCommentDTO CommentDto);
	// 댓글 신고수 추가
	public void CommentReportCount(int seq);
	// 댓글 중복 테이블 추가
	public void CommentReportInsert(OverlapDTO OverDto);
	// 댓글 신고 중복 체크
	public OverlapDTO CommentReportPickId(OverlapDTO OverDto);
	// 게시판 신고 내용 관리자 보내기
	public boolean CommentReportSend(ReportCommentDTO ReportCommentDto);
	// 게시판 신고 숫자 불러오기
	public int CommentReportGetCount(int seq);
	// 게시판 신고 리스트 불러오기
	public List<ReportCommentDTO> getCommentReportList(int seq);
	// 게시판 아이디 가져오기
	public String CommentWriteGetId(int seq);
}
