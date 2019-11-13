// 페이징
function goPage( pageNumber ) {
	
	$("#_pageNumber").val(pageNumber);
	$("#_frmFormSearch").attr("action", "myPageLike.do").submit();	
}

$(function() {
	// 디테일
	$(".detail").click(function() {
		var seq = $(this).attr("seq");
		location.href="../member/teamBbsdetail.do?seq=" + seq;
	});
	// 검색 셀렉트
	var category = $("#category").val();
	$("#_s_category").val(category).prop("selected", true);
	// 검색
	$("#_btnSearch").click(function () {
		//alert("_btnSearch click");
		$("#_pageNumber").val(0);
		$("#_frmFormSearch").attr("action", "myPageLike.do").submit();	
	});

});