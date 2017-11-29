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
<title>인물검색</title>
<link href="<c:url value='/images/ibB.ico' />" rel="shortcut icon" type="image/x-icon">
<link href="<c:url value='/css/content.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet" type="text/css">

<link href="<c:url value='/css_m/default.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css_m/layout.css'/>" rel="stylesheet" type="text/css">

<script type="text/JavaScript" src="<c:url value='/js/html5.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/jquery.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/process.js?ver=0.1'/>" ></script>
<script>var contextRoot="${pageContext.request.contextPath}";</script>
<script type="text/JavaScript" src="<c:url value='/js/sys/utils.js?ver=0.4'/>" ></script><!-- 20160108 -->

<style>
.tr_selected {
	background:#ffdcc4!important;
	font-weight:bold;
}
.pop_tb_basic tbody td {
    font-size: 0.8rem;
    padding: 0.1em 0.1em;
}
.pageBtn{
	cursor:pointer;
	margin-left:5px;
	vertical-align:top;
}
.pageIdx{
	cursor:pointer;
	margin-left:5px;
	vertical-align:top;
}
.btn_mobile_blue01 {
    width: 30%;
    background: #59647a;
    border: #4b566b solid 1px;
    border-radius: 0.2em;
    font-size: 1.3rem;
    color: #fff!important;
    letter-spacing: -0.1em;
    display: block;
    text-align: center;
    padding: 0.6em 0.7em;
    box-sizing: border-box;
    line-height: 1;
    font-weight: bold;
}
.btn_finish_ok {
    border-image-source: initial;
    border-image-slice: initial;
    border-image-width: initial;
    border-image-outset: initial;
    border-image-repeat: initial;
    height: 21px;
    min-width: 30px;
    font-size: 11px;
    font-weight: normal;
    display: inline-block;
    vertical-align: middle;
    line-height: 21px;
    letter-spacing: -0.5px;
    color: rgb(255, 255, 255);
    background: rgb(38, 126, 188);
    border-width: 1px;
    border-style: solid;
    border-color: rgb(30, 116, 177);
    border-radius: 3px;
    padding: 0px 10px;
}
.popconWrap {
    padding: 1.2rem 0.1rem 0rem 0.1rem;
}
</style>

<script>

function linkPage(pageNo){
	//location.href = "<c:url value='/work/popUpCst.do'/>?pageIndex="+pageNo;
	var frm = document.searchCst;
	$('#pageIndex').val(pageNo);
	//frm.action = "<c:url value='/work/popUpCst.do'/>";
	frm.submit();
}
$(document).ready(function(){
/*
	var arg= window.dialogArguments;
	if(arg!="회사선택" && '${YN}'!='Y'){
		var frm = document.searchCpn;
		$("#cpnNm").val(arg);
		frm.submit();
	}
*/
	if(null != Request("f"  )&&''!=Request("f"  ))$("#flag").val(Request('f'));
	if(null != Request("n"  )&&''!=Request("n"  ))$("#num").val(Request('n'));
	if(null != Request("f"  )&&''!=Request("f"  ))$("#flag1").val(Request('f'));
	if(null != Request("n"  )&&''!=Request("n"  ))$("#num1").val(Request('n'));
 });
End = function(cstId,cstNm,cpnId,cpnNm,position,cpnSnb){
	var rVal = new Object();

	if(cpnId.length==0){
		if(!confirm("회사가 없는 사람은 선택할 수 없습니다.\n회사를 등록하시겠습니까?")){
			return ;
		}
		$('#m_Name').val(cstId);
		$('#choosePopMain').val("modifyCstPopUp");
		$('#modifyCst').submit();
		return;
	}

	rVal.f = <c:if test="${empty MDf}">Request('f')</c:if><c:if test="${not empty MDf}">'${MDf}'</c:if>;
	rVal.n = <c:if test="${empty MDn}">Request('n')</c:if><c:if test="${not empty MDn}">'${MDn}'</c:if>;
	rVal.nm = cstNm;
	rVal.snb = cstId;
	rVal.cpnId = cpnId;
	rVal.cpnNm = cpnNm;
	rVal.position = position;
	rVal.cpnSnb = cpnSnb;

	//if (window.opener) window.opener.returnPopUp(rVal);
	//window.close();

	if (window.opener){
		opener.window.postMessage(JSON.stringify(rVal), "*");
		opener.window.returnPopUp(rVal);
		procOnClose();
	}
};

