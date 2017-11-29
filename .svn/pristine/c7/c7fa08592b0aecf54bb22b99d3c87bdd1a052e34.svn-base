<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script type="text/javascript">
$(document).ready(function(){
    loadListSortButton();
});
</script>

<input type="hidden" id="sortCol" name="sortCol" value="${searchMap.sortCol }">
<input type="hidden" id="sortAD" name="sortAD" value="${searchMap.sortAD }"">

<!--영업관리-->
<table class="tb_list_basic" summary="영업관리 (프로젝트명, 타입, 기한, 예산, 직원, 사용여부, 등록일)">
	<caption>영업정보목록</caption>
	<colgroup>
		<col width="100">
		<col width="100">
		<col width="100">
		<col width="*">
		<col width="*">
		<col width="*">
		<col width="*">
		<col width="100">
		<col width="100">
	</colgroup>
	<thead>
		<tr>
			<th scope="col"><a id="aCreateDate" onClick="setListSort('CREATE_DATE',this);" class="sort_normal" style="cursor:pointer;">등록일</a> </th>
			<th scope="col"><a id="aUpdateDate" onClick="setListSort('UPDATE_DATE',this);" class="sort_hightolow" style="cursor:pointer;">수정일</a> </th>
			<th scope="col"><a id="aViewDate" onClick="setListSort('VIEW_DATE',this);" class="sort_normal" style="cursor:pointer;">정보기준일</a></th>
			<th scope="col">${businessAdminRegist.pathLabel}</th>
			<th scope="col"><!-- <a href="#" class="sort_normal"> -->${businessAdminRegist.typeLabel}<!-- <em>정렬</em></a> --></th>
			<th scope="col"><!-- <a href="#" class="sort_lowtohigh"> -->${businessAdminRegist.classLabel}<!-- <em>오름차순</em></a> --></th>
			<th scope="col"><!-- <a href="#" class="sort_hightolow"> -->제목<!-- <em>내림차순</em></a> --></th>
			<th scope="col">진행상태</th>
			<th scope="col">작성자</th>

		</tr>
	</thead>
	<tbody>
		<c:forEach items="${listMap.businessInfoList }" var = "data">
			<tr>
				<td class="num_date_type"><fmt:formatDate value="${data.createDate }" pattern="yyyy-MM-dd" /></td>
				<td class="num_date_type"><fmt:formatDate value="${data.updateDate }" pattern="yyyy-MM-dd" /></td>
				<td class="num_date_type"><fmt:formatDate value="${data.viewDate }" pattern="yyyy-MM-dd" /></td>
				<td>${data.infoPathNm }</td>
				<td class="info_type_c1">${data.infoTypeNm }</td>
				<td class="info_type_c2">${data.infoClassNm }</td>
				<td class="txt_left">
				    <c:choose>
                        <c:when test="${data.infoLevel eq 'G'}"><span class="icon_important_L3"></span></c:when>
                        <c:when test="${data.infoLevel eq 'E'}"><span class="icon_important_L2"></span></c:when>
                    </c:choose>
					<a href="javascript:openDetailPop('${data.infoId }')">
						[${data.cpnNm1 }]<c:out value="${data.title}"/>
					</a>
					<c:if test="${data.commentCnt >0}">
						<span class="ripple">(${data.commentCnt })</span>
					</c:if>
                    <c:if test="${data.newYn eq 'Y'}">
					  <span class="icon_new"><em>new</em></span>
					</c:if>
				</td>
				<td>${data.progressNm }<!-- ${data.cpnId1CategoryBusiness } --></td>
				<td class="writer"><span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.createdBy}",$(this),"mouseover",null,5,-300,300)'>${data.createdByNm }</span></td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(listMap.businessInfoList)<=0 }">
			<tr>
                <td colspan="9" class="no_result">
                    <p class="nr_des">조회된 데이터가 없습니다.</p>
                </td>
            </tr>
		</c:if>
	</tbody>
</table>
<!--//영업관리//-->
<!--페이지목록-->
<div class="btnPageZone">
	<ui:pagination paginationInfo="${listMap.paginationInfo}" type="ib" jsFunction="linkPage" />
</div>
<!--//페이지목록//-->
<script type="text/javascript">
	$("#totalCnt").text("${listMap.paginationInfo.totalRecordCount }");
</script>
