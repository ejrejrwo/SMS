package com.boot.finalpro.mypage.dao;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.boot.finalpro.mypage.model.MemberVO;

public interface MyPageRepository extends JpaRepository<MemberVO, String>{

	public Optional<MemberVO> findById(String id);
	
	
}
