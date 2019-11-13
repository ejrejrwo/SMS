package com.boot.finalpro.mypage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.member.model.SMS_MemberDTO;
import com.boot.finalpro.mypage.model.ExchangeDTO;
import com.boot.finalpro.mypage.model.MessageBlackListDTO;
import com.boot.finalpro.mypage.model.MessageDTO;
import com.boot.finalpro.mypage.model.ProfitDTO;
import com.boot.finalpro.mypage.model.SpendDTO;
import com.boot.finalpro.mypage.util.BbsParam;
import com.boot.finalpro.mypage.util.MyBetParam;
import com.boot.finalpro.team.model.TeamApplicationDTO;
import com.boot.finalpro.teambbs.model.TeamBBSDTO;

public interface MyPageService {
	
	// 개인정보 변경
	public void UpdateMemberInfo(MemberDTO member);
	// 개인정보 변경(시큐리티)
	public void updateSMSMemberInfo(SMS_MemberDTO SMS);
	// 개인정보 수정
	public MemberDTO findOneMemberById(String id);
	// 돈 정보 변환
	public void ChangeInfoMoney(MemberDTO member);
	// 개인정보삭제
	public void deleteById(String id);
	// 내 쪽지 리스트
	public List<MessageDTO> findAllSendMessageListById(BbsParam param);
	// 내 쪽지 리스트 갯수
	public int findAllSendMessageCountById(BbsParam param);
	// 쪽지 디테일
	public MessageDTO findOneMessageBySeq(int seq);
	// 쪽지 읽음 여부
	public void UpdateReadingBySeq(int seq);
	// 쪽지 작성
	public boolean SaveMessage(MessageDTO msg);
	// 내 게시판
	public List<TeamBBSDTO> findAllBBSListById(BbsParam param);
	// 내 게시판 리스트 갯수
	public int findAllBBSCountById(BbsParam param);
	// 내 좋아요 리스트
	public List<TeamBBSDTO> findAllLikeListById(BbsParam param);
	// 내 좋아요 리스트 갯수
	public int findAllLikeCountById(BbsParam param);
	// 베팅 목록 리스트
	public List<MyBetParam> findAllBetListById(BbsParam param);
	// 베팅 목록 리스트 갯수
	public int findAllBetCountById(String id);
	// 환전신청
	public void saveExchange(ExchangeDTO exchange);
	// 환전 리스트
	public List<ExchangeDTO> findAllExchangeListById(BbsParam param);
	// 환전 리스트 갯수
	public int findAllExchangeCountById(String id);
	// 환전중 인지 여부
	public int exchangeCheckCountById(String id);
	// 환전 요청시 잔액 변경
	public void updateMoneyById(ExchangeDTO exchange);
	// 송신함 리스트
	public List<MessageDTO> findAllReceiveMessageListById(BbsParam param);
	// 송신함 리스트 갯수
	public int findAllReceiveMessageCountById(BbsParam param);
	// 작성자 쪽지삭제
	public void deleteSendMessageBySeq(int seq);
	// 수신자 쪽지삭제
	public void deleteReceiveMessageBySeq(int seq);
	// 수익추가
	public void saveProfit(ProfitDTO profit);
	// 지출추가
	public void saveSpend(SpendDTO spend);
	// 멤버 충전내역 리스트
	public List<ProfitDTO> findAllPayInfoListById(BbsParam param);
	// 멤버 충전내역 카운트
	public int findAllPayInfoCountById(String id);
	// 쪽지 작성 아이디 체크
	public boolean receiveIdCheck(MessageDTO msg);
	// 쪽지 작성 아이디 실시간 체크
	public List<String> FindMessageIdById(Map<String, Object> memberMap);
	// 신청 팀 목록
	public List<TeamApplicationDTO> findByMyAppList(BbsParam param);
	// 신청 팀 목록 카운트
	public int findByMyAppListCount(String id);
	// 신청 팀 목록 삭제
	public void deleteTeamApplicationBySeq(int seq);
	// 수신 쪽지 체크박스 삭제
	public void deleteAllSendMessageBySeq(Map<String, Integer> msgDelMap);
	// 송신 쪽지 체크박스 삭제
	public void deleteAllReceiveMessageBySeq(Map<String, Integer> seqs);
	// 쪽지 수신차단여부
	public boolean findMessageBlacklist(MessageDTO msg);
	// 쪽지 수신거부 등록여부
	public boolean findMessageIsBlacklist(MessageDTO msg);
	// 쪽지 수신거부 등록
	public void saveMessageBlacklist(MessageDTO msg);
	// 쪽지 수신거부 해제
	public void deleteMessageBlacklist(MessageDTO msg);
	// 수신거부 목록
	public int findAllBlackListCount(String userid);
	// 수신거부 목록 리스트
	public List<MessageBlackListDTO> findAllBlackListById(BbsParam param);
	// 권한조회
	public String findAuthByid(String id);
}
