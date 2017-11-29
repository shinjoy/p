﻿﻿document.write("<script src='"+contextRoot +"/js/sp/btn.js'></script>");

//주민등록번호 체크
function JuminNumChk(){
	var tmp = OnlyNum($('#PerJumin').val());
	if(tmp.length < '6') $('#PerJumin').val(tmp.replace('-', ''));
	else if(tmp.length == '6') $('#PerJumin').val(tmp + '-');
}

function JuminSet() {
	if($('#RegPerSabun').val() == '201301001' || $('#RegPerSabun').val() == '201509001' || $('#RegPerSabun').val() == '201504001') {
		if($('#PerBirthday').val().length == 10) {
			var tmp = replaceC($('#PerBirthday').val(), '-', '');
			$('#PerJumin').val(tmp.substring(2) + '-').focus();
		}
		else return false;
	}
}

// 쿠키 가져오기
function getWinCookie(WinId) {
	var nameOfCookie = WinId + "=";
	var oOo = 0;
	while(oOo <= document.cookie.length) {
		var y = (oOo + nameOfCookie.length);
		if (document.cookie.substring(oOo, y) == nameOfCookie) {
			if((endOfCookie=document.cookie.indexOf( ";", y )) == -1) endOfCookie = document.cookie.length;
			return unescape(document.cookie.substring(y, endOfCookie));
		}
		oOo = document.cookie.indexOf(" ", oOo) + 1;
		if(oOo == 0) break;
	}
	return "";
}

// 쿠키 저장
function setWinCookie(WinId, WinFlag, ExpireDays) {
//	var todayDate = new Date();
//	todayDate.setDate(todayDate.getDate() + ExpireDays); 호출된 시간부터 ExpireDays 시간까지 시간 설정

	var todayDate = new Date();
	todayDate = new Date(parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);	// 오늘 00시까지 시간 설정
	if(todayDate > new Date()) ExpireDays = ExpireDays - 1;
	todayDate.setDate( todayDate.getDate() + ExpireDays );
	document.cookie = WinId + "=" + escape(WinFlag) + "; path=/; expires=" + todayDate.toGMTString() + ";";
}

function TableScrolling() {
	document.getElementById('TitleTable').scrollLeft = document.getElementById('ContentTable').scrollLeft;
}

function PageView(Obj) {
	if($('#page_left', parent.document).attr('style').indexOf('none') != -1) {
		$('#page_left', parent.document).show();
		$('#page_content', parent.document).css('width', '85.8%');
		$('#topmenu table tr td').eq(0).children('a').eq(1).html('◀');
	}
	else {
		$('#page_left', parent.document).hide();
		$('#page_content', parent.document).css('width', '99%');
		$('#topmenu table tr td').eq(0).children('a').eq(1).html('▶');
	}
}

function ajaxModule(DATA, Url, Fn) {
	$.ajax({
		type:"POST",
		url:Url,
		data:DATA,
		timeout:30000,
		cache:false,
		success:function whenSuccess(arg) {
			Fn(arg);
		},
		error:function whenError(x, e) {
			ajaxErrorAlert(x, e);
		}
	});
}

function ajaxErrorAlert(x, e) {
	if(x.status == 0) {
		alert('code: '+x.status+"\r\nYou are offline!!\r\nPlease Check Your Network.");
	}
	else if(x.status == 404) {
		alert('code: '+x.status+"\r\nRequested URL not found.");
	}
	else if(x.status == 500) {
		alert('code: '+x.status+"\r\nInternel Server Error.");
	}
	else if(e == 'parsererror') {
		alert('code: '+x.status+"\r\nError.nParsing JSON Request failed.");
	}
	else if(e == 'timeout') {
		alert('code: '+x.status+"\r\nRequest Time out.");
	}
	else {
		alert('code: '+x.status+"\r\nUnknow Error.\r\n"+x.responseText);
	}
}

function FileSel(UpFiles) {
	var FileInfo = '', File;

	$('#FileInfo').html('');
	for(var oOo = 0; oOo < UpFiles.length; oOo++) {
		File = UpFiles[oOo];
		FileInfo += "파일명 : "+ File.name + " (크기 : "+ StringWithComma(File.size) +" bytes)<br/>";
	}
	$('#FileInfo').html(FileInfo);
}

// 브라우저 종류 받기
function WebChk() {
	var agt = navigator.userAgent.toLowerCase();
	if(agt.indexOf("chrome") != -1) return 'Chrome';
	else if(agt.indexOf("opera") != -1) return 'Opera';
	else if(agt.indexOf("staroffice") != -1) return 'Star Office';
	else if(agt.indexOf("webtv") != -1) return 'WebTV';
	else if(agt.indexOf("beonex") != -1) return 'Beonex';
	else if(agt.indexOf("chimera") != -1) return 'Chimera';
	else if(agt.indexOf("netpositive") != -1) return 'NetPositive';
	else if(agt.indexOf("phoenix") != -1) return 'Phoenix';
	else if(agt.indexOf("firefox") != -1) return 'Firefox';
	else if(agt.indexOf("safari") != -1) return 'Safari';
	else if(agt.indexOf("skipstone") != -1) return 'SkipStone';
	else if(agt.indexOf("msie") != -1) return 'Internet Explorer';
	else if(agt.indexOf("trident") != -1) return 'Internet Explorer';
	else if(agt.indexOf("netscape") != -1) return 'Netscape';
	else if(agt.indexOf("mozilla/5.0") != -1) return 'Mozilla';
}

