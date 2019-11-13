// caps lock 유무 확인
function caps_lock(e) {
            var keyCode = 0;
            var shiftKey = false;
            keyCode = e.keyCode;
            shiftKey = e.shiftKey;
            if (((keyCode >= 65 && keyCode <= 90) && !shiftKey)
                    || ((keyCode >= 97 && keyCode <= 122) && shiftKey)) {
                show_caps_lock();
 //               setTimeout("hide_caps_lock()", 3500);
            } else {
                hide_caps_lock();
            }
        }

function show_caps_lock() {
    $("#capslock").show();
}

function hide_caps_lock() {
    $("#capslock").hide();
}

$(document).ready(function() {
	
//	$("#security-login-font").css("display", "none");
	
	$("#login-info-font").css("display", "none");
	
	$("#capslock").hide();
	
	// 메인화면 이동
	$(".log-img").click(function () {
		location.href="main.do";
	});
	// 비밀번호 변경
	$("#pwdBtn").click(function () {
		console.log("패스워드버튼");
		location.href="findPwdPage.do";
	});
	// 회원가입
	$("#regiBtn").click(function () {
		console.log("회원가입버튼");
		location.href="regiPage.do";
	});
	// 로그인시
	$("#loginbtn").click(function() { 
		 
		if( $("#id").val().trim() == "" ){
			$("#login-info-font").html("아이디를 입력해주세요.")
			$("#login-info-font").css("color", "red");
			$("#login-info-font").css("display", "block");
			$("#id").focus();
		}
		else if( $("#pwd").val().trim() == "" ){
			$("#login-info-font").html("비밀번호를 입력해주세요.")
			$("#login-info-font").css("color", "red");
			$("#login-info-font").css("display", "block");
			$("#pwd").focus();
		} 
		else {
			$("#frm").attr({"action":"../login", "method":"post"}).submit();
		}
	});

	var user_id = $.cookie("user_id");
	
	if( user_id != null){ // 지정한 쿠키가 있을때
		//alert("쿠키 있음");	
		$("#id").val( user_id );
		$("#chk_save_id").attr("checked", "checked");
	}

	$("#chk_save_id").click(function() {
		if( $("#chk_save_id").is(":checked") ){ // 체크되었을떄
			//alert("체크됌");
			if($("#id").val().trim() == ""){
//				alert("id를 입력해주십시오");
				$("#chk_save_id").prop("checked", false);
			}else{ //정상기입 한경우
				$.cookie("user_id", $("#id").val().trim(), {expires:7, path:'/'}); // 쿠키를 사용하고 7일간 저장 (expires:저장기간 path:모든경로 ?)
			}
		}else{ // 체크 해제되었을때
			//alert("체크 없어짐");
			$.removeCookie("user_id", {path:'/'}); // 기한을 없애면서 삭제가 된다.
		}
		
	}); 
	 
});