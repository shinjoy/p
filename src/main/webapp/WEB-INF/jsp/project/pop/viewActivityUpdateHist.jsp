<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>
<div class="mo_container">
<form name="activityHistViewForm" id = "activityHistViewForm" method="post">
	<input type="hidden" id = "activityId" name = "activityId" value="${activityId }">
	<div id = "listArea">
		<jsp:include page="../include/viewActivityUpdateHist_INC.jsp"></jsp:include>
	</div>
</form>
<!--버튼영역-->
<div class="btn_baordZone">
	<!--  <a href="javascript:moveApproveProductPage()" class="btn_blueblack btn_auth">결재품의작성</a> -->

	<a href="javascript:parent.myModal2.close()" class="btn_witheline btn_auth">닫기</a>


</div>
</div>
<!--//버튼영역//-->
<script type="text/javascript">
function activityViewLinkPage(pageNo){

	$("#pageIndex").val(pageNo);
	$("#activityHistViewForm").attr("action",contextRoot+"/project/viewActivityUpdateHistAjax.do");
	commonAjaxSubmit("POST",$("#activityHistViewForm"),activityViewLinkPageCallback);
}

function activityViewLinkPageCallback(data){
	$("#listArea").html(data);
}
</script>
