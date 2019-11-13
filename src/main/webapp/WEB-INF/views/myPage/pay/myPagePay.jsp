<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<% String ctx = request.getContextPath(); %>
	
	<link rel="stylesheet" href="<%=ctx%>/css/myPage/pay/myPagePay.css">
	<script type="text/javascript" src="<%=ctx%>/js/myPage/pay/myPagePay.js"></script>
</head>
<body>
	<form id="payFrm">
		<div class="form-div">
			<div class="form-div-sub1">
				<div style="text-align: left;">
					<p style="font-size:15pt; font-weight:bold; text-align: center;">이용약관</p>
					<textarea class="form-control" readonly="readonly" rows="15" cols="25">전자금융거래 기본약관

제1조 (목적) 

이 약관은 주식회사 케이지이니시스(이하 '회사'라 합니다)가 제공하는 전자지급결제대행서비스 및 결제대금예치서비스를 이용자가 이용함에 있어 회사와 이용자 사이의 전자금융거래에 관한 기본적인 사항을 정함을 목적으로 합니다. 

제2조 (용어의 정의)

이 약관에서 정하는 용어의 정의는 다음과 같습니다. 
1. '전자금융거래'라 함은 회사가 전자적 장치를 통하여 전자지급결제대행서비스 및 결제대금예치서비스(이하 '전자금융거래 서비스'라고 합니다)를 제공하고, 이용자가 회사의 종사자와 직접 대면하거나 의사소통을 하지 아니하고 자동화된 방식으로 이를 이용하는 거래를 말합니다. 
2. '전자지급결제대행서비스'라 함은 전자적 방법으로 재화의 구입 또는 용역의 이용에 있어서 지급결제정보를 송신하거나 수신하는 것 또는 그 대가의 정산을 대행하거나 매개하는 서비스를 말합니다.
3. '결제대금예치서비스'라 함은 이용자가 재화의 구입 또는 용역의 이용에 있어서 그 대가(이하 '결제대금'이라 한다)의 전부 또는 일부를 재화 또는 용역(이하 '재화 등'이라 합니다)을 공급받기 전에 미리 지급하는 경우, 회사가 이용자의 물품수령 또는 서비스 이용 확인 시점까지 결제대금을 예치하는 서비스를 말합니다.
4. '이용자'라 함은 이 약관에 동의하고 회사가 제공하는 전자금융거래 서비스를 이용하는 자를 말합니다. 
5. '접근매체'라 함은 전자금융거래에 있어서 거래지시를 하거나 이용자 및 거래내용의 진실성과 정확성을 확보하기 위하여 사용되는 수단 또는 정보로서 전자식 카드 및 이에 준하는 전자적 정보(신용카드번호를 포함한다), '전자서명법'상의 인증서, 회사에 등록된 이용자번호, 이용자의 생체정보, 이상의 수단이나 정보를 사용하는데 필요한 비밀번호 등 전자금융거래법 제2조 제10호에서 정하고 있는 것을 말합니다.
6. '거래지시'라 함은 이용자가 본 약관에 의하여 체결되는 전자금융거래계약에 따라 회사에 대하여 전자금융거래의 처리를 지시하는 것을 말합니다. 
7. '오류'라 함은 이용자의 고의 또는 과실 없이 전자금융거래가 전자금융거래계약 또는 이용자의 거래지시에 따라 이행되지 아니한 경우를 말합니다.   

제3조 (약관의 명시 및 변경)

① 회사는 이용자가 전자금융거래 서비스를 이용하기 전에 이 약관을 게시하고 이용자가 이 약관의 중요한 내용을 확인할 수 있도록 합니다.
② 회사는 이용자의 요청이 있는 경우 전자문서의 전송방식에 의하여 본 약관의 사본을 이용자에게 교부합니다.    
③ 회사가 약관을 변경하는 때에는 그 시행일 1월 전에 변경되는 약관을 회사가 제공하는 전자금융거래 서비스 이용 초기화면 및 회사의 홈페이지에 게시함으로써 이용자에게 공지합니다.

제4조 (전자지급결제대행서비스의 종류)

