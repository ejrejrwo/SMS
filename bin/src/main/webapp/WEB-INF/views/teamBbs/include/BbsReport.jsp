<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
/* The Modal (background) */
.report-modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.report-modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 20em;
}

/* The Close Button */
.report-close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.report-close:hover,
.report-close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
.pointer{
  cursor: pointer;
}

</style>

<!-- 댓글 수정 모달창 -->
<!-- The Modal -->
<div id="report-myModal" class="report-modal">
	  <!-- Modal content -->
	  <div class="report-modal-content">
	    <div align="right">
	    <span class="report-close">&times;</span>
	    </div>
		  <div class="form-group">
		  	
		  	 <label for="DetailReport"><h2>신고 사유</h2></label><br>
		  	
		  	 <div align="left" style="border-bottom: 1px solid #ddd; padding-bottom: 7px; border-top: 1px solid #ddd; padding-top: 7px;">
		     <strong>신고 아이디 :</strong> &nbsp;&nbsp;${bbsdto.id }<br>
		     <strong>신고 제목 :</strong>&nbsp;&nbsp; ${bbsdto.title }
		  	 </div>
			 	 <div class="row" align="left" style="margin-top: 5px">
			  	   <div style="padding-left: 25px">
					   <input type="radio" name="redioSelect" value="홍보성 글을 올렸습니다." id="ch1" class="pointer">
					     <label for="ch1" class="pointer" style="padding-left: 10px; padding-top: 5px;" >홍보성 글을 올렸습니다.</label><br>
			   	   </div>
					<div style="padding-left: 25px">
					   <input type="radio" name="redioSelect" value="욕설이 심한 게시글 입니다." id="ch2" class="pointer">
					     <label for="ch2" class="pointer" style="padding-left: 10px; padding-top: 5px;">욕설이 심한 게시글 입니다.</label><br>
					 </div>
					<div style="padding-left: 25px">
					   <input type="radio" name="redioSelect" value="음란성 글을 올렸습니다." id="ch3" class="pointer">
					     <label for="ch3" class="pointer" style="padding-left: 10px; padding-top: 5px;">음란성 글을 올렸습니다.</label><br>
			  		 </div>
	 	    	 </div>
	 	  	  <small id="reportHelp" class="form-text text-muted">관리자가 검토 하여 처리하겠습니다.</small>
			  <button style="margin-top: 15px" class="btn btn-primary" onclick="DetailReportAf()" type="button">보내기</button>
	      </div>
		</div>
</div>
<script type="text/javascript">

//alert("모달실행");

// 전역변수 설정 후 자동으로 게터와 세터 역활을 하게 됨.
var detailSeq;
var user_Id
var report_id;
function report() {
//	alert("클릭");
	detailSeq = document.getElementById("_report").getAttribute("seq");
	user_Id = document.getElementById("_report").getAttribute("user_id");
	report_id = document.getElementById("_report").getAttribute("report_id");
	
	report_modal.style.display = "block";
}

function DetailReportAf() {
	var radio_btn = document.getElementsByName("redioSelect");
	var radio_btn_check = 0;
	var radio_content;
	for (var i = 0; i < radio_btn.length; i++) {
		if(radio_btn[i].checked==true){
			radio_content = radio_btn[i].value;
			radio_btn_check++;
		}
	}
	
	if(radio_btn_check == 0){
		alert("선택 한 값이 없습니다.");
		return;
	}else{
//	alert(detailSeq);		게시판 시퀀스
//	alert(user_Id);			유저 아이디
//	alert(radio_content);	
	}
		$.ajax({
			url: "../member/teamBbsReport.do",
			type: "POST",
			data : {seq:detailSeq, report_id:report_id, id:user_Id, content:radio_content, parent:detailSeq},
			dayaType: "text",
			success: function ( data ) {
				alert(data.msg);
				report_modal.style.display = "none";
			},
			error: function () {
				alert("실패");
		}
	})	
}


//Get the modal
var report_modal = document.getElementById("report-myModal");

// Get the button that opens the modal
var report_btn = document.getElementById("report-myModal");

// Get the <span> element that closes the modal
var report_span = document.getElementsByClassName("report-close")[0];

// When the user clicks on <span> (x), close the modal
report_span.onclick = function() {
  report_modal.style.display = "none";
//  document.getElementById("CommentUpdate").value="";
}
</script>