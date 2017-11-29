<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="./js/reqCancelList_JS.jsp" %>



<section id="detail_contents">

<form id ="frm" name = "frm" method="post">

	<input type="hidden" name = "appvDocId"     id = "appvDocId">
	<input type="hidden" name = "appvDocClass"  id = "appvDocClass">
	<input type="hidden" name = "appvDocType"   id = "appvDocType">
	<input type="hidden" name = "docStatus"     id = "docStatus">
	<input type="hidden" name = "listType"      value = "cancelList">

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
		</div>
		<div class="rightblock">
			<div  id = "searchDocStatusTag" style="display: inline;"></div>
			<input type="text" onkeypress="if(event.keyCode==13) {linkPage('1'); return false;}" value="${searchMap.searchTitle}"
				autocomplete="off" id="searchTitle" name="searchTitle" placeholder="기안문서 검색" class="input_txt_b" title="기안문서검색">
			<a href="javascript:linkPage('1')" class="btn_wh_bevel">검색</a>
		</div>
	</div>
	<!--//게시판정렬목록//-->
	<div id = "listArea">
		<jsp:include page="./include/reqCancelList_INC.jsp"></jsp:include>
	</div>

</form>

</section>
