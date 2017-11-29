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
<script type="text/JavaScript" src="<c:url value='/js/html5.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/jquery.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/base.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/work.min.js'/>" ></script>
<style>
*{font-size:11px;}
.active{background:#457845;border:1px solid #558755;}
.mon_header {position: relative; height: 24px;}
.mon_week {position: relative; height:110px;}
.calendar_monthly .mon_cell {width: 13.8%;}
.mon_cell {float: left; height: 100%; font-weight:bold;}
.calendar_monthly .left {margin-left: 0.5%; color: #FE7474;}
.calendar_monthly .right {margin-right: 0.5%; color: #1974D1;}
.mon_header .mon_cell, table.calendar_history th {
font-weight: bold;
text-align: center;
line-height: 24px;
background-color: #D0DAB1;
 border-right: 1px dotted white;
}
.mon_week .mon_cell{ border-top: 1px solid lightgray; border-right: 1px dotted lightgray;}
.right {border-right: none !important}
</style>
<script>
$(document).ready(function(){
	// parent.widthAuto();
	$('.tabUnderBar').css('width','calc(100% - '+ parseInt(10 + 68*($('.1st').length)) +'px)');
	if($(window).width()<1010){resize4phone();}
});

function viewBox(th,tId){
	var obj = $(th);
	var nId = obj.attr('id').split(tId+'M');
	var dId = nId[0]+tId+nId[1];
	view(dId);
}
function resize4phone(){
	var winh = ($(window).height()-(26+25+29))/6
		,winW = $(window).width()*0.95;alert(winh);
	var tmp = $('[id^=bsnsRecPriv]').css('width');
	if(tmp.replace('px','')<42) tmp = 42;
	$('.mon_week').css('height',winh+'px');
	$('.title_area').css('width','95%');
	$('.title_area > ul').css('min-width','0');
	$('.n_note').css('width',winW - (24+tmp));
	$('.c_note').css('width',winW - 18);
	$('.c_note >textarea').css('width',winW - 18);
}
function switchClkBusiness(e,th){
	clkBusiness(e,th);
}
</script>
<style>
.subTabon,.subTab{
	height:16px !important;
	line-height:15px !important;
}
.year_wrap{display:inline-block;position:static;}
</style>
</head>
<body>
	<c:set var="now" value="<%= new java.util.Date() %>"/>
	<fmt:formatDate var="cur_date" value='${now}' pattern='d'/>
	<fmt:formatDate var="first_date_string" value='${now}' pattern='yyyy-MM-01'/>
	<fmt:parseDate var="first_date" value='${first_date_string}' pattern='yyyy-MM-01'/>

<div id="offerDiv"><div id="offerPr" style="display: none;"></div></div>

<div class="clear" style="width:10px;float:left;height:15px;border-bottom:1px solid #CCC;">&nbsp;</div>
<div class="1st subTabon" onclick="viewPer(this)">업무일지</div>
<div class="1st subTab<c:if test="${name == '2'}">on</c:if>" onclick="viewPer(this,2)">정보정리</div>
<div style="height:16px;line-height:15px;" class="1st subTab<c:if test="${name == '3'}">on</c:if>" onclick="viewPer(this,3)">메모</div>
<div class="tabUnderBar" style="float:left;height:15px;border-bottom:1px solid #CCC;">&nbsp;</div>
<div class="clear" style="height:4px;"></div>

<div class="year_wrap">
	<!-- 
	<span class="btn s navy"><a onclick="switchIbIns()">전체</a></span>
	<span class="btn s blue"><a onclick="switchIbIns('ib')">ib</a></span>
	<span class="btn s orange"><a onclick="switchIbIns('ins')">InSide</a></span>
	 -->
	<span class="year">
		<select id='choiceYear' name='choiceYear'>
		<c:forEach var="year" begin="2010" end="${cur_year+2}">
			<option value="${year}"
				<c:choose>
					<c:when test="${choiceYear == null}"><c:if test="${year == cur_year}">selected</c:if>></c:when>
					<c:otherwise><c:if test="${year == choiceYear}">selected</c:if>></c:otherwise>
				</c:choose>
			${year}</option>
		</c:forEach>
		</select>
	</span>
	<a <c:if test="${choiceMonth == '01' }">class="red bold"</c:if> onclick="month('01','selectPrivateWorkV.do')">1월</a><span> | </span>
	<a <c:if test="${choiceMonth == '02' }">class="red bold"</c:if> onclick="month('02','selectPrivateWorkV.do')">2월</a><span> | </span>
	<a <c:if test="${choiceMonth == '03' }">class="red bold"</c:if> onclick="month('03','selectPrivateWorkV.do')">3월</a><span> | </span>
	<a <c:if test="${choiceMonth == '04' }">class="red bold"</c:if> onclick="month('04','selectPrivateWorkV.do')">4월</a><span> | </span>
	<a <c:if test="${choiceMonth == '05' }">class="red bold"</c:if> onclick="month('05','selectPrivateWorkV.do')">5월</a><span> | </span>
	<a <c:if test="${choiceMonth == '06' }">class="red bold"</c:if> onclick="month('06','selectPrivateWorkV.do')">6월</a><span> | </span>
	<a <c:if test="${choiceMonth == '07' }">class="red bold"</c:if> onclick="month('07','selectPrivateWorkV.do')">7월</a><span> | </span>
	<a <c:if test="${choiceMonth == '08' }">class="red bold"</c:if> onclick="month('08','selectPrivateWorkV.do')">8월</a><span> | </span>
	<a <c:if test="${choiceMonth == '09' }">class="red bold"</c:if> onclick="month('09','selectPrivateWorkV.do')">9월</a><span> | </span>
	<a <c:if test="${choiceMonth == '10' }">class="red bold"</c:if> onclick="month('10','selectPrivateWorkV.do')">10월</a><span> | </span>
	<a <c:if test="${choiceMonth == '11' }">class="red bold"</c:if> onclick="month('11','selectPrivateWorkV.do')">11월</a><span> | </span>
	<a <c:if test="${choiceMonth == '12' }">class="red bold"</c:if> onclick="month('12','selectPrivateWorkV.do')">12월</a>
</div>

<div class="clear" style="height:4px;"></div>
<div class="calendar_monthly">
	<div class="mon_header">
		<div class="mon_cell left">일</div>
		<div class="mon_cell">월</div>
		<div class="mon_cell">화</div>
		<div class="mon_cell">수</div>
		<div class="mon_cell">목</div>
		<div class="mon_cell">금</div>
		<div class="mon_cell right">토</div>
	</div>
	<c:forEach var="cn" begin="0" end="5">
	<div class="mon_week"><c:forEach var="wk" begin="1" end="7"><c:set var="count" value="${(cn*7)+(wk-first_day+1)}"/>
		<div style="overflow-x: hidden;overflow-y: auto;" class="mon_cell<c:if test="${wk==1}"> left</c:if><c:if test="${wk==7}"> right</c:if>" <c:if test="${cur_date == count}">style="background-color:bisque;"</c:if>>
		<div class="overFlowHidden">
		<c:if test="${count <= last_day and count > 0}">
			${count}
			<a class="title" name="${choiceDay}" id="title_n" onmouseup="clkBusiness(event,this);" style="width:16px;height:16px">
				<img src="<c:url value='/images/edit-5-icon.png'/>" title="일지 입력">
			</a><br/>
		</c:if>
		<c:set var="choiceDay"><c:if test="${count < 10}">0</c:if>${count}</c:set>
		<c:forEach var="bsns" items="${resultList}" varStatus="bsnsS">
			<c:set var="Day_tmDt">${fn:substring(bsns.tmDt, 8,10)}</c:set>
			<c:if test="${fn:contains(Day_tmDt, choiceDay)}"><nobr><a class="title bsns<c:if test="${bsns.bsnsRecPrivate == '2'}"> busiGrn</c:if>" name="${choiceDay}" id="title_${bsns.sNb}" onmouseup="switchClkBusiness(event,this);">${bsns.title}<c:if test="${fn:length(bsns.title) < 1}">...</c:if></a></nobr><br/></c:if>
		</c:forEach>
		<c:forEach var="inside" items="${insideList}" varStatus="inS">
			<c:set var="Day_tmDt">${fn:substring(inside.tmDt, 8,10)}</c:set>
			<c:if test="${fn:contains(Day_tmDt, choiceDay)}"><nobr><a class="bsns bold inside<c:if test="${inside.bsnsRecPrivate == '2'}"> busiGrn</c:if>" id="titleI_${inside.sNb}" onmouseup="switchClkBusiness(event,this);">${inside.title}<c:if test="${fn:length(inside.title) < 1}">...</c:if></a></nobr><br/></c:if>
		</c:forEach>
		
		<%--
		<c:forEach var="BRL" items="${resultList}" varStatus="status">
			<c:set var="str">${fn:substring(BRL.tmDt, 8,10)}</c:set>
			<fmt:parseNumber var="ddate" integerOnly="true" value="${str}"/>
			<c:if test="${ddate==count}"><span style="display:inline-block;background-color:#C6E2CA;border-radius:3px;">
				<a id="${str}brlM${status.count}" onclick="viewBox(this,'brl');"><nobr>${BRL.title}</nobr></a>
			</span><br/></c:if>
		</c:forEach>
		<c:forEach var="INL" items="${insideList}" varStatus="status">
			<c:set var="str">${fn:substring(INL.tmDt, 8,10)}</c:set>
			<fmt:parseNumber var="ddate" integerOnly="true" value="${str}"/>
			<c:if test="${ddate==count}"><span style="display:inline-block;background-color:#FED7C4;border-radius:3px;">
				<a id="${str}inlM${status.count}" onclick="viewBox(this,'inl');"><nobr>${INL.title}</nobr></a>
			</span><br/></c:if>
		</c:forEach>
		<%--
		<c:forEach var="OFL" items="${offerList}" varStatus="status">
			<c:set var="str">${fn:substring(OFL.tmDt, 8,10)}</c:set>
			<fmt:parseNumber var="ddate" integerOnly="true" value="${str}"/>
			<c:if test="${ddate==count}"><span style="display:inline-block;border-radius:3px;">
			<a id="${str}oflM${status.count}" onclick="viewBox(this,'ofl');"><nobr><c:set var="tb_title" value="${OFL.cpnNm}"/>
				<font <c:if test="${fn:length(OFL.cpnId)!=7}">color="#084B8A"</c:if>>
					${tb_title}
					${OFL.cstNm}
					<c:if test="${empty tb_title}">(${OFL.cstCpnNm})</c:if>
					<c:if test="${not empty tb_title and not empty OFL.cstCpnNm}">(${OFL.cstCpnNm})</c:if>
				</font>
				<font color="green"><c:if test="${not empty OFL.middleOfferNm}">${OFL.middleOfferNm }</c:if> ${OFL.offerNm}</font>
			</nobr></a></span><br/></c:if>
		</c:forEach>
		--%>
		</div>
		</div></c:forEach>
	</div></c:forEach>
</div>

<!-- 업무일지 -->
<div>
	<c:forEach var="workVO" items="${resultList}" varStatus="bsnsStatus">
			<div class="popUpMenu title_area" id="${fn:substring(workVO.tmDt, 8,10)}brl${bsnsStatus.count}">
		<c:choose>
			<c:when test="${baseUserLoginInfo.permission > '00019'  or  baseUserLoginInfo.userName==workVO.name}">
				<input type="hidden" id="bsnsRecSNb${bsnsStatus.count}" value="${workVO.sNb }">
				<p class="closePopUpMenu" name="textR" title="닫기">ⅹ닫기</p>
				<ul>
					<li class="c_title">
						<select id="bsnsRecPriv${bsnsStatus.count}"><option value="1" <c:if test="${workVO.bsnsRecPrivate == '1'}">selected</c:if>>개인</option><option value="2" <c:if test="${workVO.bsnsRecPrivate == '2'}">selected</c:if>>전체</option></select>
						<input type="text" class="n_note" id="txt${bsnsStatus.count}" value="${workVO.title}"/></li>
					<li class="c_note"><textarea id="txtarea${bsnsStatus.count}">${workVO.note}</textarea></li>
					<li class="bsnsR_btn">
						<span class="bsnsR_btnOk btn s green"><a><spring:message code="button.save" /></a></span>&nbsp;&nbsp;&nbsp;
						<span class="bsnsR_btnDel btn s red"><a>완전삭제</a></span>
						<input type="text" id="BN_${fn:substring(workVO.tmDt, 8,10)}_${bsnsStatus.count}" style="height:1px;width:1px;border:0px none;padding:0;vertical-align:bottom;">
					</li>
				</ul>
			</c:when>
			<c:otherwise>
				<p class="closePopUpMenu" title="닫기">ⅹ닫기</p>
				<ul>
					<li class="c_title">
						<select disabled><option value="1" <c:if test="${workVO.bsnsRecPrivate == '1'}">selected</c:if>>개인</option><option value="2" <c:if test="${workVO.bsnsRecPrivate == '2'}">selected</c:if>>전체</option></select>
						<input type="text" class="n_note" disabled="true" value="${workVO.title}"/></li>
					<li class="c_note v-textarea">${fn:replace(workVO.note, lf,"<br/>&nbsp;&nbsp;")}</li>
				</ul>
			</c:otherwise>
		</c:choose>
			</div>
	</c:forEach>
	<c:forEach var="inside" items="${insideList}" varStatus="inS">
		<div class="popUpMenu title_area" id="${fn:substring(inside.tmDt, 8,10)}inl${inS.count}">
			<p class="closePopUpMenu" title="닫기">ⅹ닫기</p>
			<ul>
				<li class="c_title">
					<select disabled><option value="1" <c:if test="${inside.bsnsRecPrivate == '1'}">selected</c:if>>개인</option><option value="2" <c:if test="${inside.bsnsRecPrivate == '2'}">selected</c:if>>전체</option></select>
					<input type="text" class="n_note" disabled="true" value="${inside.title}"/></li>
				<li class="c_note v-textarea">${fn:replace(inside.note, lf,"<br/>&nbsp;&nbsp;")}</li>
			</ul>
		</div>
	</c:forEach>
</div>
<!-- 업무일지 -->
</body>
</html>