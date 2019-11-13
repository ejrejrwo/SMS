<%@page import="com.boot.finalpro.teambbs.model.OverlapDTO"%>
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

<!-- security ajax -->
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%-- 
<% 
OverlapDTO odto = (OverlapDTO)request.getAttribute("odto");
// System.out.println("odto:" + odto.toString());
%>
 --%>
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
			 	 <div class="row" align="left">
			  	   <div style="padding-left: 25px">
					   <input type="radio" name="redioSelect" value="홍보성 글을 올렸습니다." id="ch4" class="pointer">
					     <label for="ch4" class="pointer" style="padding-left: 10px; padding-top: 5px;" >홍보성 글을 올렸습니다.</label><br>
			   	   </div>
					<div style="padding-left: 25px">
					   <input type="radio" name="redioSelect" value="욕설이 심한 글 입니다." id="ch5" class="pointer">
					     <label for="ch5" class="pointer" style="padding-left: 10px; padding-top: 5px;">욕설이 심한 글 입니다.</label><br>
					 </div>
					<div style="padding-left: 25px">
					   <input type="radio" name="redioSelect" value="음란성 글을 올렸습니다." id="ch6" class="pointer">
					     <label for="ch6" class="pointer" style="padding-left: 10px; padding-top: 5px;">음란성 글을 올렸습니다.</label><br>
			  		 </div>
	 	    	 </div>
	 	  	  <small id="reportHelp" class="form-text text-muted">관리자가 검토 하여 처리하겠습니다.</small>
			  <button style="margin-top: 15px" class="btn btn-primary" onclick="DetailreportAf()" type="button">보내기</button>
	      </div>
		</div>
</div>
<script type="text/javascript">
var VideoSeq;
var user_Id;
var report_Id;

function VideoReport(seq_video, id, report_id) {
	if(report_id == "guest"){
		alert("로그인 후 신고 가능합니다.");
		location.href="loginPage.do";
		return;
	}
	else if(id == report_id){
		alert("자신의 글은 신고하실 수 없습니다.");
		return;
	}
	
	else if(${not empty odto }){
		alert("이미 신고한 글입니다.");
		return;
	}
	
//	alert("VideoSeq:" + seq_video + ", 글쓴이:" + id + ", 신고:" + report_id);
	VideoSeq = seq_video;
	user_Id = id;
	report_Id = report_id;
	
	report_modal.style.display = "block";
}

function DetailreportAf() {
	var radio_btn = document.getElementsByName("redioSelect");
	var radio_btn_check = 0;
//	alert("글 시퀀스 : " + VideoSeq);
//	alert("글 아이디 : " + user_Id);
	
	var radio_content;
	for (var i = 0; i < radio_btn.length; i++) {
		if(radio_btn[i].checked==true){
			radio_content = radio_btn[i].value;
			radio_btn_check++;
		}
	}
	
	if(radio_btn_check == 0){
		alert("신고 사유를 선택해주십시오.");
		return;
	}
	
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$(document).ajaxSend(function(e, xhr, options) {
	    xhr.setRequestHeader(header, token);
	});
		$.ajax({
			url: "../common/videoReport.do",
			type: "POST",
			data : {seq_video:VideoSeq, seq:VideoSeq, id:report_Id, content:radio_content, write_id:user_Id},
			dayaType: "text",
			success: function ( msg ) {
			//	alert("성공");
				alert(msg);
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
//  document.getElementById("VideoUpdate").value="";
}
</script>