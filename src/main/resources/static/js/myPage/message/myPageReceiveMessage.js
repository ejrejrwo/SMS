// 페이징
function goPage( pageNumber ) {
	
	$("#_pageNumber").val(pageNumber);
	$("#_frmFormSearch").attr("action", "myPageReceiveMessage.do").submit();	
}
$(function() {
	// 디테일 팝업
	$(".detail").click(function() {
		var seq = $(this).attr("seq");
		window.open("/mypage/myPageReceiveMessageDetail.do?seq=" + seq, "receiveMsgDetail", "width=500, height=500,left=710, top=200");
	});
	// 쪽지작성 팝업
	$("#sendBtn").click(function() {
		window.open("/mypage/myPageWriteMessage.do", "writeMessage", "width=500, height=500, left=710, top=200");
	});
	// 수신거부 팝업
	$("#black-btn").click(function() {
		window.open("/mypage/myPageBlacklist.do", "blacklist", "width=500, height=500, left=710, top=200");
	});
	// 송신함
	$("#sendMsg").click(function () {
		location.href="myPageSendMessage.do?id=" + $("#id").val();
	});
	// 검색 셀렉트
	var category = $("#category").val();
	$("#_s_category").val(category).prop("selected", true);
	// 검색
	$("#_btnSearch").click(function () {
		//alert("_btnSearch click");
		$("#_pageNumber").val(0);
		$("#_frmFormSearch").attr("action", "myPageReceiveMessage.do").submit();	
	});
	$("#msgAllCheck").click(function() {
		if($("#msgAllCheck").prop("checked")) {
			$("input[name=msgCheck]").prop("checked", true);
		} else {
			$("input[name=msgCheck]").prop("checked", false);
		}
	});
	
	$(".check-td").on('click', function() {
		
		var isChecked = $(this).find('input[type="checkbox"]');
		
		if(isChecked) {
			$(this).find('input[type="checkbox"]').attr('checked', true);
		}else {
			$(this).find('input[type="checkbox"]').attr('checked', false);
		}
		
	});
	
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
			    	$("#deleteFrm").attr("action", "myPageAllReceiveMessageDelete.do").submit();
			    }
			});
		}
	});
});