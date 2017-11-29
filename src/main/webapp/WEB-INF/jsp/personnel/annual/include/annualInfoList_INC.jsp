<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>


<table class="tb_list_basic" summary="참조문서함 (전체선택, 등록일, 구분, 제목, 등록자, 진행상황)" >
	<caption>참조문서함 목록</caption>
	<colgroup>
        <col width="5%" />
         <col width="7%" />
         <col width="10%" />
         <col width="10%" />
         <col width="10%" />
         <col width="7%" />
         <col width="10%" />
         <col width="9%" />
         <col width="9%" />
         <col width="9%" />
         <col width="7%" />
         <col width="7%" />
    </colgroup>
	<thead>
		<tr>
			<th scope="col">순번</th>
			<th scope="col">사번</th>
			<th scope="col">이름 </th>
			<th scope="col">회사</th>
			<th scope="col">부서</th>
			<th scope="col">직책</th>
			<th scope="col">입사일</th>

			<th scope="col">기본<br/>년차일수</th>
			<th scope="col">근속년수<br/>년차일수</th>
			<th scope="col">임의추가<br/>년차일수</th>

			<th scope="col">수정자</th>
			<th scope="col">등록자</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${accessOrgUserList }" var="data" varStatus="i">
			<tr onclick="setUpdForm( this, '${data.leaveId}' , '${data.orgId}' ,'${data.userId}' ,'${data.empNoView}','${data.name}' ,'${data.cpnNm}' ,'${data.deptNm}' ,'${data.position}'
			,'<fmt:formatDate value="${data.hiredDate}" pattern="yyyy-MM-dd" />' ,'${data.annualLeaveDay}' ,'${data.workAnnualLeaveDay}' ,'${data.userAnnualLeaveDay}' );"   >
				<td>${(paginationInfo.recordCountPerPage*(paginationInfo.currentPageNo-1))+(i.index+1) }</td>
				<td class="num_date_type">${data.empNoView }</td>
				<td>${data.name }</td>
				<td class="txt_title">${data.cpnNm }</td>
				<td>${data.deptNm }</td>
				<td>${data.position }</td>
				<td class="num_date_type"><fmt:formatDate value="${data.hiredDate}" pattern="yyyy-MM-dd" /></td>

				<td class="txt_num">${data.annualLeaveDay}</td>
				<td class="txt_num">${data.workAnnualLeaveDay}</td>
				<td class="txt_num">${data.userAnnualLeaveDay}</td>

				<td>${data.updatedNm}</td>
				<td>${data.createdNm}</td>
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
<!--페이지목록-->
<div class="btnPageZone">
	<ui:pagination paginationInfo="${paginationInfo}" type="ib" jsFunction="linkPage" />
</div>
<script type="text/javascript">
	$("#totalCnt").text("${paginationInfo.totalRecordCount }");
</script>
