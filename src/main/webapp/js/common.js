//document.write("<script src='" + contextRoot + "/js/jquery-1.10.2.js'></script>");
document.write("<script src='" + contextRoot + "/js/jquery.min.js'></script>");
document.write("<script src='" + contextRoot + "/js/jquery-ui.js'></script>");
document.write("<script src='" + contextRoot + "/js/sys/jquery.blockUI.js'></script>");
document.write("<script src='" + contextRoot + "/js/ajaxRequest.js'></script>");
document.write("<script src='" + contextRoot + "/js/spin.js'></script>");
//document.write("<script src='" + contextRoot + "/js/axisj/AXJ.min.js'></script>");

/*
 * common.js
 *
 * 공통
 *
 * (*필요 js : jquery, jquery-ui, jquery.blockUI)
 */



//모달 메세지 팝업(전체창)
function alertMsg(msg){
	$.blockUI({
		message : msg + "<br><br><input type='button' value='닫기' onclick='removeMsg();' />",
		css : {
			border : '1px solid #CCCCCC'	//border style.
		}
	});
}

//모달 메세지 닫기(전체창)
function removeMsg(){
	$.unblockUI();
}

//모달 메세지 닫기(전체창)
function removeModalNReload(){
	$.unblockUI();
	location.reload();
}

//세션 아웃에 따른 재 로그인 팝업(모달 blockUI)
function alertLogin(){
	$.blockUI({
		message : "<b>SESSION OUT!!</b><br><iframe src='" + contextPath + "/login/ibLoginUsr.do' width='100%' height='250' border='0' style='border:hidden'></iframe><br><br><input type='button' value='닫기' onclick='removeModalNReload();' />",
		css : {
			border : '1px solid #CCCCCC'
		}
	});
}

/* ****(참조)***** 특정 엘리먼트 (block, unblock) *********
$("#blocklayer").block({message : "<input type='button' value='모달닫기' onclick='removeModal()' />"})
$("#blocklayer").unblock();
*********************************************************/



/* *** 하단 활용해서 페이지 닫을시 처리
$(window).on("beforeunload", function(){
    if(checkUnload) return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
});
*/


//엑셀다운(html table to excel)
function excelDown(htmlStr, fileName, sheetName){	//excelDown(html문자열, 파일명, 시트명)

	var sheetNm = '다운로드';
	if(sheetName!=null) sheetNm = sheetName;
	//var excelString = myGrid.getExcelFormat('html');


	var tableToExcel = (function() {
    	var uri = 'data:application/vnd.ms-excel;base64,'
    	, template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
    	, base64 = function(s) { return window.btoa(unescape(encodeURIComponent(s))); }
    	, format = function(s, c) { return s.replace(/{(\w+)}/g, function(m, p) { return c[p]; }); };

    	return function() {
	    	//if (!table.nodeType) table = document.getElementById(table)
	    	var ctx = {worksheet: sheetNm || 'Worksheet', table: htmlStr};
	    	//window.location.href = uri + base64(format(template, ctx));

    		var link = document.createElement('a');
			link.download = fileName;
			link.href = uri + base64(format(template, ctx));
			link.click();

    	};
    })();
	tableToExcel();
}


