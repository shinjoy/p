<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<%@ include file="./js/projectStatisList_JS.jsp" %>

<input type="hidden" id="searchOrgId" name="searchOrgId" value="${baseUserLoginInfo.applyOrgId }"/>
<input type="hidden" name = "searchDeptId"  id = "searchDeptId" value="" />

<!-- <form id="frm" name="frm"> -->

<div class="verticalWrap">
    <!-- ======================================= 왼쪽 메뉴 :S ======================================== -->
	<jsp:include page="../common/projectDeptTree.jsp"></jsp:include>
    <!-- ======================================= 왼쪽 메뉴 :E ======================================== -->

	<section id="detail_contents">
	<!-- 내용영역(프로젝트전체/액티비티전체/업무일지전체) -->
	<div id="projectTopArea">
		<jsp:include page="./include/projectStatisTopList_INC.jsp"></jsp:include>
	</div>

	<!--//내용영역(프로젝트전체/액티비티전체/업무일지전체)//-->

	<br>

	<input type="hidden" id="kindType" value="A"/>
	<input type="hidden" id="deptId"/>
	<input type="hidden" id="searchUserId"/>
	<input type="hidden" id="choiceMonth"/>
	<input type="hidden" id="projectId"/>
	<input type="hidden" id="hdTeamRate" value=""/>
	<input type="hidden" id="hdPrivateRate" value=""/>
	<input type="hidden" id="employee"/>
	<input type="hidden" id="projectName"/>
	<!-- <input type="hidden" id="choiceYear"/> -->
	<!-- 검색영역 -->
	<div class="carSearchBox withcal" id="searchArea">
		<div class="blocktype mgr10">
			<span id="yearDiv"></span><!-- 년도 -->
			<span class="carSearchtitle"><label for="choiceYear">년도선택</label></span>
			<span id="yearArea"></span>
			<span id="monthDiv" class="btn_monthZone mgl10"></span><!-- 월 -->
		</div>
		<div class="blocktype">
			<span class="carSearchtitle">기간조회</span>
			<input type="text" id="startDate" class="input_date_type input_b mgl5" readonly="readonly"/>
			<a href="#" onclick="$('#startDate').datepicker('show');return false;" class="icon_calendar"><em>날짜선택</em></a>
			<span class="dashLine">~</span>
			<input type="text" id="endDate" class="input_date_type input_b mgl5" readonly="readonly"/>
			<a href="#" onclick="$('#endDate').datepicker('show');return false;" class="icon_calendar"></a>
			<button type="button" name="reg_btn" class="btn_g_black mgl10" onclick="clickSearch();">조회</button>
		</div>
	</div>
	<!--//검색영역//-->

	<!-- 내용영역(부서별/개인별) -->
	<div id="projectBottomArea">
		<jsp:include page="./include/projectStatisBottomList_INC.jsp"></jsp:include>
	</div>
	<!--//내용영역//-->
	</section>
</div>

<!-- </form> -->
