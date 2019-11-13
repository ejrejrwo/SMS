<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
	[1][2][3][4][5][6][7][8][9][10] >>
	<< ...[4][5][6] 7 [8][9][10]... >>
*/
	int totalRecordCount;	// 전체 글수    23 -> 3페이지
	int pageNumber;			// 현재 페이지 0 ~ 9	[1]~[10]
	int pageCountPerScreen;	// 스크린당 페이지 수 = 10
	int recordCountPerPage;	// 페이지당 글수 = 10
	
	String st1 = request.getParameter("totalRecordCount");
	if(st1 == null)	totalRecordCount = 0;
	else			totalRecordCount = Integer.parseInt(st1);	
	
	String st2 = request.getParameter("pageNumber");
	if(st2 == null)	pageNumber = 0;
	else			pageNumber = Integer.parseInt(st2);	
	
	String st3 = request.getParameter("pageCountPerScreen");
	if(st3 == null)	pageCountPerScreen = 0;
	else			pageCountPerScreen = Integer.parseInt(st3);	
	
	String st4 = request.getParameter("recordCountPerPage");
	if(st4 == null)	recordCountPerPage = 0;
	else			recordCountPerPage = Integer.parseInt(st4);
	
	// 총페이지 수
	int totalPageCount = totalRecordCount / recordCountPerPage;
	//	2					23					10
	if((totalRecordCount % recordCountPerPage)!= 0){
		totalPageCount++;		// -> 3
	}
	
	//			0    10    20
	// 시작페이지 [1]  [11]  [21]	<<[1][2][3]...[10]>>
	int screenStartPageIndex = ((pageNumber + 1) / pageCountPerScreen) * pageCountPerScreen;
	//			0					10					10
	
	// 끝페이지  [10] [20] [30]	
	int screenEndPageIndex = (((pageNumber + 1) / pageCountPerScreen) * pageCountPerScreen) + pageCountPerScreen;
	
	// 끝페이지는 다시 계산
	if(screenEndPageIndex > totalPageCount){
		screenEndPageIndex = totalPageCount;
	}
	
	if((pageNumber + 1) % pageCountPerScreen == 0){
		screenStartPageIndex = (((pageNumber + 1) / pageCountPerScreen) * pageCountPerScreen) - pageCountPerScreen;
		
		screenEndPageIndex = pageNumber + 1;	// 0 -> 1  9 -> 10
	}
%>

<div style="float: left; width: 100%; text-align: center;  ">
	<!-- << -->
	<ul class="pagination pagination-sm">
	<li class="page-item">
	<a href="#none" title="처음페이지" onclick="goPage('0')">
		<img alt="" src="/image/arrow_first.gif" style="width: 9px; height: 9px">
	</a>
	</li>
	<!-- < -->
	<%
	if(screenStartPageIndex > 1){
		%>
		<li class="page-item">
		<a href="#none" title="이전페이지" onclick="goPage('<%=screenStartPageIndex-1 %>')">
			<img alt="" src="/image/arrow_back.gif" style="width: 9px; height: 9px">
		</a>
		</li>
		<%
	}
	%>
	
	<!-- [1] 2 [3] -->
	<%
	for(int i = screenStartPageIndex; i < screenEndPageIndex; i++){
		if(i == pageNumber){	// 현재 페이지
			%>
				<li class="page-item active"><a class="page-link"><%=i+1 %></a></li>	
			<%
		}else{		// 그외의 페이지들
			%>
			
				<li class="page-item">
					<a href="#none" class="page-link" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"><%=i+1 %></a>
				</li>
			
			<%	
		}
	}
	%>

	<!-- > -->
	<%
	if(screenEndPageIndex < totalPageCount){	//  [11][12][13] >
		%>
		<li class="page-item">
		<a href="#none" title="다음페이지" onclick="goPage(<%=screenEndPageIndex %>)">
			<img alt="" src="/image/arrow_next.gif" style="width: 9px; height: 9px">
		</a>
		</li>
		<%	
	}	
	int end_page = 0;
	if(totalPageCount > 0){
		end_page = totalPageCount - 1;	
	}
	
	//		[1][2][3]
	//		[11][12][13]
	//		총페이지 -> 120		
	
	%>
	<!-- >> -->
	<li class="page-item">
	<a href="#none" title="마지막페이지" onclick="goPage(<%=end_page %>)">
		<img alt="" src="/image/arrow_end.gif" style="width: 9px; height: 9px">
	</a>
	</li>
	</ul>
</div>