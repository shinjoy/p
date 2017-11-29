<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">

$(document).ready(function(){
	var refDocIdArr = parent.getRefDocIdArr();

	for(var i = 0 ; i < refDocIdArr.length ; i ++){
		var stStr = "<input type = 'hidden' name = 'refDocStr' value = '"+refDocIdArr[i]+"'>";
		$("#selRefDocListArea").append(stStr);
	}
});
//검색
function linkPage(pageNo){
	$("#pageIndex").val(pageNo);
	$("#refDocPopFrm").attr("action",contextRoot+"/approve/getApproveRefDocPopAjax.do");
	commonAjaxSubmit("POST",$("#refDocPopFrm"),searchCallback);
}

// 검색 콜백
function searchCallback(data){
	$("#listArea").html(data);
	parent.myModal.resize();
}

//선택버튼 클릭
function selRefDoc(){
	parent.openApproveRefDocPopFinish();
	$("input[name = 'refDocStr']").each(function(){
		parent.openApproveRefDocPopCallback($(this).val());
	});
	parent.openApproveRefDocPopFinishEnd();

	parent.myModal.close();
}

//상세팝업 노출
function openAppvDetailPop(appvDocId){
	$("#appvDocId").val(appvDocId);
	var option = "width=898px,height=800px,resizable=yes,scrollbars = yes";
    commonPopupOpen("approveDetailPop",contextRoot+"/approve/getApproveDrfDetail.do",option,$("#refDocPopFrm"));
}
</script>
<div class="mo_container">
	<form id = "refDocPopFrm" name = "refDocPopFrm">
		<input type="hidden" id = "appvDocId" name = "appvDocId">
		<input type="hidden" id = "approveDetailPopYn" name = "approveDetailPopYn" value="Y">
		<div id = "listArea">
			<jsp:include page="../include/approveRefDocPop_INC.jsp"></jsp:include>
		</div>
		<div class="btnZoneBox">
			<a href="javascript:selRefDoc()" class="p_blueblack_btn">선택</a>
			<a href="javascript:parent.myModal.close()" class="p_withelin_btn">취소</a>
		</div>
		<!--//검색결과有//-->
	</form>
</div>
<div style="display: none;" id = "selRefDocListArea">

</div>
<div style="height: 10px;"></div>
