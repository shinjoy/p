<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
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
<script type="text/JavaScript" src="<c:url value='/js/part/popUp.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/changePage.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/calendar_beans_v2.0.js'/>" ></script>
<script>
 $(document).ready(function(){
	 $(".t_skinR00 tbody tr:odd").css("background-color", "#F6F9FB");
	 $('.tabUnderBar').css('width','calc(100% - '+ parseInt(10 + 68*($('.1st').length)) +'px)');
	 var ttl = $('#total');
	 if(ttl.val()=='sellBuy') ttl.val('');
 });

function popUpStaffTable(divId, e, cnt){
	$('#TofferSnb').val($('#offerSnb'+cnt).val());
	$('#TstCnt').val(cnt);
	$('#test').find('input[name=memoSndName]:checked').each(function(){
		this.checked = false;
	});
	view(divId,e);
}
function pickStaff(){
	var names = '';
	$('#test').find('input[name=memoSndName]:checked').each(function(){
		if(names.length>0) names+=',';
		names+=this.value;
	});
	var data = {
			offerSnb : $('#TofferSnb').val()
			,memoSndName : names
	}, fn = function(arg){
		$('#staffsBtn'+$('#TstCnt').val()).children().html(arg);
		$(".popUpMenu").hide();
	}
	ajaxModule(data,"../work/mnaMatchingStaffs.do",fn);
}
</script>
</head>
<style>
tbody tr:hover{background-color: moccasin !important;}
</style>
<body>
<div id="wrap" class="content_box">

	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>

			<%@include file="includeTab.jsp"%>
			<table class="t_skinR00">
				<colgroup>
					<col width="">
					<col width="100">
					<col width="80">
					<col width="80">
					<col width="100">
					<col width="80">
					<col width="80">
					<col width="130">
					<col width="184">
				</colgroup>
				<thead>
					<tr>
						<th class="bgYlw pd0" rowspan="2">업무제목</th>
						<th class="bgGrn pd0" colspan="3">투자</th>
						<th class="bgPich pd0" colspan="3">중개</th>
						<th class="bgYlw pd0" rowspan="2">관련직원</th>
						<th class="bgYlw pd0" rowspan="2">투자의견</th>
					</tr>
					<tr>
						<th class="bgGrn pd0">제안일자</th>
						<th class="bgGrn pd0">투자규모</th>
						<th class="bgGrn pd0">실제투자</th>
						<th class="bgPich pd0">중개일자</th>
						<th class="bgPich pd0">중개규모</th>
						<th class="bgPich pd0">중개차익</th>
					</tr>
					<tr style="height:1px;"></tr>
				</thead>
				</table></div>
			<div style="padding-top:105px;">
			<table class="t_skinR00" style="table-layout:fixed;">
				<colgroup>
					<col width="">
					<col width="100">
					<col width="80">
					<col width="80">
					<col width="100">
					<col width="80">
					<col width="80">
					<col width="130">
					<col width="180">
				</colgroup>
				<tbody>
					<c:forEach var="oc" items="${outcomeList}" varStatus="ocS">
						<tr style="height:40px;">
							<td class="pd0 hand hov" onclick="popUp('${oc.tmDt}','rcmdComment','','${oc.sNb}');">&nbsp;&nbsp;
								<b>${oc.cpnNm}<c:if test="${not empty oc.cpnType}">(${oc.cpnType})</c:if></b>&nbsp;
								${oc.categoryNm}<span style="display:inline-block;width:20px;"></span>
								<%--
								<c:if test="${oc.fileCnt != 0}"><span style="color:#89A0DA">
									<img class="filePosition" id="file${status.count}" src="../images/file/files.png" style="width:16px;height:16px"/><b>[${oc.fileCnt + oc.commentFileCnt}]</b></span></c:if>
								<c:if test="${oc.analysis != 0}"><span style="color:mediumvioletred">
									<img class="filePosition" id="fileAn${status.count}" src="../images/recommend/analy.png" style="width:16px;height:16px"/><b>[${oc.analysis}]</b></span></c:if>
								<c:if test="${oc.opinion != 0}"><span style="color:darkgoldenrod">
									<img class="filePosition" id="fileOp${status.count}" src="../images/recommend/comment1.png" style="width:16px;height:16px"/><b>[${oc.opinion}]</b></span></c:if>&nbsp;</nobr>
								 --%>
							</td>
						<input type="hidden" id="offerSnb${status.count}" value="${oc.sNb}">
							<td class="cent pd0">${oc.tmDt}</td>
							<td class="cent pd0">${oc.investPrice}</td>
							<td class="cent pd0"><fmt:parseNumber var="investPrice" integerOnly="false" value="${oc.investPrice}"/><fmt:formatNumber value="${investPrice-oc.tmpNum1}"/>억</td>
							<td class="cent pd0">${oc.rgDt}</td>
							<td class="cent pd0"><fmt:formatNumber value="${oc.tmpNum1}" pattern=".00"/>억</td>
							<td class="cent pd0"><fmt:formatNumber value="${oc.tmpNum2-oc.tmpNum1}"/>억</td>
							<td class="cent pd0">${oc.rgNm}외 ${oc.jointCnt}명</td>
							<td class="cent pd0" style="overflow:hidden;">
								<a class="opinion_m" id="opinion_${oc.sNb}"><font color="blue">
								<c:choose><c:when test="${empty oc.investOpinion}"><small><font style="color:gray">의견..</font></small></c:when>
									<c:otherwise>${oc.investOpinion}</c:otherwise></c:choose>
								</font></a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>

</div>
</body>
</html>