<%@page import="com.boot.finalpro.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>


<style type="text/css">
.content-table{
	width: 1200px;
}

td{
	padding: 10px;
}

.info{
	background-color: #fff;
	border: 1px solid #c3c3c3;
	
}
th{
	text-align: center;
}

.book_time{
	padding: 20px 0 20px;
	text-align: left;
}

.label{
    padding: 5px 5px;
    text-align: center;
    border: 1px solid #c8e1af;
    background-color: #428bca;
/*     color: #fff; */
	cursor: pointer;
	font-size: 16px;
	font-weight: 100;
	padding: 8px;
}

h3{
	color: black;
    font-size: 35px;
    text-align: center;
    padding-bottom: 50px;
    font-weight: 400;
}

.price{	
    height: 25px;
    background: none;
    border: 0;
    line-height: 25px;
    color: #000;
    font-family: tahoma,geneva,sans-serif;
    font-size: 14px;
    text-align: right;
    outline: none;   
}


</style>

</head>
<body>

<div id="_top">
	경기매칭신청
</div>

<div class="container" style="width: 1200px">

<form id="frmGame">
<!-- 시큐리티 -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<table class="content-table">
<col width="450"><col width="450"><col width="300">

<tr>	
	<td valign="top" style="background-color: #fafbfa; border: 1px solid #c3c3c3;">	
		<div class="form-group">
			<select id="stadium1" name="stadium1" style="width: 120px; float: left;" class="form-control">
				<option value="default">구장선택</option>
				<option value="잠실">잠실</option>
				<option value="한밭">한밭</option>
				<option value="부산">부산</option>
				<option value="광주">광주</option>	
				<option value="강릉">강릉</option>				
			</select>
			<select id="stadium2" name="stadium2" style="width: 200px; float: left;" class="form-control">
				<option value="default">경기장선택</option>	
				<option value="축구">축구장</option>
				<option value="야구">야구장</option>
				<option value="농구">농구장</option>
				<option value="탁구">탁구장</option>
				<option value="배드민턴">배드민턴</option>
			</select>
		</div>
		
		<br><br>
		
		<div style="width: 400px; height: auto;">							
			<table border="1" class="info">
			<col width="100"><col width="300">
				<tr>
					<td colspan="2">
						<h2>사용료</h2>												
					</td>
				</tr>
				<tr>
					<th style="padding: 10px;">경기장</th>
					<th style="padding: 10px;">금액</th>							
				</tr>
				<tr>
					<th>야구장</th>
					<td>100,000원</td>
				</tr>
				<tr>
					<th>축구장</th>
					<td>100,000원</td>
				</tr>
				<tr>
					<th>농구장</th>
					<td>50,000원</td>
				</tr>
				<tr>
					<th>탁구장</th>
					<td>10,000원</td>
				</tr>
				<tr>
					<th>배드민턴장</th>
					<td>10,000원</td>	
				</tr>
				<tr>
					<th>이용수칙</th>
					<td style="text-align: left;">
					1. 시간은 3시간 단위,&nbsp;&nbsp;모든 구장 동일금액<br>&nbsp;&nbsp; ※ 조명사용은 별도 부과<br>
					2. 등급별 차등 금액 적용<br>
					3. 취사 및 과도한 음주행위 금지<br>
					4. 사용중 파손(고장)시에는 사용자 부담으로 보수 및 원상회복해야 함<br>
					</td>
				</tr>
			</table>
	</div>
	</td>
	
	<td style="border: 1px solid #c3c3c3; background-color: #fafbfa;">		
		<div style="width: 450px; height: auto; ">
			<jsp:include page="calendar.jsp"/>
		</div> 
				
 		<div id="book_time" style="text-align: left; border-top: 1px solid #c3c3c3; border-bottom: 1px solid #c3c3c3; padding: 10px 10px; background-color: #fff;">	
			<font style="font-size: 16px; font-weight: 600; padding-right: 15px;">날짜</font> 
			<input type="text" id="selectDate" name="gday" style="border: none;" placeholder="날짜를 선택해 주세요" readonly="readonly">	
		</div>
		
		<div class="book_time">
			<%
			for(int i = 6; i < 19; i = i + 3){
				%>
				<input type="checkbox" id="check<%=i%>" name="book_time" value="<%=DateUtil.two(i+"") %>" style="display: none" onclick="seltime(<%=i%>)">
				<label for="check<%=i%>" id="checklabel<%=i %>" class="label">
					<%=DateUtil.two(i+"")%>시 ~<%=DateUtil.two((i+3) +"")%>시
				</label>&nbsp;
				<%
				if(i == 12){
					%>
					<br><br>
					<%
				}
			}
			%>			
		</div> 			
	</td>	
	
	<td rowspan="3" style="background-color: #fafbfa; border: 1px solid #c3c3c3; text-align: left;" valign="top">						
			
			<div style="padding-top: 10px;"><br>
				경기장금액 <input type="text" id="pay_price" class="price" value="0" readonly="readonly" style="width: 60%;">&nbsp;원<br><br>
						
				보유머니 <input type="text" id="now_money" name="now_money" class="price" value="${mem.now_money }" readonly="readonly" style="width: 65%;">&nbsp;원<br>										
				보유포인트<input type="text" id="now_point" name="now_point" class="price" value="${mem.now_point }" readonly="readonly" style="width: 50%;">&nbsp;포인트<br>
				사용포인트<input type="text" id="pay_point" name="pay_point" class="price" value="0" onclick="pay()" style="border-bottom: 1px solid #999; width: 50%;">&nbsp;포인트<br><br>												
			</div>
			
			<div style="padding-top: 20px; border-bottom: 1px solid #e9e9e9; border-top: 1px solid #e9e9e9;">
				결제금액<input type="text" id="price" name="price" class="price" value="0" style="font-size: 26px; width: 65%;" readonly="readonly">&nbsp;원<br><br>
			</div>	
			
		<div style="margin-top: 950px; text-align: center;">
			<button type="button" id="gBtn" class="btn btn-default" style="background-color: #042e6f; color: #fff; margin-bottom: 50px;">게임매칭신청</button> 
		</div>			
	</td> 				
