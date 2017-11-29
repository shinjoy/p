<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%-- <c:if test="${searchName ne null and searchName ne '' }"> --%>
	<!--검색결과有-->
	<div class="reaserch_result">
		<p class="reNum">검색결과 : <strong>${paginationInfo.totalRecordCount }</strong></p>
		<!-- <div class="re_CompanyList"> -->
			<!-- 회사중복체크 -->
			<table class="tb_list_basic3" id="SGridTarget">
				<colgroup>
				<col width="60">
				<col width="*">
				<col width="*">
				<col width="*">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">회사</th>
						<th scope="col">대표이사</th>
						<th scope="col">회사주소</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(companyList)>0 }">
							<c:forEach var = "data" items="${companyList }"  varStatus="i">
								<tr>
									<td>${(paginationInfo.recordCountPerPage*(paginationInfo.currentPageNo-1))+(i.index+1) }</td>
									<td class="com_namest"><a href="javascript:selectedCpn('${data.cpnId }','${data.cpnNm }','${data.sNb }','${data.refOrgId }')">${data.cpnNm }</a></td>
									<td class="com_ceost">${data.ceoNm }</td>
									<td class="com_addst">${data.addr }</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
						<%--<p class="txt"><span>‘${searchName }’</span>에 대한 검색결과가 없습니다.</p>--%>
 							<tr>
								<td colspan="4" class="no_result">검색결과가 없습니다. 신규등록해 주세요.</td>
							</tr>
						</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		<!-- </div> -->
	</div>
	<!--게시판페이지버튼-->
	<c:choose>
		<c:when test="${fn:length(companyList)>0 }">
			<div class="btnPageZone">
				<ui:pagination paginationInfo="${paginationInfo}" type="ib" jsFunction="linkPage" />
			</div>
		</c:when>
		<c:otherwise></c:otherwise>
	</c:choose>

	<!--//게시판페이지버튼//-->

	<div class="btnZoneBox">
		<a href="javascript:selectedCpn('')" class="p_blueblack_btn"><strong>신규등록</strong></a>
		<a href="javascript:window.close()" class="p_withelin_btn">닫기</a>
	</div>
<%-- </c:if> --%>

