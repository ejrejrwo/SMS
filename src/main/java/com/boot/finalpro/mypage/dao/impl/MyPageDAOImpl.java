package com.boot.finalpro.mypage.dao.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.member.model.SMS_MemberDTO;
import com.boot.finalpro.mypage.dao.MyPageDAO;
import com.boot.finalpro.mypage.model.ExchangeDTO;
import com.boot.finalpro.mypage.model.MessageBlackListDTO;
import com.boot.finalpro.mypage.model.MessageDTO;
import com.boot.finalpro.mypage.model.ProfitDTO;
import com.boot.finalpro.mypage.model.SpendDTO;
import com.boot.finalpro.mypage.util.BbsParam;
import com.boot.finalpro.mypage.util.MyBetParam;
import com.boot.finalpro.team.model.TeamApplicationDTO;
import com.boot.finalpro.teambbs.model.TeamBBSDTO;

@Repository
public class MyPageDAOImpl implements MyPageDAO{

	@Autowired
	SqlSession sqlSession;

	String ns = "myPage.";

	// 빅쿼리를 돌린다는 가정
    private void slowQuery(long seconds) {
           try {
               Thread.sleep(seconds);
           } catch (InterruptedException e) {
               throw new IllegalStateException(e);
           }
   }
	
    @CacheEvict(value = "findOneMemberById", key = "#member.id")
	@Override
	public void UpdateMemberInfo(MemberDTO member) {
		sqlSession.update(ns + "UpdateMemberInfo", member);
	}

	@Override
	public void updateSMSMemberInfo(SMS_MemberDTO SMS) {
		sqlSession.update(ns + "updateSMSMemberInfo", SMS);
	}
	
	@Cacheable(key = "#id", value = "findOneMemberById")
	@Override
	public MemberDTO findOneMemberById(String id) {
		slowQuery(300);
		return sqlSession.selectOne(ns + "findOneMemberById", id);
	}

	@Override
	public void ChangeInfoMoney(MemberDTO member) {
		sqlSession.update(ns + "ChangeInfoMoney", member);
	}

	@Override
	public void deleteById(String id) {
		sqlSession.update(ns + "deleteById", id);
	}

//	@Cacheable(key = "#param.id", value = "findByBestCategoryCache")
	@Override
	public List<MessageDTO> findAllSendMessageListById(BbsParam param) {
//		slowQuery(300);
		return sqlSession.selectList(ns + "findAllSendMessageListById", param);
	}
	
	@Override
	public MessageDTO findOneMessageBySeq(int seq) {
		return sqlSession.selectOne(ns + "findOneMessageBySeq", seq);
	}

	@Override
	public int findAllSendMessageCountById(BbsParam param) {
		return sqlSession.selectOne(ns + "findAllSendMessageCountById", param);
	}
	
	@Override
	public void UpdateReadingBySeq(int seq) {
		sqlSession.update(ns + "UpdateReadingBySeq", seq);
	}
	
	@Override
	public boolean SaveMessage(MessageDTO msg) {
		int n = sqlSession.insert(ns + "SaveMessage", msg);
		return n > 0 ? true:false;
	}
	
	@Override
	public List<TeamBBSDTO> findAllBBSListById(BbsParam param) {
		return sqlSession.selectList(ns + "findAllBBSListById", param);
	}

	@Override
	public int findAllBBSCountById(BbsParam param) {
		return sqlSession.selectOne(ns + "findAllBBSCountById", param);
	}

	@Override
	public List<TeamBBSDTO> findAllLikeListById(BbsParam param) {
		return sqlSession.selectList(ns + "findAllLikeListById", param);
	}

	@Override
	public int findAllLikeCountById(BbsParam param) {
		return sqlSession.selectOne(ns + "findAllLikeCountById", param);
	}

	@Override
	public List<MyBetParam> findAllBetListById(BbsParam param) {
		return sqlSession.selectList(ns + "findAllBetListById", param);
	}

	@Override
	public int findAllBetCountById(String id) {
		return sqlSession.selectOne(ns + "findAllBetCountById", id);
	}

	@Override
	public void saveExchange(ExchangeDTO exchange) {
		sqlSession.insert(ns + "saveExchange", exchange);
	}

