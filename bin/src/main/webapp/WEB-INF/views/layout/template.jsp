<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>     

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:requestEncoding value="utf-8"/>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${InsertTitle }</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<tiles:insertAttribute name="header_import"/>

</head>
<body>

<div id="body_wrap">
	<div id="main_wrap">
		<tiles:insertAttribute name="top_inc" ignore="true"/>
	</div>

	<div id="middle_wrap">
		<div id="sidebar_wrap">
			<tiles:insertAttribute name="body_top"/>
		</div> 
		<div id="content_wrap">
			<tiles:insertAttribute name="body"/>			
		</div>		
	</div>
	
	<div id="footer_wrap">
		<tiles:insertAttribute name="footer"/>
	</div>
</div>

</body>
</html>
