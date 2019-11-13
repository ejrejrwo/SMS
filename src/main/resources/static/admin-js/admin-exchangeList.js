	$.datepicker.setDefaults({
	    dateFormat: 'yy-mm-dd' //Input Display Format 변경
	    ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	    ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	    ,changeYear: false //콤보박스에서 년 선택 가능
	    ,changeMonth: false //콤보박스에서 월 선택 가능                
	    ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	    ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
	    ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	    ,minDate: "-12M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	    ,maxDate: "+6M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
	});

	//input을 datepicker로 선언
	$("#_datepickTo").datepicker();                    
	$("#_datepickFrom").datepicker();


	$('#_datepickTo').datepicker("option", "maxDate", $("#_datepickFrom").val());
	$('#_datepickTo').datepicker("option", "onClose", function ( selectedDate ) {
	    $("#_datepickFrom").datepicker( "option", "minDate", selectedDate );
	});


	$('#_datepickFrom').datepicker("option", "minDate", $("#_datepickTo").val());
	$('#_datepickFrom').datepicker("option", "onClose", function ( selectedDate ) {
	    $("#_datepickTo").datepicker( "option", "maxDate", selectedDate );
	});
	$("#_findBtn").on("click",function(){
		var dateTo = $("#_datepickTo").val();
		var dateFrom = $("#_datepickFrom").val();
		var category = $("#_selectBox").val();
		var searchText = $("#_textbar").val();
/*		alert(dateTo+", "+dateFrom+", "+category+", "+searchText);*/
		$("input[name=begin]").val(dateTo);
		$("input[name=end]").val(dateFrom);
		$("input[name=category]").val(category);
		$("input[name=searchText]").val(searchText);
		
		if(dateTo.trim() == ""){
			$("input[name=begin]").remove();
		}
		if(dateFrom.trim() == ""){
			$("input[name=end]").remove();
		}
		if(category.trim() == "" || category.trim() == "선택"){
			$("input[name=category]").remove();
		}
		if(searchText.trim() == ""){
			$("input[name=searchText]").remove();
		}
		if(category.trim() != "선택" && searchText.trim() == ""){
			$("input[name=category]").remove();
		}
		if($("input[name=sort]").val().trim() == ""){
			$("input[name=sort]").remove();
		}
		if($("input[name=ex_check]").val().trim() == ""){
			$("input[name=ex_check]").remove();
		}
		$("#_frmForm").attr("action","admin_exchange_list.do").submit();
	})
	
	$(".pagelist").on("click",function(){	// 페이징 버튼 눌렀을시
		var dateTo = $("#_datepickTo").val();
		var dateFrom = $("#_datepickFrom").val();
		var category = $("#_selectBox").val();
		var searchText = $("#_textbar").val();

		$("input[name=begin]").val(dateTo);
		$("input[name=end]").val(dateFrom);
		$("input[name=category]").val(category);
		$("input[name=searchText]").val(searchText);
		
		if(dateTo.trim() == ""){
			$("input[name=begin]").remove();
		}
		if(dateFrom.trim() == ""){
			$("input[name=end]").remove();
		}
		if(category.trim() == "" || category.trim() == "선택"){
			$("input[name=category]").remove();
		}
		if(searchText.trim() == ""){
			$("input[name=searchText]").remove();
		}
		if(category.trim() != "선택" && searchText.trim() == ""){
			$("input[name=category]").remove();
		}
		if($("input[name=sort]").val().trim() == ""){
			$("input[name=sort]").remove();
		}
		if($("input[name=ex_check]").val().trim() == ""){
			$("input[name=ex_check]").remove();
		}		
		$("#_curPage").val($(this).attr("page"));
		$("#_frmForm").attr("action","admin_exchange_list.do").submit();
});
	
	$(".sortP").on("click",function(){	// 가격순 버튼 눌렀을시
		var dateTo = $("#_datepickTo").val();
		var dateFrom = $("#_datepickFrom").val();
		var category = $("#_selectBox").val();
		var searchText = $("#_textbar").val();
		var price = $(this).val();

		$("input[name=begin]").val(dateTo);
		$("input[name=end]").val(dateFrom);
		$("input[name=category]").val(category);
		$("input[name=searchText]").val(searchText);
		$("input[name=sort]").val(price);
		if(dateTo.trim() == ""){
			$("input[name=begin]").remove();
		}
		if(dateFrom.trim() == ""){
			$("input[name=end]").remove();
		}
		if(category.trim() == "" || category.trim() == "선택"){
			$("input[name=category]").remove();
		}
		if(searchText.trim() == ""){
			$("input[name=searchText]").remove();
		}
		if(category.trim() != "선택" && searchText.trim() == ""){
			$("input[name=category]").remove();
		}
		if($("input[name=sort]").val().trim() == ""){
			$("input[name=sort]").remove();
		}
		if($("input[name=ex_check]").val().trim() == ""){
			$("input[name=ex_check]").remove();
		}
		
		$("#_frmForm").attr("action","admin_exchange_list.do").submit();
	});	

	
	$("#ex_checkSelect").on("change",function(){	// 환전 여부 셀렉박스 선택시
		
		var dateTo = $("#_datepickTo").val();
		var dateFrom = $("#_datepickFrom").val();
		var category = $("#_selectBox").val();
		var searchText = $("#_textbar").val();
		var ex_check = $(this).val();

		$("input[name=begin]").val(dateTo);
		$("input[name=end]").val(dateFrom);
		$("input[name=category]").val(category);
		$("input[name=searchText]").val(searchText);
		$("input[name=ex_check]").val(ex_check);
		
		if(dateTo.trim() == ""){
			$("input[name=begin]").remove();
		}
		if(dateFrom.trim() == ""){
			$("input[name=end]").remove();
		}
		if(category.trim() == "" || category.trim() == "선택"){
			$("input[name=category]").remove();
		}
		if(searchText.trim() == ""){
			$("input[name=searchText]").remove();
		}
		if(category.trim() != "선택" && searchText.trim() == ""){
			$("input[name=category]").remove();
		}
		if($("input[name=sort]").val().trim() == ""){
			$("input[name=sort]").remove();
		}
		if($("input[name=ex_check]").val().trim() == ""){
			$("input[name=ex_check]").remove();
		}

		$("#_frmForm").attr("action","admin_exchange_list.do").submit();
	});	
	
	

	
	$(".notice_list_tr").on("click",function(){
		/*alert($(this).attr("seq"));*/
		location.href="admin_exchange_detail.do?seq="+$(this).attr("seq");
	});

