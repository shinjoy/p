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
<style>li select{font-size:12px;width:118px;height:20px;} .epiHid{display:none;} .epiNHid{display:''}</style>
<script type="text/JavaScript" src="<c:url value='/js/html5.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/jquery.min.js'/>" ></script>
<script>

$(document).ready(function(){
	 if(navigator.userAgent.indexOf('Firefox') >= 0){
		  (function(){
		   var events = ["mousedown", "mouseover", "mouseout", "mousemove",
		                 "mousedrag", "click", "dblclick"];
		   for (var i = 0; i < events.length; i++){
		    window.addEventListener(events[i], function(e){
		     window.event = e;
		    }, true);
		   }
		  }());
		 };

	if('<c:out value='${saveCnt}'/>' > 0 ) {
		location.href ="<c:url value='index.do' />";
	}

	$(document).on("click",".closePopUpMenu",function(event){
		$(this).parent().hide();
	});

	$(document).on("change","#choiceYear", function(){
		 var frm = document.modifyRec;
		 frm.action = "index.do";
		 frm.submit();
	});
});

function refresh(){
	location.href ="<c:url value='index.do' />";
}

function getPosition(e) {
    e = e || window.event;
    var cursor = {x:0, y:0};
    if (e.pageX || e.pageY) {
        cursor.x = e.pageX;
        cursor.y = e.pageY;
    }
    else {
        cursor.x = e.clientX +
            (document.documentElement.scrollLeft ||
            document.body.scrollLeft) -
            document.documentElement.clientLeft;
        cursor.y = e.clientY +
            (document.documentElement.scrollTop ||
            document.body.scrollTop) -
            document.documentElement.clientTop;
    }
    return cursor;
}

function view(divId,bNum,th){ //divId : 보여주기위한 target divId
	var browserWidth = document.documentElement.clientWidth;
	var calWidth= $("#" + divId).outerWidth();
	var pstn = getPosition();
	var top = pstn.y;
	var left = pstn.x;
	$("#"+divId).css({"top":top,"left":(left+calWidth<browserWidth?left:browserWidth-(calWidth+8))});
	$("#"+divId).css('display','block');
	$(".popUpMenu").hide();
	$("#"+divId).show();

	var classNum = divId.substr(6,1);
	if(divId.substr(0,6)=='staffL') {
		$("#saveReader"+classNum).attr('onclick',"saveReader('"+bNum+"',this,'"+classNum+"')");
	}
	if(bNum&&bNum.length>0) $("#bookNum4epil").val(bNum);
}

function bookCount(year, cnt, bookNum){
	var bookNumYear = bookNum.split('-');
	if(year==bookNumYear[0]){
		var len = cnt.length;
		var zero = '';
		for(var i=0;i<(4-len);i++) zero = String(zero) + String(0);
		return year+'-'+zero+String(cnt);
	}else{
		return year+'-0000';
	}
}

function delEp(snb){
	if(confirm("삭제하시겠습니까?")){
		var DATA = {sNb:snb};
		ajax(DATA,"../book/deleteEpilogue.do");
	}
}
function delBook(snb){
	if(confirm("삭제하시겠습니까?")){
		var DATA = {sNb:snb};
		ajax(DATA,"../book/deleteBook.do");
	}
}
function saveReader(bookNum, th, classNum){
	var cntMax = $('.cntNum'+classNum).length;
	var usrId = new Array();
	var DATA = {};
	var updateYN = $(th).parent().parent().parent().find('[id^=usrId1_]').val();

	for(var i=0;i<cntMax;i++){
		var cnt = $('.cntNum'+classNum+':eq('+i+')');
		var num = cnt.html();
		if(num){
			var idSnum = cnt.attr('id').split('chNum')[1];
			usrId[num-1] = $('#usrId'+idSnum).val();
			//alert(usrId[num-1]+"\n\n"+usrId);
		}else continue;
	}

	DATA = {arrUsrId: usrId, bookNum: bookNum, tmpNum1:updateYN};
	$.ajaxSettings.traditional = true;//array 전송을 위한 셋팅
	ajax(DATA,"../book/saveReader.do");
}
function ajax(DATA,Url){
	$.ajax({
		type:"POST",        //POST GET
		url:Url,     //PAGEURL
		data : DATA,
		timeout : 30000,       //제한시간 지정
		cache : false,        //true, false
		success: function whenSuccess(arg){  //SUCCESS FUNCTION
			location.href ="<c:url value='index.do' />";
		},
		error: function whenError(e){    //ERROR FUNCTION
			alert("code : " + e.status + "\r\nmessage : " + e.responseText);
		}
	});
}
var bookSubmit = function(){
	var Title = $("#bookTitle").val();
	if("" == Title | null == Title){
		alert("도서명을 입력하세요.");
		location.hash = 'bookTitle';
		return;
	}
	formBook.submit();
};

