package com.boot.finalpro.game.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.boot.finalpro.game.model.BookBean;
import com.boot.finalpro.game.model.BookingDTO;
import com.boot.finalpro.game.model.GameBean;
import com.boot.finalpro.game.model.GameDTO;
import com.boot.finalpro.game.model.GameMatchDTO;
import com.boot.finalpro.game.model.GameParam;
import com.boot.finalpro.game.model.StadiumDTO;
import com.boot.finalpro.game.service.GameService;
import com.boot.finalpro.game.util.CalParam;
import com.boot.finalpro.member.model.AuthoritiesDTO;
import com.boot.finalpro.member.model.MemberDTO;
import com.boot.finalpro.util.DateUtil;
import com.boot.finalpro.video.model.VideoCommentDTO;
import com.boot.finalpro.video.model.VideoDTO;

import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/common/*")
public class GameController {

	@Autowired
	GameService gameService;
	 
	@RequestMapping(value = "gamelist.do", method={RequestMethod.GET, RequestMethod.POST})
	public String gamelist(String page, GameParam gp, Model model, Principal pcp) {
//		log.info(gp.toString());		
		/* String id = pcp.getName(); */
		String id = "guest";
		
		Object principal2 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		log.info("idididid : " + principal2 );
		if(principal2 != "anonymousUser") {
			id = pcp.getName();
		}
		
		MemberDTO mem = gameService.getMember(id);
		AuthoritiesDTO auth = gameService.getAuth(id);
		
		// 전체 리스트 받아오기		
		int nowpage = 1;
		
		if(page != null) {
			nowpage = Integer.parseInt(page);
		}
		
		gp.setNowpage(nowpage);
		gp.setDisplayRow(10);
		
		int count = gameService.getGameCount(gp);
//		log.info("count==============" + count);
		gp.setTotalCount(count);
		
		List<GameDTO> gamelist = gameService.getGamelist(gp);
