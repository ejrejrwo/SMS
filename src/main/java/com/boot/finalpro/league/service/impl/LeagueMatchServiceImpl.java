package com.boot.finalpro.league.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.finalpro.game.dao.GameDAO;
import com.boot.finalpro.game.model.BookingDTO;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.league.dao.LeagueMatchDAO;
import com.boot.finalpro.league.model.LeagueMatchDTO;
import com.boot.finalpro.league.model.NoChatDTO;
import com.boot.finalpro.league.service.LeagueMatchService;
import com.boot.finalpro.league.util.LeagueParamDTO;
import com.boot.finalpro.member.model.AuthoritiesDTO;
import com.boot.finalpro.mypage.model.MessageDTO;
import com.boot.finalpro.team.model.TeamDTO;
import com.boot.finalpro.teambbs.model.TeamDetailDTO;
import com.boot.finalpro.util.DateUtil;

@Service
public class LeagueMatchServiceImpl implements LeagueMatchService {

	@Autowired
	LeagueMatchDAO leagueMatchDAO;

	@Override
	public List<GameDTO> leaguedata(String year, String month) {

		List<GameDTO> list = new ArrayList<GameDTO>();

		Calendar cal = Calendar.getInstance();

		String nyear = cal.get(Calendar.YEAR) + ""; // 현재 년도를 구함
		String nmonth = cal.get(Calendar.MONTH) + 1 + ""; // 0 ~ 11 현재 월을 구함

		// System.out.println("LeagueMatchServiceImpl=============================================");
		//System.out.println("year = " + year);
		//System.out.println("month = " + month);

		month = DateUtil.two(month);
		nmonth = DateUtil.two(nmonth);
		
		String yyyymm = year + month;

		if (nyear.equals(year) && nmonth.equals(month)) {
			//System.out.println("오늘스!! =============================================");
			list = leagueMatchDAO.nowdata();
			//System.out.println(list.toString());
			
			if(list.toString().equals("[]") ) {
				//System.out.println("list null =============================================");
				list = leagueMatchDAO.olddata(yyyymm);
			}
			
		} else {
			// 다른 월 검색 했을때....
			//String yyyymm = year + month;
			// System.out.println("yyyymm = " + yyyymm);
			list = leagueMatchDAO.olddata(yyyymm);
		}

		return list;
	}

	@Override
	public List<TeamDetailDTO> Ranksearch(String category) {

		return leagueMatchDAO.Ranksearch(category);
	}

	@Override
	public List<LeagueMatchDTO> acceptlist() {

		return leagueMatchDAO.acceptlist();
	}

	@Override
	public boolean messagesend(MessageDTO dto) {

		System.out.println("Service messagesend 들어옴");

		return leagueMatchDAO.messagesend(dto);
	}

