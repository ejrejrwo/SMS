package com.boot.finalpro.team.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.teambbs.model.RecruitTeamDTO;
import com.boot.finalpro.teambbs.model.RecruitTeamParam;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;
import com.boot.finalpro.teambbs.model.TeamDetailParam;

@Repository
public class TeamDAOImpl implements TeamDAO{

	@Autowired
	SqlSession sqlSession;
	
String namespace = "team.";
	
	@Override
	public boolean teamapplicationAf(TeamDetailDTO teamdetaildto) {
		int n = sqlSession.insert(namespace + "teamapplicationAf", teamdetaildto);
		return n>0?true:false;
	}
	
	@Override
	public void teamappmemup(TeamDetailDTO teamdetaildto) {
		sqlSession.update(namespace + "teamappmemup", teamdetaildto);
	}
	
	@Override
	public int tnamecheck(String team_name) {
		return sqlSession.selectOne(namespace + "get_tname", team_name);
	}
	
	@Override
	public void teamappleader(TeamDetailDTO teamdetaildto) {
		sqlSession.insert(namespace + "teamappleader", teamdetaildto);
	}
	
	@Override
	public List<TeamDetailDTO> teamlist(TeamDetailParam teamdetailparam) {
		System.out.println(teamdetailparam.toString());
		return sqlSession.selectList(namespace + "teamlist", teamdetailparam);
	}
	
	@Override
	public int teamlistCount(TeamDetailParam teamdetailparam) {
		return sqlSession.selectOne(namespace + "teamlistCount", teamdetailparam);
	}
	
	@Override
	public TeamDetailDTO teamdetail(TeamDetailDTO teamdetaildto) {
		return sqlSession.selectOne(namespace + "teamdetail", teamdetaildto);
	}
	
	@Override
	public int memcount(TeamDetailDTO teamdetaildto) {
		return sqlSession.selectOne(namespace + "memcount", teamdetaildto);
	}
	
	@Override
	public void memberapplicationAf(TeamApplicationDTO teamappdto) {
		sqlSession.insert(namespace + "memberapplication", teamappdto);
	}
	
	@Override
	public List<TeamApplicationDTO> memappstate(TeamDetailDTO teamdetaildto) {
		return sqlSession.selectList(namespace + "memappstate", teamdetaildto);
	}

	@Override
	public void memteamup(TeamApplicationDTO teamappdto) {
		sqlSession.update(namespace + "memteamup", teamappdto);
	}
	
	@Override
	public void teamaccept(TeamApplicationDTO teamappdto) {
		sqlSession.insert(namespace + "teamaccept", teamappdto);
	}
	
	@Override
	public void teamappdel(TeamApplicationDTO teamappdto) {
		sqlSession.delete(namespace + "teamappdel", teamappdto);
	}
	
	@Override
	public void teamrejdel(TeamApplicationDTO teamappdto) {
		sqlSession.delete(namespace + "teamrejdel", teamappdto);
	}
	
	@Override
	public List<GameDTO> getgamelist(TeamGameParam teamgameparam) {
		return sqlSession.selectList(namespace + "getgamelist", teamgameparam);
	}
	
	@Override
	public List<GameMatchDTO> getmatchinglist(GameDTO gamedto) {
		return sqlSession.selectList(namespace + "getmatchinglist", gamedto);
	}
	
	@Override
	public void matchappectup(GameMatchDTO gamematchdto) {
		sqlSession.update(namespace + "gameup", gamematchdto);
	}
	
	@Override
	public void matchappectdel(GameMatchDTO gamematchdto) {
		sqlSession.delete(namespace + "matchdel", gamematchdto);
	}
	
	@Override
	public void matchreject(GameMatchDTO gamematchdto) {
		sqlSession.delete(namespace + "matchreject", gamematchdto);
	}
	
	@Override
	public List<MemberDTO> memberstate(TeamMemberParam teammemberparam) {
		return sqlSession.selectList(namespace + "memberstate", teammemberparam);
	}
	
	@Override
	public void teamoutdel(MemberDTO memberdto) {
		sqlSession.delete(namespace + "teamoutdel", memberdto);
	}
	
	@Override
	public void teamoutup(MemberDTO memberdto) {
		sqlSession.update(namespace + "teamoutup", memberdto);
	}
	
	@Override
	public void teamupAf(TeamDetailParam teamdetailparam) {
		sqlSession.update(namespace + "teamupAf", teamdetailparam);
	}
	
	@Override
	public void recruitmentAf(RecruitTeamDTO recruitteamdto) {
		sqlSession.insert(namespace + "recruitmentAf", recruitteamdto);
	}
	
	@Override
	public void recruitmentup(RecruitTeamDTO recruitteamdto) {
		sqlSession.update(namespace + "recruitmentup", recruitteamdto);
	}
	
	@Override
	public List<RecruitTeamDTO> recruitmentlist(RecruitTeamParam recruitparam) {
		System.out.println("DAOImpl");
		return sqlSession.selectList(namespace + "recruitmentlist", recruitparam);
	}
	
	@Override
	public int recruitmencount(RecruitTeamParam recruitparam) {
		return sqlSession.selectOne(namespace + "recruitmencount", recruitparam);
	}
	
	@Override
	public void deadlinedel(String team_name) {
		sqlSession.delete(namespace + "deadlinedel", team_name);
	}
	
