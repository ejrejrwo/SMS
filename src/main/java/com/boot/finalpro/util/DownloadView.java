package com.boot.finalpro.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import com.boot.finalpro.admin.model.NoticeSubDTO;
import com.boot.finalpro.admin.service.NoticeService;




public class DownloadView extends AbstractView {

	
	@Autowired
	NoticeService noticeService;

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		
		NoticeSubDTO subDto = new NoticeSubDTO();
		subDto =(NoticeSubDTO)model.get("dto");
		
		
		File file =(File)model.get("downloadFile");	// == getAttribute랑 같음
		response.setContentType(this.getContentType());
		response.setContentLength((int)file.length());
		
		// IE/chrome
		String userAgent =  request.getHeader("user-Agent");	// IE냐 chrome이냐
		boolean ie = userAgent.indexOf("MSIE") > -1;	//ie가 true가 나오면 IE false면 Chrome
		
		String filename = null;
		
		if(ie) {	// IE일때
			filename = URLEncoder.encode(subDto.getOriginalName(),"utf-8");
		}
		else {	// 그 외(chrome)일때
			filename = new String(subDto.getOriginalName().getBytes("utf-8"),"iso-8859-1");
		}
		
		response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Content-Length", "" + file.length());
		response.setHeader("Pragma", "no-cache;"); 
		response.setHeader("Expires", "-1;");
		
		
		
		OutputStream out = response.getOutputStream();
		FileInputStream fi = null;
		
		fi = new FileInputStream(file);
		FileCopyUtils.copy(fi, out);
		
		//download count 증가
		noticeService.updateDownCount(subDto.getFile_seq());
		
		if(fi != null) {
			fi.close();
		}
		
		
	}	
	
}
