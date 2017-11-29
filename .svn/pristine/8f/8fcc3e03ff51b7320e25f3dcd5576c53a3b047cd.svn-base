<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>
<script type="text/javascript">
var myModal = new AXModal();	// instance

var oriAppvDocNumRuleMidName = "";
$(document).ready(function(){
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
	//-------------------------- 모달창 :E -------------------------
	Editor.modify({						 // 내용
		"content": "*** 생성하는 서식에 필요한 입력항목이나 표, 입력 방법 등에 대해 작성해주세요.<br>(본 설명 문구는 삭제하고 작성해주세요)"		 /* 내용 문자열, 주어진 필드(textarea) 엘리먼트 */
	})
});
//체크박스 클릭
function chkUseYn(type){
	if($("#"+type).prop("checked")){
		$("#"+type+"Area").show();

		$("#"+type+"Area").find("input").prop("disabled" , false);
	}else{
		$("#"+type+"Area").hide();

		$("#"+type+"Area").find("input").prop("disabled" , true);
	}
}

//공개 비공개 버튼 클릭
function chgOpenYn(type){
	if(type == "Y"){
		alert("공개 위해 저장전 미리보기로 \n문서를 확인해주세요.");
		/* $("#openNArea").show();
		$("#openYArea").hide();

		$("#openYn").val("N"); */
	}else if(type == "N"){


		/* $("#openNArea").hide();
		$("#openYArea").show();

		$("#openYn").val("Y"); */
	}
}

//미리보기 팝업
function openPreViewPop(){
	//////////////////////////////Validation : S
	if($("#appvDocTypeName").val().trim()==""){
		alert("문서타입을 입력해 주세요.");
		$("#appvDocTypeName").focus();
		return;
	}

	if($("#appvDocNumRuleMidName").val().trim()==""){
		alert("구분을 입력해 주세요.");
		$("#appvDocNumRuleMidName").focus();
		return;
	}

	if($("#appvDocNumRuleMidNameChk").val() != "Y"){
		alert("구분 중복체크 버튼을 눌러주세요.");
		return;
	}

	if(Editor.getContent() == '<p><br></p>' || Editor.getContent() == ''){
		alert("내용을 입력해 주세요.");
		return;
	}
	//////////////////////////////Validation : E


	var option = "width=1000px,height=900px,resizable=yes,scrollbars = yes";
	$("#docContent").val(Editor.getContent());
    commonPopupOpen("appvCompanyCreatePop",contextRoot+"/approve/reqCompany.do",option,$("#frm"));
}

//목록 버튼
function goListPage(){
	var stStr = "입력하신 내용이 저장되지 않았습니다.\n이대로 목록으로 이동하시겠습니까?";
	if(confirm(stStr)){
		$("#frm").attr("action" , contextRoot+"/approve/approveCompanyFormList.do").submit();
	}
}

//저장
function doSave(){
	//////////////////////////////Validation : S
	if($("#appvDocTypeName").val().trim()==""){
		alert("문서타입을 입력해 주세요.");
		$("#appvDocTypeName").focus();
		return;
	}

	if($("#appvDocNumRuleMidName").val().trim()==""){
		alert("구분을 입력해 주세요.");
		$("#appvDocNumRuleMidName").focus();
		return;
	}

	if($("#appvDocNumRuleMidNameChk").val() != "Y"){
		alert("구분 중복체크 버튼을 눌러주세요.");
		return;
	}

	if(Editor.getContent() == '<p><br></p>' || Editor.getContent() == ''){
		alert("내용을 입력해 주세요.");
		return;
	}
	//////////////////////////////Validation : E
	$("#docContent").val(Editor.getContent());
	if(confirm("저장하시겠습니까?")){
		$("#frm").attr("action",contextRoot+"/approve/insertApproveCompanyFormAjax.do");
		commonAjaxSubmit("POST",$("#frm"),doSaveCallback);
	}
}
//구분 텍스트 필드에 blur될때
function appvDocNumRuleMidNameBlur(){
	if(oriAppvDocNumRuleMidName != $("#appvDocNumRuleMidName").val().trim()){
		oriAppvDocNumRuleMidName = $("#appvDocNumRuleMidName").val().trim();
		$("#appvDocNumRuleMidNameChk").val("N");

		$("#appvDocNumRuleMidNameResult").text("");

	}
}
//구분 유효성 체크
function doAppvDocNumRuleMidNameChk(){
	if(oriAppvDocNumRuleMidName == ""){
		alert("구분을 입력해 주세요.");
		$("#appvDocNumRuleMidName").focus();
		return;
	}

	var appvDocNumRuleMidNameBuf = $("#appvDocNumRuleMidName").val();
	$("#appvDocNumRuleMidName").val(appvDocNumRuleMidNameBuf.split(" ").join(""));
	$("#frm").attr("action",contextRoot+"/approve/doAppvDocNumRuleMidNameChk.do");
	commonAjaxSubmit("POST",$("#frm"),doAppvDocNumRuleMidNameChkCallback);
}
//구분 유효성 체크 콜백
function doAppvDocNumRuleMidNameChkCallback(data){
	if(data.resultObject.result =="SUCCESS"){
		alert("사용가능합니다.");
		$("#appvDocNumRuleMidNameChk").val("Y");

		$("#appvDocNumRuleMidNameResult").css("color","");
		$("#appvDocNumRuleMidNameResult").text("사용가능");
	}else{
		alert("이미 사용중입니다.\n다른 구분을 입력해주세요.");
		$("#appvDocNumRuleMidNameChk").val("N");

		$("#appvDocNumRuleMidNameResult").css("color","red");
		$("#appvDocNumRuleMidNameResult").text("사용불가");
	}
}
//저장콜백
function doSaveCallback(data){
	if(data.resultObject.result =="SUCCESS"){
		alert("저장되었습니다.");
		$("#frm").attr("action" , contextRoot+"/approve/approveCompanyFormList.do").submit();
	}else{
		if(data.resultObject.msg!=null){
			alert(data.resultObject.msg);
			return;
		}
		alert("저장에 실패했습니다. 담당자에게 문의해 주세요.");
	}
}
//작성방법안내 팝업
function openHelpPop(){
	myModal.openDiv({
		modalID: "my-modal-div",
		targetID: "appvCompanyHelpPop",
		width:830,
		closeByEscKey:true
	});

	$(".popHeader").hide();
	$("#my-modal-div_close").hide();
	$('#my-modal-div').draggable();
}
</script>
