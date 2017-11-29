<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="./js/loginHistList_JS.jsp" %>



<section id="detail_contents">

<form id ="frm" name = "frm" method="post">
	<input type="hidden" name = "pageIndex" id = "pageIndex" value="${paginationInfo.currentPageNo }">
	<!-- 상세화면이동을위한파라미터 -->
	<input type="hidden" name = "userId" id = "userId">
	<input type="hidden" name = "searchDeptId" id = "searchDeptId" value="${searchMap.searchDeptId2}">

	<!-- order by... -->
	<input type="hidden" id = "searchOrder" name = "searchOrder" value="${searchMap.searchOrder}">
	<div style="display: none;" id = "deptListAllTmpl">

		<c:forEach items="${accessOrgDeptUserList }" var = "data">
			<c:set var = "searchDeptId" value="${data.orgId}_${data.deptId }" />
			<option value="value_${data.orgId }_${data.deptId }"
				<c:if test = "${searchMap.searchDeptId2 eq data.deptId }">selected="selected"</c:if>
			>${data.deptNm }</option>
		</c:forEach>
	</div>
	<div class="carSearchBox">


		<label for="searchOrdId"><span class="carSearchtitle">회사선택</span></label>
		<select class="select_b mgr20" id="searchOrdId" name = "searchOrdId" title="회사선택" onchange="searchOrgId('RELOAD')">
			<c:forEach items="${accessOrgIdList }" var = "data">
				<option value="${data.orgId }"
					<c:if test = "${(data.orgId eq baseUserLoginInfo.applyOrgId) or (data.orgId eq searchMap.searchOrdId)}">selected="selected"</c:if>
				>${data.cpnNm }</option>
			</c:forEach>
		</select>

		<label for="searchDeptIdBuf"><span class="carSearchtitle">부서선택</span></label>
		<select class="select_b mgr20" id="searchDeptIdBuf" name = "searchDeptIdBuf"><!-- onchange="searchDeptId()" -->
		</select>
		<label for="searchDeptIdBuf"><span class="carSearchtitle">재직상태</span></label>
        <select class="select_b mgr10" id="searchUserStatus" name = "searchUserStatus" onchange="linkPage('1');">
            <option value=""  ${searchMap.searchUserStatus eq '' ? 'selected':''}>전체</option>
            <option value="WHL"  ${searchMap.searchUserStatus eq 'WHL' ? 'selected':''}>재직</option>
            <option value="FR" ${searchMap.searchUserStatus eq 'FR' ? 'selected':''}>퇴사</option>
        </select>
		<input class="input_b2 w200px" id = "searchText" name = "searchText" placeholder="직원검색" onkeypress="if(event.keyCode==13) {linkPage('1'); return false;}" value="${searchMap.searchText}">
		<a href="javascript:linkPage('1')" class="btn_g_black mgl10"><em>검색</em></a>



	</div>

	<!--게시판정렬목록-->
	<div class="board_classic mgt20">
		<div class="leftblock">
			<span class="count_result"><strong>전체</strong><em id = "totalCnt"></em>건</span>
			<select class="sh_count_type" id = "recordCountPerPage" name = "recordCountPerPage" title="정렬방법 선택" onchange="linkPage('1')">
				<option value="10" <c:if test = "${searchMap.recordCountPerPage eq '10' }">selected="selected"</c:if>>10개씩 보기</option>
				<option value="15" <c:if test = "${searchMap.recordCountPerPage eq '15' }">selected="selected"</c:if>>15개씩 보기</option>
				<option value="20" <c:if test = "${searchMap.recordCountPerPage eq '20' }">selected="selected"</c:if>>20개씩 보기</option>
				<option value="50" <c:if test = "${searchMap.recordCountPerPage eq '50' }">selected="selected"</c:if>>50개씩 보기</option>
			</select>
		</div>
		<div class="rightblock">

		</div>
	</div>
	<!--//게시판정렬목록//-->
	<div id = "listArea">
		<jsp:include page="./include/loginHistList_INC.jsp"></jsp:include>
	</div>
	<!--버튼영역-->
	<!-- <div class="btn_baordZone">
		<a href="/support_m/personnel_info.jsp" class="btn_blueblack">신규작성</a>
	</div> -->
	<!--//버튼영역//-->
</form>

</section>
