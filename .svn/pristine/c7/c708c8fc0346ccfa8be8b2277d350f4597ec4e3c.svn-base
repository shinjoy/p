<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
	var comDocStatusType = getBaseCommonCode('DOC_STATUS', null, 'CD', 'NM', '', '전체','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
	var colorObj = {};
	$(document).ready(function(){
		var docStatusTypeTag = createSelectTag('searchDocStatus', comDocStatusType, 'CD', 'NM', '${searchMap.searchDocStatus}', null, colorObj, '', 'search_type2');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
		$("#searchDocStatusTag").html(docStatusTypeTag);

		$("#searchDocStatusTag option").each(function(){
			var value = $(this).val();
			if(value!="" && value.indexOf("CNL_")<0){
				$(this).remove();
			}
		})

		//유저프로필 이벤트 셋팅
		initUserProfileEvent();
	});
	//검색
	function linkPage(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action",contextRoot+"/approve/reqCancelListAjax.do");
		commonAjaxSubmit("POST",$("#frm"),searchCallback);
	}

	// 검색 콜백
	function searchCallback(data){
		$("#listArea").html(data);

		//유저프로필 이벤트 셋팅
		initUserProfileEvent();
	}

	//상세화면으로 이동
	function goDetailPage(appvDocId,appvDocClass, appvDocType, docStatus){
		$("#appvDocId").val(appvDocId);
		$("#appvDocClass").val(appvDocClass);
		$("#appvDocType").val(appvDocType);
		$("#docStatus").val(docStatus);
		$("#frm").attr("action",contextRoot+"/approve/getApproveCancelDetail.do").submit();
	}
</script>
