<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!--비상시프로젝트 전체-->
<ul id="sortable_task">
	<c:forEach items="${myProjectList }" var="data" varStatus="sort">
		<li class="ui-state-default" id = "dragTarget_${data.projectId}_${data.period}">
			<input type="hidden" id = "projectId" name = "projectId" value="${data.projectId}">
			<!--프로젝트01-->
			<div class="task_proSet">
				<h3 class="h3_title_basic" style="cursor: pointer;">${data.name }
					<a href="javascript:showProjectDetailPop('${data.projectId }')" class="btn_s_type3 mgl15">
						<em class="icon_info">
						${baseUserLoginInfo.projectTitle} 정보
						</em>
					</a>
					<c:if test="${not empty data.sort }">
						<span style="display: none;"></span>
					</c:if>
					<c:if test="${not empty data.projectSort}">
						<span id="capSearch_${data.projectId }" class="sub_desc">(우선순위 : ${data.projectSort} )</span>
					</c:if>
				</h3>
				<table class="tb_list_basic2" summary="결재문서함 요약 (문서함 구분, 진행중, 반려, 완료)" id = "activityDtTable_${data.projectId }">
					<caption>
						결재문서함 요약
					</caption>
					<colgroup>
						<col width="*" />
						<col width="*" />
						<col width="*" />
						<col width="*" />
						<col width="70" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">단위업무명</th>
							<th scope="col">업무일지<a href="javascript:movePage('WORK')" class="btn_s_type_blue2 mgl10">바로가기</a></th>
							<th scope="col">전자결재<a href="javascript:movePage('APPROVE')" class="btn_s_type_blue2 mgl10">바로가기</a></th>
							<th scope="col" colspan="2">기간</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
			<!--//프로젝트01//-->
		</li>
	</c:forEach>
</ul>
<!--//비상시프로젝트 전체//-->

<c:if test="${fn:length(myProjectList)<=0 }">
<dd class="pro_historyList">
	<div class="nocontents">조회 내용이 없습니다.</div>
</dd>
</c:if>