/* ***** 쿠키관련 ***** */
//쿠기설정
function setCookie(name, value, expiredays){
	var today = new Date();
	today.setDate( today.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + today.toGMTString() + ";";
}
//로그인ID저장
function saveLoginId(id)
{
	if(id != ""){
		setCookie("ibissUserId", id, 7);		//userid 쿠키에 id 값을 7일간 저장

	}else{
		setCookie("ibissUserId", id, -1);	//userid 쿠키삭제
	}
}





/**
 * 공통코드
 *
 * @param codeSetNm - 코드그룹명
 * @param language - 로그인사용자의 언어('KOR' or 'ENG')
 * @param code - return code  variable
 * @param name - return value variable
 * @param emptyCode - select 박스용 첫번째 공백값 코드
 * @param emptyName - select 박스용 첫번째 공백값 뷰명
 * @param emptyNameEng - select 박스용 첫번째 공백값 뷰명(영어명)...사용자 프로파일의 language가 'ENG'일때 첫값의 영어표기명
 * @param params - 추가 파라미터 전송시 사용 {}
 * @returns 공통코드 object(array) -	[CD(code전달명), NM(name전달명), CODE_SET_NAME(그룹코드), MEANING(그룹코드명), VALUE(코드), MEANING(코드명), DESCRIPTION(코드설명), SORT]
 */
function getCommonCode(codeSetNm, language, code, name, emptyCode, emptyName, emptyNameEng){

	var url = contextRoot + "/common/getCommonCode.do";

	return getCommonCode_common(url, codeSetNm, language, code, name, emptyCode, emptyName, emptyNameEng);
}

//base 공통코드
function getBaseCommonCode(codeSetNm, language, code, name, emptyCode, emptyName, emptyNameEng,params){

	var url = contextRoot + "/common/getBaseCommonCode.do";

	return getCommonCode_common(url, codeSetNm, language, code, name, emptyCode, emptyName, emptyNameEng,params);
}

//프로젝트/엑티비티
function getCommonProject(code, name, emptyCode, emptyName,params){

	var url = contextRoot + "/project/getBaseCommonProject.do";
	return getCommonProject_common(url, code, name, emptyCode, emptyName,params);
}
/**
 * 프로젝트/액티비티
 *
 * @param code - return code  variable
 * @param name - return value variable
 * @param emptyCode - select 박스용 첫번째 공백값 코드
 * @param emptyName - select 박스용 첫번째 공백값 뷰명
 * @param emptyNameEng - select 박스용 첫번째 공백값 뷰명(영어명)...사용자 프로파일의 language가 'ENG'일때 첫값의 영어표기명
 * @param params - 추가 파라미터 전송시 사용 {}
 */
function getCommonProject_common(reqUrl, code, name, emptyCode, emptyName,params){

	var returnObj = null;	//array object

	var codeV = (code==null||code=='')?'CD':code;				//코드명을 정하지 않을때 기본 명
	var nameV = (name==null||name=='')?'NM':name;				//벨류명을 정하지 않을때 기본 명

	var emptyObj = null;	//select 박스용 첫번째 공백값
	if(emptyCode != null){
		var emptyJson = '{"';
		emptyJson += (codeV + '":"' + emptyCode + '", "' + nameV + '":"' + emptyName + '"}');
		emptyObj= JSON.parse(emptyJson);
	}


	var url = reqUrl;

	var paramObj = {
		code : codeV,
		name : nameV
	};
	if(params!=null && params != undefined){
		$.extend(paramObj, params);
	}

	//callback function
	var callback = function(result){ //SUCCESS FUNCTION
		var obj = JSON.parse(result);

		var cnt = obj.resultVal;	//결과수
		var list = obj.resultList;	//결과데이터JSON

		//if(cnt>0){
			returnObj = list;
			if(emptyObj != null)
				returnObj.unshift(emptyObj);	//select 박스용 첫번째 공백값 추가
		//}

	};
	//공통 ajax 호출 (Sync 로)
	commonAjaxForSync("POST", url, paramObj, callback,false);

	return returnObj;
}


/**
 * 공통코드
 *
 * @param codeSetNm - 코드그룹명
 * @param language - 로그인사용자의 언어('KOR' or 'ENG')
 * @param code - return code  variable
 * @param name - return value variable
 * @param emptyCode - select 박스용 첫번째 공백값 코드
 * @param emptyName - select 박스용 첫번째 공백값 뷰명
 * @param emptyNameEng - select 박스용 첫번째 공백값 뷰명(영어명)...사용자 프로파일의 language가 'ENG'일때 첫값의 영어표기명
 * @param params - 추가 파라미터 전송시 사용 {}
 * @returns 공통코드 object(array) -	[CD(code전달명), NM(name전달명), CODE_SET_NAME(그룹코드), MEANING(그룹코드명), VALUE(코드), MEANING(코드명), DESCRIPTION(코드설명), SORT]
 */
function getCommonCode_common(reqUrl, codeSetNm, language, code, name, emptyCode, emptyName, emptyNameEng,params){

	var returnObj = null;	//array object

	var lang = (language==null||language=='')?'KOR':language;	//언어명을 정하지 않을때 기본 'KOR'
	var codeV = (code==null||code=='')?'CD':code;				//코드명을 정하지 않을때 기본 명
	var nameV = (name==null||name=='')?'NM':name;				//벨류명을 정하지 않을때 기본 명

	var emptyObj = null;	//select 박스용 첫번째 공백값
	if(emptyCode != null){
		var emptyJson = '{"';
		emptyJson += (codeV + '":"' + emptyCode + '", "' + nameV + '":"' + ((lang=='ENG')?emptyNameEng:emptyName) + '"}');
		emptyObj= JSON.parse(emptyJson);
	}


	var url = reqUrl;

	var paramObj = {
		menuCd : codeSetNm,
		codeSetNm : codeSetNm,
		lang : lang,
		code : codeV,
		name : nameV
	};
	if(params!=null && params != undefined){
		$.extend(paramObj, params);
	}

	//callback function
	var callback = function(result){ //SUCCESS FUNCTION
		var obj = JSON.parse(result);

		var cnt = obj.resultVal;	//결과수
		var list = obj.resultList;	//결과데이터JSON

		//if(cnt>0){
			returnObj = list;
			if(emptyObj != null)
				returnObj.unshift(emptyObj);	//select 박스용 첫번째 공백값 추가
		//}

	};
	//공통 ajax 호출 (Sync 로)
	commonAjaxForSync("POST", url, paramObj, callback);

	return returnObj;
}


//division 임시
function getDivisionList(url, params){


	var returnObj = null;	//array object
	var url = contextRoot + url ;
	var paramObj = {

		};
	if(params != undefined && typeof params == 'object'){
		paramObj=params;
	}

	//callback function
	var callback = function(result){ //SUCCESS FUNCTION
		var obj = JSON.parse(result);

		var cnt = obj.resultVal;	//결과수
		var list = obj.resultList;	//결과데이터JSON

		if(cnt>0){
			returnObj = list;
		}

	};
	//공통 ajax 호출 (Sync 로)
	commonAjaxForSync("POST", url, paramObj, callback);

	return returnObj;
}





/**
 * 공통코드 외 다른 테이블의 코드화데이터 (콤보박스용) ... (** 공통코드 함수를 가지고 거의 그대로 만들었다.(사실 파라미터로 합칠 수 도 있는데 한번 보자!!)
 *
 * @param language - 로그인사용자의 언어('KOR' or 'ENG')
 * @param code - return code  variable
 * @param name - return value variable
 * @param emptyCode - select 박스용 첫번째 공백값 코드
 * @param emptyName - select 박스용 첫번째 공백값 뷰명
 * @param emptyNameEng - select 박스용 첫번째 공백값 뷰명(영어명)...사용자 프로파일의 language가 'ENG'일때 첫값의 영어표기명
 * @param requestMappingValue - 가져올 요청 url ... ex) "/system/getRoleCodeCombo.do"
 * @param params - 파라미터 객체
 * @returns 코드데이터 object(array) -	[CD(code전달명), NM(name전달명), ...(등등 테이블마다 다른값들 함께) ]
 */
function getCodeInfo(language, code, name, emptyCode, emptyName, emptyNameEng, requestMappingValue, params){

	var returnObj = null;	//array object

	var lang = (language==null||language=='')?'KOR':language;	//언어명을 정하지 않을때 기본 'KOR'
	var codeV = (code==null||code=='')?'CD':code;				//코드명을 정하지 않을때 기본 명
	var nameV = (name==null||name=='')?'NM':name;				//벨류명을 정하지 않을때 기본 명

	var emptyObj = null;	//select 박스용 첫번째 공백값
	if(emptyCode != null){
		var emptyJson = '{"';
		emptyJson += (codeV + '":"' + emptyCode + '", "' + nameV + '":"' + ((lang=='ENG')?emptyNameEng:emptyName) + '"}');
		emptyObj= JSON.parse(emptyJson);
	}


	var url = contextRoot + requestMappingValue;		// "/system/getRoleCodeCombo.do";

	var paramObj = {
		lang : lang,
		code : codeV,
		name : nameV
	};

	if(params != undefined && typeof params == 'object'){
		$.extend(paramObj, params);		//추가 파라미터 객체(params) 를 파라미터(paramObj)에 추가
	}


	//callback function
	var callback = function(result){ //SUCCESS FUNCTION
		var obj = JSON.parse(result);

		var cnt = obj.resultVal;	//결과수
		var list = obj.resultList;	//결과데이터JSON

		if(cnt>0){
			returnObj = list;
			if(emptyObj != null)
				returnObj.unshift(emptyObj);	//select 박스용 첫번째 공백값 추가
		}

	};
	//공통 ajax 호출 (Sync 로)
	commonAjaxForSync("POST", url, paramObj, callback);

	return returnObj;
}



/**
 * select tag creator (optgroup 포함)
 *
 * @param id			- id명 & name명
 * @param jsonObj		- data
 * @param grpCode		- select 의 그룹코드문자열 KEY
 * @param grpName		- select 의 그룹문자열	 KEY
 * @param code			- select 의 값코드문자열	 KEY
 * @param name			- select 의 보여지는문자열 KEY
 * @param selectedVal	- 기본선택 option
 * @param changeFn		- change event handler function
 * @param colorObj		- {value : color, ...}
 * @param sWidth		- width
 * @param classNm		- style class
 * @returns {String}	- select tag string
 */
function createSelectOptgroupTag(id, jsonObj, grpCode, grpName, code, name, selectedVal, changeFn, colorObj, sWidth, classNm){

	var selTag = "<select name='" + id + "' id='" + id + "' class='" + ((classNm==null)?"AXSelect":classNm) + "' onchange='" + changeFn + "' ";
	selTag += "style='background-color:" + (selectedVal==null?"white":colorObj[selectedVal]) + ";width:" + sWidth;

	if(sWidth != undefined && sWidth != null && sWidth.length > 0){
		selTag += (sWidth.indexOf('%')>=0?"":"px");
	}
	selTag += ";'>";

	var beforeGrpCode = null;
	for(var i=0; i<jsonObj.length; i++) {
		if(beforeGrpCode != jsonObj[i][grpCode]){							//이전것의 그룹과 다를때
			if(i>0) selTag += "</optgroup>";								//첫번째가 아닐때 닫아주고
			if(i==0 && jsonObj[i][grpCode] == ''){
				//nothing
			}else{
				selTag += "<optgroup label='" + jsonObj[i][grpName] + "'>";		//새롭게 열어준다
			}
		}

		selTag += "<option value='" + jsonObj[i][code]  + "' " + (selectedVal==jsonObj[i][code]?"selected":"") + " ";
		selTag += "style='background-color:" + (colorObj[jsonObj[i][code]]==null?"white":colorObj[jsonObj[i][code]]) + ";width:" + sWidth;

		if(sWidth != undefined && sWidth != null && sWidth.length > 0){
			selTag += (sWidth.indexOf('%')>=0?"":"px");
		}

		selTag += ";'>" + jsonObj[i][name] + "</option>";

		if(i==jsonObj.length-1 && jsonObj[i][grpCode] != '') selTag += "</optgroup>";					//마지막일때 닫아준다.

		beforeGrpCode = jsonObj[i][grpCode];								//이전 그룹코드 변수 세팅
    }

	selTag += "</select>";

	return selTag;
}

/**
 * select tag creator
 *
 * @param id			- id명 & name명
 * @param jsonObj		- data
 * @param code			- select 의 값코드문자열
 * @param name			- select 의 보여지는문자열
 * @param selectedVal	- 기본선택 option
 * @param changeFn		- change event handler function
 * @param colorObj		- {value : color, ...}
 * @param sWidth		- width
 * @param classNm		- style class
 * @param disabled	- disabled
 * @returns {String}	- select tag string
 */
function createSelectTag(id, jsonObj, code, name, selectedVal, changeFn, colorObj, sWidth, classNm, disabled){
	var selTag = "<select name='" + id + "' id='" + id + "' class='" + ((classNm==null)?"AXSelect":classNm) + "' onchange='" + changeFn + "' ";
	selTag += ((disabled == "disabled") ? "disabled='disabled'" : "") ;
	selTag += "style='background-color:" + (selectedVal==null?"white":colorObj[selectedVal]) + ";width:" + sWidth + "px;'>";

	if(jsonObj != null){
		for(var i=0; i<jsonObj.length; i++) {
			selTag += "<option value='" + jsonObj[i][code]  + "' " + (selectedVal==jsonObj[i][code]?"selected":"") + " ";
			selTag += "style='background-color:" + (colorObj[jsonObj[i][code]]==null?"white":colorObj[jsonObj[i][code]]) + ";width:" + sWidth + "px;'";
			selTag += ">" + jsonObj[i][name] + "</option>";
	    }
	}

	selTag += "</select>";

	return selTag;
}
/**
 * select tag creator(프로젝트 selectBox용..)
 *
 * @param id			- id명 & name명
 * @param jsonObj		- data
 * @param code			- select 의 값코드문자열
 * @param name			- select 의 보여지는문자열
 * @param selectedVal	- 기본선택 option
 * @param changeFn		- change event handler function
 * @param colorObj		- {value : color, ...}
 * @param sWidth		- width
 * @param classNm		- style class
 * @param disabled	- disabled
 * @returns {String}	- select tag string
 */
function createSelectTagForProject(id, jsonObj, code, name, selectedVal, changeFn, colorObj, sWidth, classNm,type){
	var defaultId = "";
	var selTag = "<select name='" + id + "' id='" + id + "' class='" + ((classNm==null)?"AXSelect":classNm) + "' onchange='" + changeFn + "' ";
	selTag += "style='background-color:" + (selectedVal==null?"white":colorObj[selectedVal]) + ";width:" + sWidth + "px;'>";
	if(jsonObj != null){
		for(var i=0; i<jsonObj.length; i++) {
			selTag += "<option value='" + jsonObj[i][code]  + "' " + (selectedVal==jsonObj[i][code]?"selected":"") + " ";
			selTag += "style='background-color:" + (colorObj[jsonObj[i][code]]==null?"white":colorObj[jsonObj[i][code]]) + ";width:" + sWidth + "px;'";
			if(type == "ACTIVITY"){
				selTag += " startDate ='"+ jsonObj[i]["startDate"] + "' endDate = '" +jsonObj[i]["endDate"]+"'";
				selTag += " appvDocType ='"+ jsonObj[i]["appvDocType"] +"'";
				selTag += " vacationYn ='"+ jsonObj[i]["vacationYn"] +"'";
			}else if(type == "PROJECT"){
				selTag += " startDate ='"+ jsonObj[i]["startDate"] + "' lastDate = '" +jsonObj[i]["lastDate"]+"'"+ "' otExpense = '" +jsonObj[i]["otExpense"]+"'";
			}

			selTag += " employee ='"+ jsonObj[i]["employee"] +"'";
			selTag += " openFlag ='"+ jsonObj[i]["openFlag"] +"'";

			if(jsonObj[i]["defaultYn"]!=undefined &&jsonObj[i]["defaultYn"] == "Y" && defaultId==""){
				defaultId = id;
				selTag += "selected = 'selected'";
			}
			selTag += ">" + jsonObj[i][name] + "</option>";
	    }
	}

	selTag += "</select>";

	return selTag;
}

/**
 * radio tag creator
 *
 * @param radioName		- radio name명
 * @param jsonObj		- data
 * @param code			- select 의 값코드문자열
 * @param name			- select 의 보여지는문자열
 * @param selectedVal	- 기본선택 option
 * @param gap			- 버튼 간격 px(공백문자 &nbsp; 제외)
 * @param brTagIdx		- <br>테그를 넣으려는 위치 index (라디오 버튼들이 두줄로 표현되는 경우 깨지는 것을 막기위해 추가)
 * @param clickHandlerFn- 클릭 이벤트 핸들러 함수
 * @param direction		- 정렬 방향 ('W'(가로) or 'H'(세로))

 * @returns {String}	- radio tag string
 */
function createRadioTag(radioName, jsonObj, code, name, checkedVal, gap, brTagIdx, clickHandlerFn, direction){
	var rdTag = '';

	//간격을 추가로 주기
	var gapStyle = '';
	if(gap!=null && gap!=''){
		gapStyle = "style='padding-left:" + gap + "px;'";		//간격 스타일 넣기
	}
	if(brTagIdx==null || brTagIdx==''){
		brTagIdx = -1;
	}
	if(jsonObj != null){
		for(var i=0; i<jsonObj.length; i++) {
			rdTag += "<label " + (i==0||i==brTagIdx+1?'':gapStyle) + "><input type='radio' name='" + radioName + "' value='" + jsonObj[i][code]  + "' " + (checkedVal==jsonObj[i][code]?"checked":"") + " ";

			//클릭 이벤트 핸들러 함수
			if(clickHandlerFn!=undefined && clickHandlerFn!=null && clickHandlerFn!=''){		//index 뒤에 '<br>' 추가
				rdTag += " onchange='" + clickHandlerFn + "'";
			}

			rdTag += "/><span>" + jsonObj[i][name] + "</span></label>";

			if(direction!=null && direction!='' && direction=='H'){
				rdTag += "<br>";
			}else
			//<br>테그 넣는 옵션이 있을시 추가
			if(brTagIdx!=null && brTagIdx!='' && brTagIdx==i ){		//index 뒤에 '<br>' 추가
				rdTag += "<br>";
			}
	    }
	}


	return rdTag;
}

//모달 오픈
//messageDivId: 모달창에 보여질 영역의 div
//title: 모달창에 제목
//width: 가로 px (default : 700px)
//heigth: 가로 px (default : 500px)
//draggableClass: 팝업을 드래그할수 있는영역
//theme: jquery 테마 적용 여부 (default : true)
function openModalPop(messageDivId , title , width , heigth , top ,left ,draggableClass, theme){
	var modalMessage = $("#"+messageDivId);

	var modalTheme = (theme=='' || theme == undefined)?true:theme;
	var modalWidth = (width=='' || width == undefined)?'700px':width;
	var modalHeigth = (heigth=='' || heigth == undefined)?'500px':heigth;
	var modalTop = (top=='' || top == undefined)?'20%':top;
	var modalLeft = (left=='' || left == undefined)?'35%':left;
	var targetDraggableClass = (draggableClass=='' || draggableClass == undefined)?'popTitleZone':draggableClass;
	var closeDivId = "closePopUpMenu";
	$.blockUI({
		theme:     modalTheme,
		message: modalMessage
		//css 설정
	   ,css: {
		}
	  ,themedCSS: {
	        top:    modalTop,
	        left:   modalLeft
	    },
	    title : title
	   ,bindEvents:true
		//모달창 외부 클릭시 닫기
	   ,onOverlayClick: $.unblockUI
	   ,draggable : true

	});
	$("."+closeDivId).click(function(){$.unblockUI()});
	$(".ui-dialog-content").css("height",modalHeigth);
	/*$("."+targetDraggableClass).css("padding-top","20px");*/
	$("."+targetDraggableClass).addClass("ui-widget-header ui-dialog-titlebar ui-corner-all blockTitle ui-draggable-handle");

}

//공통팝업 바로보기 : post
//popName : 팝업 이름
//url : url ($frm 에 action이 존재한다면 빈값을 줄것 '')
//cusOption : window.open의 옵션 (빈값이나 null 일경우 디폴트옵션)
//$frm : jQuery form : 화면에서 팝업으로 form data를 넘기고 싶다면...
//$frm 의 action 이 get 방식의 url을 설정하지 않도록 주의.
function commonPopupOpen(popName,url,cuOption,$frm){
	var viewerFrm;
	var option = "width=500px,height=300px,resizable=yes,scrollbars = yes";
	if($frm != undefined){
		viewerFrm = $frm;
		if(url!="")
			viewerFrm.attr("action",url);
	}else{
		viewerFrm = $("<form id = 'viewerFrm'></form>");
		if(url!="")
			viewerFrm.attr("action",url);
	}
	if(url.indexOf("?")>0){
		var paramFullStr = url.split("?");
		viewerFrm.attr("action" ,paramFullStr[0]);

		var paramBuf = paramFullStr[1].split("&");
		for(var i=0;i<paramBuf.length;i++){
			var inputAttrBuf = paramBuf[i].split("=");
			var input = $("<input></input>");
			input.attr("type","hidden").attr("name",inputAttrBuf[0]).val(inputAttrBuf[1]);
			viewerFrm.append(input);
		}

	}
	if(cuOption!=undefined && cuOption != ""){
		option = cuOption;
	}
	viewerFrm.attr("method","post");
    window.open("",popName,option);
    viewerFrm.attr("target",popName).submit();
    if($frm != undefined){
    	$frm.attr("target","_self");
	}
}

/**
 * InputBox 금액 형식으로만 입력받는다. (keydown,blur숫자 , 콤마 ) : psj
 * @param elementId
 */
function numberFormatForNumberClass(){
	  var round = 2;
	  if($(".number").length>0){
		  $(".number").each(function(){
			  $(this).val(devUtil.fn_getNumberFormat($(this).val()));
		  })

	  }
	  $(".number").on("keydown",  function(event){
		  devUtil.fn_keyControl(event, "number");
	    }).on("keyup",  function(event){
	        var keyCode = ( window.event ) ? window.event.keyCode : event.which;
	        if ($(this).val() != "" && !(keyCode == 37 || keyCode == 39)) {
	        	$(this).val(devUtil.fn_getNumberFormat($(this).val()));
	        }
	        if(round != undefined && round != ''){

	        	var val = $(this).val();
	        	var arr = val.split("\.");
	        	if (arr.length > 1 && arr[1] !="") {
	                if(arr[1].length>round){
	                	val = "";
	                	alert("소수점 "+round + " 자리까지 입력 가능합니다.");
	                	val = arr[0]+"."+arr[1].substring(0,round);
	                	$(this).val(val);
	                }
	            }
	        }
	    }).on("blur", function(event){
	        if ($(this).val() != "") {
	            var chkNumber = /^-?(?:\d+|\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test($(this).val());
	            if (chkNumber == true) {
	            	 $(this).val(devUtil.fn_getNumberFormat($(this).val()));
	            } else {
	                alert("올바른 숫자 형식으로 입력하세요.");
	                $(this).val("");
	                $(this).focus();
	            }
	        }
	    });
}

/**
 * InputBox 숫자 형식으로만 입력받는다. (keydown,blur숫자만 ) : psj
 * 2016.11.24. 이인희 추가
 * @param elementId
 */
function numberFormatForDigitClass(){
	  /*if($(".digit").length>0){
		  $(".digit").each(function(){
			  $(this).val(devUtil.fn_getNumberFormat($(this).val()));
		  })
	  }*/
	  $(".digit").on("keydown",  function(event){
		  devUtil.fn_keyControl(event, "number");
	    })
	    /*.on("keyup",  function(event){
	        var keyCode = ( window.event ) ? window.event.keyCode : event.which;
	        if ($(this).val() != "" && !(keyCode == 37 || keyCode == 39)) {
	        	$(this).val(devUtil.fn_getNumberFormat($(this).val()));
	        }
	    })*/
	    .on("blur", function(event){
	        if ($(this).val() != "") {
	            var chkNumber = /^[0-9]*$/.test($(this).val());
	            if (chkNumber == true) {
	            	 //$(this).val(devUtil.fn_getNumberFormat($(this).val()));
	            } else {
	                alert("올바른 숫자 형식으로 입력하세요.");
	                $(this).val("");
	                $(this).focus();
	            }
	        }
	    });
}


var devUtil= {
        /*************************************************************************************************
        설명   : escape 특수문자 변경(& < > ' ")
        입력값 : vals - 변경할 내용
        **************************************************************************************************/
        fn_escapeReplace : function(vals){
            return vals.replace(/&/g,"&amp").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/'/g,"&#39;").replace(/\"/g,"&quot;");
        },
        /*************************************************************************************************
        설명   : key 입력 제어 (key이벤트 발생시)
        입력값 : e - event (필수값)
                 type - digits(0~9),digits2(0~9,), number(0~9-,.), date(0~9-), alphaNumeric(a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ)
        **************************************************************************************************/
        fn_keyControl : function(e, type) {
            var keyCode = ( window.event ) ? window.event.keyCode : e.which;
            var ctrl = ( window.event ) ? window.event.ctrlKey : e.ctrlKey;
            var shift = ( window.event ) ? window.event.shiftKey : e.shiftKey;
            var bKey = true;

            if (type == "digits") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "digits2") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift) || devUtil.fn_isValidDecimalSymbolKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "number") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberSymbolKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "date") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift) || devUtil.fn_isValidDateSymbolKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "alphaNumeric") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift) || devUtil.fn_isValidEnglishKey(keyCode, ctrl, shift) || devUtil.fn_isValidHangulKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            }else if (type == "alphaNumeric2") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift) || devUtil.fn_isValidEnglishKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "alphaDotNumeric") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift) || devUtil.fn_isValidEnglishKey(keyCode, ctrl, shift) || devUtil.fn_isValidDotSymbolKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "password") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidNumberKey(keyCode, ctrl, shift) || devUtil.fn_isValidEnglishKey(keyCode, ctrl, shift) || devUtil.fn_isValidSymbolKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "email") {
                if(devUtil.fn_isValidFunctionKey(keyCode, ctrl, shift) || devUtil.fn_isValidEmailKey(keyCode, ctrl, shift) || devUtil.fn_isValidEnglishKey(keyCode, ctrl, shift) || devUtil.fn_isValidDotSymbolKey(keyCode, ctrl, shift) || devUtil.fn_isValidDateSymbolKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            } else if (type == "nospace") {
                if(devUtil.fn_isValidSpaceKey(keyCode, ctrl, shift)) return;
                else bKey = false;
            }

            if (bKey == false) {
                if (window.event){
                    window.event.returnValue = false;
                } else {
                    e.preventDefault();
                    e.stopPropagation();
                }
            }
        },
        /*************************************************************************************************
        입력값 : keyCode: 이벤트 keycode
                 ctrl: control key 여부
                 shift: shift key 여부
        **************************************************************************************************/
        fn_isValidFunctionKey: function (keyCode, ctrl, shift) {
            var isValid = false;
            if(ctrl && keyCode == 67) { //ctrl + c
                isValid = true;
            } else if(ctrl && keyCode == 86) { //ctrl + v
                isValid = true;
            } else if(keyCode == 8 || keyCode == 9 || keyCode == 46) {//backspace, tab, delete
                isValid = true;
            } else if(keyCode == 37 || keyCode == 39) {//left, right
                isValid = true;
            }

            return isValid;
        },
        /*************************************************************************************************
        입력값 : keyCode: 이벤트 keycode
                 ctrl: control key 여부
                 shift: shift key 여부
        **************************************************************************************************/
        fn_isValidNumberKey: function (keyCode, ctrl, shift) {
            var isValid = false;

            if(shift == false && 48 <= keyCode && keyCode <= 57) { //0~9
                isValid = true;
            } else if(shift == false && 96 <= keyCode && keyCode <= 105) { //키패드 0~9
                isValid = true;
            }

            return isValid;
        },
        /*************************************************************************************************
        입력값 : keyCode: 이벤트 keycode
                 ctrl: control key 여부
                 shift: shift key 여부
        **************************************************************************************************/
        fn_isValidNumberSymbolKey: function (keyCode, ctrl, shift) {
            var isValid = false;
            if(browserDetect.browser == "Opera") {
                if(keyCode == 78 || keyCode == 46) {// .
                    isValid = true;
                } else if(keyCode == 45) {// -
                    isValid = true;
                } else if(keyCode == 44) {// ,
                    isValid = true;
                }
            } else {
                if(keyCode == 110 || keyCode == 190) {// .
                    isValid = true;
                } else if(keyCode == 189 || keyCode == 109) {// -
                    isValid = true;
                } else if(keyCode == 188) {// ,
                    isValid = true;
                }
            }

            return isValid;
        },
        fn_isValidDecimalSymbolKey: function (keyCode, ctrl, shift) {
            var isValid = false;
            if(browserDetect.browser == "Opera") {
                if(keyCode == 45) {// -
                    isValid = true;
                } else if(keyCode == 44) {// ,
                    isValid = true;
                }
            } else {
                if(keyCode == 189 || keyCode == 109) {// -
                    isValid = true;
                } else if(keyCode == 188) {// ,
                    isValid = true;
                }
            }

            return isValid;
        },
        /*************************************************************************************************
        입력값 : keyCode: 이벤트 keycode
                 ctrl: control key 여부
                 shift: shift key 여부
        **************************************************************************************************/
        fn_isValidDateSymbolKey: function (keyCode, ctrl, shift) {
            var isValid = false;

            if(browserDetect.browser == "Opera") {
                if(keyCode == 45) {// -
                    isValid = true;
                }
            } else {
                if(keyCode == 189 || keyCode == 109) {// -
                    isValid = true;
                }
            }

            return isValid;
        },
        /*************************************************************************************************
        입력값 : keyCode: 이벤트 keycode
                 ctrl: control key 여부
                 shift: shift key 여부
        **************************************************************************************************/
        fn_isValidEnglishKey: function (keyCode, ctrl, shift) {
            var isValid = false;

            if(65 <= keyCode && keyCode <= 90) {// 알파벳
                isValid = true;
            }

            return isValid;
        },
        /*************************************************************************************************
        입력값 : keyCode: 이벤트 keycode
                 ctrl: control key 여부
                 shift: shift key 여부
        **************************************************************************************************/
        fn_isValidHangulKey: function (keyCode, ctrl, shift) {
            var isValid = false;

            if(browserDetect.browser == "Opera") {
                if( 197 == keyCode) {// 한글
                    isValid = true;
                }
            } else if(browserDetect.browser == "Firefox") {
                if( 0 == keyCode) {// 한글
                    isValid = true;
                }
            } else {
                if( 229 == keyCode) {// 한글
                    isValid = true;
                }
            }

            return isValid;
        },
        /*************************************************************************************************
        설명   : 숫자 천단위 콤마 추가
        입력값 : num - 변환할문자
        예)    : devUtil.fn_getNumberFormat('100000');
        **************************************************************************************************/
        fn_getNumberFormat : function(num) {
            /*if(this.fn_isUndefined(num) == ""){
                return "0";
            }*/

            var val = num.toString().replace(/,/g,"");
            var reg = /(^[+-]?\d+)(\d{3})/;
            while(reg.test(val)){
                val = val.replace(reg, "$1"+","+"$2");
            }
            return val;
        }
};

