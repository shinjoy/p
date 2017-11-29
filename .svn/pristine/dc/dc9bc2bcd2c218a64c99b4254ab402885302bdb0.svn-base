<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
//검색
function linkPage(pageNo){
	$("#pageIndex").val(pageNo);
	$("#projectPopFrm").attr("action",contextRoot+"/approve/getAppvProjectListPopAjax.do");
	commonAjaxSubmit("POST",$("#projectPopFrm"),searchCallback);
}

// 검색 콜백
function searchCallback(data){
	$("#listArea").html(data);
	parent.myModal.resize();
}
</script>
<div class="mo_container">
	<form id = "projectPopFrm" name = "projectPopFrm">
		<div id = "listArea">
			<jsp:include page="../include/appvProjectListPop_INC.jsp"></jsp:include>
		</div>
		<div class="btnZoneBox"><a href="javascript:parent.myModal.close()" class="p_withelin_btn">취소</a></div>
		<!--//검색결과有//-->
	</form>
</div>
<div style="height: 10px;"></div>
