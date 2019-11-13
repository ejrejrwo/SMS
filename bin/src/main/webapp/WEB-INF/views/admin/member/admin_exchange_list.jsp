<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style type="text/css">
th {
	text-align: center;
}
.notice_list_tr:hover {
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="card-body">
		<div class="table-responsive">
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
				<div class="row">
					<div class="col-sm-12 col-md-6">
						<div class="dataTables_length" id="dataTable_length">
							<label> <c:choose>
									<c:when test="${empty search.begin }">
										<input type="text" id="_datepickTo" placeholder="YYYY-MM-DD"
											readonly="readonly">
									</c:when>
									<c:otherwise>
										<input type="text" id="_datepickTo" value="${search.begin }"
											readonly="readonly">
									</c:otherwise>
								</c:choose> ~ <c:choose>
									<c:when test="${empty search.end }">
										<input type="text" id="_datepickFrom" placeholder="YYYY-MM-DD"
											readonly="readonly">
									</c:when>
									<c:otherwise>
										<input type="text" id="_datepickFrom" value="${search.end }"
											readonly="readonly">
									</c:otherwise>
								</c:choose>
								
							</label>
						</div>
					</div>
					<div class="col-sm-12 col-md-6">
						<div id="dataTable_filter" class="dataTables_filter">
							<label> <select id="_selectBox">
									<c:choose>
										<c:when
											test="${empty search.category or search.category =='선택' }">
											<option selected="selected">선택</option>
											<option value="ID">아이디</option>
											<option value="BANK">은행</option>
											<option value="BANK_NUMBER">계좌번호</option>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${search.category eq 'ID' }">
													<option>선택</option>
													<option value="ID" selected="selected">아이디</option>
													<option value="BANK">은행</option>
													<option value="BANK_NUMBER">계좌번호</option>
												</c:when>
												<c:when test="${search.category eq 'BANK' }">
													<option>선택</option>
													<option value="ID">아이디</option>
													<option value="BANK" selected="selected">은행</option>
													<option value="BANK_NUMBER">계좌번호</option>
												</c:when>
												<c:when test="${search.category eq 'BANK_NUMBER' }">
													<option>선택</option>
													<option value="ID">아이디</option>
													<option value="BANK" selected="selected">은행</option>
													<option value="BANK_NUMBER" selected="selected">계좌번호</option>
												</c:when>
											</c:choose>
										</c:otherwise>
									</c:choose>
							</select> <c:choose>
									<c:when test="${empty search.searchText }">
										<input type="text" placeholder="검색어" id="_textbar">
									</c:when>
									<c:otherwise>
										<input type="text" value="${search.searchText }" id="_textbar">
									</c:otherwise>
								</c:choose> <img alt="" src="/image/magnifier.png" id="_findBtn">
							</label>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<table class="table table-bordered dataTable table-hover"
							id="dataTable" width="100%" cellspacing="0" role="grid"
							aria-describedby="dataTable_info" style="width: 100%;">
							<colgroup>
								<col width="5%">
								<col width="15%">
								<col width="10%">
								<col width="15%">
								<col width="10%">
								<col width="17.5%">
								<col width="17.5%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th>아이디</th>
									<th>은행</th>
									<th>계좌번호</th>
									<th>환전 금액</th>
									<th>요청일</th>
									<th>환전일</th>
									<th>환전 여부</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty list }">
										<!-- 작성 게시글이 없을경우 -->
										<tr>
											<th colspan="8">
												<h1>환전신청 내역이 없습니다.</h1>
											</th>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="i" items="${list }" varStatus="vs">
											<tr class="notice_list_tr" seq="${i.seq }">
												<th>${totalCount - ((pDto.curPage-1)*10+(vs.count-1)) }</th>
												<th>${i.id }</th>
												<th>${i.bank }</th>
												<th>${i.bank_number }</th>
												<th>${i.exchange_money}</th>
												<th>20${fn:substring(i.exdate,0,2) }-${fn:substring(i.exdate,3,5) }-${fn:substring(i.exdate,6,8) }</th>
												<th>${fn:substring(i.sdate,0,10) }</th>
												<th>
												<c:choose>
													<c:when test="${i.ex_check == '1' }">
													<font>환전 완료</font>
													</c:when>
													<c:when test="${i.ex_check == '0' }">
													<font style="color: red">환전 대기중</font>
													</c:when>													
												</c:choose>
												</th>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
				<div class="row" style="margin-top: 2%">
					<div class="col-sm-12 col-md-5">
						<c:choose>
							<c:when test="${empty search.sort }">
							<button class="btn btn-primary sortP" value="low_price">낮은 금액순</button>&nbsp;<button class="btn btn-primary sortP" value="high_price">높은 금액순</button>
							</c:when>
							<c:when test="${search.sort == 'low_price'}">
							<button class="btn btn-primary sortP" value="low_price" disabled="disabled">낮은 금액순</button>&nbsp;<button class="btn btn-primary sortP" value="high_price">높은 금액순</button>
							</c:when>
							<c:when test="${search.sort == 'high_price'}">
							<button class="btn btn-primary sortP" value="low_price">낮은 금액순</button>&nbsp;<button class="btn btn-primary sortP" value="high_price" disabled="disabled">높은 금액순</button>
							</c:when>																					
						</c:choose>
						<select style="height: 40px;" id="ex_checkSelect">
						<c:choose>
							<c:when test="${empty search.ex_check }">
							<option selected="selected" value="">환전여부</option>
							<option value="1">환전O</option>
							<option value="0">환전X</option>
							</c:when>
							<c:when test="${search.ex_check=='0' }">
							<option value="">환전여부</option>
							<option value="1">환전O</option>
							<option value="0" selected="selected">환전X</option>
							</c:when>
							<c:when test="${empty search.ex_check=='1' }">
							<option value="">환전여부</option>
							<option value="1" selected="selected">환전O</option>
							<option value="0">환전X</option>
							</c:when>														
						</c:choose>
						</select>						
					</div>
					<div class="col-sm-12 col-md-7">
						<div class="dataTables_paginate paging_simple_numbers"
							id="dataTable_paginate">
							<ul class="pagination">
								<c:if test="${pDto.curPage>10 }">
									<li class="paginate_button page-item " id="dataTable_previous">
										<a href="#" aria-controls="dataTable" tabindex="0"
										class="page-link pagelist" page="1"><img alt=""
											src="image/double-left-chevron.png"></a>
									</li>
									<li class="paginate_button page-item " id="dataTable_previous">
										<a href="#" aria-controls="dataTable" tabindex="0"
										class="page-link pagelist" page="${pDto.firstPage-1 }"><img
											alt="" src="image/left-arrow.png"></a>
									</li>
								</c:if>
								<c:forEach var="i" begin="${pDto.firstPage }"
									end="${pDto.lastPage }">
									<c:choose>
										<c:when test="${i eq pDto.curPage }">
											<li class="paginate_button page-item active"><div
													class="page-link">${i }</div></li>
										</c:when>
										<c:otherwise>
											<li class="paginate_button page-item "><a href="#none"
												aria-controls="dataTable" tabindex="0"
												class="page-link pagelist" page="${i }">${i }</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if
									test="${pDto.totalPage>10 and pDto.totalPage ne pDto.lastPage }">
									<li class="paginate_button page-item " id="dataTable_previous">
										<a href="#none" aria-controls="dataTable" tabindex="0"
										class="page-link pagelist" page="${pDto.lastPage+1 }"><img
											alt="" src="image/right-arrow.png"></a>
									</li>
									<li class="paginate_button page-item " id="dataTable_previous">
										<a href="#none" aria-controls="dataTable" tabindex="0"
										class="page-link pagelist" page="${pDto.totalPage }"><img
											alt="" src="image/double-angle-pointing-to-right.png"></a>
									</li>
									<%-- &nbsp;&nbsp;&nbsp;<a href="#" class="pagelist" page="${pDto.lastPage+1 }">></a>&nbsp;&nbsp;&nbsp;<a href="#" class="pagelist" page="${pDto.totalPage }">>></a> --%>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<form action="#" id="_frmForm">
	<input type="hidden" name="page" value="1" id="_curPage"><input type="hidden" name="begin"><input type="hidden" name="end"><input type="hidden" name="category"><input type="hidden" name="searchText">
	<input type="hidden" name="sort" value="${search.sort }"><input type="hidden" value="${search.ex_check }" name="ex_check">
</form>


	<script src="/admin-js/admin-exchangeList.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</body>
</html>