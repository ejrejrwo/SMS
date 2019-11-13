<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style type="text/css">
/* The Modal (background) */
.id-modal {
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
.id-modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 17%;
}

/* The Close Button */
.id-close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.id-close:hover, .id-close:focus {
	color: #000;
	text-decoration: none;
	cursor: pointer;
}
table th{
	text-align: center;
}
table td {
	text-align: left;
}

</style>

<!-- 회원 정보 모달창 -->
<!-- The Modal -->
<div id="id-myModal" class="id-modal">

	<!-- Modal content -->
	<div class="id-modal-content">
		<div align="right">
			<span class="id-close">&times;</span>
		</div>
		<div class="form-group">
			<label for="Detail_Id_Info"><h4>${bbsdto.id }님의 회원 정보</h4></label>
			<table class="modalTable1"
				style="font-size: 14px; height: 100px; width: 96%">
				<colgroup>
					<col width="30%"><col width="70%">
				</colgroup>
				<tr>
					<th>키</th>
					<td><span id="dtoheight">${bbsdto.height }</span></td>
				</tr>
				<tr>
					<th>몸무게</th>
					<td><span id="dtoweight">${bbsdto.weight }</span></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><span id="dtoemail">${bbsdto.email }</span></td>
				</tr>
			</table>
		</div>
		<a onclick="_go_send_message()">쪽지보내기</a>
	</div>

</div>

<jsp:include page="BbssendMessage2.jsp"/>

<script type="text/javascript">

//alert("모달실행");

// 전역변수 설정 후 자동으로 게터와 세터 역활을 하게 됨.
function Info_id() {
//	alert("아이디 정보 클릭");
	id_modal.style.display = "block";
}
//Get the modal
var id_modal = document.getElementById("id-myModal");

// Get the button that opens the modal
var id_btn = document.getElementsByClassName("dropdown-item")[0];

// Get the <span> element that closes the modal
var idspan = document.getElementsByClassName("id-close")[0];

// When the user clicks on <span> (x), close the modal
idspan.onclick = function() {
	id_modal.style.display = "none";
}
</script>