package com.boot.finalpro.admin.service.impl;


import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.boot.finalpro.admin.dao.AdminDAO;
import com.boot.finalpro.admin.service.MainService;
import com.boot.finalpro.admin.util.PmData;
import com.boot.finalpro.admin.util.VillageWeatherParsing;
import com.boot.finalpro.admin.util.Weather;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.util.DateUtil;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	AdminDAO adminDao;	
	
	
	@Override
	public Map<String, String> MainWeather()throws Exception {
		
		
		Weather weatehr = new Weather();
		PmData pmdata = new PmData();
		pmdata.setstationName("송파구");
		Map<String, String> data = new HashMap<String, String>();
		Map<String, String> pmdata_ = new HashMap<String, String>();
		pmdata.setUrlStr();
		
		weatehr.setNx("60");
		weatehr.setNy("127");

		Calendar cal = Calendar.getInstance();
		String today = "";
		today += cal.get(cal.YEAR) + "";
		today += DateUtil.two((cal.get(cal.MONTH)+1)+ "");
		today += DateUtil.two(cal.get(cal.DATE) + "");
		weatehr.setBaseDate(today);
		
		int hour = cal.get(cal.HOUR_OF_DAY);
		/* System.out.println("시간:"+hour); */
		
		if(hour<2 || hour>=23) {
			weatehr.setBaseTime("2300");
		}
		else if(hour>=2 && hour<5) {
			weatehr.setBaseTime("0200");
		}
		else if(hour>=5 && hour<8) {
			weatehr.setBaseTime("0500");
		}
		else if(hour>=8 && hour<11) {
			weatehr.setBaseTime("0800");
		}
		else if(hour>=11 && hour<14) {
			weatehr.setBaseTime("1100");
		}
		else if(hour>=14 && hour<17) {
			weatehr.setBaseTime("1400");
		}
		else if(hour>=17 && hour<20) {
			weatehr.setBaseTime("1700");
		}
		else if(hour>=20 && hour<23) {
			weatehr.setBaseTime("2000");
		}
		
		weatehr.setUrlStr();
		data = VillageWeatherParsing.getWeather(weatehr); 
		pmdata_ = VillageWeatherParsing.getPm(pmdata);	
		data.put("pm10Grade1h", pmdata_.get("pm10Grade1h"));
		data.put("pm25Grade1h", pmdata_.get("pm25Grade1h"));
		data.put("hour", weatehr.getBaseTime().substring(0, 2));
		return data;

	}

	@Override
	public Map<String, String> AjaxWeather(String location) throws Exception {
		
		Weather weatehr = new Weather();
		PmData pmdata = new PmData();
		Map<String, String> data = new HashMap<String, String>();
		Map<String, String> pmdata_ = new HashMap<String, String>();
		String location_ = "";	
		switch (location) {
		case "서울특별시":
			weatehr.setNx("60");
			weatehr.setNy("127");
			pmdata.setstationName("송파구");
			location_ = "url(http://stadium.seoul.go.kr/wp-content/themes/stadium/images/main/stadium_jamsil.jpg)";
			break;
		case "대전광역시":
			weatehr.setNx("67");
			weatehr.setNy("100");
			pmdata.setstationName("둔산동");
			location_ = "url(/image/daejeon.jpg)";
			break;
		case "강원강릉시":
			weatehr.setNx("92");
			weatehr.setNy("131");
			pmdata.setstationName("옥천동");
			location_ = "url(/image/kangwon.png)";
			break;
		case "광주광역시":
			weatehr.setNx("58");
			weatehr.setNy("74");
			pmdata.setstationName("농성동");
			location_ = "url(/image/gwangju.jpg)";
			break;			
		case "부산광역시":
			weatehr.setNx("98");
			weatehr.setNy("76");
			pmdata.setstationName("명장동");
			location_ = "url(/image/busan.jpg)";
			break;			
		}

		pmdata.setUrlStr();
		Calendar cal = Calendar.getInstance();
		String today = "";
		today += cal.get(cal.YEAR) + "";
		today += DateUtil.two((cal.get(cal.MONTH)+1)+ "");
		today += DateUtil.two(cal.get(cal.DATE) + "");
		weatehr.setBaseDate(today);
		
		int hour = cal.get(cal.HOUR_OF_DAY);
		if(hour<2 || hour>=23) {
			weatehr.setBaseTime("2300");
		}
		else if(hour>=2 && hour<5) {
			weatehr.setBaseTime("0200");
		}
		else if(hour>=5 && hour<8) {
			weatehr.setBaseTime("0500");
		}
		else if(hour>=8 && hour<11) {
			weatehr.setBaseTime("0800");
		}
		else if(hour>=11 && hour<14) {
			weatehr.setBaseTime("1100");
		}
		else if(hour>=14 && hour<17) {
			weatehr.setBaseTime("1400");
		}
		else if(hour>=17 && hour<20) {
			weatehr.setBaseTime("1700");
		}
		else if(hour>=20 && hour<23) {
			weatehr.setBaseTime("2000");
		}
		
		weatehr.setUrlStr();
		/* System.out.println(weatehr.toString()); */
		data = VillageWeatherParsing.getWeather(weatehr); 
		pmdata_ = VillageWeatherParsing.getPm(pmdata);
		data.put("pm10Grade1h", pmdata_.get("pm10Grade1h"));
		data.put("pm25Grade1h", pmdata_.get("pm25Grade1h"));
		data.put("hour", weatehr.getBaseTime().substring(0, 2));
		data.put("location", location_);
		/* System.out.println("ajax map : "+ data.toString()); */
		return data;
	}
	
	@Override
	public List<GameDTO> monthlyGame(String ym) {
		List<GameDTO> gDto = new ArrayList<GameDTO>();
		gDto = adminDao.monthlyGame(ym);
		return gDto;
	}

	@Override
	public List<GameDTO> dailyGame(String ymd) {
		List<GameDTO> gDto = new ArrayList<GameDTO>();
		gDto = adminDao.dailyGame(ymd);
		return gDto;
	}

	
}
