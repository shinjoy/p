<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="./js/approveAllList_JS.jsp" %>



<section id="detail_contents">

<form id ="frm" name = "frm" method="post">

	<input type="hidden" name = "appvDocId"     id = "appvDocId">
	<input type="hidden" name = "appvDocClass"  id = "appvDocClass">
	<input type="hidden" name = "appvDocType"   id = "appvDocType">
	<input type="hidden" name = "docStatus"     id = "docStatus">
	<input type="hidden" name = "listType"      value = "${listType }">

	<!-- 수신 상태 검색 -->
	<input type="hidden" name="searchRcStatus" id = "searchRcStatus" value="${searchMap.searchRcStatus }">

	<!--게시판정렬목록-->
	<div class="board_classic">
		<div class="leftblock">
			<span class="count_result"><strong>전체</strong><em id = "totalCnt"></em>건</span>
			<select class="sh_count_type" id = "recordCountPerPage" name = "recordCountPerPage" title="정렬방법 선택" onchange="linkPage('1')">
				<option value="10"
					<c:if test = "${searchMap.recordCountPerPage eq '10' }">selected="selected"</c:if>
				>10개씩 보기</option>
				<option value="20" <c:if test = "${searchMap.recordCountPerPage eq '20' }">selected="selected"</c:if>>20개씩 보기</option>
				<option value="50" <c:if test = "${searchMap.recordCountPerPage eq '50' }">selected="selected"</c:if>>50개씩 보기</option>
			</select>
			<span class="sys_p_noti mgl10" style="width: 200px;"><span class="icon_noti"></span><span class="pointB">상신된 </span><span>전체문서를 열람할 수 있는 페이지 입니다.</span></span>
		</div>
		<div class="rightblock">
				<select class="search_type2" title="결재상태선택" id = "searchSelect" name = "searchSelect">
					<option value="ALL" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'ALL') }">selected="selected"</c:if>>전체</option>
					<option value="TITLE" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'TITLE') }">selected="selected"</c:if>>제목</option>
					<option value="MEMO" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'MEMO') }">selected="selected"</c:if>>내용</option>
					<option value="DOCNUM" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'DOCNUM') }">selected="selected"</c:if>>문서번호</option>
					<option value="APPROVEUSER" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'APPROVUSER') }">selected="selected"</c:if>>결재자</option>
					<option value="AGREEUSER" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'AGREEUSER') }">selected="selected"</c:if>>합의자</option>
					<option value="DOCCC" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'DOCCC') }">selected="selected"</c:if>>수신인</option>
					<option value="DOCEXPENSEUSER" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'DOCEXPENSEUSER') }">selected="selected"</c:if>>지급인</option>
					<option value="WRITEUSER" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'WRITEUSER') }">selected="selected"</c:if>>작성자</option>
					<option value="TARGETUSER" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'TARGETUSER') }">selected="selected"</c:if>>대상자</option>
				</select>
			<span id = "searchDocStatusTag"></span>
			<input type="text" onkeypress="if(event.keyCode==13) {linkPage('1'); return false;}" value="${searchMap.searchTitle}"
				autocomplete="off" id="searchTitle" name="searchTitle" placeholder="기안문서 검색" class="input_txt_b" title="기안문서검색">
			<a href="javascript:linkPage('1')" class="btn_wh_bevel">검색</a>
		</div>
	</div>
	<!--//게시판정렬목록//-->
	<div id = "listArea">
		<jsp:include page="./include/approveAllList_INC.jsp"></jsp:include>
	</div>

</form>
</section>
