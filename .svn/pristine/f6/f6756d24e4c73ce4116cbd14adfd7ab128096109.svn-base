<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>
<script type="text/javascript">
var myModal = new AXModal();	// instance

var amountModifyYn = "N";
$(document).ready(function(){

	var listType = $("#listType").val();

	if(listType == 'pendList'||listType == 'previous')
		$(".btnAppvModify").show();

	//유저프로필 이벤트 셋팅
	initUserProfileEvent();
});
//삭제
function deleteAproveDoc(){
	if(confirm("정말 삭제하시겠습니까?")){
		$("#frm").attr("action",contextRoot+"/approve/deleteApproveDoc.do");
		commonAjaxSubmit("POST",$("#frm"),deleteCallback);
	}
}
//삭제 콜백
function deleteCallback(data){
	alert("삭제되었습니다.");

	<c:if test = "${popYn eq 'M'}">
		window.close();
		return;
	</c:if>

	url = "/approve/draftDocList.do";
	$("#frm").attr("action" , contextRoot + url).submit();

	<c:if test = "${popYn eq 'A'}">
		var popType = window.opener.approveObj.selectedType;
		window.opener.approveObj.doSearch(popType);
	</c:if>

	<c:if test = "${popYn eq 'M'}">
		var popType = window.opener.approveObj.selectedType;
		window.opener.approveObj.doSearch(popType);
	</c:if>
}
//수정화면
function goModifyPage(){
	var url = "/approve/modifyApproveDocPage.do";
	$("#frm").attr("action" , contextRoot + url).submit();
}

//상신
function processDocSubmit(){
    if("${lineSize}" == "0"){
        alert("결재선이 없으므로 품의서를 상신할수 없습니다. 담당자에게 문의해주세요.");
        return;
    }

    if($("#appvDocClass").val()=="EXPENSE"&&$("#amount").val()!=""&&$("#amount").val()!="0"){
		//프로젝트 금액 벨리데이션 체크
		$("#frm").attr("action",contextRoot+"/project/getProjectExpenseValid.do");
		commonAjaxSubmit("POST",$("#frm"),projectExpenseValidCallback);
	}else{
		if(confirm("해당 품의서를 [상신] 하시겠습니까?")){
			$("#frm").attr("action",contextRoot+"/approve/processDocSubmit.do");
			commonAjaxSubmit("POST",$("#frm"),processDocSubmitCallback);
		}
	}

}

//프로젝트 비용관련 유효성관련 데이터 조회
function projectExpenseValidCallback(data){
	var expenseInfo = data.resultObject;
	var confirmStr = "저장하시겠습니까?";
	if(expenseInfo.activityExpense == "N"){
		alert("선택한 ${baseUserLoginInfo.projectTitle }은/는 지출이 불가능합니다.\n프로젝트 담당자에게 문의 후 다시 등록해주세요.");
		return;
	}else if(expenseInfo.activityExpense == "Y"){
		var amount = parseInt($("#amount").val());
		if(parseInt(expenseInfo.avalAmt)<amount){
			alert("입력한 지출금액이 사용 가능한 지출 범위를 초과하였습니다.\n${baseUserLoginInfo.projectTitle } 담당자에게 문의 후 다시 등록해주세요.");
			return;
		}
	}else{
		alert("선택한 ${baseUserLoginInfo.projectTitle } 정보가 조회되지 않습니다. 담당자에게 문의해주세요.");
		return;
	}

	if(confirm("해당 품의서를 [상신] 하시겠습니까?")){
		$("#frm").attr("action",contextRoot+"/approve/processDocSubmit.do");
		commonAjaxSubmit("POST",$("#frm"),processDocSubmitCallback);
	}
}


