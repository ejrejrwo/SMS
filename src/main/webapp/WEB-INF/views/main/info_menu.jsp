<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	width: 25%;
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

<div class="menu_table" style="background-color: #042e6f">

	<div class="img" style="height: 250px">
 		<!-- <img alt="" src="./image/stadium_jamsil.jpg" style="height: 250px; width: 1200px"> -->
		<div>
			<p>사업소개</p>
		</div>	
	</div>
		
	<div id="game_menu" class="menu">
			
		<a href="common1.do" id="menu1">인사말</a>	
		
		<a href="phoneguide.do" id="menu2">문의전화</a>
		
		<a href="../common/notice.do?page=1" id="menu3">공지사항</a>	
		
		<a href="stadium.do?num=1" id="menu4">경기장소개</a>
	
	</div>
		
</div>

<script type="text/javascript">


</script>