// 마우스 우클릭 방지
function mouseClick() {
	//if((event.button == 2) || (event.button == 3)) alert("마우스 오른쪽 버튼을 사용 하실수 없습니다.");
	//if((event.ctrlKey) || (event.shiftKey)) alert("키를 사용할 수 없습니다.");
}
//document.onmousedown = mouseClick;	// 마우스 이벤트 받기
//document.onkeydown = mouseClick;	// 키보드 이벤트 받기

// 데이트피커
var DatePickerOpt = {
	inline: true,
	dateFormat: "yy-mm-dd",    /* 날짜 포맷 */
	prevText: 'prev',
	nextText: 'next',
	showButtonPanel: true,    /* 버튼 패널 사용 */
	changeMonth: true,        /* 월 선택박스 사용 */
	changeYear: true,        /* 년 선택박스 사용 */
	showOtherMonths: true,    /* 이전/다음 달 일수 보이기 */
	selectOtherMonths: true,    /* 이전/다음 달 일 선택하기 */
	showOn: "button",
	buttonImage: "images/sp/btn_cal.gif",
	buttonImageOnly: true,
	buttonText: "Calendar",
	minDate: '-30y',
	closeText: '닫기',
	currentText: '오늘',
	showMonthAfterYear: true,        /* 년과 달의 위치 바꾸기 */
	/* 한글화 */
	monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	dayNames : ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
	showAnim: 'slideDown',
	onSelect : function (SelDate) {
		if($('#SubmitFlag').val() == 'Y') $('form').submit();
		if($(this).attr('onblur') != undefined) document.getElementById($(this).attr('id')).onblur();
	},
	/* 날짜 유효성 체크
	onClose: function( selectedDate ) {
		$('#fromDate').datepicker("option","minDate", selectedDate);
	}*/
};

//데이트피커
var S_DatePickerOpt = {
	inline: true,
	dateFormat: "yy-mm-dd",    /* 날짜 포맷 */
	prevText: 'prev',
	nextText: 'next',
	showButtonPanel: true,    /* 버튼 패널 사용 */
	changeMonth: true,        /* 월 선택박스 사용 */
	changeYear: true,        /* 년 선택박스 사용 */
	showOtherMonths: true,    /* 이전/다음 달 일수 보이기 */
	selectOtherMonths: true,    /* 이전/다음 달 일 선택하기 */
	showOn: "button",
	buttonImage: contextRoot + "/images/sp/btn_cal.gif",
	buttonImageOnly: true,
	buttonText: "Calendar",
	closeText: '닫기',
	currentText: '오늘',
	showMonthAfterYear: true,        /* 년과 달의 위치 바꾸기 */
	/* 한글화 */
	monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	dayNames : ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
	showAnim: 'slideDown',
	yearRange: 'c-100:c+10',
//	onSelect : function (SelDate) {
//	},
	/* 날짜 유효성 체크 */
	/*onClose: function( selectedDate ) {
		if($(this).attr('id') == 'ScheSDate') {
			$('#ScheEDate').datepicker("option","minDate", selectedDate).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
		}
		else $(this).next().next().datepicker("option","minDate", selectedDate).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	}*/
};

var E_DatePickerOpt = {
	inline: true,
	dateFormat: "yy-mm-dd",    /* 날짜 포맷 */
	prevText: 'prev',
	nextText: 'next',
	showButtonPanel: true,    /* 버튼 패널 사용 */
	changeMonth: true,        /* 월 선택박스 사용 */
	changeYear: true,        /* 년 선택박스 사용 */
	showOtherMonths: true,    /* 이전/다음 달 일수 보이기 */
	selectOtherMonths: true,    /* 이전/다음 달 일 선택하기 */
	showOn: "button",
	buttonImage: contextRoot + "/images/sp/btn_cal.gif",
	buttonImageOnly: true,
	buttonText: "Calendar",
	minDate: '-30y',
	closeText: '닫기',
	currentText: '오늘',
	showMonthAfterYear: true,        /* 년과 달의 위치 바꾸기 */
	/* 한글화 */
	monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	dayNames : ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
	showAnim: 'slideDown',
	onSelect : function (SelDate) {
		if($('#SubmitFlag').val() == 'Y') $('form').submit();
		if($(this).attr('id') == 'HoliEDate') HoliPeriodCalcu();
		if($(this).attr('id') == 'ScheEDate') SchePeriodChk();
	},
	/* 날짜 유효성 체크 */
	onClose: function( selectedDate ) {
		/*if($(this).attr('id') == 'ScheEDate') {
			$('#ScheSDate').datepicker("option","maxDate", selectedDate).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
		} else $(this).prev().prev().datepicker("option","maxDate", selectedDate).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});*/
	}
};
/*	달력 오픈 이미지 관련	*/
function addZero(val){
	if(val.length == 1) val = "0" + val;
	return val;
}

var date = new Date();

/*date picker 버전 오류로 current 버튼 클릭시 무한 재귀호출 오류해결을위해 확장*/
$.datepicker._gotoToday = function(id) {
    $(id).datepicker('setDate', date);
};

// 오늘 날짜 받아오기
function GetToday() {
	var Yy = date.getFullYear();
	var Mm = "" + (date.getMonth() + 1);
	var Dd = "" + date.getDate();

	if(Mm.length == 1) Mm = "0" + Mm;
	if(Dd.length == 1) Dd = "0" + Dd;
	return Yy + "-" + Mm + "-" + Dd;
}

// 현재 시간 구하기
function GetNowTime(Type) {
	Hh = "" + date.getHours();
	Mi = "" + date.getMinutes();
	Ss = "" + date.getSeconds();
	if(Hh.length == 1) Hh = "0" + Hh;
	if(Mi.length == 1) Mi = "0" + Mi;
	if(Ss.length == 1) Ss = "0" + Ss;
	if(Type == "Hh") return Hh;
	else if(Type == "HhMi") return Hh + ":" + Mi;
	else return Hh + ":" + Mi + ":" + Ss;
}

