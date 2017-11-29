<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<%@ include file="./js/attendanceInfo_JS.jsp"%>

<form id = "frm" name = "frm">
<input type="hidden" name = "pageIndex"  id = "pageIndex" value="${paginationInfo.currentPageNo }" />
<input type="hidden" name = "searchDeptId"  id = "searchDeptId" value="${searchDeptId}" />

<input type="hidden" name = "actionType"  id = "actionType" value="${actionType}" />

<section id="detail_contents">
    <!--tab영역-->
    <ul class="tabZone_st03">
        <li id = "monthListLi" class="current"><a href="javascript:moveTab('monthList')">근태현황 (월)</a></li>
        <li id = "yearListLi"><a href="javascript:moveTab('yearList')">근태현황 (전체보기)</a></li>
        <%--<li><a href="/support_m/attendance_manage_tab3.jsp">근태현황 (년)</a></li>--%>
    </ul>
    <!--//tab영역//-->
	<div id = "selTapArea">
		<%-- <jsp:include page="./include/attendanceMgmt_dayList_INC.jsp"></jsp:include> --%>
	</div>
</section>
</form>
