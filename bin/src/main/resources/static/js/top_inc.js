$(function() {
	$("#logout").click(function() {
		$("#frm").attr("action", "../logout").submit();	
	});
});