// 두 날짜간 기간 구하기
function GetDiffDay(SDate, EDate, Flag) {
	SDateTmp = SDate.split('-');
	EDateTmp = EDate.split('-');
	var StartDate = new Date(SDateTmp[0], SDateTmp[1] - 1, SDateTmp[2]);
	var EndDate = new Date(EDateTmp[0], EDateTmp[1] - 1, EDateTmp[2]);

	var Interval = EndDate - StartDate;
	var Day = 1000*60*60*24;
	var Month = Day * 30;
	var Year = Month * 12;

	if(Flag == "Day") return parseInt(Interval/Day);
    else if(Flag == "Week") return parseInt(Interval/(Day*7));
    else if(Flag == "Month") return parseInt(Interval/Month);
    return parseInt(Interval/Year);
}

// 달력 오픈
function Open_Cal(ObjNm, SubmitFlag) {
	SelDate = document.getElementById(ObjNm).value;
	GetPWinLoc('-100', '20');
	var URL = "/SynergyCus/Calendar.do?ObjNm="+ ObjNm +"&SubmitFlag="+ SubmitFlag +"&SelDate="+ SelDate +"";
	window.open(URL, 'Calendar', 'width=210, height=240, scrollbars=no, top='+childY+', left='+childX+'');
}

function MM_swapImgRestore() { //v3.0
    var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
    var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function MM_findObj(n, d) { //v4.01
    var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
    if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
    for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
    if(!x && d.getElementById) x=d.getElementById(n); return x;
}
function MM_swapImage() { //v3.0
    var i,j=0,x,a=MM_swapImage.arguments;
    document.MM_sr=new Array;
    for(i=0;i<(a.length-2);i+=3)
    if ((x=MM_findObj(a[i]))!=null) {
          document.MM_sr[j++]=x;
          if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];
    }
}
/*	달력 오픈 이미지 관련	*/

/*	움직이는 말풍선		*/
function CreateLayer2(LayerId, Title, Content) {
	var nMouseTop = window.event.clientY;
	var nMouseLeft = window.event.clientX;
	var ScrollTop = document.body.scrollTop;
	if(WebChk() == 'Internet Explorer') ScrollTop = document.documentElement.scrollTop;
	var elDiv = document.getElementById(LayerId);
	var Layer = "";

	if(Content != '') {
		Layer += "<div class='Text_BL' style='border:1px solid #000000;background-color:yellow;padding:5px;border-radius:5px;'>";
		Layer += Title +"<br/><span style='font-size:11px;'>" + Content ;
		Layer += "</span></div>";
	}

	if(elDiv == null) {
		var elDiv = document.createElement("DIV");
		window.document.body.appendChild(elDiv);
		elDiv.id = LayerId;
		elDiv.style.zIndex = 10000;
		elDiv.style.position = "absolute";

		if(LayerId == 'PageCon') elDiv.style.top = nMouseTop + ScrollTop - 50 +'px';
		else elDiv.style.top = nMouseTop + ScrollTop + 'px';
		if(LayerId == 'ReCalcuLayer') elDiv.style.left = nMouseLeft - 200 + 'px';
		else if(LayerId == 'SumRealMoney') elDiv.style.left = nMouseLeft - 130 + 'px';
		else elDiv.style.left = nMouseLeft + 20 + 'px';
		elDiv.innerHTML = Layer;
	}
	else elDiv.innerHTML = Layer;
	elDiv.style.display = '';
}

function MoveLayer2(LayerId) {
	var nMouseTop = window.event.clientY;
	var nMouseLeft = window.event.clientX;
	var ScrollTop = document.body.scrollTop;
	if(WebChk() == 'Internet Explorer') ScrollTop = document.documentElement.scrollTop;

	var elDiv = document.getElementById(LayerId);
	if (elDiv != null) {
		if(LayerId == 'PageCon') elDiv.style.top = nMouseTop + ScrollTop - 50 +'px';
		else elDiv.style.top = nMouseTop + ScrollTop + 'px';
		if(LayerId == 'ReCalcuLayer') elDiv.style.left = nMouseLeft - 200 + 'px';
		else if(LayerId == 'SumRealMoney') elDiv.style.left = nMouseLeft - 130 + 'px';
		else elDiv.style.left = nMouseLeft + 20 + 'px';
	}
}

function RemoveLayer2(LayerId) {
	var elDiv = document.getElementById(LayerId);
	elDiv.style.display = 'none';
}

/*	움직이는 말풍선		*/

/*	프로세스 레이어		*/
function showLayer() {
	$('#prolayer').show();
}

function hideLayer() {
	$('#prolayer').hide();
}

function LayerClose(flag) {
	if(flag == 'View') {
		$("#BackDiv").remove();
		$("#ViewDiv").hide();
	}
	else {
		if(confirm("이 페이지에서 나가면 작성하던 내용들은 저장되지 않습니다.\n정말 나가겠습니까?")) {
			$("#BackDiv").remove();
			$("#ViewDiv").hide();
		}
	}
}

/*	프로세스 레이어		*/

// 파일 다운로드
function FileDown(URL, FilePath, FileUpNm, FileNm) {
	var Path = encodeURIComponent(FilePath);
	var UpNm = encodeURIComponent(FileUpNm);
	var Nm = encodeURIComponent(FileNm);
	window.open(URL+"?FilePath="+Path+"&FileUpNm="+UpNm+"&FileNm="+Nm);
}

