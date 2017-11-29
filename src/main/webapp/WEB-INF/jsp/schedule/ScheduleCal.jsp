<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="./js/ScheduleCal_JS.jsp"%>

<div class="wrap-loading display-none">
    <div><img src="${pageContext.request.contextPath}/images/ajax_loading.gif" /></div>
</div>

<form name="scheduleCal" id="scheduleCal" method="post">
<input type="hidden" name="SelDate"           id="SelDate"/>
<input type="hidden" name="PerSabun"          id="PerSabun"       value="${baseUserLoginInfo.empNo}"/>
<input type="hidden" name="RegPerSabun"       id="RegPerSabun"    value="${baseUserLoginInfo.empNo}"/>
<input type="hidden" name="SelYear"           id="SelYear"        value="${dateVO.selYear}"/>
<input type="hidden" name="SelMonth"          id="SelMonth"       value="${dateVO.selMonth}"/>
<input type="hidden" name="ScheGubun"         id="ScheGubun"      value="${vo.scheGubun}"/>
<input type="hidden" name="searchPerSabun"    id="searchPerSabun" value="${vo.searchPerSabun}"/>
<input type="hidden" name="ScheSYear"         id="ScheSYear"/>
<input type="hidden" name="ScheSMonth"        id="ScheSMonth"/>
<input type="hidden" name="ScheSDay"          id="ScheSDay"/>

<input type="hidden" name="nowYear"           id="nowYear"        value="${dateVO.nowYear}"/>
<input type="hidden" name="nowMonth"          id="nowMonth"       value="${dateVO.nowMonth}"/>

<input type="hidden" name="searchScheSDate"   id="searchScheSDate"/>
<input type="hidden" name="startDate"   id="startDate"/>
<input type="hidden" name="endDate"   id="endDate"/>

<input type="hidden" name="searchOrgId"   id="searchOrgId"  value="${baseUserLoginInfo.applyOrgId }"/>

<div class="verticalWrap">
	<!-- ======================================= 왼쪽 메뉴 :S ======================================== -->
	<div class="addAreaZone">
	    <div id="userListAreaTree"></div>
	</div>
	<!-- ======================================= 왼쪽 메뉴 :E ======================================== -->
	<section id="detail_contents">
		<!-- ======================================= 검색조건 :S ======================================== -->
		<!--캘린더버튼-->
        <div class="fc_toolbar">
            <div class="fc_left mgl20">
                <span id="projectTag">
	                <select id="projectId" name="projectId" class="select_b"  title="${baseUserLoginInfo.projectTitle}">
	                    <option value="">${baseUserLoginInfo.projectTitle } 선택</option>
	                </select>
	             </span>
	             <span id="activityTag">
	                <select id="activityId" name="activityId" class="select_b mgl6"  title="${baseUserLoginInfo.activityTitle}">
	                    <option value="">${baseUserLoginInfo.activityTitle } 선택</option>
	                </select>
	            </span>
            </div>
            <div class="fc_right"><a href="javascript:moveToday();" class="btn_today mgr20">TODAY</a></div>
            <div class="fc_center">
                <a href="javascript:moveCalendar(-1);" class="btn_arrow">&lt;</a>
                <span id="spanSearchMonth">${dateVO.selYear}년 ${dateVO.selMonth}월<em> - ${dateVO.selMonth}.01(${dateVO.startWeek}) ~ ${dateVO.selMonth}.${dateVO.endDay}(${dateVO.endWeek})</em></span>
                <a href="javascript:moveCalendar(1);" class="btn_arrow">&gt;</a>
            </div>
        </div>
        <!--/캘린더버튼/-->
		<!-- ======================================= 검색조건 :E ======================================== -->

	    <!-- ======================================= 본문 :S ======================================== -->
	    <div id = "listArea">
            <jsp:include page="./include/scheduleCal_contents_INC.jsp"></jsp:include>
        </div>
	    <!-- ======================================= 본문 :E ======================================== -->
	</section>
</div>
</form>