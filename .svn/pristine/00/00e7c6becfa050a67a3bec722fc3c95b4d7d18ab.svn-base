<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!--결재문서함-->
<table class="tb_list_basic" summary="참조문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)">
	<caption>참조문서함 목록</caption>
	<colgroup>
		<col width="80" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col">순번</th>
			<th scope="col"><a href="#;" onclick="doSort(0);" id="sort_column_prefix0" class="sort_normal">사번<em>오름차순</em></a></th>
			<th scope="col"><a href="#;" onclick="doSort(1);" id="sort_column_prefix1" class="sort_normal">이름<em>오름차순</em></a> </th>
			<th scope="col">소속회사</th>
			<th scope="col">권한</th>
			<th scope="col"><a href="#;" onclick="doSort(2);" id="sort_column_prefix2" class="sort_normal">부서<em>오름차순</em></a></th>
			<th scope="col"><a href="#;" onclick="doSort(3);" id="sort_column_prefix3" class="sort_normal">직책<em>오름차순</em></a></th>
			<th scope="col"><a href="#;" onclick="doSort(4);" id="sort_column_prefix4" class="sort_normal">입사일<em>오름차순</em></a></th>
			<th scope="col">아이디</th>
			<th scope="col">이메일</th>
			<th scope="col">핸드폰</th>
			<th scope="col">재직상태</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${accessOrgUserList }" var="data" varStatus="i">
			<tr onclick="goDetailPage('${data.userId}')">
				<td>${(paginationInfo.recordCountPerPage*(paginationInfo.currentPageNo-1))+(i.index+1) }</td>
				<td class="num_date_type">${data.empNoView }</td>
				<td>${data.name }</td>
				<td class="txt_title">${data.companyNm }</td>
				<td class="txt_title">${data.roleNm }</td>
				<td>${data.deptNm }</td>
				<td>${data.position }</td>
				<td class="num_date_type"><fmt:formatDate value="${data.hiredDate}" pattern="yyyy-MM-dd" /></td>
				<td class="txt_eng txt_letter0">${data.loginId}</td>
				<td class="txt_eng txt_letter0"><a href="mailto:gjh@synergy.co.kr">${data.email}</a></td>
				<td class="txt_num">${data.mobileTel}</td>
				<td class="txt_num">${data.userStatusNm}</td>
			</tr>
		</c:forEach>
		<c:if test = "${fn:length(accessOrgUserList)<=0 }">
			<tr>
				<td colspan="12" class="no_result">
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
<script type="text/javascript">
	$("#totalCnt").text("${paginationInfo.totalRecordCount }");
</script>