// 다중 파일 다운로드
function downloadAll(URL, FileCnt, ObjNm, Flag) {
	var cnt = 0;
	for(var oOo = 1; oOo < FileCnt + 1; oOo++) {
		if(Flag == 'all') $('#'+ObjNm+oOo).attr('checked', true);
		if($('#'+ObjNm+oOo).is(":checked")) {
			FilePath = $('#'+ObjNm+oOo).val().split('_-_')[0];
			FileUpNm = encodeURIComponent($('#'+ObjNm+oOo).val().split('_-_')[1]);
			FileNm = encodeURIComponent($('#'+ObjNm+oOo).val().split('_-_')[2]);

			window.open(URL+"?FilePath="+FilePath+"&FileUpNm="+FileUpNm+"&FileNm="+FileNm);
			$('#'+ObjNm+oOo).attr('checked', false);
			cnt++;
		}
		else continue;
	}
	if(cnt == 0) alert('선택된 파일이 없습니다.');
}

// 경고창 띄우기
function InfoMessageView() {
	var message = $('#message').val();
    if(message != "") alert(message);
    if($('#message2').val() != undefined) {
    	var message2 = $('#message2').val();
    	if(message2 != "") alert(message2);
    }
}


// 마우스오버 메뉴 색상변경
function OverColor(Obj) {
	Obj.style.color ='#FF0000';
}

// 마우스오버 메뉴 색상변경
function OutColor(Obj) {
	Obj.style.color ='#000000';
}

// 하위 목록 열고 닫기
function TrOpen(tr) {
	try {
		if(tr.style.display == "none") tr.style.display = "";
		else tr.style.display = "none";
	} catch(e) {
		for(var _i = 0 ; _i < tr.length ; _i++) {
			if(tr[_i].style.display == "none") tr[_i].style.display = "";
			else tr[_i].style.display = "none";
		}
	}
}

// 숫자 천단위 구분
function NumFormat(ObjNm, Value) {
	var ValueTmp = '';
	var SosuFlag = false;
	if(Value.indexOf(".") >= 0) {
		SosuFlag = true;
		if(Value.split(".")[1] != '') ValueTmp = Value.split(".")[1];
		Value = Value.split(".")[0];
	}
	Value = OnlyNum(Value);
	Value = RemoveMark(Value,",");
	Value = StringWithComma(Value);
	if(SosuFlag) Value = Value + "." + ValueTmp;
	document.getElementById(ObjNm).value = Value;
}

// 숫자만 입력 가능
function OnlyNum(Value) {
	re = /[^0-9\.\,\-]/gi;
	return Value.replace(re,"");
}

function ReOnlyNum(Obj, Value) {
	re = /[^0-9\.\,\-]/gi;
	$('#'+Obj).val(Value.replace(re,""));
}

// 해당 문자열에서 선택된 값 삭제
function RemoveMark(ValueC,RMark) {
	var arr, result="", i=0;
	if(RMark) arr = ValueC.split(RMark);
	else arr = ValueC.split(",");
	do{
		result = result + arr[i];
	}while(++i < arr.length);
	return result;
}

// 캐릭터 일괄 변경
function replaceC(entry, out, add) {
	entry = entry +"";
	var TempA = entry.split(out);
	var ReTemp = "";
	for(var oo = 0 ; oo < TempA.length ; oo++){
		ReTemp = ReTemp + TempA[oo];
		if(oo < TempA.length-1) ReTemp = ReTemp + add;
	}
	return ReTemp;
}

// 문자열에 콤마추가
function StringWithComma(ValueC) {
	ValueC = ""+ValueC;
	var result="", i;
	for(i=0 ; i < ValueC.length ; i++){
		result = result + ValueC.charAt(i);
		iWhere = ValueC.length - 1 - i;
		if (!(iWhere%3)&&(ValueC.length>3)&&iWhere) result = result + ",";
	}
	if(result.charAt(0) == "-" && result.charAt(1) == ",") result = result.charAt(0)+result.substring(2,result.length);
	return result;
}

// 날짜 타입
function DateFormat(ObjNm, Value) {
	Value = OnlyNum(Value);
	Value = RemoveMark(Value,"-");
	Value = DateType(Value);
	document.getElementById(ObjNm).value = Value;
}

// 날짜형식(####-##-##)
function DateType(Value) {
	if(Value.length > 4) {
		if(Value.length < 7) result = Value.substring(0,4)+"-"+Value.substring(4,Value.length);
		else result = Value.substring(0,4)+"-"+Value.substring(4,6)+"-"+Value.substring(6,Value.length);
	}
	else result = Value.substring(0,Value.length);
	return result;
}

// 리스트 정렬 기준 변경
function ListOrderSet(URL, Target, form, Obj, ObjNm, OrderKey, OrderFlag) {
	if($('#OrderType').val() == "" || $('#OrderType').val() == "ASC") {
		$('#OrderType').val("DESC");
		Img = ObjNm+'(▼)';
	}
	else {
		$('#OrderType').val("ASC");
		Img = ObjNm+'(▲)';
	}
	$('#OrderKey').val(OrderKey);
	$('#OrderFlag').val(OrderFlag);
	$('#OrderObj').val(Obj);
	$('#OrderObjNm').val(Img);
	$('#'+form).attr('target', Target).attr('action', URL).submit();
}

//리스트 정렬 기준 변경
function ListOrderSet(URL, Target, form, Obj, ObjNm, OrderKey, OrderFlag, searchType) {
	if($('#OrderType').val() == "" || $('#OrderType').val() == "ASC") {
		$('#OrderType').val("DESC");
		Img = ObjNm+'(▼)';
	}
	else {
		$('#OrderType').val("ASC");
		Img = ObjNm+'(▲)';
	}
	$('#OrderKey').val(OrderKey);
	$('#OrderFlag').val(OrderFlag);
	$('#OrderObj').val(Obj);
	$('#OrderObjNm').val(Img);
	$('#searchType').val(searchType);

	$('#'+form).attr('target', Target).attr('action', URL).submit();
}

