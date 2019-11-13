<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/css/bbsWrite.css">
</head>
<body>

	<div class="card-body">
		<div class="table-responsive"style="display: flex; justify-content: center; align-items: center;">
				<table class="table table-bordered" id="dataTable"style="width: 40%; margin-top: 2%" cellspacing="0">
					<colgroup>
						<col width="30%">
						<col width="70%">
					</colgroup>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >종목</th>
						<td style="border-left: none;"><input type="text" class="form-control"readonly="readonly" value="${gameDetail.category }"></td>
					</tr>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >경기일</th>
						<td style="border-left: none;"><input type="text" class="form-control" readonly="readonly" value="${fn:substring(gameDetail.gdate,0,4) }년 ${fn:substring(gameDetail.gdate,5,7)}월 ${fn:substring(gameDetail.gdate,8,10)}일"> 
						</td>
					</tr>					
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >경기장</th>
						<td style="border-left: none;"><input type="text" class="form-control" readonly="readonly" value="${gameDetail.name_stadium }"> 
						</td>
					</tr>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >1번팀</th>
						<td style="border-left: none;">
						<c:choose>
							<c:when test="${gameDetail.name_team1 == null || gameDetail.name_team1 == '' }">
								<input type="text" class="form-control" readonly="readonly" value="미참가">
							</c:when>
							<c:otherwise>
								<input type="text" class="form-control" readonly="readonly" value="${gameDetail.name_team1 }">
							</c:otherwise>
						</c:choose>
						</td>
					</tr>					
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >2번팀</th>
						<td style="border-left: none;">
						<c:choose>
							<c:when test="${gameDetail.name_team2 == null || gameDetail.name_team2 == '' }">
								<input type="text" class="form-control" readonly="readonly" value="미참가">
							</c:when>
							<c:otherwise>
								<input type="text" class="form-control" readonly="readonly" value="${gameDetail.name_team2 }">
							</c:otherwise>
						</c:choose>						
						</td>
					</tr>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >제목</th>
						<td style="border-left: none;"><input type="text" class="form-control" readonly="readonly" value="${gameDetail.title }"></td>						
					</tr>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none;border-bottom: none" >내용</th>
						<td style="border-left: none;border-bottom: none"></td>						
					</tr>
					<tr>
						<td colspan="2" style="border-top: none;">
						<textarea class="form-control" style="resize: none; width: 80%; margin-left: 10%;" readonly="readonly">${gameDetail.content }</textarea>
						</td>
					</tr>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >배당률</th>
						<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="1번팀:${gameDetail.payout_r1 }배  /  2번팀:${gameDetail.payout_r2}배"></td>						
					</tr>
					<c:choose>
						<c:when test="${gameDetail.game_result != null && gameDetail.game_result != '' }">
							<tr><th colspan="2" style="text-align:center;"><button type="button" class="btn btn-primary" style="width: 100px">경기 결과</button>&nbsp;<button type="button" class="btn btn-primary" style="width: 100px" onclick="history.back()">목록</button></th></tr>
						</c:when>
						<c:otherwise>
							<tr><th colspan="2" style="text-align:center;"><button type="button" class="btn btn-primary" style="width: 100px" onclick="history.back()">목록</button></th></tr>						
						</c:otherwise>
					</c:choose>																				
				</table>
		</div>
	</div>
	
<script type="text/javascript">
$("#_backBtn").click(function(){
	history.back();
});

</script> 	
</body>
</html>