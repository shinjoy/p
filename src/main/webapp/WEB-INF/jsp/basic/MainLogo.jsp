<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>


<%-- ======================= 세션 정보에 따른 변수 선언 (간단한 이름으로 재정의 사용) :S  ======================== --%>
<c:set var="mezzL" value="${baseUserLoginInfo.mezzL}"/>		<%-- 메자닌 상장 권한 --%>
<c:set var="mezzN" value="${baseUserLoginInfo.mezzN}"/>		<%-- 메자닌 비상장 권한 --%>

<c:if test="${baseUserLoginInfo.permission > '00020'  or  baseUserLoginInfo.loginId eq 'gjh'}">	<%-- 개발자 or 대표님 은 무조건 'Y' --%>
<c:set var="mezzL" value="Y"/>
<c:set var="mezzN" value="Y"/>
</c:if>
<%-- ======================= 세션 정보에 따른 변수 선언 (간단한 이름으로 재정의 사용) :E  ======================== --%>


<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta http-equiv="Cache-Control" content="no-cache"/>
<meta http-equiv="Expires" content="0"/>
<meta http-equiv="Pragma" content="no-cache"/>

<title>Main</title>
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/memo.css'/>" rel="stylesheet" type="text/css">

<script type="text/JavaScript" src="<c:url value='/js/html5.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/jquery.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/process.js?ver=0.1'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/part/popUp.js?ver=0.1'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/part/memo.js?ver=0.1'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/work.js?ver=0.1'/>" ></script>
<script>

$(document).ready(function(){
	//파일 다운로드
	$(document).on("click",".filePosition",function(){
		var obj = $(this).parent();
		// var frm = document.getElementById('modifyRec');//sender form id
		// frm.action = "downloadProcess.do";//target frame name
		// frm.submit();
		var obj_id = $(this).attr('id');
		var num = obj_id.split('ile');
		$("#makeName").val(obj.find('[id^=mkNames'+num[1]+']').val());
		// document.downName.submit();
		$("#downName").submit();
	});

	$('.Toogle').hover(function(){
		$(this).find('[class*=ToogleIpt]').next().fadeIn('slow');
	},function(){
		$(this).find('[class*=ToogleIpt]').next().delay(5000).fadeOut('fast');
	});

	$(".frt_idea ul:odd").css("background-color", "#EDF4F8");
	$(".frt_newNet ul:odd").css("background-color", "#EDF4F8");
	window.parent.mainPadding0();
});
/*
function resize_iframe(){
	var height = document.documentElement.clientHeight || window.innerHeight || document.body.clientHeight;
	var stockCstFrame = $(".line1").offsetTop;
	$(".frt_data").style.height=parseInt(height-stockCstFrame-70)+"px";
	$(".line2").style.height=parseInt(height-stockCstFrame-70)+"px";
	$(".line3").style.height=parseInt(height-stockCstFrame-70)+"px";
}
*/


function mainMemoChkOK(th, stts){
	var obj = $(th).parent().parent();
	var data = {
			memoSNb: obj.find('[id^=memoSNb]').val(),
			sttsCd: stts,
			rgId: $('#rgstId').val(),
			importance: obj.find('[id^=importance]').val()
			};
	var url = "../work/checkMemo.do";
	var fn = function(){
		parent.mainFrame.location.replace("mainLogo.do");
	};
	ajaxModule(data,url,fn);
}

function newCstNnetwork(th,cd,snb,flag){
	if(cd==='2'||cd==='5') {
		//checkMainTable($(th).parent().parent(),cd,snb);
		if(flag!='no'){
			return popUp('','rcmdCst','',snb);
		}
	}
	checkMainTable($(th).parent().parent(),cd,snb);
}
function checkMainTable(th,cd,snb){
	var clickSentence = $(th);
	var data = {
			categoryCd: "0000"+cd
			,offerSnb: snb
			,rgId: $('#rgstId').val()
			};
	var url = "../main/checkMainTable.do";
	var fn = function(){
		clickSentence.css('display','none');
		//parent.mainFrame.location.replace("mainLogo.do");
	};
	ajaxModule(data,url,fn);
}
function memoDivNew(e,rcvStf){
	var fn = function(arg){
		$("#offerDiv").html(arg);
		$("#offerDiv").find('[id^=memoSndName]').val(rcvStf);
		$("#offerDiv").find('[id^=memoarea0]').attr('placeholder','\''+rcvStf+'\'에게 메모를 전달합니다.');
		view("offerPr",'',e);
	};
	ajaxModule('',"../main/sendNewMemo.do",fn);
}
/*
//메모 추가
function memoDivAjax_new(th,e,snb,mainSnb){
	var DATA = {sNb: snb};
	if(!(mainSnb==null||mainSnb=='')) DATA = {sNb:snb,mainSnb: mainSnb};
	var fn = function(arg){
		$("#offerDiv").html(arg);
		//var day = $(th).parent().parent().attr('class').split('day')[1];
		var day = new Date().getDate();
		if(!(day==null||day=='')) $("#offerDiv").find('[id^=memoSNb]').attr('id','memoSNb'+day);
		view("offerPr",'',e);
	};
	ajaxModule(DATA,"../main/privateMemo.do",fn);
} */

//메모 내용수정 확인 미사용: 박성진
/* function sndMemo_btnOk(th,f){
	var obj = $(th).parent().parent()
	,comment = obj.find('[id^=memoarea]').val();

	if(comment.indexOf('에게 메모를 전달합니다.')>0) {
		alert('내용을 입력하세요.');
		return;
	}

	$(".popUpMenu").hide();
	var DATA = {
			memoSndName: $('#memoSndName').val(),
			comment: comment,
			//choiceYear: $('#choiceYear').val(),
			//choiceMonth: $('#choiceMonth').val(),
			//day: day,

			subMemo: "N",
			importance: obj.find('[id^=importance]').val(),
			priv: obj.find('[id^=priv]').val(),
			tmpNum2: '${baseUserLoginInfo.userName}'
			}
	,url = "../work/insertMainNewMemo.do"
	,fn = function(){
		if(f==='popUpMemo') document.modifyRec.action = "popUpMemo.do";
		else document.modifyRec.action = "selectPrivateWorkV.do";
		document.modifyRec.submit();
	};
	ajaxModule(DATA, url, fn);
} */


