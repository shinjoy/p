<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="/WEB-INF/jsp/approve/js/approveCommon_JS.jsp" %>
<!-- Daum Editor... -->
<link rel="stylesheet" href="<c:url value='/daumeditor/css/editor.css'/>" type="text/css" charset="utf-8"/>
<script src="<c:url value='/daumeditor/js/editor_loader.js'/>" type="text/javascript" charset="utf-8"></script>
<form id = "tx_editor_form" name = "tx_editor_form" ></form>
<!-- Daum Editor... -->
<style type="text/css">
    #ui-datepicker-div
    {
        z-index: 9999999!important;
    }

	.icon_favor { display:inline-block;float:right; z-index:1; background:url(${pageContext.request.contextPath}/images/approve/star_off2.png) no-repeat center center; width:40px; height:30px; }
	.icon_favor em { display:none; }
	.icon_favor.on { background:url(${pageContext.request.contextPath}/images/approve/star_on2.png) no-repeat center center; }

	.doc_subcon img{max-width: 800px;}
</style>

<!-- 결재라인 -->
<c:set var = "lineSize" value="${fn:length(approveLineMap) }"></c:set>
<c:set var = "preAppvSeq" value="${0}"></c:set>
<%@ include file="./js/approveDocDetail_JS.jsp" %>

