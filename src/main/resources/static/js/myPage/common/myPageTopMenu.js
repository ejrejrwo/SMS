$(document).ready(function() {
	
	$(".grade-container").css('display', 'none');
	
	var count = 0;
	
	$("#grade").click(function() {
		console.log("grade Click");
		
		if(count % 2 == 0) {
			$(".grade-container").css('display', 'block');
		}else {
			$(".grade-container").css('display', 'none');
		}
		
		count=count+1;
		
	});
	
	$(".grade-container").click(function() {
		console.log("grade-container click");
		
	});
	
})