//상신 콜백
function processDocSubmitCallback(data){
	if(data.resultObject.result =="SUCCESS"){
		alert("해당 품의서가 [상신] 되었습니다.");
		$("#docStatus").val("SUBMIT");
		$("#listType").val("draft");

		<c:if test = "${popYn eq 'M'}">
			if(window.opener){
				window.opener.doSearch();
			}
		</c:if>

		$("#frm").attr("action",contextRoot+"/approve/getApproveDrfDetail.do").submit();
		<c:if test = "${popYn eq 'A'}">
			var popType = window.opener.approveObj.selectedType;
			window.opener.approveObj.doSearch(popType);
		</c:if>


	}else{
		if(data.resultObject.msg!=null){
			alert(data.resultObject.msg);
			return;
		}
		alert("저장에 실패했습니다. 담당자에게 문의해 주세요.");
	}
}
var docStatusNm = "";
//상태변경
function processDocStatus(docStatus){
	if(isModify){
		alert("수정 내용이 있습니다. 저장 버튼을 눌러 저장해 주세요.");
		return;
	}
	var dupCnt = "${detailMap.dupAssignCnt}";
	if(dupCnt != ""&&parseInt(dupCnt)>1){
		if(!confirm("대결자로 지정되어서 결재처리시 대결 및 선결 처리됩니다. 결재하시겠습니까?")){
			return;
		}
	}
	docStatusNm = docStatus == 'APPROVE'?'승인':'반려';
	/* if($("#appvComment").val()==""){
		alert("["+docStatusNm+"] 의견을 입력해 주세요.");
		$("#appvComment").focus();
		return;
	} */
	if($("#amountEvent").length>0&& $("#amountEvent").val() == ""){
		alert("금액을 입력해 주세요.");
		$("#amountEvent").focus();
		return;
	}
	if(amountModifyYn == "Y"){
		alert("금액 적용 버튼을 눌러주세요.");
		$("#amountEvent").focus();
		return;
	}

	if(confirm("해당 품의서를 ["+docStatusNm+'] 하시겠습니까?')){
		$("#docStatus").val(docStatus);

		$("#frm").attr("action",contextRoot+"/approve/processDocStatus.do");
		commonAjaxSubmit("POST",$("#frm"),processDocStatusCallback);
	}
}
//상태변경 콜백
function processDocStatusCallback(data){
	if(data.resultObject.result =="SUCCESS"){//성공 메세지가 바뀌는 상황에 구현한다.
		alert("해당 품의서가 ["+docStatusNm+"] 되었습니다.");

		/* if($("#listType").val() == "pendList"&& data.resultObject.chkDupAppvReqUserCnt>1){
			$("#listType").val("pendList");
			$("#frm").attr("action",contextRoot+"/approve/approvePendDetail.do").submit();
		}else{
			$("#listType").val("reqList");
			$("#frm").attr("action",contextRoot+"/approve/getApproveReqDetail.do").submit();
		} */

		$("#listType").val("reqList");
		$("#frm").attr("action",contextRoot+"/approve/getApproveReqDetail.do").submit();

		<c:if test = "${popYn eq 'A'}">
			var popType = window.opener.approveObj.selectedType;
			window.opener.approveObj.doSearch(popType);
		</c:if>

	}else{
		alert("저장에 실패했습니다. 담당자에게 문의해 주세요.");
	}
}
var cancelDocStatus = "";
//취소처리 팝업 오픈
function openEmpCancelPop(docStatus){
	$("#appvCancelMemo").val("");
	cancelDocStatus = docStatus;
	myModal.openDiv({
		modalID: "approveEmpCancelArea",
		titleBarText: '취소처리',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
		method:"POST",
		top: 10,
		width: 750,
		closeByEscKey: true				//esc 키로 닫기
	});

	$('#approveEmpCancelArea').draggable();
}
//취소 승인/반려
function processDocCancel(){

	if($("#appvCancelUserMemo").val()==""){
		alert("회수의견을 입력해 주세요.");
		$("#appvCancelUserMemo").focus();
		return;
	}
	var docStatus = cancelDocStatus;
	docStatusNm = docStatus == 'CNL_COMMIT'?'승인':'반려';
	if(confirm("해당 품의서의 회수요청을 ["+docStatusNm+'] 하시겠습니까?')){
		$("#docStatus").val(docStatus);
		$("#frm").attr("action",contextRoot+"/approve/processDocStatusCancel.do");
		commonAjaxSubmit("POST",$("#frm"),processDocCancelCallback);
	}
}
//취소 승인/반려 콜백
function processDocCancelCallback(data){
	if(data.resultObject.result =="SUCCESS"){//성공 메세지가 바뀌는 상황에 구현한다.
		alert("해당 품의서의 회수요청이 ["+docStatusNm+"] 되었습니다.");
		$("#listType").val("reqList");
		$("#frm").attr("action",contextRoot+"/approve/getApproveReqDetail.do").submit();

		<c:if test = "${popYn eq 'A'}">
			var popType = window.opener.approveObj.selectedType;
			window.opener.approveObj.doSearch(popType);
		</c:if>
	}else{
		alert("저장에 실패했습니다. 담당자에게 문의해 주세요.");
	}
}
//승인완료취소팝업
function openCancelPop(){
	$("#appvCancelMemo").val("");
	myModal.openDiv({
		modalID: "approveCancelReqArea",
		titleBarText: '사원 선택',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
		method:"POST",
		top: 10,
		width: 750,
		closeByEscKey: true				//esc 키로 닫기
	});

	$('#approveCancelReqArea').draggable();
}
//목록
function goListPage(){
	var url = "";
	<c:choose>
	<c:when test="${searchMap.listType eq 'temp' }">
		url = contextRoot+"/approve/tempDocList.do";
	</c:when>
	<c:when test="${searchMap.listType eq 'draft' }">
		url = contextRoot+"/approve/draftDocList.do";
	</c:when>
	<c:when test="${searchMap.listType eq 'pendList' }">
		url = contextRoot+"/approve/approvePendList.do";
	</c:when>
	<c:when test="${searchMap.listType eq 'reqList' }">
		url = contextRoot+"/approve/approveReqList.do";
	</c:when>
	<c:when test="${searchMap.listType eq 'proxyList' }">
		url = contextRoot+"/approve/approveProxyList.do";
	</c:when>
	<c:when test="${searchMap.listType eq 'nextList' }">
		url = contextRoot+"/approve/approveNextList.do";
	</c:when>
	<c:when test="${searchMap.listType eq 'previous' }">
		url = contextRoot+"/approve/approvePreviousList.do";
	</c:when>
	<c:when test="${searchMap.listType eq 'refList' }">
		url = contextRoot+"/approve/approveRefList.do";
	</c:when>
	<c:when test="${searchMap.listType eq 'cancelList' }">
		url = contextRoot+"/approve/reqCancelList.do";
	</c:when>
	<c:when test="${searchMap.listType eq 'rcList' }">
		url = contextRoot+"/approve/approveRcList.do";
	</c:when>
	<c:when test="${searchMap.listType eq 'expenseList' }">
		url = contextRoot+"/approve/approveExpenseList.do";
	</c:when>
	<c:when test="${searchMap.listType eq 'allList' }">
		url = contextRoot+"/approve/approveAllList.do";
	</c:when>
	<c:otherwise>
		url = contextRoot+"/approve/draftDocList.do";
	</c:otherwise>
	</c:choose>
	$("#frm").attr("action" ,url).submit();
}
//결재의견 토글
function toggleRippleZone(){
	$("#RippleZone").toggle();

	if($("#toggleBtn").hasClass("close")) $("#toggleBtn").removeClass("close");
	else $("#toggleBtn").addClass("close");
}

