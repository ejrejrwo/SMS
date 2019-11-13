<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
	<sec:authentication var="user" property="principal" />
<html>
<head>
	<title>Insert title here</title>
	
	<% String ctx = request.getContextPath(); %>
	
	<script type="text/javascript" src="<%=ctx%>/js/myPage/exchange/myPageExchange.js"></script>
	<link rel="stylesheet" href="<%=ctx%>/css/myPage/exchange/myPageExchange.css">
</head>
<body>
	<input type="hidden" id="nowMoney" value="${member.now_money}">
	<form id="exchangeFrm">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="hidden" value="${user.username}" name="id">
		<table class="table table-hover table-responsive">
			<col width="90px;"><col width="200px;">
			<tr>
				<th>환전금액</th>
				<td>
					<input type="text" class="form-control" name="exchange_money" placeholder="환전금액을 입력해 주세요."
  				 			onkeypress="return fn_press(event,'numbers');" onkeydown="fn_press_han(this);" maxlength="8" id="exMoney">
  				 			<font id="exchange_money_font">자신의 보유 금액 이상을 환전할 수 없습니다.</font>
				</td>
			</tr>
			<tr>
				<th>은행선택</th>
				<td>
					<select name="bank" class="form-control" id="exBank">
						<option value="">선택</option>
						<option value="신한">신한</option>
						<option value="국민">국민</option>
						<option value="기업">기업</option>
						<option value="우리">우리</option>
						<option value="농협">농협</option>
						<option value="카카오뱅크">카카오뱅크</option>
					</select>
					<font id="bank_font">은행을 선택해 주세요.</font>
				</td>
			</tr>	
			<tr>	
				<th>계좌번호</th>
				<td>
					<input type="text" class="form-control" size="20" name="bank_number" placeholder="계좌번호를 입력해주세요" onkeydown="fn_press_han(this)" id="bankNumber" readonly="readonly">
					<font id="bank_number_font">계좌번호를 입력해 주세요.</font>
				</td>
			</tr>
		</table>
	</form>
	<table class="table table-hover table-responsive">
		<col width="55%"><col width="45%">
		<tr>
			<td style="text-align: right;">
				<button type="button" id="exchangeBtn"  class="btn btn-default">환전 요청</button>
			</td>
			<td style="text-align: right;">
				<button type="button" id="exBtn"  class="btn btn-info">환전내역</button>			
			</td>
		</tr>
	</table>
	
	

	
	
	
</body>

</html>