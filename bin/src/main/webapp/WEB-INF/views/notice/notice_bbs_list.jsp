<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery	.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/css/bbslist.css">

   
</head>
<body>
	<div id="_topBar" style="text-align: left;">
	<h1>공지사항</h1>
	</div>
	<div id="_searchWrap" style="text-align: left;">
		<form action="#" id="_frmForm">
			<input type="hidden" name="page" value="1" id="_curPage">
			<c:choose>
				<c:when test="${empty search.begin }">
					<input type="text" id="_datepickTo" name="begin" placeholder="YYYY-MM-DD" readonly="readonly"  >
				</c:when>
				<c:otherwise>
					<input type="text" id="_datepickTo" name="begin" value="${search.begin }" readonly="readonly"  >
				</c:otherwise>
			</c:choose>
			~
			<c:choose>
				<c:when test="${empty search.end }">
					<input type="text" id="_datepickFrom" name="end" placeholder="YYYY-MM-DD" readonly="readonly" >
				</c:when>
				<c:otherwise>
					<input type="text" id="_datepickFrom" name="end" value="${search.end }" readonly="readonly" >
				</c:otherwise>
			</c:choose>
			<div id="_searchBar" style="float: right;">
		 		<select name="category" id="_selectBox">
	 			<c:choose>
	 				<c:when test="${empty search.category }">
	 					<option selected="selected">선택</option>
						<option value="ID">작성자</option>
						<option value="TITLE">제목</option>
						<option value="CONTENT">내용</option>
	 				</c:when>
	 				<c:otherwise>
	 					<c:choose>
		 					<c:when test="${search.category eq 'ID' }">
			 					<option>선택</option>
								<option value="ID" selected="selected">작성자</option>
								<option value="TITLE">제목</option>
								<option value="CONTENT">내용</option>	 						
		 					</c:when>
		 					<c:when test="${search.category eq 'TITLE' }">
			 					<option>선택</option>
								<option value="ID">작성자</option>
								<option value="TITLE" selected="selected">제목</option>
								<option value="CONTENT">내용</option>	 						
		 					</c:when>
		 					<c:when test="${search.category eq 'CONTENT' }">
			 					<option>선택</option>
								<option value="ID">작성자</option>
								<option value="TITLE">제목</option>
								<option value="CONTENT" selected="selected">내용</option>	 						
		 					</c:when>
	 					</c:choose>	 						 					
	 				</c:otherwise>
	 			</c:choose>
				</select>
				<c:choose>
					<c:when test="${empty search.searchText }">
						<input type="text" placeholder="검색어" id="_textbar" name="searchText">
					</c:when>
					<c:otherwise>
						<input type="text" value="${search.searchText }" id="_textbar" name="searchText">
					</c:otherwise>
				</c:choose>
				<button type="button" id="_findBtn">검색</button>
			</div>
		</form>
	</div>
	
	<div id="_tableWrap">
		<table>
			<colgroup><col width="10%"><col width="40%"><col width="15%"><col width="15%"><col width="10%"><col width="10%"></colgroup>
			<thead>
				<tr><th>번호</th><th>제목</th><th>작성자</th><th>등록일</th><th>첨부</th><th>조회</th></tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty list }">	<!-- 작성 게시글이 없을경우 -->
						<tr>
						<td colspan="6">
						<h1>작성된 글이 없습니다.</h1>
						</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach	var="i" items="${list }" varStatus="vs">
							<tr class="notice_list_tr">
							<td>${totalCount - ((pDto.curPage-1)*10+(vs.count-1)) }</td><td style="text-align: left;" seq=${i.seq } class="notice_seq">${i.title }</td><td>${i.id }</td><td>${fn:substring(i.wdate,0,10) }</td>
							<td>
							<c:choose>
								<c:when test="${i.file_on eq 'Y' }">
									<img alt="" src="/image/disk.png" style="width: 30px; height: 30px">
								</c:when>
							</c:choose>
							</td>
							<td>${i.read_count }</td>
							</tr>
						</c:forEach>					
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>		
	</div>

	<div id="_pagingWrap">
		<c:if test="${pDto.curPage>10 }">
			<a href="#" class="pagelist" page="1"><<</a>&nbsp;&nbsp;&nbsp;<a href="#" class="pagelist" page="${pDto.firstPage-1 }"><</a>&nbsp;&nbsp;&nbsp;
		</c:if> 
		<c:forEach var="i" begin="${pDto.firstPage }" end="${pDto.lastPage }"> 
			<c:choose>
				<c:when test="${i eq pDto.curPage }">
					<strong>[${i }]</strong>
				</c:when>
				<c:otherwise>
					<a href="#" class="pagelist" page="${i }">${i }</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${pDto.totalPage>10 and pDto.totalPage ne pDto.lastPage }">
			&nbsp;&nbsp;&nbsp;<a href="#" class="pagelist" page="${pDto.lastPage+1 }">></a>&nbsp;&nbsp;&nbsp;<a href="#" class="pagelist" page="${pDto.totalPage }">>></a>
		</c:if>
	</div>