//		log.info("gamelist=============" + gamelist.toString());
		
		model.addAttribute("gamelist", gamelist);
		model.addAttribute("paging", gp);
		model.addAttribute("mem", mem);
		model.addAttribute("auth", auth);
		
		model.addAttribute("InsertTitle", "SMS 경기매칭");
		
		//System.out.println("=============================================================== 들어옴");
				
		return "gamelist.tiles";
	}
	
	@RequestMapping(value = "gamemake.do", method={RequestMethod.GET, RequestMethod.POST})
	public String gamemake(CalParam cp, Model model, Principal pcp) {	
		/* String id = pcp.getName(); */
		String id = "guest";
		
		Object principal2 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(principal2 != "anonymousUser") {
			id = pcp.getName();
		}
		
		MemberDTO mem = gameService.getMember(id);
		
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DATE, 1);	// 그 달의 1일
		
		String syear = cp.getYear();
		String smonth = cp.getMonth();
		
		int year = cal.get(Calendar.YEAR);
		if(DateUtil.nvl(syear) == false) {
			year = Integer.parseInt(syear);
		}
		
		int month = cal.get(Calendar.MONTH) + 1;
		if(DateUtil.nvl(smonth) == false) {
			month = Integer.parseInt(smonth);
		}	
		
		if(month < 1){
			month = 12;
			year--;
		}

		if(month > 12){
			month = 1;
			year++;
		}
											
		model.addAttribute("year", year);
		model.addAttribute("month", month);	
		model.addAttribute("mem", mem);
		model.addAttribute("action", "gamemake.do?");
		
		model.addAttribute("InsertTitle", "SMS 경기매칭");
		
		return "gamemake.tiles";
	}
		
	
	@RequestMapping(value = "gamemakeAf.do", method={RequestMethod.GET, RequestMethod.POST})
	public String gamemakeAf(GameBean game, HttpServletRequest req) {
		log.info(game.getGday());	
										
		// 게임내용 GameDTO
		GameDTO dto = new GameDTO(0
								, game.getCategory()
								, game.getName_team1()
								, game.getGdate()
								, game.getName_stadium()
								, game.getTitle()
								, game.getContent());		
		gameService.writeGame(dto);
							
		// 경기장 예약 BookinDTO
		String book_time[] = req.getParameterValues("book_time");
		if(book_time != null && book_time.length > 0){
			for(int i = 0;i < book_time.length; i++){
				
				game.setBook_time(book_time[i]);
				
				// 경기장 예약 내용 BookingDTO
				BookingDTO bdto = new BookingDTO(0
												, 0
												, game.getId()
												, game.getBdate()
												, game.getPrice()
												, game.getPay_point()
												, game.getName_stadium()
												, game.getBook_time()
												, null);
				gameService.bookGame(bdto);
								
			}
		}
		
		// 팀장 머니, 포인트 빼기	
		int pay_point = game.getPay_point();
		int now_point = game.getNow_point();			
		int now_money = game.getNow_money();
		int price = game.getPrice();
		
		now_money = now_money - price;
		now_point = now_point - pay_point;
		
		MemberDTO mem = new MemberDTO(game.getId(), now_money, 0, now_point, 0);
		
		gameService.payMoney(mem);
				
		return "redirect:/common/gamelist.do";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "getprice.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String getprice(StadiumDTO stadium) {
//		log.info(stadium.getName_stadium());		
		
		String price = gameService.getprice(stadium) + "";

		return price;	
	}
	
	@ResponseBody
	@RequestMapping(value = "booktime.do", method= {RequestMethod.GET, RequestMethod.POST})
	public List<Integer> booktime(BookingDTO book) {
//		log.info(book.toString());
		String category = (book.getName_stadium()).substring(2);
//		log.info(category);
		
		book.setCategory(category);
				
		List<Integer> blist = gameService.getTime(book);
		log.info(blist.toString());
				
		return blist;
		
//		log.info("book_time=" + blist.toString());								
	}
	
	@RequestMapping(value = "gamedetail.do", method={RequestMethod.GET, RequestMethod.POST})
	public String gamedatail(int seq_game, Model model, Principal pcp) {
//		log.info(seq_game + "");
		gameService.readCount(seq_game);
		
		/* String id = pcp.getName(); */
		String id = "guest";
		
		Object principal2 = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(principal2 != "anonymousUser") {
			id = pcp.getName();
		}
		
		MemberDTO mem = gameService.getMember(id);
		AuthoritiesDTO auth = gameService.getAuth(id);
		
		GameDTO game = gameService.updateGame(seq_game);
		
		// 게임신청 했는지 여부
		List<GameMatchDTO> glist = gameService.subGame(seq_game);
//		log.info(glist.toString());
		
		model.addAttribute("glist", glist);
		model.addAttribute("mem", mem);
		model.addAttribute("auth", auth);
		model.addAttribute("game", game);
								
		return "gamedetail.tiles";
	}
	
	@ResponseBody
	@RequestMapping(value = "reqGame.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String reqGame(GameMatchDTO gm) {
//		log.info(gm.toString());
				
		gameService.reqGame(gm);
		
		return "";			
	}
	
	@RequestMapping(value = "gamedelete.do", method={RequestMethod.GET, RequestMethod.POST})
	public String gamedelete(int seq_game, String id) {
		// 게임삭제 시 환불
		BookingDTO bdto = gameService.backMoney(seq_game);
//		log.info(bdto.toString());
		int price = bdto.getPrice();
		int point = bdto.getPoint();
				
		// memberDTO에 추가
		MemberDTO mem = new MemberDTO(id, price, 0, point, 0);
//		log.info(mem.toString());
		
		gameService.refund(mem);
				
		boolean game = gameService.deleteGame(seq_game);
		boolean book = gameService.deleteBooking(seq_game);
												
		return "redirect:/common/gamelist.do";
	}
	
	/**   
    이미지 업로드
    @param request
    @param response
    @param upload
   */
  @RequestMapping(value = "gameupload.do", method = RequestMethod.POST)
  public void communityImageUpload(HttpServletRequest request, HttpServletResponse response, 
                             @RequestParam MultipartFile upload) {

         System.out.println("communityImageUpload 도착");
        
         OutputStream out = null;
         PrintWriter printWriter = null;
         
         response.setCharacterEncoding("utf-8");
         response.setContentType("text/html;charset=utf-8");
  
         String fileName = upload.getOriginalFilename();
         System.out.println("filename : " +fileName);
         
         //upload 경로설정 .. tomcat 경로
         String uploadPath = request.getServletContext().getRealPath("upload");
         System.out.println("uploadPath : " + uploadPath);
  
             //파일 업로드 할때에는 경로와 파일 네임을 같이 올린다..
         byte[] bytes;
         try {
           bytes = upload.getBytes();
           out = new FileOutputStream(new File(uploadPath + "\\" + fileName));
           out.write(bytes);         
             
        //   System.out.println("out : "+out);
             
             String callback = request.getParameter("CKEditorFuncNum");
             
             printWriter = response.getWriter();
             //String fileUrl = request.getServletContext().getRealPath("upload") + "\\"+ fileName;
              String fileUrl = "/upload/" + fileName;
            
        //     System.out.println("fileUrl : " + fileUrl);
       
            printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
                 + callback
                 + ",'"
                 + fileUrl
                 + "','이미지를 업로드 하였습니다.'"
                 + ")</script>");
          //  System.out.println("collback : " + callback );
          printWriter.flush();
  
         }catch(IOException e){
             e.printStackTrace();
         } finally {
      }
  }
  

	@RequestMapping(value = "stadium.do", method={RequestMethod.GET, RequestMethod.POST})
	public String stadium(int num, CalParam cp, Model model) {
//		log.info("num==" + num);		
		// 경기장 정보 다 받아오기		
		int startNum = 0;
		int endNum = 0;
		
		if(num == 1) {
			startNum = 1;endNum = 5;			
		}else if(num == 2) {
			startNum = 6;endNum = 10;
		}else if(num == 3) {
			startNum = 11;endNum = 15;
		}else if(num == 4) {
			startNum = 16;endNum = 20;
		}else if(num == 5) {
			startNum = 21;endNum = 25;
		}
		
		GameBean gb = new GameBean(startNum, endNum);					
		List<StadiumDTO> stadium = gameService.getStadium(gb);		

		// 대관현황달력
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DATE, 1);	// 그 달의 1일
		
		String syear = cp.getYear();
		String smonth = cp.getMonth();
		
		int year = cal.get(Calendar.YEAR);
		if(DateUtil.nvl(syear) == false) {
			year = Integer.parseInt(syear);
		}
		
		int month = cal.get(Calendar.MONTH) + 1;
		if(DateUtil.nvl(smonth) == false) {
			month = Integer.parseInt(smonth);
		}	
		
		if(month < 1){
			month = 12;
			year--;
		}

		if(month > 12){
			month = 1;
			year++;
		}
				
		model.addAttribute("year", year);
		model.addAttribute("month", month);	
		model.addAttribute("num", num);
		model.addAttribute("slist", stadium);
		model.addAttribute("action", "stadium.do?num="+num + "&");
		
		model.addAttribute("InsertTitle", "SMS 경기장");
		
		return "stadium.tiles";
		
	}
	
	@ResponseBody
	@RequestMapping(value = "bookstadium.do", method=RequestMethod.GET)
	public Map<String, Object> bookstadium(BookingDTO book) {
//		log.info(book.toString());
				
		List<BookBean> bb = gameService.getBookList(book);
//		log.info(bb.toString());
		
		Map<String, Object> rmap = new HashMap<String, Object>();	
		rmap.put("blist", bb);
								
		return rmap;			
	}
				
	@ResponseBody
	@RequestMapping(value = "stadiumSelect.do", method=RequestMethod.GET)
	public Map<String, Object> stadiumSelect(BookingDTO book) {
//		log.info(book.toString());
		
		List<BookBean> bb = gameService.getBookList(book);
//		log.info(bb.toString());
		
		Map<String, Object> rmap = new HashMap<String, Object>();	
		rmap.put("blist", bb);
								
		return rmap;				
		
	}


	
	
}













