<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!--영업관리-->
<table class="tb_list_basic"
	summary="영업관리 (프로젝트명, 타입, 기한, 예산, 직원, 사용여부, 등록일)">
	<caption>프로젝트목록</caption>
	<colgroup>
		<col width="100">
		<col width="100">
		<col width="100">
		<col width="100">
		<col width="100">
		<col width="*">
		<col width="100">
		<col width="100">

	</colgroup>
	<thead>
		<tr>
			<th scope="col"><!-- <a href="#" class="sort_normal"> -->등록일<!-- </a> --></th>
			<th scope="col">정보기준일</th>
			<th scope="col">${businessAdminRegist.pathLabel}</th>
			<th scope="col"><!-- <a href="#" class="sort_normal"> -->${businessAdminRegist.typeLabel}<!-- <em>정렬</em></a> --></th>
			<th scope="col"><!-- <a href="#" class="sort_lowtohigh"> -->${businessAdminRegist.classLabel}<!-- <em>오름차순</em></a> --></th>
			<th scope="col"><!-- <a href="#" class="sort_hightolow"> -->내용<!-- <em>내림차순</em></a> --></th>
			<th scope="col">진행상태</th>
			<th scope="col">작성자</th>

		</tr>
	</thead>
	<tbody>
		<c:forEach items="${listMap.businessInfoList }" var = "data">
			<tr>
				<td class="num_date_type"><fmt:formatDate value="${data.createdDate }" pattern="yyyy-MM-dd" /></td>
				<td class="num_date_type"><fmt:formatDate value="${data.viewDate }" pattern="yyyy-MM-dd" /></td>
				<td>${data.infoPathNm }</td>
				<td class="info_type_c1">${data.infoTypeNm }</td>
				<td class="info_type_c2">${data.infoClassNm }</td>
				<td class="txt_left">
					<a href="javascript:openDetailPop('${data.infoId }')">
						[${data.cpnNm1 }]
						<c:choose>
							<c:when test="${fn:length(data.content)>40 }">
								${fn:substring(data.content,0,40)}...
							</c:when>
							<c:otherwise>${data.content }</c:otherwise>
						</c:choose>

					</a>
					<c:if test="${data.recommentCnt >0}">
						<span class="ripple">(${data.recommentCnt })</span>
					</c:if>
                    <c:if test="${data.newYn eq 'Y'}">
					  <span class="icon_new"><em>new</em></span>
					</c:if>
				</td>
				<td>${data.progressNm }<!-- ${data.cpnId1CategoryBusiness } --></td>
				<td class="writer">${data.createdByNm }</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(listMap.businessInfoList)<=0 }">
			<tr>
                <td colspan="8" class="no_result">
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
