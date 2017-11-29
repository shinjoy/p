<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<%@ include file="./js/cardExpenseSetting_JS.jsp" %>

<section id="detail_contents">
	<form id = "tabFrm" name = "tabFrm">
		<input type="hidden" name="actionType" id="actionType" value="${actionType}" />
	</form>
    <!--tab영역-->
    <ul class="tabZone_st03" id="moveTabArea">
		<li id="expenseLi" class="current"><a href="javascript:moveTab('expense')">지출 입력 설정</a></li>
		<li id="corporationCardLi"><a href="javascript:moveTab('corporationCard')">법인카드 설정</a></li>
    </ul>
    <br/>
    <!--//tab영역//-->

    <!-- <input type="hidden" name="actionType" id="actionType" value="${actionType}" /> -->
    <div id = "expenseBodyArea">
    	<jsp:include page="./include/cardExpenseSetting_INC.jsp"></jsp:include>
    </div>
</section>
