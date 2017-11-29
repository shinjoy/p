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
	$("#frm").attr("action",contextRoot+"/approve/getApproveCompanyFormListAjax.do");
	commonAjaxSubmit("POST",$("#frm"),searchCallback);
}

// 검색 콜백
function searchCallback(data){
	$("#listArea").html(data);

	//유저프로필 이벤트 셋팅
	initUserProfileEvent();
}


//서식 생성 페이지 이동
function moveCompanyCreatePage(){
	$("#frm").attr("action",contextRoot+"/approve/createApproveCompanyForm.do").submit();
}

//사내서식 수정/상세 페이지 이동
function goDetailPage(appvCompanyFormId){
	$("#appvCompanyFormId").val(appvCompanyFormId);
	$("#frm").attr("action" , contextRoot + "/approve/processApproveCompanyForm.do").submit()
}
</script>
