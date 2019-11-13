package com.boot.finalpro.teambbs.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.boot.finalpro.teambbs.dao.TeamBbsDAO;
import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.teambbs.model.ReportBBSDTO;
import com.boot.finalpro.teambbs.model.SubDTO;
import com.boot.finalpro.teambbs.model.TeamBBSDTO;
import com.boot.finalpro.teambbs.model.TeamBBSParam;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;
import com.boot.finalpro.teambbs.model.TeamDetailParam;

@Repository
public class TeamBbsDAOImpl implements TeamBbsDAO {

	@Autowired
	SqlSession sqlSession;
	
	String ns = "teambbs.";
	String ns2 = "subbbs.";

	@Override
	public List<TeamBBSDTO> allBbsList(TeamBBSParam param) throws Exception {
		return sqlSession.selectList(ns + "allBbsList", param);
	}

	@Override
	public int getBbsCount(TeamBBSParam param) throws Exception {
		return sqlSession.selectOne(ns + "getBbsCount", param);
	}

	@Override
	public boolean BbsWrite(TeamBBSDTO BBSdto) throws Exception {
			int n = sqlSession.insert(ns + "BbsWrite", BBSdto);
		return n>0?true:false;
	}

	@Override
	public TeamBBSDTO BbsDetail(int seq) throws Exception {
		return sqlSession.selectOne(ns + "BbsDetail", seq);
		
	}

	@Override
	public boolean BbsDelete(int seq) throws Exception {
			int n = sqlSession.delete(ns + "BbsDelete", seq);
		return n>0?true:false;
	}

	@Override
	public boolean BbsUpdate(TeamBBSDTO Bbsdto) throws Exception {
			int n = sqlSession.update(ns + "BbsUpdate", Bbsdto);
		return n>0?true:false;
	}

	@Override
	public void BbsReadCount(int seq) throws Exception {
		sqlSession.update(ns + "BbsReadCount", seq);
	}

	@Override
	public void BbsLikeCount(OverlapDTO OverDto) throws Exception {
		sqlSession.insert(ns + "BbsLikeCount", OverDto);
		
	}

	@Override
	public OverlapDTO BbsLikePickId(OverlapDTO OverDto) throws Exception {
		OverlapDTO overDto2 = sqlSession.selectOne(ns + "BbsLikePickId", OverDto);
		return overDto2;
	}

	@Override
	public void BbsLikeDelete(OverlapDTO OverDto) throws Exception {
		sqlSession.delete(ns + "BbsLikeDelete", OverDto);
		
	}

	@Override
	public void BbsReportCount(OverlapDTO OverDto) throws Exception {
		sqlSession.insert(ns + "BbsReportCount", OverDto);
		
	}

	@Override
	public OverlapDTO BbsReportPickId(OverlapDTO OverDto) throws Exception {
		OverlapDTO overDto2 = sqlSession.selectOne(ns + "BbsReportPickId", OverDto);
	return overDto2;
	}

	@Override
	public void BbsLikeCount(int seq) throws Exception {
		sqlSession.insert(ns + "BbsLikeCountAf", seq);
	}

	@Override
	public void BbsReportCount(int seq) throws Exception {
		sqlSession.insert(ns + "BbsReportCountAf", seq);
	}

	@Override
	public void BbsDisLike(int seq) throws Exception {
		sqlSession.insert(ns + "BbsDisLike", seq);
	}

	@Override
	public boolean BbsReportSend(ReportBBSDTO ReportDto) throws Exception {
		int n = sqlSession.insert(ns + "BbsReportSend", ReportDto);
		return n>0?true:false;
	}

	@Override
	public void AdminCommentDelete(int seq) throws Exception {
		sqlSession.delete(ns + "AdminCommentDelete", seq);
	}

	@Override
	public List<ReportBBSDTO> GetReportList(int seq) throws Exception {
		return sqlSession.selectList(ns + "GetReportList", seq);
	}

	@Override
	public void BbsViewsCount(OverlapDTO OverDto) throws Exception {
		sqlSession.insert(ns + "BbsViewsCount", OverDto);
	}

	@Override
	public OverlapDTO BbsViewsPickId(OverlapDTO OverDto) throws Exception {
		return OverDto = sqlSession.selectOne(ns + "BbsViewsPickId", OverDto);
	}

	@Override
	public TeamBBSDTO Previous(TeamBBSDTO Bbsdto) throws Exception {
		TeamBBSDTO dto = sqlSession.selectOne(ns + "Previous", Bbsdto);
		return dto;
	}
	@Override
	public TeamBBSDTO Next(TeamBBSDTO Bbsdto) throws Exception {
		TeamBBSDTO dto = sqlSession.selectOne(ns + "Next", Bbsdto);
		return dto;
	}

	@Override
	public String getTeamName(String team_name) throws Exception {
		return sqlSession.selectOne(ns + "getTeamName", team_name);
	}
	
	
	
	
	
	
	
	
	//////////////////////////////
	
	@Override
	public List<TeamDetailDTO> teamlist(TeamDetailParam teamdetailparam) {
		return sqlSession.selectList(ns + "teamlist", teamdetailparam);
	}
	
	@Override
	public int teamlistCount() {
		return sqlSession.selectOne(ns + "teamlistCount");
	}

	
	////////////////////////////// 용병 게시판
	@Override
	public List<SubDTO> allBbsList2(TeamBBSParam param) {
		return sqlSession.selectList(ns2 + "allBbsList2", param);
	}

	@Override
	public int getBbsCount2(TeamBBSParam param) {
		return sqlSession.selectOne(ns2 + "getBbsCount2", param);
	}

	@Override
	public boolean BbsWrite2(SubDTO dto) {
		int n = sqlSession.insert(ns2 + "BbsWrite2", dto);
		return n>0?true:false;
	}

	@Override
	public boolean BbsDelete2(int seq) {
		int n = sqlSession.delete(ns2 + "BbsDelete2", seq);
		return n>0?true:false;
	}

	@Override
	public boolean BbsUpdate2(SubDTO dto) {
		int n = sqlSession.update(ns2 + "BbsUpdate2", dto);
		return n>0?true:false;
	}

	@Override
	public SubDTO BbsDetail2(int seq) {
		return sqlSession.selectOne(ns2 + "BbsDetail2", seq);
	}

	@Override
	public void DeleteMemberReportCount(String id) {
		sqlSession.update(ns + "DeleteMemberReportCount", id);
	}

	@Override
	public void DeleteBbsReportCount(int seq) {
		sqlSession.update(ns + "DeleteBbsReportCount", seq);
	}

	@Override
	public void DeleteBbsCommentReportCount(int seq) {
		sqlSession.update(ns + "DeleteBbsCommentReportCount", seq);
	}

	@Override
	public void DeleteBbsReport(int seq) {
		sqlSession.delete(ns + "DeleteBbsReport", seq);
	}

	@Override
	public void DeleteBbsCommentReport(int seq) {
		sqlSession.delete(ns + "DeleteBbsCommentReport", seq);
	}

	@Override
	public void DeleteTeamReport(int seq) {
		sqlSession.delete(ns + "DeleteTeamReport", seq);
	}

	@Override
	public void DeleteTeamReportCount(String team_name) {
		sqlSession.update(ns + "DeleteTeamReportCount", team_name);
	}

	@Override
	public void MemberReportCount(String id) throws Exception {
		sqlSession.update(ns + "MemberReportCount", id);
	}

	@Override
	public Integer getCommentReportCount(int seq) {
		return sqlSession.selectOne(ns + "getCommentReportCount", seq);
	}
	
}
