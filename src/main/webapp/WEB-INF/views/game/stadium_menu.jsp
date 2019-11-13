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

.stadium_menu{
	width: 1200px;
	height: 60px;
	background-color: #042e6f;	
	margin: 0 auto 50px auto;		
}

.stadium_menu a{
	width: 20%;
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

#_top{
	font-size: 40px;
}
#_top:after{
	content: "";
    display: block;
    width: 50px;
    border-bottom: 1px solid #bcbcbc;
    margin: 5px auto;
    margin-bottom: 50px;
}

</style>


</head>
<body>

<div class="menu_table" style="background-color: #042e6f">
	<div class="img" style="height: 250px">
 		<!-- <img alt="" src="./image/stadium_jamsil.jpg" style="height: 250px; width: 1200px"> -->
		<div>
			<p>경기장정보</p>
		</div>	
	</div>
	
	<div id="stadium_menu" class="stadium_menu">

		<a href="stadium.do?num=1" id="stadium_menu1">잠실경기장</a>	
		
		<a href="stadium.do?num=2" id="stadium_menu2">한밭경기장</a>	
		
		<a href="stadium.do?num=3" id="stadium_menu3">부산경기장</a>
		
		<a href="stadium.do?num=4" id="stadium_menu4">광주경기장</a>
		
		<a href="stadium.do?num=5" id="stadium_menu5">강릉경기장</a>
	
	</div>
	
</div>


</body>
</html>