	@Override
	public boolean addleague(LeagueParamDTO dto) {

		String koday[] = { "공백", "일", "월", "화", "수", "목", "금", "토" };
		String book_time[] = { "06", "09", "12", "15", "18" };

		Calendar cal = Calendar.getInstance();

		String datestr1[] = dto.getDate1().split("-");
		int year = Integer.parseInt(datestr1[0]);
		int month = Integer.parseInt(datestr1[1]);
		int date = Integer.parseInt(datestr1[2]);
		cal.set(year, month - 1, date);
		int day = cal.get(Calendar.DAY_OF_WEEK);
		dto.setDate1(dto.getDate1() + " " + koday[day]);

		String datestr2[] = dto.getDate2().split("-");
		year = Integer.parseInt(datestr2[0]);
		month = Integer.parseInt(datestr2[1]);
		date = Integer.parseInt(datestr2[2]);
		cal.set(year, month - 1, date);
		day = cal.get(Calendar.DAY_OF_WEEK);
		dto.setDate2(dto.getDate2() + " " + koday[day]);

		String datestr3[] = dto.getDate3().split("-");
		year = Integer.parseInt(datestr3[0]);
		month = Integer.parseInt(datestr3[1]);
		date = Integer.parseInt(datestr3[2]);
		cal.set(year, month - 1, date);
		day = cal.get(Calendar.DAY_OF_WEEK);
		dto.setDate3(dto.getDate3() + " " + koday[day]);

		GameDTO game81 = new GameDTO(dto.getCategory(), dto.getTeam1(), dto.getTeam2(), dto.getDate1() + " 09:00",
				dto.getArea1() + dto.getStadium1(), dto.getTitle1(), dto.getContent1(), "81");
		GameDTO game82 = new GameDTO(dto.getCategory(), dto.getTeam3(), dto.getTeam4(), dto.getDate1() + " 13:00",
				dto.getArea1() + dto.getStadium1(), dto.getTitle2(), dto.getContent2(), "82");
		GameDTO game83 = new GameDTO(dto.getCategory(), dto.getTeam5(), dto.getTeam6(), dto.getDate1() + " 16:00",
				dto.getArea1() + dto.getStadium1(), dto.getTitle3(), dto.getContent3(), "83");
		GameDTO game84 = new GameDTO(dto.getCategory(), dto.getTeam7(), dto.getTeam8(), dto.getDate1() + " 19:00",
				dto.getArea1() + dto.getStadium1(), dto.getTitle4(), dto.getContent4(), "84");
		GameDTO game41 = new GameDTO(dto.getCategory(), null, null, dto.getDate2() + " 09:00",
				dto.getArea2() + dto.getStadium2(), dto.getTitle5(), dto.getContent5(), "41");
		GameDTO game42 = new GameDTO(dto.getCategory(), null, null, dto.getDate2() + " 15:00",
				dto.getArea2() + dto.getStadium2(), dto.getTitle6(), dto.getContent6(), "42");
		GameDTO game21 = new GameDTO(dto.getCategory(), null, null, dto.getDate3() + " 15:00",
				dto.getArea3() + dto.getStadium3(), dto.getTitle7(), dto.getContent7(), "21");

		BookingDTO book81 = new BookingDTO(0, 0, "admin", dto.getDate1(), 0, 0, dto.getArea1() + dto.getStadium1(),
				"09", null);
		BookingDTO book82 = new BookingDTO(0, 0, "admin", dto.getDate1(), 0, 0, dto.getArea1() + dto.getStadium1(),
				"12", null);
		BookingDTO book83 = new BookingDTO(0, 0, "admin", dto.getDate1(), 0, 0, dto.getArea1() + dto.getStadium1(),
				"15", null);
		BookingDTO book84 = new BookingDTO(0, 0, "admin", dto.getDate1(), 0, 0, dto.getArea1() + dto.getStadium1(),
				"18", null);
		BookingDTO book41 = new BookingDTO(0, 0, "admin", dto.getDate2(), 0, 0, dto.getArea2() + dto.getStadium2(),
				"09", null);
		BookingDTO book42 = new BookingDTO(0, 0, "admin", dto.getDate2(), 0, 0, dto.getArea2() + dto.getStadium2(),
				"15", null);
		BookingDTO book21 = new BookingDTO(0, 0, "admin", dto.getDate3(), 0, 0, dto.getArea3() + dto.getStadium3(),
				"15", null);

		leagueMatchDAO.write8league(game81);
		for (int i = 0; i < 2; i++) {
			book81.setBook_time(book_time[i]);
			leagueMatchDAO.writebooking(book81);
		}
		leagueMatchDAO.write8league(game82);
		leagueMatchDAO.writebooking(book82);
		leagueMatchDAO.write8league(game83);
		leagueMatchDAO.writebooking(book83);
		leagueMatchDAO.write8league(game84);
		leagueMatchDAO.writebooking(book84);

		leagueMatchDAO.writeleague(game41);
		for (int i = 0; i < 3; i++) {
			book41.setBook_time(book_time[i]);
			leagueMatchDAO.writebooking(book41);
		}
		leagueMatchDAO.writeleague(game42);
		for (int i = 3; i < 5; i++) {
			book42.setBook_time(book_time[i]);
			leagueMatchDAO.writebooking(book42);
		}

		leagueMatchDAO.writeleague(game21);
		for (int i = 0; i < 5; i++) {
			book21.setBook_time(book_time[i]);
			leagueMatchDAO.writebooking(book21);
		}

		// 리그추가가 완료되면 리그참가수락팀리스트 삭제하기
		//leagueMatchDAO.LeagueMatchDelete();

		return true;

	}

