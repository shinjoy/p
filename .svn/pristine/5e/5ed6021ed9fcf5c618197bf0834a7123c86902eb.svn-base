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
	 $(".t_skinR00 tbody tr.bgOdd:odd").css("background-color", "#F6F9FB");
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


function popupCst(sNb){	
	$('#s_Name').val(sNb);
	var frm = document.getElementById('customerName');//sender form id
	window.open("", "newWin", "width=1000, height=850");
	frm.target = "newWin";
	frm.submit();
}

</script>
</head>
<style>
tbody tr:hover{background-color: moccasin !important;}
</style>
<body>
<form id="customerName" name="customerName" action="<c:url value='/person/main.do' />" method="post">
	<input type="hidden" id="s_Name" name="sNb">
	<input type="hidden" id="popUp" name="popUp">
</form>
<div id="wrap" class="content_box">

	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>

			<%@include file="includeTab.jsp"%>
			<table class="t_skinR00">
				<colgroup>
					<col width="77">
					<col width="140">
					<col width="80">
					<col width="102">
					<col width="102">
					<col width="300">
					<col width="">
					<col width="180">
					<col width="80">
					<col width="120">
					<col width="64">
				</colgroup>
				<thead>
					<tr>
						<th style="height:20px"<%-- onclick="sortTable(1);" --%> class="bgYlw">제안일자</th>
						<th class="bgYlw pd0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;구분&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="hand" onclick="sortTable('sellBuy','${TAB}');">▼</span></th>
						<th class="bgYlw pd0">업종</th>
						<th class="bgYlw pd0">발행규모</th>
						<th class="bgYlw pd0">투자규모</th>
						<th class="bgYlw pd0">업무제목</th>
						<th class="bgYlw pd0">내용</th>
						<th class="bgYlw pd0">중개인</th>
						<th class="bgYlw pd0">진행사항</th>
						<th class="bgYlw pd0">투자의견</th>
						<th class="bgYlw pd0">등록자</th>
					</tr>
					<tr style="height:1px;"></tr>
				</thead>
				</table></div>
			<div style="padding-top:105px;">
			<table class="t_skinR00" style="table-layout:fixed;">
				<colgroup>
					<col width="77">
					<col width="80">
					<col width="60">
					<col width="80">
					<col width="102">
					<col width="102">
					<col width="300">
					<col width="">
					<col width="180">
					<col width="80">
					<col width="120">
					<col width="60">
				</colgroup>
				<%@include file="includeDeal.jsp"%>

</div>
</body>
</html>