/*************************************************************************************************
설명   :브라우저명, 버전
**************************************************************************************************/
var browserDetect = {
    init: function () {
        this.browser = this.searchString(this.dataBrowser) || "Other";
        this.version = this.searchVersion(navigator.userAgent) || this.searchVersion(navigator.appVersion) || "Unknown";

        return this;
    },
    searchString: function (data) {
        for (var i = 0; i < data.length; i++) {
            var dataString = data[i].string;
            this.versionSearchString = data[i].subString;

            if (dataString.indexOf(data[i].subString) !== -1) {
                return data[i].identity;
            }
        }
    },
    searchVersion: function (dataString) {
        var index = dataString.indexOf(this.versionSearchString);
        if (index === -1) {
            return;
        }

        var rv = dataString.indexOf("rv:");
        if (this.versionSearchString === "Trident" && rv !== -1) {
            return parseFloat(dataString.substring(rv + 3));
        } else {
            return parseFloat(dataString.substring(index + this.versionSearchString.length + 1));
        }
    },

    dataBrowser: [
        {string: navigator.userAgent, subString: "OPR", identity: "Opera"},
        {string: navigator.userAgent, subString: "MSIE", identity: "Explorer"},
        {string: navigator.userAgent, subString: "Trident", identity: "Explorer"},
        {string: navigator.userAgent, subString: "Firefox", identity: "Firefox"},
        {string: navigator.userAgent, subString: "Chrome", identity: "Chrome"},
        {string: navigator.userAgent, subString: "Safari", identity: "Safari"}
    ]

};
var browserInfo = browserDetect.init();



