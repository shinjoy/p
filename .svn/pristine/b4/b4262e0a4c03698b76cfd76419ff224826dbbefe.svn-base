<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="<c:url value='/js/base.js'/>" type="text/JavaScript"></script>
<script>
$(function(){
	changeHeight();
});

$(window).resize(function(){
	changeHeight();
}).resize();

//창 크기가 너무 작을 경우 테이블이 보이지 않아 처리
function changeHeight(){
	var calHeight= $(window).height();
	var calWidth = $('#admin_table').width();
	calHeight = calHeight - 275;
	if(calHeight < 100)
		$("#admin_div").css("height",250);
	else
		$("#admin_div").css("height",calHeight);
}

function viewDiv(divId, th){
	$("#"+divId).css('display','block');
	
}
function sortTable(flag){
	if(flag == 'total') $("#total").val(flag);
	else $("#sorting").val(flag);
	document.modifyRec.submit();
}
function kyPsrtCd(th){
	var obj = $(th)
	  , TD1st = obj.parent().parent();
	TD1st.addClass('bgRed');
}
function changePmsn(th){
	var obj = $(th)
	  , TD1st = obj.parent().parent();
	TD1st.addClass('bgRed');
	obj.removeClass();
	obj.addClass('bgP'+obj.val());
	//obj.parent().find('input').val(obj.val());
}
function changeOffice(th){
	var obj = $(th)
	  , TD1st = obj.parent().parent();
	TD1st.addClass('bgRed');
	obj.removeClass();
	//obj.parent().find('input').val(obj.val());
}
function reSetPw(snb){
	var DATA = {sNb: snb}
	  , url = "../control/reSetPw.do"
	  , fn = function(){ 
		alert("로그인 비밀번호가 '1234'로 초기화되었습니다.");
		document.modifyRec.submit();
	};
	ajaxModule(DATA,url,fn);
}
function setResign(snb){
	var DATA = {sNb: snb}
	  , url = "../control/setResign.do"
	  , fn = function(){ 
		alert("퇴사 처리되었습니다.");
		document.modifyRec.submit();
	};
	ajaxModule(DATA,url,fn);
}
function saveStaffInfo(snb){
	
	var DATA = {
		 sNb   :		$('input[name=sNb' + snb + ']').val()
		,usrNm : 		$('input[name=usrNm' + snb + ']').val()
		,position : 	$('input[name=position' + snb + ']').val()
		,division : 	$('select[name=division' + snb + ']').val()
		,usrId : 		$('input[name=usrId' + snb + ']').val()
		,office: 		$('select[name=office' + snb + ']').val()
		,srtCd : 		$('input[name=srtCd' + snb + ']').val()
		,statSeq : 		$('input[name=statSeq' + snb + ']').val()
		,permission: 	$('select[name=permission' + snb + ']').val()
		,cstId : 		$('input[name=cstId' + snb + ']').val()
		,deptId  :		$('select[name=dept' + snb + ']').val()
	};
	
	var url = "../control/modifyStaffInfo.do";
	var fn = function(){
			alert(" '"+DATA.usrNm+"' 의 정보가 수정되었습니다.");
			document.modifyRec.submit();
		};
	
	ajaxModule(DATA,url,fn);
}
function saveStaffInfo0000000000(th){
	var obj = $(th)
	  , inputLeng = obj.parent().parent().find('input').length
	  , input = obj.parent().parent()
	  , snb = 0, usrNm = '', usrId = '', office = '', srtCd = '', permission = '', cstId = '';
	
	for(var i=0;i<inputLeng;i++){
		var inputCur = input.find('input:eq('+i+')');
		// alert("i="+i+";input="+inputCur.val());
		switch(i){
		case 0: snb 		= inputCur.val(); break;
		case 1: usrNm 		= inputCur.val(); break;
		case 2: usrId 		= inputCur.val(); break;
		case 3: office 		= inputCur.val(); break;
		case 4: srtCd 		= inputCur.val(); break;
		case 5: permission 	= inputCur.val(); break;
		case 6: cstId 		= inputCur.val(); break;
		default: break;
		}
	}
	var DATA = {
		sNb: snb
		,usrNm: usrNm
		,usrId: usrId
		,office: office
		,srtCd: srtCd
		,permission: permission
		,cstId: cstId
	}
	  , url = "../control/modifyStaffInfo.do"
	  , fn = function(){ 
		alert(" '"+usrNm+"' 의 정보가 수정되었습니다.");
		document.modifyRec.submit();
	};
	ajaxModule(DATA,url,fn);
}
function updateSabun(th){
	var obj = $(th).parent().parent().find('input:eq(1)');
	var data = {usrNm:obj.val()}
		, url = "../control/updateIBstaffwithInside.do"
		, fn = function(){
		alert(" '"+obj.val()+"' 의 정보가 수정되었습니다.");
		document.modifyRec.submit();
	};
	ajaxModule(data,url,fn);
}
function saveStaff(th){
	var obj = $(th).parent().parent()
	, name = obj.find('input[name*=usrNm]')
	, id = obj.find('input[name*=usrId]')
	, phn = obj.find('input[name*=phn1]')
	;
	obj.find('input').removeClass();
	if( name.val().is_null() ){
		name.addClass('bgRed');
		name.focus();
		alert("이름을 입력하세요.");
		return;
	}
	else if( id.val().is_null() ){
		id.addClass('bgRed');
		id.focus();
		alert("id을 입력하세요.");
		return;
	}
	else if( phn.val().is_null() ){
		phn.addClass('bgRed');
		phn.focus();
		alert("휴대폰을 입력하세요.");
		return;
	}
		
	document.addStaff.submit();
	
}

