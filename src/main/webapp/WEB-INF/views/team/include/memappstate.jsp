<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="user" property="principal" /> 
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<style type="text/css">

body {font-family: Arial, Helvetica, sans-serif;}

/* The Modal (background) */
.memstatemodal {
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
.memstatemodal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 1200px;
}

/* The Close Button */
.memstateclose {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.memstateclose:hover,
.memstateclose:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}

	table{
	border-collapse: collapse;
}
th{
	background-color: #042E6F;
	color: white;
	padding: 15px;
	text-align: center;
}
td{
	border-bottom: 1px solid #A2AAC1;
	padding: 12px;
	text-align: center;
}

</style>
<a href="#" id="memstatemyBtn" class="list-group-item list-group-item-action">팀원신청관리</a>

<!-- The Modal -->
<div id="memstatemyModal" class="memstatemodal">

  <!-- Modal content -->
  <div class="memstatemodal-content">
    <span class="memstateclose">&times;</span>
    팀원신청관리
    <table class="table table-hover table-responsive">
    <thead>
		<tr>
			<th>신청인</th><th>내용</th><th>수락/거절</th>
		</tr>
	</thead>
		<c:if test="${empty memapplist}">
		<tbody>
		<tr>
			<td colspan="3">
				<h4>작성된 글이 없습니다</h4>
			</td>
		</tr>
		</tbody>
		</c:if>
		<c:forEach items="${memapplist }" var="memapp" varStatus="vs">
		<tbody>
		<tr>
			<td>${memapp.id }</td>
			<td>${memapp.content }</td>
			<td>
				<button type="button" id="accept_btn" class="btn btn-primary" user_id="${memapp.id }">수락</button>&nbsp;
				<button type="button" id="reject_btn" class="btn btn-danger" user_id="${memapp.id }">거절</button>
				<input type="hidden" id="team_name" value="${memapp.team_name }">
				<input type="hidden" id="_leader_id" value="${user.username}">
			</td>
		</tr>	
		</tbody>
		</c:forEach>
	</table>
  </div>

</div>

<script>
// Get the modal
var memstatemodal = document.getElementById("memstatemyModal");

// Get the button that opens the modal
var memstatebtn = document.getElementById("memstatemyBtn");

// Get the <span> element that closes the modal
var memstatespan = document.getElementsByClassName("memstateclose")[0];

// When the user clicks the button, open the modal 
memstatebtn.onclick = function() {
	memstatemodal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
memstatespan.onclick = function() {
	memstatemodal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == memstatemodal) {
	  memstatemodal.style.display = "none";
  }
}
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$(document).ajaxSend(function(e, xhr, options) {
    xhr.setRequestHeader(header, token);
});
$("#accept_btn").on('click', function () {
	var team_name = $('#team_name').val();
	var id = $(this).attr("user_id");
	var leader = $("#_leader_id").val();
	$.ajax({
		url: "accept.do",
		type: "POST",
		data: { team_name:team_name, id:id, leader:leader },
		dataType: "text",
		success:function ( data ){
			if(data.trim() == "수락"){
				alert("수락완료했습니다.");
				$('#memstatemyModal').css("display", "none");
				location.reload();
			}else if(data.trim() == "false"){
				alert("실패했습니다.");
			}
		},
		error: function() {
			alert("error");
		}
	});
});

$("#reject_btn").on('click', function () {
	var team_name = $('#team_name').val();
	var id = $(this).attr("user_id");
	var leader = $("#_leader_id").val();
	$.ajax({
		url: "reject.do",
		type: "POST",
		data: { team_name:team_name, id:id, leader:leader },
		dataType: "text",
		success:function ( data ){
			if(data.trim() == "거절"){
				alert("거절했습니다.");
				$('#memstatemyModal').css("display", "none");
				location.reload();
			}else if(data.trim() == "false"){
				alert("실패했습니다.");
			}
		},
		error: function() {
			alert("error");
		}
	});
});

/* $(document).ready(function () {
	$(document).on("click", ".reject_btn", function () {
		var team_name = $('#team_name').val();
		var id = $(this).attr("user_id");
		location.href="reject.do?team_name="+ team_name + "&id="
	});
}); */

</script>  