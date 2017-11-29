<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="./js/approveCompanyFormList_JS.jsp" %>



<section id="detail_contents">

<form id ="frm" name = "frm" method="post">

	<!-- 상세페이지 이동을 위한 파라미터 -->
	<input type="hidden" id = "appvCompanyFormId" name = "appvCompanyFormId">

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

			<select class="sh_count_type mgl6" title="상태선택" id = "searchOpenYn" name = "searchOpenYn"  onchange="linkPage('1')">
				<option value="">상태</option>
				<option value="Y" <c:if test = "${searchMap.searchOpenYn eq 'Y' }">selected="selected"</c:if>>공개</option>
				<option value="N" <c:if test = "${searchMap.searchOpenYn eq 'N' }">selected="selected"</c:if>>비공개</option>
			</select>

			<select class="sh_count_type mgl6" title="삭제여부선택" id = "searchDeleteFlag" name = "searchDeleteFlag"  onchange="linkPage('1')">
				<option value="">삭제여부</option>
				<option value="Y" <c:if test = "${searchMap.searchDeleteFlag eq 'Y' }">selected="selected"</c:if>>Y</option>
				<option value="N" <c:if test = "${searchMap.searchDeleteFlag eq 'Y' }">selected="selected"</c:if>>N</option>
			</select>
		</div>
		<div class="rightblock">

			<select class="search_type2" title="검색조건" id = "searchSelect" name = "searchSelect">
				<option value="">전체</option>
				<option value="searchDocTypeName" <c:if test = "${searchMap.searchSelect eq 'searchDocTypeName' }">selected="selected"</c:if>>문서타입</option>
				<option value="searchMidName" <c:if test = "${searchMap.searchSelect eq 'searchMidName' }">selected="selected"</c:if>>구분</option>
				<option value="searchCreateNm" <c:if test = "${searchMap.searchSelect eq 'searchCreateNm' }">selected="selected"</c:if>>등록자</option>
			</select>
			<input type="text" onkeypress="if(event.keyCode==13) {linkPage('1'); return false;}" value="${searchMap.searchTitle}"
			id="searchTitle" name="searchTitle" placeholder="결재문서 검색" class="input_txt_b" title="결재문서검색">
			<a href="javascript:linkPage('1')" class="btn_wh_bevel">검색</a>
		</div>
	</div>
	<!--//게시판정렬목록//-->
	<!--//게시판정렬목록//-->
	<div id = "listArea">
		<jsp:include page="./include/approveCompanyFormList_INC.jsp"></jsp:include>
	</div>
	<!--버튼영역-->
	<div class="btn_baordZone">
		 <a href="javascript:moveCompanyCreatePage()" class="btn_blueblack btn_auth">서식생성</a>
	</div>
	<!--//버튼영역//-->
</form>

</section>