</script>
<style>
	
#wrap {
	background-color: #fff;
}

p {
	font-size: 11px;
}

tbody tr td, thead tr th {
	padding: 2px !important;
}

input, select {
	border: 1px dotted #F08080;
	width: 100%;
	height: 100%;
}

tbody tr:hover {
	background-color: moccasin !important;
}

.bgP00001 {
	background-color: silver !important;
}

.bgP00005 {
	background-color: #BBBBFF !important;
}

.bgP00013, .bgP00014 {
	background-color: yellowgreen !important;
}

.bgP00015 {
	background-color: #D0DAB1 !important;
}

.bgP00016 {
	background-color: #F0DAF1 !important;
}

.bgP00017 {
	background-color: #70d6f9 !important;
}

.bgP00020 {
    background-color: khaki !important;
}
select, td select {
    margin: 0;
    padding: 0;
    font-family: 맑은 고딕, Trebuchet MS, Verdana, Geneva, sans-serif;
    font-size: 11px;
    border: 1px solid #DDDDDD;
    border-radius: 2px;
}
.bgP00021 {
	background-color: #ff9999 !important;
}
/* .bgP00011{background-color: steelblue !important;} */
/*.bgS00001,.bgS00002,.bgS00003,.bgS00004,.bgS00005,.bgS00006,.bgS00007,.bgS00008,.bgS00009,.bgS00010,
.bgS00011,.bgS00012,.bgS00013,.bgS00014,.bgS00015,.bgS00016,.bgS00017,.bgS00018,.bgS00019,.bgS00020,
.bgS00021{background-color: peachpuff !important;}*/
.bgS201 {
	background-color: silver !important;
}

.bgS00000 {
	background-color: silver !important;
}

.bgS10000 {
	background-color: gray !important;
}

.bgDivSYNERGY {
	background-color: #efe4c6 !important;
}

.nameDInput {
	text-align: center;
	width: 40px;
}

.cpnDInput {
	text-align: center;
	width: 55px;
}

.companyNameInput {
	text-align: center;
	width: 85px;
}

div.subTabon {
	cursor: pointer;
	background: url(../images/cssimg/malis5tabon.gif) no-repeat;
	color: #202020;
	font-weight: bold;
	float: left;
	width: 90px;
	height: 26px;
	line-height: 29px;
	text-align: center;
	display: block;
	position: relative;
	z-index: 1;
	font-family: "NanumGothic", 맑은 고딕, "돋움", Dotum, "굴림", Gulim, arial,
		sans-serif;
}

.addTableTitle {
	width: 50px;
	display: inline-block;
}

.addStf {
	width: 300px;
	margin-left: 40px;
    margin-top: 97px;
}

.addStf ul {
	padding: 10px;
	margin: 0;
	list-style: none; /* ul 점 없애기 */
	background-color: #fff;
}

.addStf ul li {
	padding: 2px;
}

.addStf ul li input {
	height: 20px;
	width: 180px;
}

.addStf ul li select {
	height: 25px;
	width: 185px;
}

.width120 {
	width: 120px;
}

.width200 {
	width: 200px;
}

.popUpMenu {
	display: none;
	position: absolute;
	z-index: 9999;
	background-color: #ECEADF;
	border: 1px solid hsl(0, 0%, 79%);
	border-radius: 4px;
	box-shadow: 0 2px 6px hsla(0, 0%, 0%, 0.25);
	color: hsl(0, 0%, 20%);
}