//더보기 버튼을 통해 메뉴로 이동을 위해 추가
function goMenuByMoreBtn(sUrl, knd) {
	location.href = sUrl + '?sorting=' + knd;
}


//인물추가 ... 더보기 버튼을 통해 메뉴로 이동을 위해 추가
function goMenuPerson(){
	//parent.leftIframeON();
	top_menu_new("${pageContext.request.contextPath}/person/personMgmt.do", "mainFrame");
}

function top_menu_new(sUrl, frame) {

	if (frame=="mainFrame") {
		parent.mainFrame.location.href = sUrl;
	}else if (frame == "leftFrame") {
		parent.leftFrame.location.href = sUrl;
	}
}

//parent.slctMainMenu(6);



//팝업 재정의 (인물 추가)
/* function popUpNew(num,flag,nm,snb){

	// popUp 규격
	var w = '740';
	var h = '740';
	var ah = screen.availHeight - 30;
	var aw = screen.availWidth - 10;

	var sUrl = '';

	if(flag=='new_person') {
		sUrl = "../person/rgstCst.do";
		sUrl+='?f='+flag+'&n='+num;
		sUrl+='&fromMain=y';
		w='690';
		h='400';
	}

	h = (ah-40>h?h:ah-40);
	var xc = (aw - w) / 2;
	var yc = (ah - h) / 2;
	var option = "left=" + xc
				+",top=" + yc
				+",width=" + w
				+",height=" + h
				+",menubar=no"
				+",status=no"
				+",toolbar=no"
				+",location=no"
				+",scrollbars=yes"
				+",resizable=no"
				;
	window.open(sUrl, "_blank", option);
	return;
} */




//메모 검색 화면 팝업
function openMemoSearchPop(){

	var url = "${pageContext.request.contextPath}/work/memoBox.do";
	var option = "left=" + (screen.width > 1400?"200":"0") + ", top=" + (screen.height > 810?"100":"0") + ", width=1400, height=810, menubar=no, status=no, toolbar=no, location=no, scrollbars=auto, resizable=no";

	window.open(url, "_blank", option);

}


