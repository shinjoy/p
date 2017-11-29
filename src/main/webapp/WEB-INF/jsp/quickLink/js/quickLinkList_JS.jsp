<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">

var myModal = new AXModal();	// instance
$(document).ready(function(){
	//-------------------------- 모달창 :S -------------------------
	myModal.setConfig({
		windowID:"myModalCT",
		//openModalID:"kkkkk",
		width:1200,
        mediaQuery: {
            mx:{min:0, max:767}, dx:{min:767}
        },
		displayLoading:true,
        scrollLock: true,
		onclose: function(){
			//toast.push("모달 close");

			//if(window[myModal.winID].isSaved == false){		//저장을 안한상태로 창이 닫힐때, 이미 업로드한 파일은 삭제
			//	window[myModal.winID].fnObj.deleteFile();	//팝업창 내 파일삭제함수 호출.
			//}
		}
        ,contentDivClass: "popup_outline"
	});
	//-------------------------- 모달창 :E -------------------------
	$(".quickLinkInput").hide();

	initSortInput('new');

});
//순서 인풋 타입 활성화
function initSortInput(type){
	$("#sort_"+type).bindNumber({min:0, max:1000});
}
//사용법안내팝업
function openHelpModalPop(){
	var url = "<c:url value='/management/quickLinkHelpPop.do'/>";
	var params = {};

	myModal.open({
		url: url,
		pars: params,
		titleBarText: '사이트 바로가기 안내',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
		method:"POST",
		top: $(window).scrollTop() + 100,		//screenY
		width: 900,
		closeByEscKey: true				//esc 키로 닫기
	});

	$('#myModalCT').draggable();
}
//저장
function doSave(type){
	var url = contextRoot + "/management/processQuickLink.do";

	var quickLinkId = $("#"+type).find("input[name='quickLinkId']").val();
	var sort = $("#"+type).find("input[name='sort']").val();
	var siteName = $("#"+type).find("input[name='siteName']").val();
	var linkName = $("#"+type).find("input[name='linkName']").val();
	var linkUrl = $("#"+type).find("input[name='linkUrl']").val();
	var linkType = $("#"+type).find("input[name='linkType_"+type+"']:checked").val();
	var comment = $("#"+type).find("input[name='comment']").val();
	var useYn = $("#"+type).find("input[name='useYn_"+type+"']:checked").val();


	if(!quickLinkId||quickLinkId==""){
		dialog.push({body:"<b>확인!</b> 시스템 처리도중 오류가발생했습니다.관리자에게 문의해주세요.", type:"", onConfirm:function(){}});
		return;
	}
	//순서
	if(!sort||sort==""){
		dialog.push({body:"<b>확인!</b> 순서를 입력해 주세요.", type:"", onConfirm:function(){$("#"+type).find("input[name='sort']").focus()}});
		return;
	}

	//사이트명
	if(!siteName||siteName==""){
		dialog.push({body:"<b>확인!</b> 사이트명을 입력해 주세요.", type:"", onConfirm:function(){$("#"+type).find("input[name='siteName']").focus()}});
		return;
	}

	//링크명
	if(!linkName||linkName==""){
		dialog.push({body:"<b>확인!</b> 링크명을 입력해 주세요.", type:"", onConfirm:function(){$("#"+type).find("input[name='linkName']").focus()}});
		return;
	}

	//URL
	if(!linkUrl||linkUrl==""){
		dialog.push({body:"<b>확인!</b> URL을 입력해 주세요.", type:"", onConfirm:function(){$("#"+type).find("input[name='linkUrl']").focus()}});
		return;
	}

	//comment
	if(!comment||comment==""){
		dialog.push({body:"<b>확인!</b> 비고를 입력해 주세요.", type:"", onConfirm:function(){$("#"+type).find("input[name='comment']").focus()}});
		return;
	}



	var param = {quickLinkId : quickLinkId,
				 sort : sort,
				 siteName : siteName,
				 linkName : linkName,
				 linkUrl : linkUrl,
				 linkType : linkType,
				 comment : comment,
				 useYn : useYn}

	var callback = function(result){

		var obj = JSON.parse(result);

		var cnt = obj.resultVal;	//결과수

		if(obj.result == "SUCCESS"){
			resetProc();
			toast.push("저장OK!");
		}else{
			alertM("저장도중 오류가 발생하였습니다.");
			return;
		}

	};

	commonAjax("POST", url, param, callback);

}

//저장/수정후 리프레쉬
function resetProc(){
	$("#frm").attr("action",contextRoot+"/management/getQuickLinkListAjax.do");
	commonAjaxSubmit("POST",$("#frm"),resetProcCallback);
}

//저장/수정후 리프레쉬 콜백
function resetProcCallback(data){
	$("#listArea").html(data);

	$(".quickLinkInput").hide();

	initSortInput('new');
}

//수정 영역 활성화
function showUpdateForm(type){

	$(".quickLinkView").show();
	$(".quickLinkInput").hide();

	$(".AXanchorNumberContainer").remove();
	$(".AXanchor").remove();

	initSortInput('new');
	$("#"+type).find(".quickLinkView").hide();
	$("#"+type).find(".quickLinkInput").show();
	$("#"+type).find("#btnReset").click(function(){
		reset(type);
	});

	initSortInput(type);

	//var linkType = $("#"+type).find("#"+type+"_linkType").val();
	//$("input[name='linkType_"+type+"'][value='"+linkType+"']").prop("checked",true);
	$("input[name='linkType_"+type+"']").prop("disabled",false);

	//var useYn = $("#"+type).find("#"+type+"_useYn").val();
	//$("input[name='useYn_"+type+"'][value='"+useYn+"']").prop("checked",true);
	$("input[name='useYn_"+type+"']").prop("disabled",false);
}
//새로고침버튼
function reset(type){
	if(type == "new"){
		$("#"+type).find("input[name='sort']").val("");
		$("#"+type).find("input[name='siteName']").val("");
		$("#"+type).find("input[name='linkName']").val("");
		$("#"+type).find("input[name='linkUrl']").val("");
		$("#"+type).find("input[name='linkType_"+type+"'][value='BLANK']").prop("checked",true);
		$("#"+type).find("input[name='comment']").val();
		$("#"+type).find("input[name='useYn_"+type+"'][value='Y']").prop("checked",true);
	}else{
		$("#"+type).find(".quickLinkView").show();
		$("#"+type).find(".quickLinkInput").hide();

		$(".AXanchorNumberContainer").remove();
		$(".AXanchor").remove();

		initSortInput('new');

		$("input[name='linkType_"+type+"']").prop("disabled",true);

		$("input[name='useYn_"+type+"']").prop("disabled",true);
	}
}
//퀵메뉴 삭제
function deleteQuicMenu(quickLinkId){
	var url = contextRoot + "/management/deleteQuickLink.do";
	var param = {quickLinkId : quickLinkId};

	if(!confirm("삭제하시겠습니까?")) return;

	var callback = function(result){

		var obj = JSON.parse(result);

		var cnt = obj.resultVal;	//결과수

		if(obj.result == "SUCCESS"){
			resetProc();
			toast.push("삭제OK!");
		}else{
			alertM("삭제도중 오류가 발생하였습니다.");
			return;
		}

	};

	commonAjax("POST", url, param, callback);
}
</script>
