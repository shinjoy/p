$(document).ready(function(){
/* 	$('.Toogle').hover(function(){
		$(this).find('[class*=ToogleIpt]').next().fadeIn('slow');
		//$('.ToogleIpt').next().toggle('fast');
	},function(){
		$(this).find('[class*=ToogleIpt]').next().delay(5000).fadeOut('fast');
	}); */
});
function memoDivAjax(th,e,snb,mainSnb){
	var DATA = {sNb: snb};
	if(!(mainSnb==null||mainSnb=='')) DATA = {sNb:snb,mainSnb: mainSnb};
	var fn = function(arg){
		$("#offerDiv").html(arg);
		var day = $(th).parent().parent().attr('class').split('day')[1];
		if(!(day==null||day=='')) $("#offerDiv").find('[id^=memoSNb]').attr('id','memoSNb'+day);
		view("offerPr",'',e);
	};
	ajaxModule(DATA,"../main/privateMemo.do",fn);
}

function view(divId,th,e){ //divId : 보여주기위한 target divId
	var browserWidth = document.documentElement.clientWidth
	   ,browserHeight = document.documentElement.clientHeight;
	var calWidth= $("#" + divId).outerWidth()
	   ,calHeight= $("#" + divId).outerHeight();
	var pstn = getPosition(e)
	    ,top = pstn.y
	    ,left = pstn.x;

	//var rtnTop = e.clientY < calHeight? top : top-(calHeight+5)-100;
	//$("#"+divId).css({"top":(e.clientY+calHeight<browserHeight?top - 200 : rtnTop)+"px","left":(left+calWidth<browserWidth?left-200:0)+"px"});

	var rtnTop = $('.main_con').scrollTop()+(top-200);
	rtnTop = (top > 500? rtnTop-200 : rtnTop);

	$("#"+divId).css({"top":rtnTop+"px","left":(left-300)+"px"});	//(left+calWidth<browserWidth?left-200:0)+"px"});
	//$("#"+divId).css({"top":(e.clientY+calHeight<browserHeight?top:rtnTop)+"px","left":(left+calWidth<browserWidth?left:browserWidth-(calWidth+8))+"px"});
	$("#"+divId).css('display','block');
	$(".popUpMenu").hide();
	$("#"+divId).show();
}

function viewNhide(divId,th,e){ //divId : 보여주기위한 target divId
	var browserWidth = document.documentElement.clientWidth
	   ,browserHeight = document.documentElement.clientHeight;
	var calWidth= $("#" + divId).outerWidth()
	   ,calHeight= $("#" + divId).outerHeight();
	var pstn = getPosition(e)
	    ,top = pstn.y
	    ,left = pstn.x;
	var rtnTop = top<calHeight?top:top-(calHeight+5);
	$("#"+divId).css({"top":(top+calHeight<browserHeight?top:rtnTop)+"px","left":(left+calWidth<browserWidth?left:browserWidth-(calWidth+8))+"px"});
	$("#"+divId).css('display','block');
	$("#"+divId).show();
}

