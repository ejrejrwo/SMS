<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
/* The Modal (background) */
.update-modal {
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
.update-modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 50%;
}

/* The Close Button */
.update-close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.update-close:hover,
.update-close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
</style>

<!-- 댓글 수정 모달창 -->
<!-- The Modal -->
<div id="update-myModal" class="update-modal">

  <!-- Modal content -->
  <div class="update-modal-content">
    <div align="right">
    <span class="update-close">&times;</span>
    </div>
	  <div class="form-group">
	  	 <label for="CommentUpdate"><h2>댓글 수정</h2></label>
		  <textarea class="form-control" id="CommentUpdate" placeholder="댓글을 입력해 주세요" rows="10" cols="10"></textarea>
	 	  <small id="updateHelp" class="form-text text-muted">상대를 비방하는 행위는 김민호 한테 혼납니다.</small>
 	  </div>
		  <button class="btn btn-primary" id="submitUpdate" type="button">작성 완료</button>
  </div>

</div>

<script type="text/javascript">

//alert("모달실행");

// 전역변수 설정 후 자동으로 게터와 세터 역활을 하게 됨.
var CommentSeq;

function CommentUpdate( v ) {
//	alert("v = " + v);
	CommentSeq=v;
//	alert(CommentSeq);
	update_modal.style.display = "block";	
	
	$("#CommentUpdate").focus();
}

$("#submitUpdate").on('click', function () {
//	alert("클릭");
	var CommentSeqNum = CommentSeq;
//	alert(CommentSeqNum);
	var _content = document.getElementById("CommentUpdate").value;
//	alert(_content);
	if(_content == null || _content == ""){
		alert("수정 내용을 입력 해주세요");
	}else{	
		$.ajax({
			url: "../member/teamBbsCommentUpdate.do",
			type: "POST",
			data : {seq:CommentSeqNum, content:_content},
			dayaType: "text",
			success: function ( msg ) {
				alert(msg);
				location.reload();
			},
			error: function () {
				alert("error");
			}
		})
	}
});
/* 
function commentUpdateAf() {
	alert("클릭");
}
 */
//Get the modal
var update_modal = document.getElementById("update-myModal");

// Get the button that opens the modal
var update_btn = document.getElementsByClassName("dropdown-item")[0];

// Get the <span> element that closes the modal
var updatespan = document.getElementsByClassName("update-close")[0];

// When the user clicks on <span> (x), close the modal
updatespan.onclick = function() {
  update_modal.style.display = "none";
  document.getElementById("CommentUpdate").value="";
}
</script>