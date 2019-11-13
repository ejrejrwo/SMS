//// caps lock 유무 확인
//function caps_lock(e) {
//	console.log("caps_lock function in");
//    var keyCode = 0;
//    var shiftKey = false;
//    keyCode = e.keyCode;
//    shiftKey = e.shiftKey;
//    if (((keyCode >= 65 && keyCode <= 90) && !shiftKey)
//            || ((keyCode >= 97 && keyCode <= 122) && shiftKey)) {
//        show_caps_lock();
//        setTimeout("hide_caps_lock()", 3500);
//    } else {
//        hide_caps_lock();
//    }
//}
//
//function show_caps_lock() {
//	$("#pwdfont").html("CapsLock키가 눌려있습니다.")
//	$("#pwdfont").css("display", "block" );
//}
//
//function hide_caps_lock() {
//	$("#pwdfont").css("display", "none" );
//}

function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    //document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    //document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                //document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("address").focus();
	            }
	        }).open();
	    }



var check = false;	// 아이디체크용

var pattern1 = /[0-9]/;	//숫자패턴용

var pattern2 = /[a-zA-Z]/; // 영어패턴용

var pattern3 = /[~!@\#$%<>^&*]/;     // 원하는 특수문자 추가 제거

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

function randomRange() { // 인증번호 생성
	  return Math.floor( (Math.random() * (9999 - 1000 + 1)) + 1000 );
}

var number = randomRange()+"";


$(function () {
	
	//  로그인 페이지로
	$("#loginBtn").click(function () {
		location.href="loginPage.do";
	});
	// 메인화면 이동
	$(".log-img").click(function () {
		location.href="main.do";
	});
	// 인증 코드 전송
	$("#cernumbtn").click(function() {
			
		if($("#email").val().trim().indexOf("@") == -1){
			
			alert("이메일을 입력하세요");
			
		}else{
			
			number = randomRange()+"";
			
			alert("number " + number);
			
			$.ajax({
				//이동할때 필요한것
				url: "eamilCheck.do",		
				type: "get",		
				data: "email=" + $("#email").val().trim() + "&cerNumber=" + number,
				
				success:function(data, status, xhr){
					
					if(data == "true"){
						
						check = true;
						alert("해당 이메일로 발송하였습니다 확인후 인증번호를 입력하여 주세요");
						
					}else{
						check = false;
						alert("이메일을 확인해 주세요");
					}
				},
				error:function(xhr, status, error){
					alert("이메일을 확인해 주세요.");
				}
			});
		}
	});
	// 아이디 조건
	$("#id").on("propertychange change keyup paste input", function() {
				
		var id = $("#id").val().trim();
		
		if( id.length >= 7 && id.length <= 20 && pattern1.test( id ) && pattern2.test( id ) && !pattern3.test( id ) ){
			
		}else {
			$("#idfont").show();
			$("#idfont").html("7 ~ 20글자의 영문+숫자로 등록해주십시오");
			console.log("values");
		}
	});
	// 비밀번호 조건
	$("#pwd").on("propertychange change keyup paste input", function() {
		
		var pwd = $("#pwd").val().trim();
		
		if( pwd.length >= 8 && pwd.length <= 15 && pattern1.test( pwd ) && pattern2.test( pwd ) && pattern3.test( pwd ) ){
			$("#pwdfont").hide();
		}else {
			$("#pwdfont").html("8~15자리의 특수,영문+숫자로 등록해주십시오")
			$("#pwdfont").show();
		}
				
	});
	// 회원가입 조건
	$("#accountbtn").click(function () {
		
        var pw = $("#pwd").val().trim();
        
        var cernum = $("#cernum").val().trim();

        if(check == false){
			alert("아이디를 확인해 주세요.");
		}else if(!pattern1.test(pw) ||!pattern2.test(pw)||!pattern3.test(pw)||pw.length<8||pw.length>15){
            alert("비밀번호 형식을 확인해 주세요.");
        }else if($("#name").val().trim() == ""){
			alert("이름을 확인해 주세요.");
		}else if($("#address").val().trim() == ""){
			alert("주소를 확인해 주세요.");
		}else if($("#birthday").val().trim().length != 8){
			alert("생일을 확인해 주세요.");
		}else if($("#phone").val().trim().length != 11){
			alert("전화번호를 확인해 주세요.");
		}else if(number.trim() != cernum){
			alert("이메일 인증번호가 다릅니다.");
		}else if($("#height").val().trim().length < 3){
			alert("신장을 확인해 주세요");
		}else if($("#weight").val().trim().length < 1){
			alert("몸무게를 확인해 주세요");
		}else if(grecaptcha.getResponse() == "") {
			alert("로봇이 아닙니다를 확인해 주세요.")
		}else{
			
			if(confirm("입력하신 " + $("#idsave").val() + " 로 가입하게 됩니다 가입하시겠습니까?") == true){
				
				$("#id").val( $("#idsave").val() );
				
				$("#regiFrm").attr({"action":"regi.do", "method":"post"}).submit();
		    }
		    else{
		        return ;
		    }
		}
	});
	// 아이디 체크
	$("#id").change(function () {
		
		 if(($("#id").val().trim().length < 7 || $("#id").val().trim().length > 20 )|| !pattern1.test($("#id").val().trim())){
			 $("idfont").css("display", "block" );
			
		}else{
			$.ajax({
				url:"idCheck.do",		
				type:"get",			
				data:"id=" + $("#id").val(),
				
				success:function(data, status, xhr){
					
					if(data == "true"){
						check = true;
						$("#idfont").css("display", 'none');
						$("#idsave").val( $("#id").val().trim() );
					}else{
						check = false;
						$("#idfont").css("display", "block" );
						$("#idfont").html("이미 사용중인 아이디 입니다.");
					}
					 
				},
				error:function(xhr, status, error){
					alert("통신실패");
					console.log(xhr + ", " + status + "m " + error);
				}
			});
		} 
		
	});
	
});
