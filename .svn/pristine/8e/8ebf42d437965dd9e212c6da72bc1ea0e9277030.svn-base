<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!-- 결재라인 -->
<input type="hidden" id = "lineSize" value="${fn:length(approveLineMap) }">
<ul class="app_step_list3">
	<c:forEach var="data" items="${approveLineMap }" varStatus="i">
		<c:if test="${data.appvSeq ne preAppvSeq}">
			</li>
		</c:if>

		<c:if test="${data.appvSeq eq preAppvSeq}">
                              &nbsp;,&nbsp;
                          </c:if>
		<c:if test="${data.appvSeq ne preAppvSeq}">
			<li
				<c:if test = "${i.index eq (lineSize-1)}">class='finish_line'</c:if>>
		</c:if>

		<c:if test="${data.appvAssignNm ne '' and data.appvAssignNm ne null}">
			<c:if test="${data.appvStatus eq 'REQ'}">
				<U>
					<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.appvAssignId}",$(this),"mouseover",null,5,-80,80)'>
           				<B>${data.appvAssignNm}</B>
           			</span>
				</U>
			</c:if>
			<c:if test="${data.appvStatus ne 'REQ'}">
				<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.appvAssignId}",$(this),"mouseover",null,5,-80,80)'>
       				${data.appvAssignNm}
       			</span>
			</c:if>
                              (${data.deptNm}/${data.rankNm})
        </c:if>

		<c:set var="preAppvSeq" value="${data.appvSeq}"></c:set>
	</c:forEach>
</ul>
