<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		//linkPage(1);
		moveTab('monthList');
	});

	function moveTab(type){
        $("#actionType").val(type);

        if(type == 'yearList') {
            $("#monthListLi").removeClass();
            $("#yearListLi").addClass("current");
            $("#searchMonth").val("All");
        }else{
            $("#yearListLi").removeClass();
            $("#monthListLi").addClass("current");
            $("#searchMonth").val("");
        }
         linkPage(1);
    }

	//검색
    function linkPage(pageNo){
        $("#pageIndex").val(pageNo);

        var url = contextRoot+"/worktime/user/attendanceInfoMonthListAjax.do";
        if($("#actionType").val() == 'yearList') {
        	url=contextRoot+"/worktime/user/attendanceInfoYearListAjax.do";
        }else{
        	url=contextRoot+"/worktime/user/attendanceInfoMonthListAjax.do";
        }
        $("#frm").attr("action",url);
        commonAjaxSubmit("POST",$("#frm"),searchCallback);
    }

    // 검색 콜백
    function searchCallback(data){
        $("#selTapArea").html(data);
    }

	//근태현황(월 조회)
	function searchForMonth(searchMonth){
		$("#searchMonth").val(searchMonth);
		linkPage(1);
	}

	//왼쪽트리 전체 조직 선택시
    function searchAllOrg(){
    	$("#searchDeptId").val("");
        linkPage(1);
    }

	//출근인정요청 팝업호출
    function openAttendanceApprovReq(worktimeId){
        var url = "<c:url value='/worktime/user/attendanceApprovReqPopup.do'/>" + "?worktimeId="+worktimeId;
        window.open(url, 'attendanceApproReq','resizable=no,width=650,height=350,scrollbars=yes');
    }

	//화면재로딩
	function openPage(){
		linkPage(1);
	}
</script>

