<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>SESSION OUT</title>

<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>


<!-- ============== style css :S ============== -->
<link href="${pageContext.request.contextPath}/images/favicon.ico" rel="shortcut icon" type="image/x-icon">		<!-- icon -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jstree/style.min.css" />					<!-- jstree -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css">								<!-- jquery-ui -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/n_style.css"/>				<!-- design css -->

<!-- ============== style css :E ============== -->


<!--html5새로생성된 태그가 IE6~8에서 적용되게 하는 js파일-->
    <!--[if lt IE 9]>
            <script src="${pageContext.request.contextPath}/js/html5shiv.js" ></script>
    <![endif]-->

    <!--미디어쿼리가 IE6~8에서 적용되게 하는 js파일-->
    <!--[if lt IE 9]>
            <script src="${pageContext.request.contextPath}/js/respond.min.js" ></script>
    <![endif]-->

    <!-- Load jQuery Here -->
    <!--이유는 모르겠으나...익스8에서 깨지게 되어서 변경함 로컬에선 문제가 없는데...뭔가 꼬인듯합니다.-->
    <!--[if lt IE 7]>
            <script src="//ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js"></script>
            <script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
            <script src="//ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script>
    <![endif]-->



<script>var contextRoot="${pageContext.request.contextPath}";</script><!-- necessary! to import js files -->
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/common.js?ver=0.2"></script><!-- jquery , ajaxRequest, etc -->
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/sys/utils.js"></script><!-- util folder -->
<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/html5.js"></script>


</head>
<script>
//모달이 열려있는 경우 (ajax가 아닌 경우 이페이지를 통함)
var existYn = parent.document.getElementsByClassName("AXModalBox").length;

alert("<spring:message code='fail.session.out' />");
location.href= contextRoot + "/index.do";

</script>


