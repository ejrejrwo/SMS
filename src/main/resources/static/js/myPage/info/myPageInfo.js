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
		
const pattern1 = /[0-9]/;

const pattern2 = /[a-zA-Z]/;

const pattern3 = /[~!@\#$%<>^&*]/;     // 원하는 특수문자 추가 제거

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
	if (event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
			event.keyCode == 39 || event.keyCode == 46){
		return;
	}
	obj.value = obj.value.replace(/[\ㄱ-ㅎ ㅏ-ㅣ 가-힣]/g, "");
}

$(function () {
	// 계정삭제
	$("#deletebtn").click(function() {
		if(confirm("정말 회원탈퇴를 진행하시겠습니까? 팀에 소속되어 있으면 팀을 먼저 탈퇴 혹은 해체 해야합니다.") == true)
		{
			location.href="infoDelete.do";
		}
	});
	// 비빌번호 조건
	$("#pwd").on("propertychange change keyup paste input", function() {
		
		var pwd = $("#pwd").val().trim();
		
		if( pwd.length >= 8 && pwd.length <= 15 && pattern1.test( pwd ) && pattern2.test( pwd ) && pattern3.test( pwd ) ){
			$("#pwdfont").css("display", "none" );
		}else {
			$("#pwdfont").css("display", "block" );
		}
				
	});
	
	/*$("#updateBtn").on("click", (event) => {*/
	// 업데이트 ( => 방식 )
	$("#updateBtn").on("click", (event) => {
		const pw = $("#pwd").val().trim();
        
		if (!pattern1.test(pw) || !pattern2.test(pw) || !pattern3.test(pw) || pw.length<8 || pw.length > 15) {

            alert("비밀번호는 영문+숫자+특수기호 8~15자리로 구성하여야 합니다.");
            
        } else if ($("#name").val().trim() === "") {
			
			alert("이름을 입력하세요");
			
		} else if ($("#address").val().trim() === "") {
			
			alert("주소를 입력하세요");
			
		} else if ($("#birthday").val().trim().length !== 8) {
			
			alert("생일을 형식이 올바르지 않습니다.");
			
		} else if($("#phone").val().trim().length !== 11) {
			
			alert("전화번호 형식이 올바르지 않습니다.");
			
		} else if($("#email").val().trim().indexOf("@") === -1) {
			
			alert("이메일 형식으로 입력해주세요");
			
		} else if($("#height").val().trim().length < 3) {
			
			alert("신장을 입력해 제대로 주세요");
			
		} else if($("#weight").val().trim().length < 1) {
			
			alert("몸무게를 입력해 제대로 주세요");
			
		} else if($("#height").val().trim() > 230) {
			
			alert("신장을 확인해 주세요");
			
		} else if($("#weight").val().trim() > 130) {
			
			alert("몸무게를 확인해 주세요");
			
		} else {

			$("#infoFrm").attr({"action":"infoChange.do", "method":"post"}).submit();
		
		}
	});
	
});