<section id="detail_contents">
<form id = "frm" name = "frm" method="post">
	<!-- 상신: 유효성검사 정보 -->
	<input type="hidden" id = "amount" name = "amount" value="${detailMap.amount }">
	<input type="hidden" id = "projectId" name = "projectId" value="${detailMap.projectId }">
	<input type="hidden" id = "activityId" name = "activityId" value="${detailMap.activityId }">
	<input type="hidden" id = "appvHeaderId" name = "appvHeaderId" value="${detailMap.appvHeaderId }">
	<input type="hidden" id = "individualYn" name = "individualYn" value="${detailMap.individualYn }">
	<input type="hidden" id = "appvCompanyFormId" name = "appvCompanyFormId" value="${detailMap.appvCompanyFormId }">
	<input type="hidden" id = "amountModifyYn" name = "amountModifyYn" value="N">
	<input type="hidden" id = "approveDetailPopYn" name = "approveDetailPopYn" value="${popYn }">
	<input type="hidden" id = "popYn" name = "popYn" value="${popYn }">
	<div class="doc_AllWrap">
	<c:if test = "${searchMap.listType eq 'draft'}">
		<button type="button" id="btn_Fav_APPROVE_${detailMap.appvDocId }" onclick="processAppvFavDoc($(this))" class="icon_favor printOut"><em>즐겨찾기</em></button>
	</c:if>

		<!--문서타이틀-->
		<div class="doctitleZone">
			<div class="doctitle">
				<span class="app_state">
					<em class="icon st_ing">${detailMap.docStatusNm }</em>
				</span>
				<span class="title">
					<c:choose>
                    		<c:when test="${detailMap.appvDocClass eq 'BASIC'}">
                    			기본양식 _&nbsp;
                    		</c:when>
                    		<c:when test="${detailMap.appvDocClass eq 'REPORT'}">
                    			보고서 _&nbsp;
                    		</c:when>
                    		<c:when test="${detailMap.appvDocClass eq 'COMPANY'}">
                    			사내서식 _&nbsp;
                    		</c:when>
                    	</c:choose>
					${detailMap.title }
                </span>
			</div>
			<div class="writerinfo">
				<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${detailMap.writerId }",$(this),"mouseover",null,5,-200,200)'>
						${detailMap.writerNm }
				</span>
				<span class="doc_date"><fmt:formatDate value="${detailMap.createDate }" pattern="yyyy-MM-dd" /></span>
			</div>
		</div>

		<!--//문서타이틀//-->
		<!--결재라인요약-->
		<div class="doc_aappline">
			<div class="doc_linedes">
				<ul class="app_step_list2">
					<li><span class="divide">결재라인</span></li>

                    <c:forEach var = "data" items="${approveLineMap }" varStatus="i">
                        <c:if test = "${data.appvSeq ne preAppvSeq}">
                            </li>
                        </c:if>
                        <c:if test = "${data.appvSeq eq preAppvSeq}">
                            &nbsp;,&nbsp;
                        </c:if>
                        <c:if test = "${data.appvSeq ne preAppvSeq}">
                            <li>
                        </c:if>

                        <c:if test = "${data.appvAssignNm ne '' and data.appvAssignNm ne null}">
                            <c:if test = "${data.appvStatus eq 'REQ'}">
                           		<span class="current">
                           			<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.appvAssignId}",$(this),"mouseover",null,5,-80,80)'>
                           			${data.appvAssignNm}
                           			</span>
                           		</span>
                            </c:if>
                            <c:if test = "${data.appvStatus ne 'REQ'}">
                           		<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.appvAssignId}",$(this),"mouseover",null,5,-80,80)'>${data.appvAssignNm}</span>
                            </c:if>
                            (${data.deptNm}/${data.rankNm})
                        </c:if>

                        <c:set var = "preAppvSeq" value="${data.appvSeq}"></c:set>
                    </c:forEach>

                    </li>
				</ul>
			</div>
		</div>
		<!--//결재라인요약//-->
		<!--문서미리보기-->
		<c:choose>
			<c:when test="${detailMap.appvDocClass eq 'VACATION' or detailMap.appvDocClass eq 'REST' }">
				<jsp:include page="./include/approveDocDetail_vac_INC.jsp"></jsp:include>
			</c:when>

			<c:when test="${detailMap.appvDocClass eq 'EDUCATION' }">
				<jsp:include page="./include/approveDocDetail_edu_INC.jsp"></jsp:include>
			</c:when>
			<c:when test="${detailMap.appvDocClass eq 'TRIP' }">
				<jsp:include page="./include/approveDocDetail_trip_INC.jsp"></jsp:include>
			</c:when>
			<c:when test="${detailMap.appvDocClass eq 'BUY' }">
				<jsp:include page="./include/approveDocDetail_pur_INC.jsp"></jsp:include>
			</c:when>
			<c:when test="${detailMap.appvDocClass eq 'EVENT' }">
				<jsp:include page="./include/approveDocDetail_event_INC.jsp"></jsp:include>
			</c:when>
			<c:when test="${detailMap.appvDocClass eq 'BASIC' }">
				<jsp:include page="./include/approveDocDetail_basic_INC.jsp"></jsp:include>
			</c:when>
			<c:when test="${detailMap.appvDocClass eq 'REPORT' }">
				<jsp:include page="./include/approveDocDetail_report_INC.jsp"></jsp:include>
			</c:when>
			<c:when test="${detailMap.appvDocClass eq 'COMPANY' }">
				<jsp:include page="./include/approveDocDetail_company_INC.jsp"></jsp:include>
			</c:when>
			<c:when test="${detailMap.appvDocClass eq 'EXPENSE' }">
				<jsp:include page="./include/approveDocDetail_expense_INC.jsp"></jsp:include>
			</c:when>
		</c:choose>
		<!--문서미리보기-->


		<c:if test="${detailMap.docStatus ne 'WORKING'}">
			<div id = "commentArea" class="printOut">
				<jsp:include page="./include/approveDocDetail_comment_INC.jsp"></jsp:include>
			</div>
		</c:if>
		<c:if test="${searchMap.listType eq 'cancelList' and detailMap.docStatus eq 'CNL_SUBMIT'}">
			<jsp:include page="./include/approveDocDetail_cancelProc_INC.jsp"></jsp:include>
		</c:if>
		<%-- <c:if test="${detailMap.docStatus eq 'CNL_COMMIT' or detailMap.docStatus eq 'CNL_REJECT'}">
			<div class="e_doc_rippleWrap">
				<div id="RippleZone">
					<div class="RippleGroup">
						<h4 class="RippleTitle">회수의견</h4>
						<div class="RippleCon">
							<dl class="normal">
								<dt><span class="name">${detailMap.appvCancelUserNm }</span><span class="date"><fmt:formatDate value="${detailMap.updateDate }" pattern="yyyy-MM-dd" /></span></dt>
								<dd class="comment">${detailMap.appvCancelUserMemo }</dd>
							</dl>
						</div>
					</div>
				</div>
			</div>
		</c:if> --%>
		<!--//댓글폼(결재라인)//-->
		<!--버튼모음-->
		<div class="btn_baordZone2">
			<c:if test="${popYn eq 'Y' }">
				<a href="javascript:window.print();" class="btn_grayline">문서인쇄</a>
					<a href="javascript:window.close()" class="btn_witheline">닫기</a>
			</c:if>
			<c:if test="${popYn ne 'Y' }">
			<c:choose>
				<c:when test="${detailMap.docStatus eq 'WORKING'}">
					<a href="javascript:processDocSubmit()" class="btn_blueblack btn_auth">상신</a>
					<a href="javascript:goModifyPage()" class="btn_witheline btn_auth">수정</a>
					<a href="javascript:deleteAproveDoc()" class="btn_witheline btn_auth">삭제</a>
				</c:when>
				<c:when test="${searchMap.listType eq 'draft' and detailMap.docStatus eq 'COMMIT'}">
					<a href="javascript:openCancelPop()" class="btn_witheline btn_auth">회수요청</a>
				</c:when>
				<c:when test="${searchMap.listType eq 'pendList' and detailMap.docStatus eq 'CNL_SUBMIT'}">
					<a href="javascript:openEmpCancelPop('CNL_COMMIT')" class="btn_blueblack btn_auth">회수승인</a>
                    <a href="javascript:openEmpCancelPop('CNL_REJECT')" class="btn_witheline btn_auth">회수반려</a>
				</c:when>
                <c:otherwise>
	                    <%--<c:forEach var = "data" items="${approveLineMap }" varStatus="i">
	                         <c:if test="${data.appvStatus eq 'REQ' and data.appvAssignId eq baseUserLoginInfo.userId and searchMap.listType eq 'reqList'}"></c:if>

	                    </c:forEach>--%>
	                    <c:if test="${searchMap.listType eq 'pendList' or searchMap.listType eq 'previous' and detailMap.docStatus ne 'CNL_SUBMIT'}">
                            <!-- 승인반려 처리를 위한 값 -->
                            <input type="hidden" id = "appvProcessId" name = "appvProcessId" value="${detailMap.appvProcessId }">

                            <a href="javascript:processDocStatus('APPROVE')" class="btn_blueblack btn_auth">승인</a>
                            <a href="javascript:processDocStatus('REJECT')" class="btn_witheline btn_auth">반려</a>
                            <script type="text/javascript">
                            	$("#amountModifyBtn").show();
                            </script>
                        </c:if>
                        <c:if test="${searchMap.listType eq 'nextList'}">
                        	<c:if test="${detailMap.lastAppvStatus eq 'APPROVE' }"> <a href="javascript:processDocStatus('APPROVE')" class="btn_blueblack btn_auth">승인</a></c:if>
                        	<c:if test="${detailMap.lastAppvStatus eq 'REJEC' }"><a href="javascript:processDocStatus('REJECT')" class="btn_witheline btn_auth">반려</a></c:if>
                        </c:if>
                </c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${searchMap.listType eq 'projectStatus' }">
					<a href="javascript:parent.myModal.close()" class="btn_witheline">닫기</a>
				</c:when>
				<c:otherwise>

					<c:choose>
						<c:when test="${popYn eq 'A'}">
							<a href="javascript:window.print();" class="btn_grayline">문서인쇄</a>
							<a href="javascript:window.close()" class="btn_witheline">닫기</a>
						</c:when>
						<c:when test="${popYn eq 'M'}">
							<a href="javascript:window.print();" class="btn_grayline">문서인쇄</a>
							<a href="javascript:window.close()" class="btn_witheline">닫기</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:window.print();" class="btn_grayline">문서인쇄</a>
							<a href="javascript:goListPage()" class="btn_witheline">목록</a>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
			</c:if>
		</div>
		<!--//버튼모음//-->
	</div>
	<!-- 승인취소 확인 팝업 -->
	<div id = "approveCancelReqArea" class="AXModalBox" style="display: none;z-index: 6000;position: absolute;top:50%;left: 20%;padding: 0px;width:500px;background: white;" >
		<table class="popHeader windowbox" style="border-collapse:collapse; border:1px #000 solid; border-bottom:0px;" cellspacing="0" width="100%" height="31px">
			<tbody>
				<tr>
					<td width="100%" bgcolor="white" style="color:white;font-size:13px;padding-left:7px;background-image:linear-gradient(#20304a, #20304a);">
						<b style="float: left;">승인취소</b>
						<a id="AXModalA162314863_close" class="closeBtn" style="float: right;" href="javascript:myModal.close('approveCancelReqArea')"><em>닫기</em></a>
					</td>
				</tr>
			</tbody>
		</table>
		<table class="tb_regi_basic">
			<caption>승인취소신청</caption>
			<colgroup>
				<col width="90" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td>
						${detailMap.title }
					</td>
				</tr>
				<tr>
					<th>회수요청사유</th>
					<td>
						<textarea class="txtarea_b2 w100pro" id="appvCancelMemo" name = "appvCancelMemo" placeholder="회수요청사유 상세적기"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<!--버튼모음-->
		<div class="btn_baordZone2">
			<a href="javascript:doSave()" class="btn_blueblack btn_auth">확인</a>
			<a href="javascript:myModal.close('approveCancelReqArea')" class="btn_witheline">취소</a>
		</div>
		<!--//버튼모음//-->
	</div>

	<!-- 수신확인 팝업 -->
	<div id = "approveRcConfirmArea" class="AXModalBox" style="display: none;z-index: 6000;position: absolute;top:50%;left: 20%;padding: 0px;width:500px;background: white;" >
		<table class="popHeader windowbox" style="border-collapse:collapse; border:1px #000 solid; border-bottom:0px;" cellspacing="0" width="100%" height="31px">
			<tbody>
				<tr>
					<td width="100%" bgcolor="white" style="color:white;font-size:13px;padding-left:7px;background-image:linear-gradient(#20304a, #20304a);">
						<b style="float: left;">수신확인</b>
						<a id="AXModalA162314863_close" class="closeBtn" style="float: right;" href="javascript:myModal.close('approveRcConfirmArea')"><em>닫기</em></a>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="mo_container2">
			<!--문서열람목록-->
			<div class="referOpinionWrap">
				<h3 class="h3_title_basic">수신확인</h3>
				<textarea class="textarea_basic w100pro" id="receiptUserMemo" name = "receiptUserMemo" placeholder="수신확인 의견을 입력해주세요."></textarea>
			</div>
			<!--//문서열람목록//-->
			<div class="btnZoneBox"><a href="javascript:processAppvRcSave()" class="p_blueblack_btn">수신확인</a><a href="javascript:myModal.close('approveRcConfirmArea')" class="p_withelin_btn">취소</a></div>
			<!--//검색결과有//-->
		</div>
		<div style="height: 10px;"></div>
	</div>

	<!-- 취소처리 팝업 -->
	<div id = "approveEmpCancelArea" class="AXModalBox" style="display: none;z-index: 6000;position: absolute;top:50%;left: 20%;padding: 0px;width:500px;background: white;" >
		<table class="popHeader windowbox" style="border-collapse:collapse; border:1px #000 solid; border-bottom:0px;" cellspacing="0" width="100%" height="31px">
			<tbody>
				<tr>
					<td width="100%" bgcolor="white" style="color:white;font-size:13px;padding-left:7px;background-image:linear-gradient(#20304a, #20304a);">
						<b style="float: left;">회수의견</b>
						<a id="AXModalA162314863_close" class="closeBtn" style="float: right;" href="javascript:myModal.close('approveEmpCancelArea')"><em>닫기</em></a>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="mo_container2">
			<!--문서열람목록-->
			<div class="referOpinionWrap">
				<h3 class="h3_title_basic">회수의견</h3>
				<textarea class="textarea_basic w100pro" id="appvCancelUserMemo" name = "appvCancelUserMemo" placeholder="회수의견을 입력해주세요."></textarea>
			</div>
			<!--//문서열람목록//-->
			<div class="btnZoneBox"><a href="javascript:processDocCancel()" class="p_blueblack_btn">확인</a><a href="javascript:myModal.close('approveEmpCancelArea')" class="p_withelin_btn">취소</a></div>
			<!--//검색결과有//-->
		</div>
		<div style="height: 10px;"></div>
	</div>

	<!-- 지출확인 팝업 -->
	<div id = "approveExpenseConfirmArea" class="AXModalBox" style="display: none;z-index: 6000;position: absolute;top:50%;left: 20%;padding: 0px;width:500px;background: white;" >
		<table class="popHeader windowbox" style="border-collapse:collapse; border:1px #000 solid; border-bottom:0px;" cellspacing="0" width="100%" height="31px">
			<tbody>
				<tr>
					<td width="100%" bgcolor="white" style="color:white;font-size:13px;padding-left:7px;background-image:linear-gradient(#20304a, #20304a);">
						<b style="float: left;">지급완료의견</b>
						<a id="AXModalA162314863_close" class="closeBtn" style="float: right;" href="javascript:myModal.close('approveRcConfirmArea')"><em>닫기</em></a>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="mo_container2">
			<!--문서열람목록-->
			<div class="referOpinionWrap">
				<h3 class="h3_title_basic">처리의견</h3>
				<textarea class="textarea_basic w100pro" id="expensePayComment" name = "expensePayComment" placeholder="처리의견 의견을 입력해주세요."></textarea>
			</div>
			<!--//문서열람목록//-->
			<div class="btnZoneBox"><a href="javascript:processExpenseYn()" class="p_blueblack_btn">지급</a><a href="javascript:myModal.close('approveExpenseConfirmArea')" class="p_withelin_btn">취소</a></div>
			<!--//검색결과有//-->
		</div>
		<div style="height: 10px;"></div>
	</div>

	<!-- 수정의견팝업 -->
	<div id = "approveDocUpdateArea" class="AXModalBox" style="display: none;z-index: 6000;position: absolute;top:50%;left: 20%;padding: 0px;width:500px;background: white;" >
		<table class="popHeader windowbox" style="border-collapse:collapse; border:1px #000 solid; border-bottom:0px;" cellspacing="0" width="100%" height="31px">
			<tbody>
				<tr>
					<td width="100%" bgcolor="white" style="color:white;font-size:13px;padding-left:7px;background-image:linear-gradient(#20304a, #20304a);">
						<b style="float: left;">수정의견</b>
						<a id="AXModalA162314863_close" class="closeBtn" style="float: right;" href="javascript:myModal.close('approveDocUpdateArea')"><em>닫기</em></a>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="mo_container2">
			<div class="referOpinionWrap">
				<h3 class="h3_title_basic">수정의견</h3>
				<textarea class="textarea_basic w100pro" id="updateComment" name = "updateComment" placeholder="수정의견 의견을 입력해주세요."></textarea>
			</div>
			<!--//저장//-->
			<div class="btnZoneBox"><a href="javascript:doSaveAppvInfoUpdate()" class="p_blueblack_btn">수정</a><a href="javascript:myModal.close('approveDocUpdateArea')" class="p_withelin_btn">취소</a></div>
			<!--//검색결과有//-->
		</div>
		<div style="height: 10px;"></div>
	</div>
	<!--//기타의견//-->
	<input type="hidden" id = "appvDocId" name = "appvDocId" value="${detailMap.appvDocId }">
	<input type="hidden" id = "appvDocClass" name = "appvDocClass" value="${detailMap.appvDocClass }">
	<input type="hidden" id = "appvDocType" name = "appvDocType" value="${detailMap.appvDocType }">
	<input type="hidden" id = "appvAgencyId" name = "appvAgencyId" value="${detailMap.appvAgencyId }">
	<input type="hidden" id = "docStatus" name = "docStatus" value="${detailMap.docStatus }">

	<!-- 검색조건유지 : S -->
	<input type="hidden" id = "searchSelect" name = "searchSelect" value="${searchMap.searchSelect }">
	<input type="hidden" id = "searchDocStatus" name = "searchDocStatus" value="${searchMap.searchDocStatus }">
	<input type="hidden" id = "searchTitle" name = "searchTitle" value="${searchMap.searchTitle }">
	<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${searchMap.recordCountPerPage }">
	<input type="hidden" id = "pageIndex" name = "pageIndex" value="${searchMap.pageIndex }">
	<input type="hidden" name = "listType" id = "listType" value="${searchMap.listType}">
	<input type="hidden" name="searchRcStatus" id = "searchRcStatus" value="${searchMap.searchRcStatus }">
	<input type="hidden" name="searchOrdId" id = "searchOrdId" value="${searchMap.searchOrdId }">
	<!-- 검색조건유지 : E -->
	<!-- 메모수정 -->
	<input type="hidden" id="memo" name = "memo" value='<c:out value="${detailMap.memo }" />'>

	<input type="hidden" id = "updateType" name = "updateType">
