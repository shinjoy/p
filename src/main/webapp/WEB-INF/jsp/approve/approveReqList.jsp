<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="./js/approveReqList_JS.jsp" %>



<section id="detail_contents">

<form id ="frm" name = "frm" method="post">
	<input type="hidden" name = "appvDocId"     id = "appvDocId">
	<input type="hidden" name = "appvDocClass"  id = "appvDocClass">
	<input type="hidden" name = "appvDocType"   id = "appvDocType">
	<input type="hidden" name = "docStatus"     id = "docStatus">
	<input type="hidden" name = "approveProcessId" id = "approveProcessId">
	<input type="hidden" name = "processDocStatus"     id = "processDocStatus">
	<input type="hidden" name = "listType"      value = "${searchMap.listType }">
    <!--결재문서함-->
    <%-- <table class="tb_list_basic2 mgb30" summary="결재문서함 요약 (문서함 구분, 진행중, 반려, 완료)">
        <caption>결재문서함 요약</caption>
        <colgroup>
            <col width="20%" span="5" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col">문서함 구분</th>
                <th scope="col">결재요청<em class="rep_count">(대행)</em></th>
                <th scope="col">승인</th>
                <th scope="col">승인반려</th>
                <th scope="col">결재대행</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>결재문서함</th>
                <c:choose>
                    <c:when test="${reqSummary ne null }">
                        <td><a href="javascript:gatherView('REQ')">${reqSummary.reqCnt }(${reqSummary.reqAcencyCnt })</a></td>
                        <td><a href="javascript:gatherView('APPROVE')">${reqSummary.approveCnt }</a></td>
                        <td><a href="javascript:gatherView('REJECT')">${reqSummary.rejectCnt }</a></td>
                        <td><a href="javascript:gatherView('ENTRUST')">${reqSummary.entrustCnt }</a></td>
                    </c:when>
                    <c:otherwise>
                        <td><a href="#">-</a></td>
                        <td><a href="#">-</a></td>
                        <td><a href="#">-</a></td>
                        <td><a href="#">-</a></td>
                    </c:otherwise>
                </c:choose>


            </tr>
        </tbody>
    </table> --%>
	<!--//결재문서함//-->

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
			<c:if test = "${fn:length(accessOrgIdList)>1 and searchMap.listType eq 'allList' }">
				<select class="select_b mgl10" id="searchOrdId" name = "searchOrdId" title="회사선택" onchange="linkPage('1')">
					<c:forEach items="${accessOrgIdList }" var = "data">
						<c:if test="${data.orgAccessAuthType eq 'SUPER' or data.orgAccessAuthType eq 'VIP' }">
							<option value="${data.orgId }"
								<c:if test = "${data.orgId eq searchMap.searchOrdId}">selected="selected"</c:if>
							>${data.cpnNm }</option>
						</c:if>
					</c:forEach>
				</select>
			</c:if>
			<c:if test = "${searchMap.listType eq 'reqList' }"><!-- 기결 -->
				<span class="sys_p_noti mgl10" style="width: 200px;"><span class="icon_noti"></span><span class="pointB">결재처리한 </span><span>문서들을 열람할 수 있는 페이지 입니다.</span></span>
			</c:if>
			<c:if test = "${searchMap.listType eq 'proxyList' }"><!-- 대결 -->
				<span class="sys_p_noti mgl10" style="width: 400px;"><span class="icon_noti"></span><span class="pointB">자신 혹은 임직원 부재시 </span><span>결재 대행 진행한 문서를 열람할 수 있는 페이지 입니다.</span></span>
			</c:if>
			<c:if test = "${searchMap.listType eq 'pendList' }"><!-- 미결 -->
				<span class="sys_p_noti mgl10" style="width: 400px;"><span class="icon_noti"></span><span class="pointB">아직 결재하지 않은 결재 문서 </span><span>들이모여 있는 페이지 입니다.</span></span>
			</c:if>
			<c:if test = "${searchMap.listType eq 'previous' }"><!-- 선열 -->
				<span class="sys_p_noti mgl10" style="width: 400px;"><span class="icon_noti"></span><span class="pointB">종결전 문서열람 </span><span>가능하도록 세팅된 결재문서 중 아직 결재순서가 도래 되지 않은 문서들을 먼저 볼 수 있도록 모아둔 페이지입니다.</span></span>
			</c:if>
			<c:if test = "${searchMap.listType eq 'nextList' }"><!-- 후결 -->
				<span class="sys_p_noti mgl10" style="width: 400px;"><span class="icon_noti"></span><span class="pointB">상급 결재가가 선결 </span><span>하여 후결 해야하는 결재 문서가 모여 있는 페이지 입니다.</span></span>
			</c:if>
			<c:if test = "${searchMap.listType eq 'allList' }"><!-- 전체보기 -->
				<span class="sys_p_noti mgl10" style="width: 200px;"><span class="icon_noti"></span><span class="pointB">상신된 </span><span>전체문서를 열람할 수 있는 페이지 입니다.</span></span>
			</c:if>

		</div>
		<div class="rightblock">
			<select class="search_type2" title="결재상태선택" id = "searchSelect" name = "searchSelect">
					<option value="ALL" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'ALL') }">selected="selected"</c:if>>전체</option>
					<option value="TITLE" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'TITLE') }">selected="selected"</c:if>>제목</option>
					<option value="MEMO" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'MEMO') }">selected="selected"</c:if>>내용</option>
					<option value="DOCNUM" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'DOCNUM') }">selected="selected"</c:if>>문서번호</option>


					<option value="WRITEUSER" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'WRITEUSER') }">selected="selected"</c:if>>작성자</option>
					<option value="TARGETUSER" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'TARGETUSER') }">selected="selected"</c:if>>대상자</option>


					<c:if test="${searchMap.listType eq 'reqList' or searchMap.listType eq 'pendList' or searchMap.listType eq 'nextList' or  searchMap.listType eq 'previous'}">
						<option value="APPROVEUSER" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'APPROVUSER') }">selected="selected"</c:if>>결재자</option>
						<option value="AGREEUSER" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'AGREEUSER') }">selected="selected"</c:if>>합의자</option>
					</c:if>

					<c:if test="${searchMap.listType eq 'proxyList' }">
						<option value="REQAPPROVEUSER" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'REQLAPPROVE') }">selected="selected"</c:if>>원결재자</option>
						<option value="REALAPPROVEUSER" <c:if test = "${fn:contains(searchMap.searchDocStatus, 'AGREEUSER') }">selected="selected"</c:if>>결재 실행자</option>
					</c:if>

				</select>

			<span id = "searchDocStatusTag"></span>
			<input type="text" onkeypress="if(event.keyCode==13) {linkPage('1'); return false;}" value="${searchMap.searchTitle}"
			id="searchTitle" name="searchTitle" placeholder="결재문서 검색" class="input_txt_b" title="결재문서검색">
			<a href="javascript:linkPage('1')" class="btn_wh_bevel">검색</a>
		</div>
	</div>
	<!--//게시판정렬목록//-->
	<!--//게시판정렬목록//-->
	<div id = "listArea">
		<jsp:include page="./include/approveReqList_INC.jsp"></jsp:include>
	</div>
	<c:if test = "${searchMap.listType eq 'pendList' or searchMap.listType eq 'nextList' or searchMap.listType eq 'previous' }">
		<!--버튼영역-->
		<div class="btn_baordZone">
			 <a href="javascript:processDocStatusAll('APPROVE')" class="btn_blueblack btn_auth">승인</a>
			 <c:if test="${searchMap.listType ne 'nextList' }">
			 <a href="javascript:processDocStatusAll('REJECT')" class="btn_witheline btn_auth">반려</a>
			 </c:if>
		</div>
		<!--//버튼영역//-->
	</c:if>
</form>

</section>