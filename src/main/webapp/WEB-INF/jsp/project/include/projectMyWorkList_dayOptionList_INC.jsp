<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:forEach items="${dayList }" var="data">
	<div id = "dayOption_${data.key }" style="display: none;">
		<c:forEach var = "day" begin="1" end="${data.value }">
			<option value="${day }">${day<10?'0':'' }${day }</option>
		</c:forEach>
	</div>
</c:forEach>
	<!--날짜선택-->
	<div class="carSearchBox">
		<span class="carSearchtitle"><label for="choiceYear">날짜선택</label></span>
		<button type="button" class="btn_arrow_calleft mgl10" onclick="selectDay('PREV')"><em>이전</em></button>
		<select class="select_b w_date mgr3" id = "searchYear" name = "searchYear" onchange="selectYear()">
			<option value="2017" <c:if test = "${searchYear eq '2017'}">selected="selected"</c:if>>2017</option>
			<option value="2018" <c:if test = "${searchYear eq '2018'}">selected="selected"</c:if>>2018</option>
			<option value="2019" <c:if test = "${searchYear eq '2019'}">selected="selected"</c:if>>2019</option>
			<option value="2020" <c:if test = "${searchYear eq '2020'}">selected="selected"</c:if>>2020</option>
		</select>
		<span>년</span>
		<select class="select_b w_monthday mgr3 mgl6" onchange="selectMonth()" id = "searchMonth" name = "searchMonth">
			<c:forEach items="${dayList }" var="data">
				<option value="${data.key}" <c:if test = "${data.key eq searchMonth}">selected="selected"</c:if> >${data.key<10?'0':'' }${data.key }</option>
			</c:forEach>
		</select>
		<span>월</span>
		<select class="select_b w_monthday mgr3 mgl6" id = "searchDate" name = "searchDate" onchange="doSearch()">
			<c:forEach items="${dayList }" var="data">
				<c:if test = "${data.key eq searchMonth}">
					<c:forEach var = "day" begin="1" end="${data.value }">
						<option value="${day }" <c:if test = "${day eq searchDate}">selected="selected"</c:if>>${day<10?'0':'' }${day }</option>
					</c:forEach>
				</c:if>
			</c:forEach>
		</select>
		<span>일</span>
		<button type="button" class="btn_arrow_calright"  onclick="selectDay('NEXT')"><em>다음</em></button>
	<!-- 	<div class="btnRightZone">
			<button name="reg_btn" class="btn_b2_skyblue" onClick="javascript:excelDownDayList();return false;"><em class="icon_XLS">파일로 저장</em></button>
		</div> -->
	</div>
	<!--//날짜선택//-->