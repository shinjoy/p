<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<ul >
<c:if test = "${paginationInfo.currentPageNo<2 }">
		<li class="projectTreeContentsArea"   id = "projectTreeLi_0">
			<span id = "projectTreeSpan_0">
				<a href = "javascript:##projectDeptTreeProjectReturnFnc##('0');projectTreeSelect('0');">전체</a>
			</span>
		</li>
</c:if>

<c:forEach items="${projectTreeList }" var="data" varStatus="status">
    <c:if test="${status.index eq 0}">
        <input type="hidden" id="firstProjectId" name="firstProjectId"  value="${data.projectId }"/>
        <input type="hidden" id="firstProjectName" name="firstProjectName"  value="${data.name }"/>
        <input type="hidden" id="firstProjectEmployee" name="firstProjectEmployee"  value="${data.employee }"/>
    </c:if>
	    <li class="projectTreeContentsArea"  id = "projectTreeLi_${data.projectId }">
			<span id = "projectTreeSpan_${data.projectId }">
				<a href = "javascript:##projectDeptTreeProjectReturnFnc##('${data.projectId }' , '${data.name }', '${data.employee }');projectTreeSelect('${data.projectId }');">${data.name }(${data.projectCode })</a>
			</span>
        </li>
</c:forEach>
<li>&nbsp;</li>
<div class="btnPageZone">
	<ui:pagination paginationInfo="${paginationInfo}" type="ib" jsFunction="selectProjectDeptTreeProject" />
</div>