var rent = function(snb,ren){
	var url = "../book/modifyRent.do";
	var DATA;
	if(ren==0) DATA = {sNb:snb};
	else       DATA = {sNb:snb, rent:'1'};
	ajax(DATA,url);
};

var modifyBook = function(th){
	var obj = $(th).parent().parent().parent();
	var url = "../book/updateBook.do";

	if("" == Title | null == Title){
		alert("도서명을 입력하세요.");
		return;
	}

	var DATA = {
		 sNb: obj.find('[id^=snb]').val();
		,title: obj.find('[id^=bookTitle]').val();
		,author: obj.find('[id^=author]').val();
		,epilogue: obj.find('[id^=epilogue]').val();
	};

	ajax(DATA,url);
};

function setCount(th,classNum){
	var obj = $(th).parent();
	var chNum = obj.find('[id^=chNum]');
	var count = chNum.html();
	//var leng = $('.cntNum').length;
	var leng = $('.cntNum'+classNum).length;

	if(count==""||count=="null"||count=="undefined"){
		var max = 1;
		for(var i=0;i<leng;i++){
			var epNum = $('.cntNum'+classNum+':eq('+i+')').html();
			epNum = epNum==''?0:epNum;
			if(parseInt(max) <= parseInt(epNum)) max = parseInt(epNum)+1;
		}
		chNum.html(max);
		obj.css('background-color','#FFF777');
	}else{
		for(var i=0;i<leng;i++){
			var epNum = $('.cntNum'+classNum+':eq('+i+')').html();
			epNum = epNum==''?0:epNum;
			if(parseInt(count) < parseInt(epNum)) $('.cntNum'+classNum+':eq('+i+')').html(parseInt(epNum)-1);
		}
		chNum.html("");
		obj.css('background-color','');
	}

};

var viewHidden = function(th){
	var obj = $(th);
	if('+'==obj.html()[0]){
		obj.html('-숨김');
		$('.epiHid').attr('class','epiNHid');
	}else{
		obj.html('+펼침');
		$('.epiNHid').attr('class','epiHid');
	}
};

