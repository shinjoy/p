<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>
<script type="text/javascript">
	var now = new Date();
	var year = now.getFullYear();
	var month = now.getMonth();
	var day = now.getDate();
	var nowMonth = (month+1)>=10?(month+1):"0"+(month+1);
	var nowDay = (day)>=10?(day):"0"+(day);
	var nowStr = year+"-"+nowMonth+"-"+(nowDay);
	var g_idx =0;						//파일 idx

	var delArray = new Array();
	var saveFileList ;

	var colorObj = {};
	var orgId = "${baseUserLoginInfo.orgId}";
	var commonPropject = getCommonProject('CD', 'NM', '', '${baseUserLoginInfo.projectTitle } 선택', { orgId : orgId,userId : "${baseUserLoginInfo.userId}",type:"PROJECT",incApproveActivity:"N",incCardActivity:"Y",startDate:nowStr});


	var myModal = new AXModal();	// instance
	var myModal2 = new AXModal();	// instance

	var addHtml = "";
	var expenseTypeSelectStr = "";
	$(document).ready(function(){

		numberFormatForNumberClass();

		//유저프로필 이벤트 셋팅
		initUserProfileEvent();

		$('#expenseDate_1').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
		$('#expenseDate_1').attr("readonly","readonly");

		$('#advanceWishDate').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
		$('#advanceWishDate').attr("readonly","readonly");

		$('#taxBillIssueDate').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
		$('#taxBillIssueDate').attr("readonly","readonly");




		var projectTag = createSelectTagForProject('projectId', commonPropject, 'CD', 'NM', '', null, {}, null, 'select_b','PROJECT');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        $("#projectArea").html(projectTag);

        $("#projectId").change(function(){
        	chgProjectId();
        });
        if($("#projectId").val()!="") $("#projectId").change();

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
    	myModal2.setConfig({
    		windowID:"myModalCT",

    		width:740,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		displayLoading:true,
            scrollLock: false,
    		onclose: function(){
    			/* if(lineYn != "Y"){
					$("#individualYn").prop("checked",false);
    			} */
    		}
            ,contentDivClass: "popup_outline"

    	});
    	//-------------------------- 모달창 :E -------------------------

    	//계정과목 select Str
    	expenseTypeSelectStr = setExpenseTypeSelect();

		$("#expenseTd").html(expenseTypeSelectStr);


		Editor.modify({						 // 내용
			"content": "<p>"+$("#memo").val()+"</p>"
		});
		 //문서종류 검색 선택박스
	    var appvDocClass = $("#appvDocClass").val();

		var comCodeAppvDocType = getBaseCommonCode('APPV_DOC_TYPE_'+appvDocClass, null, 'CD', 'NM', null, null, null, { orgId : "${baseUserLoginInfo.orgId}" });
	    var searchAppvDocType = createSelectTag('appvDocTypeSelect', comCodeAppvDocType, 'CD', 'NM', null, 'appvDocTypeChg()', colorObj, '', 'select_b');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	    $("#appvDocTypeTag").html(searchAppvDocType);

	    $("#appvDocTypeSelect").val($("#appvDocType").val());
	    $("#appvDocTypeSelect").prop("disabled",true);

	   appvDocTypeChg();

	   accountSubjectSet();


	   addHtml = $("#itemListTable tbody").html();

	 	//My업무구분에서 넘어온경우
  	   var myProjectName = "${projectName}";

  	   if(myProjectName!=""){
  		   $("#projectId").val("${projectId}").change();

  		   $("#activityId").val("${activityId}").change();
  	   }

  	   //My단위업무에서 팝업띄운경우
  	   if($("#popYn").val() =="M"){
  		   $("#expenseDate_1").val($("#selDate").val());
  	   }

	});
	//계정과목 selectBox set
	function setExpenseTypeSelect(){
		var comCodeType = getBaseCommonCode('ACCOUNT_SUBJECT', null, 'CD', 'NM', '', '선택','ALL', { orgId : "${baseUserLoginInfo.orgId}" });

		var returnStr = '<select id="expenseTypeStr" name = "expenseTypeStr" class="select_b"><option value = "">선택</option>';
		for(var i = 1 ; i < comCodeType.length; i ++){
			returnStr += '<optgroup label = "'+comCodeType[i].NM+'">';

			var code = comCodeType[i].CD;

			var comType = getBaseCommonCode(comCodeType[i].sonCodeName, null, 'CD', 'NM', '', '선택','ALL', { orgId : "${baseUserLoginInfo.orgId}" });

			for(var j = 1 ;j<comType.length;j++){
				returnStr += '<option value = "'+code+"|"+comType[j].CD+'">'+comType[j].NM+"</option>";
			}

			returnStr += "</optgroup>";
		}

		returnStr+="</select>";

		return returnStr;
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


	//프로젝트 셀렉트박스 체인지
	function chgProjectId(){
		var projectId = $("#projectId").val();
		$("#activityDescArea").text("");
		if(projectId == ""){
			$("#activityId").html("<option value = ''>선택</option>");
			return;
		}
		var commonActivity = getCommonProject('CD', 'NM', '', '${baseUserLoginInfo.activityTitle } 선택', { orgId : orgId,projectId : projectId, userId : "${baseUserLoginInfo.userId}" ,type:"ACTIVITY",incApproveActivity:"N",incCardActivity:"Y",startDate:nowStr});
		var activityTag = createSelectTagForProject('activityId', commonActivity, 'CD', 'NM', '', null, colorObj, null, 'select_b mgl6','ACTIVITY');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
		$("#activityArea").html(activityTag);

		$("#activityId").change(function(){
			$("#activityDescArea").text("");
			if($("#activityId").val()==""){
				$("#activityDescArea").text("");
				return;
			}
			var startDateStr = $("#activityId option:selected").attr("startdate");
			var endDateStr = $("#activityId option:selected").attr("enddate");

			$("#activityDescArea").text("기간 : "+startDateStr + " ~ " + endDateStr);
		});
		if($("#activityId").val()!="") $("#activityId").change();
	}

	var index =2;
	//구매내역을 추가한다
	function addItemList(){


		var stStr = $("#itemListBuf").text();
		stStr = stStr.split("##index##").join(index);
		$("#itemListTableTbody").append(stStr);
		numberFormatForNumberClass();

		$("#expenseSelect"+index).html(expenseTypeSelectStr);


		$('#expenseDate_'+index).datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
		$('#expenseDate_'+index).attr("readonly","readonly");

		//My단위업무에서 팝업띄운경우
		if($("#popYn").val() =="M"){
			$('#expenseDate_'+index).val($("#selDate").val());
		}

		index++;
	}
	//구매내역을 제거한다
	function deleteItemList($this){

		if($("input[name='expenseDate']").length==1){
			alert("지출내역은 반드시 한 건이상 입력하셔야 합니다.");
			$("input[name='expenseDate']").focus();
			return;
		}

		$this.parent().parent().remove();


		processItemPrice();
	}
	//구매내역 금액을 계산한다
	function processItemPrice(){
		var cashPrice = 0;
		var cardPrice = 0;

		$("select[name='paymentType']").each(function(){
			var expenseAmount = $(this).parent().next().next().find("#expenseAmount").val();

			if(expenseAmount != ""){
				expenseAmount = expenseAmount.split(",").join("");
				var amount = parseInt(expenseAmount);
				if($(this).val() == "CASH") cashPrice +=amount;
				else if($(this).val() == "CARD") cardPrice +=amount;
			}

			$("#cash_sum").text(cashPrice.toLocaleString('en').split(".")[0]+"원");
			$("#card_sum").text(cardPrice.toLocaleString('en').split(".")[0]+"원");
			var sum = cashPrice+cardPrice;
			$("#sum").text(sum.toLocaleString('en').split(".")[0]);

			$("#amount").val(sum);

		});
		/* var paymentType = $this.parent().parent().find("#paymentType").val();
		var priceVal = $this.parent().parent().find("#expenseAmount").val();

		var price = 0;
		if(priceVal!=""){
			var priceStr = priceVal.split(",").join("");
			price = parseInt(priceStr);
		}

		var cashPrice = 0;

		var cartPrice = 0;

		if(paymentType == "CASH") cashPrice


		//금액과 총계를 계산한다.
		if(price!=0 || qty!=0){
			var money = price*qty;
			$this.parent().parent().find("#money").val(money.toLocaleString('en').split(".")[0]);
		}
		var sum = 0;
		$("input[name='expenseAmount']").each(function(){
			if($(this).val()!=""){
				sum += parseInt($(this).val().split(",").join(""));
			}
		});
		$("#sum").text(sum.toLocaleString('en').split(".")[0]);
		$("#amount").val(sum); */
	}

	//취소버튼 : 결제품의화면으로 이동
	function goBasicFormPage(){
		$("#frm").attr("action",contextRoot+"/approve/approveProduct.do").submit();
	}


	//저장
	function doSave(){

		if($("#projectId").val() == ""){
			alert("${baseUserLoginInfo.projectTitle }을/를 선택해 주세요.");
			$("#projectId").focus();
			return;
		}

		if($("#activityId").val() == ""){
			alert("${baseUserLoginInfo.activityTitle }을/를 선택해 주세요.");
			$("#activityId").focus();
			return;
		}


		if($("#why").val().trim() == ""){
			alert("제목을 입력해 주세요.");
			$("#why").focus();
			return;
		}
		var chk = true;
		$("#itemListTable").find("input,select").each(function(){
			if($(this).val()=="" && $(this).attr("type")!='button'){
				alert("지출내역을 입력해 주세요.");
				$(this).focus();
				chk = false;
				return false;
			}
		});

		if(!chk) return;

		if(Editor.getContent() == '<p><br></p>'){
			alert("내용을 입력해 주세요.");
			return;
		}

		if(!$("#individualYn").prop("checked")){
			if($("#appvHeaderId").val() == ""){
				alert("결재 라인을 지정해 주세요.");
				$("#appvHeaderId").focus();
				return;
			}

			if($("#lineSize").val() == "0"){
				alert("결재선이 없으므로 품의서를 저장할수 없습니다. 담당자에게 문의해주세요.");
				return;
			}
		}else{
			if($("input[name*='appvSeq']").length == 0){
				alert("결재선이 없으므로 품의서를 저장할수 없습니다. 결재라인을 작성해주세요.");
				return;
			}
		}

		$(".number").each(function(){
			$(this).val($(this).val().split(",").join(""));
		});
		//프로젝트 금액 벨리데이션 체크
		$("#frm").attr("action",contextRoot+"/project/getProjectExpenseValid.do");
		commonAjaxSubmit("POST",$("#frm"),projectExpenseValidCallback);

	}
	//프로젝트 비용관련 유효성관련 데이터 조회
	function projectExpenseValidCallback(data){
		var expenseInfo = data.resultObject;
		var confirmStr = "저장하시겠습니까?";
		if(expenseInfo.activityExpense == "N"){
			confirmStr = "선택한 ${baseUserLoginInfo.projectTitle }는 지출이 불가능합니다.\n${baseUserLoginInfo.projectTitle } 담당자에게 문의 후 다시 등록해주세요.\n확인버튼 클릭 시 [임시저장] 문서로 저장되며, 상신은 불가능합니다.\n\n"+confirmStr;
		}else if(expenseInfo.activityExpense == "Y"){
			var amount = parseInt($("#amount").val());
			if(parseInt(expenseInfo.avalAmt)<amount){
				confirmStr = "입력한 지출금액이 사용 가능한 지출 범위를 초과하였습니다.\n${baseUserLoginInfo.projectTitle } 담당자에게 문의 후 다시 등록해주세요.\n확인버튼 클릭 시 [임시저장] 문서로 저장되며, 상신은 불가능합니다.\n\n"+confirmStr;
			}
		}else{
			alert("선택한 ${baseUserLoginInfo.projectTitle }정보가 조회되지 않습니다. 담당자에게 문의해주세요.");
			return;
		}

		if(confirm(confirmStr)){
			$("#memo").val(Editor.getContent());
			$("select[name*='appvLineType']").prop("disabled",false);

			if($("#individualYn").prop("checked")){
				setIdxApproveLineObjectForSave();
			}
			$("#frm").attr("action",contextRoot+"/approve/insertExpenseApprove.do");
			commonAjaxSubmit("POST",$("#frm"),doSaveCallback);
		}else{
			numberFormatForNumberClass();
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
	//////////////////////결재라인 :S

	//문서 헤더 선택시 결재라인 조회
	function appvHeaderIdChg(){
		if($("#appvHeaderId").val() == ""){
			$("#approveLineTr").hide();
			$("#approveLineTh").attr("rowspan","1");
			return;
		}

		$("#lineIndividualArea").empty();
		$("#individualYn").prop("checked",false);
		lineYn = "N";

		$("#frm").attr("action",contextRoot+"/approve/getApproveLineAjax.do");
		commonAjaxSubmit("POST",$("#frm"),appvHeaderIdChgCallback);

	}
	//문서 헤더 선택시 결재라인 조회 콜백
	function appvHeaderIdChgCallback(data){

		$("#approveLineTr").show();
		$("#approveLineTh").attr("rowspan","2");
		$("#approveLineArea").html(data);

		$("#appvLineBtn").hide();
		//유저프로필 이벤트 셋팅
		initUserProfileEvent();
	}
	//결재라인 직접선택 체크
	function individualChk(){
		if($("#individualYn").prop("checked")){

			//$("#lineIndividualArea").empty();

			$("#approveLineTr").hide();
			$("#approveLineTh").attr("rowspan","1");

			$("#appvHeaderId").val("");

			$("#appvLineBtn").show();
		}else{
			lineYn = "N";
			$("#lineIndividualArea").empty();

			$("#approveLineTr").hide();
			$("#approveLineTh").attr("rowspan","1");

			$("#appvLineBtn").hide();
		}
	}
	//결재라인 직접선택 콜백
	function individualChkCallback(lineHtml){
		$("#appvHeaderId").val("");
		lineYn = "Y";
		$("#lineIndividualArea").html(lineHtml);

		var stStr = '<ul class="app_step_list3">';
		$(".spanAppvLineDisplayNm").each(function(){
			stStr+='<li>'+$(this).text()+'</li>';
		});
		stStr += '</ul>';
		$("#approveLineTr").show();
		$("#approveLineTh").attr("rowspan","2");
		$("#approveLineArea").html(stStr);

	}
	var modifyType ="create";
	//결재라인 직접선택 팝업
	function openAppvLinePop(){
		var url = "<c:url value='/approve/individualChkPop.do'/>";

		modifyType = $("#lineIndividualArea").html().length>10?"modify":"create";

		var params = {};
		myModal2.open({
			windowID:"myModalCT",
			url: url,
			pars: params,
			titleBarText: '결재라인 직접입력',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
			method:"POST",
			top: $(window).scrollTop() + 150,
			width: 900,
			closeByEscKey: true			//esc 키로 닫기
		});

		$('#myModalCT').draggable();
	}
	//결재라인 수정일때 팝업으로 데이터를 보낸다
	function getAppvLineHtml(){
		return $("#lineIndividualArea").html();
	}

	//저장을 위해 결재라인의 Object들의 순번을 부여
	function setIdxApproveLineObjectForSave(){
	    var appvSeqArray      = $("input[name='appVoList.appvSeq']");
	    var appvClassArray    = $("select[name='appVoList.appvClass']");
	    var appvLineTypeArray = $("select[name='appVoList.appvLineType']");
	    var deptIdArray       = $("input[name='appVoList.deptId']");
	    var appvUserIdArray   = $("input[name='appVoList.appvUserId']");
	    for(var i = 0; i < appvSeqArray.length; i++){
	        $(appvSeqArray     [i]).attr("name", "appVoList["+i+"].appvSeq");
	        $(appvClassArray   [i]).attr("name", "appVoList["+i+"].appvClass");
	        $(appvLineTypeArray[i]).attr("name", "appVoList["+i+"].appvLineType");
	        $(deptIdArray      [i]).attr("name", "appVoList["+i+"].deptId");
	        $(appvUserIdArray  [i]).attr("name", "appVoList["+i+"].appvUserId");
	    }
	}
	//문서타입 선택시 결재라인명 리스트를 조회
	function appvDocTypeChg(){
		if($("#appvDocTypeSelect").val() == ""){
			alert("문서타입을 선택해 주세요.");
			return;
		}
		$("#appvDocType").val($("#appvDocTypeSelect").val());
		$("#frm").attr("action",contextRoot+"/approve/getAppvHeaderListAjax.do");
		commonAjaxSubmit("POST",$("#frm"),appvDocTypeChgCallback);
	}
	//문서타입 선택시 결재라인명 리스트를 조회 콜백
	function appvDocTypeChgCallback(data){
		if(data.result =="SUCCESS"){
			var stStr = "<select name='appvHeaderId' id='appvHeaderId' class='select_b' onchange='appvHeaderIdChg()' style='background-color:white;width:px;'>";
			stStr += "<option value = ''>결재라인선택</option>";

			var headerList = data.resultObject;

			for(var i = 0 ; i < headerList.length;i++){
				stStr += "<option value = '"+headerList[i].appvHeaderId+"'>"+headerList[i].appvHeaderName+"</option>";
			}
			stStr += "</select>";

			$("#appvHeaderNameArea").html(stStr);
		}else{
			alert("결재라인 조회에 실패했습니다. 담당자에게 문의해주세요.");
			return;
		}
	}
	//////////////////////결재라인 :E
	//선지급요망 체크
	function chkAdvanceWishYn(){
		if($("#advanceWishYn").prop("checked")){
			$("#advanceWishYArea").show();
		}else{
			$("#advanceWishDate").val("");
			$("#advanceWishReason").val("");
			$("#advanceWishYArea").hide();
		}
	}

	//사람찾기팝업
	var popType = "";
	function openSelectUserPop(type){
		popType = type;
		var paramList = [];
		var param = "";
		switch(popType){

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

		}
		 userSelectPopCall(paramList);		//공통 선택 팝업 호출
	}

	function deleteStaff(type,userId){
		switch(type){
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
		    actionBySelData: function(listObj){

		    	switch(popType){
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
				}
		    }
	}

	//계정과목 안내팝업 셋팅
	function accountSubjectSet(){
		/*================ 계정과목 SELECT :S ===============*/

		dv2List = getBaseCommonCode('ACCOUNT_SUBJECT', '', 'CD', 'NM', null, '', '', { orgId : "${baseUserLoginInfo.applyOrgId}"});
		if(dv2List == null){
			dv2List = [{ 'CD': '', 'NM' :'선택'}];
		}
		dvList = getBaseCommonCode('', '', 'CD', 'NM', null, '', '',{sSortOrder : 'Y' , parentCodeSetNm : 'ACCOUNT_SUBJECT', orgId : "${baseUserLoginInfo.applyOrgId}"});
		if(dvList == null){
			dvList = [{ 'CD': '', 'NM' :'선택'}];
		}
		var beforeCodeName ='';
		var str = '<select id="dv" class="select_b w_st18">';
		str+='<option value="">선택</option>';
		for(var i=0; i< dv2List.length; i++){
			if(beforeCodeName != dv2List[i].codeName){
				if(i!=0){
					str += '</optgroup>';
				}
				str += '<optgroup label="'+dv2List[i].NM+'">';
			}
			for(var k=0; k<dvList.length; k++){
				if(dvList[k].codeName == dv2List[i].sonCodeName){
					str += '<option value="'+dvList[k].CD+'">'+dvList[k].NM+'</option>';
				}
			}
			beforeDtailCd = dv2List[i].codeName;
		}
		$("#dvSelect").html(str);
		/*================ 계정과목 SELECT :E ===============*/

		/*================ 계정과목 안내 툴팁 :S ===============*/
		var toolTipHtml = "";

		toolTipHtml += '                <table class="tb_list_basic5 mgb10">';
		toolTipHtml += '                    <colgroup>';
		toolTipHtml += '                        <col width="85" />';
		toolTipHtml += '                        <col width="80" />';
		toolTipHtml += '                        <col width="*" />';
		toolTipHtml += '                    </colgroup>';
		toolTipHtml += '                    <thead>';
		toolTipHtml += '                        <tr>';
		toolTipHtml += '                            <th scope="col">대분류</th>';
		toolTipHtml += '                            <th scope="col">소분류</th>';
		toolTipHtml += '                            <th scope="col">내용</th>';
		toolTipHtml += '                        </tr>';
		toolTipHtml += '                    </thead>';
		toolTipHtml += '                    <tbody>';

		//rowspan 구하기
		var cdObj = {};
		var beforeDtailCd ='';
		var cdCnt = 0;
		beforeCodeName ='';
        for(var i=0; i< dv2List.length; i++){
        	if(beforeDtailCd != dv2List[i].sonCodeName){
                if(i!=0){
                	cdObj[beforeDtailCd] = cdCnt;
                    cdCnt = 0;
                }
            }
            for(var k=0; k<dvList.length; k++){
                if(dvList[k].codeName == dv2List[i].sonCodeName){
                	cdCnt++;
                }
            }
            beforeDtailCd = dv2List[i].sonCodeName;
        }

		for(var i=0; i< dv2List.length; i++){
			var sameCnt = 0;
            for(var k=0; k<dvList.length; k++){
                if(dvList[k].codeName == dv2List[i].sonCodeName){
                    toolTipHtml += '                        <tr>';
                    if(sameCnt == 0){
                    	toolTipHtml += '                            <td rowspan="'+cdObj[dv2List[i].CD]+'" class="center_txt_bold">'+dv2List[i].NM+'</td>';
                    }
                    toolTipHtml += '                            <td class="car_member">'+dvList[k].NM+'</td>';
                    toolTipHtml += '                            <td class="left_txt">'+dvList[k].valueDesc+'</td>';
                    toolTipHtml += '                        </tr>';

                    sameCnt++;
                }
            }
        }

		/* toolTipHtml += '                        <tr>';
		toolTipHtml += '                            <td class="car_member">저녁업무</td>';
		toolTipHtml += '                            <td class="left_txt">업무 관계자와 저녁식사</td>';
		toolTipHtml += '                   </tr>';
		toolTipHtml += '                   <tr>';
		toolTipHtml += '                            <td class="car_member">회식업무</td>';
		toolTipHtml += '                            <td class="left_txt">업무 관계자와 저녁회식 - 저녁식사 외 별도인 경우</td>';
		toolTipHtml += '                        </tr>';
		toolTipHtml += '                        <tr>';
		toolTipHtml += '                            <td class="car_member">커피업무</td>';
		toolTipHtml += '                            <td class="left_txt">업무 관계자와 식사 외 비용 - 간식 포함</td>';
		toolTipHtml += '                        </tr>';
		toolTipHtml += '                    <tr>';
		toolTipHtml += '                            <td class="center_txt_red">기타업무</td>';
		toolTipHtml += '                            <td class="left_txt">고객 방문시 접대 선물 및 기타 물품 구매용</td>';
		toolTipHtml += '                        </tr>';
		toolTipHtml += '                    <tr>';
		toolTipHtml += '                            <td rowspan="5" class="center_txt_bold">복리후생</td>';
		toolTipHtml += '                            <td class="car_member">저녁야근</td>';
		toolTipHtml += '                            <td class="left_txt">본사 야근시 저녁 식사비용</td>';
		toolTipHtml += '                        </tr>';
		toolTipHtml += '                        <tr>';
		toolTipHtml += '                            <td class="car_member">부서회식</td>';
		toolTipHtml += '                            <td class="left_txt">부서 회식비</td>';
		toolTipHtml += '                   </tr>';
		toolTipHtml += '                   <tr>';
		toolTipHtml += '                            <td class="car_member">워크샵식비</td>';
		toolTipHtml += '                            <td class="left_txt">워크샵 비용 중 식대 관련 비용 - 식사, 커피, 간식</td>';
		toolTipHtml += '                        </tr>';
		toolTipHtml += '                        <tr>';
		toolTipHtml += '                            <td class="car_member">워크샵회식</td>';
		toolTipHtml += '                            <td class="left_txt">워크샵 비용 중 회식 관련 비용</td>';
		toolTipHtml += '                        </tr>';
		toolTipHtml += '                    <tr>';
		toolTipHtml += '                            <td class="center_txt_red">점심-직원</td>';
		toolTipHtml += '                            <td class="left_txt">고객과의 점심이 아닌 일상적인 점심</td>';
		toolTipHtml += '                        </tr>'; */
		toolTipHtml += '                    </tbody>';
		toolTipHtml += '                </table>';

		$("#accountToolTip").html(toolTipHtml);
		/*================ 계정과목 안내 툴팁 :E ===============*/
	}
	function showlayer(id){
		if(id.style.display == 'none'){id.style.display='block';}
		else{id.style.display = 'none';}
	}
</script>