//커멘트 입력 처리 Ajax
function addComment(){
	if($("#appvComment").val()==""){
		alert("의견을 입력해 주세요.");
		$("#appvComment").focus();
		return;
	}
	if(confirm("해당 품의서 [처리의견]을 입력하시겠습니까?")){
		$("#frm").attr("action",contextRoot+"/approve/processDocComment.do");
		commonAjaxSubmit("POST",$("#frm"),addCommentCallback);
	}
}

function addCommentCallback(data){
	alert("[처리의견]이 입력되었습니다.");
	$("#commentArea").html(data);
}

//승인취소저장
function doSave(){
	if($("#appvCancelMemo").val() == ""){
		alert("회수요청사유를 입력해 주세요.");
		$("#appvCancelMemo").focus();
		return;
	}

	if(confirm("저장하시겠습니까?")){
		$("#frm").attr("action",contextRoot+"/approve/processApproveCancelReq.do");
		commonAjaxSubmit("POST",$("#frm"),doSaveCallback);
	}

}
//승인취소 저장 콜백
function doSaveCallback(data){
	if(data.resultObject.result =="SUCCESS"){
		alert("저장되었습니다.");
		$("#frm").attr("action",contextRoot+"/approve/getApproveDrfDetail.do").submit();

		<c:if test = "${popYn eq 'A'}">
			var popType = window.opener.approveObj.selectedType;
			window.opener.approveObj.doSearch(popType);
		</c:if>
	}else{
		if(data.resultObject.msg!=null){
			alert(data.resultObject.msg);
			return;
		}
		alert("저장에 실패했습니다. 담당자에게 문의해 주세요.");
	}
}
//수신확인 팝업 오픈
function processAppvRc(){

	<c:if test="${detailMap.docStatus ne 'COMMIT' and detailMap.docStatus ne 'CNL_SUBMIT' and detailMap.docStatus ne 'CNL_REJECT'}">
		alert("[승인진행] 상태에서는 수신확인은 할 수 없습니다.");
		return;
	</c:if>
	$("#approveRcConfirmArea").val("");
	myModal.openDiv({
		modalID: "approveRcConfirmArea",
		titleBarText: '',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
		method:"POST",
		top: 10,
		width: 750,
		closeByEscKey: true				//esc 키로 닫기
	});

	$('#approveRcConfirmArea').draggable();
}
//수신확인
function processAppvRcSave(){
	if($("#receiptUserMemo").val()==""){
		alert("수신확인 의견을 입력해주세요.");
		$("#receiptUserMemo").focus();
		return;
	}

	if(confirm("[수신확인] 하시겠습니까?")){
		var listType = $("#listType").val();

		$("#frm").attr("action",contextRoot+"/approve/processAppvRcAjax.do");
		commonAjaxSubmit("POST",$("#frm"),processAppvRcCallback);
	}
}

