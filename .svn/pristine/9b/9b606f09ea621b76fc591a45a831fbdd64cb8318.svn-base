function view(divId,e){ //divId : 보여주기위한 target divId
	// var browserWidth = document.documentElement.clientWidth;
	var clientW = document.documentElement.clientWidth/* 화명상 width */
	,	scrollW = document.documentElement.scrollWidth;/* scroll될 전체화면 width */
	var calWidth= $("#" + divId).outerWidth();
	var pstn = getPosition(e);
	var top = pstn.y;
	var left = pstn.x;
	var browserWidth = left>clientW?scrollW:clientW;
	$("#"+divId).css({"top":top+"px","left":(left+calWidth<browserWidth?left:browserWidth-(calWidth+8))+"px"});
	$("#"+divId).css('display','block');
	//$(".popUpMenu").hide();
	$("#"+divId).show();
}

function getPosition(e) {
    e = e || window.event;
	var ddE = document.documentElement;
	var db = document.body;
    var cursor = {x:0, y:0};
    if (e.pageX || e.pageY) {
        cursor.x = e.pageX;
        cursor.y = e.pageY;
		
    }else if (e.clientX || e.clientY) {
		cursor.x = e.clientX + (ddE.scrollLeft || db.scrollLeft) - ddE.clientLeft;
        cursor.y = e.clientY + (ddE.scrollTop  || db.scrollTop)  - ddE.clientTop;
    }
    return cursor;
}
$(document).on("click",".closePopUpMenu",function(event){
	// $(this).parent().hide();
	$(".popUpMenu").hide();
});

function statsOfferdivAjax(rgName, middleCd, e, pgCd, offerCd, infoProvCd, report, sort, supporterCd){
	var DATA;
	if(sort=='100'||sort=='200') {
		DATA = {
				choiceYear: $("#choiceYearS").val(),
				total: ($("#choiceMonth").val()<7 ? 'high':'low'),
				rgId: rgName,
				sort_t: sort
		};
	}else{
		DATA = {
				choiceYear: $("#choiceYearS").val(),
				total: ($("#choiceMonth").val()<7 ? 'high':'low'),
				rgNm: rgName,
				middleOfferCd: middleCd,
				progressCd: pgCd,
				offerCd: offerCd,
				infoProvider: infoProvCd,
				reportYN: report,
				sort_t: sort,
				supporter: supporterCd
		};
	}
	$.ajax({
		type:"POST",        //POST GET
		url:"../stats/statsPrivateOffer4Stats.do",     //PAGEURL
		data : DATA,
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		timeout : 30000,       //제한시간 지정
		cache : false,        //true, false
		success: function whenSuccess(arg){  //SUCCESS FUNCTION
			$("#offerDiv").html(arg);
			view("offerPr",e);
		},
		error: function whenError(x,e){    //ERROR FUNCTION
			ajaxErrorAlert(x,e);
		}
	});
}

function statsNetworkAjax(e, cntCst, cntCpn, staffId){
	var DATA = {
		choiceYear: $("#choiceYearS").val(),
		total: ($("#choiceMonth").val()<7 ? 'high':'low'),
		tmpNum1: cntCst,
		tmpNum2: cntCpn,
		rgId: staffId
	};

	$.ajax({
		type:"POST",        //POST GET
		url:"../stats/statsNetwork.do",     //PAGEURL
		data : DATA,
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		timeout : 30000,       //제한시간 지정
		cache : false,        //true, false
		success: function whenSuccess(arg){  //SUCCESS FUNCTION
			$("#offerDiv").html(arg);
			view("offerPr",e);
		},
		error: function whenError(x,e){    //ERROR FUNCTION
			ajaxErrorAlert(x,e);
		}
	});
}

//정보정리 팝업을 위한 ajax
function statsIntroducerOfferdivAjax(e,rgName, th, snb, report){
	var DATA = {
				sNb: snb,
				tmpNum1: "on",
				rgNm: rgName,
				reportYN: report,
				day: $(th).attr('name'),
				tmpNum2:$('#pageName').val()
		};
	$.ajax({
		type:"POST",        //POST GET
		url:"../stats/statsPrivateOffer.do",     //PAGEURL
		data : DATA,
		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
		timeout : 30000,       //제한시간 지정
		cache : false,        //true, false
		success: function whenSuccess(arg){  //SUCCESS FUNCTION
			$("#offerDiv2").html(arg);
			$("#offerDiv2").find('[id^=offerPr]').attr('id','offerPr2');
			$("#offerPr").css('z-index','900');
			$("#offerPr2").css('z-index','901');
			$("#offerPr2").find('[class^=closePopUpMenu]').addClass('closePopUpMenu2');
			$("#offerPr2").find('[class^=closePopUpMenu]').removeClass('closePopUpMenu');
			view("offerPr2",e);
			$("#closeTab2").mousedown(function(){
				$("#offerPr2").draggable();
			});
		},
		error: function whenError(x,e){    //ERROR FUNCTION
			ajaxErrorAlert(x,e);
		}
	});
}
$(document).on("click",".closePopUpMenu2",function(event){
	// $(this).parent().hide();
	$(this).parent().parent().hide();
});

function submitLH(halfYear){
	$("#total").val(halfYear);
	$("#dayForm").submit();
}

function ajaxModule(DATA,Url,Fn){
	$.ajax({
		type:"POST",        //POST GET
		url:Url,     //PAGEURL
		data : DATA,
		timeout : 30000,       //제한시간 지정
		cache : false,        //true, false
		success: function whenSuccess(arg){  //SUCCESS FUNCTION
			Fn(arg);
		},
		error: function whenError(x,e){    //ERROR FUNCTION
			ajaxErrorAlert(x,e);
		}
	});
}
function ajaxErrorAlert(x,e){
	if(x.status==0){
		alert('code: '+x.status+"\r\nYou are offline!!\r\nPlease Check Your Network.");
	}else if(x.status==404){
		alert('code: '+x.status+"\r\nRequested URL not found.");
	}else if(x.status==500){
		alert('code: '+x.status+"\r\nInternel Server Error.");
	}else if(e=='parsererror'){
		alert('code: '+x.status+"\r\nError.nParsing JSON Request failed.");
	}else if(e=='timeout'){
		alert('code: '+x.status+"\r\nRequest Time out.");
	}else {
		alert('code: '+x.status+"\r\nUnknow Error.\r\n"+x.responseText);
	}
}