/*************************************************************************************************
북마크 체크 (즐겨찾기 체크 : 메뉴의 별 표시 누르는 경우)
**************************************************************************************************/
function checkBookmark(value){
	var url = contextRoot + "/basic/checkBookmark.do";
	var param = {
			menuId : value
	};

	var callback = function(result){

		var obj = JSON.parse(result);
		//console.log(obj);
		$('#imgAtag').removeClass('add');
		if(obj.result == 'SUCCESS'){
			var list = obj.resultObject.bookmarkList;
			$("ul.quickmn_list").html("");
			var exist = false;
			for(var i = 0 ;i < list.length ;i++){
				var item = list[i];
				$("<li id="+item.menuId+"><a href='"+contextRoot+"/"+item.menuPath+"' " + (item.menuId==value ? 'class="current_favor"' : '') + ">"+item.menuKor+"</a>").appendTo("ul.quickmn_list");

				if(item.menuId == value) exist = true;		//북마크 리스트에 존재
			}

			/*var srcStr = contextRoot + '/images/common/' + (exist?'btn_bookmark_delete.png':'btn_bookmark.png');
			$('#bookmark_img_tag').attr('src', srcStr);*/


			$('#imgAtag').addClass((exist ? 'add':''));

		}else{
			alertM("즐겨찾기 등록/삭제 도중 오류가 발생하였습니다.");
			return;
		}
	};

	commonAjax("POST", url, param, callback);

}

