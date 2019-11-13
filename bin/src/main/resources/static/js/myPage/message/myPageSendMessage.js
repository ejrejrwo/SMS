// 페이징
function goPage( pageNumber ) {
	
	$("#_pageNumber").val(pageNumber);
	$("#_frmFormSearch").attr("action", "myPageSendMessage.do").submit();	
}

$(function() {
	// 팝업 디테일 접근
	$(".detail").click(function() {
		var seq = $(this).attr("seq");
		window.open("/mypage/myPageSendMessageDetail.do?seq=" + seq, "sendMsgDetail", "width=500, height=500,left=710, top=200");
	});
	// 팝업 쪽지 작성
	$("#sendBtn").click(function() {
		window.open("/mypage/myPageWriteMessage.do", "writeMessage", "width=500, height=500,left=710, top=200");
	});
	// 수신함으로 이동
	$("#receiveMsg").click(function () {
		location.href="myPageReceiveMessage.do?id=" + $("#id").val();
	});
	
	// 검색 셀렉트
	var category = $("#category").val();
	$("#_s_category").val(category).prop("selected", true);
	// 검색
	$("#_btnSearch").click(function () {
		//alert("_btnSearch click");
		$("#_pageNumber").val(0);
		$("#_frmFormSearch").attr("action", "myPageSendMessage.do").submit();	
	});
	
	$("#msgAllCheck").click(function() {
		if($("#msgAllCheck").prop("checked")) {
			$("input[name=msgCheck]").prop("checked", true);
		} else {
			$("input[name=msgCheck]").prop("checked", false);
		}
	});
	
	
	
	/*$(".allCheck-box").on('click', function() {
		var isAllChecked = $(this).find('input[type="checkbox"]').prop("checked");
		console.log("th클릭시" + isAllChecked);
		if(isAllChecked) {
			$(this).find('input[type="checkbox"]').attr('checked', false);
			$("input[name=msgCheck]").prop("checked", false);
		}else {
			$(this).find('input[type="checkbox"]').attr('checked', true);
			$("input[name=msgCheck]").prop("checked", true);
		}
	});*/
	
	/*$(".check-box").on('click', function() {
		var isChecked = $(this).find('input[type="checkbox"]').prop("checked");
		console.log("td 클릭시" + isChecked);
		if(isChecked) {
			$(this).find('input[type="checkbox"]').attr('checked', false);
		}else {
			$(this).find('input[type="checkbox"]').attr('checked', true);
		}
		
	});*/
	
	$("#delBtn").on('click', function() {
		
		var checks = $("input[name='msgCheck']");
		var isChecked = false;
		
		for(var i = 0; i < checks.length; i++) {
			if(checks.eq(i).prop("checked")) {
				isChecked = true;
			}
		}
		
		if(!isChecked) {
			alert("삭제 항목을 선택하세요.");
			return ;
		}else {
			confirm("쪽지를 삭제합니다.", function(result){ 
			    if(result) {
			    	$("#deleteFrm").attr("action", "myPageAllSendMessageDelete.do").submit();
			    }
			});
		}
	});
	
});