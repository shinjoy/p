<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="/WEB-INF/jsp/approve/js/approveCommon_JS.jsp" %>
<%@ include file="./js/approveCompany_JS.jsp" %>
	<!--//결재문서함//-->

	<!--게시판정렬목록-->
	<%-- <div class="board_classic">
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
	<div id = "listArea">
		<jsp:include page="./include/approveCompany_INC.jsp"></jsp:include>
	</div> --%>
	<section id="detail_contents">
		<form id ="frm" name = "frm" method="post">
			<input type="hidden" id = "appvDocClass" name = "appvDocClass" value="COMPANY">
			<!-- 작성화면 이동을 위한 파라미터 -->
			<input type="hidden" id = "appvCompanyFormId" name = "appvCompanyFormId">
			<div class="e_doc_choicebox">
				<ul class="doc_sample_list">
					<c:forEach items="${companyFormList }" var = "data">
						<li>
							<a href="javascript:goCreatePage('${data.appvCompanyFormId }','${data.approveLineType }','${data.appvLineHeaderCnt }')">
								<p class="img_sum"><img src="../images/approve/img_sum_basic.gif" alt="${data.appvDocTypeName }"></p>
								<span><em class="icon_basic">${data.appvDocTypeName }</em></span>
							</a>

							<p class="doctitle">${data.appvDocTypeName }
							<c:if test = "${data.newYn eq 'Y' }"><span class="icon_new"><em>new</em></span></c:if>

							</p>
							<button type="button" id="btn_Fav_COMPANY_${data.appvCompanyFormId }" onclick="processAppvFavDoc($(this))" class="icon_favor"><em>즐겨찾기</em></button>
						</li>

					</c:forEach>
				</ul>
			</div>

		</form>
	</section>