package com.boot.finalpro.team.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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

public interface TeamService {
	public void teamapplicationAf(TeamDetailDTO teamdetaildto, MultipartFile file, String uploadPath)throws Exception;
	public void teamappmemup(TeamDetailDTO teamdetaildto);
	public void teamappleader(TeamDetailDTO teamdetaildto);
	public int tnamecheck(String team_name);
	
	public List<TeamDetailDTO> teamlist(TeamDetailParam teamdetailparam);
	public int teamlistCount(TeamDetailParam teamdetailparam);
	
	public TeamDetailDTO teamdetail(TeamDetailDTO teamdetaildto);
	public int memcount(TeamDetailDTO teamdetaildto);
	public int TeamAppcheck(TeamDetailParam teamdetailparam);
	
	
	public void memberapplicationAf(TeamApplicationDTO teamappdto);
	
	public List<TeamApplicationDTO> memappstate(TeamDetailDTO teamdetaildto);
	
	public void teamacceptall(TeamApplicationDTO teamappdto);
	
	public void teamreject(TeamApplicationDTO teamappdto);
	
	public List<GameDTO> getgamelist(TeamGameParam teamgameparam);
	public int getgamelistCount(TeamGameParam teamgameparam);
	
	
	public List<GameMatchDTO> getmatchinglist(GameDTO gamedto);
	
	public void matchappect(GameMatchDTO gamematchdto);
	
	public void matchreject(GameMatchDTO gamematchdto);
	
	public List<MemberDTO> memberstate(TeamMemberParam teammemberparam);
	public int memberstateCount(TeamMemberParam teammemberparam);
	
	
	public void teamout(MemberDTO memberdto);
	
	public void teamupAf(TeamDetailParam teamdetailparam, MultipartFile file, String uploadPath)throws Exception;
	
	public void recruitmentAf(RecruitTeamDTO recruitteamdto);
	
	public List<RecruitTeamDTO> recruitmentlist(RecruitTeamParam recruitparam);
	public int recruitmencount(RecruitTeamParam recruitparam);
	
	public void deadlineall(String team_name);
	
	public void appmsg(MessageDTO msgdto);
	
	public void tdel_all(String team_name);
	
	public int tdel_check(String team_name);
	
	public MemberDTO getMemberById(String id);
	
	public void teamappauthup(TeamDetailDTO teamdetaildto);
	public AuthoritiesDTO getAuth(String id);
	
	public String getTeamcount(String id);
	
	public int getAppCount(String id);
	
	public int TeamAppCount(TeamDetailParam teamdetailparam);
	
	/* 팀 좋아요 */
	public void TeamLikePlus(String team_name);
	public void TeamLikeOverlap(OverlapDTO overlapDto);
	public OverlapDTO TeamLikePickId(OverlapDTO overlapDto);
	
	/* 팀 좋아요 삭제 */
	public void TeamLikeDel(OverlapDTO overlapDto);
	
	/* 팀 신고 */
	public void TeamReport(OverlapDTO overlapDto);
	public OverlapDTO TeamReportPickId(OverlapDTO overlapDto);
	
	/* 팀 신고 내용 관리자 보내기 */
	public void TeamReportSend(ReportTeamDTO reportteamDto);
	/* 팀 신고 내용 관리자 가져오기 */
	public List<ReportTeamDTO> GetTeamReportList(String team_name);
}
