<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
/* 
.ta_1{
	margin-left: auto;
	margin-right: auto;
}
 */

#leaguetable_user2{
	margin-left: auto;
	margin-right: auto;
	width: 80%;
	height: 700px;
	margin-top: 10px;
	border-collapse: separate;
	border-spacing: inherit;
}

#leaguetable_user2 th, #leaguetable_user2 td{
	padding: 1px;
}

.leagueline{
	border-left: 1px solid;
	border-right: 1px solid;
	border-top: 1px solid;
}

.leagueline2{
	border-right: 1px solid;
}

.form-control{
	width: 50%;
	margin-left: auto;
	margin-right: auto;
}

.hasDatepicker{cursor: pointer;}



.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 30px; /* Location of the box */
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
  width: 1200px;
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
#modaltable, #modaltable th, #modaltable td{
	text-align: center;
}

</style>

<form id="addleagueFrm">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>


	<table id="leaguetable_user2">
		<colgroup>
			<col width="300"><col width="300"><col width="300"><col width="300"><col width="300">
			<col width="300"><col width="300"><col width="300"><col width="300"><col width="300">
			<col width="300"><col width="300"><col width="300"><col width="300"><col width="300">
			<col width="300"><col width="300"><col width="300"><col width="300"><col width="300">
			<col width="300"><col width="300"><col width="300"><col width="300"><col width="300">
			<col width="300"><col width="300"><col width="300"><col width="300"><col width="300">
		</colgroup>
		<tr>
			<td colspan="5">
			</td>
			<td colspan="10">
				<select name="category" class="form-control">
					<option value="축구">축구</option>
					<option value="농구">농구</option>
					<option value="야구">야구</option>
					<option value="배드민턴">배드민턴</option>
					<option value="탁구">탁구</option>
				</select>
			</td>
			<td colspan="3">
				<button type="button" id="modalbtn" class="btn btn-default">설명쓰기</button>
			</td>
			<td colspan="3">
				<button type="button" id="fianl_btn" class="btn btn-default">결정</button>
			</td>
			<td colspan="9">
			</td>
		</tr>
		<tr>
			<td colspan="15" class="leagueline2"></td>
			<td colspan="15"></td>
		</tr>
		<tr>
			<td colspan="7"></td>
			<td colspan="16" class="leagueline">
			
				<input type="text" id="datepicker3" placeholder="날짜" class="form-control" name="date3" autocomplete="off">
				
				<select class="form-control" name="area3">
					<option value="잠실">잠실</option>
					<option value="대전">대전</option>
					<option value="부산">부산</option>
					<option value="광주">광주</option>	
					<option value="강릉">강릉</option>	
				</select>
				<select class="form-control" name="stadium3">	
					<option value="축구장">축구장</option>
					<option value="야구장">야구장</option>
					<option value="농구장">농구장</option>
					<option value="탁구장">탁구장</option>
					<option value="배드민턴장">매트민턴</option>
				</select>
				
			</td>
			<td colspan="7"></td>
		</tr>
		<tr>
			<td colspan="6"></td>
			<td colspan="2" class="leaguebox">
				
			</td>
			<td colspan="14">
				
			</td>
			<td colspan="2" class="leaguebox">
				
			</td>
			<td colspan="6"></td>
		</tr>
		<tr>
			<td colspan="7" class="leagueline2"></td>
			<td colspan="16" class="leagueline2"></td>
			<td colspan="7"></td>
		</tr>
		<tr>
			<td colspan="3"></td>
			<td colspan="8" class="leagueline">
				
			</td>
			<td colspan="8">
			
				<input type="text" id="datepicker2" placeholder="날짜" class="form-control" name="date2" autocomplete="off">
				
				<select class="form-control" name="area2">
					<option value="잠실">잠실</option>
					<option value="대전">대전</option>
					<option value="부산">부산</option>
					<option value="광주">광주</option>	
					<option value="강릉">강릉</option>	
				</select>
				<select class="form-control" name="stadium2">
					<option value="축구장">축구장</option>
					<option value="야구장">야구장</option>
					<option value="농구장">농구장</option>
					<option value="탁구장">탁구장</option>
					<option value="배드민턴장">매트민턴</option>
				</select>
			
			
			</td>
			<td colspan="8" class="leagueline">
				
			</td>
			<td colspan="3"></td>
		</tr>
		<tr>
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				
			</td>
			<td colspan="6"></td>
			<td colspan="2" class="leaguebox">
				
			</td>
			<td colspan="6"></td>
			<td colspan="2" class="leaguebox">
				
			</td>
		 	<td colspan="6"></td>
			<td colspan="2" class="leaguebox">
				
			</td>
			<td colspan="2"></td>
		</tr>
		<tr>
			<td colspan="3" class="leagueline2"></td>
			<td colspan="8" class="leagueline2"></td>
			<td colspan="8" class="leagueline2"></td>
			<td colspan="8" class="leagueline2"></td>
			<td colspan="3"></td>
		</tr>
		<tr>
			<td></td>
			<td colspan="4" class="leagueline">
				
			</td>
			<td colspan="4"></td>
			<td colspan="4" class="leagueline">
				
			</td>
			<td colspan="4">
			
				<input type="text" id="datepicker1" placeholder="날짜" class="form-control" name="date1" autocomplete="off">
				
				<select class="form-control" name="area1">
					<option value="잠실">잠실</option>
					<option value="대전">대전</option>
					<option value="부산">부산</option>
					<option value="광주">광주</option>	
					<option value="강릉">강릉</option>	
				</select>
				<select class="form-control" name="stadium1">	
					<option value="축구장">축구장</option>
					<option value="야구장">야구장</option>
					<option value="농구장">농구장</option>
					<option value="탁구장">탁구장</option>
					<option value="배드민턴장">매트민턴</option>
				</select>
			
			</td>
			<td colspan="4" class="leagueline">
				
			</td>
			<td colspan="4"></td>
			<td colspan="4" class="leagueline">
				
			</td>
			<td></td>
		</tr>
		<tr>
			<td colspan="2" class="leaguebox">
				<select id="team1" class="" name="team1">
					<c:forEach items="${acceptlist }" var="v" varStatus="vs">
						<option value="${v.team_name }">${v.team_name }</option>
					</c:forEach>
				</select>
			</td>
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<select id="team2" class="" name="team2">
					<c:forEach items="${acceptlist }" var="v" varStatus="vs">
						<option value="${v.team_name }">${v.team_name }</option>
					</c:forEach>
				</select>
			</td>
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<select id="team3" class="" name="team3">
					<c:forEach items="${acceptlist }" var="v" varStatus="vs">
						<option value="${v.team_name }">${v.team_name }</option>
					</c:forEach>
				</select>
			</td>
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<select id="team4" class="" name="team4">
					<c:forEach items="${acceptlist }" var="v" varStatus="vs">
						<option value="${v.team_name }">${v.team_name }</option>
					</c:forEach>
				</select>
			</td>
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<select id="team5" class="" name="team5">
					<c:forEach items="${acceptlist }" var="v" varStatus="vs">
						<option value="${v.team_name }">${v.team_name }</option>
					</c:forEach>
				</select>
			</td>
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<select id="team6" class="" name="team6">
					<c:forEach items="${acceptlist }" var="v" varStatus="vs">
						<option value="${v.team_name }">${v.team_name }</option>
					</c:forEach>
				</select>
			</td>
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<select id="team7" class="" name="team7">
					<c:forEach items="${acceptlist }" var="v" varStatus="vs">
						<option value="${v.team_name }">${v.team_name }</option>
					</c:forEach>
				</select>
			</td>
			
			<td colspan="2"></td>
			<td colspan="2" class="leaguebox">
				<select id="team8" class="" name="team8">
					<c:forEach items="${acceptlist }" var="v" varStatus="vs">
						<option value="${v.team_name }">${v.team_name }</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		
	</table>

	<!-- The Modal -->
	<div id="myModal" class="modal">
	
	  <!-- Modal content -->
	  <div class="modal-content">
	     <span class="close">&times;</span>
	    <!--<p id="_id">Some text in the Modal..</p> -->
	    
	    <table id="modaltable">
	    	<tr>
	    		<td colspan="4">
	    			<button type="button" class="btn btn-default" id="modaltablebtn">완료</button>
	    		</td>
	    	</tr>
	    	<tr>
	    		<th>4강1라운드</th><th colspan="2">결승전</th><th>4강2라운드</th>
	    	</tr>
	    	<tr>
	    		<td>
	    			<input type="text" name="title5" id="_title5" placeholder="제목">
	    		</td>
	    		<td colspan="2">
	    			<input type="text" name="title7" id="_title7" placeholder="제목">
	    		</td>
	    		<td>
	    			<input type="text" name="title6" id="_title6" placeholder="제목">
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>
	    			<textarea rows="15" cols="30" name="content5" id="_content5" placeholder="내용"></textarea>
	    		</td>
	    		<td colspan="2">
	    			<textarea rows="15" cols="30" name="content7" id="_content7" placeholder="내용"></textarea>
	    		</td>
	    		<td>
	    			<textarea rows="15" cols="30" name="content6" id="_content6" placeholder="내용"></textarea>
	    		</td>
	    	</tr>
	    	
	    	<tr>
	    		<th>8강1라운드</th><th>8강2라운드</th><th>8강3라운드</th><th>8강4라운드</th>
	    	</tr>
	    	<tr>
	    		<td>
	    			<input type="text" name="title1" id="_title1" placeholder="제목">
	    		</td>
	    		<td>
	    			<input type="text" name="title2" id="_title2" placeholder="제목">
	    		</td>
	    		<td>
	    			<input type="text" name="title3" id="_title3" placeholder="제목">
	    		</td>
	    		<td>
	    			<input type="text" name="title4" id="_title4" placeholder="제목">
	    		</td>
	    	</tr>
	    	<tr>
	    		<td>
	    			<textarea rows="15" cols="30" name="content1" id="_content1" placeholder="내용"></textarea>
	    		</td>
	    		<td>
	    			<textarea rows="15" cols="30" name="content2" id="_content2" placeholder="내용"></textarea>
	    		</td>
	    		<td>
	    			<textarea rows="15" cols="30" name="content3" id="_content3" placeholder="내용"></textarea>
	    		</td>
	    		<td>
	    			<textarea rows="15" cols="30" name="content4" id="_content4" placeholder="내용"></textarea>
	    		</td>
	    	</tr>
	    	
	    </table>
	  </div>
	</div>

