<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<%@ include file="./js/attendanceMgmt_JS.jsp"%>

<form id = "frm" name = "frm">
<input type="hidden" name = "pageIndex"  id = "pageIndex" value="${paginationInfo.currentPageNo }" />
<input type="hidden" name = "searchDeptId"  id = "searchDeptId" value="" />
<input type="hidden" name = "actionType"  id = "actionType" value="${actionType}" />

<input type="hidden" name = "pageType"  id = "pageType" value="${pageType}" />
<input type="hidden" name = "searchUserId"  id = "searchUserId" value="" />
<input type="hidden" name = "viewAuth"  id = "viewAuth"" value="${viewAuth}" />

<input type="hidden" name = "userArr"  id = "userArr" value="" />
<input type="hidden" name = "targetOrgId"  id = "targetOrgId"" value="" />

<div class="verticalWrap" id = "wrapArea">

    <!-- ======================================= 왼쪽 메뉴 :S ======================================== -->
    <div class="addAreaZone" id = "userTreeArea"></div>
    <!-- ======================================= 왼쪽 메뉴 :E ======================================== -->

	<section id="detail_contents">
		<!--tab영역-->
		<ul class="tabZone_st03" id = "moveTabArea">
			<li id = "dayListLi" class="current"><a href="javascript:moveTab('dayList')">근태현황 (일)</a></li>
			<li id = "monthListLi"><a href="javascript:moveTab('monthList')">근태현황 (월/년)</a></li>
			<c:if test="${pageType eq 'MGMT'}">
			    <li id= "excelListLi"><a href="javascript:moveTab('excelList')">근태일괄관리</a></li>
			</c:if>
		</ul>
		<!--//tab영역//-->
		<div id = "selTapArea">
			<jsp:include page="./include/attendanceMgmt_dayList_INC.jsp"></jsp:include>
		</div>
	</section>
</div>
</form>

<form id = "frmYearPop" name = "frmYearPop">
    <input type="hidden" name = "searchYear"  id = "searchYear"  value="${searchYear}" />
    <input type="hidden" name = "searchMonth"  id = "searchMonth"  value="${searchMonth}" />
    <input type="hidden" name = "searchUserId"  id = "searchUserId"  value="${searchUserId}" />
</form>