// 정렬값에 따른 타이틀 표시
function ListOrderTitleSet() {
	Obj = $('#OrderObj').val();
	if($('#OrderType').val() == "DESC") $('#'+Obj).html("<font color='blue'>"+$('#OrderObjNm').val()+"</font>");
	else $('#'+Obj).html("<font color='red'>"+$('#OrderObjNm').val()+"</font>");
}

// 컨텐츠로 다운받기
function ContentDown(form, DocType, DocNm, DocPage) {
	if(DocPage != "/ReportView.do") DocNm = "(" + GetToday() + ")" + $.trim(DocNm);
	$('#DocType').val(DocType);
//	form.action = "ContentDown.do?DocNm="+DocNm+"&DocPage="+DocPage+"";
//	form.submit();

	var input1 = document.createElement("input");
	var input2 = document.createElement("input");

	input1.setAttribute("type", "hidden");
	input1.setAttribute("name", "DocNm");
	input1.setAttribute("id", "DocNm");
	input1.setAttribute("value", DocNm);
	form.appendChild(input1);

	input2.setAttribute("type", "hidden");
	input2.setAttribute("name", "DocPage");
	input2.setAttribute("id", "DocPage");
	input2.setAttribute("value", DocPage);
	form.appendChild(input2);


	$('#DocNm').val(DocNm);
	$('#DocPage').val(DocPage);
	window.open('', 'content', 'width=210, height=240, scrollbars=no');
	form.action = 'ContentDown.do';
	form.target = 'content';
	form.submit();
}

// 문자열 길이 체크
function byteCheck(Obj, Len, DescNm) {
  var text = document.getElementById(Obj).value;
  var msglen = 0;
  msglen = reStrCount(text);

  if(msglen > Len) {
    removeStr = msglen - Len;
    alert(DescNm + '은 '+ Len +'를 넘을수 없습니다.\n입력하신 문장의 총길이는 ' + msglen + '입니다.\n초과되는 ' + removeStr + '바이트는 삭제됩니다.');
    document.getElementById(Obj).value = cutMsg(text, Len);
  }
}

// 문자열 길이 반환
function reStrCount(str) {
	var msglen = 0;

	for(var oOo = 0; oOo < str.length; oOo++) {
		var ch = str.charAt(oOo);
		if(escape(ch).length > 4) msglen += 2;
		else msglen++;
	}
	return msglen;
}

// 지정된 길이만큼 문자열 자르기
function cutMsg(str, Len) {
	var returnStr = '';
	var msglen = 0;

	for(var oOo = 0; oOo < str.length; oOo++) {
		var ch = str.charAt(oOo);
		//한글자가 2byte인지 1byte인지 체크
		if(escape(ch).length > 4) msglen += 2;
		else msglen++;
		if(msglen > Len) break;
		returnStr += ch;
	}
	return returnStr;
}

// 첨부파일 창 오픈
function File_View(File_Cnt, Max_Cnt) {
	for(var oOo = 1; oOo < Max_Cnt; oOo++) {
		document.all.FileInput[oOo].style.display = 'none';
	}
	for(var oOo = 1; oOo < File_Cnt; oOo++) {
		document.all.FileInput[oOo].style.display = '';
	}
}

// 체크박스를 이용한 일괄 체크
function Select_All(Obj) {
	var All = $('#'+Obj+'');
	var List = $('input[name='+Obj+'Ary]');

	if(!All.is(':checked')) {// 전체선택 체크박스가 해제되었다면
		for(var oOo = 0; oOo <= List.length - 1; oOo++) {// 모든 체크박스를 체크해제
			List[oOo].checked = false;
		}
	}
	else { // 그게 아니라면
		for(var oOo = 0; oOo <= List.length - 1; oOo++) {
			List[oOo].checked = true;// 모든 체크박스를 체크
		}
	}
}

// 일괄체크 후 카운팅
function Select_All_Cnt(Obj) {
	var List = $('input[name='+Obj+']');

	var cnt = 0;
	if(!List.length) {
		if(List.checked == true) cnt++;
	}
	else {
		for(var oOo = 0 ; oOo < List.length ; oOo++) {
			if(List[oOo].checked == true)  cnt++;
		}
	}
	return cnt;
}

// 전화번호 체크
function TelNumChk(ObjNm, Value, Flag) {
	Value = OnlyNum(Value);
	if(Flag == "Phone" && RemoveMark(Value,"-").length == 3) {
		if(PhoneNumChk(RemoveMark(Value,"-")) == 0) {
			alert('폰번호오류');
			document.getElementById(ObjNm).value = '';
			return false;
		}
	}
	Value = TelNumType(RemoveMark(Value,"-"));
	document.getElementById(ObjNm).value = Value;
}

// 핸드폰번호 체크
var PhoneNumAry = ["010", "011", "016", "017", "018", "019"];
function PhoneNumChk(Value) {
	var Cnt = 0;
	for(var oOo = 0; oOo < PhoneNumAry.length; oOo++) {
		if(PhoneNumAry[oOo] == Value) {
			Cnt++;
		}
	}
	return Cnt;
}

