/**
 * dateUtil.js
 * 
 * 날짜 시간 관련
 */


/**
 * 현재 날짜 가져오기 (원하는 방식으로 가공해서 사용)
 * 
 */
function getCurrentDate(){
	var week = new Array('일', '월', '화', '수', '목', '금', '토');
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth() + 1;
	var day = today.getDate();
	var dayName = week[today.getDay()];
  
	//console.log("현재 날짜는 %d-%d-%d %s요일 입니다.", year, month, day, dayName);
	//alert("현재 날짜는 "+ year + "-" + month + "-" + day + " " + dayName + "요일 입니다.");
	alert("현재 날짜는 "+ year + "-" + fillzero(month, 2) + "-" + fillzero(day, 2) + " " + dayName + "요일 입니다.");
}


/**
 * 원하는 요일 가져오기 (원하는 방식으로 가공해서 사용)
 * 
 */
function getWeekName(year,month,day){
	var week = new Array('일', '월', '화', '수', '목', '금', '토');
	
	var year =year;
	var month = month;
	var day = day;
	
	var selDay = new Date(year,month-1,day);
	
	var dayName = week[selDay.getDay()];
  
	return dayName;
	//console.log("현재 날짜는 %d-%d-%d %s요일 입니다.", year, month, day, dayName);
	//alert("현재 날짜는 "+ year + "-" + month + "-" + day + " " + dayName + "요일 입니다.");
	//alert("현재 날짜는 "+ year + "-" + fillzero(month, 2) + "-" + fillzero(day, 2) + " " + dayName + "요일 입니다.");
}


/**
 * Date 로 반환
 * 
 * @param type	: 생성자 타입
 * @param p1
 * @param ~
 * @param p6
 * @returns
 */
function makeDate(ctype, p1, p2, p3, p4, p5, p6){
	var dt;
	
	if(ctype == 1){			//p1: "1/1/2002", p2: 시, p3: 분, p4: 초	 		사용1.	makeDate(1, "1/1/2002", 15, 37, 49)
		dt = new Date(p1);
		dt.setHours(p2, p3, p4, "000");
		
	}else if(ctype == 2){	//p1: 년, p2: 월, p3: 일, p4: 시, p5: 분, p6: 초	사용2.	makeDate(2, 2002, 1, 1, 15, 37, 49)
		dt = new Date(p1, Number(p2)-1, p3, p4, p5, p6);
		
	}else if(ctype == 3){	//p1: "2002-01-01", p2: 시, p3: 분, p4: 초	 	사용3.	makeDate(3, "2002-01-01", 15, 37, 49)
		var adt = p1.split("-");
		dt = new Date(adt[0], Number(adt[1])-1, adt[2], p2, p3, p4);
		
	}else if(ctype == 4){	//p1: "20020101", p2: 시, p3: 분, p4: 초	 		사용4.	makeDate(4, "20020101", 15, 37, 49)
		dt = new Date(p1.substring(0,4), Number(p1.substring(4,6))-1, p1.substring(6,8), p2, p3, p4);
	
	}else if(ctype == 5){	//p1: "20020101"						 		사용5.	makeDate(5, "20020101")
		dt = new Date(p1.substring(0,4), Number(p1.substring(4,6))-1, p1.substring(6,8));
	
	}else{
		dt = null;
	}
	
	return dt;
}



/**
 * yyyymmdd 형태로 포매팅된 날짜 반환
 * 
 * @returns yyyymmdd 형태 날짜
 */
Date.prototype.yyyymmdd = function()			// new Date().yyyymmdd()	>> 8자리 문자열  ex) "20150609"
{
    var yyyy = this.getFullYear().toString();
    var mm = (this.getMonth() + 1).toString();
    var dd = this.getDate().toString();

    return yyyy + (mm[1] ? mm : '0'+mm[0]) + (dd[1] ? dd : '0'+dd[0]);
};
Date.prototype.yyyy_mm_dd = function()			// new Date().yyyy_mm_dd()	>> 10자리 문자열 	ex) "2015-06-09"
{
    var yyyy = this.getFullYear().toString();
    var mm = (this.getMonth() + 1).toString();
    var dd = this.getDate().toString();

    return yyyy + "-" + (mm[1] ? mm : '0'+mm[0]) + "-" + (dd[1] ? dd : '0'+dd[0]);
};
//해당 월의 마지막 날짜구하기.

