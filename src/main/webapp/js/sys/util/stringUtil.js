/**
 * trim
 */
String.prototype.trim = function(){
	    return this.replace(/(^\s*)|(\s*$)/gi, "");
};


/**
 * isEmpty
 */
//String.prototype.isEmpty = function(){
//
//	if(this==null) return true;
//
//	var str = this.trim();
//	if(str.length == 0){
//		return true;
//	}else{
//		return false;
//	}
//};




/**
 * 공백문자 이거나 null 체크
 */
function isEmpty(param){

	if(param==null || param == undefined) return true;
	if(typeof param == "number") return false;

	var str = param.trim();
	if(str.length == 0){
		return true;
	}else{
		return false;
	}
}


/**
 * 숫자열을 3자리마다 "," 표 찍기
 */
function formatMoney(strNumber,mode){

	if(typeof strNumber == 'number'){
		strNumber = strNumber.toString();				//숫자타입이면 문자로 변환
	}else if(strNumber == null){
		strNumber = '';
	}

    var nLength=strNumber.length;
    var i=0;
    var strResult='';
    if(mode=='INSERT'){
        var j=0;
        for(i=nLength-1;i>=0;i--){
            j++;
            strResult=strNumber.substring(i,i+1)+strResult;
            if(j%3==0 && i>0){
                strResult=','+strResult;
            }
        }
    }else if( mode=='DELETE'){
        for(i=nLength-1;i>=0;i--){
            if(strNumber.substring(i,i+1)!=','){
                strResult=strNumber.substring(i,i+1)+strResult;
            }
        }
    }
    return strResult;
}

/**
 * 쿠키 값추가
 */
function addCookie(name, value, url, expiredays){
    var todayDate = new Date();
    if(Number(expiredays)>0){
        todayDate.setDate( eval(todayDate.getDate() + expiredays) );
    }else if(Number(expiredays) == 0){
        todayDate = null;
    }else{
        todayDate.setDate( todayDate.getDate() + 30);
    }
    document.cookie = name + "=" + escape( value ) +
        (todayDate!=null ? "; expires=" + todayDate.toGMTString() : "") +
        (url!=null ? "; path="+url : " " );
}

/**
 * 쿠키 값 얻기
 */
function getCookie(name){
    var Found = false;
    var start, end;
    var i = 0;
    while(i <= document.cookie.length){
        start = i;
        end = start + name.length;
        if(document.cookie.substring(start, end) == name){
            Found = true;
            break;
        }
        i++;
    }

    if(Found == true){
        start = end + 1;
        end = document.cookie.indexOf(";", start);
        if(end < start){
            end = document.cookie.length;
        }
        return document.cookie.substring(start, end);
    }else{
        return "";
    }
}


/**
 * 알파벳으로만 되어 있는 문자열인지
 */
function isAlpha(xStr){
    return xStr.match(/[^a-z]/gi);
}


/**
 * 문자열에 한글문자가 하나라도 있는지 검사
 */
function strInKrChar(value){
    for (var idx = 0; idx < value.length; idx++) {
        str2 = value.charAt(idx);
        if (( str2 >= 'ㄱ' && str2 <= '힣' )){
            return true;
        }
    }
    return false;
}

/**
 * 문자열이 영문대소 와 숫자 로만 구성됬는지 패턴검사(_^ 허용)
 */
function strInNumNEn(value){
    if(value==null || value.length < 1) return true;
    var temp = value;
    while(temp.indexOf("\\")>-1){
        temp = temp.substr(temp.indexOf("\\")+1);
    }
    temp = temp.replace("[","");
    temp = temp.replace("]","");
    var format = "[^\._A-Za-z0-9]{1,}";

    if(temp.search(format) != -1){
        return true;
    }else{
        return false;
    }
}


/**
 * 문자열이 영문대소 와 숫자 로만 구성됬는지 패턴검사
 */
function strInNumNEnNotUnder(value){
    if(value==null || value.length < 1) return true;
    var temp = value;
    while(temp.indexOf("\\")>-1){
        temp = temp.substr(temp.indexOf("\\")+1);
    }
    temp = temp.replace("[","");
    temp = temp.replace("]","");
    var format = "[^A-Za-z0-9]{1,}";

    if(temp.search(format) != -1){
        return true;
    }else{
        return false;
    }
}


