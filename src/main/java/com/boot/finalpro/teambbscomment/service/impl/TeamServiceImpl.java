package com.boot.finalpro.teambbscomment.service.impl;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.boot.finalpro.admin.model.NoticeSubDTO;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.model.GameMatchDTO;
import com.boot.finalpro.member.model.AuthoritiesDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.mypage.model.MessageDTO;
import com.boot.finalpro.team.dao.TeamDAO;
import com.boot.finalpro.team.model.ReportTeamDTO;
import com.boot.finalpro.team.model.TeamApplicationDTO;
import com.boot.finalpro.team.model.TeamGameParam;
import com.boot.finalpro.team.model.TeamMemberParam;
import com.boot.finalpro.team.service.TeamService;
import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.teambbs.model.RecruitTeamDTO;
import com.boot.finalpro.teambbs.model.RecruitTeamParam;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;
import com.boot.finalpro.teambbs.model.TeamDetailParam;

@Service
public class TeamServiceImpl implements TeamService {

	@Autowired
	TeamDAO teamDAO;
	
	
	
	@Override
	public void teamapplicationAf(TeamDetailDTO teamdetaildto, MultipartFile file, String uploadPath)throws Exception {
		
		if(file != null) {
			System.out.println("111111111111111111");
			String orifile_name = file.getOriginalFilename();	
			String file_name =  System.currentTimeMillis() + orifile_name;	//파일 저장공간 + 이름바꾸기
			String file_name1 = uploadPath + file_name;
			file.transferTo(new File(file_name1));
			teamdetaildto.setFile_name(file_name);
			teamDAO.teamapplicationAf(teamdetaildto);
		}else {
			System.out.println("2222222222222222");
			teamDAO.teamapplicationAf(teamdetaildto);
		}
		
		teamDAO.teamappleader(teamdetaildto);
		teamDAO.teamappmemup(teamdetaildto);
		teamDAO.teamappauthup(teamdetaildto);
	}
	
	@Override
	public int TeamAppcheck(TeamDetailParam teamdetailparam) {
		return teamDAO.TeamAppcheck(teamdetailparam);
	}
	
	@Override
	public int tnamecheck(String team_name) {
		return teamDAO.tnamecheck(team_name);
	}
	
	@Override
	public void teamappmemup(TeamDetailDTO teamdetaildto) {
		teamDAO.teamappmemup(teamdetaildto);
	}
	
	@Override
	public void teamappleader(TeamDetailDTO teamdetaildto) {
		teamDAO.teamappleader(teamdetaildto);
	}
	
	@Override
	public List<TeamDetailDTO> teamlist(TeamDetailParam teamdetailparam) {
		return teamDAO.teamlist(teamdetailparam);
	}
	
	@Override
	public int teamlistCount(TeamDetailParam teamdetailparam) {
		return teamDAO.teamlistCount(teamdetailparam);
	}
	
	@Override
	public TeamDetailDTO teamdetail(TeamDetailDTO teamdetaildto) {
		return teamDAO.teamdetail(teamdetaildto);
	}
	
	@Override
	public int memcount(TeamDetailDTO teamdetaildto) {
		return teamDAO.memcount(teamdetaildto);
	}

	@Override
	public void memberapplicationAf(TeamApplicationDTO teamappdto) {
		teamDAO.memberapplicationAf(teamappdto);
	}

	@Override
	public List<TeamApplicationDTO> memappstate(TeamDetailDTO teamdetaildto) {
		return teamDAO.memappstate(teamdetaildto);
	}
	
	@Override
	public void teamacceptall(TeamApplicationDTO teamappdto) {
		teamDAO.memteamup(teamappdto);
		teamDAO.teamaccept(teamappdto);
		teamDAO.teamappdel(teamappdto);
		teamDAO.authteamup(teamappdto);
	}
	
	@Override
	public void teamreject(TeamApplicationDTO teamappdto) {
		teamDAO.teamrejdel(teamappdto);
	}
	
	@Override
	public List<GameDTO> getgamelist(TeamGameParam teamgameparam) {
		return teamDAO.getgamelist(teamgameparam);
	}
	
	@Override
	public int getgamelistCount(TeamGameParam teamgameparam) {
		return teamDAO.getgamelistCount(teamgameparam);
	}
	
	@Override
	public List<GameMatchDTO> getmatchinglist(GameDTO gamedto) {
		
		return teamDAO.getmatchinglist(gamedto);
	}
	
	@Override
	public void matchappect(GameMatchDTO gamematchdto) {
		teamDAO.matchappectup(gamematchdto);
		teamDAO.matchappectdel(gamematchdto);
	}
	
	@Override
	public void matchreject(GameMatchDTO gamematchdto) {
		teamDAO.matchreject(gamematchdto);
	}
	
	@Override
	public List<MemberDTO> memberstate(TeamMemberParam teammemberparam) {
		return teamDAO.memberstate(teammemberparam);
	}
	
