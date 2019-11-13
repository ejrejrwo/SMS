package com.boot.finalpro.admin.model;

import java.io.Serializable;

public class NoticeSubDTO implements Serializable {

	private int file_seq;
	private int seq;
	private String uploadName;
	private String originalName;
	private int down_count;
	
	public NoticeSubDTO() {
		// TODO Auto-generated constructor stub
	}
	
	
	public NoticeSubDTO(int file_seq, int seq, String uploadName, String originalName,int down_count) {
		super();
		this.file_seq = file_seq;
		this.seq = seq;
		this.uploadName = uploadName;
		this.originalName = originalName;
		this.down_count = down_count;
	}

	

	public int getFile_seq() {
		return file_seq;
	}


	public void setFile_seq(int file_seq) {
		this.file_seq = file_seq;
	}


	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getUploadName() {
		return uploadName;
	}

	public void setUploadName(String uploadName) {
		this.uploadName = uploadName;
	}

	public String getOriginalName() {
		return originalName;
	}

	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}
	
	public int getDown_count() {
		return down_count;
	}


	public void setDown_count(int down_count) {
		this.down_count = down_count;
	}


	@Override
	public String toString() {
		return "NoticeSubDTO [file_seq=" + file_seq + ", seq=" + seq + ", uploadName=" + uploadName + ", originalName="
				+ originalName + ", down_count=" + down_count + "]";
	}


	

	
	
}
