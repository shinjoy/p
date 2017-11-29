<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
	//var comDocStatusType = getBaseCommonCode('DOC_STATUS', null, 'CD', 'NM', '', '전체','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
	var colorObj = {};

	$(document).ready(function(){
		/* var docStatusTypeTag = createSelectTag('searchDocStatus', comDocStatusType, 'CD', 'NM', '${searchMap.searchDocStatus}', null, colorObj, 100, 'search_type2 mgl8');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
		$("#searchDocStatusTag").html(docStatusTypeTag);
		$("#searchDocStatus option").each(function(){
			if($(this).val() == "WORKING"||$(this).val() == "SUBMIT"){
				$(this).remove();
			}
		}); */
		//유저프로필 이벤트 셋팅
		initUserProfileEvent();
	})
	//구분별 보기
	function gatherView(type){
		$("#searchAppvStatus").val(type);
		linkPage('1');

	}
	//검색
	function linkPage(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action",contextRoot+"/approve/approveReqDocListAjax.do");
		commonAjaxSubmit("POST",$("#frm"),searchCallback);
	}

	// 검색 콜백
	function searchCallback(data){
		$("#listArea").html(data);

		//유저프로필 이벤트 셋팅
		initUserProfileEvent();
	}

	//품의페이지이동
	function moveApproveProductPage(){
		$("#frm").attr("action",contextRoot+"/approve/approveProduct.do").submit();
	}
	//상세화면으로 이동
	function goDetailPage(appvDocId,appvDocClass, appvDocType, docStatus, approveProcessId){
		$("#appvDocId").val(appvDocId);
		$("#appvDocClass").val(appvDocClass);
		$("#appvDocType").val(appvDocType);
		$("#docStatus").val(docStatus);
		$("#approveProcessId").val(approveProcessId);

		var listType = "${searchMap.listType }";

		var url = "";

		switch(listType){
		case 'pendList':/*미결*/
			url = "/approve/approvePendDetail.do";
			break;
		case 'reqList':/*기결*/
			url = "/approve/getApproveReqDetail.do";
			break;
		case 'proxyList':/*대결*/
			url = "/approve/approveProxyDetail.do";
			break;
		case 'nextList':/*후결*/
			url = "/approve/approveNextDetail.do";
			break;
		case 'previous':/*선열*/
			url = "/approve/approvePreviousDetail.do";
			break;
		case 'allList':/*전체*/
			url = "/approve/approveAllDetail.do";
			break;
		}

		$("#frm").attr("action",contextRoot+url).submit();
	}
	var docStatusNm = "";
	//승인 반려 일괄처리
	function processDocStatusAll(docStatus){

		if($("input[name='chkedDoc']:checked").length == 0){
			alert("최소 한건 이상 선택해 주세요.");
			return;
		}

		if(docStatus == "WORKING"){
			alert("작성중 문서는 처리할수 없습니다.");
			return;
		}
		docStatusNm = docStatus == 'APPROVE'?'승인':'반려';
		if(confirm("선택하신 품의서를 ["+docStatusNm+'] 하시겠습니까?')){
			$("#processDocStatus").val(docStatus);
			$("#frm").attr("action",contextRoot+"/approve/processDocSubmitAll.do");
			commonAjaxSubmit("POST",$("#frm"),processDocStatusAllCallback);
		}
	}
	//콜백함수
	function processDocStatusAllCallback(data){
		if(data.resultObject.result =="SUCCESS"){//성공 메세지가 바뀌는 상황에 구현한다.
			alert("선택하신 품의서가 ["+docStatusNm+"] 되었습니다.");
			$("#frm").attr("action",contextRoot+"/approve/approvePendList.do").submit();
		}else{
			alert("저장에 실패했습니다. 담당자에게 문의해 주세요.");
		}
	}

</script>
