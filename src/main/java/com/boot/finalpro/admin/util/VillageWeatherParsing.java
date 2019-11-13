package com.boot.finalpro.admin.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;


public class VillageWeatherParsing {
	
	public static Map<String, String> getWeather(Weather weather)throws Exception {
		URL url = new URL(weather.getUrlStr());
		Map<String, String> data = new HashMap<String, String>();
		
		BufferedReader bf;
		String line ="";
		String result = "";
		
		//날씨 정보 받아오기
		bf = new BufferedReader(new InputStreamReader(url.openStream()));
		
		while((line=bf.readLine())!=null) {
			result = result.concat(line);
			/* System.out.println(result); */
		}
		
		//Json parser를 만들어서 만들어진 문자열 데이터를 객체화
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject)parser.parse(result);
		// Top레벨 단계인 response 키를 가지고 데이터를 파싱합니다.
		JSONObject parse_response = (JSONObject) obj.get("response"); 
		// response 로 부터 body 찾아옵니다
		JSONObject parse_body = (JSONObject)parse_response.get("body");
		
		// body 로 부터 items 받아옵니다.
		JSONObject parse_items = (JSONObject)parse_body.get("items");
		
		JSONArray parse_item = (JSONArray)parse_items.get("item");
		JSONObject weather_;
		/* System.out.println("item size : "+ parse_item.size()); */
		
		
		for(int i=0; i<parse_item.size(); i++) {
			weather_ = (JSONObject)parse_item.get(i);
			data.put("base_date", String.valueOf(weather_.get("baseDate")));	// 조회시간대
			
			switch((String)weather_.get("category")) {
				case "POP":	//강수확률
					data.put("POP", String.valueOf(weather_.get("fcstValue")));
					break;
				case "REH":	//습도
					data.put("REH", String.valueOf(weather_.get("fcstValue")));
					break;
				case "SKY":	//하늘상태
					if((Long)weather_.get("fcstValue")>=0 && (Long)weather_.get("fcstValue")<=5) {
						data.put("SKY","<img alt='' src='/image/sun.png' title='맑음'>");
					}
					else if((Long)weather_.get("fcstValue")>=6 && (Long)weather_.get("fcstValue")<=8) {
						data.put("SKY","<img alt='' src='/image/cloud.png' title='구름 많음'>");
					}
					else {
						data.put("SKY","<img alt='' src='/image/fullcloud.png' title='흐림'>");
					}
					break;
				case "T3H":	//3시간기온
					data.put("T3H", String.valueOf(weather_.get("fcstValue")));
					break;

			}
			
		}
		
		
		return data;
	}
	

	public static Map<String, String> getPm(PmData pmdata)throws Exception {
		URL url = new URL(pmdata.getUrlStr());
		Map<String, String> data = new HashMap<String, String>();
		
		BufferedReader bf;
		String line ="";
		String result = "";
		
		//날씨 정보 받아오기
		bf = new BufferedReader(new InputStreamReader(url.openStream()));
		
		
		while((line=bf.readLine())!=null) {
			result = result.concat(line);
		
		}
		
		//Json parser를 만들어서 만들어진 문자열 데이터를 객체화
		JSONParser parser = new JSONParser();
		JSONObject obj = (JSONObject)parser.parse(result);
		// Top레벨 단계인 response 키를 가지고 데이터를 파싱합니다.
		JSONArray parse_list = (JSONArray) obj.get("list"); 
		JSONObject weather_;
		/* System.out.println("item size : "+ parse_list.size()); */ 
		
		
		for(int i=0; i<parse_list.size(); i++) {
			weather_ = (JSONObject)parse_list.get(i);
			switch (weather_.get("pm10Grade1h")+"") { //미세먼지
			case "1":
				data.put("pm10Grade1h","<img alt='' src='/image/verygood.png' title='좋음'>");	
				break;
			case "2":
				data.put("pm10Grade1h","<img alt='' src='/image/good.png' title='보통'>");	
				break;
			case "3":
				data.put("pm10Grade1h","<img alt='' src='/image/sad.png' title='나쁨'>");
				break;
			case "4":
				data.put("pm10Grade1h","<img alt='' src='/image/gas-mask.png' title='매우나쁨'>");
				break;
			}
			
			switch (weather_.get("pm25Grade1h")+"") { //초미세먼지
			case "1":
				data.put("pm25Grade1h","<img alt='' src='/image/verygood.png' title='좋음'>");	
				break;
			case "2":
				data.put("pm25Grade1h","<img alt='' src='/image/good.png' title='보통'>");	
				break;
			case "3":
				data.put("pm25Grade1h","<img alt='' src='/image/sad.png' title='나쁨'>");
				break;
			case "4":
				data.put("pm25Grade1h","<img alt='' src='/image/gas-mask.png' title='매우나쁨'>");
				break;
			}
			
		}
		/* System.out.println(data.toString()); */
		return data;
	}

}
