<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Main</title>
<link href="<c:url value='/css/content.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/management.css'/>" rel="stylesheet" type="text/css"/>
<script type="text/JavaScript" src="<c:url value='/js/jquery.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/process.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/part/keyPointChk.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/calendar_beans_v2.0.js'/>" ></script>
<script>
 $(document).ready(function(){
	 $('.t_skinR00:eq(1)').parent().css('padding-top','135px');
	 $(".t_skinR00 tbody tr:odd").css("background-color", "#F6F9FB");
	 $('.tabUnderBar').css('width','calc(100% - '+ parseInt(10 + 68*($('.1st').length)) +'px)');
 });

 function selectLevelCD(lv, snb, frmNm, tmp){
 	var DATA = {sNb:snb, importance:"0000"+lv, tmpNum1: tmp};
 	var url = "../work/saveImportance.do";
 	var fn = function(){
 		$("#"+frmNm).submit();
 	};
 	ajaxModule(DATA,url,fn);
 }
</script>
<style>tbody tr:hover{background-color: moccasin !important;}</style>
</head>
<body>
<div id="wrap">

	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>
	
	<%@include file="includeTab.jsp"%>
	<%@include file="../../includeJSP/Network.jsp" %>
</div>
</body>
</html>