<form action="#" id="_detailForm">
	<c:if test="${not empty search.category }">
		<input type="hidden" value="${search.category }" name="category">
	</c:if>
	<c:if test="${not empty search.searchText }">
		<input type="hidden" value="${search.searchText }" name="searchText">
	</c:if>
		<c:if test="${not empty search.begin }">
		<input type="hidden" value="${search.begin }" name="begin">
	</c:if>
		<c:if test="${not empty search.end }">
		<input type="hidden" value="${search.end }" name="end">
	</c:if>
		<c:if test="${search.page != 0}">
		<input type="hidden" value="${search.page }" name="page">
	</c:if>
		<input type="hidden" value="" id="_seq" name="seq">	
</form>	
	
<script type="text/javascript">

$("#menu3").css("background-color","#e60013");

$.datepicker.setDefaults({
    dateFormat: 'yy-mm-dd' //Input Display Format 변경
    ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
    ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
    ,changeYear: false //콤보박스에서 년 선택 가능
    ,changeMonth: false //콤보박스에서 월 선택 가능                
    ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
    ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
    ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
    ,minDate: "-12M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
    ,maxDate: "+6M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
});

//input을 datepicker로 선언
$("#_datepickTo").datepicker();                    
$("#_datepickFrom").datepicker();


$('#_datepickTo').datepicker("option", "maxDate", $("#_datepickFrom").val());
$('#_datepickTo').datepicker("option", "onClose", function ( selectedDate ) {
    $("#_datepickFrom").datepicker( "option", "minDate", selectedDate );
});


$('#_datepickFrom').datepicker("option", "minDate", $("#_datepickTo").val());
$('#_datepickFrom').datepicker("option", "onClose", function ( selectedDate ) {
    $("#_datepickTo").datepicker( "option", "maxDate", selectedDate );
});
$("#_findBtn").on("click",function(){	// 검색버튼 클릭시
	/* alert("클릭됨"); */
	var begin = $("#_datepickTo").val();
	var end = $("#_datepickFrom").val();
	var category = $("#_selectBox").val();
	var search = $("#_textbar").val();
	
	if(begin.trim() == ""){
		$("#_datepickTo").removeAttr("name");
	}
	if(end.trim() == ""){
		$("#_datepickFrom").removeAttr("name");
	}
	if(category.trim() == "" || category.trim() == "선택"){
		$("#_selectBox").removeAttr("name");
	}
	if(search.trim() == ""){
		$("#_textbar").removeAttr("name");
	}
	if(category.trim() != "선택" && search.trim() == ""){
		$("#_selectBox").removeAttr("name");
	}
	$("#_frmForm").attr("action","notice.do").submit();
});

$(".pagelist").on("click",function(){	// 페이징 버튼 눌렀을시
	/* alert("클릭됨"); */
	/* alert($(this).attr("page")); */
	var begin = $("#_datepickTo").val();
	var end = $("#_datepickFrom").val();
	var category = $("#_selectBox").val();
	var search = $("#_textbar").val();
	
	if(begin.trim() == ""){
		$("#_datepickTo").removeAttr("name");
	}
	if(end.trim() == ""){
		$("#_datepickFrom").removeAttr("name");
	}
	if(category.trim() == "" || category.trim() == "선택"){
		$("#_selectBox").removeAttr("name");
	}
	if(search.trim() == ""){
		$("#_textbar").removeAttr("name");
	}
	$("#_curPage").val($(this).attr("page"));
	$("#_frmForm").attr("action","notice.do").submit();
});


$(".notice_seq").on("click",function(){	// detail창으로 넘기기
	/* alert("클릭됨"); */
	var seq = $(this).attr("seq");
	$("#_seq").val(seq);
	$("#_detailForm").attr("action","noticeDetail.do").submit();
	/* location.href = "../common/noticeDetail.do?seq="+seq; */
});
</script>		
</body>
</html>