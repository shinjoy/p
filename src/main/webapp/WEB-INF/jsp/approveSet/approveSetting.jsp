<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="./js/approveSetting_JS.jsp" %>

<c:set var="appvDocNumRuleDateEX" value=""/>
<c:set var="appvDocNumRuleSeqEX" value=""/>
<section id="detail_contents">
    <!--tab영역-->
    <ul class="tabZone_st03" id = "moveTabArea">
        <li id = "receiverLi" class="current"><a href="javascript:moveTab('receiver')">필수 수신/참조자 세팅</a></li>
        <li id = "readLi"><a href="javascript:moveTab('read')">종결전 문서열람 세팅</a></li>
        <li id= "expenseLi"><a href="javascript:moveTab('expense')">지출결의서 세팅</a></li>
        <li id= "pendLi"><a href="javascript:moveTab('pend')">미결알림 세팅</a></li>
    </ul>
   	<!--//tab영역//-->
	<form id = "frm" name = "frm">
	    <input type="hidden" name = "actionType"  id = "actionType" value="${actionType}" />
		<div id = "listArea">
			<jsp:include page="./include/approveSetting_receiver_INC.jsp"></jsp:include>
		</div>
	</form>

</section>
