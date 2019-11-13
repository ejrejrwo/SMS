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
						<th style="text-align: center; padding-top:3%; border-right: none" >아이디</th>
						<td style="border-left: none;"><input type="text" class="form-control"readonly="readonly" value="${member.id } (경고횟수:${member.report_count}회)" name="id"></td>
					</tr>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >가입일</th>
						<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="${fn:substring(member.regidate,0,4) }년 ${fn:substring(member.regidate,5,7)}월 ${fn:substring(member.regidate,8,10)}일"> 
						</td>
					</tr>					
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >이름</th>
						<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="${member.name }"> 
						</td>
					</tr>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >이메일</th>
						<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="${member.email }"></td>
					</tr>					
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >생년월일</th>
						<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="${fn:substring(member.birthday,0,4) }년 ${fn:substring(member.birthday,4,6) }월 ${fn:substring(member.birthday,6,8) }일"></td>
					</tr>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >전화번호</th>
						<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="${member.phone }"></td>						
					</tr>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >주소</th>
						<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="${member.address }"></td>						
					</tr>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >현재 금액 / 총 금액</th>
						<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="${member.now_money }원 / ${member.total_money}원"></td>						
					</tr>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >현재 포인트 / 총 포인트</th>
						<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="${member.now_point }원 / ${member.total_point}원"></td>						
					</tr>
					<tr><th colspan="2" style="text-align:center;"><button type="button" class="btn btn-primary" style="width: 100px" onclick="history.back()">목록</button></th></tr>															
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