// 팝업창 최대화
function screenResizeFull(){
	 self.moveTo(0,0); //창위치
	 self.resizeTo(screen.availWidth, screen.availHeight); //창크기
}


/*
*  originalstr: lpad 할 text
* length: lpad할 길이
* strToPad: lpad 시킬 text
*/
function lpad(originalstr, length, strToPad) {
    while (originalstr.length < length)
        originalstr = strToPad + originalstr;
    return originalstr;
}

/*
*  originalstr: rpad 할 text
* length: rpad할 길이
* strToPad: rpad 시킬 text
*/

function rpad(originalstr, length, strToPad) {
    while (originalstr.length < length)
        originalstr = originalstr + strToPad;
    return originalstr;
}

// 부모창 호출용, 2016.11.25. 이인희
function openPage(){
	// 지우지 마시오.
}
function openPageReload(){
	// 지우지 마시오.
}


//고객신규 등록 재오픈
function reOpenCst(workCstNm, actionType,sNb){
	var url = "";
	if(actionType == "INSERT") url =contextRoot+"/person/regCstPopup.do";
	else if(actionType == "UPDATE") url =contextRoot+"/person/modifyCst.do";

	var str ='<form method="POST" name="frmReOpenCst" id="frmReOpenCst" action="'+url+'" target="regCstPopupNew">';
	str +='<input type="hidden" name="openPage" id="openPage" value="WORK_PAGE">';
	str +='<input type="hidden" name="workCstNm" id="workCstNm" value="'+workCstNm+'">';
	str +='<input type="hidden" name="sNb" id="sNb" value="'+sNb+'">';
	str +='</form>';
	$(document.body).append(str);

    var popStatus = window.open('', 'regCstPopupNew','resizable=no,width=968,height=630,scrollbars=yes');
    document.frmReOpenCst.submit(); // target에 쏜다.

    $("#frmReOpenCst").remove();

    return popStatus;


}