	@Override
	public int leaguecheck() {

		return leagueMatchDAO.leaguecheck();
	}

	@Override
	public int LeagueMatchSearch(String id) {

		return leagueMatchDAO.LeagueMatchSearch(id);
	}

	@Override
	public boolean LeagueMatchWrite(String id) {

		TeamDTO tdto = leagueMatchDAO.TeamSearch(id);

		LeagueMatchDTO ldto = new LeagueMatchDTO(0, tdto.getTeam_name(), id);

		return leagueMatchDAO.LeagueMatchWrite(ldto);
	}

	@Override
	public boolean LeagueResult(GameDTO dto) {
		
		boolean b = false;
		int lea = Integer.parseInt( dto.getLeague() );
		System.out.println("LeagueResult lea : " + lea);

		switch (dto.getLeague()) {
		case "81":
		case "41":
		case "83":
			//1라운드 게임 가져오기
			GameDTO g1 = leagueMatchDAO.GameSearch( lea+"" );
			//가져온데이터로 업데이트할 데이터 만들기
			g1.setLeague( (lea/2+1)+"" );
			//업데이트하기
			b = leagueMatchDAO.leagueUpdate1(g1);
			
			break;
			
		case "82":
		case "84":
		case "42":
			//2라운드 게임 가져오기
			GameDTO g2 = leagueMatchDAO.GameSearch(lea+"");
			//가져온데이터로 업데이트할 데이터 만들기
			g2.setLeague( (lea/2)+"" );
			//업데이트하기
			b = leagueMatchDAO.leagueUpdate2(g2);
			break;
		case "21":
			
			Calendar cal = Calendar.getInstance();

			String year = cal.get(Calendar.YEAR) + ""; // 현재 년도를 구함
			String month = cal.get(Calendar.MONTH) + 1 + ""; // 0 ~ 11 현재 월을 구함

			month = DateUtil.two(month);
			System.out.println("LeagueResult month : " + month);
			//업데이트하기
			b = leagueMatchDAO.leagueEnd((year+month));
			break;
		default: 
			System.out.println("리그 데이터가 정확하지 않습니다!!!");
			break;
		}

		return b;
	}

	@Override
	public AuthoritiesDTO AuthSearch(String id) {
		
		return leagueMatchDAO.AuthSearch(id);
	}

	@Override
	public boolean LeagueMatchCancel(String id) {
		
		return leagueMatchDAO.LeagueMatchCancel(id);
	}

	@Override
	public TeamDTO ChatTeamCheck(String id) {
		
		return leagueMatchDAO.ChatTeamCheck(id);
	}

	@Override
	public NoChatDTO NoChatSearch(String id) {
		
		return leagueMatchDAO.NoChatSearch(id);
	}

	@Override
	public boolean NoChatStart(NoChatDTO dto) {
		
		boolean b = false;
		
		if(dto.getNo_count() == 0) {
			//처음 금지먹은사람
			b = leagueMatchDAO.NoChatWrite(dto);
		}else {
			//여러번인사람
			b = leagueMatchDAO.NoChatUpdate(dto);
		}
		
		return b;
	}

	@Override
	public boolean NoChatEnd(NoChatDTO dto) {
		
		return leagueMatchDAO.NoChatEnd(dto);
	}
	
	
	

}