</tr>

<tr>
	<td colspan="2" style="border: 1px solid #c3c3c3;">	
		<select id="gtime" name="gtime" style="width: 130px; float: left;" class="form-control">
			<option>시작시간</option>		
			<%			
			for(int i = 6;i < 21; i++){
				%>				
				<option><%=DateUtil.two(i+"") %>:00</option>
				<option><%=DateUtil.two(i+"") %>:30</option>		
				<%
			}
		%>			
		</select>
						
		<input type="text" id="title" name="title" class="form-control" style="float: left; width: 500px" placeholder="제목을 입력해주세요">
		<input type="hidden" name="name_team1" size="15" value="${mem.team_name }" readonly="readonly">
		<input type="hidden" name="id" value="${mem.id }">		
	</td>	
</tr>

<tr>
	<td colspan="2" style="background-color: #fafbfa; border: 1px solid #c3c3c3;">
		<textarea rows="8" cols="50" id="content" name="content"></textarea>	
	</td>
</tr>

</table>	
</form>


</div>

<script type="text/javascript">
$(".book_time").hide();

$(".form-group").click(function () {
	$(".book_time").hide();
});

$(function(){
    CKEDITOR.replace( 'content', {//해당 이름으로 된 textarea에 에디터를 적용
        width:'100%',
        height:'400px',
        filebrowserImageUploadUrl: '${path }gameupload.do?${_csrf.parameterName}=${_csrf.token}',       			
    });
    
    CKEDITOR.editorConfig = function( config ) {
        config.removePlugins = 'easyimage, cloudservices';         
        config.language = 'ko';
     };
     
});

$(document).ready(function () {
	$("#menu1").css("background-color","#e60013");
		
	$("#pay_point").change(function () {
		var pay_price = $("#pay_price").val();
		$("#price").val(pay_price);
		
		var price = $("#price").val();
		var pay_point = $("#pay_point").val();
		
		var paycheck = pay_price - pay_point;
//		alert(paycheck);
		if(paycheck < 0){
			alert("결제금액 이상 포인트를 사용할 수 없습니다");
			$("#pay_point").val(pay_price);
			$("#price").val(0);
			return;
		}
		
		var now_point = $("#now_point").val();	
		if(parseInt(now_point) < parseInt(pay_point)){
			alert("보유 포인트 이상은 사용 불가능합니다 ");
			var pay_point = $("#pay_point").val("");
			return;
		}
			
		var totalprice = price - pay_point;	
	//	alert(pay_price);
		$("#price").val(totalprice);			
	});	
			

	// 경기등록 버튼
	$("#gBtn").click(function() {
				
		if($("#stadium1").val()=='default'){
			alert("구장을 선택해 주세요");
			return;
		} 
 		if($("#stadium2").val()=='default'){
			alert("경기장을 선택해 주세요");
			return;
		} 
 		if($("#selectDate").val()==""){
			alert("날짜를 선택해 주세요");
			return;
		} 
 		if($("#gtime").val()=='시작시간'){
			alert("시작시간을 선택해 주세요");
			return;
		} 
 		if($("#title").val()==""){
			alert("제목을 작성해주세요");
			return;
		} 
 		if($("input:checkbox[name=book_time]").is(":checked") == false){
 			alert("예약시간을 선택해 주세요");
 			return;
 		}
 		if(CKEDITOR.instances.content.getData()==""){
 	    	 window.alert("내용을 입력해주세요");
 	    	 CKEDITOR.instances.content.focus();
 	    	 return false;
 	     }
 		
 		// 경기장 예약 시간과 게임 시작시간을 비교한다
 		var booktime = "";
		$("input:checkbox[name=book_time]:checked").each(function () {
			booktime += "," + ($(this).val());			
		})
//		alert(booktime);
		
		var splitTime = booktime.split(",");
		var slength = splitTime.length;
		var stime;
		var etime;
		for(var i=0; i<slength; i++){			
			stime = splitTime[1];
			etime = parseInt(splitTime[slength-1]) + 3;
		}
		var gtime = $("#gtime").val().substring(0,2);
//		alert(etime);
		
		if(!(gtime>=stime && gtime<=(etime+3))){
			alert("게임시작 시간과 경기장 예약시간을 확인해주세요");
			return;
		}
 		 		
		var price = $("#price").val();
		var now_money = $("#now_money").val();
		if(parseInt(now_money) < parseInt(price)){
			alert("보유 머니가 부족합니다. 충전해주세요");
			return;
		}
				 										
		$("#frmGame").attr("action", "gamemakeAf.do").submit();				
	});
	
});


