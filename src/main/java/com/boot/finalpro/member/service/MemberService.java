package com.boot.finalpro.member.service;

import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.member.model.SMS_MemberDTO;

public interface MemberService {

	// security id 얻어오기
	public SMS_MemberDTO getOneMemberByMemberId(String id);
	// 중복 아이디 체크
	public int idCheck(String id);
	// 회원가입
	public MemberDTO saveMember(MemberDTO member);
	// 시큐리티 회원가입
	public void saveSMSMember(SMS_MemberDTO member);
	// 회원 권한 입력
	public void saveAuth(String id);
	// 패스워드 변경
	public void updatePwd(MemberDTO member);
	
	// 포인트 증가
	public void WritePointPlus(String id);
	public void CommentPointPlus(String id);
	public void UploadPointPlus(String id);
	public void regiPointPlus(String id);
	
   // 글 삭제시 포인트 감소
   public void WritePointMinus(String id);
   public void CommentPointMinus(String id);
   public void UploadPointMinus(String id);
}