//회사신규 등록 재오픈
function reOpenCpn(workCpnNm,actionType,cpnId){
	var url =  contextRoot+"/company/rgstCpn.do";

	var str ='<form method="POST" name="frmReOpenCpn" id="frmReOpenCpn" action="'+url+'" target="companyProcessPop">';
	str +='<input type="hidden" name="openPage" id="openPage" value="WORK_PAGE">';
	str +='<input type="hidden" name="workCpnNm" id="workCpnNm" value="'+workCpnNm+'">';
	str +='<input type="hidden" name="cpnId" id="cpnId" value="'+cpnId+'">';
	str +='</form>';
	$(document.body).append(str);

    var popStatus = window.open('', 'companyProcessPop','resizable=no,width=968,height=600,scrollbars=yes');
    document.frmReOpenCpn.submit(); // target에 쏜다.

    $("#frmReOpenCpn").remove();

    return popStatus;


}

////////////////////////spin////////////////////
var opts_main = {
		  lines: 17, // The number of lines to draw
		  length: 20, // The length of each line
		  width: 10, // The line thickness
		  radius: 34, // The radius of the inner circle
		  corners: 1, // Corner roundness (0..1)
		  rotate: 0, // The rotation offset
		  direction: 1, // 1: clockwise, -1: counterclockwise
		  color: '#EBFBFF', // #rgb or #rrggbb or array of colors
		  speed: 1, // Rounds per second
		  trail: 60, // Afterglow percentage
		  shadow: false, // Whether to render a shadow
		  hwaccel: false, // Whether to use hardware acceleration
		  className: 'spinner', // The CSS class to assign to the spinner
		  zIndex: 2e9, // The z-index (defaults to 2000000000)
		};
var spinner_main;
function progressView(){
	$('#ajaxProgress_progress').css('display','block');
	var target = document.getElementById('ajaxProgress_progress');
	spinner_main = new Spinner(opts_main).spin(target);
}
//ajax용 화면 보호기
function wrapWindowByMask(){
	//화면의 높이와 너비를 구한다.
	var maskHeight = document.body.scrollHeight;
	var maskWidth = $(window).width();

	//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
	$('#ajaxProgress_mask').css({'width':maskWidth,'height':maskHeight});

	//애니메이션 효과 - 일단 *초동안 까맣게 됐다가 30% 불투명도로 간다.
	$('#ajaxProgress_mask').fadeIn(0);				//0/1000 초동안 까맣게 됐다가
	$('#ajaxProgress_mask').fadeTo("slow",0.3);		//30% 불투명도로

	//윈도우 같은 거 띄운다.
	$('.window').show();
}


//--------------------유저 선택 공통 팝업 호출

function userSelectPopCall(paramList){


	if($('#userSelectCheckPopFrm')!=undefined) $('#userSelectCheckPopFrm').remove();
	var url =contextRoot+"/user/selectUserCheckPopup/pop.do";
	var str ='<form method="POST" name="userSelectCheckPopFrm" id="userSelectCheckPopFrm" action="'+url+'" target="userPop">';

	for(var i=0;i<paramList.length;i++){
		var paramObj = paramList[i];
		str +='<input type="hidden" name="'+paramObj.name+'" id="'+paramObj.name+'" value="'+ (paramObj.value.length == 0 ? '' : paramObj.value)+'"> ';
	}

	str +='</form>';

	$(document.body).append(str);


	var option = "left=" + (screen.width > 1400?"550":"0") + ", top=" + (screen.height > 810?"100":"0") + ", width=1000, height=800, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=no";
	window.open('','userPop',option);
	//document.userSelectCheckPopFrm.action = url;
	//document.userSelectCheckPopFrm.target = "userPop";
	document.userSelectCheckPopFrm.submit(); // target에 쏜다.
	return false;

}


