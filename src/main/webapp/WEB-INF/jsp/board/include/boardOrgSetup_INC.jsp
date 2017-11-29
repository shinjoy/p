<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>

<div class="doc_AllWrap">


	<c:forEach items="${cateList}" var="data" varStatus="i">
		<h3 class="h3_title_basic mgt20">
	    <span>${i.index+1}. ${data.cboardName}</span>
	    <a class="s_violet01_btn mgl15" href="javascript:openEmpPopup(${data.cboardId});"><em>직원선택</em></a>
		</h3>
		<p class="notice_script">* 해당 게시판 내용을 승인하는 담당자를 지정하는 기능으로 승인자는 1인만 지정 가능 합니다.</p>
		<article class="paymentsetBox">
			<div class="gray_notibox" id="userArea_${data.cboardId}">
		    	<c:if test="${data.staffUserId ne ''}">
				    <span class="employee_list">
			    	<span>${data.staffUserNm}<em>(${data.position})</em></span><a href="javascript:;" onclick="deleteEmp(this);" class="btn_delete_employee"><em>삭제</em></a>
			    	<input type="hidden" name="arrUserId" targetCateId ="${data.cboardId}" id="arrUserId_${data.cboardId}" value="${data.staffUserId}">
			    	</span>
		    	</c:if>
		    </div>
	    </article>
	</c:forEach>

	<div class="btn_baordZone2">
		<a href="javascript:;" onclick="doSaveOrgSetup();" class="btn_blueblack btn_auth">저장</a>
	</div>

</div>