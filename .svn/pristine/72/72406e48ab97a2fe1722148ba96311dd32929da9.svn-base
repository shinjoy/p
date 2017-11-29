//* 참조 하단 함수는 바로 사용
//setTimeout("ozit_timer_test()", 3000); // 3000ms(3초)가 경과하면 ozit_timer_test() 함수를 실행합니다.
//setInterval("ozit_interval_test()", 5000); // 매 5000ms(5초)가 지날 때마다 ozit_timer_test() 함수를 실행합니다.

//timerId = setInterval("ozit_interval_test()", 5000);
//clearInterval(timerId);    // timerId 값을 인자로 입력하여 해당 setInterval 을 종료시킵니다.


//========================================== Dialog 관련 :S ===============================================

/**
 * 단순 alert
 *
 * @param msg : message
 */
function alertM(msg, fnConfirmClick, topPx, widthPx){
	dialog.push({body:"<b>확인!</b> " + msg, type:"", onConfirm:fnConfirmClick, top:topPx, width:widthPx});
}


/**
 * 한글금액 문자로 반환
 *
 * @param num	: 금액 숫자
 * @returns
 */
function numToKorean(num){
    var hanA = new Array("","일","이","삼","사","오","육","칠","팔","구","십");
    var danA = new Array("","십","백","천","","십","백","천","","십","백","천","","십","백","천");
    var result = "";
	for(var i=0; i<num.length; i++){
		str = "";
		han = hanA[num.charAt(num.length-(i+1))];
		if(han != "")
			str += han+danA[i];
		if(i == 4) str += "만";
		if(i == 8) str += "억";
		if(i == 12) str += "조";
		result = str + result;
	}
	if(num != 0)
		result = result + "원";

    return result ;
}



/**
 * 테이블 특정컬럼 rowspan
 *
 * @param tableId	: 테이블 id 명
 * @param fromIdx	: 컬럼 index
 * @param toIdx		: 컬럼 index
 * @returns
 */
function tableRowspan(tableId, fromIdx, toIdx){
	$(function(){
		$('#'+tableId).each(function() {
			var table = this;
			$.each([fromIdx,toIdx] /* 합칠 칸 번호 */, function(c, v) {
				var tds = $('>tbody>tr>td:nth-child(' + v + ')', table).toArray(), i = 0, j = 0;
				for(j = 1; j < tds.length; j ++) {
					if(tds[i].innerHTML == '<a></a>' || tds[i].innerHTML != tds[j].innerHTML) {
						$(tds[i]).attr('rowspan', j - i);
						i = j;
						continue;
					}
					$(tds[j]).hide();
				}
				j --;
				if(tds[i].innerHTML == tds[j].innerHTML) {
					$(tds[i]).attr('rowspan', j - i + 1);
				}
			});
		});
	});
}






/**
*
*  Base64 encode / decode
*  http://www.webtoolkit.info/
*
**/
var Base64 = {

	// private property
	_keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",

	// public method for encoding
	encode : function (input) {
	    var output = "";
	    var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
	    var i = 0;

	    input = Base64._utf8_encode(input);

	    while (i < input.length) {

	        chr1 = input.charCodeAt(i++);
	        chr2 = input.charCodeAt(i++);
	        chr3 = input.charCodeAt(i++);

	        enc1 = chr1 >> 2;
	        enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
	        enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
	        enc4 = chr3 & 63;

	        if (isNaN(chr2)) {
	            enc3 = enc4 = 64;
	        } else if (isNaN(chr3)) {
	            enc4 = 64;
	        }

	        output = output +
	        this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
	        this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);

	    }

	    return output;
	},

	// public method for decoding
	decode : function (input) {
	    var output = "";
	    var chr1, chr2, chr3;
	    var enc1, enc2, enc3, enc4;
	    var i = 0;

	    input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");

	    while (i < input.length) {

	        enc1 = this._keyStr.indexOf(input.charAt(i++));
	        enc2 = this._keyStr.indexOf(input.charAt(i++));
	        enc3 = this._keyStr.indexOf(input.charAt(i++));
	        enc4 = this._keyStr.indexOf(input.charAt(i++));

	        chr1 = (enc1 << 2) | (enc2 >> 4);
	        chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
	        chr3 = ((enc3 & 3) << 6) | enc4;

	        output = output + String.fromCharCode(chr1);

	        if (enc3 != 64) {
	            output = output + String.fromCharCode(chr2);
	        }
	        if (enc4 != 64) {
	            output = output + String.fromCharCode(chr3);
	        }

	    }

	    output = Base64._utf8_decode(output);

	    return output;

	},

	// private method for UTF-8 encoding
	_utf8_encode : function (string) {
	    string = string.replace(/\r\n/g,"\n");
	    var utftext = "";

	    for (var n = 0; n < string.length; n++) {

	        var c = string.charCodeAt(n);

	        if (c < 128) {
	            utftext += String.fromCharCode(c);
	        }
	        else if((c > 127) && (c < 2048)) {
	            utftext += String.fromCharCode((c >> 6) | 192);
	            utftext += String.fromCharCode((c & 63) | 128);
	        }
	        else {
	            utftext += String.fromCharCode((c >> 12) | 224);
	            utftext += String.fromCharCode(((c >> 6) & 63) | 128);
	            utftext += String.fromCharCode((c & 63) | 128);
	        }

	    }

	    return utftext;
	},

	// private method for UTF-8 decoding
	_utf8_decode : function (utftext) {
	    var string = "";
	    var i = 0;
	    var c = c1 = c2 = 0;

	    while ( i < utftext.length ) {

	        c = utftext.charCodeAt(i);

	        if (c < 128) {
	            string += String.fromCharCode(c);
	            i++;
	        }
	        else if((c > 191) && (c < 224)) {
	            c2 = utftext.charCodeAt(i+1);
	            string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
	            i += 2;
	        }
	        else {
	            c2 = utftext.charCodeAt(i+1);
	            c3 = utftext.charCodeAt(i+2);
	            string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
	            i += 3;
	        }

	    }

	    return string;
	}

};//Base64