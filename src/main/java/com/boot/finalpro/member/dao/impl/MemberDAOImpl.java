package com.boot.finalpro.member.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.boot.finalpro.member.dao.MemberDAO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.member.model.SMS_MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	SqlSession sqlSession;

	String ns = "member.";
	
	@Override
	public SMS_MemberDTO getOneMemberByMemberId(String id) {
		return sqlSession.selectOne(ns + "getOneMemberByMemberId", id);
	}

	@Override
	public int idCheck(String id) {
		return sqlSession.selectOne(ns + "idCheck", id);
	}

	@Override
	public MemberDTO saveMember(MemberDTO member) {
		return sqlSession.selectOne(ns + "saveMember", member);
	}

	@Override
	public void saveSMSMember(SMS_MemberDTO member) {
		sqlSession.insert(ns + "saveSMSMember", member);
	}

	@Override
	public void saveAuth(String id) {
		sqlSession.insert(ns + "saveAuth", id);
	}

	@Override
	public void updatePwd(MemberDTO member) {
		sqlSession.update(ns + "updatePwd", member);
	}

	@Override
	public void WritePointPlus(String id) {
		sqlSession.update(ns + "WritePointPlus", id);
	}

	@Override
	public void CommentPointPlus(String id) {
		sqlSession.update(ns + "CommentPointPlus", id);
	}

	@Override
	public void UploadPointPlus(String id) {
		sqlSession.update(ns + "UploadPointPlus", id);
	}

	@Override
	public void regiPointPlus(String id) {
		sqlSession.update(ns + "regiPointPlus", id);
	}

   @Override
   public void WritePointMinus(String id) {
      sqlSession.update(ns + "WritePointMinus", id);
   }

   @Override
   public void CommentPointMinus(String id) {
      sqlSession.update(ns + "CommentPointMinus", id);
   }

   @Override
   public void UploadPointMinus(String id) {
      sqlSession.update(ns + "UploadPointMinus", id);
   }

}
