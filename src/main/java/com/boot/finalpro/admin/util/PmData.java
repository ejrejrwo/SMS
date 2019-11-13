package com.boot.finalpro.admin.util;

public class PmData {
	
	private String stationName;
	private String urlStr;
	
	public PmData() {
		// TODO Auto-generated constructor stub
	}

	public PmData(String stationName,String urlStr) {
		super();
		this.stationName = stationName;
		this.urlStr = urlStr;
	}

	public String getstationName() {
		return stationName;
	}

	public void setstationName(String stationName) {
		this.stationName = stationName;
	}

	public String getUrlStr() {
		return urlStr;
	}

	public void setUrlStr() {
		this.urlStr = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?ServiceKey=DNxrChb5Gw2FawbXRKHl8x7SwY8jmH5A1cJK8RDnq244RgYHrkyZZeArUcqfv3tIABsc8feVpO1UviAcQpDVrQ%3D%3D&stationName="+stationName+"&ver=1.3&dataTerm=DAILY&numOfRows=1&_returnType=json";						
	}

	@Override
	public String toString() {
		return "PmData [urlStr=" + urlStr + "]";
	}
	
	
}