//수신확인 콜백
function processAppvRcCallback(data){
	if(data.resultObject.result =="SUCCESS"){
		alert("[수신확인]되었습니다.");
		$("#frm").attr("action",contextRoot+"/approve/getApproveRcDetail.do").submit();

		<c:if test = "${popYn eq 'A'}">
			var popType = window.opener.approveObj.selectedType;
			window.opener.approveObj.doSearch(popType);
		</c:if>
	}else{
		if(data.resultObject.msg!=null){
			alert(data.resultObject.msg);
			$("#frm").attr("action",contextRoot+"/approve/getApproveRcDetail.do").submit();
			return;
		}
		alert("저장에 실패했습니다. 담당자에게 문의해 주세요.");
	}
}
//수신완료후 확인 팝업
function openRcPop(){
	var url = "<c:url value='/approve/getAppvDocReceiverPop.do'/>";
	var params = {appvDocId:$("#appvDocId").val(),appvDocClass:$("#appvDocClass").val()};
	myModal.open({
		windowID:"myModalCT",
		url: url,
		pars: params,
		titleBarText: '수신확인내역',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
		method:"POST",
		top: $(window).scrollTop() + 150,
		width: 750,
		closeByEscKey: true			//esc 키로 닫기
	});

	$('#myModalCT').draggable();
}
//상세 팝업
function openAppvDocPop(appvDocId,appvDocClass,appvDocType){

	$("#approveFrm #appvDocId").val(appvDocId);
	$("#approveFrm #appvDocClass").val(appvDocClass);
	$("#approveFrm #appvDocType").val(appvDocType);
	var option = "width=898px,height=800px,resizable=yes,scrollbars = yes";
    commonPopupOpen("approveDetailPop",contextRoot+"/approve/getApproveDrfDetail.do",option,$("#approveFrm"));

    return;
}