</form>
<form id = "approveFrm" name = "approveFrm">
	<input type="hidden" id = "appvDocId" name = "appvDocId">
	<input type="hidden" id = "appvDocClass" name = "appvDocClass">
	<input type="hidden" id = "appvDocType" name = "appvDocType">
	<input type="hidden" id = "approveDetailPopYn" name = "approveDetailPopYn" value="Y">
</form>

<form>
<!-- 내용 수정 팝업 -->
<div id = "approveMemoModifyArea" class="AXModalBox" style="display: none;z-index: 6000;position: absolute;top:50%;left: 20%;padding: 0px;width:1000px;background: white;" >
	<table class="popHeader windowbox" style="border-collapse:collapse; border:1px #000 solid; border-bottom:0px;" cellspacing="0" width="100%" height="31px">
		<tbody>
			<tr>
				<td width="100%" bgcolor="white" style="color:white;font-size:13px;padding-left:7px;background-image:linear-gradient(#20304a, #20304a);">
					<b style="float: left;">내용 수정</b>
					<a id="AXModalA162314863_close" class="closeBtn" style="float: right;" href="javascript:myModal.close('approveMemoModifyArea')"><em>닫기</em></a>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="mo_container2">
		<!--문서열람목록-->
		<div class="referOpinionWrap">
			<h3 class="h3_title_basic">내용</h3>
			<jsp:include page="/daumeditor/editor.jsp" flush="true">
              		<jsp:param value="approve" name="type"/>
              	</jsp:include>
		</div>
		<!--//문서열람목록//-->
		<div class="btnZoneBox"><a href="javascript:modifyAppvMemoInfo()" class="p_blueblack_btn">수정</a><a href="javascript:myModal.close('approveMemoModifyArea')" class="p_withelin_btn">취소</a></div>
		<!--//검색결과有//-->
	</div>
	<div style="height: 10px;"></div>
</div>
</form>

</section>