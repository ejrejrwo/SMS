package com.boot.finalpro.admin.util;

public class Weather {

	private String nx;	// 경도
	private String ny;	// 위도
	private String baseDate;	// 조회하고싶은 날짜
	private String baseTime; // 조회하고 싶은 시간대
	private String urlStr;	// url정보
	
	public Weather() {
		// TODO Auto-generated constructor stub
	}

	public Weather(String nx, String ny, String baseDate, String baseTime, String urlStr) {
		super();
		this.nx = nx;
		this.ny = ny;
		this.baseDate = baseDate;
		this.baseTime = baseTime;
		this.urlStr = urlStr;
	}

	public String getNx() {
		return nx;
	}

	public void setNx(String nx) {
		this.nx = nx;
	}

	public String getNy() {
		return ny;
	}

	public void setNy(String ny) {
		this.ny = ny;
	}

	public String getBaseDate() {
		return baseDate;
	}

	public void setBaseDate(String baseDate) {
		this.baseDate = baseDate;
	}

	public String getBaseTime() {
		return baseTime;
	}

	public void setBaseTime(String baseTime) {
		this.baseTime = baseTime;
	}

	public String getUrlStr() {
		return urlStr;
	}

	public void setUrlStr() {
		this.urlStr = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData?" + "serviceKey=DNxrChb5Gw2FawbXRKHl8x7SwY8jmH5A1cJK8RDnq244RgYHrkyZZeArUcqfv3tIABsc8feVpO1UviAcQpDVrQ%3D%3D" + "&base_date=" + baseDate + "&base_time=" + baseTime + "&nx="+ nx + "&ny=" + ny + "&_type=json";
	}

	@Override
	public String toString() {
		return "Weather [urlStr=" + urlStr + "]";
	}
	
	
}
