<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="user" property="principal" />
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<style type="text/css">
/* The Modal (background) */
.ms_modal {
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
.ms_modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 50%;
}

/* The Close Button */
.ms_close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.ms_close:hover,
.ms_close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
</style>

<!-- 쪽지 보내기 모달창 -->
<!-- The Modal -->
<div id="ms_myModal" class="modal">

  <!-- Modal content -->
  <div class="ms_modal-content">
    <div align="right">
    <span class="ms_close">&times;</span>
    </div>
	  <div class="form-group">
	  	 <label for="exampleInputEmail1"><h2>쪽지 보내기</h2></label>
		  <textarea class="form-control" id="_sendContent" placeholder="${bbsdto.id } 님에게 쪽지 내용을 적어주세요" rows="10" cols="10"></textarea>
 	  </div>
		  <button class="btn btn-primary" onclick="sendMessage('${bbsdto.id }')" type="button" class="btn btn-primary">작성 완료</button>
  </div>

</div>

<script type="text/javascript">
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$(document).ajaxSend(function(e, xhr, options) {
    xhr.setRequestHeader(header, token);
});

function _go_send_message() {
	id_modal.style.display = "none";
	$("#_sendContent").focus();
	ms_modal.style.display = "block";
}

function sendMessage(r_id) {
	var send_id = '${user.username}';
	var receive_id = r_id;
	var content = document.getElementById("_sendContent").value;
		$.ajax({
			url: "/mypage/myPageWriteMessageSuc.do",
			type :"POST",
			data : {send_id:send_id, receive_id:receive_id, content:content},
			dataType : "text",
			success: function () {
				alert("쪽지 보내기 성공");
				document.getElementById("_sendContent").value="";
				ms_modal.style.display = "none";
			},
			error: function () {
				alert("error");
			}		
		});
	} 

//Get the modal
var ms_modal = document.getElementById("ms_myModal");

//Get the button that opens the modal
var ms_btn = document.getElementById("ms_myModal");

// Get the <span> element that closes the modal
var ms_span = document.getElementsByClassName("ms_close")[0];

// When the user clicks on <span> (x), close the modal
ms_span.onclick = function() {
  ms_modal.style.display = "none";
  document.getElementById("_sendContent").value="";
}
</script>