</script>
<style>
p{font-size:11px;}.cent{text-align: center;}
.popUpMenu #closeTab{
	margin: 0;
	text-align: right;

	background-color: #323232;
    border-bottom: 1px solid hsl(0, 0%, 95%);
    color: hsl(0, 0%, 100%);
	border-radius: 4px 4px 0 0;
    font-weight: bold;
    padding: 7px 12px 7px 15px;
    position: relative;
}
select{font-size:11px;}.mainDataLayout{border-radius:5px;box-shadow:2px 2px 10px#888888;margin:0 auto;}.mainDataLayoutTitle{text-align:center;padding:10px 0;border-radius:5px 5px 0 0;}.title_areaS{width:400px;}.title_areaS ul{padding:7px;margin:0;list-style:none;min-width:390px;border-radius:5px;}.popUpMenu{display:none;position:absolute;z-index:9999;background-color:#ECEADF;border:1px solid hsl(0,0%,79%);border-radius:4px;box-shadow:0 2px 6px hsla(0,0%,0%,0.25);color:hsl(0,0%,20%);font-size:12px;}.popUpMenu .closePopUpMenu:hover{margin:0;text-align:left;cursor:pointer;background-color:#666666;}.popUpMenu select,.popUpMenu input{border:1px solid gray;border-radius:2px;}.popUpMenu input{font-size:0.95em;padding:2px 1px 2px 2px;}.title_area{width:530px;}.title_area ul{padding:7px;margin:0;list-style:none;min-width:420px;border-radius:5px;}.popUpTitle_area ul{padding:7px;margin:0;list-style:none;min-width:320px;list-style:none;}.overFlowHidden{width:98%;overflow:hidden;}.title,.c_title,.cpnNm,.bold{font-weight:bold;}.c_title{line-height:18px;vertical-align:middle;}.c_note{color:gray;line-height:150%;min-height:180px;}.mini_c_note{color:gray;line-height:150%;}
textarea{resize:none;min-height: 180px; font-family:맑은 고딕, Trebuchet MS, Verdana, Geneva, sans-serif;}.bsnsR_btn{margin:0;text-align:center;}.t_note{margin:0;color:gray;font-size:12px;}.v-textarea{background-color:white;border:1px solid#AFAFAF;width:504px;margin-top:2px;padding:2px;}
textarea,.c_note,.m_note{font-size:12px;width:500px;}.bgRed {background-color: #F6CECE !important;}
a img{cursor:pointer;}

.mg0 {	margin:0 !important;}.pd0 {	padding:0 !important;}html, body{	height:100%;	background-color:rgba(230, 230, 230, 0.44)}


.frt_data, .frt_cmnt, .frt_mna, .frt_cbeb, .frt_prjt, .frt_memo, .frt_majorMemo, .frt_keyPt, .frt_newCst, .frt_newNet, .frt_idea, .frt_ipo{ border: 1px solid gray; background-color:white;overflow-y:auto;}
/*.frt_{height: -moz-calc( 50% -12px);height: -webkit-calc( 50% -12px);height:calc( 50% - 12px);margin-bottom: 10px;}*/
/* .frt_keyPt{height:38%;} */

/*.frt_cbeb,.frt_cmnt00{height: -moz-calc( 43% -12px);height: -webkit-calc( 43% -12px);height:calc( 43% - 12px);margin-bottom: 10px;}
.frt_mna,.frt_memo00{height:30%; margin-bottom: 10px;}

.frt_newNet,.frt_cmnt,.frt_data{height: -moz-calc( 49% -12px);height: -webkit-calc( 49% -12px);height:calc( 49% - 12px);margin-bottom: 10px;}
.frt_memo,.frt_keyPt{height: -moz-calc( 50%);height: -webkit-calc( 50%);height:calc( 50%);}
.frt_ipo{height: -moz-calc( 26% -12px);height: -webkit-calc( 26% -12px);height:calc( 26% - 12px);margin-bottom: 10px;}
.frt_newCst{height: -moz-calc( 50%);height: -webkit-calc( 50%);height:calc( 50%);}
.frt_idea{height:28%;}
.frt_majorMemo{height:50%;}
.frt_prjt{height:18%;}*/


.frt_cbeb {height: 48%;margin-bottom: 10px;  } /*cb*/
.frt_mna{height:24%; margin-bottom: 10px; } /*mna*/
.frt_ipo { height: 24%; margin-bottom: 10px; } /*프리*/

.frt_data { height:48%; margin-bottom:10px; } /*정보정리*/
.frt_keyPt { height:49.3%;  } /*정보정리핵심체크*/

.frt_newNet { height:48%; margin-bottom:10px;  } /*네트워크*/
.frt_newCst { height: 49.3%; } /*인물추가*/

.frt_cmnt { height:48%; margin-bottom:10px; } /*코멘트*/
.frt_majorMemo { height:49.3%;  } /*메모*/

.frt_memo { height:50%;  } /**/
.frt_idea { height:28%;   } /**/
.frt_prjt { height:18%; } /**/



.frt_title{font-weight:bold;font-size:14px;font-family: 맑은 고딕, Trebuchet MS, Verdana, Geneva, sans-serif;display:inline-block;padding:0px 4px 8px 10px;}
.frt_body{font-weight:bold;font-size:12px;line-height:18px;font-family: 맑은 고딕, Trebuchet MS, Verdana, Geneva, sans-serif; }
.frt_body ul:not(.hov),.frt_body ul div.hov{cursor:pointer;}
.frt_body ul:hover:not(.hov),.frt_body ul div.hov:hover {background-color: moccasin !important;}
.frt_body .nameNdate{float:right;font-weight:normal;padding-right:5px;height:18px;}
/* Internet Explorer */
html {scrollbar-3dLight-Color: #efefef; scrollbar-arrow-color: #dfdfdf; scrollbar-base-color: #efefef; scrollbar-Face-Color: #dfdfdf; scrollbar-Track-Color: #efefef; scrollbar-DarkShadow-Color: #efefef; scrollbar-Highlight-Color: #efefef; scrollbar-Shadow-Color: #efefef}
/* Chrome, Safari용 스크롤 바 */
::-webkit-scrollbar {width: 8px; border: 3px solid #fff; }
::-webkit-scrollbar-button:start:decrement, ::-webkit-scrollbar-button:end:increment {display: block; height: 10px; background: #efefef}
::-webkit-scrollbar-track {background: #efefef; -webkit-border-radius: 10px; border-radius:10px; -webkit-box-shadow: inset 0 0 4px rgba(0,0,0,.2)}
::-webkit-scrollbar-thumb {height: 50px; width: 50px; background: rgba(0,0,0,.2); -webkit-border-radius: 8px; border-radius: 8px; -webkit-box-shadow: inset 0 0 4px rgba(0,0,0,.1)}

.bg00002{background-color:lightgray;}
.bg00003,bgMna00006{background-color:#E94F51;}
.clr1{color:green;}.clr2{color:blue;}.clr3{color:red;}

.mainBoxTitle { background:#2b9abf; /*border-top-left-radius:5px; border-top-right-radius:5px;*/ line-height:1; height:17px; vertical-align:middle; color:#fff; font-weight:bold; font-size:13px; font-family: "나눔고딕", 맑은 고딕, Verdana, sans-serif; padding:5px 15px 7px 15px!important; position:relative; }
.mainBoxTitle .title  { line-height:17px; vertical-align:middle; }
.mainBoxTitle .btnZone { position:absolute; z-index:10; right:6px; top:6px; }

.line2 {width:330px;height:100%; min-height:500px; float:left; margin:10px 0px 0px 10px; } /* 딜 */
.line1 {width:330px;height:100%;min-height:500px;float:left; margin:10px 0px 0px 10px; } /* 정보정리 */
.line4 {width:330px;height:100%;min-height:500px;float:left; margin:10px 0px 0px 10px; } /* 네트워크 인물추가 */
.line3 {width:330px;height:100%; min-height:500px; float:left; margin:10px 0px 0px 10px; } /* 코멘트 메모		width:351px; */
.line5 {width:330px;height:100%; min-height:500px; float:left; margin:5px; } /* 없는듯 */

.line2 .mainBoxTitle { background:#2b9abf; }
.line1 .mainBoxTitle { background:#4cb1c9; }
.line4 .mainBoxTitle { background:#4a9fca; }
.line3 .mainBoxTitle { background:#3585c8; }




</style>
</head>
	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>
<c:set var="now" value="<%= new java.util.Date() %>"/>
<fmt:formatDate var="cur_day" value='${now}' pattern='yyyy-MM-dd'/>

<body style="height:calc(98%);margin:2px 0 0 5px;">

<input type="hidden" id="pageName" value="MainLogo">
<input type="hidden" id="rgstId" value="<c:out value='${baseUserLoginInfo.loginId}'/>">
<form id="downName" name="downName" action="<c:url value='/work/downloadProcess.do' />" method="post">
	<input type="hidden" name="makeName" id="makeName"/>
	<input type="hidden" name="recordCountPerPage" value="0"/>
</form>

<div id="offerDiv"><div id="offerPr" style="display: none;"></div></div>

	<div class="line2">
		<!-- cb / eb -->
		<div class="frt_cbeb">
	        <div class="mainBoxTitle"><span class="title">CB / EB</span><span class="btnZone"><a href="javascript:goMenuByMoreBtn('${pageContext.request.contextPath}/work/selectWorkAllDeal.do', '');"><img src="../images/main/btn_more_st01.gif" alt="더보기"/></a></span></div>
	        <div class="frt_body">
	            <c:forEach var="ofer" items="${offerList2}" varStatus="status">


	            	<%-- ================== 권한에 따라 '*' 처리해야 하는 딜 건인지 변수(asterDeal) 에 저장 :S  ================== --%>
					<c:choose>
					<c:when test="${mezzL eq 'Y'}">
						<c:set var="asterDeal" value="N"/>
					</c:when>		<%-- 내가 등록한 딜이 아니면서 --%>		<%--             상장사 이고			 --%>		<%--						메자닌 (CB, EB, BW) 이고								 --%>		<%--	진행중 인 건		 --%>		<%--						제안중이 아니고					 --%>
					<c:when test="${ofer.rgId ne baseUserLoginInfo.loginId and ('A' eq ofer.cpnStts or 'Q' eq ofer.cpnStts) and (ofer.categoryCd eq '00001' or ofer.categoryCd eq '00002' or ofer.categoryCd eq '00003') and ofer.progressCd eq '00001'}">		<%--  and (ofer.middleOfferCd ne '00004' and ofer.middleOfferCd ne '00005') --%>
						<c:set var="asterDeal" value="Y"/>	<%-- 별표시(숨김) --%>
					</c:when>
					<c:otherwise>
						<c:set var="asterDeal" value="N"/>
					</c:otherwise>
					</c:choose>
					<%-- ================== 권한에 따라 '*' 처리해야 하는 딜 건인지 변수(asterDeal) 에 저장 :E  ================== --%>


		            <c:choose>
					<c:when test="${ofer.rgId ne baseUserLoginInfo.loginId and ((ofer.categoryCd ne '00008' and ofer.infoLevel lt baseUserLoginInfo.infoLevel)||(ofer.categoryCd eq '00008' and ofer.infoLevel lt baseUserLoginInfo.mnaLevel))}">	<%--of.secretYn eq 'Y' and of.rgId ne baseUserLoginInfo.loginId --%>
					<!-- 보안등급이 나의 등급보다 높고 내가 등록한게 아니면 안보인다. -->
					</c:when>
					<c:otherwise>

		            <c:if test="${ofer.categoryCd == '00001' || ofer.categoryCd == '00003'}">
		            <ul class="mg0 pd0 hov bg${ofer.progressCd}" style="width:100%;overflow: hidden;">
		                <nobr>
		                    <div class="mg0 hov" style="overflow:hidden;width:204px;float:left;padding:0 0 0 5px;"
		                    <c:choose>
		                        <c:when test="${(ofer.offerCd == '00006') or (ofer.offerCd == '00007') or (ofer.offerCd == '00013') or (ofer.middleOfferCd == '00004') or (ofer.middleOfferCd == '00005') }"> onclick="popUp('${ofer.tmDt}','rcmdComment','','${ofer.sNb}');"</c:when>
		                        <c:otherwise> onclick="statsOfferdivAjax(event,'${ofer.rgNm}',this.parentNode.parentNode,'${ofer.sNb}','${ofer.reportYN}')"</c:otherwise>
		                    </c:choose>
		                    >
		                        <font <c:if test="${((fn:length(ofer.cpnId)!=0) and (fn:length(ofer.cpnId)!=7)) or ((fn:length(ofer.cpnId)==0) and (fn:length(ofer.cstCpnId)!=7))}">color="#084B8A"</c:if>>
		                            -
		                            <c:choose><c:when test="${asterDeal eq 'Y'}">***</c:when><c:otherwise>${ofer.cpnNm}<c:if test="${empty ofer.cpnNm}">${ofer.cstCpnNm}</c:if></c:otherwise></c:choose>
		                            <%-- ${ofer.cstNm}<c:if test="${empty ofer.cpnNm}">(${ofer.cstCpnNm})</c:if><c:if test="${not empty ofer.cpnNm and not empty ofer.cstCpnNm}">(${ofer.cstCpnNm})</c:if> --%>
		                        </font>
		                        <font color="green">${ofer.middleOfferNm }<c:if test="${empty ofer.middleOfferNm}"> ${ofer.offerNm}</c:if></font>
		                        <c:if test="${not empty ofer.realNm}"><img src="../images/file/files.png" align="absmiddle"></c:if>
		                    </div>
		                    <div class="nameNdate hov" onclick="checkMainTable(this.parentNode.parentNode,'1','${ofer.sNb}')"><small>&nbsp;X&nbsp;</small></div>
		                    <div class="nameNdate hov" onclick="memoDivNew(event,'${ofer.rgNm}');"><small>${ofer.rgNm} | '${fn:replace(fn:substring(ofer.tmDt,2,10),'-','.')}</small></div>
		                </nobr>
		            </ul>
		            </c:if>

		            </c:otherwise>
		            </c:choose>

	            </c:forEach>
	        </div>
		</div>
		<!-- M & A -->
		<div class="frt_mna">
	        <div class="mainBoxTitle"><span class="title">M &amp; A</span><span class="btnZone"><a href="javascript:goMenuByMoreBtn('${pageContext.request.contextPath}/work/selectWorkAllDeal.do', '00008');"><img src="../images/main/btn_more_st01.gif" alt="더보기"/></a></span></div>
			<div class="frt_body">
				<c:forEach var="ofer" items="${offerList2}" varStatus="status">

				<c:choose>
				<c:when test="${ofer.rgId ne baseUserLoginInfo.loginId and ((ofer.categoryCd ne '00008' and ofer.infoLevel lt baseUserLoginInfo.infoLevel)||(ofer.categoryCd eq '00008' and ofer.infoLevel lt baseUserLoginInfo.mnaLevel))}">	<%--of.secretYn eq 'Y' and of.rgId ne baseUserLoginInfo.loginId --%>
				<!-- 보안등급이 나의 등급보다 높고 내가 등록한게 아니면 안보인다. -->
				</c:when>
				<c:otherwise>

				<c:if test="${ofer.categoryCd == '00008'}">
				<ul class="mg0 pd0 hov bgMna${ofer.progressCd}" style="width:100%;overflow: hidden;">
					<nobr>
						<div class="mg0 hov" style="overflow:hidden;width:204px;float:left;padding:0 0 0 5px;"
						<c:choose>
							<c:when test="${(ofer.offerCd == '00006') or (ofer.offerCd == '00007') or (ofer.offerCd == '00013') }"> onclick="popUp('${ofer.tmDt}','rcmdComment','','${ofer.sNb}');"</c:when>
							<c:otherwise> onclick="statsOfferdivAjax(event,'${ofer.rgNm}',this.parentNode.parentNode,'${ofer.sNb}','${ofer.reportYN}')"</c:otherwise>
						</c:choose>
						>
							<font <c:if test="${((fn:length(ofer.cpnId)!=0) and (fn:length(ofer.cpnId)!=7)) or ((fn:length(ofer.cpnId)==0) and (fn:length(ofer.cstCpnId)!=7))}">color="#084B8A"</c:if>>
								- ${ofer.cpnNm}<c:if test="${empty ofer.cpnNm}">${ofer.cstCpnNm}</c:if><%-- ${ofer.cstNm}<c:if test="${empty ofer.cpnNm}">(${ofer.cstCpnNm})</c:if><c:if test="${not empty ofer.cpnNm and not empty ofer.cstCpnNm}">(${ofer.cstCpnNm})</c:if> --%>
							</font>
							<font color="green">${ofer.middleOfferNm }<c:if test="${empty ofer.middleOfferNm}"> ${ofer.offerNm}</c:if></font>
							<c:if test="${not empty ofer.realNm}"><img src="../images/file/files.png" align="absmiddle"></c:if>
						</div>
						<div class="nameNdate hov" onclick="checkMainTable(this.parentNode.parentNode,'1','${ofer.sNb}')"><small>&nbsp;X&nbsp;</small></div>
						<div class="nameNdate hov" onclick="memoDivNew(event,'${ofer.rgNm}');"><small>${ofer.rgNm} | '${fn:replace(fn:substring(ofer.tmDt,2,10),'-','.')}</small></div>
					</nobr>
				</ul>
				</c:if>

				</c:otherwise>
				</c:choose>

				</c:forEach>
			</div>
		</div>
		<!-- 프리IPO -->
		<div class="frt_ipo">
			<div class="mainBoxTitle"><span class="title">프리IPO</span><span class="btnZone"><a href="javascript:goMenuByMoreBtn('${pageContext.request.contextPath}/work/selectWorkAllDeal.do', '00012');"><img src="../images/main/btn_more_st01.gif" alt="더보기"/></a></span></div>
			<div class="frt_body">
				<c:forEach var="ofer" items="${offerList4}" varStatus="status">

				<c:choose>
				<c:when test="${ofer.rgId ne baseUserLoginInfo.loginId and ((ofer.categoryCd ne '00008' and ofer.infoLevel lt baseUserLoginInfo.infoLevel)||(ofer.categoryCd eq '00008' and ofer.infoLevel lt baseUserLoginInfo.mnaLevel))}">	<%--of.secretYn eq 'Y' and of.rgId ne baseUserLoginInfo.loginId --%>
				<!-- 보안등급이 나의 등급보다 높고 내가 등록한게 아니면 안보인다. -->
				</c:when>
				<c:otherwise>

				<c:if test="${ofer.categoryCd == '00012'}">
				<ul class="mg0 pd0 hov bg${ofer.progressCd}" style="width:100%;overflow: hidden;">
					<nobr>
						<div class="mg0 hov" style="overflow:hidden;width:204px;float:left;padding:0 0 0 5px;"
						<c:choose>
							<c:when test="${(ofer.offerCd == '00006') or (ofer.offerCd == '00007') or (ofer.offerCd == '00013') }"> onclick="popUp('${ofer.tmDt}','rcmdComment','','${ofer.sNb}');"</c:when>
							<c:otherwise> onclick="statsOfferdivAjax(event,'${ofer.rgNm}',this.parentNode.parentNode,'${ofer.sNb}','${ofer.reportYN}')"</c:otherwise>
						</c:choose>
						>
							<font <c:if test="${((fn:length(ofer.cpnId)!=0) and (fn:length(ofer.cpnId)!=7)) or ((fn:length(ofer.cpnId)==0) and (fn:length(ofer.cstCpnId)!=7))}">color="#084B8A"</c:if>>
								- ${ofer.cpnNm}<c:if test="${empty ofer.cpnNm}">${ofer.cstCpnNm}</c:if><%-- ${ofer.cstNm}<c:if test="${empty ofer.cpnNm}">(${ofer.cstCpnNm})</c:if><c:if test="${not empty ofer.cpnNm and not empty ofer.cstCpnNm}">(${ofer.cstCpnNm})</c:if> --%>
							</font>
							<font color="green">${ofer.middleOfferNm }<c:if test="${empty ofer.middleOfferNm}"> ${ofer.offerNm}</c:if></font>
							<c:if test="${not empty ofer.realNm}"><img src="../images/file/files.png" align="absmiddle"></c:if>
						</div>
						<div class="nameNdate hov" onclick="checkMainTable(this.parentNode.parentNode,'1','${ofer.sNb}')"><small>&nbsp;X&nbsp;</small></div>
						<div class="nameNdate hov" onclick="memoDivNew(event,'${ofer.rgNm}');"><small>${ofer.rgNm} | '${fn:replace(fn:substring(ofer.tmDt,2,10),'-','.')}</small></div>
					</nobr>
				</ul>
				</c:if>

				</c:otherwise>
				</c:choose>

				</c:forEach>
			</div>
		</div>
	</div>
	<div class="line1">
		<!-- 업무일지>정보정리 -->
		<div class="frt_data">
	        <div class="mainBoxTitle"><span class="title">정보정리</span></div>
			<div class="frt_body">
				<c:forEach var="ofer" items="${offerList}" varStatus="status">

					<%-- ================== 권한에 따라 '*' 처리해야 하는 딜 건인지 변수(asterDeal) 에 저장 :S  ================== --%>
					<c:choose>
					<c:when test="${mezzL eq 'Y'}">
						<c:set var="asterDeal" value="N"/>
					</c:when>		<%-- 내가 등록한 딜이 아니면서 --%>		<%--             상장사 이고			 --%>		<%--						메자닌 (CB, EB, BW) 이고								 --%>		<%--						제안중이 아니고					 --%>		<%--	진행중 인 건		 --%>
					<c:when test="${ofer.rgId ne baseUserLoginInfo.loginId and ('A' eq ofer.cpnStts or 'Q' eq ofer.cpnStts) and (ofer.categoryCd eq '00001' or ofer.categoryCd eq '00002' or ofer.categoryCd eq '00003') and (ofer.middleOfferCd ne '00004' and ofer.middleOfferCd ne '00005') and ofer.progressCd eq '00001'}">
						<c:set var="asterDeal" value="Y"/>	<%-- 별표시(숨김) --%>
					</c:when>
					<c:otherwise>
						<c:set var="asterDeal" value="N"/>
					</c:otherwise>
					</c:choose>
					<%-- ================== 권한에 따라 '*' 처리해야 하는 딜 건인지 변수(asterDeal) 에 저장 :E  ================== --%>

					<ul class="mg0 pd0 hov bg${ofer.progressCd}" style="width:100%;overflow: hidden;">
						<nobr>
							<div class="mg0 hov" style="overflow:hidden;width:204px;float:left;padding:0 0 0 5px;"
							<c:choose>
								<c:when test="${(ofer.offerCd == '00006') or (ofer.offerCd == '00007') or (ofer.offerCd == '00013') }"> onclick="popUp('${ofer.tmDt}','rcmdComment','','${ofer.sNb}');"</c:when>
								<c:otherwise> onclick="statsOfferdivAjax(event,'${ofer.rgNm}',this.parentNode.parentNode,'${ofer.sNb}','${ofer.reportYN}')"</c:otherwise>
							</c:choose>
							>
								<font <c:if test="${((fn:length(ofer.cpnId)!=0) and (fn:length(ofer.cpnId)!=7)) or ((fn:length(ofer.cpnId)==0) and (fn:length(ofer.cstCpnId)!=7))}">color="#084B8A"</c:if>>
									-
									<c:choose><c:when test="${asterDeal eq 'Y'}">***</c:when><c:otherwise>${ofer.cpnNm}<c:if test="${empty ofer.cpnNm}">${ofer.cstCpnNm}</c:if></c:otherwise></c:choose>
									<%-- ${ofer.cstNm}<c:if test="${empty ofer.cpnNm}">(${ofer.cstCpnNm})</c:if><c:if test="${not empty ofer.cpnNm and not empty ofer.cstCpnNm}">(${ofer.cstCpnNm})</c:if> --%>
								</font>
								<font color="green">${ofer.middleOfferNm }<c:if test="${empty ofer.middleOfferNm}"> ${ofer.offerNm}</c:if></font>
								<c:if test="${not empty ofer.realNm}"><img src="../images/file/files.png" align="absmiddle"></c:if>
							</div>
							<div class="nameNdate hov" onclick="checkMainTable(this.parentNode.parentNode,'1','${ofer.sNb}')"><small>&nbsp;X&nbsp;</small></div>
							<div class="nameNdate hov" onclick="memoDivNew(event,'${ofer.rgNm}');"><small>${ofer.rgNm} | '${fn:replace(fn:substring(ofer.tmDt,2,10),'-','.')}</small></div>
						</nobr>
					</ul>

				</c:forEach>
			</div>
		</div>

		<!-- 정보정리>핵심>중요도 3,4,5 -->
		<div class="frt_keyPt">
	    	<div class="mainBoxTitle"><span class="title">정보정리 > 핵심체크</span></div>
			<!-- <span class="frt_title" style="float:right;"><font color="blue">3</font> 〈 <font color="orange">4</font> 〈 <font color="red">5</font></span> -->
			<div class="frt_body">
				<c:forEach var="kp" items="${keyPointList}" varStatus="stat"><c:set var="text" value="${kp.financing}"/>
				<ul class="mg0 pd0 hov bg${ofer.progressCd}" style="width:100%;overflow:hidden;">
					<nobr>
						<div class="mg0 hov" style="overflow:hidden;width:204px;float:left;padding:0 0 0 5px;" onclick="statsOfferdivAjax(event,'${kp.rgNm}',this.parentNode.parentNode,'${kp.sNb}','${kp.reportYN}')">
							<small style="color:navy;">${kp.categoryNm}</small>
							<font <c:choose>
								<c:when test="${kp.lvCd == '00002'}"> color='navy'</c:when>
								<c:when test="${kp.lvCd == '00003'}"> color='blue'</c:when>
								<c:when test="${kp.lvCd == '00004'}"> color='orange'</c:when>
								<c:when test="${kp.lvCd == '00005'}"> color='red'</c:when>
								<c:otherwise>color='#5A5A66'</c:otherwise></c:choose>
							>${kp.cpnNm}<c:if test="${empty kp.cpnNm}">${kp.cstCpnNm}</c:if> : ${text}</font>
						</div><div class="mg0 pd0" style="width:12px;float:left;color:#5A5A66;"><c:if test="${fn:length(text)>=12}">&nbsp;...</c:if></div>
						<div class="nameNdate hov" onclick="memoDivNew(event,'${kp.rgNm}');"><small>${kp.rgNm} | '${fn:replace(fn:substring(kp.tmDt,2,10),'-','.')}</small></div>
					</nobr>
				</ul>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="line4">
		<div class="frt_newNet">
	        <div class="mainBoxTitle"><span class="title">경력 / 네트워크</span></div>
			<div class="frt_body">
				<c:forEach var="net" items="${netList}"><c:if test="${net.netYn!= '인물수정' and net.netYn != '인물추가' }">
				<ul class="mg0 pd0 hov" style="width:100%;overflow:hidden;">
					<nobr>
						<div class="mg0 hov" style="overflow:hidden;width:204px;float:left;padding:0 0 0 5px;" onclick="popUp('','rcmdCst','','${net.snb1st}');" title="${net.position1st}"><small>${net.netYn}&nbsp;</small><font color="navy">&nbsp;${net.cstNm1st}&nbsp;</font><small>${net.cpnNm1st}</small></div>
						<div class="nameNdate hov" onclick="newCstNnetwork(this,'<c:if test="${net.netYn=='인물넷'}">3</c:if><c:if test="${net.netYn=='딜경력' or net.netYn=='법인넷'}">4</c:if>','${net.sNb}')"><small>&nbsp;X&nbsp;</small></div>
						<div class="mg0 hov" style="overflow:hidden;width:204px;float:left;padding:0 0 0 5px;" <c:if test="${not empty net.cstNm2nd}">onclick="popUp('','rcmdCst','','${net.snb2nd}');"</c:if> <c:if test="${empty net.cstNm2nd}">onclick="popUp('','rcmdCpn','','${net.snb2nd}');"</c:if> title="${net.position2nd}"><small style="visibility:hidden;">${net.netYn}&nbsp;</small><font color="navy">&nbsp;${net.cstNm2nd}<c:if test="${empty net.cstNm2nd}">${net.cpnNm2nd}</c:if>&nbsp;</font><c:if test="${not empty net.cstNm2nd}"><small>${net.cpnNm2nd}</small></c:if></div>
						<div class="nameNdate hov" onclick="memoDivNew(event,'${net.rgNm}');"><small>${net.rgNm} | '${fn:replace(fn:substring(net.rgDt,2,10),'-','.')}</small></div>
					</nobr>
				</ul></c:if>
				</c:forEach>
			</div>
		</div>
		<!-- 신규인물정보 -->
		<%-- <div class="frt_newCst">
	        <div class="mainBoxTitle"><span class="title">인물추가 / 수정</span><span class="btnZone"><a href="javascript:popUpNew('_0','new_person','${cst.cstNm}','${cst.sNb}');"><img src="../images/main/btn_add_st03.gif" alt="추가"/></a><a href="javascript:goMenuPerson();"><img src="../images/main/btn_more_st03.gif" alt="더보기"/></a></span></div>
			<div class="frt_body hov">
				<c:forEach var="net" items="${netList}"><c:if test="${net.netYn == '인물수정' or net.netYn == '인물추가' }">
				<ul class="mg0 pd0 hov" style="width:100%;overflow:hidden;">
					<nobr>
						<div class="mg0 hov" onclick="newCstNnetwork(this,'2','${net.sNb}');" title="${net.position1st}" style="overflow:hidden;width:204px;float:left;padding:0 0 0 5px;"><small>${fn:split(net.netYn,'인물')[0]}</small><font color="navy">&nbsp;${net.cstNm1st}&nbsp;</font><small>${net.cpnNm1st}</small></div>
						<div class="nameNdate hov" onclick="newCstNnetwork(this,'2','${net.sNb}','no')"><small>&nbsp;X&nbsp;</small></div>
						<div class="nameNdate hov" onclick="memoDivNew(event,'${net.rgNm}');"><small>${net.rgNm} | '${fn:replace(fn:substring(net.rgDt,2,10),'-','.')}</small></div>
					</nobr>
				</ul></c:if>
				</c:forEach>
			</div>
		</div> --%>
	</div>
	<div class="line3">
		<!-- 코멘트 -->
		<div class="frt_cmnt">
	        <div class="mainBoxTitle"><span class="title">코멘트</span></div>
			<div class="frt_body">
				<c:forEach var="rp" items="${replyList}" varStatus="memoS">

					<%-- ================== 권한에 따라 '*' 처리해야 하는 딜 건인지 변수(asterDeal) 에 저장 :S  ================== --%>
					<c:choose>
					<c:when test="${mezzL eq 'Y'}">
						<c:set var="asterDeal" value="N"/>
					</c:when>		<%-- 내가 등록한 딜이 아니면서 --%>		<%--             상장사 이고			 --%>		<%--						메자닌 (CB, EB, BW) 이고								 --%> <%--	진행중 인 건		 --%>	<%--						제안중이 아니고					 --%>
					<c:when test="${rp.offerRgId ne baseUserLoginInfo.loginId and ('A' eq rp.cpnStts or 'Q' eq rp.cpnStts) and (rp.categoryCd eq '00001' or rp.categoryCd eq '00002' or rp.categoryCd eq '00003') and rp.progressCd eq '00001'}">	<%-- and (rp.middleOfferCd ne '00004' and rp.middleOfferCd ne '00005') --%>
						<c:set var="asterDeal" value="Y"/>	<%-- 별표시(숨김) --%>
					</c:when>
					<c:otherwise>
						<c:set var="asterDeal" value="N"/>
					</c:otherwise>
					</c:choose>
					<%-- ================== 권한에 따라 '*' 처리해야 하는 딜 건인지 변수(asterDeal) 에 저장 :E  ================== --%>

					<ul class="mg0 pd0 hov" style="width:100%;overflow: hidden;">
						<nobr>
							<div class="mg0 hov" style="overflow:hidden;width:190px;float:left;padding:0 0 0 5px;" onclick="popUp('${rp.rgDt}','rcmdComment','','${rp.offerSnb}');">
								<font color="navy">
								<c:choose><c:when test="${asterDeal eq 'Y'}">***</c:when><c:otherwise>${rp.cpnNm}</c:otherwise></c:choose>
								</font>
								<font color="green">${rp.categoryNm}</font> <font color="#5A5A66" title="${rp.comment}">${rp.comment}</font>
							</div>

							<div class="mg0 pd0" style="width:12px;float:left;color:#5A5A66;"><c:if test="${fn:length(rp.comment)>=12}">&nbsp;...</c:if></div>
							<div class="nameNdate hov" onclick="checkMainTable(this.parentNode.parentNode,'5','${rp.sNb}')"><small>&nbsp;X&nbsp;</small></div>
							<div class="nameNdate hov" onclick="memoDivNew(event,'${rp.rgNm}');"><small>${rp.rgNm} | '${fn:replace(fn:substring(rp.rgDt,2,10),'-','.')}</small></div>
						</nobr>
					</ul>

				</c:forEach>
			</div>
		</div>
		<!-- 메모 -->
		<%--
		<div class="frt_memo">
			<span class="frt_title">주요업무</span>
			<div class="frt_body">
				<c:forEach var="memo" items="${majorMemoList}" varStatus="memoS">
				<ul class="mg0 pd0 hov<c:if test="${baseUserLoginInfo.userName != memo.cstNm}"> bgRed</c:if>" style="width:100%;overflow:hidden;">
					<nobr>
						<div class="mg0 hov clr${memo.importance}" onclick="memoDivAjax(this,event,'${memo.sNb}'<c:if test="${memo.sttsCd=='00001' or memo.sttsCd=='00002'}">,'${memo.mainSnb}'</c:if>);" style="overflow:hidden;width:204px;float:left;padding:0 0 0 5px;"> - ${memo.comment}</div>
						<c:if test="${baseUserLoginInfo.userName != memo.cstNm}"><div class="nameNdate hov" onclick="newCstNnetwork(this,'5','${memo.sNb}','no');"><small>&nbsp;X&nbsp;</small></div></c:if>
						<div class="nameNdate"><small><c:choose><c:when test="${baseUserLoginInfo.userName != memo.cstNm}">${memo.cstNm}</c:when><c:otherwise>내메모</c:otherwise></c:choose> | '${fn:replace(fn:substring(memo.tmDt,2,10),'-','.')}</small></div>
					</nobr>
				</ul>
				</c:forEach>
			</div>
		</div>
		--%>
		<!-- 업무전달(메모) -->
		<div class="frt_majorMemo">
	        <div class="mainBoxTitle"><span class="title">업무전달 (메모) <a href="javascript:openMemoSearchPop();" style="float:right;"><img src="<c:url value='/images/work/btn_memo_search.jpg' />"  style="vertical-align:bottom;" title="메모상세보기"></a></span><!-- <span class="btnZone"><a href="javascript:memoDivAjax_new(this,event,'0','0');"><img src="../images/main/btn_add_st04.gif" alt="추가"/></a></span> --></div>
			<div class="frt_body">
				<c:forEach var="memo" items="${memoList}" varStatus="memoS">
				<ul class="mg0 pd0 hov<c:if test="${baseUserLoginInfo.userName != memo.cstNm}"> bgRed</c:if>" style="width:100%;overflow:hidden;">
					<nobr>
						<div class="mg0 hov clr${memo.importance}" style="overflow:hidden;width:200px;float:left;padding:0 0 0 5px;" onclick="memoDivAjax(this,event,'${memo.sNb}'<c:if test="${memo.sttsCd=='00001' or memo.sttsCd=='00002'}">,'${memo.mainSnb}'</c:if>);" >
							<c:choose>
							<c:when test="${fn:substring(memo.tmDt,0,10) eq cur_day or fn:substring(memo.rgDt,0,10) eq cur_day}">
								<img src="<c:url value='/images/n.gif'/>">
							</c:when>
							<c:otherwise></c:otherwise>
							</c:choose>
							<c:if test="${memo.priv eq 'Y'}"><b><font style="background:#FAAC58;">[S]</font></b> ******</c:if>
							<c:if test="${memo.priv ne 'Y'}">${memo.comment}</c:if>
						</div>

						<div class="mg0 pd0" style="width:12px;float:left;color:#5A5A66;"><c:if test="${fn:length(memo.comment)>=20}">&nbsp;...</c:if></div>
						<%-- <div class="mg0 pd0" style="width:12px;float:left;<c:if test="${memo.importance == '1'}">color:blue;</c:if><c:if test="${memo.importance == '2'}">color:red;</c:if>"><c:if test="${fn:length(memo.comment)>=20}">&nbsp;...</c:if></div> --%>
						<%-- <c:if test="${baseUserLoginInfo.userName != memo.cstNm}"><div class="nameNdate hov" onclick="newCstNnetwork(this,'5','${memo.sNb}','no');"><small>&nbsp;X&nbsp;</small></div></c:if> --%>
						<div class="nameNdate"><small><c:choose><c:when test="${baseUserLoginInfo.userName != memo.cstNm}">${memo.cstNm}</c:when><c:otherwise>내메모</c:otherwise></c:choose> | '${fn:replace(fn:substring(memo.tmDt,2,10),'-','.')}</small></div>
					</nobr>
				</ul>
				</c:forEach>
			</div>
		</div>
	</div>

</body>
</html>