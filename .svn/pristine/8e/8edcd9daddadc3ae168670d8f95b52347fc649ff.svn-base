<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!--결재문서함-->
	<table class="tb_list_basic" summary="결재문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)" id = "listTable">
		<caption>결재문서함 목록</caption>
		<colgroup>
			<col width="*" />
			<col width="*" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="100" />
			<col width="120" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">문서타입</th>
				<th scope="col">구분</th>
				<th scope="col">상태</th>
				<th scope="col">삭제여부</th>
				<th scope="col">수정자</th>
				<th scope="col">등록자</th>
				<th scope="col">등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${companyFormList }" var = "data">
				<tr>
					<td class="e_doc_type"  onclick="goDetailPage('${data.appvCompanyFormId }')">${data.appvDocTypeName }</td>
					<td class="e_doc_type"  onclick="goDetailPage('${data.appvCompanyFormId }')">${data.appvDocNumRuleMidName }</td>
					<td class="e_doc_type"  onclick="goDetailPage('${data.appvCompanyFormId }')">${data.openYn eq 'Y'?'공개':'비공개' }</td>
					<td class="e_doc_type"  onclick="goDetailPage('${data.appvCompanyFormId }')">${data.deleteFlag eq 'Y'?'삭제':'-' }</td>

					<td class="doc_writer"  onclick="goDetailPage('${data.appvCompanyFormId }')">
						<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.updatedBy }",$(this),"mouseover",null,5,-200,200)'>
							${data.updatedNm }
						</span>
					</td>

					<td class="doc_writer"  onclick="goDetailPage('${data.appvCompanyFormId }')">
						<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.createdBy }",$(this),"mouseover",null,5,-200,200)'>
							${data.createdNm }
						</span>
					</td>
					<td class="num_date_type"  onclick="goDetailPage('${data.appvCompanyFormId }')"><fmt:formatDate value="${data.createDate }" pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(companyFormList)<=0 }">
				<tr>
					<td colspan="7" class="no_result">
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
	<!--//페이지목록//-->
	<input type="hidden" name = "pageIndex" id = "pageIndex" value="${paginationInfo.currentPageNo }">
<script type="text/javascript">
	$("#totalCnt").text("${paginationInfo.totalRecordCount }");
</script>