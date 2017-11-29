<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Main</title>
<link href="<c:url value='/css/content.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet" type="text/css">
<style>li select{font-size:12px;width:118px;height:20px;} .epiHid{display:none;} .epiNHid{display:'';border:1px dotted gray !important;border-radius:4px;text-align:left;cursor:pointer;} .epiNHid:hover{background-color: #FAAC58 !important;}</style>
<script type="text/JavaScript" src="<c:url value='/js/html5.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/jquery.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/base.js'/>"></script>
<script>

$(document).ready(function(){
	$(document).on("change","#choiceYear", function(){
		 var frm = document.modifyRec;
		 frm.action = "index.do";
		 frm.submit();
	});

	function resize_iframe(){
		if(parseInt($(".rcmdTableTd").css('width')) >= 800) $(".rcmdTable").css('width','50%');
		else $(".rcmdTable").css('width','100%');
	}
	window.onresize=resize_iframe;
	window.onload=resize_iframe;
});

function refresh(){
	location.href ="<c:url value='index.do' />";
}

function delIdea(snb){
	if(confirm("삭제하시겠습니까?")){
		var DATA = {sNb:snb};
		var fn = function(){location.href ="<c:url value='index.do' />";};
		ajaxModule(DATA,"../idea/deleteIdea.do",fn);
	}
}

var ideaSubmit = function(th){
	var obj = $(th).parent().parent().parent();
	var Cd = obj.find("[id^=cD]").val();
	var Title = obj.find("[id^=title]").val();
	var Idea = obj.find("[id^=idea]").val(); 
	var CstNm = obj.find("[id^=cstNm]").val(); 

	if(basicInput(Title,Idea,obj)) return;
	
	var data = {cd:Cd,title:Title,idea:Idea,cstNm:CstNm};
	var fn = function(){location.href ="<c:url value='index.do' />";};
	ajaxModule(data,"../idea/insertIdea.do",fn);
};

var modifyIdea = function(th, flag){
	var obj = $(th).parent().parent().parent();
	var snb = obj.find('[id^=snb]').val();
	var DATA;
	var url = "../idea/updateIdea.do";
	var fn = function(){ location.href ="<c:url value='index.do' />"; };
	if(flag=='idea'){
		var Cd = obj.find('[id^=cd]').val();
		var Title = obj.find('[id^=title]').val();
		var Idea = obj.find('[id^=idea]').val();
		var CstNm = obj.find("[id^=cstNm]").val(); 
		if(basicInput(Title,Idea,obj)) return;
		DATA = { sNb: snb,cd: Cd,title: Title,idea: Idea,cstNm:CstNm};
	}else if(flag=='score'){
		var txt = obj.find('[id^=prize]').val();
		if(txt==="포상 내용을 입력하세요.") txt = '';
		var Score = obj.find('[id^=score]').val();
		DATA = { sNb: snb, score:Score, prize:txt};
	}else return;
	
	ajaxModule(DATA,url,fn);
};

function basicInput(Title,Idea,obj){
	if("" == Title | null == Title | "제목" == Title){
		alert("아이디어 제목을 입력하세요."); 
		//location.hash = 'title';
		obj.find("[id^=title]").focus();
		return true;
	}
	if("" == Idea | null == Idea | "아이디어 내용을 입력하세요." == Idea){
		alert("아이디어 내용을 입력하세요."); 
		//location.hash = 'title';
		obj.find("[id^=idea]").focus();
		return true;
	}
	return false;
}


var viewHidden = function(th){
	var obj = $(th);
	if('+'==obj.html()[0]){
		obj.html('-숨김');
		$('.epiHid').attr('class','epiNHid');
		//$('.rcmdRs').removeClass('w120p');
		//$('.rcmdRs').addClass('w500p');
	}else{
		obj.html('+펼침');
		$('.epiNHid').attr('class','epiHid');
		//$('.rcmdRs').removeClass('w500p');
		//$('.rcmdRs').addClass('w120p');
	}
};

var saveRcmd = function(th,ins5up){
	var obj = $(th).parent().parent().parent()
	  , url = ''
	  , fn = function(){ location.href ="<c:url value='index.do' />"; };
	if(ins5up==='ins'){
		var OfferSnb = obj.find('[id^=snb]').val();
		url = "../idea/insertRcmd.do";
	}else if(ins5up==='up'){
		var snb = obj.find('[id^=snb]').val();
		url = "../idea/updateRcmd.do";
	}else return;
	var Reason = obj.find('[id^=reason]').val();
	if(""==Reason|null ==Reason|"코멘트를 입력하세요."==Reason){
		alert("코멘트를 입력하세요.");
		obj.find('[id^=reason]').focus();
		return;
	}
	var DATA = {sNb: snb, offerSnb: OfferSnb, reason:Reason};
	ajaxModule(DATA,url,fn);
};

function delRcmd(snb){
	if(confirm("삭제하시겠습니까?")){
		var DATA = {sNb:snb}
		  , fn = function(){ location.href ="<c:url value='index.do' />"; };
	    ajaxModule(DATA,"../idea/deleteRcmd.do",fn);
	}
}
$(document).on("change",".eval", function(){
	var obj = $(this);
	var data = {sNb: obj.attr('id').split('eval')[1]
				,lvCd: obj.val()}
			,fn=function(){};
	ajaxModule(data,"../idea/updateEval.do",fn);
});
$(document).on("change",".processCd", function(){
	var obj = $(this);
	var data = {sNb: obj.attr('id').split('_')[1]
				,process: obj.val()}
			,fn=function(){refresh();};
	ajaxModule(data,"../idea/updateProcess.do",fn);
});

function viewStaff(divId,th,e){ //divId : 보여주기위한 target divId
	var obj = $(th).parent();
	var browserWidth = document.documentElement.clientWidth;
	var calWidth= $("#" + divId).outerWidth();
	var pstn = getPosition(e);
	var top = pstn.y;
	var left = pstn.x;
	
	$("#id4insert").val(obj.find('[id^=cstNm]').attr('id'));
	$(".memo_btnSnd").attr("onclick","addStaffName(this)");
	$("#"+divId).css({"top":top+"px","left":(left+calWidth<browserWidth?left:browserWidth-(calWidth+8))+"px"});
	$("#"+divId).css('display','block');
	$("#"+divId).find(':checkbox').attr('checked',false);
	$("#"+divId).show();
}
function addStaffName(th){
	var obj = $(th).parent().parent();
	var chkbx = obj.find(':checkbox:checked');
	var text = '';
	for(var i=0;i<chkbx.size();i++){
		if(i!=0)text += ', ';
		text += obj.find(':checkbox:checked:eq('+i+')').val();
	}
	$("#"+$("#id4insert").val()).val(text);
	obj.hide();
	
}

function viewStaffM(divId,th,e){ //divId : 보여주기위한 target divId
	var obj = $(th).parent();
	var browserWidth = document.documentElement.clientWidth;
	var calWidth= $("#" + divId).outerWidth();
	var pstn = getPosition(e);
	var top = pstn.y;
	var left = pstn.x;
	
	$("#id4insert").val(obj.find('[id^=addP]').attr('id').split('_')[1]);
	$(".memo_btnSnd").attr("onclick","addStaffNameM(this)");
	$("#"+divId).css({"top":top+"px","left":(left+calWidth<browserWidth?left:browserWidth-(calWidth+8))+"px"});
	$("#"+divId).css('display','block');
	$("#"+divId).find(':checkbox').attr('checked',false);
	$("#"+divId).show();
}
function addStaffNameM(th){
	var obj = $(th).parent().parent();
	var chkbx = obj.find(':checkbox:checked');
	var text = '';
	for(var i=0;i<chkbx.size();i++){
		if(i!=0)text += ', ';
		text += obj.find(':checkbox:checked:eq('+i+')').val();
	}
	obj.hide();
	var data = {sNb: $("#id4insert").val(), cstNm: text, tmpNum1: 'addStaff'}
		,fn=function(){refresh();};;
	ajaxModule(data,"../idea/updateIdea.do",fn);
	
}
</script>
<style>.rcmdTableTd{width: clac( 50% - 299px )}</style>
</head>
<input type="hidden" id="rgstId" value="<c:out value='${baseUserLoginInfo.loginId}'/>">
<body>
<div id="wrap">

	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>
	
	<c:set var="bookCnt" value="0"/>
	<c:set var="now" value="<%= new java.util.Date() %>"/>
	<fmt:formatDate var="cur_year" value='${now}' pattern='yyyy'/>
	

<!-- floating div staff -->

	<div class="popUpMenu" id="test" style="z-index:100;font-size: 1em;">
		<p class="closePopUpMenu">ⅹ닫기</p>
		<input type="hidden" id="id4insert"/>
		<c:forEach var="staff" items="${userList}" varStatus="tttStatus">
			<input type="checkbox" id="chbox${tttStatus.count}" name="memoSndName" value="${staff.usrNm}"><label for="chbox${tttStatus.count}" class="checkR">${staff.usrNm}</label><br/>
		</c:forEach>
		<p class=bsnsR_btn>
			<span onclick="addStaffName(this)" class="memo_btnSnd btn s green"><a>선택</a></span>
		</p>
	</div>
	
<!-- floating div staff -->
		<!-- 입력   -->
		<form name="formBook" action="<c:url value='/idea/insertIdea.do' />" method="post">
			<div class="popUpMenu title_area" id="idea" style="z-index:99;">
				<p class="closePopUpMenu" onclick="javascript:$('.popUpMenu').hide();" title="닫기">ⅹ닫기</p>
				<ul>
					<li class="c_title">
					<input type="hidden" id="cstNm">
					<span class="bold" style="display:inline-block;">구분 :&nbsp;</span><select id="cD" name="cd" class="w80p">
						<option value="1">딜</option>
						<option value="2">자금</option>
						<option value="3">경영효율</option>
						<option value="4">기타</option>
					</select>
					<input type="text" id="title" name="title" placeholder="제목" style="width:323px"/>
					<span class="btn s orange" onclick="viewStaff('test',this,event);"><a>참가자</a></span></li>
					<li class="c_note"><textarea id="idea" name="idea" style="font-size:13px !important;line-height: 150%;color:black;" placeholder="아이디어 내용을 입력하세요."></textarea></li>
					<!-- <li class=""><span class="w60p bold" style="display:inline-block;vertical-align:top;padding-top:5px;">대&nbsp;&nbsp;&nbsp;상 : </span><textarea name="epilogue" class="pop_note" style="min-height:50px;"></textarea></li> -->
					<li class="bsnsR_btn">
						<span class="btn s green"><a id="saveBookBtn" onclick="ideaSubmit(this)">저장</a></span>
					</li>
				</ul>
			</div>
		</form>
		<c:forEach var="idea" items="${ideaList}" varStatus="ideaS">
			<div class="popUpMenu title_area" id="idea${ideaS.count}" style="z-index:99;">
				<p class="closePopUpMenu" onclick="javascript:$('.popUpMenu').hide();" title="닫기">ⅹ닫기</p>
				<ul><input type="hidden" id="snbIdea${ideaS.count}" value="${idea.sNb}" />
					<li class="c_title">
					<input type="hidden" id="cstNm${ideaS.count}" value="${idea.cstNm}">
					<span class="bold" style="display:inline-block;">구분 :&nbsp;</span><select id="cd${ideaS.count}" class="w80p" <c:if test="${baseUserLoginInfo.loginId!=idea.rgId}">disabled</c:if>>
						<option value="1" <c:if test="${idea.cd == 1}">selected</c:if>>딜</option>
						<option value="2" <c:if test="${idea.cd == 2}">selected</c:if>>자금</option>
						<option value="3" <c:if test="${idea.cd == 3}">selected</c:if>>경영효율</option>
						<option value="4" <c:if test="${idea.cd == 4}">selected</c:if>>기타</option>
					</select>
					<input type="text" id="title${ideaS.count}" value="${idea.title}" style="width:323px" <c:if test="${baseUserLoginInfo.loginId!=idea.rgId}">disabled</c:if>/>
					<c:if test="${baseUserLoginInfo.loginId==idea.rgId}"><span class="btn s orange" onclick="viewStaff('test',this,event);"><a>참가자</a></span></c:if></li>
					<c:if test="${baseUserLoginInfo.loginId==idea.rgId}"><li class="c_note"><textarea id="ideaC${ideaS.count}">${idea.idea}</textarea></li></c:if>
					<c:if test="${baseUserLoginInfo.loginId!=idea.rgId}"><li class="c_note v-textarea" style="font-size:13px !important;line-height: 150%;color:black;">${fn:replace(idea.idea, lf,"<br/>")}</li></c:if>
					<c:if test="${baseUserLoginInfo.loginId==idea.rgId}"><li class="bsnsR_btn">
						<span class="btn s orange"><a onclick="modifyIdea(this, 'idea')">수정</a></span>
					</li></c:if>
				</ul>
			</div>
			<div class="popUpMenu title_area" id="rcmd${ideaS.count}">
				<p class="closePopUpMenu" title="닫기">ⅹ닫기</p>
				<ul><input type="hidden" id="snbOffer${ideaS.count}" value="${idea.sNb}" />
					<li class="c_note"><textarea id="reason${ideaS.count}" placeholder="코멘트를 입력하세요."></textarea></li>
					<li class="bsnsR_btn">
						<span class="btn s green"><a onclick="saveRcmd(this,'ins')">저장</a></span>
					</li>
				</ul>
			</div>
			<div class="popUpMenu title_area" id="score${ideaS.count}">
				<p class="closePopUpMenu" title="닫기">ⅹ닫기</p>
				<ul><input type="hidden" id="snbScore${ideaS.count}" value="${idea.sNb}" />
					<li class="c_title">
						<span class="bold" style="display:inline-block;">평가점수 :&nbsp;</span><select id="scoreC${ideaS.count}" class="w50p">
							<option value="1" <c:if test="${idea.score == 1}">selected</c:if>>1</option>
							<option value="2" <c:if test="${idea.score == 2}">selected</c:if>>2</option>
							<option value="3" <c:if test="${idea.score == 3}">selected</c:if>>3</option>
							<option value="4" <c:if test="${idea.score == 4}">selected</c:if>>4</option>
							<option value="5" <c:if test="${idea.score == 5}">selected</c:if>>5</option>
						</select>
					</li>
					<li class="c_note">
						<c:if test="${empty idea.prize}"><textarea id="prize${ideaS.count}" style="font-size:13px !important;line-height: 150%;color:black;" placeholder="포상 내용을 입력하세요."></textarea></c:if>
						<c:if test="${not empty idea.prize}"><textarea id="prize${ideaS.count}" style="font-size:13px !important;line-height: 150%;color:black;">${idea.prize}</textarea></c:if>
					</li>
					<li class="bsnsR_btn">
						<span class="btn s green"><a onclick="modifyIdea(this, 'score')">저장</a></span>
					</li>
				</ul>
			</div>
		</c:forEach>
		<c:forEach var="rcmd" items="${rcmdList}" varStatus="rcmdS">
			<div class="popUpMenu title_area" id="rcmdReasn${rcmdS.count}">
				<p class="closePopUpMenu" title="닫기">ⅹ닫기</p>
				<ul><input type="hidden" id="snbRcmd${rcmdS.count}" value="${rcmd.sNb}" />
					<c:if test="${baseUserLoginInfo.loginId==rcmd.rgId}"><li class="c_note"><textarea id="reason${rcmdS.count}" style="font-size:13px !important;line-height: 150%;color:black;">${rcmd.reason}</textarea></li></c:if>
					<c:if test="${baseUserLoginInfo.loginId!=rcmd.rgId}"><li class="c_note v-textarea" style="font-size:13px !important;line-height: 150%;color:black;">${fn:replace(rcmd.reason, lf,"<br/>")}</li></c:if>
					<c:if test="${baseUserLoginInfo.loginId==rcmd.rgId}"><li class="bsnsR_btn">
						<span class="btn s orange"><a onclick="saveRcmd(this,'up')">수정</a></span>
						<span class="btn s red"><a onclick="delRcmd('${rcmd.sNb}')">삭제</a></span>
					</li></c:if>
				</ul>
			</div>
		</c:forEach>
		<!-- 입력   -->

	<section>
		<div class="fixed-top" style="z-index:10;">
		
		<header>
			<form id="modifyRec" name="modifyRec" method="post" action="<c:url value='/idea/index.do' />">
				<input type="hidden" name="sorting" id="sorting">
			<div class="year_wrap" style="width:97%">
			
				<span class="year">
					<select id='choiceYear' name='choiceYear'>
						<c:forEach var="year" begin="2013" end="${cur_year}">
							<option value="${year}"
							<c:choose>
								<c:when test="${choiceYear == null}">
									<c:if test="${year == cur_year}">selected</c:if>>
								</c:when>
								<c:otherwise>
									<c:if test="${year == choiceYear}">selected</c:if>>
								</c:otherwise>
							</c:choose> 
							${year}</option>
						</c:forEach>
					</select>
				</span>
				<span>
				<span class="btn s blue"><a onclick="view('idea')">IDEA 입력</a></span>
				</span>
			</div>
			</form>
		</header>
		
			<table class="t_skinR00" style="width:100%;margin-top:35px;padding-right:5px;;table-layout:fixed;">
				<colgroup>
			        <col width="97">
			        <col width="82">
			        <col width="62">
			        <col width="132">
			        <col width="calc( 60% - 300px )">
			        <col width="calc( 40% - 300px )">
			        <col width="62">
			        <col width="102">
			        <col width="62">
			    </colgroup>
				<thead>
					<tr>
 						<th class="bgYlw">일자</th>
						<th class="bgYlw">입력자</th>
						<th class="bgYlw">구분</th>
						<th class="bgYlw">아이디어</th>
						<th class="bgYlw">코멘트 <span class="btn s gold"><a onclick="viewHidden(this)">-숨김</a></span></th>
						<th class="bgYlw">평가</th>
						<th class="bgYlw">평가점수</th>
						<th class="bgYlw">진행사항</th>
						<th class="bgYlw">참가자</th>
						<c:if test="${not empty idea.prize}"><th class="bgYlw">포상내용</th></c:if>
					</tr>
					<tr style="height:1px;"></tr>
				</thead>
			</table>
		</div>
		<div style="padding-top:65px;">
		
		<input type="hidden" id="cardD" value="card">
		<form name="insertBook" id="insertBook" method="post">
			<table class="t_skinR00" style="width:100%;table-layout:fixed;">
				<colgroup>
			        <col width="97">
			        <col width="82">
			        <col width="62">
			        <col width="132">
			        <col width="calc( 60% - 300px )">
			        <col width="calc( 40% - 300px )">
			        <col width="62">
			        <col width="102">
			        <col width="62">
			    </colgroup>
				<tbody><c:set var="subBegin" value="0"/>
					<c:forEach var="idea" items="${ideaList}" varStatus="ideaS">
					<tr
						<c:choose>
							<c:when test="${idea.process == '10000'}"> style="height:40px;background-color:#B9B9B9" </c:when>
							<c:otherwise><c:if test="${idea.process == '00001'}"> style="background-color:#F6CECE"</c:if><c:if test="${idea.process == '00005'}"> style="background-color:#A9F5BC"</c:if></c:otherwise>
						</c:choose>
					>
						<td class="cent" id="bookNumber${ideaS.count}"><b>${idea.rgDt}</b><br/><nobr><c:if test="${baseUserLoginInfo.userName==idea.usrNm}">
							<span class="btn s red"><a onclick="delIdea(${idea.sNb})">삭제</a></span></c:if>
							<span class="btn s green"><a onclick="view('rcmd${ideaS.count}')">코멘트</a></span></nobr>
							<c:if test="${baseUserLoginInfo.loginId=='gjh'}"><span class="btn s gold"><a onclick="view('score${ideaS.count}')">평가</a></span></c:if>
						</td>
						<td class="cent"><b>${idea.usrNm}</b></td>
						<td class="cent"><b><c:if test="${idea.cd=='1'}">딜</c:if><c:if test="${idea.cd=='2'}">자금</c:if><c:if test="${idea.cd=='3'}">경영효율</c:if><c:if test="${idea.cd=='4'}">기타</c:if></b></td>
						<td class="cent navy"><c:if test="${idea.diffDt<3}"><img class="filePosition" id="fileNew${status.count}" src="../images/file/new0.gif" style="width:23px;height:11px"/><br/></c:if><b><a onclick="view('idea${ideaS.count}')">${idea.title}</a></b></td>
						<td class="cent rcmdRs rcmdTableTd">
							<c:forEach var="rcmd" items="${rcmdList}" begin="${subBegin}" varStatus="epS"><c:if test="${idea.sNb == rcmd.offerSnb and rcmd.rgId != 'gjh'}">
							<table class="rcmdRs rcmdTable" style="float:left;width:100%;">
								<tr>
									<td class="bd0 pd0 w40p bold navy"><c:if test="${rcmd.diffDt<3}"><img class="filePosition" id="fileNew${status.count}" src="../images/file/new0.gif" style="width:23px;height:11px"/><br/></c:if>${rcmd.usrNm }</td>
									<td class="epiNHid" onclick="view('rcmdReasn${epS.count}')">${fn:replace(rcmd.reason, lf,"<br/>")}</td>
									<c:if test="${baseUserLoginInfo.permission > '00019'}"><td style="width:57px;vertical-align:top;">
										<select class="eval hand" id="eval${rcmd.sNb}">
											<option value="0"<c:if test="${rcmd.lvCd == 0}"> selected="selected"</c:if>>평가</option><c:forEach var="loop5" varStatus="L5" begin="1" end="5">
											<option value="${loop5}"<c:if test="${rcmd.lvCd == loop5}"> selected="selected"</c:if>>&nbsp;&nbsp;${loop5}</option>
										</c:forEach></select>
									</td></c:if>
								</tr>
							</table>
							</c:if></c:forEach><%-- <c:set var="subBegin" value="${epS.count}"/> --%>
						</td>
						<td class="cent rcmdRs rcmdTableTd">
							<c:forEach var="rcmd" items="${rcmdList}" varStatus="epS"><c:if test="${idea.sNb == rcmd.offerSnb and rcmd.rgId == 'gjh'}">
							<table class="rcmdRs" style="float:left;width:100%;">
								<tr><td class="bd0 pd0 w40p bold navy">${rcmd.usrNm }</td></tr>
								<tr><td class="epiNHid" onclick="view('rcmdReasn${epS.count}')">${fn:replace(rcmd.reason, lf,"<br/>")}</td></tr>
							</table>
							</c:if></c:forEach><%-- <c:set var="subBegin" value="${epS.count}"/> --%>
						</td>
						<td class="cent"><c:if test="${idea.score != 0}">${idea.score }</c:if></td>
						<td class="cent">
							<select class="processCd" id="processCd_${idea.sNb}"><c:forEach var="cmmCd" items="${cmmCdProcessList}" varStatus="prcsS">
								<option value="${cmmCd.cd}" <c:if test="${idea.process == cmmCd.cd}">selected</c:if>>${cmmCd.nm}</option>
							</c:forEach>
							</select>
						</td>
						<td class="cent"><span class="btn s orange" id="addP_${idea.sNb}" onclick="viewStaffM('test',this,event);"><a>참가자</a></span>${idea.cstNm}</td>
						<c:if test="${not empty idea.prize}"><td class="cent w50p">${idea.prize }</td></c:if>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
		</div>
	</section>
</div>
<div class="clear"></div>
</body>
</html>