/**
 * 정규식으로 문자열이 숫자로만 구성됬는지 패턴검사
 */
function strInNum(value){
    var format = "^[0-9]";

    if (value.search(format) != -1) {
        return true;
    }
    return false;
}

/**
 * 정규식으로 문자열이 이메일로 유효한지 패턴검사
 */
function isEmail(value){
	var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	return regex.test(value);
}


/**
 * 정규식으로 문자열이 일반전화번호로 유효한지 패턴검사
 */
function isPhoneNumber(value){
    var format = "^[0-9]\{2,3\}-[0-9]\{3,4\}-[0-9]\{4\}$";

    if (value.search(format) != -1) {
        return true;
    }
    return false;
}

/**
 * 정규식으로 문자열이 일반전화번호로 유효한지 패턴검사 (숫자와 - 로만 되어있는지 검사만 하는 약식 검사)
 */
function isPhoneNumberSimple(value){
    var format = "^[0-9]+[0-9-]*[0-9]$";

    if (value.search(format) != -1) {
        return true;
    }
    return false;
}

/**
 * 정규식으로 문자열이 헨드폰번호로 유효한지 패턴검사
 */
function isMobileNumber(value){
    var format = "^[0-9]\{3\}-[0-9]\{3,4\}-[0-9]\{4\}$";
    if (value.search(format) != -1) {
        return true;
    }
    return false;
}

/**
 * 전화번호형식으로 ex)025556666 >> 02-555-6666
 */
function toPhoneFormat(pStr){
	if(pStr == null) return '';
	return pStr.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/, '$1-$2-$3');
}


/**
 * 숫자앞에 원하는 길이만큼 '0' 채우기
 *
 * @param no	: 숫자
 * @param len	: 전체길이
 * @returns 숫자앞에 '0' 채운 문자열
 */
function fillzero(no, len) {
	no= '000000000000000'+no;
	return no.substring(no.length-len);
}



//천단위 마다 콤마(,) 추가하는 함수
function addComma(value) {
	var num = isNumber(value);
	if (!num) return;

	// 문자열 길이가 3과 같거나 작은 경우 입력 값을 그대로 리턴
	if (num.length <= 3) {
		return num;
	}


	var count = Math.floor((num.length - 1) / 3);		// 3단어씩 자를 반복 횟수 구하기
	var result = "";									// 결과 값을 저정할 변수

	// 문자 뒤쪽에서 3개를 자르며 콤마(,) 추가
	for (var i = 0; i < count; i++) {

		var length = num.length;						// 마지막 문자(length)위치 - 3 을 하여 마지막인덱스부터 세번째 문자열 인덱스값 구하기
		var strCut = num.substr(length - 3, length);	 // 반복문을 통해 value 값은 뒤에서 부터 세자리씩 값이 리턴됨.
		num = num.slice(0, length - 3);					// 입력값 뒷쪽에서 3개의 문자열을 잘라낸 나머지 값으로 입력값 갱신
		result = "," + strCut + result;					// 콤마(,) + 신규로 자른 문자열 + 기존 결과 값
	}


	result = num + result;								// 마지막으로 루프를 돌고 남아 있을 입력값(value)을 최종 결과 앞에 추가

	return result;
}

//숫자 유무 판단
function isNumber(checkValue) {
	checkValue = '' + checkValue;
	if (isNaN(checkValue)) {
		alert("숫자만 입력해 주세요.");
		return;
	}
	return checkValue;
}

//폰 - 생성
function phoneFormatDash(str){

	str = str.replace(/[^0-9]/g, '');
	var tmp = '';
	if( str.length < 4){
		return str;
	}else if(str.length < 7){
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3);
		return tmp;
	}else if(str.length < 11){
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3, 3);
		tmp += '-';
		tmp += str.substr(6);
		return tmp;
	}else{
		tmp += str.substr(0, 3);
		tmp += '-';
		tmp += str.substr(3, 4);
		tmp += '-';
		tmp += str.substr(7);
		return tmp;
	}
	return str;
}
