package com.boot.finalpro.admin.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.finalpro.admin.dao.NoticeDAO;
import com.boot.finalpro.admin.model.NoticeDTO;
import com.boot.finalpro.admin.model.NoticeSubDTO;
import com.boot.finalpro.admin.service.NoticeService;
import com.boot.finalpro.admin.util.SearchUtillDto;


@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	NoticeDAO noticeDao;

	@Override
	public int totalCount(SearchUtillDto dto) {
		return noticeDao.totalCount(dto);
	}

	@Override
	public List<NoticeDTO> getNoticeList(SearchUtillDto dto) {
		List<NoticeDTO> list = new ArrayList<NoticeDTO>();
		list = noticeDao.getNoticeList(dto);
		return list;
	}

	@Override
	public Map<String, Object> noticeDetail(int seq) {
		NoticeDTO previousNotice = new NoticeDTO();
		NoticeDTO nextNotice = new NoticeDTO();
		
		noticeDao.updateReadCount(seq);
		Map<String, Object> notice = new HashMap<String, Object>();
		NoticeDTO dto = new NoticeDTO();
		dto = noticeDao.noticeDetail(seq);
		notice.put("notice", dto);
		
		if(dto.getFile_on().equals("Y")) {
			List<NoticeSubDTO> subDto = new ArrayList<NoticeSubDTO>();
			subDto = noticeDao.noticeFileDetail(seq);
			notice.put("fileList", subDto);
		}
		
		previousNotice = noticeDao.previousNotice(seq);
		if(previousNotice == null) {
			previousNotice = new NoticeDTO();
		}
		nextNotice = noticeDao.nextNotice(seq);
		if(nextNotice == null) {
			nextNotice = new NoticeDTO();
		}

		notice.put("previousNotice", previousNotice);
		notice.put("nextNotice", nextNotice);
		
		return notice;
	}


	@Override
	public void updateDownCount(int file_seq) {
		noticeDao.updateDownCount(file_seq);
	}

	@Override
	public NoticeSubDTO noticeFileDetail(int file_seq) {
		NoticeSubDTO dto = new NoticeSubDTO();
		dto=noticeDao.noticeFile(file_seq);
		return dto;
	}
	
	
	
}
