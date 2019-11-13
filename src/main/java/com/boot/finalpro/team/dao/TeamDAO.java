package com.boot.finalpro.team.dao;

import java.util.List;

import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.model.GameMatchDTO;
import com.boot.finalpro.member.model.AuthoritiesDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.mypage.model.MessageDTO;
import com.boot.finalpro.team.model.ReportTeamDTO;
import com.boot.finalpro.team.model.TeamApplicationDTO;
import com.boot.finalpro.team.model.TeamGameParam;
import com.boot.finalpro.team.model.TeamMemberParam;
import com.boot.finalpro.teambbs.model.OverlapDTO;
import com.boot.finalpro.teambbs.model.RecruitTeamDTO;
import com.boot.finalpro.teambbs.model.RecruitTeamParam;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;
import com.boot.finalpro.teambbs.model.TeamDetailParam;

public interface TeamDAO {
	/* 팀 만들기 */
	public boolean teamapplicationAf(TeamDetailDTO teamdetaildto);
	public void teamappmemup(TeamDetailDTO teamdetaildto);
	public void teamappleader(TeamDetailDTO teamdetaildto);
	public int tnamecheck(String team_name);
	public void teamappauthup(TeamDetailDTO teamdetaildto);
	
	/* 팀 리스트 */
	public List<TeamDetailDTO> teamlist(TeamDetailParam teamdetailparam);
	public int teamlistCount(TeamDetailParam teamdetailparam);
	
	/* 팀 디테일 */
	public TeamDetailDTO teamdetail(TeamDetailDTO teamdetaildto);
	
	public int TeamAppcheck(TeamDetailParam teamdetailparam);
	
	/* 팀원 수 */
	public int memcount(TeamDetailDTO teamdetaildto);
	
	/* 팀원모집 게시글 */
	public List<RecruitTeamDTO> recruitmentlist(RecruitTeamParam recruitparam);
	public int recruitmencount(RecruitTeamParam recruitparam); 
	public void recruitmentAf(RecruitTeamDTO recruitteamdto);
	public void recruitmentup(RecruitTeamDTO recruitteamdto);
	
	/* 팀원 모집 끝 */
	public void deadlineup(String team_name);
	public void deadlinedel(String team_name);
	public void deadlineAppDel(String team_name);
	
	/* 팀 멤버 신청 */
	public void memberapplicationAf(TeamApplicationDTO teamappdto);
	
	/* 팀 멤버 신청서 리스트 */
	public List<TeamApplicationDTO> memappstate(TeamDetailDTO teamdetaildto);
	
	/* 팀원 신청에서 팀장이 수락을 했을때 */
	public void teamaccept(TeamApplicationDTO teamappdto);
	public void memteamup(TeamApplicationDTO teamappdto);
	public void authteamup(TeamApplicationDTO teamappdto);
	/* 팀원 신청에서 팀장이 수락 및 거절을 했을때 */
	public void teamrejdel(TeamApplicationDTO teamappdto);
	public void teamappdel(TeamApplicationDTO teamappdto);
	public void appmsg(MessageDTO msgdto);
	
	
	/* 게임 신청 리스트 */
	public List<GameDTO> getgamelist(TeamGameParam teamgameparam);
	public List<GameMatchDTO> getmatchinglist(GameDTO gamedto);
	public int getgamelistCount(TeamGameParam teamgameparam);
	
	/* 게임 매칭 수락 */
	public void matchappectup(GameMatchDTO gamematchdto);
	public void matchappectdel(GameMatchDTO gamematchdto);
	
	/* 게임 매칭 거절 */
	public void matchreject(GameMatchDTO gamematchdto);
	
	/* 팀원 리스트 */
	public List<MemberDTO> memberstate(TeamMemberParam teammemberparam);
	public int memberstateCount(TeamMemberParam teammemberparam);
	
	/* 팀 탈퇴 시키기 */
	public void teamoutdel(MemberDTO memberdto);
	public void teamoutup(MemberDTO memberdto);
	public void authoutup(MemberDTO memberdto);
	
	/* 팀디테일 수정 */
	public void teamupAf(TeamDetailParam teamdetailparam);
	
	
	/* 팀 삭제 */
	public void tdel_member(String team_name);
	public void tdel_team(String team_name);
	public void tdel_teamdet(String team_name);
	public void tdel_teamapp(String team_name);
	public void tdel_recteam(String team_name);
	public void tdel_teambbs(String team_name);
	public void tdel_gmat(String team_name);
	public void tdel_auth(String id);
	public List<String> tdel_getid(String team_name);
	
	/* 팀 삭제 체크 */
	public int tdel_check(String team_name);
	
	/* 로그인 멤버 정보 가져오기 */
	public MemberDTO getMemberById(String id);
	public AuthoritiesDTO getAuth(String id);
	
	/* 내팀 가기 위해 팀이름 가져오기 */
	public String getTeamcount(String id);
	
	/* 팀원신청서 카운트 */
	public int getAppCount(String id);
	public int TeamAppCount(TeamDetailParam teamdetailparam);
	
	/* 팀 좋아요 */
	public void TeamLikePlus(String team_name);
	public void TeamLikeOverlap(OverlapDTO overlapDto);
	public OverlapDTO TeamLikePickId(OverlapDTO overlapDto);
	
	/* 팀 좋아요 삭제 */
	public void TeamLikeDel(OverlapDTO overlapDto);
	public void TeamLikeOverlapDel(OverlapDTO overlapDto);
	
	/* 팀 신고 */
	public void TeamReportPlus(String team_name);
	public void TeamReportOverlap(OverlapDTO overlapDto);
	public OverlapDTO TeamReportPickId(OverlapDTO overlapDto);
	
	/* 팀 신고 내용 관리자 보내기 */
	public void TeamReportSend(ReportTeamDTO reportteamDto);
	/* 팀 신고 내용 관리자 가져오기 */
	public List<ReportTeamDTO> GetTeamReportList(String team_name);
	
	
	
	
}
