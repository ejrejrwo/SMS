package com.boot.finalpro.admin.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.boot.finalpro.admin.dao.NoticeDAO;
import com.boot.finalpro.admin.model.NoticeDTO;
import com.boot.finalpro.admin.model.NoticeSubDTO;
import com.boot.finalpro.admin.util.SearchUtillDto;

@Repository
public class NoticeDAOImpl implements NoticeDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	String ns = "Admin.";

	@Override
	public int totalCount(SearchUtillDto dto) {
		int count = 0; 
		count = sqlSession.selectOne(ns + "getAllNotice", dto);
		return count;
	}

	@Override
	public List<NoticeDTO> getNoticeList(SearchUtillDto dto) {
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		list = sqlSession.selectList(ns + "getNoticeList", dto);
		return list;
	}

	@Override
	public NoticeDTO noticeDetail(int seq) {
		NoticeDTO dto = new NoticeDTO();
		dto = sqlSession.selectOne(ns + "noticeDetail" , seq);
		return dto;
	}

	@Override
	public List<NoticeSubDTO> noticeFileDetail(int seq) {
		List<NoticeSubDTO> fileList = new ArrayList<NoticeSubDTO>();
		fileList = sqlSession.selectList(ns + "noticeFileDetail", seq);
		return fileList;
	}

	@Override
	public void updateReadCount(int seq) {
		sqlSession.update(ns+"readCount", seq);
		
	}

	@Override
	public void updateDownCount(int file_seq) {
		sqlSession.update(ns+"downCount", file_seq);
		
	}

	@Override
	public NoticeSubDTO noticeFile(int file_seq) {
		NoticeSubDTO dto = new NoticeSubDTO();
		dto = sqlSession.selectOne(ns + "noticeFile2", file_seq);
		return dto;
	}

	@Override
	public NoticeDTO previousNotice(int seq) {
		NoticeDTO previousNotice = new NoticeDTO();
		previousNotice = sqlSession.selectOne(ns+"previousNotice", seq);
		return previousNotice;
	}

	@Override
	public NoticeDTO nextNotice(int seq) {
		NoticeDTO nextNotice = new NoticeDTO();
		nextNotice = sqlSession.selectOne(ns+"nextNotice", seq);
		return nextNotice;
	}
	
	
}
