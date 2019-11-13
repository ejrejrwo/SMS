package com.boot.finalpro.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class utilMethod {
	// 날짜용 함수
	public static String dateEdit(String strDate) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		String str = "";
		long min = 0;
		long hour = 0;
		Date w_date = new Date();
		
		try{
			w_date = sdf.parse(strDate);
			Date today = new Date();
			long diff = today.getTime() - w_date.getTime();
			min = diff / (1000 * 60);
			hour = diff / (1000 * 60 * 60);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		if(min < 60) {
			str = min + "분 전";
		}else if (min >= 60 && hour < 24) {
			str = hour + "시간 전";
		}else if (hour >= 24) {
			str = new SimpleDateFormat("yyyy-MM-dd").format(w_date);
		}
		
		return str;
	}
	
}
