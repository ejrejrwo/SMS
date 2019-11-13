<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


<meta charset="UTF-8">
<title>RANKING</title>
</head>
<body>
<!-- 시큐리티 -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<div class="container" style="width: 1360px;">
<div id="_top">
	RANKING
</div>
<!-- 
	<div style="width: 250px; height: auto; float: left; margin-right: 15px;">
		<iframe src="MMRRankList1.do" style="border:0; display:block; width:250px; height: 100vh"></iframe>
	</div>
	
	<div style="width: 250px; height: auto; float: left; margin-right: 15px;">
		<iframe src="MMRRankList2.do" style="border:0; display:block; width:250px; height: 100vh"></iframe>
	</div>
	
	<div style="width: 250px; height: auto; float: left; margin-right: 15px;">
		<iframe src="MMRRankList3.do" style="border:0; display:block; width:250px; height: 100vh"></iframe>
	</div>
	
	<div style="width: 250px; height: auto; float: left; margin-right: 15px;">
		<iframe src="MMRRankList4.do" style="border:0; display:block; width:250px; height: 100vh"></iframe>
	</div>
	
	<div style="width: 250px; height: auto; float: left; margin-right: 15px;">
		<iframe src="MMRRankList5.do" style="border:0; display:block; width:250px; height: 100vh"></iframe>
	</div>
	  -->
	 
	<div style="width: 250px; height: auto; float: left; margin-right: 15px;">
		<iframe src="MMRRankList1.do" width="250px;" height="670px;" style="border: 0"></iframe>
	</div> 
	 
	<div style="width: 250px; height: auto; float: left; margin-right: 15px;">
		<iframe src="MMRRankList2.do" width="250px;" height="670px;" style="border: 0"></iframe>
	</div>
	
	<div style="width: 250px; height: auto; float: left; margin-right: 15px;">
		<iframe src="MMRRankList3.do" width="250px;" height="670px;" style="border: 0"></iframe>
	</div>
	
	<div style="width: 250px; height: auto; float: left; margin-right: 15px;">	
		<iframe src="MMRRankList4.do" width="250px;" height="670px;" style="border: 0"></iframe>
	</div>
	
	<div style="width: 250px; height: auto; float: left;">
		<iframe src="MMRRankList5.do" width="250px;" height="670px;" style="border: 0"></iframe>
	</div>


</div>

<script type="text/javascript">
$(document).ready(function(){
	$("#menu5").css("background-color","#e60013");
	
	
});
</script>

</body>
</html>