package com.boot.finalpro.mypage.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.mypage.dao.MyPageRepository;
import com.boot.finalpro.mypage.model.MemberVO;
import com.boot.finalpro.mypage.model.MessageDTO;
import com.boot.finalpro.mypage.model.ProfitDTO;
import com.boot.finalpro.mypage.service.MyPageService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/mypage/*")
public class MyPageRestController {
	
	@Autowired
	MyPageService myPageService;
	// 돈 충전
	@GetMapping("/changeInFoMoney.do")
	public void changeInFoMoney(MemberDTO member) {

		log.info("MyPageController changeInFoMoney in");
		log.info("money : " + member.getMoney() + member.getId());

		// 멤버 돈추가
		myPageService.ChangeInfoMoney(member);
		
		ProfitDTO profit = new ProfitDTO();
		profit.setId(member.getId());
		profit.setProfit_money(member.getMoney());
		
		// 이익테이블 추가
		myPageService.saveProfit(profit);
	}
	// msgAutocompleate...(자동완성 jquery 기능)
	@GetMapping("msgAutocompleate.do")
	public List<String> json(String value, Principal pcp) {
		
		log.info("myPageController msgAutocompleate IN");
		
		log.info(value);
		// db에 접속시켜 돌려줄 데이터
		Map<String, Object> memberMap = new HashMap<String, Object>();
		
		memberMap.put("value", value);
		memberMap.put("id", pcp.getName());
		
		List<String> member = myPageService.FindMessageIdById(memberMap);
		
		log.info("member to String" + member.toString());
		
		return member;
	}
	// 메세지 작성시 상대방 아이디 존재 유무 체크
	@GetMapping("receiveIdCheck.do")
	public String receiveIdCheck(MessageDTO msg) {
		
		log.info("CommonController receiveIdCheck in");
		log.info("msg = " + msg.toString());
		
		boolean b = myPageService.receiveIdCheck(msg);

		if(b) {
			// 데이터가 있는경우
			log.info("CommonController receiveIdCheck true");
			return "true";
		}
		// 데이터가 없는경우
		log.info("CommonController receiveIdCheck false");
		return "false";
	}
	// 팝업으로 메세지 전송해서 ajax로 데이터 입력후 팝업 닫기
	@RequestMapping(value="/myPageWriteMessageSuc.do", method = {RequestMethod.POST, RequestMethod.GET})
	public String myPageSendMessageSuc(MessageDTO msg) {
		
		log.info("MyPageController myPageSendMessageSuc in");
		log.info("msg" + msg.toString());
		
		boolean blacklist = myPageService.findMessageBlacklist(msg);
		
		log.info("blacklist" + blacklist);
		
		if(blacklist) {
			return "true";
		}
		log.info("blacklist 통과");
		
		boolean bb = myPageService.SaveMessage(msg);
		
		if(bb) {
			log.info("bb tt");
			return "true";
		}
		
		return "false";

	}
	// 쪽지 차단
	@GetMapping("mypageMessageReceiveStat.do")
	public String mypageMessageReceiveStat(MessageDTO msg, Principal pcp) {
		
		log.info("myPageController mypageMessageReceiveStat in");

		String userid = pcp.getName();
		msg.setReceive_id(userid);
		
		log.info("msg :" + msg.toString());
		
		// 수신여부 확인
		boolean b = myPageService.findMessageIsBlacklist(msg);
		
		if(b) {
			// 수신거부가 되있으면 풀어준다.
			myPageService.deleteMessageBlacklist(msg);
			return "N";
		}
		// 수신거부가 안되어있으면 수신거부를 해준다.
		myPageService.saveMessageBlacklist(msg);
		
		return "Y";
	}
	// blacklist delete
	@GetMapping("myPageBlacklistDelete.do")
	public String myPageBlacklistDelete(MessageDTO msg, Principal pcp) {

		log.info("myPageController myPageBlacklistDelete in");
		
		String userid = pcp.getName();
		msg.setReceive_id(userid);
		
		myPageService.deleteMessageBlacklist(msg);
		
		return "Suc";
	}
}