function getPosition(e) {
   e = e || window.event;
   var cursor = {x:0, y:0};
   if (e.pageX || e.pageY) {
       cursor.x = e.pageX;
       cursor.y = e.pageY;
   }else {
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

function viewRepl(day, cnt, th, repSNb){
	var divId = day+"replyPr"+ cnt;
	$(".popUpMenu").hide();
	divShow($(th),divId);
	if($("#repSNb"+day+"_"+cnt).val()==repSNb) {
		$(".repEdit").css('display','');
		$(".repView").css('display','none');
	}else{
		$(".repEdit").css('display','none');
		$(".repView").css('display','');
	}
	$("#MM_"+day+"_"+cnt).focus();

}

//메모확인 클릭시
function chkOk(th,f){
	$(".popUpMenu").hide();
	var obj = $(th).parent().parent();
	var DATA = {
			memoSNb: obj.find('[id^=memoSNb]').val(),
			sttsCd: '00002',
			rgId: $('#rgstId').val(),
			importance: obj.find('[id^=importance]').val(),
			focus: obj.find('[id^=MM_]').attr('id').split('_')[1]
			};
	var url = "../work/checkMemo.do";
	var fn = function(arg){
		$('#focus').val(arg);
		if(f==='popUpMemo') document.modifyRec.action = "popUpMemo.do";
		else document.modifyRec.action = "selectPrivateWorkV.do";
		document.modifyRec.submit();
	};
	ajaxModule(DATA, url, fn);
}
function memoActAfterSave(f){
	var fileHtml = $("#file_list").html();
	//console.log(fileHtml);
	if(fileHtml!='undefined'&&fileHtml!=''){
		if(f==='popUpMemo') $("#m_rtn").val('work/popUpMemo');
		else $("#m_rtn").val('work/selectPrivateWorkV');
		$("#multiFile_N_comment").submit();

	}else{

		if(document.modifyRec == undefined){
			document.location.reload();
			return;
		}

		if(f==='popUpMemo') document.modifyRec.action = "popUpMemo.do";
		else document.modifyRec.action = "selectPrivateWorkV.do";
		document.modifyRec.submit();
	}
}
//메모 내용수정 확인
function memo_btnOk(th,f){
	$(".popUpMenu").hide();
	var obj = $(th).parent().parent();
	var DATA = null;
	var url = null;
	var fn = function(arg){
			// console.log(arg);
			var rtnSmsVal = arg;
			rtnSmsVal = rtnSmsVal.split('SMSreturnValueOK')[0].length;
			if(rtnSmsVal<1000){
				$("#frmSMS").remove();
				$("#uploadIFrame").append(arg);
				$("#frmSMS").submit();
				setTimeout(memoActAfterSave(f),1000);
			}else{
				memoActAfterSave(f);
			}
		};
	var day = obj.find('[id^=memoSNb]').attr('id').split('b');
	day = parseInt(day[1])<10?('0'+day[1]):day[1];
	$('#focus').val(day);

//insert
	if(obj.find('[id^=memoSNb]').val()==""){
		DATA = {
				memoSndName: $('#am_Name').val(),
				comment: obj.find('[id^=memoarea]').val(),
				choiceYear: $('#choiceYear').val(),
				choiceMonth: $('#choiceMonth').val(),
				day: day,
				rgId: $('#rgstId').val(),
				subMemo: "N",
				importance: obj.find('[id^=importance]').val(),
				priv: obj.find('[id^=priv]').val(),
				SMSTitle: $('#am_SMSTitle').val(),
				major: $('#am_majorBsns').val(),
				tmpNum1: obj.find('[id^=DirectRecord]').val(),
				tmpNum2: $('#loginName').val()
				};

		url = "../work/insertMemo.do";
		ajaxModule(DATA, url, fn);
//update
	}else{
		var OLDcomment = obj.find('[id^=oldMemoComment]').val().split('(');
		DATA = {
				memoSNb: obj.find('[id^=memoSNb]').val(),
				comment: obj.find('[id^=memoarea]').val(),
				rgId: $('#rgstId').val(),
				oldcomment: OLDcomment[0],
				tmDt: obj.find('[id^=oldMemoTmdt]').val(),
				subMemo: "N",
				importance: obj.find('[id^=importance]').val(),
				major: $('#am_majorBsns').val(),
				priv: obj.find('[id^=priv]').val()
				};
		url = "../work/modifyMemo.do";
		ajaxModule(DATA, url, fn);
	}
}

//메모 내용 삭제
function memo_btnDel(th,f){
	if(confirm("DB에서 완전삭제 처리됩니다. \n삭제하시겠습니까?")){
		$(".popUpMenu").hide();
		var obj = $(th).parent().parent();
		var DATA = {memoSNb: obj.find('[id^=memoSNb]').val()};
		var url = "../work/deleteMemo.do";
		var fn = function(){
			if(f==='popUpMemo') document.modifyRec.action = "popUpMemo.do";
			else document.modifyRec.action = "selectPrivateWorkV.do";
			document.modifyRec.submit();
		};
		ajaxModule(DATA, url, fn);
	}
}

///선택시 check open
function openDiv(divCode){
	$("#dl_"+divCode).css("display","");
	$("#span_"+divCode).attr('onclick','hiddenDiv(\''+divCode+'\')');
	$("#btn_"+divCode).attr('class','axi-keyboard-arrow-up');

}
///선택시 check hidden
function hiddenDiv(divCode){
	$("#dl_"+divCode).css("display","none");
	$("#span_"+divCode).attr('onclick','openDiv(\''+divCode+'\')');
	$("#btn_"+divCode).attr('class','axi-keyboard-arrow-down');

}