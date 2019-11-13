<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="user" property="principal" />


    <style type="text/css">
/* The Modal (background) */
.reply_modal {
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
.reply_modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 50%;
}

/* The Close Button */
.reply_close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.reply_close:hover,
.reply_close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
</style>

<!-- 대 댓글 모달창 -->
<!-- The Modal -->
<div id="reply_myModal" class="reply_modal">

  <!-- Modal content -->
  <div class="reply_modal-content">
    <div align="right">
    <span class="reply_close">&times;</span>
    </div>
	  <div class="form-group">
	  	 <label for="CommentReply"><h2>대댓글 작성</h2></label>
		  <textarea class="form-control" id="CommentReply" placeholder="댓글을 입력해 주세요" rows="10" cols="10"></textarea>
	 	  <small id="ReplyHelp" class="form-text text-muted">상대를 비방하는 행위는 김민호 한테 혼납니다.</small>
 	  </div>
		  <button class="btn btn-primary" onclick="commentreply()" type="button" class="btn btn-primary">작성 완료</button>
  </div>

</div>

<script type="text/javascript">

var seq;
var parent;
var reply_id;
function CommentReply( v , s , n ) {
	
	seq = v;
	parent = s;
	reply_id = n;
//	alert("seq : " + seq);
//	alert("parent seq : " + parent);
//	alert("reply_id : " +reply_id);
	reply_modal.style.display = "block";
	$("#CommentReply").focus();
}

function commentreply() {
//	alert(seq);
//	alert(parent);
	var id = '${user.username }';
	var content = document.getElementById("CommentReply").value;
//	alert(content);
	if(content == null || content == ""){
		alert("답글 내용을 입력 해주세요");
	}else{
		$.ajax({
			url: "../member/teamBbsCommentReply.do",
			type: "POST",
			data : {seq:seq, reply_id:reply_id, parent:parent, id:id, content:content},
			dataType: "text",
			success: function () {
			//	alert("성공");
				location.reload();
				modal.style.display = "none";
			},
			error: function () {
			//	alert("실패");
			}
		})
	}
}


//Get the modal
var reply_modal = document.getElementById("reply_myModal");

// Get the button that opens the modal
var update_btn = document.getElementsByClassName("dropdown-item")[0];

// Get the <span> element that closes the modal
var reply_span = document.getElementsByClassName("reply_close")[0];

// When the user clicks on <span> (x), close the modal
reply_span.onclick = function() {
  reply_modal.style.display = "none";
  document.getElementById("CommentReply").value="";
}
</script>