// 지역번호 있는 전화번호 체크
function TelNumType(ValueC) {
	var result = "";
	if(ValueC.length < 3) result = ValueC.substring(0,ValueC.length);
	else if(ValueC.length < 6) {
		if(ValueC.substring(0,2) == 02) result = ValueC.substring(0,2)+"-"+ValueC.substring(2,ValueC.length);
		else {
			if(ValueC.length == 3) result = ValueC.substring(0,ValueC.length);
			else result = ValueC.substring(0,3)+"-"+ValueC.substring(3,ValueC.length);
		}
	}
	else if(ValueC.length < 10) {
		if(ValueC.substring(0,2) == 02) result = ValueC.substring(0,2)+"-"+ValueC.substring(2,5)+"-"+ValueC.substring(5,ValueC.length);
		else {
			if(ValueC.length == 6) result = ValueC.substring(0,3)+"-"+ValueC.substring(3,ValueC.length);
			else result = ValueC.substring(0,3)+"-"+ValueC.substring(3,6)+"-"+ValueC.substring(6,ValueC.length);
		}
	}
	else {
		if(ValueC.substring(0,2) == 02) result = ValueC.substring(0,2)+"-"+ValueC.substring(2,6)+"-"+ValueC.substring(6,ValueC.length);
		else {
			if(ValueC.length == 10) result = ValueC.substring(0,3)+"-"+ValueC.substring(3,6)+"-"+ValueC.substring(6,ValueC.length);
			else result = ValueC.substring(0,3)+"-"+ValueC.substring(3,7)+"-"+ValueC.substring(7,ValueC.length);
		}
	}
	return result;
}

// 고급검색
function HighSearchViewSet() {
	if($('#HighSearchQuery').val() != '') {
		TrOpen(HighSearchGrp);
		var DataTmp = $('#HighSearchData').val(), View = '', OldView = '';

		for(var oOo = 0; oOo < DataTmp.split(",").length; oOo++) {
			var Obj = DataTmp.split(",")[oOo].split("=")[0], val = DataTmp.split(",")[oOo].split("=")[1];
			Btn = "Search_B_" + Obj.split('_')[1].replace("Sel", "");
			View = "Search_S_" + Obj.split('_')[1].replace("Sel", "");

			if(View != OldView) HighSearchSet(View);
			OldView = View;
			$('input:radio[name="'+Obj+'"]:input[value="'+val+'"]').attr("checked", true);
		}
	}
}

// 고급검색
var HighSearchFlag = true;
function HighSearch(Obj) {
	TrOpen(Obj);
	var Height = OnlyNum($('#PaddingTable').attr('style')).replace('-', '');

	if(HighSearchFlag) {
		Height = Number(Height) + 30;
		$('#PaddingTable').attr('style', 'padding-top:'+Height+'px;');
		HighSearchFlag = false;
	}
	else {
		Height = Number(Height) - 30;
		$('#PaddingTable').attr('style', 'padding-top:'+Height+'px;');
		HighSearchFlag = true;
	}
}

// 고급검색 선택 초기화
function HighSearchReset(Obj_Len) {
	for(var oOo = 1; oOo < Obj_Len; oOo++) {
//		$('#Search_B_' + oOo).attr('class', 'button btn_Gray');
		$('#Search_B_' + oOo).attr('name', 'Silver');
		var len = $('#Search_Len_' + oOo).val();
		for(var OoO = 1; OoO <= len; OoO++) {
			$('input:radio[name="Search_Sel'+oOo+'_'+OoO+'"]').attr("checked", false);
		}
		$('#Search_S_' + oOo).hide();
	}
	if($('#HighSearchSDate').val() != undefined) {
		$('#HighSearchEDate').val('');
		$('#HighSearchSDate').val('');
	}
}

// 고급검색 그룹 선택
function HighSearchSet(Obj) {
	var Btn = Obj.replace('_S', '_B');
	var Data = Obj.replace('_S', '_D');

	var Height = OnlyNum($('#PaddingTable').attr('style')).replace('-', '');
//	if($('#'+Btn).attr('class').split(" ")[1] == "btn_Gray") {
//		if($('#'+Data).height() == null) Height = Number(Height) + 30;
//		else Height = Number(Height) + $('#'+Data).height();
//
//		$('#PaddingTable').attr('style', 'padding-top:'+Height+'px;');
//		$('#'+Obj).show();
//		$('#'+Btn).attr('class', 'button btn_Orange');
//	}
//	else {
//		if($('#'+Data).height() == null) Height = Number(Height) - 30;
//		else Height = Number(Height) - $('#'+Data).height();
//
//		$('#PaddingTable').attr('style', 'padding-top:'+Height+'px;');
//		$('#'+Obj).hide();
//		$('#'+Btn).attr('class', 'button btn_Gray');
//	}


	if($('#'+Btn).attr('name') == "Silver") {
		if($('#'+Data).height() == null) Height = Number(Height) + 30;
		else Height = Number(Height) + $('#'+Data).height();

		$('#PaddingTable').attr('style', 'padding-top:'+Height+'px;');
		$('#'+Obj).show();
		$('#'+Btn).attr('name', 'Orange');
	}
	else {
		if($('#'+Data).height() == null) Height = Number(Height) - 30;
		else Height = Number(Height) - $('#'+Data).height();

		$('#PaddingTable').attr('style', 'padding-top:'+Height+'px;');
		$('#'+Obj).hide();
		$('#'+Btn).attr('name', 'Silver');
	}
}

