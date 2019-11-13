package com.boot.finalpro.admin.model;




public class NoticeDTO {

	private int seq;
	private String id;
	private String title;
	private String content;
	/* private Date wdate; */
	private String wdate;
	private int read_count;
	private String file_on;
	
	public NoticeDTO() {
	
	}
	
	
	public NoticeDTO(int seq, String id, String title, String content, String wdate, int read_count, String file_on) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.read_count = read_count;
		this.file_on = file_on;
	}


	public NoticeDTO(String title, String content, String wdate, String file_on) {
		super();
		this.title = title;
		this.content = content;
		this.wdate = wdate;
		this.file_on = file_on;
	}


	public int getSeq() {
		return seq;
	}


	public void setSeq(int seq) {
		this.seq = seq;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getWdate() {
		return wdate;
	}


	public void setWdate(String wdate) {
		this.wdate = wdate;
	}


	public int getRead_count() {
		return read_count;
	}


	public void setRead_count(int read_count) {
		this.read_count = read_count;
	}


	public String getFile_on() {
		return file_on;
	}


	public void setFile_on(String file_on) {
		this.file_on = file_on;
	}



	@Override
	public String toString() {
		return "NoticeDTO [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", wdate=" + wdate
				+ ", read_count=" + read_count + ", file_on=" + file_on + "]";
	}

	
}


