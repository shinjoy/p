<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">

	var colorObj = {};
	$(document).ready(function(){
		/* var comDocStatusType = getBaseCommonCode('DOC_STATUS', null, 'CD', 'NM', '', '전체','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
		var docStatusTypeTag = createSelectTag('searchDocStatus', comDocStatusType, 'CD', 'NM', '${searchMap.searchDocStatus}', null, colorObj, '', 'search_type2');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
		$("#searchDocStatusTag").html(docStatusTypeTag); */

		//유저프로필 이벤트 셋팅
		initUserProfileEvent();
	})
	//구분별 보기
	function gatherView(type){
		if(type == "RECEIVER_CONFIRM" || type == "RECEIVER_NOT_CONFIRM"){
			$("#searchRcStatus").val(type);
			$("#searchDocStatus").val("");
		}else{
			$("#searchRcStatus").val("");
			$("#searchDocStatus").val(type);
		}
		linkPage('1');

	}
	//검색
	function linkPage(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action",contextRoot+"/approve/draftDocListAjax.do");
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
	function goDetailPage(appvDocId,appvDocClass, appvDocType, docStatus){
		$("#appvDocId").val(appvDocId);
		$("#appvDocClass").val(appvDocClass);
		$("#appvDocType").val(appvDocType);
		$("#docStatus").val(docStatus);
		<c:if test="${listType eq 'draft' }">
		$("#frm").attr("action",contextRoot+"/approve/getApproveDrfDetail.do").submit();
		</c:if>
		<c:if test="${listType eq 'temp' }">
		$("#frm").attr("action",contextRoot+"/approve/getApproveTempDetail.do").submit();
		</c:if>
	}
	//승인 반려 일괄처리
	function processDocSubmitAll(){

		if($("input[name='chkedDoc']:checked").length == 0){
			alert("최소 한건 이상 선택해 주세요.");
			return;
		}

		if(confirm("선택하신 품의서를 [상신] 하시겠습니까?")){
			$("#frm").attr("action",contextRoot+"/approve/processDraftDocSubmitAll.do");
			commonAjaxSubmit("POST",$("#frm"),processDocStatusAllCallback);
		}
	}
	//
	function processDocStatusAllCallback(data){
		if(data.resultObject.result =="SUCCESS"){//성공 메세지가 바뀌는 상황에 구현한다.
			alert("선택하신 품의서가 상신 되었습니다.");
			$("#frm").attr("action",contextRoot+"/approve/tempDocList.do").submit();
		}else{
			alert("저장에 실패했습니다. 담당자에게 문의해 주세요.");
		}
	}
</script>