function ajaxSearching(e){

	if(e.keyCode == 13){		//엔터키
		if($('.tr_selected').length > 0)
			$($('.tr_selected')[0]).trigger('click');
	}

	//위,아래 방향키를 통해 검색결과 선택		20160627
	if(e.keyCode == 38 || e.keyCode == 40){		//38 위로, 40 아래로 (방향키)
		var list = $('tr[name^=result_searched]');
		if(list.length > 0){
			var sel = $('.tr_selected');
			if(sel.length == 0){
				$(list[0]).addClass('tr_selected');
			}else{
				var tmp = '';

				var rIdx = ( 1 * ($(sel.get(0)).attr('name').substring(15)) - 1);		//선택된 현재 row index
				if(e.keyCode == 38){	// 38 위로
					if(rIdx - 1 < 0) rIdx = list.length -1;
					else rIdx --;
				}else{					//e.keyCode == 40 아래로
					if(rIdx + 1 == list.length) rIdx = 0;
					else rIdx ++;
				}

				list.removeClass('tr_selected');
				$(list[rIdx]).addClass('tr_selected');
			}
		}
		return;
	}

	var url = 'ajaxPopUpCstSearchName.do'
		,data = {
			pageIndex: $('#pageIndex').val()
			,cstNm: $('#nameSearch').val()
			,cstNmKor: engTypeToKor($('#nameSearch').val())
		},fn = function(arg){
		//console.log(arg.length);
		//if(arg.length>600)
		$('#icd').html(arg);


		//검색결과가 1건이면 자동 선택되도록 :S ----------	20160627
		var list = $('tr[name^=result_searched]');
		if(list.length == 1)
			list.addClass('tr_selected');
		//검색결과가 1건이면 자동 선택되도록 :E ----------

	};
	ajaxModule(data,url,fn);
}

</script>
<style>*{font-family: 맑은 고딕, Trebuchet MS, Verdana, Geneva, sans-serif;}.t_skinR00 tbody td{padding:0 !important;}</style>
 <base target="_self">
</head>

<body>
	<div class="popconWrap">

	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>

		<input type="hidden" id="rgstId" value="<c:out value='${baseUserLoginInfo.loginId}'/>">

		<form id="modifyCst" name="modifyCst" action="<c:url value='/person/modifyCst.do' />" method="post"><input type="hidden" id="m_Name" name="sNb"><input type="hidden" id="choosePopMain" name="choosePopMain"></form>
		<form id="insertCst" name="insertCst" action="<c:url value='/work/popRgstCst.do' />" method="post"><input type="hidden" id="s_Name" name="cstNm"><input type="hidden" id="s_Name2" name="searchCstNm" value="${searchName}"><input type="hidden" id="flag1" name="modalFlag" value="${MDf}"><input type="hidden" id="num1" name="modalNum" value="${MDn}"></form>

		<form name="searchCst" action="<c:url value='/work/popUpCst.do' />" method="post" onkeypress="return event.keyCode != 13;" >
			<div class="pool_seachZone" >
				<input type="hidden" id="flag" name="modalFlag" value="${MDf}">
				<input type="hidden" id="num" name="modalNum" value="${MDn}">
				<input type="hidden" id="cpnNm" name="cpnNm">
				<input type="hidden" id="pageIndex" name="pageIndex" value="1">
				<input type="search" id="nameSearch" name="cstNm" onkeyup="javascript:ajaxSearching(event);" placeholder="이름/회사" autofocus="autofocus" value="${searchName}">
				<input type="hidden" id="nameSearchKor" name="cstNmKor" value="DONTTOUCH"> <!-- 검색기능의 default value 쿼리의 or 조건(cstNmKor) -->
				<button onclick="ajaxSearching(event);"><em>검색</em></button>
			</div>
		</form>
		<div id="icd"><%@include file="../../includeJSP/PopUpCst.jsp" %></div>
</body>
</html>