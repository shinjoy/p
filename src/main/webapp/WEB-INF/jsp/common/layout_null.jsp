<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
    <tiles:insertAttribute name="header"/>
</head>
<body>
	<div class="modalWrap2 popup_outline">
    <tiles:insertAttribute name="content"/>
    </div>
</body>
<tiles:insertAttribute name="authStyle"/>
</html>