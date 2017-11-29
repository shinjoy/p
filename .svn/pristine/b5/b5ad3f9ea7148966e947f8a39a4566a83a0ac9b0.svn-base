<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
	//날짜이동
	function moveWeekNum(type){
		$("#weekType").val(type);

		$("#schePopFrm").attr("action",contextRoot+"/approve/getAppvScheduleListPopAjax.do");
		commonAjaxSubmit("POST",$("#schePopFrm"),moveWeekNumCallback);
	}
	//날짜이동 콜백
	function moveWeekNumCallback(data){
		$("#weepPopArea").html(data);
		parent.myModal.resize();
	}
	//일정등록팝업
	function scheAdd(){
	   var SelDate =$("#startStr").val();
       var url = "${pageContext.request.contextPath}/scheduleProc.do?EventType=Add&ParentPage=approve&ScheSDate="+SelDate;
       var option = "left=" + (screen.width > 1400?"700":"0") + ", top=" + (screen.height > 810?"100":"0") + ", width=900, height=860, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=no";
       schedulePopup = window.open(url, "_blank", option);

	}

	//스케쥴 등록후 콜백
	function openPageReload(){
		moveWeekNum("RELOAD");
	}
</script>
<div class="mo_container" id = "weepPopArea">
	<jsp:include page="../include/appvScheduleListPop_INC.jsp"></jsp:include>
</div>