// 경기장 이름과 시간을 통해 가격을 받아온다
// 구장선택 전 시간선택 시 오류메세지
function seltime(i) {			
	if($("#check" + i).prop("checked") == true){
		$("#checklabel" + i).css("background-color","#042e6f");
	 	$("#checklabel" + i).css("color","#fff"); 
	}else{
		$("#checklabel" + i).css("background-color","#428bca");
		/* $("#checklabel" + i).css("color","#fff");  */
	}
	
	var checked = $("input:checkbox[name=book_time]:checked").length;
//	alert(checked);
	var stadium = $("#stadium1").val() + $("#stadium2").val() + "장";
//	alert(stadium);
	
	$.ajax({
		url:'getprice.do',
		async:true,
		data: 'name_stadium=' + stadium,
		success:function(price){
//			alert(price);
			$("#pay_price").val(price*checked);	
			$("#price").val(price*checked);	
		},
		error:function(){
			alert("경기장을 선택해주세요");
			$("#checklabel" + i).css("background-color","#428bca");
			$("input:checkbox[name=book_time]").prop("checked", false);	
		}				
	})		
}


// 달력 날짜 선택 시 예약시간 가져오기
function calselect(y, m, d, w) {
	$(".book_time").show();
	// 전체 배경색 원래대로 돌리고, 선택된 날짜 배경색 바꿔준다 
	for(var i = 0; i < 32; i++){
		$(".day" + i).css("background-color","#fff");
	}
	$(".day" + parseInt(d)).css("background-color","#d5d5d5");
	
	// 체크박스 전체 해제, 가격 칸 비워주기
	$("input[type=checkbox]").prop("checked",false);
	$("#pay_price").val("0");	
	$("#price").val("0");	
	
	// 체크박스 시간 원상복구
	for (var j = 6; j < 19; j = j + 3) {
		$("#checklabel" + j).css("background-color","#428bca");
		$("#checklabel" + j).css("color","#fff");
		$("#checklabel" + j).css("cursor","pointer");
		$("#check" + j).prop("disabled", false);
	}	 
				
//	alert(y + " " + m  + " " + d + " " + w);
	if(w == 1)w = '일';
	else if(w == 2)w = '월';
	else if(w == 3)w = '화';
	else if(w == 4)w = '수';
	else if(w == 5)w = '목';
	else if(w == 6)w = '금';
	else if(w == 0)w = '토';
	
	var day = y + "-" + m  + "-" + d;
	$("#selectDate").val(day + " " + w);	
	
	var name_stadium = $("#stadium1").val() + $("#stadium2").val() + "장";		
	var bdate = $("#selectDate").val();
	
	$.ajax({		
		url:'booktime.do',
		async:true,
		data: 'bdate=' + bdate + '&name_stadium=' + name_stadium,
		success:function(data){					
//		alert(data[0]);			
			for (var i = 0; i < data.length; i++) {					
				for (var j = 6; j < 19; j = j + 3) {
					if(data[i] == $("#check" + j).val()){
//						alert(data[i]);
//						alert($("#check" + j).val());
						$("#checklabel" + j).css("background-color","white");
						$("#checklabel" + j).css("color","black");
						$("#checklabel" + j).css("cursor","default");
						$("#check" + j).prop("disabled", true);
						
					} 						
				}	 
			}																				
		},
		error:function(){
			alert("error");
		}						
	})
	
}


</script>



</body>
</html>

