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
											<option value="NAME">이름</option>
											<option value="ADDRESS">주소</option>
											<option value="PHONE">전화번호</option>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${search.category eq 'NAME' }">
													<option>선택</option>
													<option value="NAME" selected="selected">이름</option>
													<option value="ADDRESS">주소</option>
													<option value="PHONE">전화번호</option>
												</c:when>
												<c:when test="${search.category eq 'ADDRESS' }">
													<option>선택</option>
													<option value="NAME">이름</option>
													<option value="ADDRESS" selected="selected">주소</option>
													<option value="PHONE">전화번호</option>
												</c:when>
												<c:when test="${search.category eq 'PHONE' }">
													<option>선택</option>
													<option value="NAME">이름</option>
													<option value="ADDRESS">주소</option>
													<option value="PHONE" selected="selected">전화번호</option>
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
								<col width="5%">
								<col width="10%">
								<col width="10%">
								<col width="50%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" id="_checkAll"
										style="height: 15px; width: 15px; margin-bottom: 5px;"></th>
									<th>번호</th>
									<th>아이디</th>
									<th>이름</th>
									<th>주소</th>
									<th>전화번호</th>
									<th>가입일</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty list }">
										<!-- 작성 게시글이 없을경우 -->
										<tr>
											<th colspan="7">
												<h1>등록된 회원이 없습니다.</h1>
											</th>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="i" items="${list }" varStatus="vs">
											<tr class="notice_list_tr" id="${i.id }">
												<th onclick="event.cancelBubble=true" class="checkBoxs"><input type="checkbox"
													style="height: 15px; width: 15px; margin-top: 5px;"
													class="delCheck" ids="${i.id }"></th>
												<th>${totalCount - ((pDto.curPage-1)*10+(vs.count-1)) }</th>
												<th>${i.id }</th>
												<th>${i.name }</th>
												<th style="text-align: left;">
												<c:choose>
													<c:when test="${fn:length(i.address) gt 50 }">
														${fn:substring(i.address,0,49) }...
													</c:when>
													<c:otherwise>
														${i.address }
													</c:otherwise>
												</c:choose>
												</th>
												<th>${i.phone}</th>
												<th>${fn:substring(i.regidate,0,10) }</th>
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
						<button class="btn btn-danger" id="_delBtn">삭제하기</button>
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
		<input type="hidden" name="page" value="1" id="_curPage"><input
			type="hidden" name="begin"><input type="hidden" name="end"><input
			type="hidden" name="category"><input type="hidden"
			name="searchText">
	</form>
	<script src="/admin-js/admin-memberList.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</body>
</html>