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
		<div class="re_CompanyList">
			<c:choose>
				<c:when test="${fn:length(companyList)>0 }">
					<ul class="gray_dot_list">
						<c:forEach var = "data" items="${companyList }">
							<li>
							    <a href="javascript:selectedCpn('${data.cpnId }','${data.cpnNm }','${data.sNb }','${data.refOrgId }')">${data.cpnNm }</a>
							    <a class="btn_modify_con" href="javascript:popRgstCpn('UPDATE' , '${data.cpnId}' );" ><em>수정</em></a>
							</li>
						</c:forEach>
					</ul>
				</c:when>
				<c:otherwise>
					<p class="txt"><span>‘${searchName }’</span>에 대한 검색결과가 없습니다.</p>
				</c:otherwise>
			</c:choose>
		</div>
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
		<%-- <c:if test="${type ne null }"> --%>
			<a href="javascript:popRgstCpn('INSERT' , '');" class="p_blueblack_btn"><strong>신규입력하기</strong></a>
		<%-- </c:if> --%>
		<a href="javascript:window.close()" class="p_withelin_btn">취소</a>
	</div>
<%-- </c:if> --%>

