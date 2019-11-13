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

$(document).ready(function(){
	
	// 이용약관 동의 여부
	var agree = false;
	// 천원단위로 입력하는지 막기위한 트리거
	var payCheck = true;
	
	// 이용약관 라디오 클릭시
	$("#agree_radio").click(function() {
		
		if($("input:checkbox[id=agree_radio]").is(":checked") == true) {
			agree = true;
		}else {
			agree = false;
		}
		
	});
	
	// 결제수단 select 선택시 금액 입력 readonly 해제
	$("#pay_Thing").change(function () {
		if($("#pay_Thing").val() == "card") {
			$("#val_payThing").html("신용카드");
			$("#pay_Money").removeAttr("readonly");
		}else if($("#pay_Thing").val() == "phone") {
			$("#val_payThing").html("휴대폰 결제");
			$("#pay_Money").removeAttr("readonly");
		}else if($("#pay_Thing").val() == "samsung") {
			$("#val_payThing").html("삼성페이");
			$("#pay_Money").removeAttr("readonly");
		}	
//				$("#val_payThing").html($("#pay_Thing").val());
	});
	/*
	$("#pay_Money").keyup(function (event) {
	    var keycode = event.which?event.which:event.keyCode;
		if(keycode === 8 && $("#pay_Money").val().length < 7){
			$("#pay_Money").val("");
			$("#val_payMoney").html("");
			return;
		}
		
		if($("#pay_Money").val().length == 2){
			var mVal = $(this).val();
			if(mVal <= 50) {
				$("#pay_Money").val( $("#pay_Money").val() + ",000" );
				$("#val_payMoney").html($("#pay_Money").val() + "원");
				$("#payMoney_font").css("visibility", "hidden" );
			}else {
				$("#payMoney_font").css("visibility", "visible" );
				$("#pay_Money").val("50,000");
				$("#val_payMoney").html($("#pay_Money").val() + "원");
			}
		}
		
	});
	*/
	
	$("#pay_Money").blur(function() {
		// 만약에 50000원 이상 입력시 5만원으로 바꿔주기
		if($("#pay_Money").val() > 50000) {
			$("#pay_Money").val( 50000 );
			$("#payMoney_font").html("최대 충전금액은 50,000원 입니다.");
			$("#payMoney_font").css("color", "red");
			$("#payMoney_font").css("visibility", "visible" );
			$("#val_payMoney").val( $("#pay_Money").val() );
			$("#val_payMoney").html( $("#val_payMoney").val() + "원" );
			payCheck = true;
			console.log("hidden value :" + $("#val_payMoney").val());
		}else {
			// 만약 금액이 천원단위로 안떨어지면
			if($("#pay_Money").val() % 1000 != 0) {
				$("#payMoney_font").html("금액 단위를 천원 단위로 입력해주세요.");
				$("#payMoney_font").css("visibility", "visible" );
				payCheck = false;
				return;
			}
			// 제대로 입력할 경우
			$("#payMoney_font").css("visibility", "hidden" );
			$("#val_payMoney").val( $("#pay_Money").val() );
			$("#val_payMoney").html( $("#val_payMoney").val() + "원" );
			payCheck = true;
			console.log("hidden value :" + $("#val_payMoney").val());
		}
	});
	
	if($("#pay_Money").val() == "" || $("#pay_Money").val() == null){
		$("#val_payMoney").html("");
	}
	
	// 결제 버튼 클릭시
	$("#payBtn").click(function () {
		if(agree == false) {
			alert("이용약관 동의를 해주세요.");
		}else if($("#pay_Thing").val() == "") {
			alert("결제수단을 선택해 주세요.");
		}else if($("#pay_Money").val() == "") {
			alert("금액을 입력해 주세요.");
			$("#pay_Money").focus();
		}else if($("#pay_Money").val() <= 0) {
			alert("최소 1000원 부터 충전할 수 있습니다.");
			$("#pay_Money").val("");
			$("#pay_Money").focus();
		}else if(payCheck == false) {
			alert("천원단위로 금액을 입력해 주세요.");
		}else {
/*			
*/			
			// 결제수단
			var payThing = $("#pay_Thing").val();
			// 결제금액
			var payMoney = $("#pay_Money").val();
			
			window.open("/mypage/payMoney.do?payThing=" + payThing + "&payMoney=" + payMoney , "payMoney", "width=900, height=700,left=40%, top=40%");
//			$("#payFrm").attr({"action" : "payMoney.do", "method":"get"}).submit();
		}
	});
	
});

/* 	
$("#pay_Money").blur(function () {
	 var currentVal = $(this).val();
    if(currentVal <= 50) {
    	$("#pay_Money").val( $("#pay_Money").val() + ",000" );
    }else {
    	console.log("충전금액은 50,000을 넘을 수 없습니다.");
    	$("#pay_Money").val("");
    }
});
 */