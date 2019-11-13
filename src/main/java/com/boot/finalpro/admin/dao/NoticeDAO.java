package com.boot.finalpro.admin.dao;

import java.util.List;

import com.boot.finalpro.admin.model.NoticeDTO;
import com.boot.finalpro.admin.model.NoticeSubDTO;
import com.boot.finalpro.admin.util.SearchUtillDto;


public interface NoticeDAO {
	
	public int totalCount(SearchUtillDto dto);

	public List<NoticeDTO> getNoticeList(SearchUtillDto dto);
	
	public NoticeDTO noticeDetail(int seq);
	
	public List<NoticeSubDTO> noticeFileDetail(int seq);
	
	public void updateReadCount(int seq);
	
	public void updateDownCount(int file_seq);
	
	public NoticeSubDTO noticeFile(int file_seq);
	
	public NoticeDTO previousNotice(int seq);	// 공지사항 이전글
	
	public NoticeDTO nextNotice(int seq);	// 공지사항 다음
}