Date.prototype.getLastDate=function(){return new Date(this.getFullYear(),this.getMonth()+1,0).getDate();};




/**
 * 기준일 + n 일 
 * 					(예) 하루전날짜 addDate(-1), addDate(new Date(-1, "1/1/2002"))
 * 
 * @param n		: 숫자(일)
 * @param dt	: 기준일
 * @returns		: date (기준일+n)
 */
function addDate(n, dt){
	var base;
	
	if(dt == null)		//기준일(dt)이 없을때는 현재날짜로
		base = new Date();
	else
		base = dt;
	
	base.setDate(base.getDate() + n);
	
	return base;
}




/**
 * 경과 시(hour)
 * 
 * @param day1
 * @param day2
 * @returns {Number}
 */
function diffHour(day1, day2){
	
	var diff = day1.getTime() - day2.getTime();		//diff : millisecond
	
	return diff /(1000 * 60 * 60);		//시(hour)
}

/**
 * 두날짜간 차이구하기
 * 
 * @param day1 ('2016-11-04')
 * @param day2 ('2016-11-02')
 * @returns 
 */
function diffDay(day1, day2){
	
	var day1Array = day1.split("-"); 
	var day2Array = day2.split("-"); 
	
	var day1Obj = new Date(day1Array[0], Number(day1Array[1])-1, day1Array[2]);
	var day2Obj = new Date(day2Array[0], Number(day2Array[1])-1, day2Array[2]);
	
	var betweenDay = (day1Obj.getTime() - day2Obj.getTime()) / 1000 / 60 / 60 / 24;
	
	return betweenDay;		
}



/**
 * 현재 날짜와 시간까지
 * 
 * @param 
 * @param
 * @returns 2013-11-22 15:30:22
 */

function getTimeStamp() {
	  var d = new Date();
	  var s =
	    leadingZeros(d.getFullYear(), 4) + '-' +
	    leadingZeros(d.getMonth() + 1, 2) + '-' +
	    leadingZeros(d.getDate(), 2) + ' ' +

	    leadingZeros(d.getHours(), 2) + ':' +
	    leadingZeros(d.getMinutes(), 2) + ':' +
	    leadingZeros(d.getSeconds(), 2);

	  return s;
}

/**
 * 현재 날짜와 시간까지
 * 
 * @param 
 * @param
 * @returns 20131122153022
 */

function getTimeStampStr() {
	  var d = new Date();
	  var s =
	    leadingZeros(d.getFullYear(), 4) +
	    leadingZeros(d.getMonth() + 1, 2) +
	    leadingZeros(d.getDate(), 2) +
	    leadingZeros(d.getHours(), 2) +
	    leadingZeros(d.getMinutes(), 2) +
	    leadingZeros(d.getSeconds(), 2);

	  return s;
}

/**
 * 0붙히기
 * 
 * @param 
 * @param
 * @returns
 */


function leadingZeros(n, digits) {
  var zero = '';
  n = n.toString();

  if (n.length < digits) {
    for (i = 0; i < digits - n.length; i++)
      zero += '0';
  }
  return zero + n;
}

//올해 몇주 차인지
function yearOfWeekNum(dt){
	var tdt = new Date(dt.valueOf()); 
	var dayn = (dt.getDay() + 6) % 7; 
	tdt.setDate(tdt.getDate() - dayn + 3); 
	var firstThursday = tdt.valueOf(); 
	tdt.setMonth(0, 1); 
	if (tdt.getDay() !== 4) { 
		tdt.setMonth(0, 1 + ((4 - tdt.getDay()) + 7) % 7); 
	} 
	return 1 + Math.ceil((firstThursday - tdt) / 604800000); 
}
 
	

