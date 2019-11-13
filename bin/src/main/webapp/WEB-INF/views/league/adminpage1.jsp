<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">

.modal {
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
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 500px;
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}

table, td, th {
	text-align: center;
}

</style>

<%
	String category = (String)request.getParameter("category");
	if(category == null || category.equals("") ){
		category = "0";
	}
%>

<form action="" method="get">
	<!-- <table class="table table-hover table-responsive"> -->
	<table class="table table-bordered dataTable">
		<tr>
			<td colspan="5">
			</td>
			<td colspan="2">
				<select name="category" class="form-control">
					<option <%=(category).equals("0")? "selected='selected'":"" %> value="0">축구</option>
					<option <%=(category).equals("1")? "selected='selected'":"" %> value="1">농구</option>
					<option <%=(category).equals("2")? "selected='selected'":"" %> value="2">야구</option>
					<option <%=(category).equals("3")? "selected='selected'":"" %> value="3">배드민턴</option>
					<option <%=(category).equals("4")? "selected='selected'":"" %> value="4">탁구</option>
				</select>
			</td>
			<td>
				<button type="submit" class="btn btn-default">검색</button>
			</td>
			<td colspan="3">
			</td>
		</tr>
		<tr>
			<th>번호</th><th>팀이름</th><th>팀장</th><th>좋아요</th><th>신고수</th><th>축구MMR</th><th>농구MMR</th><th>야구MMR</th><th>배드민턴MMR</th><th>탁구MMR</th><th>쪽지보내기</th>
		</tr>
		<c:if test="${empty ranklist }">
			<tr>
				<th colspan="11">
					데이터가 없습니다
				</th>
			</tr>
		</c:if>
		<c:if test="${not empty ranklist }">
			<c:forEach items="${ranklist }" var="v" varStatus="vs">
				<tr>
					<td>${vs.count }</td>
					<td>${v.team_name }</td>
					<td>${v.leader }</td>
					<td>${v.like_count }</td>
					<td>${v.report_count }</td>
					<td>${v.soccer_mmr }</td>
					<td>${v.basketball_mmr }</td>
					<td>${v.baseball_mmr }</td>
					<td>${v.badminton_mmr }</td>
					<td>${v.pingpong_mmr }</td>
					<td>
						<button type="button" class="btn btn-default" onclick="message('${v.leader }')">보내기</button>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	
</form>

<form id="messageform">
<!-- The Modal -->
	<div id="myModal" class="modal">
	
	  <!-- Modal content -->
	  <div class="modal-content">
	     <span class="close">&times;</span>
	    <!--<p id="_id">Some text in the Modal..</p> -->
	    
	    <table class="table table-hover table-responsive">
	    	<tr>
	    		<th>ID</th>
	    		<td>
	    			<input type="text" readonly="readonly" name="id" id="_id">
	    		</td>
	    	</tr>
	    	<tr>
	    		<th>내용</th>
	    		<td>
	    			<textarea rows="20" cols="40" name="content" id="_content"></textarea>
	    		</td>
	    	</tr>
	    	<tr>
	    		<td colspan="2" style="text-align: right;">
	    			<button type="button" id="messageBtn" class="btn btn-default">보내기</button>
	    		</td>
	    	</tr>
	    </table>
	  </div>
	</div>
</form>

<script type="text/javascript">

$("#messageBtn").click(function () {
	
	//$("#messageform").attr({"action":"", "method":"post"}).submit();
	if($("#_content").val().trim() == ""){
		alert("메세지 내용을 채워주세요");
	}else{
		$.ajax({
			url:"messagesend.do",
			type:"get",
			data:"id=" + $("#_id").val() + "&message=" + $("#_content").val().trim(),
			success:function(data){
				//alert("success");		
				alert(data);
			},
			error:function(req, status, error){
				alert("error");		
			}
		});
		
		modal.style.display = "none";
		
	}
	
});

//Get the modal
var modal = document.getElementById("myModal");

// Get the button that opens the modal
//var btn = document.getElementById("myBtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 

function message(id) {
	
	//$("#_id").text(id);
	$("#_id").val(id);
	//document.getElementById("_id").innerHTML = id;
	modal.style.display = "block";
}
/* 
btn.onclick = function() {
	modal.style.display = "block";
}
 */
// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}

</script>

