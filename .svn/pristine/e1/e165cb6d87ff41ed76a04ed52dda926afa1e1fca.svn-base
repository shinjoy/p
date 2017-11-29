/**
 * ajaxRequest.js
 *
 * ajax request 처리하는 공통 js
 *
 * (*필요 js : jquery, jquery-ui, jquery.blockUI)
 */


/**
 * 공통 ajax request
 *
 * @param pgType		: "POST" "GET"
 * @param url			: request url
 * @param paramObj		: parameter object
 * @param callbackFn	: callback function
 * @param isAsync		: true(async) or false(sync)
 */
function commonAjax(pgType, url, paramObj, callbackFn, isAsync, beforeFn, completeFn){

	// async or sync
	var async = true;	//default : async(비동기)
	if(isAsync != null){
		async = isAsync;
	}


	//상태값 update
	$.ajax({
		type	: pgType,        			//"POST" "GET"
		url		: url,    					//PAGEURL
		data	: paramObj,					//parameter object
		timeout : 100000,       				//제한시간 지정(millisecond)
		cache 	: false,        			//true, false
		//success : callbackFn,				//SUCCESS FUNCTION
		success : function(result) {
			// json으로 올바르게 오는지 체크함.
			var is_json = true;
			try {
				var json = $.parseJSON(result);
			} catch (err) {
				is_json = false;
			}
			if (!is_json) { // html로 온 경우.
				var indexOf = result.indexOf("SESSION OUT");
				if (indexOf > 0) {
					//SESSION OUT인 경우.
					alert("세션아웃 되었습니다.");
					location.href=contextRoot;
				}else {
					callbackFn(result);
				}
			} else
				callbackFn(result); // SUCCESS FUNCTION
		},
		async	: async,
		error	: function whenError(x,e){	// ERROR FUNCTION
			alertMsg("[FAIL!!]\n\n실패하였습니다!\n\n재시도후 문의바랍니다!");
		},
		beforeSend: beforeFn,
	    complete: completeFn
	});
}

/**
 * 공통 ajax request
 *
 * @param pgType		: "POST" "GET"
 * @param url			: request url
 * @param paramObj		: parameter object
 * @param callbackFn	: callback function
 * @param isAsync		: true(async) or false(sync)
 */
function commonAjaxForFail(pgType, url, paramObj, callbackFn, failFn, isAsync, beforeFn, completeFn){

	// async or sync
	var async = true;	//default : async(비동기)
	if(isAsync != null){
		async = isAsync;
	}


	//상태값 update
	$.ajax({
		type	: pgType,        			//"POST" "GET"
		url		: url,    					//PAGEURL
		data	: paramObj,					//parameter object
		timeout : 100000,       				//제한시간 지정(millisecond)
		cache 	: false,        			//true, false
		success	: callbackFn,				//SUCCESS FUNCTION
		async	: async,
		error	: failFn,
		beforeSend: beforeFn,
	    complete: completeFn
	});
}



/**
 * 공통 ajax request (동기방식!!으로 호출)
 *
 * @param pgType		: "POST" "GET"
 * @param url			: request url
 * @param paramObj		: parameter object
 * @param callbackFn	: callback function
 */
function commonAjaxForSync(pgType, url, paramObj, callbackFn, beforeFn, completeFn){
	commonAjax(pgType, url, paramObj, callbackFn, false, beforeFn, completeFn);		//async : false 로 주어 동기방식으로 처리
}


/**
 * 저장(등록, 수정)
 *
 * @param url
 * @param paramObj
 */
function saveAjax(url, paramObj){

	//callback function
	var callback = function(arg){ //SUCCESS FUNCTION
		var obj = JSON.parse(arg);		//위에서 dataType: "json" 으로 하면 자동변환되므로 파싱이 필요없다.
		if(obj.result == "SUCCESS"){ //alert("저장하였습니다!");
			alertMsg("저장하였습니다!");

		}else{		   //"FAIL"
			if(obj.resultVal == "SESSION"){		//session out
				//alertLogin();					//login pop
			}else{
				//alertMsg("[FAIL!!]\n\n" + decodeURIComponent(obj.resultMsg));
			}
		}
	};

	//공통 ajax 호출
	commonAjax("POST", url, paramObj, callback);
}


/**
 * 공통 ajax request (동기방식!!으로 호출)
 *
 * @param pgType :
 *            "POST" "GET"
 * @param url :
 *            request url
 * @param paramObj :
 *            parameter object
 * @param callbackFn :
 *            callback function
 */
function commonAjaxSubmit(pgType, $frm, callbackFn, isAsync) {
	// async or sync
	var async = true; // default : async(비동기)
	if (isAsync != null) {
		async = isAsync;
	}

	var frmId = $frm.attr("id");

	var paramJson = $frm.serialize();

	// 상태값 update
	$.ajax({
		type : pgType, // "POST" "GET"
		url : $frm.attr("action"), // PAGEURL
		data : paramJson, // parameter object
		timeout : 30000, // 제한시간 지정(millisecond)
		cache : false, // true, false
		success : function(data){
			if(data.substring(0,1)=="{"){
				data = $.parseJSON(data);
			}
			callbackFn(data); // SUCCESS FUNCTION
		},
		async : async,
		error : function(req, status, error) { // ERROR FUNCTION
			alertMsg("[FAIL!!]\n\n실패하였습니다!\n\n재시도후 문의바랍니다!");
		}
	});
}