//내용 수정 팝업 노출
function openMemoModifyPop(){
	myModal.openDiv({
		modalID: "approveMemoModifyArea",
		titleBarText: '내용 수정',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
		method:"POST",
		top: 10,
		width: 1000,
		closeByEscKey: true				//esc 키로 닫기
	});

	$('#approveMemoModifyArea').draggable();
}

//내용 수정
var isModify=false;
function openModify(type){
	isModify = true;
	if(type == "CONTENTS"){
		openModifyAppvMemoInfoPop();
	}else if(type == "FILE"){
		$("#fileViewArea").hide();
		$("#fileUpdateArea").show();
		$(".btnAppvModify").hide();
	}else if(type == "CC"){
		$(".ccViewArea").hide();
		$("#ccUpdateArea").show();

		var targetRowspan = $("#approveCcTh").attr("rowspan");

		if(parseInt(targetRowspan)>1)
			$("#approveCcTr").show();
		$(".btnAppvModify").hide();
	}else if(type == "RECEIVER"){
		$(".rcViewArea").hide();
		$("#rcUpdateArea").show();

		var targetRowspan = $("#approveRcTh").attr("rowspan");

		if(parseInt(targetRowspan)>1)
			$("#approveRcTr").show();
		$(".btnAppvModify").hide();
	}else if(type == "AMOUNT"){
		numberFormatForNumberClass();
		amountModifyYn= "Y";
		$("#amountModifyArea").show();
		$("#amountArea").hide();
	}
}

//메모수정팝업오픈
function openModifyAppvMemoInfoPop(){

	Editor.modify({						 // 내용
		"content": $("#memo").val()
	});

	myModal.openDiv({
		modalID: "approveMemoModifyArea",
		titleBarText: '내용 수정',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
		method:"POST",
		top: 10,
		width: 1000,
		closeByEscKey: true				//esc 키로 닫기
	});
	$('#approveMemoModifyArea').draggable();
}
//메모수정
function modifyAppvMemoInfo(){
	$("#memoArea").html(Editor.getContent());
	myModal.close('approveMemoModifyArea');
	$("#btnMemoSave").show();
	$(".btnAppvModify").hide();
}

//공통 수정의견 팝업
var updateType;
function openSavePop(type){

	if(type == "FILE"){
		<c:if test = "${detailMap.appvDocClass eq 'COMPANY' and detailMap.companyFileUseType eq 'MANDATORY'}">
		if($("#uploadFileList li").length==0) {
			alert("해당 서식은 반드시 파일을 첨부해야 합니다.");
			return;
		}
		</c:if>
	}
	$("#updateComment").val("");
	updateType = type;
	myModal.openDiv({
		modalID: "approveDocUpdateArea",
		titleBarText: '수정의견',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
		method:"POST",
		top: 10,
		width: 1000,
		closeByEscKey: true				//esc 키로 닫기
	});
}

