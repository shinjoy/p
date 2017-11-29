<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>
<script type="text/JavaScript" src="<c:url value='/js/jquery-ui.js'/>" ></script>
<script>
$("#closeTab").mousedown(function(){
	$("#offerPr").draggable();
});
</script>
<form id="downName" name="downName" action="<c:url value='/work/downloadProcess.do' />" method="post">
	<input type="hidden" name="makeName" id="makeName"/>
	<input type="hidden" name="recordCountPerPage" value="0"/>
</form>
<style>ul{min-width:0 !important;}.popUpMenu .closePopUpMenu2:hover {margin: 0;text-align: left;cursor: pointer;background-color: #666;}.popUpMenu #closeTab2 {margin: 0;text-align: right;background-color: #323232;border-bottom: 1px solid #F2F2F2;color: #FFF;border-radius: 4px 4px 0 0;font-weight: bold;padding: 7px 12px 7px 15px;position: relative;}
</style>
<div class="popUpMenu title_area offerL" id="offerPr" style="display:block">
	<%--<p class="closePopUpMenu" name="textR" title="닫기" onclick="javascript:if(typeof(closePopUpMenu)=='function') closePopUpMenu(this);">ⅹ닫기</p>--%>
	<p id="closeTab2" name="textR"><span class="closePopUpMenu" onclick="javascript:if(typeof(closePopUpMenu)=='function') closePopUpMenu(this);" title="닫기">ⅹ닫기</span></p>
	<c:set var="cst2" value="0"/>
	<c:forEach var="net" items="${statsList}" varStatus="status">
		<c:choose><c:when test="${cst2 ne net.cpnNm}">
		<c:if test="${cst2 ne '0'}"></li></ul><div class="clear"></div></c:if>
		<ul style="overflow:hidden;background-color:white;border: solid gray 1px;padding: 4px;margin:3px;">
			<li style="width:50%;float:left">
				<ul>
					<li style="float:left;"><small>${net.rgDt }</small></li>
					<div class="clear"></div>
					<li style="float:left;width:90px;font-weight:bold;">${net.cstNm}</li>
					<li style="float:left;font-weight:bold;">→&nbsp;&nbsp;${net.cpnNm}</li>
					<div class="clear"></div>
					<li style="float:left;width:90px;"><small>${net.cstCpnNm}</small></li>
					<li style="float:left;"><small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${net.cstCpnNm2}</small></li>
					<div class="clear"></div>
					<li style="float:both;padding-top:5px;">&nbsp;${net.note}</li>
				</ul>
			</li>
			<li style="width:50%;float:left">
				<ul<c:if test="${not empty net.sNb}"> class="link" onclick="statsIntroducerOfferdivAjax(event,'${net.rgNm}',this,'${net.sNb}')"</c:if>>
					<li><small>${net.tmDt}</small></li>
					<li><b>${net.cpnNm1st}</b> ${net.cstNm1st} <font color="green"><c:if test="${not empty net.middleOfferNm}">${net.middleOfferNm }</c:if> ${net.offerNm}</font></li>
				</ul>
		</c:when><c:otherwise>
				<ul<c:if test="${not empty net.sNb}"> class="link" onclick="statsIntroducerOfferdivAjax(event,'${net.rgNm}',this,'${net.sNb}')"</c:if>>
					<li><small>${net.tmDt}</small></li>
					<li><b>${net.cpnNm1st}</b> ${net.cstNm1st} <font color="green"><c:if test="${not empty net.middleOfferNm}">${net.middleOfferNm }</c:if> ${net.offerNm}</font></li>
				</ul>
		</c:otherwise></c:choose>
		<c:if test="${fn:length(statsList) == status.count}"></li></ul><div class="clear"></div></c:if>
		<c:set var="cst2" value="${net.cpnNm}"/>
	</c:forEach>
</div>

