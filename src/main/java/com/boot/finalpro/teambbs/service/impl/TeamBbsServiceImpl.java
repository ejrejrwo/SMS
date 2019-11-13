package com.boot.finalpro.teambbs.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.finalpro.teambbs.dao.TeamBbsDAO;
import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.teambbs.model.ReportBBSDTO;
import com.boot.finalpro.teambbs.model.SubDTO;
import com.boot.finalpro.teambbs.model.TeamBBSDTO;
import com.boot.finalpro.teambbs.model.TeamBBSParam;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;
import com.boot.finalpro.teambbs.model.TeamDetailParam;
import com.boot.finalpro.teambbs.service.TeamBbsService;

@Service
public class TeamBbsServiceImpl implements TeamBbsService {

	@Autowired
	TeamBbsDAO teamBbsDAO;

	@Override
	public List<TeamBBSDTO> allBbsList(TeamBBSParam param) throws Exception {
		return teamBbsDAO.allBbsList(param);
	}

	@Override
	public int getBbsCount(TeamBBSParam param) throws Exception {
		return teamBbsDAO.getBbsCount(param);
	}

	@Override
	public boolean BbsWrite(TeamBBSDTO BBSdto) throws Exception {
		return teamBbsDAO.BbsWrite(BBSdto);
	}

	@Override
	public TeamBBSDTO BbsDetail(int seq) throws Exception {
		return teamBbsDAO.BbsDetail(seq);
	}

	@Override
	public boolean BbsDelete(int seq) throws Exception {
		return teamBbsDAO.BbsDelete(seq);
	}

	@Override
	public boolean BbsUpdate(TeamBBSDTO Bbsdto) throws Exception {
		return teamBbsDAO.BbsUpdate(Bbsdto);
	}

	@Override
	public void BbsReadCount(int seq) throws Exception {
		teamBbsDAO.BbsReadCount(seq);
	}

	@Override
	public void BbsLikeCount(OverlapDTO OverDto) throws Exception {
		teamBbsDAO.BbsLikeCount(OverDto);
	}

	@Override
	public OverlapDTO BbsLikePickId(OverlapDTO OverDto) throws Exception {
		return teamBbsDAO.BbsLikePickId(OverDto);
	}

	@Override
	public void BbsLikeDelete(OverlapDTO OverDto) throws Exception {
		teamBbsDAO.BbsLikeDelete(OverDto);
	}

	@Override
	public void BbsReportCount(OverlapDTO OverDto) throws Exception {
		teamBbsDAO.BbsReportCount(OverDto);
	}

	@Override
	public OverlapDTO BbsReportPickId(OverlapDTO OverDto) throws Exception {
		return teamBbsDAO.BbsReportPickId(OverDto);
	}

	@Override
	public void BbsLikeCount(int seq) throws Exception {
		teamBbsDAO.BbsLikeCount(seq);
	}

	@Override
	public void BbsReportCount(int seq) throws Exception {
		teamBbsDAO.BbsReportCount(seq);
	}

	@Override
	public void BbsDisLike(int seq) throws Exception {
		teamBbsDAO.BbsDisLike(seq);
	}

	@Override
	public boolean BbsReportSend(ReportBBSDTO ReportDto) throws Exception {
		return teamBbsDAO.BbsReportSend(ReportDto);
	}

	@Override
	public void AdminCommentDelete(int seq) throws Exception {
		teamBbsDAO.AdminCommentDelete(seq);
	}

	@Override
	public List<ReportBBSDTO> GetReportList(int seq) throws Exception {
		return teamBbsDAO.GetReportList(seq);
	}

	@Override
	public void BbsViewsCount(OverlapDTO OverDto) throws Exception {
		teamBbsDAO.BbsViewsCount(OverDto);
	}

	@Override
	public OverlapDTO BbsViewsPickId(OverlapDTO OverDto) throws Exception {
		return teamBbsDAO.BbsViewsPickId(OverDto);
	}

	@Override
	public TeamBBSDTO Previous(TeamBBSDTO Bbsdto) throws Exception {
		return teamBbsDAO.Previous(Bbsdto);
	}

	@Override
	public TeamBBSDTO Next(TeamBBSDTO Bbsdto) throws Exception {
		return teamBbsDAO.Next(Bbsdto);
	}

	@Override
	public String getTeamName(String team_name) throws Exception {
		return teamBbsDAO.getTeamName(team_name);
	}
	
	
	
	
	@Override
	public List<TeamDetailDTO> teamlist(TeamDetailParam teamdetailparam) {
		return teamBbsDAO.teamlist(teamdetailparam);
	}
	
	@Override
	public int teamlistCount() {
		return teamBbsDAO.teamlistCount();
	}

	@Override
	public List<SubDTO> allBbsList2(TeamBBSParam param) {
		return teamBbsDAO.allBbsList2(param);
	}

	@Override
	public int getBbsCount2(TeamBBSParam param) {
		return teamBbsDAO.getBbsCount2(param);
	}

	@Override
	public boolean BbsWrite2(SubDTO dto) {
		return teamBbsDAO.BbsWrite2(dto);
	}

	@Override
	public boolean BbsDelete2(int seq) {
		return teamBbsDAO.BbsDelete2(seq);
	}

	@Override
	public boolean BbsUpdate2(SubDTO dto) {
		return teamBbsDAO.BbsUpdate2(dto);
	}

	@Override
	public SubDTO BbsDetail2(int seq) {
		return teamBbsDAO.BbsDetail2(seq);
	}

	@Override
	public void DeleteMemberReportCount(String id) {
		teamBbsDAO.DeleteMemberReportCount(id);
	}

	@Override
	public void DeleteBbsReportCount(int seq) {
		teamBbsDAO.DeleteBbsReportCount(seq);
	}

	@Override
	public void DeleteBbsCommentReportCount(int seq) {
		teamBbsDAO.DeleteBbsCommentReportCount(seq);
	}

	@Override
	public void DeleteBbsReport(int seq) {
		teamBbsDAO.DeleteBbsReport(seq);
	}

	@Override
	public void DeleteBbsCommentReport(int seq) {
		teamBbsDAO.DeleteBbsCommentReport(seq);
	}

	@Override
	public void DeleteTeamReport(int seq) {
		teamBbsDAO.DeleteTeamReport(seq);
	}

	@Override
	public void DeleteTeamReportCount(String team_name) {
		teamBbsDAO.DeleteTeamReportCount(team_name);
	}

	@Override
	public void MemberReportCount(String id) throws Exception {
		teamBbsDAO.MemberReportCount(id);
	}

	@Override
	public Integer getCommentReportCount(int seq) {
		return teamBbsDAO.getCommentReportCount(seq);
	}

}
