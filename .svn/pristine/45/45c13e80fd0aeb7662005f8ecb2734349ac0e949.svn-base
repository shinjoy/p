<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!--검색결과有-->
<table class="tb_list_basic" summary="알림내용 (알림날짜, 분류, 사원선택, 알림타입, 내용)">
	<caption>알림내용</caption>
	<colgroup>
		<col width="80"> <!--구분-->
		<col width="*"> <!--프로젝트명-->
		<col width="*"> <!--유형-->
		<col width="*"> <!--설명-->
		<col width="160"> <!--기간-->
		<col width="60"> <!--상태값-->
		<col width="80"> <!--등록일-->
		<col width="60"> <!--등록자-->
	</colgroup>
	<thead>
		<tr>
			<th scope="col">구분</th>
			<th scope="col">${baseUserLoginInfo.projectTitle }명</th>
			<th scope="col">유형</th>
			<th scope="col">설명</th>
			<th scope="col">기간</th>
			<th scope="col">상태값</th>
			<th scope="col">등록일</th>
			<th scope="col">등록자</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${appvProjectList }" var = "data">
			<tr onclick="parent.openApproveProjectPopCallback('${data.projectId}','${data.name }<span>(${data.projectCode })</span>')">
				<th scope="row">${data.employeeNm }</th>
				<td class="txt_left">
					<c:if test="${data.openFlag eq 'Y' }">
						<span class="icon_secret mgr6"><em>비공개</em></span>
					</c:if>
					${data.name }<span>(${data.projectCode })</span>
				</td>
				<td>${data.projectTypeNm }</td>
				<td>${data.description }</td>
				<td class="num_date_type">
					<c:choose>
						<c:when test="${data.period eq 'Y'}">${data.startDate } ~ ${data.endDate }<br>(마감일:${data.closeDate })</c:when>
						<c:otherwise><b>무기한</b> (상시업무)</c:otherwise>
					</c:choose>
				</td>
				<td>${data.projectStatusNm }</td>
				<td class="num_date_type">${data.createDate }</td>
				<td>${data.createNm }</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(appvProjectList) <=0}">
			<td class="no_result" colspan="8">조회된 데이터가 없습니다.</td>
		</c:if>
	</tbody>
</table>
<!--게시판페이지버튼-->
<div class="btnPageZone">
	<ui:pagination paginationInfo="${paginationInfo}" type="ib" jsFunction="linkPage" />
</div>
<!--//게시판페이지버튼//-->
<input type="hidden" name = "pageIndex" id = "pageIndex" value="${paginationInfo.currentPageNo }">