//고급검색 완료
function HighSearchEnd(form, Obj_Len, action) {
	var HighSearchQuery = "", Oper = "", Column = "", Val = "", SelData = "";
	var HighCnt = 1;
	for(var oOo = 1; oOo < Obj_Len; oOo++) {
		var len = $('#Search_Len_' + oOo).val();
//		if($('#Search_B_' + oOo).attr('class').split(" ")[1] == "btn_Orange") {
//			for(var OoO = 1; OoO <= len; OoO++) {
//				if($('input:radio[name="Search_Sel'+oOo+'_'+OoO+'"]:checked').val() != undefined) {
//					HighSearchFlag = true;
//					Column = $('#Search_Column_'+oOo).val();
//					Oper = $('input:radio[name="Search_Sel'+oOo+'_'+OoO+'"]:checked').val().split("[_]")[1];
//					Val = $('input:radio[name="Search_Sel'+oOo+'_'+OoO+'"]:checked').val().split("[_]")[0];
//					if(Val != 'Date') {
//						if(HighCnt == 1) HighSearchQuery += "WHERE " + Column + " = '" + Val + "' ";
//						else HighSearchQuery += Oper + " " + Column + " = '" + Val + "' ";
//					}
//					else {
//						if(HighCnt == 1) HighSearchQuery += "WHERE " + Column + " BETWEEN '" + $('#HighSearchSDate').val() + "' AND '"+ $('#HighSearchEDate').val() +"' ";
//						else HighSearchQuery += Oper + " " + Column + " BETWEEN '" + $('#HighSearchSDate').val() + "' AND '"+ $('#HighSearchEDate').val() +"' ";
//					}
//					if(HighCnt == 1) SelData += "Search_Sel"+oOo+"_"+OoO+"="+$('input:radio[name="Search_Sel'+oOo+'_'+OoO+'"]:checked').val();
//					else SelData += ",Search_Sel"+oOo+"_"+OoO+"="+$('input:radio[name="Search_Sel'+oOo+'_'+OoO+'"]:checked').val();
//					HighCnt++;
//				}
//			}
//		}

		if($('#Search_B_' + oOo).attr('name') == "Orange") {
			for(var OoO = 1; OoO <= len; OoO++) {
				if($('input:radio[name="Search_Sel'+oOo+'_'+OoO+'"]:checked').val() != undefined) {
					HighSearchFlag = true;
					Column = $('#Search_Column_'+oOo).val();
					Oper = $('input:radio[name="Search_Sel'+oOo+'_'+OoO+'"]:checked').val().split("[_]")[1];
					Val = $('input:radio[name="Search_Sel'+oOo+'_'+OoO+'"]:checked').val().split("[_]")[0];
					if(Val != 'Date') {
						if(HighCnt == 1) HighSearchQuery += "WHERE " + Column + " = '" + Val + "' ";
						else HighSearchQuery += Oper + " " + Column + " = '" + Val + "' ";
					}
					else {
						if(HighCnt == 1) HighSearchQuery += "WHERE " + Column + " BETWEEN '" + $('#HighSearchSDate').val() + "' AND '"+ $('#HighSearchEDate').val() +"' ";
						else HighSearchQuery += Oper + " " + Column + " BETWEEN '" + $('#HighSearchSDate').val() + "' AND '"+ $('#HighSearchEDate').val() +"' ";
					}
					if(HighCnt == 1) SelData += "Search_Sel"+oOo+"_"+OoO+"="+$('input:radio[name="Search_Sel'+oOo+'_'+OoO+'"]:checked').val();
					else SelData += ",Search_Sel"+oOo+"_"+OoO+"="+$('input:radio[name="Search_Sel'+oOo+'_'+OoO+'"]:checked').val();
					HighCnt++;
				}
			}
		}
	}

	if(HighSearchFlag) {
		$('#HighSearchQuery').val(HighSearchQuery);
		$('#HighSearchData').val(SelData);
		form.action = action;
		form.submit();
	}
	else alert('선택된 고급검색 조건이 없습니다.');
}

// 메뉴 선택
function MenuSel(MenuNum, Len) {
	for(var oOo = 1; oOo < Len; oOo++) {
		$('#Btn'+oOo).attr("name", "Silver");
	}
	$('#Btn'+MenuNum).attr("name", "Violet");
	BtnSet();
}









///////////////////// 급여시스템 사용중
// 방향키로 텍스트박스 조작
function KeyControl(Obj, ObjNm, event) {
	var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
	var Focus_Num = '';
	if(keyCode == '13' || keyCode == '40' || keyCode == '38') {
		for(var oOo = 0; oOo < Obj.form.elements.length; oOo++) {
			if(Obj == Obj.form.elements[oOo]) {
				if(keyCode == '38') Focus_Num = Number(Obj.form.elements[oOo].id.replace(ObjNm, "")) - 1;
				else if(keyCode == '13' || keyCode == '40') Focus_Num = Number(Obj.form.elements[oOo].id.replace(ObjNm, "")) + 1;
				break;
			}
		}
		if(Focus_Num != '0' && Focus_Num <= $('#AddCnt').val()) {
			if($('#'+ObjNm + Focus_Num)) $('#'+ObjNm + Focus_Num).focus();
		}
	}
	else if(keyCode == '37' || keyCode == '39') {
		for(oOo = 0; oOo < Obj.form.elements.length; oOo++) {
			if(Obj == Obj.form.elements[oOo]) {
				if(keyCode == '37') {
					Focus_Num = Obj.form.elements[(oOo - 1)];
					if(Focus_Num.readOnly || Focus_Num.type == 'hidden') {
						Focus_Num = Obj.form.elements[Next_Ele(Obj, keyCode, oOo)];
						break;
					}
					else break;
				}
				else {
					Focus_Num = Obj.form.elements[(oOo + 1)];
					if(Focus_Num.readOnly || Focus_Num.type == 'hidden') {
						Focus_Num = Obj.form.elements[Next_Ele(Obj, keyCode, oOo)];
						break;
					}
					else break;
				}

			}
		}
		if(Focus_Num) $('#'+Focus_Num.id).focus();
	}
}

function Next_Ele(Obj, keyCode, seq) {
	do {
		if(keyCode == '37') {
			Focus_Num = Obj.form.elements[(seq - 1)];
			seq--;
		}
		else {
			Focus_Num = Obj.form.elements[(seq + 1)];
			seq++;
		}
	}
	while(Focus_Num.readOnly || Focus_Num.type == 'hidden');
	return seq;
}

