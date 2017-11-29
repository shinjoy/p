function month(mon,url){//월 선택
	 var frm = document.modifyRec;
	 $('#choiceMonth').val(mon);
	 frm.action = url;
	 frm.submit();
}

String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/gi, "");
};

/*Object.defineProperty(Object.prototype, "is_null", {
	value: function(){
		if (this === null || String(this).trim() === "") return true;
		else return false;
	}
});*/
function cardSubmit(th){
	$("input").css('background-color','');
	var obj = $(th).parent().parent().parent();
	var tmdt = obj.find("[id^=tmDt]");
	var cstSnb = obj.find("[id^=cstSnb]");
	var place = obj.find("[id^=place]");
	var dv = obj.find("[id^=dv]");
	var dv2 = obj.find("[id^=dv2]");
	var price = obj.find("[id^=price]");

	if(tmdt.val().is_null()){
		alert("일자를 선택하세요.");
		return 0;
	}
	if(cstSnb.val().is_null()){
		alert("대상자를 선택하세요.");return 0;
	}

	var len = $("input[name=memoSndName]:checkbox:checked").length;
	if(len<1){
		alert("시너지 참석자를 선택하세요.");return 0;
	}

	if(place.val().is_null()){
		place.focus();
		place.css('background-color','#A9F5BC');
		alert("장소를 입력하세요.");return 0;
	}
	if(dv.val().is_null()){
		dv.focus();
		dv.css('background-color','#A9F5BC');
		alert("업태를 선택하세요.");return 0;
	}
	if((dv.val()=='1'||dv.val()=='2'||dv.val()=='3'||dv.val()=='4') && dv2.val().is_null()){	//20150713 업태 구분추가(식사 >> 점심, 저녁 구분)
		dv2.focus();
		dv2.css('background-color','#A9F5BC');
		alert("식사구분을 선택하세요.");return 0;
	}
	if(price.val().is_null()){
		price.focus();
		price.css('background-color','#A9F5BC');
		alert("금액을 입력하세요.");return 0;
	}
	$(th).hide();
	var frm = document.getElementById('insertCard');//sender form id
	frm.action = "insertUsed.do";//target frame name
	frm.submit();
}

function numbersonly(e, decimal) {//input박스 숫자만 입력받기
	var key;
	var keychar;

	if (window.event) {
		key = window.event.keyCode;
	} else if (e) {
		key = e.which;
	} else {
		return true;
	}
	keychar = String.fromCharCode(key);

	if ((key == null) || (key == 0) || (key == 8) || (key == 9) || (key == 13)
			|| (key == 27)) {
		return true;
	} else if ((("0123456789").indexOf(keychar) > -1)) {
		return true;
	} else if (decimal && (keychar == ".")) {
		return true;
	} else
		return false;
}

function selectStaff(){
	// var obj = $(this).parent().parent();
	var obj = $("input[name=memoSndName]:checkbox:checked");
	var name = "";
	for(var i = 0; i<obj.length ; i++){

		var objN = $("input[name=memoSndName]:checkbox:checked:eq("+i+")");
		// if(objN.is(":checked")==false){i-=1; continue;}
		name += objN.val()+" ";
	}
	$("#test").hide();
	$("#0_0_staff_0").val(name);
}


	//노트 저장 버튼
	/*
$(".bsnsPsave").live("click",function(){
	var obj = $(this);
	var num = obj.attr('id').split('_');
	$.ajax({
		type:"POST",        //POST GET
		url:"../bsnsPlan/insertBsnsPlanNote.do",     //PAGEURL
		data : ({sNb: $('#bsnsPsnb'+num[1]).val(),
				note: $('#memoarea'+num[1]).val(),
				}),
		timeout : 30000,       //제한시간 지정
		cache : false,        //true, false
		success: function whenSuccess(arg){  //SUCCESS FUNCTION
			$("#bsnsPmemo_"+num[1]).hide();
		},
		error: function whenError(e){    //ERROR FUNCTION
			alert("code : " + e.status + "\r\nmessage : " + e.responseText);
		}
	});
});*/
function bsnsPsave(page, tempNum){
	var obj = $(this);
	var num = tempNum.split('_');
	var pUrl;
	if(page=='bsnsPlan') pUrl = "../bsnsPlan/insertBsnsPlanNote.do";
	else if(page=='card') pUrl = "../card/insertCardFeedback.do";
	$.ajax({
		type:"POST",        //POST GET
		url:pUrl,     //PAGEURL
		data : ({sNb: $('#bsnsPsnb'+num[1]).val(),
				note: $('#memoarea'+num[1]).val(),
				feedback: $('#memoarea'+num[1]).val()
				}),
		timeout : 30000,       //제한시간 지정
		cache : false,        //true, false
		success: function whenSuccess(arg){  //SUCCESS FUNCTION
			$("#bsnsPmemo_"+num[1]).hide();
		},
		error: function whenError(e){    //ERROR FUNCTION
			alert("code : " + e.status + "\r\nmessage : " + e.responseText);
		}
	});
}

function delCardUsed(th, cnt){
	var snb = $("#snb"+cnt).val();
	var pUrl = "../card/deleteCardUsed.do";

	if(confirm("삭제하시겠습니까?")){
		$.ajax({
			type:"POST",        //POST GET
			url:pUrl,     //PAGEURL
			data : ({sNb: snb}),
			timeout : 30000,       //제한시간 지정
			cache : false,        //true, false
			success: function whenSuccess(arg){  //SUCCESS FUNCTION
				$("#insertCard").submit();
			},
			error: function whenError(e){    //ERROR FUNCTION
				alert("code : " + e.status + "\r\nmessage : " + e.responseText);
			}
		});
	}
}


function sortTable(flag){
	$("#sorting").val(flag);
	document.modifyRec.submit();
}


function popUp(num,flag,nm,snb){
	var sUrl = "../work/popUpCst.do";
	sUrl+='?f='+flag+'&n=0';
	var w = '500';
	var h = '600';
	var ah = screen.availHeight - 30;
	var aw = screen.availWidth - 10;
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
	//var rVal = showModalDialog(sUrl, val, option);
}

function returnPopUp(rVal){
	if(rVal.f=='card'){
		$("#cstSnb").val(rVal.snb);
		$("#sltNm").html(rVal.nm);
		$("#sltCpn").html(rVal.cpnNm);
		$("#sltPst").html(rVal.position);
		$("#sltCst").css('display','');
		// $("#sltCst").html("외 <input type=\"text\" name=\"etcNum\" style=\"height:15px;width:14px;\"/>명");

	}
	// $("input[id^=foCus"+num+"]").focus();
}
