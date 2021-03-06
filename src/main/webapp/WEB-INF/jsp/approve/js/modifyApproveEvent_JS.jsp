<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>
<script type="text/javascript" defer="defer">
	var now = new Date();
	var year = now.getFullYear();
	var month = now.getMonth();
	var day = now.getDate();

	var period = 0;
	var holidayYn = "N";

	var g_idx =0;						//파일 idx

	var delArray = new Array();
	var saveFileList ;
	var colorObj = {};
	var amountModifyYn = "N";

	var myModal = new AXModal();	// instance
	$(document).ready(function(){
		Editor.modify({						 // 내용
			"content": $("#memo").val()		 /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
		});
		///////////////////////////////날짜 DATEPICKER : S///////////////////////////////


		$('#dateFrom').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
		$('#dateFrom').attr("readonly","readonly");
		$('#eventDate').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'}).prop("readonly",true);
		$('#eventDate').attr("readonly","readonly");

		var nowMonth = (month+1)>=10?(month+1):"0"+(month+1);
		//날짜에 초기값 셋팅
		//$('#eventDate').datepicker("option", "minDate", year+"-"+nowMonth+"-"+(day));
		//$('#dateFrom').datepicker("option", "minDate", year+"-"+nowMonth+"-"+(day));

		$('#dateFrom').datepicker("option", "onClose", function ( selectedDate ) {
			if($("#eventDate").val()==""){
            	alert("경조일자를 먼저 입력해 주세요");
            	$('#dateFrom').val("");
            	return;
            }
			getLastDate();
	      });
		$("#familyEventsIdSelect").change(function(){
			familyEventsIdChnage();
		});

		///////////////////////////////날짜 DATEPICKER : E///////////////////////////////

		getFileList();
		familyEventsIdChnage();

		//문서종류 검색 선택박스
	    var appvDocClass = $("#appvDocClass").val();

  		var comCodeAppvDocType = getBaseCommonCode('APPV_DOC_TYPE_'+appvDocClass, null, 'CD', 'NM', null, null, null, { orgId : "${baseUserLoginInfo.orgId}" });
        var searchAppvDocType = createSelectTag('appvDocTypeSelect', comCodeAppvDocType, 'CD', 'NM', null, 'appvDocTypeChg()', colorObj, '', 'select_b');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        $("#appvDocTypeTag").html(searchAppvDocType);

        $("#appvDocTypeSelect").val($("#appvDocType").val());
        $("#appvDocTypeSelect").prop("disabled",true);

        appvDocTypeChg();

        appvHeaderIdChg();

      //-------------------------- 모달창 :S -------------------------
    	myModal.setConfig({
    		windowID:"myModalCT",

    		width:740,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		displayLoading:true,
            scrollLock: false,
    		onclose: function(){

    		}
            ,contentDivClass: "popup_outline"

    	});
	});
	//문서타입 선택시 결재라인명 리스트를 조회
	function appvDocTypeChg(){
		if($("#appvDocTypeSelect").val() == ""){
			alert("문서타입을 선택해 주세요.");
			return;
		}
		$("#appvDocType").val($("#appvDocTypeSelect").val());
		$("#frm").attr("action",contextRoot+"/approve/getAppvHeaderListAjax.do");
		commonAjaxSubmit("POST",$("#frm"),appvDocTypeChgCallback,false);
	}
	//문서타입 선택시 결재라인명 리스트를 조회 콜백
	function appvDocTypeChgCallback(data){
		if(data.result =="SUCCESS"){

			var appvHeaderId = "${detailMap.appvHeaderId}";

			var stStr = "<select name='appvHeaderId' id='appvHeaderId' class='select_b' onchange='appvHeaderIdChg()' style='background-color:white;width:px;'>";
			stStr += "<option value = ''>결재라인선택</option>";

			var headerList = data.resultObject;
			for(var i = 0 ; i < headerList.length;i++){
				stStr += "<option value = '"+headerList[i].appvHeaderId+"'";
				if(parseInt(headerList[i].appvHeaderId) == parseInt(appvHeaderId)){
					stStr += " selected='selected'";
				}
				stStr += ">"+headerList[i].appvHeaderName+"</option>";
			}
			stStr += "</select>";

			$("#appvHeaderNameArea").html(stStr);
		}else{
			alert("결재라인 조회에 실패했습니다. 담당자에게 문의해주세요.");
			return;
		}
	}
	//문서 헤더 선택시 결재라인 조회
	function appvHeaderIdChg(){
		if($("#appvHeaderId").val() == ""){
			$("#approveLineTr").hide();
			$("#approveLineTh").attr("rowspan","1");
			return;
		}

		$("#frm").attr("action",contextRoot+"/approve/getApproveLineAjax.do");
		commonAjaxSubmit("POST",$("#frm"),appvHeaderIdChgCallback);

	}
	//문서 헤더 선택시 결재라인 조회 콜백
	function appvHeaderIdChgCallback(data){

		$("#approveLineTr").show();
		$("#approveLineTh").attr("rowspan","2");
		$("#approveLineArea").html(data);

		initUserProfileEvent();
	}

	//신규 파일 등록시
	function newFileUpload(){

		var url = contextRoot+"/file/uploadFiles.do"


   		var callback = function(result){


   			var list = result.resultList;
   			var str='';
   			for(var i=0;i<list.length;i++){
   				var fileObj = list[i];
   				str +='<li id="li_'+g_idx+'">' + fileObj.orgFileNm ;
   				str +='<input type="hidden" name="fileSeq" value="0">' ;
   				str +='<input type="hidden" name="orgFileNm" value="'+fileObj.orgFileNm+'">' ;
   				str +='<input type="hidden" name="newFileNm" value="'+fileObj.newFileNm+'">' ;
   				str +='<input type="hidden" name="filePath" value="'+fileObj.filePath+'">' ;
   				str +='<input type="hidden" name="fileSize" value="'+fileObj.fileSize+'">' ;
   				str +='<span>' + parseInt(fileObj.fileSize/1024) + 'KB</span><a href="javascript:newFileDelete(\''+fileObj.newFileNm+'\',\''+fileObj.filePath+'\','+g_idx+');" class="fileDelete"><em>삭제</em></a></li>';
   				g_idx++;


   			}

   			//파일 태그 재 생성.
   			$('#fileInputArea').append('<input name="upFile" type="file" multiple class="file_btn_cover"  onchange="newFileUpload();">');


   			$('#uploadFileList').append(str);
   			$('#uploadFileList').show();

   		}

   		commonAjaxForFileCreateForm(url,"","upFile","100","fileSize", callback , "");

	}


	//첨부파일이 있다면 셋팅한다.
    function getFileList(){
    	var url = contextRoot + "/file/getFileList.do";
    	var param = {
    					uploadId 	: "${detailMap.appvDocId}",
    					uploadType  : 'EVENT'
    				}

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var list = obj.resultList;
    		var str = '';
    		saveFileList = list;
    		if(list.length>0){
	    		for(var i=0;i<list.length;i++){

	    			var fileObj = list[i];
	    			str +='<li id="li_'+g_idx+'">' + fileObj.orgFileNm ;
	    			str +='<input type="hidden" name="fileSeq" value="'+fileObj.fileSeq+'">' ;
	    			str +='<input type="hidden" name="orgFileNm" value="'+fileObj.orgFileNm+'">' ;
	    			str +='<input type="hidden" name="newFileNm" value="'+fileObj.newFileNm+'">' ;
	    			str +='<input type="hidden" name="filePath" value="'+fileObj.filePath+'">' ;
	    			str +='<input type="hidden" name="fileSize" value="'+fileObj.fileSize+'">' ;
	    			str +='<span>' + parseInt(fileObj.fileSize/1024) + 'KB</span><a href="javascript:setDelFile('+fileObj.fileSeq+','+g_idx+');" class="fileDelete"><em>삭제</em></a></li>';
	    			g_idx++;
				}
	    		$('#uploadFileList').html(str);
	    		$('#uploadFileList').show();
    		}

    	}
    	commonAjax("POST", url, param, callback, false);
    }
  	//파일 바로 삭제
     function newFileDelete(newFileNm,filePath,idx){
    	var url = contextRoot + "/file/deleteFile.do";
    	var param = { newFileNm : newFileNm , filePath : filePath};
    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var cnt = obj.resultVal;
    		if(cnt>0){
    			$("#li_"+idx).remove();
    		}
    		if($("#uploadFileList li").length==0) $("#uploadFileList").hide();
    	};
    	commonAjax("POST", url, param, callback, false);
    }
     //수정시 db 에 이미 저장된 파일삭제 할땐. 바로삭제하지않고 리스트를 만든다.
     function setDelFile(fileSeq,idx){

     	delArray.push(fileSeq);
     	$("#li_"+idx).remove();
     	if($("#uploadFileList li").length==0) $("#uploadFileList").hide();
     }

	//마지막 날짜를 조회한다
	function getLastDate(){
		if($('#dateFrom').val()==""){
			return;
		}
		var url = contextRoot + "/approve/getEventLastDay.do";
		var param = {
				period 	: period,
				holidayYn  :holidayYn,
				selectedDate:$("#dateFrom").val()
			}

		var callback = function(result){
			var resultJSON = JSON.parse(result);
			var lastDtStr = resultJSON.resultObject.eventLastMap.sysDate;

			var lastDtBuf = lastDtStr.split("-").join("");
			var dateFromBuf = $("#dateFrom").val().split("-").join("");

			var eventDtBuf = $("#eventDate").val().split("-").join("");
			/* if(parseInt(eventDtBuf)<parseInt(dateFromBuf)){
				$("#dateFrom").val("");
				$("#dateTo").val("");
				alert("경조일자가 휴가기간에 없습니다.");
				return;
			} */
			/* if(parseInt(eventDtBuf)>parseInt(lastDtBuf)){
				$("#dateFrom").val("");
				$("#dateTo").val("");
				alert("경조일자가 휴가기간에 없습니다.");
				return;
			} */
			$("#dateTo").val(lastDtStr);

    	}
    	commonAjax("POST", url, param, callback, true);
	}
	//사람찾기팝업
	var popType = "";
	function openSelectUserPop(type){
		popType = type;
		var paramList = [];
		var param = "";
		switch(popType){
		//업무인수자
		case 'workAssign':
			var paramObj ={ name : 'isOneOrg' ,value : 'Y'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'userList'   ,value : $("#workAgencyId").val()};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isAllOrg' ,value : 'N'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'oneOrg' ,value : '${baseUserLoginInfo.orgId}'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isCheckDisable' ,value : 'N'};
	        paramList.push(paramObj);

	        paramObj ={ name : 'isOneUser' ,value : 'Y'};
	        paramList.push(paramObj);
			break;
		//대결자
		case 'appvAssign':
			var paramObj ={ name : 'isOneOrg' ,value : 'Y'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'userList'   ,value : $("#appvAgencyId").val()};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isAllOrg' ,value : 'N'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'oneOrg' ,value : '${baseUserLoginInfo.orgId}'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isCheckDisable' ,value : 'N'};
	        paramList.push(paramObj);

	        paramObj ={ name : 'isOneUser' ,value : 'Y'};
	        paramList.push(paramObj);
			break;
		//참조인
		case 'approveCc':
			var userStr ='';
	    	var arr =[];
	    	var selectUserList =$("input[name=approveCcId]");

	    	for(var i=0;i<selectUserList.length;i++){
	    		arr.push(selectUserList[i].value);
	  		}
	    	userStr = arr.join(',');
	    	var paramObj ={ name : 'userList'   ,value : userStr};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isOneOrg' ,value : 'Y'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'hasDeptTopLevel' ,value : 'Y'};
	        paramList.push(paramObj);  //부서의 회장 부서 표시여부
	        paramObj ={ name : 'isAppoveLineAdd' ,value : 'Y'};
	        paramList.push(paramObj);  //결재 라인 결재자 공개여부

			break;
			//수신인
		case 'approveRc':
			var userStr ='';
	    	var arr =[];
	    	var selectUserList =$("input[name=approveRcId]");

	    	for(var i=0;i<selectUserList.length;i++){
	    		arr.push(selectUserList[i].value);
	  		}
	    	userStr = arr.join(',');
	    	var paramObj ={ name : 'userList'   ,value : userStr};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isOneOrg' ,value : 'Y'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'hasDeptTopLevel' ,value : 'Y'};
	        paramList.push(paramObj);  //부서의 회장 부서 표시여부
	        paramObj ={ name : 'isAppoveLineAdd' ,value : 'Y'};
	        paramList.push(paramObj);  //결재 라인 결재자 공개여부

			break;
			//직원선택
		case 'userType':
			var paramObj ={ name : 'isOneOrg' ,value : 'Y'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'userList'   ,value : $("#selectStaffId").val()};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isAllOrg' ,value : 'N'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'oneOrg' ,value : '${baseUserLoginInfo.orgId}'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isCheckDisable' ,value : 'N'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isOneUser' ,value : 'Y'};
	        paramList.push(paramObj);
	        break;

		}
		 userSelectPopCall(paramList);		//공통 선택 팝업 호출
		/* var url = contextRoot + "/approve/searchUserPop.do?type="+param;
		var option = "width=968px,height=720px,resizable=yes,scrollbars = yes";

		fnObj.openUserPopup();

		commonPopupOpen("searchUser",url,option); */

	}

	//경조사 분류 change
	function familyEventsIdChnage(){
		var familyEventsIdBuf = $("#familyEventsIdSelect").val().split("|");
		var familyEventsId = familyEventsIdBuf[0];
		var amount = familyEventsIdBuf[1];
		period = familyEventsIdBuf[2];
		holidayYn = familyEventsIdBuf[3];

		//경조휴가 0일인경우 (17.06.30):S
		if(parseInt(period)>0){
			var holiday  = holidayYn == "Y"?"(휴일포함)":"(휴일미포함)";
			$("#eventPeriodArea").show();
		}else{
			$("#eventPeriodArea").hide();
		}
		//경조휴가 0일인경우 (17.06.30):E

		var amountText = parseInt(amount).toLocaleString('en').split(".")[0];

		/* 경조금액 */
		$("#amount").val(amount);


		$("#familyEventsId").val(familyEventsId);
		$("#event_amount").text("\\"+amountText);
		$("#event_period").text(period+"일");
		$("#event_holiday").text(holiday);

		getLastDate();
	}

	function deleteStaff(type,userId){
		switch(type){
		case 'workAssign':
			$("#workAssignName").text("");
			$("#workAssignRankNm").text("");
			$("#workAgencyId").val("");
			$("#workAssignDelete").remove();
			break;
		case 'appvAssign':
			$("#appvAssignName").text("");
			$("#appvAssignRankNm").text("");
			$("#appvAgencyId").val("");
			$("#appvAssignDelete").remove();
			break;
		case 'approveCc':
			$("#approveCcList_"+userId).remove();

			$("span[id*='approveCcList_']").eq(0).find("#approveCcList_comma").remove();
			if($("span[id*='approveCcList_']").length==0){
				$("#approveCcTh").attr("rowspan","1");
				$("#approveCcTr").hide();
			}

			break;
		case 'approveRc':
			$("#approveRcList_"+userId).remove();

			$("span[id*='approveRcList_']").eq(0).find("#approveRcList_comma").remove();
			if($("span[id*='approveRcList_']").length==0){
				$("#approveRcTh").attr("rowspan","1");
				$("#approveRcTr").hide();
			}
			break;
		}
	}
	//참조인 직원선택 버튼 토글 / 컨트롤
	function approveCcBtnToggle(){
		$("#approveCcArea").empty();
		$("#approveCcTh").attr("rowspan","1");
		$("#approveCcTr").hide();
		if($("input[name='approveCcType']:checked").val()=='SELECT'){
			$("#approveCcBtn").show();
		}else{
			$("#approveCcBtn").hide();
			$("#approveCcArea").empty();
		}
	}
	//수신인 직원선택 버튼 토글 / 컨트롤
	function approveRcBtnToggle(){
		$("#approveRcArea").empty();
		$("#approveRcTh").attr("rowspan","1");
		$("#approveRcTr").hide();

		if($("input[name='approveRcType']:checked").val()=='SELECT'){

			$("#approveRcBtn").show();
		}else{
			$("#approveRcBtn").hide();
			$("#approveRcArea").empty();
		}
	}
	//도움말팝업토글
	function showlayer(id)
	{
		$("#"+id).toggle();
	}

	//저장
	function doSave(){

		if($("#familyEventsIdSelect").val() == null || $("#familyEventsIdSelect").val() == "" ){
			alert("경조사 분류를 선택해 주세요.");
			$("#familyEventsIdSelect").focus();
			return;
		}
		if($("#amount").val() == ""){
			alert("금액을 입력해 주세요.");
			$("#amount").focus();
			return;
		}
		if(amountModifyYn == "Y"){
			alert("금액 적용 버튼을 눌러주세요.");
			$("#amount").focus();
			return;
		}
		if($("#eventDate").val()==""){
			alert("경조일자를 입력해 주세요.");
			$("#eventDate").focus();
			return;
		}

		if(period>0){
			if($("#dateFrom").val()==""){
				alert("경조시작일을 입력해 주세요.");
				$("#dateFrom").focus();
				return;
			}
		}
		if(Editor.getContent() == '<p><br></p>'){
			alert("내용을 입력해 주세요.");
			return;
		}
		/* 파일 수정시 delete List 처리 */
		if(delArray.length !=0){										//수정시 삭제한 파일들의 리스트
			for(var i = 0 ; i < delArray.length; i++){
				$input = $("<input></input>").attr("type","hidden").attr("name","delFileList").val(delArray[i]);
				$("#frm").append($input);
			}
		}
		if($("#appvHeaderId").val() == ""){
			alert("결재 라인을 선택해 주세요.");
			$("#appvHeaderId").focus();
			return;
		}

		if("${lineSize}" == "0"){
			alert("결재선이 없으므로 품의서를 저장할수 없습니다. 담당자에게 문의해주세요.");
			return;
		}
		if(confirm("저장하시겠습니까?")){
			$("#memo").val(Editor.getContent());
			$("#frm").attr("action",contextRoot+"/approve/getChkAppointedPerson.do");
			commonAjaxSubmit("POST",$("#frm"),chkAppointedPersonCallback);

		}

	}
	//대결자 / 동행자 체크 콜백
	function chkAppointedPersonCallback(data){
		if(data.resultObject.result =="SUCCESS"){
			<c:choose>
				<c:when test ="${searchMap.listType ne 'bookMarkList'}">
				$("#frm").attr("action",contextRoot+"/approve/modifyEventApprove.do");
				</c:when>
				<c:otherwise>
				$("#frm").attr("action",contextRoot+"/approve/insertEventApprove.do");
				</c:otherwise>
			</c:choose>

			commonAjaxSubmit("POST",$("#frm"),doSaveCallback);
		}else{
			if(data.resultObject.msg!=null){
				alert(data.resultObject.msg);
				return;
			}
		}
	}
	//저장 콜백
	function doSaveCallback(data){
		if(data.resultObject.result =="SUCCESS"){
			$("#appvDocId").val(data.resultObject.appvDocId);
			alert("저장되었습니다.");
			$("#frm").attr("action",contextRoot+"/approve/getApproveTempDetail.do").submit();
		}else{
			if(data.resultObject.msg!=null){
				alert(data.resultObject.msg);
				return;
			}
			alert("저장에 실패했습니다. 담당자에게 문의해 주세요.");
		}
	}

	//취소버튼 : 결제품의화면으로 이동
	function goDraftListPage(){
		$("#frm").attr("action",contextRoot+"/approve/draftDocList.do").submit();
	}

	var myModal = new AXModal();	// instance
	var fnObj = {
			//사원선택 팝업	(idx : activity index, knd : 'project' 프로젝트전체에 배정하는 케이스)
		    openUserPopup: function(params,title){

		    	var url = "<c:url value='/user/selectUserOrDeptPopup.do'/>";
		    	var params = params;
		    	myModal.open({
		    		url: url,
		    		pars: params,
		    		titleBarText: title,		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
		    		method:"POST",
		    		top: 250,
		    		width: 750,
		    		closeByEscKey: true				//esc 키로 닫기
		    	});

		    	$('#myModalCT').draggable();

		    },
			//사원 및 부서 선택 팝업에서 선택한 데이터를 처리
		    getResult: function(list){
		    	fnObj.actionBySelData(list);
		    },
			 //사원 및 부서 선택 팝업에서 선택한 데이터를 처리
		    actionBySelData: function(listObj, pKey){

		    	switch(popType){
		    	case 'workAssign':
					if(listObj[0].userId == "${baseUserLoginInfo.userId}"){
						alert("업무인수자는 본인을 선택할 수 없습니다.");
						return;
					}
					$("#workAssignDelete").remove();
					$("#workAssignName").text(listObj[0].userName);
					$("#workAssignRankNm").text("("+listObj[0].rankNm+")");
					$("#workAgencyId").val(listObj[0].userId);
					$("#workAssignArea").append("<a id = 'workAssignDelete' href=\"javascript:deleteStaff('"+popType+"')\" class=\"btn_delete_employee\"><em>삭제</em></a>");
					break;
				//대결자
				case 'appvAssign':
					if(listObj[0].userId == $("#selectStaffId").val()){
						alert("대결자는 대상자를 선택할 수 없습니다.");
						return;
					}
					$("#appvAssignDelete").remove();
					$("#appvAssignName").text(listObj[0].userName);
					$("#appvAssignRankNm").text("("+listObj[0].rankNm+")");
					$("#appvAgencyId").val(listObj[0].userId);
					$("#appvAssignArea").append("<a id = 'appvAssignDelete' href=\"javascript:deleteStaff('"+popType+"')\" class=\"btn_delete_employee\"><em>삭제</em></a>");
					break;
				case 'approveCc':
					$("#approveCcArea").empty();
					for(var i = 0 ; i <listObj.length; i++){
						$("#approveCcTh").attr("rowspan","2");
						$("#approveCcTr").show();
						var addchk=true;
						if(listObj[i].userId == "${baseUserLoginInfo.userId}"){
							alert("참조인은 본인을 선택할 수 없습니다.");
							continue;
						}
						/* $("input[name='approveCcId']").each(function(){
							if($(this).val()==listObj[i].userId){
								//alert(listObj[i].userName+"("+listObj[i].rankNm+") 님은 이미 참조인으로 선택하셨습니다.");
								addchk = false;
								return false;
							}
						}); */

						/* if(addchk){ */
							var stStr = "";
							stStr += "<span class=\"employee_list approveCcList\" id = 'approveCcList_"+listObj[i].userId+"'>";
							if($("#approveCcArea .approveCcList").length>0) stStr+="<span><div id = 'approveCcList_comma' style='display:inline'>,</div>";
							else  stStr+="<span>";
							stStr += listObj[i].userName+"</span><em>("+listObj[i].rankNm+")</em>";
							stStr += "<input type=\"hidden\" id = \"approveCcId\" name = \"approveCcId\" value=\""+listObj[i].userId+"\">";
							stStr += "<a href=\"javascript:deleteStaff('"+popType+"','"+listObj[i].userId+"')\" class=\"btn_delete_employee\"><em>삭제</em></a></span>";
							$("#approveCcArea").append(stStr);
						//}
					}
					break;
				case 'approveRc':
					$("#approveRcArea").empty();

					for(var i = 0 ; i <listObj.length; i++){

						$("#approveRcTh").attr("rowspan","2");
						$("#approveRcTr").show();
						var addchk=true;
						if(listObj[i].userId == "${baseUserLoginInfo.userId}"){
							alert("수신인은 본인을 선택할 수 없습니다.");
							continue;
						}
						/* $("input[name='approveCcId']").each(function(){
							if($(this).val()==listObj[i].userId){
								//alert(listObj[i].userName+"("+listObj[i].rankNm+") 님은 이미 참조인으로 선택하셨습니다.");
								addchk = false;
								return false;
							}
						}); */

						/* if(addchk){ */
							var stStr = "";
							stStr += "<span class=\"employee_list approveRcList\" id = 'approveRcList_"+listObj[i].userId+"'>";
							if($("#approveRcArea .approveRcList").length>0) stStr+="<span><div id = 'approveRcList_comma' style='display:inline'>,</div>";
							else  stStr+="<span>";
							stStr += listObj[i].userName+"</span><em>("+listObj[i].rankNm+")</em>";
							stStr += "<input type=\"hidden\" id = \"approveRcId\" name = \"approveRcId\" value=\""+listObj[i].userId+"\">";
							stStr += "<a href=\"javascript:deleteStaff('"+popType+"','"+listObj[i].userId+"')\" class=\"btn_delete_employee\"><em>삭제</em></a></span>";
							$("#approveRcArea").append(stStr);
						//}
					}
					break;
				case 'userType':
					$("#selectStaffId").val(listObj[0].userId);
					$("#staffNameArea").text(listObj[0].userName)

					var stStr = listObj[0].deptNm + '<span class="dashLine"> / </span>';
						stStr+= listObj[0].rankNm;

					$("#selectStaffInfoArea").html(stStr);

					$("#selectStaffMobileArea").text(listObj[0].phone);
					$("#linkDocTh").attr("rowspan","1");
					$("#linkDocArea").empty();
					$("#linkDocTr").hide();
					break;
				}

		    	var chk = true;
		    	$("input[name='addDept'],input[name='deptId']").each(function(){
		    		if($(this).val() == listObj[0].deptId){
		    			alert("이미 선택된 부서입니다.");
		    			chk = false;
		    			return false;
		    		}
		    	});
		    }
	}
	//금액변경
	function amountModify(){
		numberFormatForNumberClass();
		amountModifyYn= "Y";
		$("#amountModifyArea").show();
		$("#amountArea").hide();
	}
	//금액 적용
	function amountConfirm(){

		var amount = $("#amount").val();


		$("#event_amount").text("\\"+amount);

		amount = amount.split(",").join("");
		$("#amount").val(amount);

		amountModifyYn= "N";
		$("#amountModifyArea").hide();
		$("#amountArea").show();
	}