//텍스트박스 인포커스(기본)
function BaseInFocus(Obj) {
	$('#'+Obj).css('background-color', '#D9FFFF');
}

//텍스트박스 아웃포커스(기본)
function BaseOutFocus(Obj) {
	$('#'+Obj).css('background-color', '#FFFFFF');
}

// 텍스트박스 인포커스(input_box)
function InFocus(Obj) {
	$('#'+Obj).removeClass('input_box');
	$('#'+Obj).addClass('input_box_focus');
}

//텍스트박스 아웃포커스(input_box)
function OutFocus(Obj) {
	$('#'+Obj).removeClass('input_box_focus');
	$('#'+Obj).addClass('input_box');
}

//텍스트박스 인포커스(타이틀)
function InFocus(Obj, Target) {
	var Class = $('#'+Obj).attr('class');
	$('#'+Target).removeClass('grid_title');
	$('#'+Target).addClass('grid_title_focus');
	if($('#'+Obj).attr('type') != 'checkbox') {
		$('#'+Obj).removeClass(Class);
		$('#'+Obj).addClass(Class+'_focus');
	}
}

//텍스트박스 아웃포커스(타이틀)
function OutFocus(Obj, Target) {
	var Class = $('#'+Obj).attr('class').replace('_focus', '');
	$('#'+Target).removeClass('grid_title_focus');
	$('#'+Target).addClass('grid_title');
	if($('#'+Obj).attr('type') != 'checkbox') {
		$('#'+Obj).removeClass(Class+'_focus');
		$('#'+Obj).addClass(Class);
	}
}

//마우스오버
function MouseInOut(Num, Cnt, InColor, OutColor, Flag) {
	if(Flag == "In") Color = InColor;
	else Color = OutColor;
	for(var oOo = 1; oOo < Cnt; oOo++) {
		$('#Tr_'+oOo+Num).css('background', Color);
	}
}
/**************************/


var childX, childY, NowX, NowY;
// 현재 마우스 위치를 통한 자식창 위치 값 얻기
function GetPWinLoc(SumX, SumY) {
	var parentX = window.screenLeft; //opener X좌표
	var parentY = window.screenTop; //opener Y좌표
	childX = parentX + NowX + Number(SumX);
	childY = parentY + NowY + Number(SumY);
}

// 현재 마우스 위치 받아오기
function fnMouseMove (evt) {
	var x = document.all ? event.clientX : document.layers ? evt.x : evt.clientX;
	var y = document.all ? event.clientY : document.layers ? evt.y : evt.clientY;
	NowX = x;
	NowY = y;
}

//넷스케이프 4일 경우 추가
if (document.layers) document.captureEvents(Event.MOUSEMOVE);
// 넷스케이프 4 및 익스플로러 4 이상
if (document.layers || document.all) document.onmousemove = fnMouseMove;
// 넷스케이프 6일 경우
if (document.addEventListener) document.addEventListener('mousemove', fnMouseMove, true);

// 객체 보이기
function Obj_Show(elementId) {
	var element = document.getElementById(elementId);
	if(element) element.style.display = '';
}

// 객체 숨기기
function Obj_Hide(elementId) {
	var element = document.getElementById(elementId);
	if(element) element.style.display = 'none';
}

// 부모창 닫기
function ParentWinClose() {
	IE7 = navigator.userAgent.toLowerCase().indexOf('msie 7') != -1;
	IE8 = navigator.userAgent.toLowerCase().indexOf('msie 8') != -1;

	if(IE7) {
		window.open('about:blank', '_self').close();
	}
	else if(IE8) {
		window.opener = "nothing";
		window.open('', '_parent', '').close();
	}
	else {
		opener = self;
		opener.close();
	}
}

// 객체 데이터 길이 체크
function ObjLenCheck(ObjNm, Len, DescNm) {
	if(Number(document.getElementById(ObjNm).value) >= Len) {
		var key = event.keyCode;
		if(!(key==8||key==16||key==13||key==46||key==144||(key>=33&&key<=40)||(key>=16&&key<=21))){
			alert(''+ DescNm +'는 '+ Len +'글자를 넘을 수 없습니다.');
			event.returnValue = false;
		}
	}
}

// 체크박스를 이용한 이벤트
function Chk_Event(FormNm, ObjNm, CMD, ProcTxt) {
	var cnt = 0;	// 선택된 수
	var flag = '';

	if(!ObjNm.length) {
		if(ObjNm.checked==true) cnt++;
	}
	else {
		for(var oOo = 0; oOo < ObjNm.length; oOo++) {
			if(ObjNm[oOo].checked==true)  cnt++;
		}
	}
	if(cnt==0) alert('선택된 데이터가 없습니다.');
	else if(cnt==1) flag = confirm(ProcTxt);
	else flag = confirm(''+ cnt +' 건이 선택되었습니다. 모두 '+ ProcTxt +'');
	if(flag) {
		document.getElementById("CMD").value = CMD;
		FormNm.target = "hiddenfram";
		FormNm.submit();
	}
}
//월만 표시하는 달력
function monthPickerWrap(formId){

	$( formId ).MonthPicker({
		Button: false ,
		MaxMonth: -1 ,
		MonthFormat: 'yy/mm', // Short month name, Full year.
	}).attr('readonly','readonly');
	$( formId ).after('<img class="ui-monthpicker-trigger" src="'+contextRoot + "/images/sp/btn_cal.gif"+'">');
	$(".ui-monthpicker-trigger").click(function(){
		$(this).prev().focus();
	})

}