<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//유저프로필 이벤트 셋팅
	initUserProfileEvent();
});
//검색
function linkPage(pageNo){
	$("#pageIndex").val(pageNo);
	$("#frm").attr("action",contextRoot+"/approve/getApproveCompanyAjax.do");
	commonAjaxSubmit("POST",$("#frm"),searchCallback);
}

// 검색 콜백
function searchCallback(data){
	$("#listArea").html(data);

	//유저프로필 이벤트 셋팅
	initUserProfileEvent();
}

//작성 페이지 이동
function goCreatePage(appvCompanyFormId,approveLineType,appvLineHeaderCnt){

	if(approveLineType!="INPUT"&&appvLineHeaderCnt==0){
		alert("결재라인 설정이 필요합니다.\n사내매니저에게 설정을 요청해주십시오.");
		return;
	}

	$("#appvCompanyFormId").val(appvCompanyFormId);
	$("#frm").attr("action", contextRoot + "/approve/reqCompany.do").submit();
}
</script>
