<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!--결재문서함-->
<table class="tb_list_basic" summary="기안문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)">
	<caption>기안문서함 목록</caption>
	<colgroup>
		<col width="110" />
		<col width="80" />
		<col width="180" />
		<col width="*" />
		<col width="120" />
		<col width="100" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">등록일</th>
			<th scope="col">구분 </th>
			<th scope="col">문서번호</th>
			<th scope="col">제목 </th>
			<th scope="col">등록자</th>
			<th scope="col">취소진행상황</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${cancelDocList}" var = "data">
			<tr onclick="goDetailPage('${data.appvDocId }','${data.appvDocClass }','${data.appvDocType }','${data.docStatus }')">
				<td class="num_date_type"><fmt:formatDate value="${data.createDate }" pattern="yyyy-MM-dd" /></td>
				<td class="e_doc_type">${data.appvDocTypeNm }</td>
				<td class="e_doc_type">${data.appvDocNum }</td>
				<td class="txt_doc_title">
						${data.title }
					<c:if test="${data.commentCnt >0}">
						<span class="ripple">(${data.commentCnt })</span>
					</c:if>
				</td>
				<td class="doc_writer">
					<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.userId }",$(this),"mouseover",null,5,-200,200)'>
						${data.userNm }
					</span>
				</td>
				<td class="app_state">
					<c:choose>
						<c:when test="${data.docStatus eq null }"><span class="icon st_predoc"></c:when>
						<c:when test="${data.docStatus eq 'CNL_SUBMIT' }"><span class="icon st_request"></c:when>
						<c:when test="${data.docStatus eq 'CNL_REJECT' }"><span class="icon st_reject"></c:when>
						<c:when test="${data.docStatus eq 'CNL_COMMIT' }"><span class="icon st_finish"></c:when>
					</c:choose>
					${data.docStatusNm }
					</span>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(cancelDocList)<=0 }">
			<tr>
				<td colspan="6" class="no_result">
					<p class="nr_des">조회된 데이터가 없습니다.</p>
				</td>
			</tr>
		</c:if>
	</tbody>
</table>
<!--//결재문서함//-->
<!--페이지목록-->
<div class="btnPageZone">
	<ui:pagination paginationInfo="${paginationInfo}" type="ib" jsFunction="linkPage" />
</div>
<input type="hidden" name = "pageIndex" id = "pageIndex" value="${paginationInfo.currentPageNo }">
<!--//페이지목록//-->
<script type="text/javascript">
	$("#totalCnt").text("${paginationInfo.totalRecordCount }");
</script>