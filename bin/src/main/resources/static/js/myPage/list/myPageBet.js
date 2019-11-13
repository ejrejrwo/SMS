// 페이징
function goPage( pageNumber ) {
	
	$("#_pageNumber").val(pageNumber);
	$("#_frmFormSearch").attr("action", "myPageBet.do").submit();
	
}