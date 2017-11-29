<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="./js/approveDocNumList_JS.jsp" %>

<c:set var="appvDocNumRuleDateEX" value=""/>
<c:set var="appvDocNumRuleSeqEX" value=""/>
<section id="detail_contents">
	<form id = "frm" name = "frm">
		<div id = "listArea">
			<jsp:include page="./include/approveDocNumList_INC.jsp"></jsp:include>
		</div>
	</form>
	<!--버튼영역-->
	<div class="btn_baordZone2">
	    <a href="javascript:doSave();" class="btn_blueblack btn_auth">저장</a>
	    <a href="javascript:doReset();" class="btn_witheline btn_auth">취소</a>
	</div>
	<!--//버튼영역//-->
</section>