//다음 주소찾기 팝업 오픈
function execDaumPostcodePop(){
	var option = "width=560px,height=650px,resizable=yes,scrollbars = yes";
	window.open(contextRoot+"/common/postPopup.do","daumPostPop",option);
}

/**
 *  yyyy-MM-dd 포맷으로 반환
 */
function getFormatDate(date,sep){
	var year = date.getFullYear();                                 //yyyy
	var month = (1 + date.getMonth());                     //M
	month = month >= 10 ? month : '0' + month;     // month 두자리로 저장
	var day = date.getDate();                                        //d
	day = day >= 10 ? day : '0' + day;                            //day 두자리로 저장
	return  year + sep + month + sep + day;
}

//파일 사이즈 체크
//파일 사이즈를 담는 input name 값.
function getFileSize(inputFileSizeName,inputFileName){

	var fileSize = 0;
	var chk = true;

	if(inputFileName == '' || inputFileName == undefined){

		chk = false;
	}

	//ie 9버전 이하 파일 사이즈 체크 안함.
	if (chk && browserDetect.browser == 'Explorer'){
		if(browserDetect.version <10){
			chk = false;
		}
	}

	if(chk){
		var fileList = $("input[name="+inputFileName+"]")[0].files;
		for(var i=0;i<fileList.length;i++){
			fileSize+=(parseInt(fileList[i].size));
		}
	}


	$("input[name="+inputFileSizeName+"]").each(function(index, value){
		fileSize += parseInt($(this).val());
	});

	return fileSize;
}

//파일 갯수체크
//파일 사이즈를 담는 input name 값.
function getFileCount(inputFileName){

	var fileCnt = 0;
	$("input[name="+inputFileName+"]").each(function(index, value){
		fileCnt ++;
	});

	return fileCnt;
}

//파일 확장자 체크
function getFileExtCheck(inputFileName,fileType){

	var chk =  'true';
	var imgArr = ['JPEG','BMP','GIF','PNG','JPG'];

	$("input[name="+inputFileName+"]").each(function(index, value){

		var fileName = $("input[name="+inputFileName+"]").val();	//파일 이름
		var extIdx = fileName.lastIndexOf('.');
		var ext = fileName.substring(extIdx+1,fileName.length);


		if(fileType == 'img'){
			if(getArrayIndexWithValue(imgArr, ext.toUpperCase())<0){
				chk = 'false';
				return chk;
			}

		}else if(fileType != ext){
			chk = 'false';
			return chk;
		}


	});
	return chk;
}

//URL 체크
function getUrlCheck(str) {
	var pattern = new RegExp('^(https?:\\/\\/)?'+ // protocol
	  '((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|'+ // domain name
	  '((\\d{1,3}\\.){3}\\d{1,3}))'+ // OR ip (v4) address
	  '(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*'+ // port and path
	  '(\\?[;&a-z\\d%_.~+=-]*)?'+ // query string
	  '(\\#[-a-z\\d_]*)?$','i'); // fragment locator
	if(!pattern.test(str)) {
		return false;
	} else {
		return true;
	}
}

//날짜를 입력 하면 날짜로부터 숫자만큼 이후날의 날짜를 mm-dd-yyyy 형식으로 돌려 준다.
function getNextDate(strDate, day){
	 var caledmonth, caledday, caledYear;
	 var arrDate = strDate.split('-');
	 var loadDt = new Date(arrDate[0],arrDate[1],arrDate[2]);
	 loadDt.setMonth(loadDt.getMonth()-1); //한달 전해야 이번달이 됨

	 var nextDay = day-1;
	 /*for(var i=0;i<day;i++){
		 var tempDate = new Date(Date.parse(loadDt) + i*1000*60*60*24);
		 if(tempDate.getDay() == 0 || tempDate.getDay() == 6){ //토요일 일요일이면 하루더
			 nextDay++;
		 }
	 }
	 var targetDate = new Date(Date.parse(loadDt) + nextDay*1000*60*60*24);
	 if(targetDate.getDay() == 0){ //일요일이면 하루더
		 nextDay++;
		 targetDate = new Date(Date.parse(loadDt) + nextDay*1000*60*60*24);
	 }*/
	 var targetDate = new Date(Date.parse(loadDt) + nextDay*1000*60*60*24);

	 caledYear = targetDate.getFullYear();

	 if( targetDate.getMonth() < 9 ){
	  caledmonth = '0'+(targetDate.getMonth()+1);
	 }else{
	  caledmonth = targetDate.getMonth()+1;
	 }
	 if( targetDate.getDate() <= 9 ){
	  caledday = '0'+targetDate.getDate();
	 }else{
	  caledday = targetDate.getDate();
	 }
	 return caledYear +'-'+caledmonth+'-'+caledday;
}

//날짜를 입력 하면 요일을 돌려준다.
function getDateWeek(strDate){
	 var arrDate = strDate.split('-');
	 var loadDt = new Date(arrDate[0],arrDate[1],arrDate[2]);
	 loadDt.setMonth(loadDt.getMonth()-1); //한달 전해야 이번달이 됨

	 //0일,1월,2화,3수,4목,5금,6토
	 return loadDt.getDay();
}

function getDateWeekLabel(strDate){
	var week = new Array('일', '월', '화', '수', '목', '금', '토');
	var today = new Date(strDate).getDay();
	var todayLabel = week[today];
	return todayLabel;
}


function getDateFormat(newDate){

	 var targetDate = new Date(newDate);

	 caledYear = targetDate.getFullYear();

	 if( targetDate.getMonth() < 9 ){
	  caledmonth = '0'+(targetDate.getMonth()+1);
	 }else{
	  caledmonth = targetDate.getMonth()+1;
	 }
	 if( targetDate.getDate() <= 9 ){
	  caledday = '0'+targetDate.getDate();
	 }else{
	  caledday = targetDate.getDate();
	 }
	 return caledYear +'-'+caledmonth+'-'+caledday;
}

//전체 문자열 반복적으로 치환하기
function replaceAll(str,org, dest) {
    return str.split(org).join(dest);
}


//날짜형식이 맞는지 체크
//6자리면 앞에 19를 붙임
function isValidDate(param) {
	try {

      if(param.length == 6){
          param = "19" + param;
      }
		param = param.replace(/-/g, '');

		// 자리수가 맞지않을때
		if (isNaN(param) || param.length != 8) {
			return false;
		}

		var year = Number(param.substring(0, 4));
		var month = Number(param.substring(4, 6));
		var day = Number(param.substring(6, 8));

		if (month < 1 || month > 12) {
			return false;
		}

		var maxDaysInMonth = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
		var maxDay = maxDaysInMonth[month - 1];

		// 윤년 체크
		if (month == 2 && (year % 4 == 0 && year % 100 != 0 || year % 400 == 0)) {
			maxDay = 29;
		}

		if (day <= 0 || day > maxDay) {
			return false;
		}
		return true;

	} catch (err) {
		return false;
	}
	;
}