//////////////////////연결문서 :S
	//연결결재문서 선택 팝업
	function openApproveRefDocPop(){
		var url = "<c:url value='/approve/getApproveRefDocPop.do'/>";
		var params = {};
		myModal.open({
			windowID:"myModalCT",
			url: url,
			pars: params,
			titleBarText: '연결결재문서선택',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
			method:"POST",
			top: $(window).scrollTop() + 150,
			width: 900,
			closeByEscKey: true			//esc 키로 닫기
		});

		$('#myModalCT').draggable();
	}
	//연결문서 팝업 콜백
	function openApproveRefDocPopCallback(data){

		var refDocBuf = data.split("|");
		var refDocId = refDocBuf[0];
		var refDocTitle = refDocBuf[1];

		var stStr = "";
		stStr += "<span class=\"linkDoc_list linkDocList\" id = 'linkDocList_"+refDocId+"'>";
		if($("#linkDocArea .linkDocList").length>0) stStr+="<span><div id = 'linkDocList_comma' style='display:inline'><br></div>";
		else  stStr+="<span>";
		stStr += refDocTitle+"</span>";
		stStr += "<input type=\"hidden\" id = \"refDocIdStr\" name = \"refDocIdStr\" value=\""+data+"\">";
		stStr += "<a href=\"javascript:deleteLinkDoc('"+refDocId+"')\" class=\"btn_delete_employee\"><em>삭제</em></a></span>";
		$("#linkDocArea").append(stStr);

	}

	//연결문서 팝업 종료
	function openApproveRefDocPopFinish(){
		$("#linkDocTh").attr("rowspan","1");
		$("#linkDocTr").hide();
		$("#linkDocArea").empty();
	}
	//연결문서 팝업 종료 2
	function openApproveRefDocPopFinishEnd(){
		if($("input[name='refDocIdStr']").length>0){
			$("#linkDocTh").attr("rowspan","2");
			$("#linkDocTr").show();
		}
	}
	//연결문서 삭제
	function deleteLinkDoc(refDocId){
		$("#linkDocList_"+refDocId).remove();
		$("span[id*='linkDocList_']").eq(0).find("#linkDocList_comma").remove();
		if($("span[id*='linkDocList_']").length==0){
			$("#linkDocTh").attr("rowspan","1");
			$("#linkDocTr").hide();
		}
	}
	//기 입력된 연결문서 리스트를 반환
	function getRefDocIdArr(){
		var refDocIdArr = new Array();
		$("input[name='refDocIdStr']").each(function(){
			refDocIdArr.push($(this).val());
		});
		return refDocIdArr;
	}
	//////////////////////연결문서 :E
</script>
