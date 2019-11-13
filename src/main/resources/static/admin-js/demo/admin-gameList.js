/**
 * 
 */
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
	
	$("#_checkAll").on("click",function(){	//삭제 체크박스 다 눌렀을때
		var chk = $(this).is(":checked");
		if(chk) $(".delCheck").prop('checked',true);
		else $(".delCheck").prop('checked',false);
	})
	
	$("#_findBtn").on("click",function(){
		var dateTo = $("#_datepickTo").val();
		var dateFrom = $("#_datepickFrom").val();
		var category = $("#_selectBox").val();
		var searchText = $("#_textbar").val();
		var g_result = $("input[name=g_result]").val();
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
		if(g_result.trim() == ""){
			$("input[name=g_result]").remove();
		}
		$("#_frmForm").attr("action","admin_game_list.do").submit();
	})
	
	$(".pagelist").on("click",function(){	// 페이징 버튼 눌렀을시
		var dateTo = $("#_datepickTo").val();
		var dateFrom = $("#_datepickFrom").val();
		var category = $("#_selectBox").val();
		var searchText = $("#_textbar").val();
		var g_result = $("input[name=g_result]").val();
		
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
		
		if(g_result.trim() == ""){
			$("input[name=g_result]").remove();
		}
		
		$("#_curPage").val($(this).attr("page"));
		$("#_frmForm").attr("action","admin_game_list.do").submit();
	});
	
	$(".resultChk").click(function() {
		/*alert($(this).val());*/
		var dateTo = $("#_datepickTo").val();
		var dateFrom = $("#_datepickFrom").val();
		var category = $("#_selectBox").val();
		var searchText = $("#_textbar").val();
		var g_result = $(this).val();

		$("input[name=begin]").val(dateTo);
		$("input[name=end]").val(dateFrom);
		$("input[name=category]").val(category);
		$("input[name=searchText]").val(searchText);
		$("input[name=g_result]").val(g_result);
		
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
		if(g_result.trim() == ""){
			$("input[name=g_result]").remove();
		}	
		
		$("#_frmForm").attr("action","admin_game_list.do").submit();		
	});
	
	$("#_delBtn").on("click",function(){
		var seqs = [];
		$(".delCheck:checked").each(function() {
			seqs.push($(this).attr("seq"));
		})
		location.href="admin_notice_delete.do?seqs="+seqs;
	});

	
	$(".notice_list_tr").on("click",function(){

		location.href="admin_game_detail.do?game_seq="+$(this).attr("seq_game");
	});
