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
						<td style="border-left: none;"><input type="text" class="form-control"readonly="readonly" value="${exchangeDetail.id }" name="id"></td>
					</tr>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >은행</th>
						<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="${exchangeDetail.bank}"> 
						</td>
					</tr>					
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >계좌번호</th>
						<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="${exchangeDetail.bank_number }"> 
						</td>
					</tr>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >요청금액</th>
						<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="${exchangeDetail.exchange_money }원"></td>
					</tr>					
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >요청일시</th>
						<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="20${fn:substring(exchangeDetail.exdate,0,2) }년 ${fn:substring(exchangeDetail.exdate,3,5) }월 ${fn:substring(exchangeDetail.exdate,6,8) }일 "></td>
					</tr>
					<tr>
						<th style="text-align: center; padding-top:3%; border-right: none" >환전여부</th>
						<c:choose>
							<c:when test="${exchangeDetail.ex_check == 1}">
							<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="환전 완료"></td>													
							</c:when>
							<c:otherwise>
							<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="환전 대기중" style="color: red"></td>							
							</c:otherwise>						
						</c:choose>
					</tr>
					<c:if test="${not empty exchangeDetail.sdate }">
					<tr>
					<th style="text-align: center; padding-top:3%; border-right: none" >환전일시</th>
					<td style="border-left: none;"><input type="text" name="title" class="form-control" readonly="readonly" value="${fn:substring(exchangeDetail.sdate,0,4) }년 ${fn:substring(exchangeDetail.sdate,5,7) }월 ${fn:substring(exchangeDetail.sdate,8,10) }일"></td>
					</tr>
					</c:if>
					<tr>
					<c:choose>
						<c:when test="${not empty exchangeDetail.sdate }">
						<th colspan="2" style="text-align:center; border: none;"><button type="button" class="btn btn-primary" style="width: 100px" onclick="history.back()">목록</button></th>
						</c:when>
						<c:otherwise>
						<th colspan="2" style="text-align:center; border: none;"><button type="button" class="btn btn-primary" style="width: 100px" id="doExchange" seq="${exchangeDetail.seq }">환전완료</button>&nbsp;<button type="button" class="btn btn-primary" style="width: 100px" onclick="history.back()">목록</button></th>
						</c:otherwise>
					</c:choose>
					</tr>															
				</table>
		</div>
	</div>
	
<script type="text/javascript">

$("#_backBtn").click(function(){
	history.back();
})

$("#doExchange").click(function(){
	/* alert($(this).attr("seq")); */
	location.href = "admin_exchange_update.do?seq="+$(this).attr("seq");
});

</script> 	
</body>
</html>