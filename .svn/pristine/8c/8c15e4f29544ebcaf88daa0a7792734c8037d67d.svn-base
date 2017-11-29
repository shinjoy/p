

/**
 * 배열 복제
 * 
 * @param 
 * @returns
 */
Array.prototype.clone = function () {
	return this.slice(0);
};




/**
 * 배열 인덱스 삭제
 * 
 * @param index	: 배열 인덱스
 * @returns
 */
Array.prototype.remove = function (index) {
	this.splice(index, 1);
};




/**
 * 해당키값을 가지는 총수
 * 
 * @param arrayObj	: 대상배열객체
 * @param key		: 찾으려는 row 객체의 속성키
 * @param value		: 찾으려는 row 객체의 속성값
 */
function getCountWithValue(arrayObj, key, value){
	var cnt = 0;
	for(var i=0; i<arrayObj.length; i++){
		if(arrayObj[i][key] == value) cnt++;
	}
	return cnt;
}

/**
 * 해당키값을 가지는 행 Object
 * 
 * @param arrayObj	: 대상배열객체
 * @param key		: 찾으려는 row 객체의 속성키
 * @param value		: 찾으려는 row 객체의 속성값
 */
function getRowObjectWithValue(arrayObj, key, value){
	var obj = null;
	for(var i=0; i<arrayObj.length; i++){
		if(arrayObj[i][key] == value){
			obj = arrayObj[i];
			break;
		}
	}
	return obj;
}

/**
 * 해당키값을 가지는 행 index
 * 
 * @param arrayObj	: 대상배열객체
 * @param key		: 찾으려는 row 객체의 속성키
 * @param value		: 찾으려는 row 객체의 속성값
 */
function getRowIndexWithValue(arrayObj, key, value){
	var idx = -1;
	for(var i=0; i<arrayObj.length; i++){		
		if(arrayObj[i][key] == value){
			idx = i;
			break;
		}
	}
	return idx;
}


/**
 * 해당키값을 가지는 index (문자열배열에서)
 * 
 * @param arrayObj	: 대상배열
 * @param value		: 찾으려는 값
 */
function getArrayIndexWithValue(arrayStr, value){
	var idx = -1;
	for(var i=0; i<arrayStr.length; i++){		
		if(arrayStr[i] == value){
			idx = i;
			break;
		}
	}
	return idx;
}


/**
 * 해당키값을 가지는 count(문자열배열에서)
 * 
 * @param arrayObj	: 대상배열
 * @param value		: 찾으려는 값
 */
function getArrayIndexWithCnt(arrayStr, value){
	var cnt = 0;
	for(var i=0; i<arrayStr.length; i++){		
		if(arrayStr[i] == value){
			cnt++;
		}
	}
	return cnt;
}


/**
 * 배열에 요소(객체)추가 (특정 index 에)
 * 
 * @param arrayObj	: 대상배열객체
 * @param idx		: 특정 index
 * @param obj		: 넣을 요소 객체
 */
function addToArray(arrayObj, idx, obj){
	var resultArray = [];
	var aSize = arrayObj.length;
	
	var tempA = arrayObj.slice(0, idx);			//앞에자르고
	var tempB = arrayObj.slice(idx, aSize);		//뒤에잘라
	var tempP = [obj];							//사이에 넣을 것을 가지고
	
	resultArray = tempA.concat(tempP, tempB);	//전체 합친다
	
	return resultArray;		//새로운 결과 반환
}


/**
 * 객체배열 정렬
 * 
 * @param arrayObj	: 대상배열객체
 * @param key		: 객체내 특정 key
 * @param direction	: 'ASC' or 'DESC'
 */
function sortByKey(arrayObj, key, direction) {
	if(direction==undefined){
		direction = 'ASC';
	}
	
	return arrayObj.sort(function(a, b) {
        var x = a[key]; var y = b[key];
        return ((x < y) ? ((direction=='ASC')?-1:1) : ((x > y) ? ((direction=='ASC')?1:-1) : 0));
    });
}


/**
 * 배열에서 조건에 만족하는 값만으로의 배열 생성 (하단 참조해서 화면에서 구현해서 사용하자)
 * 
 * @param someArray	: 원 array
 */
/*
예)
var someArray = [1,2,3];
var newArray = $.grep(someArray, function(item){
								    return item > 1;		//만족하는 조건 
								});
결과) newArray = [2,3];
*/