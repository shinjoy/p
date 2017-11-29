/**
 * 영어로 친 자판을 한글로 변환 ex)ghfkddl >> 호랑이
 */



var ENG_KEY = "rRseEfaqQtTdwWczxvgkoiOjpuPhynbml";
var KOR_KEY = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎㅏㅐㅑㅒㅓㅔㅕㅖㅗㅛㅜㅠㅡㅣ";
var CHO_DATA = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ";
var JUNG_DATA = "ㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ";
var JONG_DATA = "ㄱㄲㄳㄴㄵㄶㄷㄹㄺㄻㄼㄽㄾㄿㅀㅁㅂㅄㅅㅆㅇㅈㅊㅋㅌㅍㅎ";


function engTypeToKor(src) {
	var res = "";
	if (src.length == 0)
		return res;

	var nCho = -1, nJung = -1, nJong = -1;		// 초성, 중성, 종성

	for (var i = 0; i < src.length; i++) {
		var ch = src.charAt(i);
		var p = ENG_KEY.indexOf(ch);
		if (p == -1) {				// 영자판이 아님
			// 남아있는 한글이 있으면 처리
			if (nCho != -1) {
				if (nJung != -1)				// 초성+중성+(종성)
					res += makeHangul(nCho, nJung, nJong);
				else							// 초성만
					res += CHO_DATA.charAt(nCho);
			} else {
				if (nJung != -1)				// 중성만
					res += JUNG_DATA.charAt(nJung);
				else if (nJong != -1)			// 복자음
					res += JONG_DATA.charAt(nJong);
			}
			nCho = -1;
			nJung = -1;
			nJong = -1;
			res += ch;
		} else if (p < 19) {			// 자음
			if (nJung != -1) {
				if (nCho == -1) {					// 중성만 입력됨, 초성으로
					res += JUNG_DATA.charAt(nJung);
					nJung = -1;
					nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
				} else {							// 종성이다
					if (nJong == -1) {				// 종성 입력 중
						nJong = JONG_DATA.indexOf(KOR_KEY.charAt(p));
						if (nJong == -1) {			// 종성이 아니라 초성이다
							res += makeHangul(nCho, nJung, nJong);
							nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
							nJung = -1;
						}
					} else if (nJong == 0 && p == 9) {			// ㄳ
						nJong = 2;
					} else if (nJong == 3 && p == 12) {			// ㄵ
						nJong = 4;
					} else if (nJong == 3 && p == 18) {			// ㄶ
						nJong = 5;
					} else if (nJong == 7 && p == 0) {			// ㄺ
						nJong = 8;
					} else if (nJong == 7 && p == 6) {			// ㄻ
						nJong = 9;
					} else if (nJong == 7 && p == 7) {			// ㄼ
						nJong = 10;
					} else if (nJong == 7 && p == 9) {			// ㄽ
						nJong = 11;
					} else if (nJong == 7 && p == 16) {			// ㄾ
						nJong = 12;
					} else if (nJong == 7 && p == 17) {			// ㄿ
						nJong = 13;
					} else if (nJong == 7 && p == 18) {			// ㅀ
						nJong = 14;
					} else if (nJong == 16 && p == 9) {			// ㅄ
						nJong = 17;
					} else {						// 종성 입력 끝, 초성으로
						res += makeHangul(nCho, nJung, nJong);
						nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
						nJung = -1;
						nJong = -1;
					}
				}
			} else {								// 초성 또는 (단/복)자음이다
				if (nCho == -1) {					// 초성 입력 시작
					if (nJong != -1) {				// 복자음 후 초성
						res += JONG_DATA.charAt(nJong);
						nJong = -1;
					}
					nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
				} else if (nCho == 0 && p == 9) {			// ㄳ
					nCho = -1;
					nJong = 2;
				} else if (nCho == 2 && p == 12) {			// ㄵ
					nCho = -1;
					nJong = 4;
				} else if (nCho == 2 && p == 18) {			// ㄶ
					nCho = -1;
					nJong = 5;
				} else if (nCho == 5 && p == 0) {			// ㄺ
					nCho = -1;
					nJong = 8;
				} else if (nCho == 5 && p == 6) {			// ㄻ
					nCho = -1;
					nJong = 9;
				} else if (nCho == 5 && p == 7) {			// ㄼ
					nCho = -1;
					nJong = 10;
				} else if (nCho == 5 && p == 9) {			// ㄽ
					nCho = -1;
					nJong = 11;
				} else if (nCho == 5 && p == 16) {			// ㄾ
					nCho = -1;
					nJong = 12;
				} else if (nCho == 5 && p == 17) {			// ㄿ
					nCho = -1;
					nJong = 13;
				} else if (nCho == 5 && p == 18) {			// ㅀ
					nCho = -1;
					nJong = 14;
				} else if (nCho == 7 && p == 9) {			// ㅄ
					nCho = -1;
					nJong = 17;
				} else {							// 단자음을 연타
					res += CHO_DATA.charAt(nCho);
					nCho = CHO_DATA.indexOf(KOR_KEY.charAt(p));
				}
			}
		} else {									// 모음
			if (nJong != -1) {						// (앞글자 종성), 초성+중성
				// 복자음 다시 분해
				var newCho;			// (임시용) 초성
				if (nJong == 2) {					// ㄱ, ㅅ
					nJong = 0;
					newCho = 9;
				} else if (nJong == 4) {			// ㄴ, ㅈ
					nJong = 3;
					newCho = 12;
				} else if (nJong == 5) {			// ㄴ, ㅎ
					nJong = 3;
					newCho = 18;
				} else if (nJong == 8) {			// ㄹ, ㄱ
					nJong = 7;
					newCho = 0;
				} else if (nJong == 9) {			// ㄹ, ㅁ
					nJong = 7;
					newCho = 6;
				} else if (nJong == 10) {			// ㄹ, ㅂ
					nJong = 7;
					newCho = 7;
				} else if (nJong == 11) {			// ㄹ, ㅅ
					nJong = 7;
					newCho = 9;
				} else if (nJong == 12) {			// ㄹ, ㅌ
					nJong = 7;
					newCho = 16;
				} else if (nJong == 13) {			// ㄹ, ㅍ
					nJong = 7;
					newCho = 17;
				} else if (nJong == 14) {			// ㄹ, ㅎ
					nJong = 7;
					newCho = 18;
				} else if (nJong == 17) {			// ㅂ, ㅅ
					nJong = 16;
					newCho = 9;
				} else {							// 복자음 아님
					newCho = CHO_DATA.indexOf(JONG_DATA.charAt(nJong));
					nJong = -1;
				}
				if (nCho != -1)			// 앞글자가 초성+중성+(종성)
					res += makeHangul(nCho, nJung, nJong);
				else                    // 복자음만 있음
					res += JONG_DATA.charAt(nJong);

				nCho = newCho;
				nJung = -1;
				nJong = -1;
			}
			if (nJung == -1) {						// 중성 입력 중
				nJung = JUNG_DATA.indexOf(KOR_KEY.charAt(p));
			} else if (nJung == 8 && p == 19) {            // ㅘ
				nJung = 9;
			} else if (nJung == 8 && p == 20) {            // ㅙ
				nJung = 10;
			} else if (nJung == 8 && p == 32) {            // ㅚ
				nJung = 11;
			} else if (nJung == 13 && p == 23) {           // ㅝ
				nJung = 14;
			} else if (nJung == 13 && p == 24) {           // ㅞ
				nJung = 15;
			} else if (nJung == 13 && p == 32) {           // ㅟ
				nJung = 16;
			} else if (nJung == 18 && p == 32) {           // ㅢ
				nJung = 19;
			} else {			// 조합 안되는 모음 입력
				if (nCho != -1) {			// 초성+중성 후 중성
					res += makeHangul(nCho, nJung, nJong);
					nCho = -1;
				} else						// 중성 후 중성
					res += JUNG_DATA.charAt(nJung);
				nJung = -1;
				res += KOR_KEY.charAt(p);
			}
		}
	}

	// 마지막 한글이 있으면 처리
	if (nCho != -1) {
		if (nJung != -1)			// 초성+중성+(종성)
			res += makeHangul(nCho, nJung, nJong);
		else                		// 초성만
			res += CHO_DATA.charAt(nCho);
	} else {
		if (nJung != -1)			// 중성만
			res += JUNG_DATA.charAt(nJung);
		else {						// 복자음
			if (nJong != -1)
				res += JONG_DATA.charAt(nJong);
		}
	}

	return res;
}

