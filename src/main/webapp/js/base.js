$(function () {
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
	}
	/* $('.closePopUpMenu').live("click",function(event){
		$(this).parent().hide();
	}); */
	$(document).on("click",".closePopUpMenu",function(){
		$(this).parent().hide();
	});
	

});

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
        // cursor.x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
        // cursor.y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
/*         cursor.x = e.clientX + 
            (document.documentElement.scrollLeft || document.body.scrollLeft) - 
            document.documentElement.clientLeft;
        cursor.y = e.clientY + 
            (document.documentElement.scrollTop || document.body.scrollTop) - 
            document.documentElement.clientTop; */

String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/gi, "");
};

	if(!Object.prototype.is_null){		//정의되어 있지 않으면 추가
		
		Object.defineProperty(Object.prototype, "is_null", {
			value: function(){
				if (this === null || String(this).trim() === "") return true;
				else return false;
			}
		});
	}

	
	/* 
var is_null = function(check){
	if(check===null||check.trim()==="") return true;
	else return false;
};
Object.prototype.is_null = function () {
	if (this === null || String(this).trim() === "") return true;
	else return false;
}; */
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

	if ((key == null) || (key == 0) || (key == 8) || (key == 9) || (key == 13) || (key == 27)) {
		return true;
	} else if ((("0123456789").indexOf(keychar) > -1)) {
		return true;
	} else if (decimal && (keychar == ".")) {
		return true;
	} else
		return false;
}

function view(divId,th,e){ //divId : 보여주기위한 target divId
	var browserWidth = document.documentElement.clientWidth;
	var calWidth= $("#" + divId).outerWidth();
	var pstn = getPosition(e);
	var top = pstn.y;
	var left = pstn.x;
	$("#"+divId).css({"top":top+"px","left":(left+calWidth<browserWidth?left:browserWidth-(calWidth+8))+"px"});
	$("#"+divId).css('display','block');
	$(".popUpMenu").hide();
	$("#"+divId).show();
}

