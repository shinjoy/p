<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Main</title>
<link href="<c:url value='/css/content.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/images/synergyAI.ico'/>" rel="icon" type="image/x-icon">
<script type="text/JavaScript" src="<c:url value='/js/html5.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/jquery.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/process.min.js'/>" ></script>
<script>
$(document).ready(function(){
	$("#flag").val(Request('f'));
	if(null != Request("n"  )&&''!=Request("n"  ))$("#num").val(Request('n'));
	$("#rcmdSnb").val(Request('sNb'));
	if('ok'!='<c:out value='${pop}'/>') {
		$("#searchRcmd").submit();
	}
	
 });
End = function(snb,nm){
	var rVal = new Object();

	if(snb.length==0){ 
		return;
	}
	rVal.f = <c:if test="${empty MDf}">Request('f')</c:if><c:if test="${not empty MDf}">'${MDf}'</c:if>;
	rVal.n = <c:if test="${empty MDn}">Request('n')</c:if><c:if test="${not empty MDn}">'${MDn}'</c:if>;
	rVal.snb = snb;
	rVal.nm = nm;
	
	if (window.opener) window.opener.returnPopUp(rVal);
	window.close();
};
slct = function(YN){
	if(YN==0)
		End('0','미지정');
	else 
		End($("#snb").val(),$("#nm").val());
};
</script>
 <base target="_self">
</head>

<body>
	<div id="wrap">

		<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>

<br/>
<input type="hidden" id="rgstId" value="<c:out value='${baseUserLoginInfo.loginId}'/>">

<form id="searchRcmd" name="searchRcmd" action="<c:url value='/work/popUpRecommend.do' />" method="post"><input type="hidden" id="flag" name="modalFlag" value="${MDf}"><input type="hidden" id="num" name="modalNum" value="${MDn}"><input type="hidden" name="cpnId" id="rcmdSnb" value=""><input type="hidden" name="tmpNum1" value="1"></form>

			<div class="_popUpWidth">
				<div><c:if test="${not empty rcmdList}"><span class="btn s green"><a onclick="slct(1);">추천인 지정</a></span></c:if>
				<span class="btn s red"><a onclick="slct(0);">지정 취소</a></span></div>
				<table class="t_skin04_left">
					<thead>
						<tr>
							<th class="nameD bgYlw">추천인</th>
							<th class="bgYlw">회사</th>
							<th class="bgYlw">추천날짜</th>
						</tr>
					</thead>
					
					<tbody>
					<c:forEach var="rcmd" items="${rcmdList}" varStatus="status">
						<input type="hidden" id="snb" value="${rcmd.sNb}"/>
						<input type="hidden" id="nm" value="${rcmd.rgNm}"/>
						<tr onclick="End('${rcmd.sNb}','${rcmd.rgNm}');">
							<td class="cent">${rcmd.rgNm}</td>
							<td class="cent">${rcmd.cpnNm}</td>
							<td class="cent">${rcmd.tmDt}</td>
						</tr>
						<tr onclick="End('${rcmd.sNb}','${rcmd.rgNm}');">
							<td class="cent">내용</td>
							<td colspan="2">${fn:replace(rcmd.memo, lf,"<br/>")}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
</body>
</html>