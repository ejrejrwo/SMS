<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 시큐리티 -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<div style="margin: auto; padding-top: 50px; border: 3px solid #ddd;">
<div style="width: 250px; height: auto; float: left; margin-right: 15px;">
	<iframe src="MMRRankList6.do" width="250px;" height="800px;" style="border: 0"></iframe>
</div>

<div style="width: 250px; height: auto; float: left; margin-right: 15px;">
	<iframe src="MMRRankList2.do" width="250px;" height="800px;" style="border: 0"></iframe>
</div>

<div style="width: 250px; height: auto; float: left; margin-right: 15px;">
	<iframe src="MMRRankList3.do" width="250px;" height="800px;" style="border: 0"></iframe>
</div>

<div style="width: 250px; height: auto; float: left; margin-right: 15px;">	
	<iframe src="MMRRankList4.do" width="250px;" height="800px;" style="border: 0"></iframe>
</div>

<div style="width: 250px; height: auto; float: left; margin-right: 15px;">
	<iframe src="MMRRankList5.do" width="250px;" height="800px;" style="border: 0"></iframe>
</div>

<div style="width: 250px; height: auto; float: left;">
	<iframe src="MMRRankList1.do" width="250px;" height="800px;" style="border: 0"></iframe>
</div>
<%-- 
<div style="width: 260px; height: auto; float: left; margin-left: 10px;">
	<jsp:include page="MMRRankList1.jsp"/>
</div> 
 --%>
</div>
