
/*숫자만 입력하게함*/
function fn_press(event, type) {
	if(type == 'numbers'){
		if((event.keyCode < 48) || (event.keyCode > 57)){
			return false;
		}
	}
}

/* 한글입력방지 */
function fn_press_han(obj) {
	if(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
			event.keyCode == 39 || event.keyCode == 46){
		return;
	}
	obj.value = obj.value.replace(/[\ㄱ-ㅎ ㅏ-ㅣ 가-힣]/g, "");
}


/* 값 입력시 콤마찍기 */
function inputNumberFormat(obj) {
//   bootbox.alert("input");
    obj.value = comma(uncomma(obj.value));
}

/* 콤마찍기 */
function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{4})+(?!\d))/g, '$1-');
}

/* 콤마풀기 */
function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}

$(document).ready(function() {
	$("#exchange_money_font").css("display", "none");
	$("#bank_font").css("display", "none");
	$("#bank_number_font").css("display", "none");
});

$(function() {
	// 결제방지 변수
	var check = false;
	// 형 변환 ( 최초 선언시 String 값이 되는데 *1 할경우 number 로 변경된다.)
	const money = $("#nowMoney").val() * 1;

	$("#bank_font").css("display", "none" );
	$("#bank_number_font").css("display", "none" );
	$("#exchange_money_font").css("display", "none" );
	//  환전 금액 입력시 조건문
	$("#exMoney").blur(function (event) {
	    var keycode = event.which?event.which:event.keyCode;
	    var exMoney = $("#exMoney").val() * 1;
		if(keycode === 8){
			if( exMoney < money ){
				$("#exchange_money_font").css("display", "none" );
			}
			return;
		}
		
		if(exMoney > money) {
			$("#exchange_money_font").html("자신의 보유 금액 이상을 환전할 수 없습니다.");
			$("#exchange_money_font").css("display", "block" );
			$("#exMoney").val( money );
		}else {
			if( exMoney % 1000 != 0) {
				$("#exchange_money_font").html("금액 단위를 천원 단위로 입력해주세요.");
				$("#exchange_money_font").css("display", "block" );
				check = false;
				return;
			}
			$("#exchange_money_font").css("display", "none" );
			check = true;
		}
		
	});
	// 환전신청 조건문
	$("#exchangeBtn").click(function () {
		var exMoney = $("#exMoney").val() * 1;
		if(exMoney > money){
			$("#exchange_money_font").html("자신의 보유 금액 이상을 환전할 수 없습니다.");
			$("#exchange_money_font").css("display", "block" );
			$("#bank_font").css("display", "none" );
			$("#bank_number_font").css("display", "none" );
		}else if($("#exMoney").val().trim() == ''){
			$("#exchange_money_font").html("금액을 입력해 주세요.");
			$("#exchange_money_font").css("display", "block" );
			$("#bank_font").css("display", "none" );
			$("#bank_number_font").css("display", "none" );
		}else if($("#exBank").val() == ""){
			$("#bank_font").css("display", "block" );
			$("#bank_number_font").css("display", "none" );
			$("#exchange_money_font").css("display", "none" );
		}else if($("#bankNumber").val().trim() == ''){
			$("#bank_number_font").html("계좌번호를 입력해 주세요.")
			$("#bank_number_font").css("display", "block" );
			$("#bank_font").css("display", "none" );
			$("#exchange_money_font").css("display", "none" );
		}else{
			
			if($("#exBank").val() == "신한") {
				
				if($("#bankNumber").val().length != 14) {
					$("#bank_number_font").html("계좌번호를 똑바로 입력해 주세요.")
					$("#bank_number_font").css("display", "block" );
				} else {
					if(check == true) {
//						bootbox.alert("check :" + check);
						$("#exchangeFrm").attr({"action":"myPageExchange.do", "method":"post"}).submit();
						}else {
							$("#exchange_money_font").html("금액을 똑바로 입력해 주세요.");
							$("#exchange_money_font").css("display", "block" );
						}
				}
				
			}else if($("#exBank").val() == "국민") {
				
				if($("#bankNumber").val().length != 16) {
					$("#bank_number_font").html("계좌번호를 똑바로 입력해 주세요.")
					$("#bank_number_font").css("display", "block" );
				} else {
					if(check == true) {
//						bootbox.alert("check :" + check);
						$("#exchangeFrm").attr({"action":"myPageExchange.do", "method":"post"}).submit();
						}else {
							$("#exchange_money_font").html("금액을 똑바로 입력해 주세요.");
							$("#exchange_money_font").css("display", "block" );
						}
				}
				
			}else if($("#exBank").val() == "기업") {
				
				if($("#bankNumber").val().length != 17) {
					$("#bank_number_font").html("계좌번호를 똑바로 입력해 주세요.")
					$("#bank_number_font").css("display", "block" );
				} else {
					if(check == true) {
//						alert("check :" + check);
						$("#exchangeFrm").attr({"action":"myPageExchange.do", "method":"post"}).submit();
						}else {
							$("#exchange_money_font").html("금액을 똑바로 입력해 주세요.");
							$("#exchange_money_font").css("display", "block" );
						}
				}
				
			}else if($("#exBank").val() == "우리") {
				
				if($("#bankNumber").val().length != 15) {
					$("#bank_number_font").html("계좌번호를 똑바로 입력해 주세요.")
					$("#bank_number_font").css("display", "block" );
				} else {
					if(check == true) {
//						bootbox.alert("check :" + check);
						$("#exchangeFrm").attr({"action":"myPageExchange.do", "method":"post"}).submit();
						}else {
							$("#exchange_money_font").html("금액을 똑바로 입력해 주세요.");
							$("#exchange_money_font").css("display", "block" );
						}
				}
				
			}else if($("#exBank").val() == "농협") {
				
				if($("#bankNumber").val().length != 16) {
					$("#bank_number_font").html("계좌번호를 똑바로 입력해 주세요.")
					$("#bank_number_font").css("display", "block" );
				} else {
					if(check == true) {
//						bootbox.alert("check :" + check);
						$("#exchangeFrm").attr({"action":"myPageExchange.do", "method":"post"}).submit();
						}else {
							$("#exchange_money_font").html("금액을 똑바로 입력해 주세요.");
							$("#exchange_money_font").css("display", "block" );
						}
				}
				
			}else if($("#exBank").val() == "카카오뱅크") {
				
				if($("#bankNumber").val().length != 15) {
					$("#bank_number_font").html("계좌번호를 똑바로 입력해 주세요.")
					$("#bank_number_font").css("display", "block" );
				}else {
					if(check == true) {
//					bootbox.alert("check :" + check);
					$("#exchangeFrm").attr({"action":"myPageExchange.do", "method":"post"}).submit();
					}else {
						$("#exchange_money_font").html("금액을 똑바로 입력해 주세요.");
						$("#exchange_money_font").css("display", "block" );
					}
				}
				
			}
			
		}
	});
	// 환전정보 view 이동
	$("#exBtn").click(function () {
		location.href="myPageExchangeInfo.do";
	});
	// 은행 select 변경시
	$("#exBank").change(function() {
		
		$("#bankNumber").val("");
		$("#bank_font").css("display", "none" );
		if($(this).val() == "신한") {
			$("#bankNumber").val("");
			$("#bankNumber").removeAttr( 'readonly' );
			$("#bankNumber").attr("maxlength", "14");
		} else if($(this).val() == "국민") {
			$("#bankNumber").val("");
			$("#bankNumber").removeAttr( 'readonly' );
			$("#bankNumber").attr("maxlength", "16");
		} else if($(this).val() == "기업") {
			$("#bankNumber").val("");
			$("#bankNumber").removeAttr( 'readonly' );
			$("#bankNumber").attr("maxlength", "17");
		} else if($(this).val() == "우리") {
			$("#bankNumber").val("");
			$("#bankNumber").removeAttr( 'readonly' );
			$("#bankNumber").attr("maxlength", "15");
		} else if($(this).val() == "농협") {
			$("#bankNumber").val("");
			$("#bankNumber").removeAttr( 'readonly' );
			$("#bankNumber").attr("maxlength", "16");
		} else if($(this).val() == "카카오뱅크") {
			$("#bankNumber").val("");
			$("#bankNumber").removeAttr( 'readonly' );
			$("#bankNumber").attr("maxlength", "15");
		} else if($(this).val() == ""){
			$("#bankNumber").val("");
			$("#bankNumber").attr('readonly', 'readonly');
		}
		
	});
	
	// 계좌번호 입력시 자동으로 하이픈 추가
	$("#bankNumber").keyup(function(event) {
		var keycode = event.which?event.which:event.keyCode;
		console.log(keycode);
		if(keycode === 8){
			return;
		}
		$("#bank_number_font").css("display", "none" );
		if($("#exBank").val() == "신한") {
			if($("#bankNumber").val().length == 3 || $("#bankNumber").val().length == 7) {
				$("#bankNumber").val($("#bankNumber").val() + "-");
			}
		}else if($("#exBank").val() == "국민") {
			if($("#bankNumber").val().length == 6 || $("#bankNumber").val().length == 9) {
				$("#bankNumber").val($("#bankNumber").val() + "-");
			}
		}else if($("#exBank").val() == "기업") {
			if($("#bankNumber").val().length == 3 || $("#bankNumber").val().length == 10 || $("#bankNumber").val().length == 13) {
				$("#bankNumber").val($("#bankNumber").val() + "-");
			}
		}else if($("#exBank").val() == "우리") {
			if($("#bankNumber").val().length == 4 || $("#bankNumber").val().length == 8) {
				$("#bankNumber").val($("#bankNumber").val() + "-");
			}
		}else if($("#exBank").val() == "농협") {
			if($("#bankNumber").val().length == 3 || $("#bankNumber").val().length == 8 || $("#bankNumber").val().length == 13) {
				$("#bankNumber").val($("#bankNumber").val() + "-");
			}
		}else if($("#exBank").val() == "카카오뱅크") {
			if($("#bankNumber").val().length == 4 || $("#bankNumber").val().length == 7) {
				$("#bankNumber").val($("#bankNumber").val() + "-");
			}
		}
	});
	
});