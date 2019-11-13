<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.img{
	background: url(../image/stadium_jamsil.jpg) no-repeat center top;
	background-size: 100% 100%;
}

.menu{
	width: 1200px;
	height: 60px;
	background-color: #042e6f;	
	margin: 0 auto 50px auto;		
}

.menu a{
	width: 50%;
	text-decoration: none;
	
	display: block;
    color: #fff;
    font-size: 18px;
    text-align: center;
    line-height: 60px;
    border-right: 1px solid rgba(0, 0, 0, 0.3);
    float: left;
    margin: 0;		
}

.img p {
    color: #fff;
    font-size: 40px;
    padding-top: 100px;
    text-align: center;
    line-height: 1em;
    font-weight: 600;
}

</style>


</head>
<body>

<div class="menu_table" style="background-color: #042e6f">

	<div class="img" style="height: 250px">
 		<!-- <img alt="" src="./image/stadium_jamsil.jpg" style="height: 250px; width: 1200px"> -->
		<div>
			<p>토너먼트</p>
		</div>	
	</div>
		
	<div id="game_menu" class="menu">
			
		<a href="../common/userleagueapply.do" id="menu1">토너먼트 신청</a>	
		
		<a href="../common/userleaguepage.do" id="menu2">토너먼트 일정</a>
		
	</div>
		
</div>

<script type="text/javascript">


</script>


</body>
</html>




