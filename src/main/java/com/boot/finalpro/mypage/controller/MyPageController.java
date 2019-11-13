package com.boot.finalpro.mypage.controller;

import java.security.Principal;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.member.model.SMS_MemberDTO;
import com.boot.finalpro.mypage.dao.MyPageRepository;
import com.boot.finalpro.mypage.model.ExchangeDTO;
import com.boot.finalpro.mypage.model.MemberVO;
import com.boot.finalpro.mypage.model.MessageBlackListDTO;
import com.boot.finalpro.mypage.model.MessageDTO;
import com.boot.finalpro.mypage.model.ProfitDTO;
import com.boot.finalpro.mypage.model.SpendDTO;
import com.boot.finalpro.mypage.service.MyPageService;
import com.boot.finalpro.mypage.util.BbsParam;
import com.boot.finalpro.mypage.util.MyBetParam;
import com.boot.finalpro.team.model.TeamApplicationDTO;
import com.boot.finalpro.teambbs.model.TeamBBSDTO;
import com.boot.finalpro.util.utilMethod;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage/*")
@EnableCaching
public class MyPageController {

	// service
	@Autowired
	MyPageService myPageService;
	
	// security encoder
	@Autowired
	BCryptPasswordEncoder bc;
	
	// jpa
	@Autowired
	MyPageRepository myPageRepository;
	
	
	// 마이페이지 메인이동
//	@GetMapping("/myPageMain.do")
//	public ModelAndView myPageMain(Principal pcp) {
//		
//		log.info("MyPageController myPageMain in");
//		
//		String userId = pcp.getName();
//		
//		MemberDTO member = myPageService.findOneMemberById(userId);
//		
//		ModelAndView myMav = new ModelAndView();
//		myMav.setViewName("myPageMain.tiles");
//		myMav.addObject("member", member);
//		
//		return myMav; 
//	}
		
	// 마이페이지 메인이동
	@GetMapping("/myPageMain.do")
	public ModelAndView myPageMain(Principal pcp) {
		
		log.info("MyPageController myPageMain in");
		
		String userId = pcp.getName();
		
		Optional<MemberVO> member = myPageRepository.findById(userId);
		
		ModelAndView myMav = new ModelAndView();
		myMav.setViewName("myPageMain.tiles");
		myMav.addObject("member", member.get());
		
		return myMav;
		
	}
	// 결제 페이지 이동
	@GetMapping("/myPagePay.do")
	public ModelAndView myPagePay(Principal pcp) {

		log.info("MyPageController myPagePay in");
		
		String userId = pcp.getName();
		Optional<MemberVO> member = myPageRepository.findById(userId);
		
		ModelAndView payMav = new ModelAndView();
		payMav.setViewName("payPage.tiles");
		payMav.addObject("member", member.get());
		payMav.addObject("InsertTitle", "마이페이지 결제");
		
		return payMav;
	}
	// 결제 데이터 받기
	@GetMapping("/payMoney.do")
	public ModelAndView payMoney(String payThing, String payMoney, Principal pcp) {

		log.info("MyPageController payMoney in");
		log.info("thing :" + payThing + "money :" + payMoney);
		
		String userId = pcp.getName();
		// 콤마 없애주기
		String payMoney2 = payMoney.replace(",", "");
		// 형변환
		int money = Integer.parseInt(payMoney2);
		
		// 예외 머니
		MemberDTO member = myPageService.findOneMemberById(userId);
		member.setMoney(money);
		
		log.info("member :" + member.toString());
		log.info("payThing :" + payThing);
		
	    ModelAndView moneyMav = new ModelAndView();
	    moneyMav.addObject("member", member);
	    moneyMav.addObject("payThing", payThing);
	    moneyMav.setViewName("/myPage/myPagePayAf");

		return moneyMav;
	}
	// 보낸 메시지함 들어가기
	@RequestMapping(value = "/myPageSendMessage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView messagePage(BbsParam param, Principal pcp) throws ParseException {
						
		String userId = pcp.getName();
		Optional<MemberVO> member = myPageRepository.findById(userId);
		
		param.setId(userId);
		
		log.info("MyPageController messagePage in" + param.toString());
		
		ModelAndView messageMav = new ModelAndView();
		messageMav.setViewName("myPageSendMessage.tiles");
		
		// paging 처리
		int sn = param.getPageNumber(); // 0 1 2
		int start = sn * param.getRecordCountPerPage() + 1; // 1 11
		int end = (sn + 1) * param.getRecordCountPerPage(); // 10 20

		param.setStart(start);
		param.setEnd(end);
		
		BbsParam ppp = param;
		

		List<MessageDTO> msgList = null;
		msgList = myPageService.findAllSendMessageListById(ppp);
		 
		
		// 글의 총수
		int totalRecordCount = myPageService.findAllSendMessageCountById(param);
		
//		for (MessageDTO messageDTO : msgList) {
//			String wdate = utilMethod.dateEdit(messageDTO.getWdate());
//			messageDTO.setWdate(wdate);
//			String rdate = utilMethod.dateEdit(messageDTO.getRdate());
//			messageDTO.setRdate(rdate);
//		}

		messageMav.addObject("msgList", msgList);
		messageMav.addObject("id", param.getId());
		messageMav.addObject("pageNumber", sn);
		messageMav.addObject("pageCountPerScreen", 10);
		messageMav.addObject("recordCountPerPage", param.getRecordCountPerPage());
		messageMav.addObject("totalRecordCount", totalRecordCount);
		messageMav.addObject("s_keyword", param.getS_keyword());
		messageMav.addObject("s_category", param.getS_category());
		messageMav.addObject("member", member.get());
		messageMav.addObject("InsertTitle", "마이페이지 송신함");
		
		return messageMav;
	}
	
	// 내가 보낸 쪽지함 디테일 이동
	@GetMapping("/myPageSendMessageDetail.do")
	public ModelAndView messageDetail(int seq) {
		log.info("MyPageController messageDetail in");
		MessageDTO msgDTO = myPageService.findOneMessageBySeq(seq);
		
		ModelAndView msgDetailMav = new ModelAndView();
		msgDetailMav.addObject("msgDTO", msgDTO);
		msgDetailMav.addObject("seq", seq);
		
		msgDetailMav.setViewName("myPageSendMessageDetail.tiles");
		
		return msgDetailMav;
	}
	// 내가 보낸 쪽지함 삭제
	@GetMapping("/myPageSendMessagez.do")
	public String messageDelete(int seq) {
		
		log.info("MyPageController messageDelete in" + seq);
//		myPageService.deleteMessageBySeq(seq);
		
		myPageService.deleteSendMessageBySeq(seq);
		
		return "redirect:/mypage/myPageSendMessage.do";
	}
	// 수신함 쪽지함
	@RequestMapping(value = "/myPageReceiveMessage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView messageReceivePage(BbsParam param, Principal pcp) {
		
		
		String userId = pcp.getName();
		param.setId(userId);
		log.info("MyPageController messageRcseivePage in" + param.toString());

		ModelAndView messageMav = new ModelAndView();
		messageMav.setViewName("myPageReceiveMessage.tiles");

		// paging 처리
		int sn = param.getPageNumber(); // 0 1 2
		int start = sn * param.getRecordCountPerPage() + 1; // 1 11
		int end = (sn + 1) * param.getRecordCountPerPage(); // 10 20

		param.setStart(start);
		param.setEnd(end);

		// 조건의 맞는 모든 글
		List<MessageDTO> msgList = myPageService.findAllReceiveMessageListById(param);
		// 글의 총수
		int totalRecordCount = myPageService.findAllReceiveMessageCountById(param);
		
		Optional<MemberVO> member = myPageRepository.findById(userId);
		
		for (MessageDTO messageDTO : msgList) {
			String wdate = utilMethod.dateEdit(messageDTO.getWdate());
			messageDTO.setWdate(wdate);
//			String rdate = utilMethod.dateEdit(messageDTO.getRdate());
//			messageDTO.setRdate(rdate);
		}

		messageMav.addObject("msgList", msgList);
		messageMav.addObject("id", param.getId());
		messageMav.addObject("pageNumber", sn);
		messageMav.addObject("pageCountPerScreen", 10);
		messageMav.addObject("recordCountPerPage", param.getRecordCountPerPage());
		messageMav.addObject("totalRecordCount", totalRecordCount);
		messageMav.addObject("s_keyword", param.getS_keyword());
		messageMav.addObject("s_category", param.getS_category());
		messageMav.addObject("member", member.get());
		messageMav.addObject("InsertTitle", "마이페이지 수신함");
		
		return messageMav;
	}
	// 수신한 쪽지함 디테일
	@GetMapping("/myPageReceiveMessageDetail.do")
	public ModelAndView messageReceiveDetail(int seq) {
		log.info("MyPageController myPageSendMessageDetail in");
		MessageDTO msgDTO = myPageService.findOneMessageBySeq(seq);
		myPageService.UpdateReadingBySeq(seq);
		
		boolean b = myPageService.findMessageIsBlacklist(msgDTO);
		
		ModelAndView msgDetailMav = new ModelAndView();
		
		if(b) {
			msgDetailMav.addObject("block", "block");
		}

		msgDetailMav.addObject("msgDTO", msgDTO);
		msgDetailMav.addObject("seq", seq);
		msgDetailMav.addObject("noBlock", "noBlock");
		msgDetailMav.setViewName("myPageReceiveMessageDetail.tiles");
		
		return msgDetailMav;
	}
	// 수신한 쪽지함 삭제
	@GetMapping("/myPageReseiveMessageDelete.do")
	public String messageReceiveDelete(int seq) {
		
		log.info("MyPageController myPageReseiveMessageDelete in" + seq);
		
		myPageService.deleteReceiveMessageBySeq(seq);
		
		return "redirect:/mypage/myPageReceiveMessage.do";
	}
	// 쪽지 작성
	@GetMapping("/myPageWriteMessage.do")
	public ModelAndView myPageWriteMessage(Principal pcp) {
		
		log.info("MyPageController myPageWriteMessage in");
		
		String userId = pcp.getName();
		Optional<MemberVO> member = myPageRepository.findById(userId);
		
		ModelAndView writeMav = new ModelAndView();
		writeMav.setViewName("myPageWriteMessage.tiles");
		writeMav.addObject("id", pcp.getName());
		writeMav.addObject("member", member.get());
		
		return writeMav;
	}
	// 수신한 편지 디테일에서 답장하기
	@GetMapping("/myPageAnswerMessage.do")
	public ModelAndView myPageAnswerMessage(String send_id, Principal pcp) {
		
		log.info("MyPageController myPageAnswerMessage in");
		
		ModelAndView answerMav = new ModelAndView();
		answerMav.setViewName("myPageAnswerMessage.tiles");
		answerMav.addObject("receive_id", send_id);
		answerMav.addObject("id", pcp.getName());
		
		return answerMav;
	}
	// 내 개인정보 접근
	@GetMapping("/myPageInfo.do")
	public ModelAndView myInfo(Principal pcp) {

		log.info("MyPageController myInfo in");

		String userId = pcp.getName();
		
		ModelAndView detailMav = new ModelAndView();

		long startCache = System.currentTimeMillis(); // 수행시간 측정	

		MemberDTO member = myPageService.findOneMemberById(userId);
		
		log.info("member : " + member.toString());
		
		detailMav.addObject("member", member);
		detailMav.setViewName("myPageInfo.tiles");
		detailMav.addObject("InsertTitle", "마이페이지 개인정보");
		
		long endChace = System.currentTimeMillis();
		log.info("MyPageController messagePage Cache 수행시간 :" + Long.toString(endChace-startCache));
		
		return detailMav;
	}
	// 개인정보 수정
	@PostMapping("/infoChange.do")
	public ModelAndView infoChange(MemberDTO member, Principal pcp) {
		
		String userId = pcp.getName();
		member.setId(userId);
		
		log.info("MyPageController infoChange in");
		log.info("member nos" + member.toString());

		String pwd = bc.encode(member.getPwd());
		SMS_MemberDTO SMS = new SMS_MemberDTO();
		SMS.setUserpw(pwd);
		SMS.setUserid(member.getId());
		// 기본 정보수정
		myPageService.UpdateMemberInfo(member);
		// 패스워드 수정시 시큐리티 수정
		myPageService.updateSMSMemberInfo(SMS);

		ModelAndView changeMav = new ModelAndView();
		changeMav.setViewName("redirect:/mypage/myPageMain.do");

		return changeMav;
	}
	
	// 계정 탈퇴
	@GetMapping("/infoDelete.do")
	public String infoDelete(Principal pcp) {
		
		log.info("MyPageController infoDelete in");
		
		String userId = pcp.getName();
		// 권한조회
		String auth = myPageService.findAuthByid(userId);
		
		if(auth.equals("ROLE_MEMBER")) {
			log.info("role_member in");
			// 삭제 및 로그인페이지
			myPageService.deleteById(userId);
			return "redirect:/common/loginPage.do";
		}
		// 팀 내역이동
		log.info("role_another");
		return "redirect:/mypage/teamapplication.do";
			
	}

	// 내가 작성한 게시물
	@RequestMapping(value = "/myPageBBS.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView bbsList(BbsParam param, Principal pcp) {
		
		String userId = pcp.getName();
		param.setId(userId);
		
		log.info("MyPageController bbslist ");
		log.info("bbsparam " + param.toString());
		log.info("asdasdas" + param.getId());
		// paging 처리
		int sn = param.getPageNumber(); // 0 1 2
		int start = sn * param.getRecordCountPerPage() + 1; // 1 11
		int end = (sn + 1) * param.getRecordCountPerPage(); // 10 20

		param.setStart(start);
		param.setEnd(end);

		// 조건의 맞는 모든 글
		List<TeamBBSDTO> bbsList = myPageService.findAllBBSListById(param);
		// 글의 총수
		int totalRecordCount = myPageService.findAllBBSCountById(param);
		// myPageTopMenu
		Optional<MemberVO> member = myPageRepository.findById(userId);
		
		for (TeamBBSDTO teamBBSDTO : bbsList) {
			String date = utilMethod.dateEdit(teamBBSDTO.getWdate());
			teamBBSDTO.setWdate(date);
		}

		ModelAndView BBSMav = new ModelAndView();
		BBSMav.setViewName("myBBS.tiles");

		BBSMav.addObject("bbsList", bbsList);
		BBSMav.addObject("id", param.getId());
		BBSMav.addObject("pageNumber", sn);
		BBSMav.addObject("pageCountPerScreen", 10);
		BBSMav.addObject("recordCountPerPage", param.getRecordCountPerPage());
		BBSMav.addObject("totalRecordCount", totalRecordCount);
		BBSMav.addObject("s_keyword", param.getS_keyword());
		BBSMav.addObject("s_category", param.getS_category());
		BBSMav.addObject("member", member.get());
		BBSMav.addObject("InsertTitle", "마이페이지 내 작성 게시물");

		return BBSMav;
	}

	// 내가 좋아요 누른 게시물
	@RequestMapping(value = "/myPageLike.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView likeList(BbsParam param, Principal pcp) {

		String userId = pcp.getName();
		param.setId(userId);
		
		log.info("MyPageController likeList in ");
		log.info("bbsparam " + param.toString());
		log.info("asdasdas" + param.getId());
		// paging 처리
		int sn = param.getPageNumber(); // 0 1 2
		int start = sn * param.getRecordCountPerPage() + 1; // 1 11
		int end = (sn + 1) * param.getRecordCountPerPage(); // 10 20

		param.setStart(start);
		param.setEnd(end);

		// 조건의 맞는 모든 글
		List<TeamBBSDTO> likeList = myPageService.findAllLikeListById(param);
		// 글의 총수
		int totalRecordCount = myPageService.findAllLikeCountById(param);
		// mypageTopMenu
		Optional<MemberVO> member = myPageRepository.findById(userId);
		
		for (TeamBBSDTO teamBBSDTO : likeList) {
			String date = utilMethod.dateEdit(teamBBSDTO.getWdate());
			teamBBSDTO.setWdate(date);
		}

		ModelAndView likeMav = new ModelAndView();
		likeMav.setViewName("myLike.tiles");

		likeMav.addObject("likeList", likeList);
		likeMav.addObject("id", param.getId());
		likeMav.addObject("pageNumber", sn);
		likeMav.addObject("pageCountPerScreen", 10);
		likeMav.addObject("recordCountPerPage", param.getRecordCountPerPage());
		likeMav.addObject("totalRecordCount", totalRecordCount);
		likeMav.addObject("s_keyword", param.getS_keyword());
		likeMav.addObject("s_category", param.getS_category());
		likeMav.addObject("member", member.get());
		likeMav.addObject("InsertTitle", "마이페이지 내 좋아요 게시물");
		
		return likeMav;
	}

	// 내 베팅 목록 가져오기
	@RequestMapping(value = "/myPageBet.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView betList(BbsParam param, Principal pcp) {

		String userId = pcp.getName();
		param.setId(userId);
		
		log.info("MyPageController myPageBetList in ");
		log.info("param " + param.toString());
		log.info("id" + param.getId());
		// paging 처리
		int sn = param.getPageNumber(); // 0 1 2
		int start = sn * param.getRecordCountPerPage() + 1; // 1 11
		int end = (sn + 1) * param.getRecordCountPerPage(); // 10 20

		param.setStart(start);
		param.setEnd(end);

		// 조건의 맞는 모든 글
		List<MyBetParam> betList = myPageService.findAllBetListById(param);
		// 글의 총수
		int totalRecordCount = myPageService.findAllBetCountById(param.getId());
		// myPageTopMenu
		Optional<MemberVO> member = myPageRepository.findById(userId);

		ModelAndView betMav = new ModelAndView();
		betMav.setViewName("myBet.tiles");

		betMav.addObject("betList", betList);
		betMav.addObject("id", param.getId());
		betMav.addObject("pageNumber", sn);
		betMav.addObject("pageCountPerScreen", 10);
		betMav.addObject("recordCountPerPage", param.getRecordCountPerPage());
		betMav.addObject("totalRecordCount", totalRecordCount);
		betMav.addObject("member", member.get());

		return betMav;

	}
	// 환전 페이지 이동
	@GetMapping("/myPageExchangePage.do")
	public ModelAndView myPageExchangePage(Principal pcp) {
		
		String userId = pcp.getName();
		
		log.info("MyPageController myPageExchangePage in ");
		
		ModelAndView exchangeMav = new ModelAndView();
		
		// 환전데이터
		Optional<MemberVO> member = myPageRepository.findById(userId);
		// 환전데이터 숫자
		int count = myPageService.exchangeCheckCountById(userId);
		
		// 기존의 환전 내역 없는경우
		if(count == 0) {
			exchangeMav.addObject("member", member.get());
			exchangeMav.setViewName("exchange.tiles");
			
			return exchangeMav;
		}
		// 기존 환전내역 있는경우 환전정보 페이지로 이동
		exchangeMav.setViewName("redirect:/mypage/myPageExchangeInfo.do");
		
		return exchangeMav;
		
	}
	// 환정신청
	@PostMapping("/myPageExchange.do")
	public String myPageExchange(ExchangeDTO exchange) {
		
		log.info("MyPageController myPageExchange in");
		
		// 환전 신청 ( 신청만 )
		myPageService.saveExchange(exchange);
		
		// 멤버 환전 ( member 잔액 차감 )
		myPageService.updateMoneyById(exchange);
		
		SpendDTO spend = new SpendDTO();
		spend.setId(exchange.getId());
		spend.setSpend_money(exchange.getExchange_money());

		// 환전 테이블 추가
		myPageService.saveSpend(spend);
		
		return "redirect:/mypage/myPageMain.do";
	}
	// 내 환전내역 페이지
	@RequestMapping(value = "/myPageExchangeInfo.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView myPageExchangeInfo(BbsParam param, Principal pcp) {
		
		String userId = pcp.getName();
		param.setId(userId);
		
		log.info("MyPageController myPageExchangeInfo in");
		log.info("파람은?" + param.toString());
		
		ModelAndView exchangeMav = new ModelAndView();
		exchangeMav.setViewName("exchangeInfo.tiles");
		int sn = param.getPageNumber(); // 0 1 2
		int start = sn * param.getRecordCountPerPage() + 1; // 1 11
		int end = (sn + 1) * param.getRecordCountPerPage(); // 10 20

		param.setStart(start);
		param.setEnd(end);
		// 내 환전내역 데이터
		List<ExchangeDTO> exchangeList = myPageService.findAllExchangeListById(param);
		// 내 환전내역 데이터 숫자
		int totalRecordCount = myPageService.findAllExchangeCountById(param.getId());
		// myPageTopMenu
		Optional<MemberVO> member = myPageRepository.findById(userId);
		
		exchangeMav.addObject("exchangeList", exchangeList);
		exchangeMav.addObject("id", param.getId());
		exchangeMav.addObject("pageNumber", sn);
		exchangeMav.addObject("pageCountPerScreen", 10);
		exchangeMav.addObject("recordCountPerPage", param.getRecordCountPerPage());
		exchangeMav.addObject("totalRecordCount", totalRecordCount);
		exchangeMav.addObject("member", member.get());
		
		return exchangeMav;
		
	}
	// 내 결제 내역
	@RequestMapping(value = "/myPagePayInfo.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView myPagePayInfo(BbsParam param, Principal pcp) {
		
		String userId = pcp.getName();
		param.setId(userId);
		
		log.info("MyPageController myPagePayInfo in" + param.toString());
		
		ModelAndView payInfoMav = new ModelAndView();
		payInfoMav.setViewName("myPayInfo.tiles");

		int sn = param.getPageNumber(); // 0 1 2
		int start = sn * param.getRecordCountPerPage() + 1; // 1 11
		int end = (sn + 1) * param.getRecordCountPerPage(); // 10 20
		
		param.setStart(start);
		param.setEnd(end);
		// 내 결제내역 데이터
		List<ProfitDTO> profitList = myPageService.findAllPayInfoListById(param);
		// 내 결제내역 데이터 숫자
		int totalRecordCount = myPageService.findAllPayInfoCountById(param.getId());
		// myPageTopMenu
		Optional<MemberVO> member = myPageRepository.findById(userId);
		
		for (ProfitDTO profitDTO : profitList) {
			String date = utilMethod.dateEdit(profitDTO.getPdate());
			profitDTO.setPdate(date);
		}
		
		payInfoMav.addObject("profitList", profitList);
		payInfoMav.addObject("id", param.getId());
		payInfoMav.addObject("pageNumber", sn);
		payInfoMav.addObject("pageCountPerScreen", 10);
		payInfoMav.addObject("recordCountPerPage", param.getRecordCountPerPage());
		payInfoMav.addObject("totalRecordCount", totalRecordCount);
		payInfoMav.addObject("member", member.get());
		
		return payInfoMav;
	}
	
	// 내 신청 팀목록
	@RequestMapping(value = "/myPageTeamAppInfo.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView myPageTeamAppInfo(BbsParam param, Principal pcp) {
		
		log.info("MyPageController myPageTeamAppInfo in" + param.toString());
		
		ModelAndView teamAppMav = new ModelAndView();
		teamAppMav.setViewName("myPageTeamAppInfo.tiles");
		
		String userId = pcp.getName();	// 아이디
		int sn = param.getPageNumber();	// 현재 페이지
		int start = sn * param.getRecordCountPerPage();	// 페이징 보이는거
		int end = (sn + 1) * param.getRecordCountPerPage();	// 페이지당 글 갯수
		
		param.setId(userId);
		param.setStart(start);
		param.setEnd(end);
		// 내 신청 팀목록 데이터
		List<TeamApplicationDTO> teamAppList = myPageService.findByMyAppList(param);
		// 내 신청 팀목록 데이터 숫자
		int totalRecordCount = myPageService.findByMyAppListCount(userId);
		// myPageTopMenu
		Optional<MemberVO> member = myPageRepository.findById(userId);
		
		teamAppMav.addObject("teamAppList", teamAppList);
		teamAppMav.addObject("pageNumber", sn);
		teamAppMav.addObject("pageCountPerScreen", 10);
		teamAppMav.addObject("recordCountPerPage", param.getRecordCountPerPage());
		teamAppMav.addObject("totalRecordCount", totalRecordCount);
		teamAppMav.addObject("member", member.get());
		
		return teamAppMav;
	}
	// 내 신청 팀목록 삭제
	@GetMapping("/myPageTeamAppDelete.do")
	public String myPageTeamAppDelete(int seq) {
		
		log.info("MyPageController myPageTeamAppDelete in");
		
		myPageService.deleteTeamApplicationBySeq(seq);
		
		return "redirect:/mypage/myPageTeamAppInfo.do";
	}
	
	// 송신쪽지 단체 삭제
	@PostMapping("/myPageAllSendMessageDelete.do")
	public String allSendMessageDelete(HttpServletRequest req) {
		
		log.info("MyPageController allSendMessageDelete in");
		
		String[] StringSeqs = req.getParameterValues("msgCheck");
		int[] seqs = new int[StringSeqs.length];
		
		Map<String, Integer> msgDelMap = new HashMap<String, Integer>();
		
		for (int i = 0; i < StringSeqs.length; i++) {
			log.info("seqs :" + StringSeqs[i]);
			seqs[i] = Integer.parseInt(StringSeqs[i]);
			msgDelMap.put("seq", seqs[i]);
			myPageService.deleteAllSendMessageBySeq(msgDelMap);
		}
		
		return "redirect:/mypage/myPageSendMessage.do";
	}
		
	// 수신쪽지 단체 삭제
	@PostMapping("/myPageAllReceiveMessageDelete.do")
	public String allReceiveMessageDelete(HttpServletRequest req) {
		
		log.info("MyPageController allReceiveMessageDelete in");
		
		String[] StringSeqs = req.getParameterValues("msgCheck");
		int[] seqs = new int[StringSeqs.length];
		
		Map<String, Integer> msgDelMap = new HashMap<String, Integer>();
		
		for (int i = 0; i < StringSeqs.length; i++) {
			seqs[i] = Integer.parseInt(StringSeqs[i]);
			msgDelMap.put("seq", seqs[i]);
			myPageService.deleteAllReceiveMessageBySeq(msgDelMap);
		}
		return "redirect:/mypage/myPageReceiveMessage.do";
	}
	// blacklist
	@RequestMapping(value = "/myPageBlacklist.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView myPageBlacklist(BbsParam param, Principal pcp) {
		
		log.info("myPageController myPageBlacklist in");
		// session id
		String userId = pcp.getName();
		param.setId(userId);
		
		int sn = param.getPageNumber(); // 0 1 2
		int start = sn * param.getRecordCountPerPage() +1; // 1 11
		int end = ( sn+1 ) * param.getRecordCountPerPage(); // 10 20
				
		param.setStart(start);
		param.setEnd(end);
		
		log.info("parma" + param.toString());
		
		// 쪽지 블랙리스트 숫자
		int totalRecordCount = myPageService.findAllBlackListCount(userId);
		// 쪽지 블랙리스트 데이터
		List<MessageBlackListDTO> blacklist = myPageService.findAllBlackListById(param);
		// member 정보
		Optional<MemberVO> member = myPageRepository.findById(userId);
		
		ModelAndView blackMav = new ModelAndView();
		blackMav.setViewName("/myPage/myPageBlacklist");
		blackMav.addObject("blacklist", blacklist);
		blackMav.addObject("id", param.getId());
		blackMav.addObject("pageNumber", sn);
		blackMav.addObject("totalRecordCount", totalRecordCount);
		blackMav.addObject("pageCountPerScreen", 10);
		blackMav.addObject("recordCountPerPage", param.getRecordCountPerPage());
		blackMav.addObject("s_keyword", param.getS_keyword());
		blackMav.addObject("member", member.get());
		
		return blackMav;
	}
	
}
