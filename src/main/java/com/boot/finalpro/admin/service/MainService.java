package com.boot.finalpro.admin.service;


import java.util.List;
import java.util.Map;

import com.boot.finalpro.game.model.GameDTO;



public interface MainService {
	
	
	public Map<String, String> MainWeather()throws Exception;
	public Map<String, String> AjaxWeather(String location)throws Exception;
	public List<GameDTO> monthlyGame(String ym);
	
	public List<GameDTO> dailyGame(String ymd);


}
