package com.boot.finalpro.admin.util;

public class PagingUtill {

   public static PagingUtillDto getPageCount(int count,int _curpage) {
      PagingUtillDto dto = new PagingUtillDto();
      dto.setCurPage(_curpage);
      int totalPageCount = 0;
      totalPageCount = count/10+1;
      dto.setTotalPage(totalPageCount);
      int subPage = 0;
      if(_curpage%10 == 0) {
         subPage = _curpage/10-1;
      }
      else {
         subPage = dto.getCurPage()/10;
      }
      int firstPage =   0; 
      firstPage = subPage*10+1;
      dto.setFirstPage(firstPage);
      int lastPage = 0;
      if(subPage == totalPageCount/10) {   // 마지막페이지 == 끝페이지
         lastPage = totalPageCount;
      }
      else {   // 마지막페이지 == (현재페이지/10+1)*10
         lastPage = (subPage+1)*10;
      }
      dto.setLastPage(lastPage);
      return dto;
   }
}