회사가 제공하는 전자지급결제대행서비스는 지급결제수단에 따라 다음과 같이 구별됩니다. 

1. 신용카드결제대행서비스: 이용자가 결제대금의 지급을 위하여 제공한 지급결제수단이 신용카드인 경우로서, 회사가 전자결제시스템을 통하여 신용카드 지불정보를 송,수신하고 결제대금의 정산을 대행하거나 매개하는 서비스를 말합니다. 
2. 계좌이체대행서비스: 이용자가 결제대금을 회사의 전자결제시스템을 통하여 금융기관에 등록한 자신의 계좌에서 출금하여 원하는 계좌로 이체할 수 있는 실시간 송금 서비스를 말합니다. 
3. 가상계좌서비스: 이용자가 결제대금을 현금으로 결제하고자 경우 회사의 전자결제시스템을 통하여 자동으로 이용자만의 고유한 일회용 계좌의 발급을 통하여 결제대금의 지급이 이루어지는 서비스를 말합니다. 
4. 기타: 회사가 제공하는 서비스로서 지급결제수단의 종류에 따라 '휴대폰 결제대행서비스', 'ARS결제대행서비스', '상품권결제대행서비스'등이 있습니다.

제5조 (결제대금예치서비스의 내용)

① 이용자(이용자의 동의가 있는 경우에는 재화 등을 공급받을 자를 포함합니다. 이하 본조에서 같습니다)는 재화 등을 공급받은 사실을 재화 등을 공급받은 날부터 3영업일 이내에 회사에 통보하여야 합니다.
② 회사는 이용자로부터 재화 등을 공급받은 사실을 통보받은 후 회사와 통신판매업자간 사이에서 정한 기일 내에 통신판매업자에게 결제대금을 지급합니다.
③ 회사는 이용자가 재화 등을 공급받은 날부터 3영업일이 지나도록 정당한 사유의 제시없이 그 공급받은 사실을 회사에 통보하지 아니하는 경우에는 이용자의 동의없이 통신판매업자에게 결제대금을 지급할 수 있습니다.
④ 회사는 통신판매업자에게 결제대금을 지급하기 전에 이용자에게 결제대금을 환급받을 사유가 발생한 경우에는 그 결제대금을 소비자에게 환급합니다.
⑤ 회사는 이용자와의 결제대금예치서비스 이용과 관련된 구체적인 권리,의무를 정하기 위하여 본 약관과는 별도로 결제대금예치서비스이용약관을 제정할 수 있습니다. 
					</textarea>
					<div style="text-align: right">
						약관동의
						<input type="checkbox" id="agree_radio">
					</div>
				</div>
			</div>

			<div class="form-div-sub2">
				<div class="form-group">
					<select id="pay_Thing" name="payThing" class="form-control">
						<option value="" selected="selected">결제수단</option>
						<option value="card">신용카드</option>
						<option value="phone">휴대폰 결제</option>
						<option value="samsung">삼성페이</option>
					</select>
				</div>	
				<div class="form-group">
			  		<input type="text" class="form-control"  id="pay_Money" name="payMoney" maxlength="6" placeholder="금액을 입력해주세요."
			  			   	  onkeydown="fn_press_han(this);" style="ime-mode:disabled;" readonly="readonly">
		  		</div>
		  		<div class="form-group">
		  			<font id="payMoney_font">최대 충전금액은 50,000원 입니다.</font>
		  		</div>
				<div class="col-xs-6 col-md-4">
	        		<label class="form-control">결제수단</label>
	   			</div>
	   			<div class="col-xs-6 col-md-7">
					<label id="val_payThing" class="form-control"></label>
	   			</div>
	   			<div class="col-xs-6 col-md-4">
	        		<label class="form-control">결제금액</label>
	   			</div>
	   			<div class="col-xs-6 col-md-7">
	   				<input type="hidden" id="val_payMoney_hidden">
					<label id="val_payMoney" class="form-control"></label>
	   			</div>
				<div class="form-group">
					<button type="button" class="btn btn-danger" id="payBtn" style="width: 100%;">결제하기</button>
				</div>
			</div>
		</div>
	</form>
	
</body>
</html>