<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<link href="<c:url value='/css/new_sis.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/main.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/images/ibB.ico' />" rel="shortcut icon" type="image/x-icon">
<link href="<c:url value='/css/memo.css'/>" rel="stylesheet" type="text/css">

<script type="text/JavaScript" src="<c:url value='/js/html5.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/jquery.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/process.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/part/popUp.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/part/memo.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/work.js'/>" ></script>
<script>

$(document).ready(function(){
	//파일 다운로드
	var height = document.documentElement.clientHeight || window.innerHeight || document.body.clientHeight;
	//console.debug(height);
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

	parent.resize_iframe();
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
		parent.mainFrame.location.replace("mainSisLogo.do");
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
	var clickSentence = th;
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

//메모 내용수정 확인
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
		w='650';
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
select{font-size:11px;}
.mainDataLayout{border-radius:5px;box-shadow:2px 2px 10px#888888;margin:0 auto;}
.mainDataLayoutTitle{text-align:center;padding:10px 0;border-radius:5px 5px 0 0;}
.title_areaS{width:400px;}
.title_areaS ul{padding:7px;margin:0;list-style:none;min-width:390px;border-radius:5px;}
.popUpMenu{display:none;position:absolute;z-index:9999;background-color:#ECEADF;border:1px solid hsl(0,0%,79%);border-radius:4px;box-shadow:0 2px 6px hsla(0,0%,0%,0.25);color:hsl(0,0%,20%);font-size:12px;}
.popUpMenu .closePopUpMenu:hover{margin:0;text-align:left;cursor:pointer;background-color:#666666;}
.popUpMenu select,.popUpMenu input{border:1px solid gray;border-radius:2px;}
.popUpMenu input{font-size:0.95em;padding:2px 1px 2px 2px;}
.title_area{width:530px;}
.title_area ul{padding:7px;margin:0;list-style:none;min-width:420px;border-radius:5px;}
.popUpTitle_area ul{padding:7px;margin:0;list-style:none;min-width:320px;list-style:none;}
.overFlowHidden{width:98%;overflow:hidden;}
.title,.c_title,.cpnNm,.bold{font-weight:bold;}
.c_title{line-height:18px;vertical-align:middle;}
.c_note{color:gray;line-height:150%;min-height:180px;}
.mini_c_note{color:gray;line-height:150%;}
textarea{resize:none; min-height: 180px; }
.bsnsR_btn{margin:0;text-align:center;}.t_note{margin:0;color:gray;font-size:12px;}
.v-textarea{background-color:white;border:1px solid#AFAFAF;width:504px;margin-top:2px;padding:2px;}
textarea,.c_note,.m_note{font-size:12px;width:500px;}.bgRed {background-color: #F6CECE !important;}
a img{cursor:pointer;}

.mg0 {	margin:0 !important;}.pd0 {	padding:0 !important;}html, body{	height:100%;	background-color:beige;}


.frt_data, .frt_cmnt, .frt_mna, .frt_cbeb, .frt_prjt, .frt_memo, .frt_majorMemo, .frt_keyPt, .frt_newCst, .frt_newNet, .frt_idea, .frt_ipo{ border: 1px solid gray; border-radius:5px; background-color:white;overflow-y:auto;}
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


#offerPr li { text-align:left; }
#offerPr div{ text-align:left; }
#offerPr textarea { text-align:left; border:#bfbfbf solid 1px; padding:2px; margin-bottom:5px; line-height:150%; }
.M_basicInfoR {text-align:center!important; }

</style>
</head>
	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>
<c:set var="now" value="<%= new java.util.Date() %>"/>
<fmt:formatDate var="cur_day" value='${now}' pattern='yyyy-MM-dd'/>

<body>

<input type="hidden" id="pageName" value="MainLogo">
<input type="hidden" id="rgstId" value="<c:out value='${baseUserLoginInfo.loginId}'/>">
<form id="downName" name="downName" action="<c:url value='/work/downloadProcess.do' />" method="post">
	<input type="hidden" name="makeName" id="makeName"/>
	<input type="hidden" name="recordCountPerPage" value="0"/>
</form>
<div id="offerDiv"><div id="offerPr" style="display: none;"></div></div>
<div id="containerWarp">
	<div id="container">
		<div id="mainConBox">
			<!--정보정리-->
            <article>
            <div class="conBox">
            	<h3 class="title">정보정리</h3>
            	<div class="scrollBox">
            	<table class="main_info_tb" summary="정보정리 (구분, 내용, 등록자, 등록일안내)">
		 		<caption>정보정리</caption>
		  		<colgroup>
            		<col width="60" />
                    <col width="*" />
                    <col width="40" />
                    <col width="40" />
                    <col width="20" />
				</colgroup>
				<thead>
                <tr>
                	<th scope="col">구분</th>
                    <th scope="col">내용</th>
                    <th scope="col">등록자</th>
                    <th scope="col">등록일</th>
                    <th scope="col">삭제</th>
				</tr>
                </thead>
                <tbody>
				<c:forEach var="ofer" items="${offerList}" varStatus="status">


				<tr>
					<th scope="row" class="gtype">${ofer.middleOfferNm }<c:if test="${empty ofer.middleOfferNm}"> ${ofer.offerNm}</c:if></th>

					<td>
						<div onclick="statsOfferdivAjax(event,'${ofer.rgNm}',this.parentNode.parentNode,'${ofer.sNb}','${ofer.reportYN}')" class="contxt" style="cursor:pointer;"><c:if test="${not empty ofer.realNm}"><span class="icon_new"><em>new</em></span></c:if>${ofer.cstCpnNm}</div>
					</td>
					<td class="writer"><div onclick="memoDivNew(event,'${ofer.rgNm}');" style="cursor:pointer;">${ofer.rgNm}</div></td>
                    <td class="date">${fn:replace(fn:substring(ofer.tmDt,2,10),'-','.')}</td>
                    <td class="btntd"><div onclick="newCstNnetwork(this,'1','${ofer.sNb}', 'no');" class="btn_delete_con" style="cursor:pointer;"><em>삭제</em></a></td>
				</tr>
				</c:forEach>
				</tbody>
				</table>
			</div>
			</div>
			</article>

			<article>
            <div class="conBox">
            	<h3 class="title">코멘트</h3>
            	<div class="scrollBox">
            	<table class="main_info_tb" summary="정보정리 (구분, 내용, 등록자, 등록일안내)">
		 		<caption>코멘트</caption>
		  		<colgroup>
                        <col width="55" />
                        <col width="*" />
                        <col width="45" />
                        <col width="45" />
                        <col width="20" />
                    </colgroup>
				<thead>
                <tr>
                	<th scope="col">구분</th>
                    <th scope="col">내용</th>
                    <th scope="col">등록자</th>
                    <th scope="col">등록일</th>
                    <th scope="col">삭제</th>
				</tr>
                </thead>
                <tbody>
				<c:forEach var="rp" items="${replyList}" varStatus="memoS">
				<tr>
					<th scope="row" class="gtype">
						<font color="navy">${rp.cpnNm}</font>
					</th>
					<td>
					<div onclick="javascript:popUp('${rp.rgDt}','rcmdComment','','${rp.offerSnb}');" class="contxt" style="cursor:pointer;"><span class="pointG">${rp.cpnNm}</span>${rp.comment}</div>

	                <td class="writer"><div onclick="memoDivNew(event,'${rp.rgNm}');" style="cursor:pointer;">${rp.rgNm}</div></td>
	                <td class="date">${fn:replace(fn:substring(rp.rgDt,2,10),'-','.')}</td>
	                <td class="btntd"><div onclick="newCstNnetwork(this,'5','${rp.sNb}', 'no');" class="btn_delete_con" style="cursor:pointer;"><em>삭제</em></a></td>
				</tr>
				</c:forEach>
				</tbody>
				</table>
			</div>
			</div>
			</article>



			<article>
            <div class="conBox">
            	<h3 class="title">프리IPO</h3>
            	<a href="javascript:goMenuByMoreBtn('${pageContext.request.contextPath}/work/selectWorkAllDeal.do', '00012');" class="btn_more">더보기</a>

            	<div class="scrollBox">
            	<table class="main_info_tb" summary="정보정리 (구분, 내용, 등록자, 등록일안내)">
		 		<caption>프리IPO</caption>
		  		<colgroup>
            		<col width="30" />
                    <col width="*" />
                    <col width="45" />
                    <col width="45" />
                    <col width="20" />

				</colgroup>
				<thead>
                <tr>
                	<th scope="col">구분</th>
                    <th scope="col">내용</th>
                    <th scope="col">등록자</th>
                    <th scope="col">등록일</th>
                    <th scope="col">삭제</th>
				</tr>
                </thead>
                <tbody>

				<c:forEach var="ofer" items="${offerList4}" varStatus="status"><c:if test="${ofer.categoryCd == '00012'}">

				<tr>
					<th scope="row" class="gtype">${ofer.middleOfferNm }<c:if test="${empty ofer.middleOfferNm}"> ${ofer.offerNm}</c:if></th>
					<td>
						<div onclick="statsOfferdivAjax(event,'${ofer.rgNm}',this,'${ofer.sNb}','${ofer.reportYN}');" class="contxt" style="cursor:pointer;"><c:if test="${not empty ofer.realNm}"><span class="icon_new"><em>new</em></span></c:if>${ofer.cstCpnNm}</div>
					</td>
	                   <td class="writer"><div onclick="memoDivNew(event,'${ofer.rgNm}');" style="cursor:pointer;">${ofer.rgNm}</div></td>
	                   <td class="date">${fn:replace(fn:substring(ofer.tmDt,2,10),'-','.')}</td>
	                   <td class="btntd"><div onclick="newCstNnetwork(this,'1','${ofer.sNb}','no');" class="btn_delete_con" style="cursor:pointer;"><em>삭제</em></div></td>
				</tr>

				</c:if>
				</c:forEach>
				</tbody>
				</table>
			</div>
			</div>
			</article>


			<article>
            <div class="conBox">
            	<h3 class="title">정보정리 - 핵심체크</h3>
            	<div class="scrollBox">
            	<table class="main_info_tb" summary="정보정리 (구분, 내용, 등록자, 등록일안내)">
		 		<caption>정보정리 - 핵심체크</caption>
		  		<colgroup>
            		<col width="70" />
                    <col width="*" />
                    <col width="45" />
                    <col width="45" />
                    <col width="20" />
				</colgroup>
				<thead>
                <tr>
                	<th scope="col">구분</th>
                    <th scope="col">내용</th>
                    <th scope="col">등록자</th>
                    <th scope="col">등록일</th>
                    <th scope="col">삭제</th>
				</tr>
                </thead>
                <tbody>
				<c:forEach var="kp" items="${keyPointList}" varStatus="stat"><c:set var="text" value="${kp.financing}"/>


				<tr>
					<th scope="row" class="gtype">${kp.categoryNm}</th>
					<td><div onclick="statsOfferdivAjax(event,'${kp.rgNm}',this.parentNode,'${kp.sNb}','${kp.reportYN}');" class="contxt" style="cursor:pointer;"><span <c:choose>
							<c:when test="${kp.lvCd == '00002'}"> class='point01'</c:when>
							<c:when test="${kp.lvCd == '00003'}"> class='point02'</c:when>
							<c:when test="${kp.lvCd == '00004'}"> class='point03'</c:when>
							<c:when test="${kp.lvCd == '00005'}"> class='point04'</c:when>
							<c:otherwise> class='point05'</c:otherwise></c:choose>
						>${kp.cpnNm}<c:if test="${empty kp.cpnNm}">${kp.cstCpnNm}</c:if> : ${text}</span></div></td>

                    <td class="writer"><div onclick="memoDivNew(event,'${kp.rgNm}');" style="cursor:pointer;">${kp.rgNm}</div></td>
                    <td class="date">${fn:replace(fn:substring(kp.tmDt,2,10),'-','.')}</td>
                    <td class="btntd"><div onclick="newCstNnetwork(this.parentNode,'1','${kp.sNb}', 'no');" class="btn_delete_con"><em>삭제</em></div></td>
				</tr>

				</nobr>
				</ul>
				</c:forEach>
				</tbody>
				</table>



			</div>
			</div>
			</article>


			<%-- <article>
            <div class="conBox">
            	<h3 class="title">인물추가/수정</h3>
            	<a href="javascript:popUpNew('_0','new_person','${cst.cstNm}','${cst.sNb}');" class="btn_add"></a>
            	<a href="javascript:goMenuPerson();" class="btn_more">더보기</a>
            	<div class="scrollBox">
            	<table class="main_info_tb" summary="정보정리 (구분, 내용, 등록자, 등록일안내)">
		 		<caption>인물추가/수정</caption>
		  		<colgroup>
            		<col width="30" />
                    <col width="*" />
                    <col width="45" />
                    <col width="45" />
                    <col width="20" />
				</colgroup>
				<thead>
                <tr>
                	<th scope="col">구분</th>
                    <th scope="col">내용</th>
                    <th scope="col">등록자</th>
                    <th scope="col">등록일</th>
                    <th scope="col">삭제</th>
				</tr>
                </thead>
                <tbody>
				<c:forEach var="net" items="${netList}"><c:if test="${net.netYn == '인물수정' or net.netYn == '인물추가' }">
					<tr >

					<th scope="row" class="gtype">${fn:split(net.netYn,'인물')[0]}</th>
					<td><div onclick="newCstNnetwork(this,'2','${net.sNb}');" class="gtype" style="cursor:pointer;"><span class="pointG">${net.cstNm1st}</span>${net.cpnNm1st}</div></td>
                    <td class="writer"><div onclick="memoDivNew(event,'${net.rgNm}');" style="cursor:pointer;">${net.rgNm}</div></td>
                    <td class="date">${fn:replace(fn:substring(net.rgDt,2,10),'-','.')}</td>
                    <td class="btntd"><div onclick="newCstNnetwork(this,'2','${net.sNb}','no');" class="btn_delete_con" style="cursor:pointer;"><em>삭제</em></div></td>
					</tr>
				</c:if>
				</c:forEach>
				</tbody>
				</table>
			</div>
			</div>
			</article> --%>


			<article>
            <div class="conBox">
            	<h3 class="title">메모</h3>
            	<div class="scrollBox">
            	<table class="main_info_tb" summary="메모">
		 		<caption>메모</caption>

		  		<colgroup>
                    <col width="*" />
                    <col width="45" />
                    <col width="45" />
                    <col width="20" />
				</colgroup>
				<thead>

                <tr>
                    <th scope="col">내용</th>
                    <th scope="col">등록자</th>
                    <th scope="col">등록일</th>
                    <th scope="col">삭제</th>
				</tr>
                </thead>
                <tbody>

				<c:forEach var="memo" items="${memoList}" varStatus="memoS">



				<tr>
					<td class="memotxt">
                        <div onclick="memoDivAjax(this.parentNode.parentNode,event,'${memo.sNb}'<c:if test="${memo.sttsCd=='00001' or memo.sttsCd=='00002'}">,'${memo.mainSnb}'</c:if>);" style="cursor:pointer;">
                            <c:choose>
                                <c:when test="${fn:substring(memo.tmDt,0,10) eq cur_day or fn:substring(memo.rgDt,0,10) eq cur_day}"><span class="icon_new"><em>new</em></span></c:when>
                                <c:otherwise></c:otherwise>
                            </c:choose>${memo.comment}
                        </div>
                	</td>
					<%--<td class="memotxt"><span>${ofer.middleOfferNm }<c:if test="${empty ofer.middleOfferNm}"> ${ofer.offerNm}</c:if></span></td>--%>


					<%--<td><div onclick="statsOfferdivAjax(event,'${ofer.rgNm}',this.parentNode,'${ofer.sNb}','${ofer.reportYN}');" class="contxt" style="cursor:pointer;"><c:if test="${not empty ofer.realNm}"><span class="icon_new"><em>new</em></span></c:if>${ofer.cstCpnNm}</div></td>--%>
                    <!--  <td class="writer"><div onclick="memoDivNew(event,'${memo.rgNm}');" style="cursor:pointer;">${memo.rgNm}</div></td> -->
                    <td class="writer">
                    	<div >
							<c:choose><c:when test="${baseUserLoginInfo.userName != memo.cstNm}">${memo.cstNm}</c:when><c:otherwise>내메모</c:otherwise></c:choose>
						</div>
					</td>
                    <td class="date">${fn:replace(fn:substring(memo.tmDt,2,10),'-','.')}</td>
                    <td class="btntd"><div onclick="newCstNnetwork(this,'5','${memo.sNb}','no');" class="btn_delete_con" style="cursor:pointer;"><em>삭제</em></div></td>
				</tr>


				</c:forEach>
				</tbody>
				</table>
			</div>
			</div>
			</article>
		</div>
	</div>
</div>
</body>
</html>




<script type="text/javascript">

var fnObj = {
		doLoadInfoArrange: function (){

		}
}

</script>