/**
 * 파일포함 전송 ajax request
 *
 * @param fileObj		: file array
 * @param url			: request url
 * @param paramObj		: parameter object
 * @param callbackFn	: callback function
 * @param isAsync		: true(async) or false(sync)
 */
function commonAjaxForFile(fileObj, url, paramObj, callbackFn, isAsync){

	var data = new FormData();

	//파일 첨부
	if(fileObj!=null){
		for(var i=0; i<fileObj.length; i++){
			data.append('file' + i, fileObj[i]);
		}
	}

	//파일 외 정보 첨부
	for(var key in paramObj){
		var obj = paramObj[key];
		if(obj instanceof Array){
			//배열인 경우
			data.append(key, JSON.stringify(obj));

		}else{
			data.append(key, paramObj[key]);
		}
	}


	//ajax 호출
	$.ajax({
		type	: "POST",        			//"POST" "GET"
		url		: url,    					//PAGEURL
		dataType: "text",
		data	: data,					//parameter object
		processData: false,
		contentType: false,
		timeout : 30000,       				//제한시간 지정(millisecond)
		cache 	: false,        			//true, false
		//success	: callbackFn,				//SUCCESS FUNCTION
		success : function(result) {
			// json으로 올바르게 오는지 체크함.

			var is_json = true;
			try {
				var json = $.parseJSON(result);
			} catch (err) {
				is_json = false;
			}

			if (!is_json) { // html로 온 경우.
				var indexOf = result.indexOf("SESSION OUT");
				if (indexOf > 0) {
					//SESSION OUT인 경우.
					alert("세션아웃 되었습니다.");
					location.href=contextRoot;
				}
			} else
				callbackFn(result); // SUCCESS FUNCTION
		},
		async	: true,
		error	: function whenError(x,e){	//ERROR FUNCTION
			//alert(x.responseText);
			alertMsg("[FAIL!!]\n\n실패하였습니다!\n\n재시도후 문의바랍니다!");
		}
	});

}//commonAjaxForFile



/**
 * 파일 전송 form.js -ie 호환
 *
 * @param maxFileCount	: 첨부가능 최대 파일 카운트
 * @param url			: request url
 * @param inputFileName	: input file name
 * @param maxFileSize	: 최대 파일 사이즈
 * @param inputFileSizeName	:  fileSize 를 담는 input name
 * @param callbackFn	: callback function
 * @param isAsync		: true(async) or false(sync)
 * @param param			: parameter
 * @param fileType		: img, 등.
 */
function commonAjaxForFileCreateForm(url,maxFileCount,inputFileName,maxFileSize,inputFileSizeName, callbackFn, isAsync,param,fileType){


	if($('#fileCommonForm')!=undefined) $('#fileCommonForm').remove();


	//-- 파일 타입 판별 (확장자 체크) 일단 multiple 은 안됨.
	if(fileType!= '' && fileType != null){
		var chk = getFileExtCheck(inputFileName,fileType);

		if(chk == 'false'){
			alert("형식에 맞지 않는 파일입니다.");
			return false;
		}

	}

	//---- 파일 사이즈 체크
	if((inputFileSizeName != '' && inputFileSizeName != null) && (maxFileSize != '' && maxFileSize != null)){

		var fileSize = getFileSize(inputFileSizeName,inputFileName);

		if (fileSize > 1024 * 1024 * maxFileSize) {
			alert("첨부파일은 "+maxFileSize+"mb를 넘을수 없습니다.");
			return false;
		}
	}

	//---- 파일 갯수 체크
	if(maxFileCount != '' && maxFileCount != null){

		if (getFileCount(inputFileName) > maxFileCount) {
			alert("첨부파일 수는 "+maxFileCount+"개를 넘을수 없습니다.");
			return;
		}

	}

	// async or sync
	var async = true; // default : async(비동기)
	if (isAsync != null) {
		async = isAsync;
	}

	$file = $("input[name="+inputFileName+"]");

	$file.attr("name", "shadowFile");
	$file.css("display", "none");

	var str ='<form method="POST" name="fileCommonForm" id="fileCommonForm" ></form>';

	$(document.body).append(str);


	$file.appendTo("#fileCommonForm");


	$("#fileCommonForm").attr("enctype", "multipart/form-data");
	var option = {
		url : url,
		type : 'POST',
		data	: param,
		dataType : "json",
		beforeSubmit: function (data,form,option) {
             //validation체크
             //막기위해서는 return false를 잡아주면됨
             return true;
        },
        success : function(result) {		  // SUCCESS FUNCTION

			$('#fileCommonForm').remove();
			callbackFn(result);


		},
		error : function(req, status, error) { // ERROR FUNCTION
			alert("파일첨부에 실패하였습니다.");
			return;
		}
	};

	$("#fileCommonForm").ajaxForm(option).submit();


}//commonAjaxForFile