function makeHangul(nCho, nJung, nJong) {
	return String.fromCharCode(0xac00 + nCho * 21 * 28 + nJung * 28 + nJong + 1);
}



function cho_hangul(str) {
	cho = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"];
	result = "";
	for(i=0;i<str.length;i++) {
		code = str.charCodeAt(i)-44032;
		if(code>-1 && code<11172) result += cho[Math.floor(code/588)];
	}
	
	return result;
}


var font_cho = Array(
'ㄱ', 'ㄲ', 'ㄴ', 'ㄷ', 'ㄸ',
'ㄹ', 'ㅁ', 'ㅂ', 'ㅃ', 'ㅅ', 'ㅆ',
'ㅇ', 'ㅈ', 'ㅉ', 'ㅊ', 'ㅋ', 'ㅌ', 'ㅍ', 'ㅎ' );

function runSearch(list,key){
	var inputStr = key;
	var result ="";

	//입력된 문자열 길이만큼 반복 - [1]반복문
	for(k = 0; k < inputStr.length; k++){
		var inputStr2 = inputStr.substring(k, k+1);			//입력한 단어 글자 단위로 나눠 담기
		var inputCho = searchCho(inputStr2.charCodeAt(0));	//입력한 단어 초성 나누기	
		
		var forLength = 0;	
		var checkArr = result.split(",");	// 조회된결과를 배열로 나눔
		var arrStr = "";

		//최초 조회시... 
		if(result == "" && k == 0){
			forLength = list.length;
		//두번째 조회 부터...
		}else{
			forLength = checkArr.length;
			result = "";
		}

		// 비교대상 배열의 길이만큼 반복 - [2]반복문
		for(i = 0 ; i < forLength ; i++){	
		
			//최초 조회시... 
			if(k == 0){
				arrStr = list[i].usrNm;
			//두번째 조회 부터...
			}else{
				arrStr = checkArr[i];
			}

			//배열 값의 길이만큼 반복 - [3]반복문 
			//단, j는 [1]반복문의 현재값으로 초기화 
			for(j =  k; j < arrStr.length ; j++){

				//이전 검색된 문자
				var beforeStr = arrStr.charCodeAt(j);
				var beforeCho = searchCho(arrStr.charCodeAt(j));
				var beforeInput = inputStr2;
			
				if(k > 0){
					beforeStr = arrStr.charCodeAt(j-1);
					beforeCho = searchCho(arrStr.charCodeAt(j-1));	
					beforeInput = inputStr.substring(k-1, k);
				}				

				//한글이면
				if(escape(inputStr2.charCodeAt(0)).length > 4  && result.indexOf(arrStr) < 0 ){

					var Cho = searchCho(arrStr.charCodeAt(j));	//조회 대상 배열의 값 초성 나누기	

					//초성만 입력한 경우이면..
					if(inputCho >= 0){
						if(arrStr.charCodeAt(j) == inputStr2.charCodeAt(0)){
							if(font_cho[beforeCho] == beforeInput ||  beforeStr == beforeInput.charCodeAt(0)){
								result += arrStr + ",";
							}
						}
					//초성인 경우...
					}else{
						if(font_cho[Cho] == inputStr2){
							if(font_cho[beforeCho] == beforeInput ||  beforeStr == beforeInput.charCodeAt(0)){
								result += arrStr + ",";
							}
						}
					}
				
				//영어면
				}else{
					//대문자로 변환뒤 비교
					if(inputStr2.toUpperCase().charCodeAt(0) == arrStr.toUpperCase().charCodeAt(j)){
						if(result.indexOf(arrStr) < 0 ){
							result += arrStr + ",";	
						}
					}
				}

			} //[3]반복문 종료
		}//[2]반복문 종료
	}//[1]반복문 종료

	if(result == ""){
		result = "";
	}
	
	return result;
}

// 초성 나누기 return : 초성 배열 index
function searchCho(str){

	CompleteCode = str;
	UniValue = CompleteCode - 0xAC00;

	var Jong = UniValue % 28;
	var Jung = ( ( UniValue - Jong ) / 28 ) % 21;
	var Cho = parseInt (( ( UniValue - Jong ) / 28 ) / 21);
	
	return Cho;
}

	