	@Override
	public void deadlineup(String team_name) {
		sqlSession.update(namespace + "deadlineup", team_name);
	}
	
	@Override
	public void deadlineAppDel(String team_name) {
		sqlSession.delete(namespace + "deadlineAppDel", team_name);
	}
	
	@Override
	public void appmsg(MessageDTO msgdto) {
		sqlSession.insert(namespace + "appmsg", msgdto);
	}
	
	@Override
	public void tdel_member(String team_name) {
		sqlSession.update(namespace + "tdel_member", team_name);
	}

	@Override
	public void tdel_team(String team_name) {
		sqlSession.delete(namespace + "tdel_team", team_name);
	}

	@Override
	public void tdel_teamdet(String team_name) {
		sqlSession.delete(namespace + "tdel_teamdet", team_name);
	}

	@Override
	public void tdel_teamapp(String team_name) {
		sqlSession.delete(namespace + "tdel_teamapp", team_name);
	}

	@Override
	public void tdel_recteam(String team_name) {
		sqlSession.delete(namespace + "tdel_recteam", team_name);
	}

	@Override
	public void tdel_teambbs(String team_name) {
		sqlSession.delete(namespace + "tdel_teambbs", team_name);
	}

	@Override
	public void tdel_gmat(String team_name) {
		sqlSession.delete(namespace + "tdel_gmat", team_name);
	}
	
	@Override
	public int tdel_check(String team_name) {
		return sqlSession.selectOne(namespace + "tdel_check", team_name);
	}
	
	@Override
	public AuthoritiesDTO getAuth(String id) {
		return sqlSession.selectOne(namespace + "getAuth", id);
	}
	
	@Override
	public MemberDTO getMemberById(String id) {
		return sqlSession.selectOne(namespace + "getMemberById", id);
	}
	
	@Override
	public void teamappauthup(TeamDetailDTO teamdetaildto) {
		sqlSession.update(namespace + "teamappauthup", teamdetaildto);
	}
	
	@Override
	public String getTeamcount(String id) {
		return sqlSession.selectOne(namespace + "getTeamcount", id);
	}
	
	@Override
	public void authoutup(MemberDTO memberdto) {
		sqlSession.update(namespace + "authoutup", memberdto);
	}
	
	@Override
	public void authteamup(TeamApplicationDTO teamappdto) {
		sqlSession.update(namespace + "authteamup", teamappdto);
	}
	
	@Override
	public int getAppCount(String id) {
		return sqlSession.selectOne(namespace + "getAppCount", id);
	}
	
	@Override
	public int TeamAppCount(TeamDetailParam teamdetailparam) {
		return sqlSession.selectOne(namespace + "TeamAppCount", teamdetailparam);
	}
	
	@Override
	public void tdel_auth(String id) {
		sqlSession.update(namespace + "tdel_auth", id);
	}
	
	@Override
	public List<String> tdel_getid(String team_name) {
		return sqlSession.selectList(namespace + "tdel_getid", team_name);
	}
	
	@Override
	public void TeamLikePlus(String team_name) {
		sqlSession.update(namespace + "TeamLikePlus", team_name);
	}

	@Override
	public void TeamLikeOverlap(OverlapDTO overlapDto) {
		sqlSession.insert(namespace + "TeamLikeOverlap", overlapDto);
	}

	@Override
	public OverlapDTO TeamLikePickId(OverlapDTO overlapDto) {
		return sqlSession.selectOne(namespace + "TeamLikePickId", overlapDto);
	}

	@Override
	public void TeamLikeDel(OverlapDTO overlapDto) {
		sqlSession.update(namespace + "TeamLikeDel", overlapDto);
	}

	@Override
	public void TeamLikeOverlapDel(OverlapDTO overlapDto) {
		sqlSession.delete(namespace + "TeamLikeOverlapDel", overlapDto);
	}

	@Override
	public void TeamReportPlus(String team_name) {
		sqlSession.update(namespace + "TeamReportPlus", team_name);
	}

	@Override
	public void TeamReportOverlap(OverlapDTO overlapDto) {
		sqlSession.insert(namespace + "TeamReportOverlap", overlapDto);
	}

	@Override
	public OverlapDTO TeamReportPickId(OverlapDTO overlapDto) {
		return sqlSession.selectOne(namespace + "TeamReportPickId", overlapDto);
	}

	@Override
	public void TeamReportSend(ReportTeamDTO reportteamDto) {
		sqlSession.insert(namespace + "TeamReportSend", reportteamDto);
	}

	@Override
	public List<ReportTeamDTO> GetTeamReportList(String team_name) {
		return sqlSession.selectList(namespace + "GetTeamReportList", team_name);
	}
	
	@Override
	public int TeamAppcheck(TeamDetailParam teamdetailparam) {
		return sqlSession.selectOne(namespace + "TeamAppcheck", teamdetailparam);
	}
	
	@Override
	public int getgamelistCount(TeamGameParam teamgameparam) {
		return sqlSession.selectOne(namespace + "getgamelistCount", teamgameparam);
	}
	
	@Override
	public int memberstateCount(TeamMemberParam teammemberparam) {
		return sqlSession.selectOne(namespace + "memberstateCount", teammemberparam);
	}
}
