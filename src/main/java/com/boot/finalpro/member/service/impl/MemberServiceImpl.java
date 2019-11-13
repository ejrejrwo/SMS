package com.boot.finalpro.member.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.finalpro.member.dao.MemberDAO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.member.model.SMS_MemberDTO;
import com.boot.finalpro.member.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;

	@Override
	public SMS_MemberDTO getOneMemberByMemberId(String id) {
		return memberDAO.getOneMemberByMemberId(id);
	}

	@Override
	public int idCheck(String id) {
		return memberDAO.idCheck(id);
	}

	@Override
	public MemberDTO saveMember(MemberDTO member) {
		return memberDAO.saveMember(member);
	}

	@Override
	public void saveSMSMember(SMS_MemberDTO member) {
		memberDAO.saveSMSMember(member);
	}

	@Override
	public void saveAuth(String id) {
		memberDAO.saveAuth(id);
	}

	@Override
	public void updatePwd(MemberDTO member) {
		memberDAO.updatePwd(member);
	}

	@Override
	public void WritePointPlus(String id) {
		memberDAO.WritePointPlus(id);
	}

	@Override
	public void CommentPointPlus(String id) {
		memberDAO.CommentPointPlus(id);
	}

	@Override
	public void UploadPointPlus(String id) {
		memberDAO.UploadPointPlus(id);
	}

	@Override
	public void regiPointPlus(String id) {
		memberDAO.regiPointPlus(id);
	}

	@Override
	public void WritePointMinus(String id) {
		memberDAO.WritePointMinus(id);		
	}

	@Override
	public void CommentPointMinus(String id) {
		memberDAO.CommentPointMinus(id);
	}

	@Override
	public void UploadPointMinus(String id) {
		memberDAO.UploadPointMinus(id);
	}

}
