package com.boot.finalpro.mypage.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.member.model.SMS_MemberDTO;
import com.boot.finalpro.mypage.dao.MyPageDAO;
import com.boot.finalpro.mypage.model.ExchangeDTO;
import com.boot.finalpro.mypage.model.MessageBlackListDTO;
import com.boot.finalpro.mypage.model.MessageDTO;
import com.boot.finalpro.mypage.model.ProfitDTO;
import com.boot.finalpro.mypage.model.SpendDTO;
import com.boot.finalpro.mypage.service.MyPageService;
import com.boot.finalpro.mypage.util.BbsParam;
import com.boot.finalpro.mypage.util.MyBetParam;
import com.boot.finalpro.team.model.TeamApplicationDTO;
import com.boot.finalpro.teambbs.model.TeamBBSDTO;

@Service
public class MyPageServiceImpl implements MyPageService {

	@Autowired
	MyPageDAO myPageDAO;

	@Override
	public void UpdateMemberInfo(MemberDTO member) {
		myPageDAO.UpdateMemberInfo(member);
	}
	
	@Override
	public void updateSMSMemberInfo(SMS_MemberDTO SMS) {
		myPageDAO.updateSMSMemberInfo(SMS);
	}

	@Override
	public MemberDTO findOneMemberById(String id) {
		return myPageDAO.findOneMemberById(id);
	}

	@Override
	public void ChangeInfoMoney(MemberDTO member) {
		myPageDAO.ChangeInfoMoney(member);
	}

	@Override
	public void deleteById(String id) {
		myPageDAO.deleteById(id);
	}
	
	@Override
	public List<MessageDTO> findAllSendMessageListById(BbsParam param) {
		return myPageDAO.findAllSendMessageListById(param);
	}

	@Override
	public int findAllSendMessageCountById(BbsParam param) {
		return myPageDAO.findAllSendMessageCountById(param);
	}

	@Override
	public MessageDTO findOneMessageBySeq(int seq) {
		return myPageDAO.findOneMessageBySeq(seq);
	}
	
	@Override
	public void UpdateReadingBySeq(int seq) {
		myPageDAO.UpdateReadingBySeq(seq);
	}
	

	@Override
	public boolean SaveMessage(MessageDTO msg) {
		return myPageDAO.SaveMessage(msg);
	}
	
	@Override
	public List<TeamBBSDTO> findAllBBSListById(BbsParam param) {
		return myPageDAO.findAllBBSListById(param);
	}

	@Override
	public int findAllBBSCountById(BbsParam param) {
		return myPageDAO.findAllBBSCountById(param);
	}

	@Override
	public List<TeamBBSDTO> findAllLikeListById(BbsParam param) {
		return myPageDAO.findAllLikeListById(param);
	}

	@Override
	public int findAllLikeCountById(BbsParam param) {
		return myPageDAO.findAllLikeCountById(param);
	}

	@Override
	public List<MyBetParam> findAllBetListById(BbsParam param) {
		return myPageDAO.findAllBetListById(param);
	}

	@Override
	public int findAllBetCountById(String id) {
		return myPageDAO.findAllBetCountById(id);
	}

	@Override
	public void saveExchange(ExchangeDTO exchange) {
		myPageDAO.saveExchange(exchange);
	}

	@Override
	public List<ExchangeDTO> findAllExchangeListById(BbsParam param) {
		return myPageDAO.findAllExchangeListById(param);
	}

	@Override
	public int findAllExchangeCountById(String id) {
		return myPageDAO.findAllExchangeCountById(id);
	}

	@Override
	public int exchangeCheckCountById(String id) {
		return myPageDAO.exchangeCheckCountById(id);
	}

	@Override
	public void updateMoneyById(ExchangeDTO exchange) {
		myPageDAO.updateMoneyById(exchange);
	}

	@Override
	public List<MessageDTO> findAllReceiveMessageListById(BbsParam param) {
		return myPageDAO.findAllReceiveMessageListById(param);
	}

	@Override
	public int findAllReceiveMessageCountById(BbsParam param) {
		return myPageDAO.findAllReceiveMessageCountById(param);
	}

	@Override
	public void deleteSendMessageBySeq(int seq) {
		myPageDAO.deleteSendMessageBySeq(seq);
	}

	@Override
	public void deleteReceiveMessageBySeq(int seq) {
		myPageDAO.deleteReceiveMessageBySeq(seq);
	}

	@Override
	public void saveProfit(ProfitDTO profit) {
		myPageDAO.saveProfit(profit);
	}

	@Override
	public void saveSpend(SpendDTO spend) {
		myPageDAO.saveSpend(spend);
	}

	@Override
	public List<ProfitDTO> findAllPayInfoListById(BbsParam param) {
		return myPageDAO.findAllPayInfoListById(param);
	}

	@Override
	public int findAllPayInfoCountById(String id) {
		return myPageDAO.findAllPayInfoCountById(id);
	}

	@Override
	public boolean receiveIdCheck(MessageDTO msg) {
		return myPageDAO.receiveIdCheck(msg);
	}

	@Override
	public List<String> FindMessageIdById(Map<String, Object> map) {
		return myPageDAO.FindMessageIdById(map);
	}

	@Override
	public List<TeamApplicationDTO> findByMyAppList(BbsParam param) {
		return myPageDAO.findByMyAppList(param);
	}

	@Override
	public int findByMyAppListCount(String id) {
		return myPageDAO.findByMyAppListCount(id);
	}
	
	@Override
	public void deleteTeamApplicationBySeq(int seq) {
		myPageDAO.deleteTeamApplicationBySeq(seq);
	}

	@Override
	public void deleteAllSendMessageBySeq(Map<String, Integer> seqs) {
		myPageDAO.deleteAllSendMessageBySeq(seqs);
	}

	@Override
	public void deleteAllReceiveMessageBySeq(Map<String, Integer> seqs) {
		myPageDAO.deleteAllReceiveMessageBySeq(seqs);
	}

	@Override
	public boolean findMessageBlacklist(MessageDTO msg) {
		return myPageDAO.findMessageBlacklist(msg);
	}

	@Override
	public boolean findMessageIsBlacklist(MessageDTO msg) {
		return myPageDAO.findMessageIsBlacklist(msg);
	}

	@Override
	public void saveMessageBlacklist(MessageDTO msg) {
		myPageDAO.saveMessageBlacklist(msg);
	}

	@Override
	public void deleteMessageBlacklist(MessageDTO msg) {
		myPageDAO.deleteMessageBlacklist(msg);
	}

	@Override
	public int findAllBlackListCount(String userid) {
		return myPageDAO.findAllBlackListCount(userid);
	}

	@Override
	public List<MessageBlackListDTO> findAllBlackListById(BbsParam param) {
		return myPageDAO.findAllBlackListById(param);
	}
	
	@Override
	public String findAuthByid(String id) {
		return myPageDAO.findAuthByid(id);
	}

}
