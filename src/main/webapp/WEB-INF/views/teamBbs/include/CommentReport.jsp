<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style type="text/css">
/* The Modal (background) */
.report2-modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content */
.report2-modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 20em;
}

/* The Close Button */
.report2-close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.report2-close:hover, .report2-close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}

.pointer {
	cursor: pointer;
}
</style>

<!-- 댓글 수정 모달창 -->
<!-- The Modal -->
<div id="report2-myModal" class="report2-modal">

	<!-- Modal content -->
	<div class="report2-modal-content">
		<div align="right">
			<span class="report2-close">&times;</span>
		</div>
		<div class="form-group">
			<label for="DetailReport"><h2>신고 사유</h2></label><br>
			<div align="left" style="border-bottom: 1px solid #ddd; padding-bottom: 7px; border-top: 1px solid #ddd; padding-top: 7px;">
				<strong>신고 아이디 :</strong> &nbsp;&nbsp;<span id="bbsCommentId"></span><br> <strong>신고 제목 :</strong>&nbsp;&nbsp; <span id="bbsCommentContent"></span> 
			</div>
			<div class="row" align="left">
				<div style="padding-left: 25px">
					<input type="radio" name="redioSelect" value="홍보성 글을 올렸습니다." id="ch4" class="pointer"> <label for="ch4" class="pointer"
						style="padding-left: 10px; padding-top: 5px;">홍보성 글을 올렸습니다.</label><br>
				</div>
				<div style="padding-left: 25px">
					<input type="radio" name="redioSelect" value="욕설이 심한 게시글 입니다." id="ch5" class="pointer"> <label for="ch5" class="pointer"
						style="padding-left: 10px; padding-top: 5px;">욕설이 심한 게시글 입니다.</label><br>
				</div>
				<div style="padding-left: 25px">
					<input type="radio" name="redioSelect" value="음란성 글을 올렸습니다." id="ch6" class="pointer"> <label for="ch6" class="pointer"
						style="padding-left: 10px; padding-top: 5px;">음란성 글을 올렸습니다.</label><br>
				</div>
			</div>
			<small id="reportHelp" class="form-text text-muted">관리자가 검토 하여 처리하겠습니다.</small>
			<button style="margin-top: 15px" class="btn btn-primary" onclick="Detailreport2Af()" type="button">보내기</button>
		</div>
	</div>
</div>
<script type="text/javascript">

//alert("모달실행");

// 전역변수 설정 후 자동으로 게터와 세터 역활을 하게 됨.

var CommentSeq;
var user_Id
var report_Id;

function CommentReport(s, i, r ,c) {
//	alert("클릭");
	CommentSeq = s;
	user_Id = i;
	report_Id = r;
	report2_modal.style.display = "block";
	document.getElementById("bbsCommentId").innerHTML = r;
	document.getElementById("bbsCommentContent").innerHTML = c;
}

function Detailreport2Af() {
	var radio_btn = document.getElementsByName("redioSelect");
	var radio_btn_check = 0;
//	alert("댓글 시퀀스 : " + CommentSeq);
//	alert("댓글 아이디 : " + user_Id);
	
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

//	alert(radio_content);	
	}
	
		$.ajax({
			url: "../member/teamBbsReport2.do",
			type: "POST",
			data : {seq:CommentSeq, id:user_Id, content:radio_content, report_id:report_Id},
			dayaType: "text",
			success: function ( data ) {
			//	alert("성공");
				alert(data.msg);
				report2_modal.style.display = "none";
			},
			error: function () {
				alert("실패");
		}
	})	
	
}


//Get the modal
var report2_modal = document.getElementById("report2-myModal");

// Get the button that opens the modal
var report2_btn = document.getElementById("report2-myModal");

// Get the <span> element that closes the modal
var report2_span = document.getElementsByClassName("report2-close")[0];

// When the user clicks on <span> (x), close the modal
report2_span.onclick = function() {
  report2_modal.style.display = "none";
//  document.getElementById("CommentUpdate").value="";
}
</script>