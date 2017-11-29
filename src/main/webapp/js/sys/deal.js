
String.prototype.trim = function(){
	    return this.replace(/(^\s*)|(\s*$)/gi, "");
};

/*
Object.defineProperty(Object.prototype, "is_null", {
	value: function(){
		if (this === null || String(this).trim() === "") return true;
		else return false;
	}
});
*/

/******* 초기화(event, etc..) *******/
$(function(){
	
	
	
	/*
	//분석상태 셀렉트박스 선택 이벤트
	$('#sel_analStatus').change(function(){
		
		//상태값 update
		$.ajax({
			type: "POST",        								//POST GET
			dataType: "json",									//JSON data type
			url: "<c:url value='/sys/deal/updateAnalStatus.do'/>",    	//PAGEURL
			data : ({
				offerSnb	:  
				analStatus	: $(this).val()	//상태코드
			}),
			timeout : 30000,       				//제한시간 지정
			cache : false,        				//true, false
			success: function whenSuccess(arg){ //SUCCESS FUNCTION
				//$("#tab1").html(arg);
				//$("#tab1").attr('src', arg);
				alert(arg);
			},
			error: function whenError(x,e){    //ERROR FUNCTION
				alert(x.responseText);
			}
		});
		
	});
	*/
	
	
});


function dealInfo(num, flag, nm, snb){
	
	var w = '950';
	var h = '755';
	var ah = screen.availHeight - 30;
	var aw = screen.availWidth - 10;

	var sUrl = '';
	
	
	if(flag=='rcmdComment'){
		sUrl = "../sys/deal/dealInfoTabMain.do";	
		var tmDate = num.split('-');
		sUrl+='?sNb='+snb+'&choiceYear='+tmDate[0]+'&choiceMonthS='+tmDate[1];
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
}

//저장 공통함수.
function saveAjax(url, paramObj){
	
	//상태값 update
	$.ajax({
		type: "POST",        				//POST GET
		//dataType: "json",					//JSON data type
		url: url,    						//PAGEURL
		data : paramObj,
		timeout : 30000,       				//제한시간 지정
		cache : false,        				//true, false
		success: function whenSuccess(arg){ //SUCCESS FUNCTION
			var obj = JSON.parse(arg);		//위에서 dataType: "json" 으로 하면 자동변환되므로 파싱이 필요없다.
			if(obj.result == "SUCCESS"){ //alert("저장하였습니다!");
				
				//$.blockUI({message : "저장하였습니다!<br><br><input type='button' value='닫기' onclick='removeModal();' />"});
				alertMsg("저장하였습니다!");
				
			}else{	//"FAIL"
				if(obj.resultVal == "SESSION"){		//session out
					alertLogin();					//login pop
				}else{
					//alert("[FAIL!!]\n\n" + decodeURIComponent(obj.resultMsg));
					alertMsg("[FAIL!!]\n\n" + decodeURIComponent(obj.resultMsg));
				}
			}
		},
		error: function whenError(x,e){    //ERROR FUNCTION
			alert(x.responseText);
		}
	});
	
}

//모달 메세지 팝업(전체창)
function alertMsg(msg){
	$.blockUI({
		message : msg + "<br><br><input type='button' value='닫기' onclick='removeModal();' />",
		css : {
			border : '1px solid #0000ff'
		}
	});
}
//모달 메세지 닫기(전체창)
function removeModal(){
	$.unblockUI();
}
//모달 메세지 닫기(전체창)
function removeModalNReload(){
	$.unblockUI();
	location.reload();
}

/* ********* 특정 엘리먼트 (block, unblock) *********
$("#blocklayer").block({message : "<input type='button' value='모달닫기' onclick='removeModal()' />"})
$("#blocklayer").unblock();
*/


function alertLogin(){
	//<c:url value='login/ibLoginUsr.do'/>
	$.blockUI({
		message : "<b>SESSION OUT!!</b><br><iframe src='/PASS/login/ibLoginUsr.do' width='100%' height='300' border='0' style='border:hidden'></iframe><br><br><input type='button' value='닫기' onclick='removeModalNReload();' />",		
		css : {
			border : '1px solid #0000ff'
		}
	});
	
}