.popUpMenu .closePopUpMenu {
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

.popUpMenu input, .popUpMenu textarea {
	/* font-size: 0.95em; */
	padding: 2px 1px 2px 2px;
}

.popUpMenu select, .popUpMenu input, .popUpMenu textarea {
	border: 1px solid gray;
	border-radius: 2px;
}

/*네트워크리스트*/
.widescroll_wrap {
	width: 100%;
	min-width: 1350px;
}

.scroll_header {
	overflow-y: scroll;
	overflow-x: hidden;
}

.scroll_body {
	max-height: 550px;
	overflow-y: scroll;
	overflow-x: hidden;
}

.network_st_box {
	position: relative;
	border-top: #868d97 solid 2px;
	border-left: #b9c1ce solid 1px;
	border-right: #b9c1ce solid 1px;
	border-bottom: #b9c1ce solid 1px;
}

.network_st_box .scroll_cover {
	position: absolute;
	right: 0px;
	top: 0px;
	z-index: 10;
	background: #dfe3e8;
	width: 17px;
	height: 50px;
	border-bottom: #b1b5ba solid 1px;
	*width: 16px;
	*height: 49px;
}

.network_tb_st {
	letter-spacing: -0.1px;
	width: 100%;
	overflow: auto;
	width: 100%;
	*width: 99%;
}

.network_tb_st caption {
	display: none;
}

.network_tb_st thead th {
	background: #dfe3e8;
	font-weight: normal;
	color: #33383f;
	line-height: 1.4;
	padding: 3px 3px 3px;
	text-align: center;
	border-right: #b9c1ce solid 1px;
	border-bottom: #b1b5ba solid 1px;
	font-size: 13px;
	vertical-align: middle;
	letter-spacing: -0.05em;
}

.network_tb_st thead th a {
	color: #33383f;
	font-size: 13px;
}

.network_tb_st tbody td {
	border-right: #dadcdd solid 1px;
	border-bottom: #dadada solid 1px;
	vertical-align: top;
	text-align: center;
	font-size: 12px;
	line-height: 1.4;
	color: #636c7f;
	letter-spacing: 0px;
	padding: 3px 10px 3px;
	*padding: 3px 3px 3px !important;
}

.network_tb_st td:first-child, .network_tb_st th:first-child {
	border-left: none;
}

.network_tb_st tr:first-child td {
	border-top: none;
}

.network_tb_st tbody tr:nth-child(2n) {
	background: #f7f7f7;
}

.network_tb_st tbody tr:hover {
	background: #f0f0f0;
}

.network_tb_st .numst {
	font-family: Tahoma, Geneva, sans-serif;
	font-size: 11px;
}

.network_tb_st .engst {
	font-family: Tahoma, Geneva, sans-serif;
	font-size: 11px;
}

.network_tb_st .engst a {
	letter-spacing: 0.05em;
	display: inline;
}

.network_tb_st .left_txt {
	text-align: left;
}

.network_tb_st .right_txt {
	text-align: right;
}

.network_tb_st .pointcolor01 {
	color: #eb2b2b;
}

.network_tb_st .pointcolor02 {
	color: #185ad0;
}

.network_tb_st tbody td a {
	color: #636c7f;
}
.carSearchBox {
    background: url(../images/Work/bg_memo_search.gif) repeat-x 0 0;
    border: #b8bfcc solid 1px;
    box-shadow: 0px 1px 0px #fff;
    height: 23px;
    padding: 12px 15px 12px 15px;
    position: relative;
    
}
.popUpMenu .closePopUpMenu:hover{
	margin: 0;
	cursor: pointer;
	font-weight:bolder;
	background-color: #666666;
}

</style>
<jsp:scriptlet>pageContext.setAttribute("cr", "\r");
			pageContext.setAttribute("lf", "\n");
			pageContext.setAttribute("crlf", "\r\n");</jsp:scriptlet>

<div id="wrap">
	<div style="padding-top: 12px;">
		<input type="hidden" id="rgstId"
			value="<c:out value='${baseUserLoginInfo.loginId}'/>">
		<form name="modifyRec" method="post"
			action="<c:url value='/control/mainControl.do' />">
			<input type="hidden" id="sorting" name="sort_t" />
		</form>

		<form name="addStaff" method="post"
			action="<c:url value='/control/insertStaff.do' />">
			<div class="popUpMenu addStf" id="addStaff">
				<p class="closePopUpMenu" name="textR" title="닫기">ⅹ닫기</p>
				<ul>
					<li class="c_title"><span class="addTableTitle cent">이&nbsp;&nbsp;름</span>:
						<input type="text" name="usrNm" /></li>
					<li class="c_title"><span class="addTableTitle cent">I&nbsp;&nbsp;&nbsp;&nbsp;D</span>:
						<input type="text" name="usrId" /></li>
					<li class="c_title"><span class="addTableTitle cent">소&nbsp;&nbsp;속</span>:
						<select name="office">
							<option value="1">파트너스</option>
							<option value="2">투자자문</option>
							<option value="3">IB투자</option>
							<option value="4">벤처투자</option>
					</select></li>
					<li class="c_title"><span class="addTableTitle cent">직&nbsp;&nbsp;급</span>:
						<input type="text" name="position" /></li>
					<li class="c_title"><span class="addTableTitle cent">휴대폰</span>:
						<input type="text" name="phn1"
						onKeyPress="return numbersonly(event, false);" maxlength="11" /></li>
					<li class="c_title"><span class="addTableTitle cent">권&nbsp;&nbsp;한</span>:
						<select name="permission">
							<option value="00001"
								<c:if test="${stf.permission=='00001'}">selected</c:if>>외부</option>
							<option value="00005"
								<c:if test="${stf.permission=='00005'}">selected</c:if>>자회사_일반</option>
							<option value="00011"
								<c:if test="${stf.permission=='00011'}">selected</c:if>>일반</option>
							<option value="00012"
								<c:if test="${stf.permission=='00012'}">selected</c:if>>분석</option>
							<option value="00013"
								<c:if test="${stf.permission=='00013'}">selected</c:if>>딜상태변경</option>
							<option value="00014"
								<c:if test="${stf.permission=='00014'}">selected</c:if>>딜코멘트</option>
							<option value="00015"
								<c:if test="${stf.permission=='00015'}">selected</c:if>>인사</option>
							<option value="00016"
								<c:if test="${stf.permission=='00016'}">selected</c:if>>총무</option>
							<option value="00017"
								<c:if test="${stf.permission=='00017'}">selected</c:if>>CRM매니저</option>
							<option value="00020"
								<c:if test="${stf.permission=='00020'}">selected</c:if>>관리</option>
							<c:if test="${baseUserLoginInfo.permission > '00020'}">
								<option value="00021"
									<c:if test="${stf.permission=='00021'}">selected</c:if>>개발</option>
							</c:if>
					</select></li>
					<li class="bsnsR_btn">
						<div style="text-align: center; margin-top: 5px;">
							<button
								style="padding: 4px 30px 4px 30px; border: 1px solid #cccccc; background-color: #f1f1f1;"
								onclick="saveStaff(this);">저장</button>
						</div>
					</li>
				</ul>
			</div>
		</form>
		
	
			<div class="clear" style="height: 5px;"></div>
			<div class="clear"
				style="width: 20px; float: left; height: 25px; border-bottom: 1px solid #CCC;"></div>
			<div class="1st subTabon">관리자 관리</div>
			<div class="tabUnderBar"
				style="height: 25px; border-bottom: 1px solid #CCC; width: 100%;">&nbsp;</div>
				
			<div id="carMgmt_wrap"  style="border:0px;padding-left:25px;padding-right:25px;padding-top:25px;"> 
			<div class="carSearchBox">
				<c:if test="${baseUserLoginInfo.permission > '00020'}">
				<button style="padding: 5px 30px 5px 30px; border: 1px solid #ccc; font-size: 11px; color: #000; background-color: #f1f1f1;"
								onclick="viewDiv('addStaff',this)">직원 추가</button>
				</c:if>
				<button	style="padding: 5px 20px 5px 20px; border: 1px solid #cccccc; font-size: 11px; background-color: #ccc;"
					onclick="javascirpt:if($('.bgS').css('display')!='none') $('.bgS').css('display','none'); else $('.bgS').css('display','');">퇴사 가리기</button>
			</div>
			
			<div style="margin-top:20px;margin-bottom:10px;overflow-y:auto;position:relative;border: 1px solid #b8bfcc;" id="admin_div">
				<table id="admin_table" class="network_tb_st">
						<colgroup>
	                        	<col width="45"> <!--snb-->
	                            <col width="65"> <!--직원Id -->
	                            <col width="105"> <!--usr_nm-->
	                            <col width="65"> <!--position-->
	                            <col width="105"> <!--권한 -->
	                            <col width="*"> <!--srt_cd-->
	                            <col width="50"> <!--stat_seq-->
	                            <col width="105"> <!-- 부서(팀) -->
	                            <col width="85"> <!-- DIVISION -->
	                            <col width="100"> <!--소속 -->
	                            <col width="120"> <!--휴대폰-->
	                            <col width="80"> <!--인물ID-->
	                            <col width="50"> <!-- 저장버튼-->
	                            <col width="125"> <!--SABUN-->
	                            <col width="*"> <!--USR_PW-->
	                            <col width="*"> <!--기타--> 
           				 </colgroup>
						<thead>
							<tr>
								<th  rowspan="" onclick="sortTable()" class="hand bgYlw nameD">S_NB<br />▼
								</th>
								<th rowspan="" class="bgYlw cpnD">직원ID</th>
								<th  rowspan="" onclick="sortTable(1)"
									class="hand bgYlw companyName">USR_NM<br />▼
								</th>
								<th rowspan="" class="hand bgYlw companyName">POSITIOIN</th>
								<th  rowspan="" onclick="sortTable(3)" class="hand bgYlw "
									title="PERMISSION" >권한<br />▼
								</th>
								<c:if test="${baseUserLoginInfo.permission > '00020'}">
									<th rowspan="" onclick="sortTable(2)"  class="hand bgYlw nameD">SRT_CD<br />▼
									</th>
								</c:if>
								<th  rowspan="" class="hand bgYlw nameD">STAT<br />_SEQ
								</th>
								<th  rowspan="" onclick="sortTable(5)"
									class="hand bgYlw companyName" title="부서(팀)">부서(팀)<br />▼
								</th>
								<th rowspan="" onclick="sortTable(6)"
									class="hand bgYlw companyName"
									title="DIVISION">DIVISION<br />▼
								</th>
								<th rowspan="" onclick="sortTable(4)"
									class="hand bgYlw companyName" title="소속">소속<br />▼
								</th>
								<th  rowspan="" class="bgYlw companyName">휴대폰</th>
								<%-- <th rowspan="" onclick="sortTable(2)" class="hand bgYlw nameD">구분<br/>▼</th> --%>

								<th rowspan="" class="bgYlw cpnD">인물ID</th>
								<th rowspan="" class="bgYlw nameD"></th>

								<th rowspan="" class="bgYlw width120">SABUN</th>
								<c:if test="${baseUserLoginInfo.permission > '00020'}">
									<th rowspan="" class="bgYlw width120">USR_PW</th>
								</c:if>
								<th rowspan="" class="bgYlw">기타</th>
							</tr>
						</thead>
						<tbody>						
							<form name="insertCard" id="insertCard" method="post">
							<c:forEach var="stf" items="${staffList}" varStatus="stfS">
									<tr <c:if test="${stf.srtCd=='10000'}">class="bgS" style="display:none;"</c:if>>
										<input type="hidden" name="sNb${stf.sNb}" value="${stf.sNb}"/>
										<td class="cent" >${stf.sNb}</td>
										<td class="cent" ><input type="text" class="cpnDInput" name="usrId${stf.sNb}" value="${stf.usrId}"/></td>
										<td class="cent" ><input type="text" class="companyNameInput" name="usrNm${stf.sNb}" value="${stf.usrNm}"/></td>
										<td class="cent"><input type="text" class="companyNameInput" style="text-align:left;padding-left:3px;width:55px;" name="position${stf.sNb}" value="${stf.position}"/></td>
										<c:if test="${baseUserLoginInfo.permission > '00020'}">
										<td class="cent ">
											<%-- <input type="hidden" name="permission${stf.sNb}"/> --%>
											<select name="permission${stf.sNb}" class="bgP${stf.permission}" onchange="changePmsn(this);" <c:if test="${baseUserLoginInfo.permission < stf.permission}">disabled</c:if>>
												<option value="00001" <c:if test="${stf.permission=='00001'}">selected</c:if>>외부</option>
												<option value="00005" <c:if test="${stf.permission=='00005'}">selected</c:if>>자회사_일반</option>
												<option value="00011" <c:if test="${stf.permission=='00011'}">selected</c:if>>일반</option>
												<option value="00012" <c:if test="${stf.permission=='00012'}">selected</c:if>>분석</option>
												<option value="00013" <c:if test="${stf.permission=='00013'}">selected</c:if>>딜상태변경</option>
												<option value="00014" <c:if test="${stf.permission=='00014'}">selected</c:if>>딜코멘트</option>
												<option value="00015" <c:if test="${stf.permission=='00015'}">selected</c:if>>인사</option>
												<option value="00016" <c:if test="${stf.permission=='00016'}">selected</c:if>>총무</option>
												<option value="00017" <c:if test="${stf.permission=='00017'}">selected</c:if>>CRM매니저</option>
												<option value="00020" <c:if test="${stf.permission=='00020'}">selected</c:if>>관리</option>
											<c:if test="${baseUserLoginInfo.permission > '00020'}">	<option value="00021" <c:if test="${stf.permission=='00021'}">selected</c:if>>개발</option></c:if>
											</select>
										</td></c:if>
										
										<c:if test="${baseUserLoginInfo.permission < '00021'}"><input type="hidden" name="srtCd${stf.sNb}" value="${stf.srtCd}"/></c:if>
										<c:if test="${baseUserLoginInfo.permission > '00020'}"><td class="cent" style="width:45px"><input type="text" class="nameDInput bgS${stf.srtCd}" name="srtCd${stf.sNb}" value="${stf.srtCd}" onKeyPress="kyPsrtCd(this); return numbersonly(event, false);" maxlength="5"/></td></c:if>
										
										<td class="cent" ><input type="text" class="nameDInput bgS${stf.statSeq}" name="statSeq${stf.sNb}" value="${stf.statSeq}" maxlength="5"/></td>
										<td class="cent" >
											<select name="dept${stf.sNb}">
												<option value="" <c:if test="${stf.team eq ''}">selected</c:if>>선택</option>
											<c:forEach var="dept" items="${deptList}" varStatus="dS">
												<option value="${dept.code}" <c:if test="${stf.team eq dept.code}">selected</c:if>>${dept.name}</option>								
											</c:forEach>
											</select>
										</td>
										<td class="cent" >
											<select name="division${stf.sNb}" class="bgDiv${stf.division}">
												<option value="" <c:if test="${stf.division eq ''}">selected</c:if>>선택</option>
											<c:forEach var="divi" items="${divList}" varStatus="dS">
												<option value="${divi.code}" <c:if test="${stf.division eq divi.code}">selected</c:if>>${divi.name}</option>								
											</c:forEach>
											</select>
										</td>
										<td class="cent" >
											<%-- <input type="hidden" name="office${stf.sNb}"/> --%>
											<select name="office${stf.sNb}" class="" onchange="changeOffice(this);">
												<option value="1" <c:if test="${stf.office=='1'}">selected</c:if>>파트너스</option>
												<option value="2" <c:if test="${stf.office=='2'}">selected</c:if>>투자자문</option>
												<option value="3" <c:if test="${stf.office=='3'}">selected</c:if>>IB투자</option>
												<option value="4" <c:if test="${stf.office=='4'}">selected</c:if>>벤처투자</option>
											</select>
										</td>
										<td class="cent" >${stf.phn1}</td>
										<%-- 
										<td class="cent nameD bgS${stf.srtCd}">
											<c:if test="${stf.srtCd<10}">IB관리</c:if>
											<c:if test="${stf.srtCd=='10000'}">퇴사</c:if>
										</td>
										 --%>
										
										<td class="cent" ><input type="text" class="nameDInput" style="text-align:right!important;padding-right:3px;" name="cstId${stf.sNb}" value="${stf.cstId}"/><!-- <span class="btn s glass bold" onclick="javascript:updateCustomer(this);">update</span> --></td>
										<td class="cent"><span class="btn s green" onclick="saveStaffInfo(${stf.sNb});"><a>저장</a></span></td>
										
										
										<td class="cent width120">${stf.sabun}&nbsp;<span class="btn s orange" onclick="javascript:updateSabun(this);"><a>Update</a></span></td>
										
										
										<c:if test="${baseUserLoginInfo.permission > '00020'}">
										<td class="cent width120">
											<span class="btn s red" onclick="reSetPw('${stf.sNb}')"><a>PW 초기화</a></span>
											<c:if test="${stf.srtCd!='10000'}">
												&nbsp;<span class="btn s black" onclick="setResign('${stf.sNb}')"><a>퇴사</a></span>
											</c:if>
										</td>
										</c:if>
										<td class="cent"><%-- ${stf.usrPw} --%></td>
									</tr>
								</c:forEach>
							</form>
						</tbody>
					</table>
					</div>
				</div>
		</div>
	</div>