/**
 * 
 */

$(document).ready(function() {
	var a = 0 ;

	$("#_fileUpload").on("click",function(){
		a ++;
		var str = "<div class='filebox'><br><input class='upload-name bs3-primary' value='파일선택' disabled='disabled'><label for='ex_file"+a+"'>업로드</label><input type='file' name='file' id='ex_file"+a+"' class='upload-hidden'><button type='button' class='delBtn btn btn-danger' style='width:100px; height:41px; margin-left:5%;'>삭제하기</button><br></div>"
		$(this).after(str);
		
		$(".delBtn").on("click",function(){
			$(this).parent().remove();
		})

		var fileTarget = $('.filebox .upload-hidden');
		
		fileTarget.on('change', function(){ // 값이 변경되면 
			if(window.FileReader){ // modern browser 
				var filename = $(this)[0].files[0].name; } 
			else { // old IE 
				var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
				} 
			// 추출한 파일명 삽입 
			$(this).siblings('.upload-name').val(filename);
			});
	});
	
	$("#_submit").on("click",function(){
		/*alert("클릭됨");*/ 
		/*$("#_frmForm").submit();*/
		var a = document.getElementsByClassName("delDiv").length;
		var abc = new Array();
		for (var i = 0; i < a; i++) {
			if($("#_del"+(i+1)+"Dive").css("display")=="none"){
				/*alert("삭제요청 seq번호:"+$("#_del"+(i+1)+"Dive").attr("seq"));*/
				abc[i] = $("#_del"+(i+1)+"Dive").attr("seq");
			}
		}
		$("input[name='seqDel']").val(abc);
		/*alert($("input[name='seqDel']").val());*/
		$("#_frmForm").submit();
	});
	
	
});