	@Override
	public List<ExchangeDTO> findAllExchangeListById(BbsParam param) {
		return sqlSession.selectList(ns + "findAllExchangeListById", param);
	}

	@Override
	public int findAllExchangeCountById(String id) {
		return sqlSession.selectOne(ns + "findAllExchangeCountById", id);
	}

	@Override
	public int exchangeCheckCountById(String id) {
		return sqlSession.selectOne(ns + "exchangeCheckCountById", id);
	}

	@Override
	public void updateMoneyById(ExchangeDTO exchange) {
		sqlSession.update(ns + "updateMoneyById", exchange);
	}

	@Override
	public List<MessageDTO> findAllReceiveMessageListById(BbsParam param) {
		return sqlSession.selectList(ns + "findAllReceiveMessageListById", param);
	}

	@Override
	public int findAllReceiveMessageCountById(BbsParam param) {
		return sqlSession.selectOne(ns + "findAllReceiveMessageCountById", param);
	}

	@Override
	public void deleteSendMessageBySeq(int seq) {
		sqlSession.update(ns + "deleteSendMessageBySeq" , seq);
	}

	@Override
	public void deleteReceiveMessageBySeq(int seq) {
		sqlSession.update(ns + "deleteReceiveMessageBySeq" , seq);
	}

	@Override
	public void saveProfit(ProfitDTO profit) {
		sqlSession.insert(ns + "saveProfit", profit);
	}

	@Override
	public void saveSpend(SpendDTO spend) {
		sqlSession.insert(ns + "saveSpend", spend);
	}

	@Override
	public List<ProfitDTO> findAllPayInfoListById(BbsParam param) {
		return sqlSession.selectList(ns + "findAllPayInfoListById", param);
	}

	@Override
	public int findAllPayInfoCountById(String id) {
		return sqlSession.selectOne(ns + "findAllPayInfoCountById", id);
	}

	@Override
	public boolean receiveIdCheck(MessageDTO msg) {
		int n = sqlSession.selectOne(ns + "receiveIdCheck", msg);
		return n > 0?true:false;
	}

	@Override
	public List<String> FindMessageIdById(Map<String, Object> map) {
		return sqlSession.selectList(ns + "FindMessageIdById", map);
	}

	@Override
	public List<TeamApplicationDTO> findByMyAppList(BbsParam param) {
		return sqlSession.selectList(ns + "findByMyAppList", param);
	}

	@Override
	public int findByMyAppListCount(String id) {
		return sqlSession.selectOne(ns + "findByMyAppListCount", id);
	}
	
	@Override
	public void deleteTeamApplicationBySeq(int seq) {
		sqlSession.delete(ns + "deleteTeamApplicationBySeq", seq);
	}

	@Override
	public void deleteAllSendMessageBySeq(Map<String, Integer> seqs) {
		sqlSession.update(ns + "deleteAllSendMessageBySeq", seqs);
	}

	@Override
	public void deleteAllReceiveMessageBySeq(Map<String, Integer> seqs) {
		sqlSession.update(ns + "deleteAllReceiveMessageBySeq", seqs);
	}

	@Override
	public boolean findMessageBlacklist(MessageDTO msg) {
		int n = sqlSession.selectOne(ns + "findMessageBlacklist", msg);
		return n > 0 ? true:false;
	}

	@Override
	public boolean findMessageIsBlacklist(MessageDTO msg) {
		int n = sqlSession.selectOne(ns + "findMessageIsBlacklist", msg);
		return n > 0 ? true:false;
	}

	@Override
	public void saveMessageBlacklist(MessageDTO msg) {
		sqlSession.insert(ns + "saveMessageBlacklist", msg);
	}

	@Override
	public void deleteMessageBlacklist(MessageDTO msg) {
		sqlSession.delete(ns + "deleteMessageBlacklist", msg);
	}

	@Override
	public int findAllBlackListCount(String userid) {
		return sqlSession.selectOne(ns + "findAllBlackListCount", userid);
	}

	@Override
	public List<MessageBlackListDTO> findAllBlackListById(BbsParam param) {
		return sqlSession.selectList(ns + "findAllBlackListById", param);
	}
	
	@Override
	public String findAuthByid(String id) {
		return sqlSession.selectOne(ns + "findAuthById", id);
	}
}