	@Override
	public void teamout(MemberDTO memberdto) {
		teamDAO.teamoutdel(memberdto);
		teamDAO.teamoutup(memberdto);
		teamDAO.authoutup(memberdto);
	}
	
	@Override
	public void teamupAf(TeamDetailParam teamdetailparam, MultipartFile file, String uploadPath)throws Exception {
		if(file != null) {
			System.out.println("111111111111111111");
			String orifile_name = file.getOriginalFilename();	
			String file_name =  System.currentTimeMillis() + orifile_name;	//파일 저장공간 + 이름바꾸기
			String file_name1 = uploadPath + file_name;
			file.transferTo(new File(file_name1));
			teamdetailparam.setFile_name(file_name);
			teamDAO.teamupAf(teamdetailparam);
		}else {
			System.out.println("2222222222222222");
			teamDAO.teamupAf(teamdetailparam);
		}
		
	}
	
	@Override
	public void recruitmentAf(RecruitTeamDTO recruitteamdto) {
		teamDAO.recruitmentAf(recruitteamdto);
		teamDAO.recruitmentup(recruitteamdto);
	}
	
	@Override
	public void deadlineall(String team_name) {
		teamDAO.deadlinedel(team_name);
		teamDAO.deadlineup(team_name);
		teamDAO.deadlineAppDel(team_name);
	}
	
	
	@Override
	public List<RecruitTeamDTO> recruitmentlist(RecruitTeamParam recruitparam) {
		System.out.println("serviceImpl");
		return teamDAO.recruitmentlist(recruitparam);
	}
	@Override
	public int recruitmencount(RecruitTeamParam recruitparam) {
		return teamDAO.recruitmencount(recruitparam);
	}
	
	
	@Override
	public void appmsg(MessageDTO msgdto) {
		teamDAO.appmsg(msgdto);
	}
	
	@Override
	public void tdel_all(String team_name) {
		List<String> id = teamDAO.tdel_getid(team_name);
		for (int i = 0; i < id.size(); i++) {
			teamDAO.tdel_auth(id.get(i));
		}
		teamDAO.tdel_gmat(team_name);
		teamDAO.tdel_member(team_name);
		teamDAO.tdel_recteam(team_name);
		teamDAO.tdel_team(team_name);
		teamDAO.tdel_teamapp(team_name);
		teamDAO.tdel_teambbs(team_name);
		teamDAO.tdel_teamdet(team_name);
	}
	
	@Override
	public int tdel_check(String team_name) {
		return teamDAO.tdel_check(team_name);
	}
	
	@Override
	public AuthoritiesDTO getAuth(String id) {
		return teamDAO.getAuth(id);
	}
	
	@Override
	public MemberDTO getMemberById(String id) {
		return teamDAO.getMemberById(id);
	}
	
	@Override
	public void teamappauthup(TeamDetailDTO teamdetaildto) {
		teamDAO.teamappauthup(teamdetaildto);
	}
	
	@Override
	public String getTeamcount(String id) {
		return teamDAO.getTeamcount(id);
	}
	
	@Override
	public int getAppCount(String id) {
		return teamDAO.getAppCount(id);
	}
	
	@Override
	public int TeamAppCount(TeamDetailParam teamdetailparam) {
		return teamDAO.TeamAppCount(teamdetailparam);
	}
	
	@Override
	public void TeamLikePlus(String team_name) {
		teamDAO.TeamLikePlus(team_name);
	}

	@Override
	public void TeamLikeOverlap(OverlapDTO overlapDto) {
		teamDAO.TeamLikeOverlap(overlapDto);
	}

	@Override
	public OverlapDTO TeamLikePickId(OverlapDTO overlapDto) {
		return teamDAO.TeamLikePickId(overlapDto);
	}
	@Override
	public void TeamLikeDel(OverlapDTO overlapDto) {
		teamDAO.TeamLikeDel(overlapDto);
		teamDAO.TeamLikeOverlapDel(overlapDto);
	}
	@Override
	public void TeamReport(OverlapDTO overlapDto) {
		teamDAO.TeamReportOverlap(overlapDto);
		teamDAO.TeamReportPlus(overlapDto.getTeam_name());
		
	}
	@Override
	public OverlapDTO TeamReportPickId(OverlapDTO overlapDto) {
		return teamDAO.TeamReportPickId(overlapDto);
	}

	@Override
	public void TeamReportSend(ReportTeamDTO reportteamDto) {
		teamDAO.TeamReportSend(reportteamDto);
	}

	@Override
	public List<ReportTeamDTO> GetTeamReportList(String team_name) {
		return teamDAO.GetTeamReportList(team_name);
	}
	
	@Override
	public int memberstateCount(TeamMemberParam teammemberparam) {
		return teamDAO.memberstateCount(teammemberparam);
	}
}
