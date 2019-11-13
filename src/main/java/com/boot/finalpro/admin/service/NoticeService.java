package com.boot.finalpro.admin.service;

import java.util.List;
import java.util.Map;

import com.boot.finalpro.admin.model.NoticeDTO;
import com.boot.finalpro.admin.model.NoticeSubDTO;
import com.boot.finalpro.admin.util.SearchUtillDto;


public interface NoticeService {

	public int totalCount(SearchUtillDto dto);
	
	public List<NoticeDTO> getNoticeList(SearchUtillDto dto);
	
	public Map<String, Object> noticeDetail(int seq);
	
	public void updateDownCount(int file_seq);
	
	public NoticeSubDTO noticeFileDetail(int file_seq);
	
}