//수정 저장
function doSaveAppvInfoUpdate(){
	if($("#updateComment").val() == ""){
		alert("수정의견을 입력해주세요.");
		return;
	}
	if(confirm("수정하시겠습니까?")){
		if(updateType == "CONTENTS"){
			$("#memo").val(Editor.getContent());
		}else if(updateType == "FILE"){
			/* 파일 수정시 delete List 처리 */
			if(delArray.length !=0){										//수정시 삭제한 파일들의 리스트
				for(var i = 0 ; i < delArray.length; i++){
					$input = $("<input></input>").attr("type","hidden").attr("name","delFileList").val(delArray[i]);
					$("#frm").append($input);
				}
			}
		}else if(updateType == "AMOUNT"){

			if($("#amountEvent").val() == ""){
				alert("경조금액을 입력해 주세요.");
				return;
			}
			var  amountEvent =$("#amountEvent").val();
			$("#amountEvent").val(amountEvent.split(",").join(""));
		}

		$("#updateType").val(updateType);

		$("#frm").attr("action",contextRoot+"/approve/doSaveAppvInfoUpdate.do");
		commonAjaxSubmit("POST",$("#frm"),doSaveAppvInfoUpdateCallback);
	}
}
//수정 저장 콜백
function doSaveAppvInfoUpdateCallback(data){
	alert("수정되었습니다.");
	$("#frm").attr("action","").submit();
}
//선열 , 미결 화면에서 결재 가능한지 유효성 검사를 함
/* function chkAppvReqStatus(){
	var url = contextRoot +"/approve/chkAppvReqStatus.do";

	var listType = $("#listType").val();

	if(listType!= "previous" &&listType!= "pendList"){
		return;
	}
	var param = {listType:listType};
	var callback = function(data){
		goListPage();
	}
} */
function openProcessExpense(){
	<c:if test = "${detailMap.totReceiptCnt>0 and detailMap.rcReceiptCnt eq 0}">
		alert("수신 확인 후 지급처리 할수 있습니다.");
		return;
	</c:if>
	myModal.close('approveExpenseConfirmArea');

	myModal.openDiv({
		modalID: "approveExpenseConfirmArea",
		titleBarText: '지출처리',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
		method:"POST",
		top: 10,
		width: 1000,
		closeByEscKey: true				//esc 키로 닫기
	});
}
//지출결의서 지급처리
function processExpenseYn(){

	if(confirm("지급처리 하시겠습니까?")){
		$("#frm").attr("action",contextRoot+"/approve/processExpenseYn.do");
		commonAjaxSubmit("POST",$("#frm"),processExpenseYnCallback);
	}
}
//지출결의서 지급처리 콜백
function processExpenseYnCallback(data){
	alert("지급처리 되었습니다.");
	$("#frm").attr("action",contextRoot+"/approve/approveExpenseDetail.do").submit();

	<c:if test = "${popYn eq 'A'}">
		var popType = window.opener.approveObj.selectedType;
		window.opener.approveObj.doSearch(popType);
	</c:if>
}
//////////////////////////////////////////////////참조인,수신인 컨트롤
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
		case 'userType':
			$("#userTypeList_"+userId).remove();

			$("span[id*='userTypeList_']").eq(0).find("#userTypeList_comma").remove();
			if($("span[id*='userTypeList_']").length==0){
				$("#userTypeTh").attr("rowspan","1");
				$("#userTypeTr").hide();
			}
			break;
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
				case 'userType':
					$("#selectStaffId").val(listObj[0].userId);
					$("#staffNameArea").text(listObj[0].userName)

					var stStr = listObj[0].deptNm + '<span class="dashLine"> / </span>';
						stStr+= listObj[0].rankNm;

					$("#selectStaffInfoArea").html(stStr);

					<c:if test = "${companyFormMap.projectType eq 'ING'}">
						setProjectArea();

						var stStr = '<select id = "activityId" name = "activityId" class="select_b mgl6">';
							stStr+= '<option value="">${baseUserLoginInfo.activityTitle } 선택</option></select>';

						$("#activityArea").html(stStr);
						$("#activityDescArea").empty();
					</c:if>
					doRefleshSche();
					doRefleshProject();
					$("#linkDocTh").attr("rowspan","1");
					$("#linkDocArea").empty();
					$("#linkDocTr").hide();
					break;
				}
		    }
	}
//프린트
function approveDocPrint(){

}
</script>
