<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="user" property="principal" /> 
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<style type="text/css">

body {font-family: Arial, Helvetica, sans-serif;}

/* The Modal (background) */
.memberappAfmodal {
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
.memberappAfmodal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 400px;
}

/* The Close Button */
.memberappAfclose {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.memberappAfclose:hover,
.memberappAfclose:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}

</style>
<a class="list-group-item list-group-item-action" href="#" id="memberappAfBtn">팀원 신청서 보내기</a>

<!-- The Modal -->
<div id="memberappAfModal" class="memberappAfmodal">

  <!-- Modal content -->
  <div class="memberappAfmodal-content">
    <span class="memberappAfclose">&times;</span>
    <table class="table table-hover table-responsive">
		<tr>
			<td>아이디</td>
			<td><input class="form-control" id="id" type="text" value="${user.username}" readonly="readonly"></td>
		</tr>
		<tr>
			<td>신청팀</td>
			<td><input class="form-control" id="team_name" type="text" value="${teamdetail.team_name }" readonly="readonly"></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><textarea class="form-control" id="content" rows="10"></textarea></td>
		</tr>					
	</table>
	<button type="button" id="app_btn" class="btn btn-primary">신청 완료</button>
  </div>
	
</div>

<script>
// Get the modal
var modal = document.getElementById("memberappAfModal");

// Get the button that opens the modal
var btn = document.getElementById("memberappAfBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("memberappAfclose")[0];

// When the user clicks the button, open the modal 
btn.onclick = function() {
	modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
$('#content').val("");
	modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
	  $('#content').val("");
	  modal.style.display = "none";
  }
}

$("#app_btn").on('click', function () {
	var id = $('#id').val();
	var team_name = $('#team_name').val();
	var content = $('#content').val();
	
	if(content == null || content == ""){
		alert("내용을 입력해 주세요");
	}else{
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$(document).ajaxSend(function(e, xhr, options) {
		    xhr.setRequestHeader(header, token);
		});
		
		$.ajax({
			url: "memberapplicationAf.do",
			type: "POST",
			data: { id:id, team_name:team_name, content:content },
			dataType: "text",
			success:function ( data ){
				if(data.trim() == "완료"){
					location.reload();
					alert("팀신청완료 팀장이 승인할때까지 기다려주세요.");
					$('#content').val("");
					$('#memberappAfModal').css("display", "none");
				}else if(data.trim() == "                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   false"){
					alert("실패했습니다.");
				}
			},
			error: function () {
				alert("error");
			}
		});
	}
});

</script>    
    