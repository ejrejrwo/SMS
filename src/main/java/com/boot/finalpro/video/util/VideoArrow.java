package com.boot.finalpro.video.util;

public class VideoArrow {
	
	private int depth = 0;	
	
	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String getArrow(){
		
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		String ts="";
		
			ts += nbsp;
		
		return depth == 0 ? "" : ts;
	}

}
