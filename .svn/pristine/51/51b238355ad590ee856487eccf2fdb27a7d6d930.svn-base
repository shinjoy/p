<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Main</title>
<link href="<c:url value='/css/content.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet" type="text/css">
<script src="<c:url value='/js/html5.js'/>"></script>
<script src="<c:url value='/js/jquery.min.js'/>" type="text/JavaScript" ></script>
<style>p{font-size:11px;}</style>
<script>

$(document).ready(function(){
	//parent.reloadpage();
});
function chngTitle(th){
	var obj = $(th);
	var chId = $("#chId").val();
	$(".logLine").css('display','none');
	$("[class*="+obj.val()+"][class*="+chId+"]").css('display','');
}
function chngId(th){
	var obj = $(th);
	var chTitle = $("#chTitle").val();
	$(".logLine").css('display','none');
	$("[class*="+obj.val()+"][class*="+chTitle+"]").css('display','');
}
</script>
</head>
	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>
<body>
	<section>
		<article>
		<input type="hidden" id="rgstId" value="<c:out value='${baseUserLoginInfo.loginId}'/>">
			<div>
				<select id="chTitle" onchange="chngTitle(this)">
					<option value="logLine">-전체-</option>
					<option value="INFO">INFO</option>
					<option value="DEBUG">DEBUG</option>
					<option value="ERROR">ERROR</option>
				</select>
				<select id="chId" onchange="chngId(this)">
					<option value="logLine">-이름-</option>
					<c:forEach var="stf" items="${staffList}" varStatus="st">
					<option value="${stf.usrId}">${stf.usrNm}</option>
					</c:forEach>
				</select>
			</div>
			<div class="clear">
				<p class="mg0"><br/>
					<span style="display:inline-block;width:121px;">날짜</span>
					<span style="display:inline-block;width:40px;">rgId</span>
					<span style="display:inline-block;width:150px;">Controller</span>
					<span style="display:inline-block;width:150px;">Method</span>
				</p>
				<c:forEach var="f" items="${fileList}" varStatus="d"><c:if test="${fn:substring(f.tmDt,8,10) != line }"><br/></c:if>
				<c:set var="ex" value="${fn:split(f.tmpId,' ')}"/>
				<p class="logLine mg0 ${f.title} ${f.rgId}">${f.tmDt}
					<span style="display:inline-block;width:40px; font-weight:bold;color:hotpink;"><c:forEach var="stf" items="${staffList}" varStatus="st"><c:if test="${f.rgId eq stf.usrId}">${stf.usrNm}</c:if></c:forEach></span>
					<span style="display:inline-block;width:150px;font-weight:bold;<c:if test="${f.title == 'DEBUG' }">color:blue</c:if><c:if test="${f.title == 'ERROR' }">color:orangered</c:if>">${ex[0]}</span> 
					<span style="display:inline-block;width:150px;font-weight:bold;<c:if test="${f.title == 'DEBUG' }">color:blue</c:if><c:if test="${f.title == 'ERROR' }">color:orangered</c:if>">${ex[1]}</span> 
					<c:if test="${fn:length(f.rgId)>7}"><span style="color:red;font-weight:bold">${f.rgId}</span></c:if> 
					<span style="color:${f.tmpNum2};font-weight:bold">${f.tmpNum1 }</span> ${f.sNb }
				</p>
				<c:set var="line" value="${fn:substring(f.tmDt,8,10) }"/>
				</c:forEach>
			</div>
			<br/>
			<br/>
		</article>
	</section>
</body>
</html>