package com.boot.finalpro.teambbs.util;

public class TeamBbsArrow {
	
	private int depth = 0;	
	
	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String getArrow(){
		String rs = "<img src='/image/arrow.png' width='20px' height='20px'/>";
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
		String ts="";
		
			ts += nbsp;
		
		return depth == 0 ? "" : ts+rs;
	}
}
