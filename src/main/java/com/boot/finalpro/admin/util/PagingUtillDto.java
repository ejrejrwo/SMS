package com.boot.finalpro.admin.util;

public class PagingUtillDto {
   
   int totalPage;
   int curPage;
   int firstPage;
   int lastPage;
   
   public PagingUtillDto() {
      // TODO Auto-generated constructor stub
   }

   public PagingUtillDto(int totalPage,int curPage, int firstPage, int lastPage) {
      super();
      this.totalPage = totalPage;
      this.curPage = curPage;
      this.firstPage = firstPage;
      this.lastPage = lastPage;
   }

   public int getCurPage() {
      return curPage;
   }

   public void setCurPage(int curPage) {
      this.curPage = curPage;
   }

   public int getFirstPage() {
      return firstPage;
   }

   public void setFirstPage(int firstPage) {
      this.firstPage = firstPage;
   }

   public int getLastPage() {
      return lastPage;
   }

   public void setLastPage(int lastPage) {
      this.lastPage = lastPage;
   }

   
   public int getTotalPage() {
      return totalPage;
   }

   public void setTotalPage(int totalPage) {
      this.totalPage = totalPage;
   }

   @Override
   public String toString() {
      return "PagingUtillDto [totalPage=" + totalPage + ", curPage=" + curPage + ", firstPage=" + firstPage
            + ", lastPage=" + lastPage + "]";
   }

   
}