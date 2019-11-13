<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="admin.do">
        <div class="sidebar-brand-icon">
          <i class="fas fa-medal"></i>
        </div>
        <div class="sidebar-brand-text mx-3">SMS Admin </div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item active">
        <a class="nav-link" href="../common/main.do">
          <i class="fas fa-fw fa-home"></i>
          <span>메인페이지</span></a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
        MEMBER
      </div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-fw fa-users-cog"></i>
          <span>회원관리</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Components</h6>
            <a class="collapse-item" href="admin_memberList.do?page=1">회원 리스트</a>
            <a class="collapse-item" href="admin_exchange_list.do?page=1">환전 신청</a>
          </div>
        </div>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
        NOTICE
      </div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-fw fa-exclamation-circle"></i>
          <span>공지사항</span>
        </a>
        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">COMPONENTS</h6>
            <a class="collapse-item" href="admin_noitceList.do?page=1">공지사항 리스트</a>
            <a class="collapse-item" href="admin_noticeWrite.do">공지사항 작성</a>
          </div>
        </div>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider">

      <!-- Heading -->
      <div class="sidebar-heading">
        MATCH
      </div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTeam" aria-expanded="true" aria-controls="collapseTeam">
          <i class="fas fa-fw fa-handshake"></i>
          <span>팀 관리</span>
        </a>
        <div id="collapseTeam" class="collapse" aria-labelledby="headingTeam" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">COMPONENTS</h6>
            <a class="collapse-item" href="admin_team.do">팀 리스트</a>
            <a class="collapse-item" href="adminMMRRankList.do">팀 랭킹</a>
            <a class="collapse-item" href="admin_bbs.do">팀 게시판</a>
          </div>
        </div>
      </li>
        
      
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseMatch" aria-expanded="true" aria-controls="collapseMatch">
          <i class="fas fa-fw fa-play"></i>
          <span>경기 관리</span>
        </a>
        <div id="collapseMatch" class="collapse" aria-labelledby="headingMatch" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">COMPONENTS</h6>
            <a class="collapse-item" href="admin_game_list.do?page=1">경기 일정</a>
            <a class="collapse-item" href="gameResultAdmin.do">경기 결과</a>
            <a class="collapse-item" href="admin_report.do">하이라이트</a>
          </div>
        </div>
      </li>      
      
      
      <!-- Divider -->
      <hr class="sidebar-divider">
      
      <!-- Heading -->
      <div class="sidebar-heading">
        LEAGUE
      </div>      
      
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLeague" aria-expanded="true" aria-controls="collapseLeague">
          <i class="fas fa-fw fa-trophy"></i>
          <span>리그 관리</span>
        </a>
        <div id="collapseLeague" class="collapse" aria-labelledby="headingLeague" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">COMPONENTS</h6>
            <a class="collapse-item" href="adminleaguepage1.do">리그참가권유</a>
            <a class="collapse-item" href="adminleaguepage2.do">리그만들기</a>
          </div>
        </div>
      </li>  
      
      

      
      <!-- Divider -->
      <hr class="sidebar-divider">
      
      <!-- Heading -->
      <div class="sidebar-heading">
        CHART
      </div>      
      
      <!-- Nav Item - Charts -->
            
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseChart" aria-expanded="true" aria-controls="collapseChart">
          <i class="fas fa-fw fa-chart-area"></i>
          <span>통계 차트</span>
        </a>
        <div id="collapseChart" class="collapse" aria-labelledby="headingChart" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">COMPONENTS</h6>
            <a class="collapse-item" href="admin_chart_money.do">소득 통계</a>
            <a class="collapse-item" href="admin_chart_category.do">종목 통계</a>
            <a class="collapse-item" href="#none" id="_stadium">경기장 통계</a>
          </div>
        </div>
      </li>        
      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
<script type="text/javascript">
$("#_stadium").click(function() {
	var dt = new Date();
	var month = dt.getMonth()+1;
	if(month<10) month = "0"+month;
	location.href = "admin_chart_stadiumCount.do?month="+month;
});
</script>  
</html>