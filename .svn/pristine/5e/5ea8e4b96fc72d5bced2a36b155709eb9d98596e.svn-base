<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="js/companyList_JS.jsp"  %>



<section id="detail_contents">

<form name="searchCpn" id="searchCpn" action="<c:url value='/company/searchName.do' />" method="post">
	<input type="hidden" id = "pageIndex" name = "pageIndex" value="1">
	<!--ver1.일반목록-->
	<!--회사검색-->
	<div class="search_netBox">
		<div class="f_left">
			<select title="검색구분 선택" id = "searchType" name = "searchType">
				<option value="">전체</option>
				<option value="cpnNm"
					<c:if test = "${companyVO.searchType eq 'cpnNm' }">selected="selected"</c:if>
				>회사</option>
				<option value="customer"
					<c:if test = "${companyVO.searchType eq 'customer' }">selected="selected"</c:if>
				>고객</option>
			</select>
			<input type="text" id = "searchText" name = "searchText" onkeypress="if(event.keyCode==13) {linkPage('1'); return false;}" autocomplete="off" placeholder="검색어를 입력하세요" title="검색어입력" />
		</div>
		<div class="f_right">
			<button type="button" onclick="linkPage('1')">
				<img src="../images/network/btn_search2.gif" alt="검색" />
			</button>
		</div>
	</div>
	<!--//회사검색//-->
	<!--탭구분-->
	<%--<ul class="tabZone_st03">
			<li class="current"><a href="/network/company_list.jsp">전체</a></li>
			<li><a href="/network/company_list.jsp">초성검색</a></li>
			<li><a href="/network/company_list.jsp">시장</a></li>
			<li><a href="/network/company_list.jsp">업종</a></li>
			<li><a href="/network/company_list.jsp">종목코드</a></li>
		</ul>--%>
	<!--//탭구분//-->

	<div id = "listArea">
		<jsp:include page="./include/companyList_INC.jsp"></jsp:include>
	</div>
	<!--버튼영역-->
	<div class="btn_baordZone">
		<a href="javascript:openProcessCpnPop()" class="btn_blueblack btn_auth">회사신규등록</a>
		<c:if test="${baseUserLoginInfo.orgId eq 1 and baseUserLoginInfo.userRoleId eq 20}">	<%-- 시너지 개발 자 권한만 회사업로드 가능하도록 --%>
		<a href="javascript:openCsvPop('company')" class="btn_witheline btn_auth">회사업로드(CSV)</a>
		<a href="javascript:openCsvPop('companyInfo')" class="btn_witheline btn_auth">상장회사업로드(CSV)</a>
		<a href="javascript:openCsvPop('stock')" class="btn_witheline btn_auth">주가정보업로드(CSV)</a>
		</c:if>
	</div>
	<!--버튼영역-->
</form>

<!-- 상세 팝업을 열기위한 form....추후 회사 수정에도 쓰일지 고려: psj -->
<form id = "detailFrm" name = "detailFrm" method="post">
	<input type="hidden" id = "sNb" name = "sNb">
	<input type="hidden" id = "cpnId" name = "cpnId">
</form>

</section>