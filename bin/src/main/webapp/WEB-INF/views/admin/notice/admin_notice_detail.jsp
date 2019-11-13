<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/css/bbsdetail.css">
</head>
<body>
	<div id="_topBar">
		공지사항
	</div>
	<div id="_tableWrap">
		<table>
			<colgroup><col width="10%"><col width="90%"></colgroup>
			<thead>
				<tr style="height: 70px;">
				<th colspan="2" style="border-bottom:1px solid #DDD0D0;text-align: center; font-size: 30px" id="_titleTh">${dto.title }</th>
				</tr>
			</thead>
			<tbody>
				<tr style="height: 70px">
				<th style="border-bottom:1px solid #DDD0D0;text-align: center;" class="writeTh"><div>작성일</div></th><td style="border-bottom:1px solid #DDD0D0;text-align: left;padding-left: 2%">${fn:substring(dto.wdate,0,10) }</td>
				</tr>
				<tr style="height: 70px">
				<th style="border-bottom:1px solid #DDD0D0;text-align: center;" class="writeTh"><div>작성자</div></th><td style="border-bottom:1px solid #DDD0D0;text-align: left; padding-left: 2%">${dto.id }</td>
				</tr>				
				<tr>
				<td colspan="2" id="_contentTd" style="text-align: center;">${dto.content }</td>
				</tr>
				<tr style="height: 70px">
				<th style="border-bottom:1px solid #DDD0D0;text-align: center;" class="writeTh"><div>첨부파일</div></th>
				<td style="border-bottom:1px solid #DDD0D0;text-align: left; padding-left: 2%">
				<c:choose>
					<c:when test="${empty fileList }">
					첨부파일이 없습니다.
					</c:when>
					<c:otherwise>
					<c:forEach var="i" items="${fileList }">
						<img alt="" src="/image/disk.png" class="disk_img">&nbsp;<a href="#" seq="${i.file_seq }" class="downBtn">${i.originalName }</a>(다운로드:${i.down_count }회)&nbsp;&nbsp;&nbsp;
					</c:forEach>
					</c:otherwise>
				</c:choose>
				</td>
				</tr>
				<tr height="100px">
					<th colspan="2" id="_btnTh"><button type="button" id="_updateBtn" style="margin-right: 3%">글 수정</button><button id="_backBtn" type="button" style="margin-left: 3%">목록</button></th>
				</tr>												
			</tbody>
		</table>
	</div>
<input type="hidden" value="${dto.seq }" id="_seqHidden">	
<script type="text/javascript">
$(".downBtn").on("click",function(){
	/* alert($(this).attr("seq")); */
	var file_seq = $(this).attr("seq");
	location.href = "../common/noticeFileDown.do?file_seq="+file_seq;
})
$("#_backBtn").click(function(){
	history.back();
});
$("#_updateBtn").click(function(){
	location.href = "admin_notice_update.do?seq="+$("#_seqHidden").val();
})

</script>	
</body>
</html>