function sortTable(flag){
	$("#sorting").val(flag);
	document.modifyRec.submit();
}
</script>
<style>
.sch{
	border: 2px solid #2B9ABF;
	padding: 3px;
	border-radius: 4px;
	background-color: #2B9ABF;
	color: #FFF;
	font-weight: bold;
}
</style>
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

	<c:forEach var="book" items="${bookList}" varStatus="bookS">
		<div class="popUpMenu" id="staffL${bookS.count}">
			<p class="closePopUpMenu" title="닫기">ⅹ닫기</p>
			<c:forEach var="reader" items="${readerList}" varStatus="readerS"><c:if test="${book.bookNum==reader.bookNum}">
			<input type="hidden" id="usrId${reader.turn}_${bookS.count}" value="${reader.sNb}"/></c:if></c:forEach>
			<c:forEach var="staff" items="${userList}" varStatus="tttStatus">
				<c:if test="${baseUserLoginInfo.userName!=staff.usrNm}">
				<input type="hidden" id="usrId${tttStatus.count}" value="${staff.usrId}"/>
				<p class="pd0 mg0">
					<span class="cntNum${bookS.count}" id="chNum${tttStatus.count}" align="right" style="display:inline-block;width:15px;margin-right:10px;text-align:right"><c:forEach var="reader" items="${readerList}" varStatus="readerS"><c:if test="${(book.bookNum==reader.bookNum)&&(staff.usrId == reader.readerId)}">${reader.turn}</c:if></c:forEach></span>
					<label onclick="setCount(this,'${bookS.count}')" for="chNum${tttStatus.count}" class="checkR">${staff.usrNm}</label></p>
				</c:if>
			</c:forEach>
			<p class="bsnsR_btn">
				<c:if test="${baseUserLoginInfo.permission > '00019'}"><span class="btn s green"><a id="saveReader${bookS.count}" onclick="saveReader()">&nbsp;순위지정&nbsp;</a></span></c:if>
			</p>
		</div>
	</c:forEach>

		<!-- 입력   -->
		<form name="formBook" action="<c:url value='/book/insertBook.do' />" method="post">
			<div class="popUpMenu title_area" id="book">
				<input type="hidden" id="nextBookN" name="bookNum">
				<p class="closePopUpMenu" title="닫기">ⅹ닫기</p>
				<ul>
					<li class=""><span class="w60p bold" style="display:inline-block">품&nbsp;&nbsp;&nbsp;번 : </span><input type="text" id="nextBookNum" disabled="disabled"></li>
					<li class=""><span class="w60p bold" style="display:inline-block">도서명 : </span><input type="text" name="title" id="bookTitle" class="pop_note"></li>
					<li class=""><span class="w60p bold" style="display:inline-block">작&nbsp;&nbsp;&nbsp;가 : </span><input type="text" name="author" class="pop_note"></li>
					<li class=""><span class="w60p bold" style="display:inline-block;">대&nbsp;&nbsp;&nbsp;상 : </span><select name="epilogue">
						<option value="0">전직원</option>
						<option value="1">팀장급</option>
						<option value="2">일반직원</option>
					</select></li></li>
					<!-- <li class=""><span class="w60p bold" style="display:inline-block;vertical-align:top;padding-top:5px;">대&nbsp;&nbsp;&nbsp;상 : </span><textarea name="epilogue" class="pop_note" style="min-height:50px;"></textarea></li> -->
				</ul>
				<p class="bsnsR_btn">
					<span class="btn s green"><a id="saveBookBtn" onclick="bookSubmit()">저장</a></span>
				</p>
			</div>
		</form>
		<c:forEach var="book" items="${bookList}" varStatus="bookS">
			<div class="popUpMenu title_area" id="book${bookS.count}">
				<input type="hidden" id="nextBookN" name="bookNum">
				<p class="closePopUpMenu" title="닫기">ⅹ닫기</p>
				<ul>
					<input type="hidden" id="snb${bookS.count}" value="${book.sNb}"/>
					<li class=""><span class="w60p bold" style="display:inline-block">품&nbsp;&nbsp;&nbsp;번 : </span><input type="text" id="nextBookNum${bookS.count}" value="${book.bookNum}" disabled="disabled"></li>
					<li class=""><span class="w60p bold" style="display:inline-block">도서명 : </span><input type="text" id="bookTitle${bookS.count}" class="pop_note" value="${book.title}"></li>
					<li class=""><span class="w60p bold" style="display:inline-block">작&nbsp;&nbsp;&nbsp;가 : </span><input type="text" id="author${bookS.count}" class="pop_note" value="${book.author}"></li>
					<li class=""><span class="w60p bold" style="display:inline-block;">대&nbsp;&nbsp;&nbsp;상 : </span><select id="epilogue${bookS.count}">
						<option value="0" <c:if test="${book.epilogue == 0}">selected</c:if>>전직원</option>
						<option value="1" <c:if test="${book.epilogue == 1}">selected</c:if>>팀장급</option>
						<option value="2" <c:if test="${book.epilogue == 2}">selected</c:if>>일반직원</option>
					</select></li>
					<%-- <li class=""><span class="w60p bold" style="display:inline-block;vertical-align:top;padding-top:5px;">대&nbsp;&nbsp;&nbsp;상 : </span><textarea id="epilogue${bookS.count}" class="pop_note" style="min-height:50px;">${book.epilogue}</textarea></li> --%>
				</ul>
				<p class="bsnsR_btn">
					<span class="btn s orange"><a onclick="modifyBook(this)">수정</a></span>
				</p>
			</div>
		</c:forEach>
		<form name="formEpilogue" action="<c:url value='/book/insertEpilogue.do' />" method="post">
			<div class="popUpMenu title_area" id="epilogue">
				<input type="hidden" id="bookNum4epil" name="bookNum"/>
				<p class="closePopUpMenu" title="닫기">ⅹ닫기</p>
				<ul>
					<li class="c_note"><textarea name="epilogue" placeholder="후기를 입력하세요."></textarea></li>
					<li class="bsnsR_btn">
						<span class="btn s green"><a id="saveEpilBtn" onclick="formEpilogue.submit()">저장</a></span>
					</li>
				</ul>
			</div>
		</form>
		<!-- 입력   -->

	<section>
		<div class="fixed-top" style="z-index:10;">

		<header>
			<form id="modifyRec" name="modifyRec" method="post" action="<c:url value='/book/index.do' />">
				<input type="hidden" name="sorting" id="sorting">
			<div class="year_wrap" style="width:97%">
				<%-- <span class="year">
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
				</span> --%>
				<span class="btn s blue"><a onclick="view('book')">도서입력</a></span>
				<span><input type="search" class="textSearch" id="search" name="search" placeholder="도서/작가/품번명" autofocus="autofocus" value="${search}">
					<input type="submit" class="btnSearch" value="검색">
				</span>
			</div>
			</form>
		</header>
			<table class="t_skinR00" style="width:100%;margin-top:40px;padding-right:5px;">
				<thead>
					<tr>
 						<th class="bgYlw hand w70p" onclick="sortTable()">품번 ▼</th>
						<th class="bgYlw hand w200p" onclick="sortTable(1)">도서명 ▼</th>
						<th class="bgYlw hand w120p" onclick="sortTable(2)">작가 ▼</th>
						<th class="bgYlw w70p">대상</th>
						<th class="bgYlw w50p">대여</th>
						<th class="bgYlw w70p">날짜</th>
						<th class="bgYlw w70p">이름</th>
						<th class="bgYlw">감상평 <span class="btn s gold"><a onclick="viewHidden(this)">+펼침</a></span></th>
					</tr>
					<tr style="height:1px;"></tr>
				</thead>
			</table>
		</div>
		<div style="padding-top:70px;">
			<input type="hidden" id="cardD" value="card">
			<form name="insertBook" id="insertBook" method="post">
				<table class="t_skinR00" style="width:100%">
					<tbody><c:set var="subBegin" value="0"/>
						<c:forEach var="book" items="${bookList}" varStatus="bookS">
						<tr <c:if test="${not empty book.rent}">class="bgRed"</c:if>>
							<td class="cent w70p" id="bookNumber${bookS.count}"><b>${book.bookNum}</b><c:if test="${baseUserLoginInfo.userName==book.usrNm}">
								<br/><span class="btn s red"><a onclick="delBook(${book.sNb})">삭제</a></span></c:if>
								<span class="btn s green"><a onclick="view('epilogue','${book.bookNum}')">후기</a></span>
							</td>
							<td class="cent w200p navy"><b><a onclick="view('book${bookS.count}')">${book.title}</a></b></td>
							<td class="cent w120p"><b>${book.author}</b></td>
							<td class="cent w70p"><span id="id4jstl${bookS.count}" class="btn m <c:if test='${book.epilogue == 0}'>orange</c:if> <c:if test='${book.epilogue == 1}'>gold</c:if> <c:if test='${book.epilogue == 2}'>blue</c:if>"><a onclick="view('staffL${bookS.count}','${book.bookNum}',this)"><c:if test='${book.epilogue == 0}'>전직원</c:if> <c:if test='${book.epilogue == 1}'>팀장급</c:if> <c:if test='${book.epilogue == 2}'>일반직원</c:if></a></span></td>
							<td class="cent w50p"><span class="btn s navy"><c:if test="${empty book.rent}"><a onclick="rent(${book.sNb},'1')">대여</a></c:if><c:if test="${not empty book.rent}"><a onclick="rent(${book.sNb},'0')">${book.rent}</a></c:if></span></td>
							<td class="cent pd0" colspan="3">
								<%--
								<c:if test="${baseUserLoginInfo.userName==book.usrNm}">
									<span class="btn s red"><a onclick="delbook(this, ${bookS.count})">삭제</a></span>
								</c:if>
								<c:if test="${not empty book.sNb }"><a class="memoBtn" id="mm_${bookS.count}"><img src="<c:url value='/images/edit-5-icon.png'/>" title="메모 입력" <c:if test="${fn:length(book.note)>1}">style="background-color:red"</c:if>></a></c:if>
								 --%>
								<table>
								<c:forEach var="ep" items="${epilogueList}" begin="${subBegin}" varStatus="epS"><c:if test="${book.bookNum == ep.bookNum}">
									<tr>
										<td class="cent w70p bd0">${ep.rgDt}<c:if test="${baseUserLoginInfo.userName==ep.usrNm}">
											<span class="btn s red"><a onclick="delEp('${ep.sNb}')">삭제</a></span></c:if></td>
										<td class="cent w70p bd0">${ep.usrNm}</td>
										<td class="bd0 epiHid" align="left">${ep.epilogue}</td>
									</tr>
								</c:if></c:forEach><c:set var="subBegin" value="${epS.count}"/>
								</table>
							</td>
						</tr>	<c:if test="${bookS.count == 1}"><c:set var="bookNumber" value="${book.bookNum}"/><c:set var="bookCnt" value="${fn:substring(book.bookNum,5,9)+1}"/></c:if>
						</c:forEach>
	<script>
		var BOOK_NUM = bookCount('${cur_year}','${bookCnt}','${bookNumber}');
		$("#nextBookNum").val(BOOK_NUM);
		$("#nextBookN").val(BOOK_NUM);
		//$("#saveBookBtn").attr("onclick","saveBook('"+BOOK_NUM+"')");
	</script>
					</tbody>
				</table>
			</form>
		</div>
	</section>
</div>
<div class="clear"></div>
</body>
</html>