/**  주민등록번호 형식을 검증한다. */
function checkResIdNo( srcNumeric )
{
    var sum = 0;

    if ( srcNumeric.length < 13 ) return false;

    for( var nIndex = 0; nIndex < 8; nIndex++ ) { sum += srcNumeric.substring( nIndex, nIndex + 1 ) * ( nIndex + 2 ); }
    for( var nIndex = 8; nIndex < 12; nIndex++ ) { sum += srcNumeric.substring( nIndex, nIndex + 1 ) * ( nIndex - 6 ); }

    sum = 11 - ( sum % 11 );

    if ( sum >= 10 ) { sum -= 10; }
    if ( srcNumeric.substring( 12, 13 ) != sum || ( srcNumeric.substring( 6, 7 ) != 1 && srcNumeric.substring( 6, 7 ) != 2&& srcNumeric.substring( 6, 7 ) != 3&& srcNumeric.substring( 6, 7 ) != 4 ) ) { return false; }

    return true;
}

//유저 프로필 박스를 보여준다.
//userId : 사용자 시퀀스
//element : 프로필박스 노출 대상 엘리먼트 Jquery Selector ...ex) $(this)
//openEvent : 프로필박스 노출 이벤트 ,Jquery on 이벤트 ex) mouseover , click ....
//endEvent  : 프로필박스 hide이벤트 ,Jquery on 이벤트 ex) mouseover , click ....
//left : 기본적으로 element밑에 나오도록하지만 화면구성에따라 좌측으로 위치조절한다 ,type of int...ex)100,-200..
//pointLeft : 프로필박스 상단 ^ 포인트 위치조절 ,기본값은 제일 좌측 ,type of int...ex)100,-200..
//parentModalId: 프로필박스가 하단에있어 노출됬을때 창크기를 조절해야한다면 부모창 모달변수명을 넘긴다.
function openUserProfileBox(userId ,element ,openEvent ,endEvent,top,left,pointLeft,type){

	//ie 는 top위치가 차이가 있어 조절한다.
	if (browserDetect.browser == 'Explorer'){
		top = top+8;
	}

	//유저 프로필박스 오픈
	var open = function(event){
		var $frm = $("<form></form>");
		$frm.attr("id" , "personnelProfileFrm").attr("name","personnelProfileFrm");

		var $input1 = $("<input></input>");
		$input1.attr("id","userProfileId").attr("name","userProfileId").attr("type","hidden");
		$input1.val(userId);
		$frm.append($input1);

		var $input2 = $("<input></input>");
		$input2.attr("id","type").attr("name","type").attr("type","hidden");
		$input2.val(type);
		$frm.append($input2);

		$frm.attr("action",contextRoot+"/user/getUserProfileAjax.do");

		$("#personnelProfileArea").append($frm);


		var callback = function(data){
			$("#personnelProfileArea").html(data);
			$("#personnelProfileArea").show();

			var obj = element.offset();

			var leftBuf = left == undefined?0:parseInt(left);

		    $("#personnelProfileArea").css("top",obj.top+top).css("left",obj.left+left).css("position","absolute").css("z-index","9999999");

		    if(pointLeft!= undefined){
		    	$(".edge_topleft").css("left",pointLeft);
		    }

		}
		commonAjaxSubmit("POST",$frm,callback);
	}

	//유저 프로필박스 오픈 1초뒤..for mouseover
	var openTimeOut = function(event){
		element.attr("userProfileType","proc");
		//1초후 실행한다
		setTimeout(function(){

			if(element.attr("userProfileType")!="proc") return;


			var $frm = $("<form></form>");
			$frm.attr("id" , "personnelProfileFrm").attr("name","personnelProfileFrm");

			var $input1 = $("<input></input>");
			$input1.attr("id","userProfileId").attr("name","userProfileId").attr("type","hidden");
			$input1.val(userId);
			$frm.append($input1);

			var $input2 = $("<input></input>");
			$input2.attr("id","type").attr("name","type").attr("type","hidden");
			$input2.val(type);
			$frm.append($input2);

			$frm.attr("action",contextRoot+"/user/getUserProfileAjax.do");

			$("#personnelProfileArea").append($frm);


			var callback = function(data){
				$("#personnelProfileArea").html(data);
				$("#personnelProfileArea").show();

				var obj = element.offset();

				var leftBuf = left == undefined?0:parseInt(left);

			    $("#personnelProfileArea").css("top",obj.top+top).css("left",obj.left+left).css("position","absolute").css("z-index","9999999");

			    if(pointLeft!= undefined){
			    	$(".edge_topleft").css("left",pointLeft);
			    }

			}
			commonAjaxSubmit("POST",$frm,callback);
		},1000);

	}

	//유저 프로필박스 닫기
	var close = function(){
		closeUserProfileBox();
	}

	//유저 프로필박스 이벤트 설정
	var $target = element;
	$target.css("cursor","pointer");
	//우클릭..
	if(openEvent == "rClick"){
		$target.mousedown(function(e){
			if(e.which == 3){
				open();
			}
		});
	//일반적은 mouseover이벤트는 1초후 실행 , 1초가 지나지않으면 비노출
	}else if(openEvent == "mouseover"){
		$target.on(openEvent,openTimeOut);

		$target.on("mouseout",function(){
			$(this).attr("userProfileType","end");
		});
	}
	//일반적인 on 이벤트
	else{
		$target.on(openEvent,open);
	}

	if(endEvent!=undefined&&endEvent!=null&&endEvent!=""){
		$target.on(endEvent,close);
	}
}
//유저프로필박스 닫기
function closeUserProfileBox(){
	$("#personnelProfileArea").empty();
	$("#personnelProfileArea").hide();
	$("#personnelProfileArea").css("");
}
//유저프로필 이벤트 셋팅
function initUserProfileEvent(){
	//유저프로필 이벤트 셋팅
	$(".userProfileTargetArea").each(function(){
		$(this).trigger("onmousedown");
		$(this).css("cursor","pointer");
		$(this).off("onmousedown");
		$(this).removeClass("userProfileTargetArea");
	});

	closeUserProfileBox();
}

//메모 말풍선
function openMemoHelpArea(length,top,left){
	var openFnc = function($obj){
		var txt = $obj.find("a").html();

		if(txt.length>length){
			$("#memoCommonHelpPopStr").html(txt.replace(/(?:\r\n|\r|\n)/g, '<br />'));
			$("#memoCommonHelpPop").show();
			$("#memoCommonHelpPopTooltipBox").show();
			var obj = $obj.offset();

		    $("#memoCommonHelpPop").css("top",obj.top+top).css("left",obj.left+left).css("position","absolute").css("z-index","9999999");
		}
	}
	$(".memo_list").find("li").on("mouseover",function(){openFnc($(this))});
	$(".memo_list").find("li").on("mouseout",function(){closeMemoHelpArea();});
}

//메모 말풍선 닫기
function closeMemoHelpArea(){
	$("#memoCommonHelpPop").hide();
	$("#memoCommonHelpPopTooltipBox").hide();
}
//접속 디바이스를 판별한다.
function contactDeviceChk(){
	var filter = "win16|win32|win64|mac";

	var loginLoc = "";
	if(navigator.platform){
		if(0 > filter.indexOf(navigator.platform.toLowerCase())){
			loginLoc = "MOBILE";
		}else{
			loginLoc = "PC";
		}
	}

	return loginLoc;
}
