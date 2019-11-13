package com.boot.finalpro.teambbs.service;

import java.util.List;

import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.teambbs.model.ReportBBSDTO;
import com.boot.finalpro.teambbs.model.SubDTO;
import com.boot.finalpro.teambbs.model.TeamBBSDTO;
import com.boot.finalpro.teambbs.model.TeamBBSParam;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;
import com.boot.finalpro.teambbs.model.TeamDetailParam;

public interface TeamBbsService {
	// 글 전체 불러오기
		public List<TeamBBSDTO> allBbsList(TeamBBSParam param) throws Exception;
		// 글 갯수 구하기
		public int getBbsCount(TeamBBSParam param) throws Exception;
		// 글 작성하기
		public boolean BbsWrite(TeamBBSDTO BBSdto) throws Exception;
		// 글 상세확인
		public TeamBBSDTO BbsDetail(int seq) throws Exception;
		// 글 삭제하기
		public boolean BbsDelete(int seq) throws Exception;
		// 글 수정하기
		public boolean BbsUpdate(TeamBBSDTO Bbsdto) throws Exception;
		// 조회수
		public void BbsReadCount(int seq) throws Exception;
		// 좋아요 카운트
		public void BbsLikeCount(int seq) throws Exception;
		// 신고수 카운트
		public void BbsReportCount(int seq) throws Exception;
		// 좋아요 감소
		public void BbsDisLike(int seq) throws Exception;
		// 좋아요 중복 추가
		public void BbsLikeCount(OverlapDTO OverDto) throws Exception;
		// 좋아요 중복 체크
		public OverlapDTO BbsLikePickId(OverlapDTO OverDto) throws Exception;
		// 좋아요 중복 삭제
		public void BbsLikeDelete(OverlapDTO OverDto) throws Exception;
		// 신고수 중복 추가
		public void BbsReportCount(OverlapDTO OverDto) throws Exception;
		// 신고수 중복 체크
		public OverlapDTO BbsReportPickId(OverlapDTO OverDto) throws Exception;
		// 조회수 중복 추가
		public void BbsViewsCount(OverlapDTO OverDto) throws Exception;
		// 조회수 중복 체크
		public OverlapDTO BbsViewsPickId(OverlapDTO OverDto) throws Exception;
		// 신고 내용 (게시판 신고 테이블 생성) 후 관리자 보내기(뿌려주기)
		public boolean BbsReportSend(ReportBBSDTO ReportDto) throws Exception;
		// 관리자 게시판 댓글 삭제
		public void AdminCommentDelete(int seq) throws Exception;
		// 신고글 리스트 가져오기
		public List<ReportBBSDTO> GetReportList(int seq) throws Exception;
		// 이전글
		public TeamBBSDTO Previous(TeamBBSDTO Bbsdto) throws Exception;
		// 다음글
		public TeamBBSDTO Next(TeamBBSDTO Bbsdto) throws Exception;
		// 로그인 팀 네임 가져오기
		public String getTeamName(String team_name) throws Exception;
		// 멤버 신고수 올리기
		public void MemberReportCount(String id) throws Exception;
		// 리스트 댓글 신고수 불러오기
		public Integer getCommentReportCount(int seq);
		
		
		public List<TeamDetailDTO> teamlist(TeamDetailParam teamdetailparam);
		
		public int teamlistCount();
		// 용병 게시판 가져오기
		public List<SubDTO> allBbsList2(TeamBBSParam param);
		public int getBbsCount2(TeamBBSParam param);
		
		// 글 작성하기
		public boolean BbsWrite2(SubDTO dto);
		// 글 삭제하기
		public boolean BbsDelete2(int seq);
		// 글 수정하기
		public boolean BbsUpdate2(SubDTO dto);
		// 글 상세정보
		public SubDTO BbsDetail2(int seq);
		
		///////신고수 삭제 부분
		public void DeleteMemberReportCount(String id);
		public void DeleteBbsReportCount(int seq);
		public void DeleteBbsCommentReportCount(int seq);
		public void DeleteBbsReport(int seq);
		public void DeleteBbsCommentReport(int seq);
		public void DeleteTeamReport(int seq);
		public void DeleteTeamReportCount(String team_name);
}