</form>
<script type="text/javascript">

//Get the modal
var modal = document.getElementById("myModal");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

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


$(document).ready(function () {
	
	$("#modalbtn").click(function () {
		modal.style.display = "block";
	});
	$("#modaltablebtn").click(function () {
		modal.style.display = "none";
	});
	
	
	
	$.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd' //Input Display Format 변경
        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시            
        ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
        ,minDate: "+1D" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        ,maxDate: "+3M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
    });
	
	$( "#datepicker1" ).datepicker();
	$( "#datepicker2" ).datepicker();
	$( "#datepicker3" ).datepicker();
	
	$("#fianl_btn").click(function () {
		//alert($("#team1").val());
		
		//alert($("#datepicker1").val());
		$.ajax({
			url:"leaguecheck.do",
			type:"get",
			/* data:"", */
			success:function(data){
						
				//alert(data);
				if(data == "있음"){
					alert("리그가 존재합니다 모든 리그가 종료되고 다시 만들어주세요");
					return;
				}
				
				for(i=1; i<8; i++){
					if( $("#_title"+i).val() == "" ){
						alert("설명 타이틀을 채워주세요");
						return;
					}
					if( $("#_content"+i).val() == "" ){
						alert("설명 내용을 채워주세요");
						return;
					}
					for(j=i+1; j<9; j++){
						if( $("#team"+i).val() == $("#team"+j).val() ){
							alert(i+"번팀과 " + j + "번팀이 같습니다");
							return;
							
						}
					}
				}
				
				for(i=1; i<4; i++){
					if( $("#datepicker"+i).val() == ""){
						if(i==1){
							alert("8강전 날짜가 비어있습니다.");
						}else if(i==2){
							alert("4강전 날짜가 비어있습니다.");
						}else if(i==3){
							alert("결승전 날짜가 비어있습니다.");
						}
						return;
					}
				}
				if( $("#datepicker1").val() >= $("#datepicker2").val() ){
					alert("8강전 날짜가 4강전 날짜보다 늦을수 없습니다.");
					return;
				}
				
				if( $("#datepicker2").val() >= $("#datepicker3").val() ){
					alert("4강전 날짜가 결승전 날짜보다 늦을수 없습니다.");
					return;
				}
				
				
				
				$("#addleagueFrm").attr({"action":"addleague.do", "method":"post"}).submit();
				
				
			},
			error:function(req, status, error){
				alert("error");		
			}
		});
		
		
		
		//alert("중복없음");
	});
});
</script>

