<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
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
</style>
<%@ include file="./js/modifyApproveRest_JS.jsp" %>

<section id="detail_contents">

<form id = "frm" name = "frm" method="post">
	<!-- DocClass 고정.... -->
	<input type="hidden" id = "appvDocClass" name = "appvDocClass" value="REST">
	<!-- 연차휴가만 고정...(16.10.20) -->
	<input type="hidden" id = "appvDocType" name = "appvDocType" value="REST">

	<input type="hidden" id = "allHalf" name = "allHalf" value="ALL">
	<!-- 저장후 상세화면 이동 -->
	<input type="hidden" id = "appvDocId" name = "appvDocId" value="${detailMap.appvDocId }">

	<!-- 검색조건유지 : S -->
	<input type="hidden" id = "searchDocStatus" name = "searchDocStatus" value="${searchMap.searchDocStatus }">
	<input type="hidden" id = "searchTitle" name = "searchTitle" value="${searchMap.searchTitle }">
	<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${searchMap.recordCountPerPage }">
	<input type="hidden" id = "pageIndex" name = "pageIndex" value="${searchMap.pageIndex }">
	<!-- 검색조건유지 : E -->


	<div class="doc_AllWrap">
		<!--휴직신청서작성-->
		<table class="tb_regi_basic" summary="휴직신청(문서종류, 결재자, 신청자, 연락처, 소속/직위,연락처, 휴가기간, 사용일/잔여일, 사유, 업무인수자, 대결자, 참조인선택)">
			<caption>휴직신청서작성</caption>
			<colgroup>
				<col width="90" />
				<col width="*" />
				<col width="110" />
				<col width="28%" />
			</colgroup>
			<tbody>
				<tr>
					<th>신청자</th>
					<td>${baseUserLoginInfo.userName }</td>
					<th><label for="IDNAME04">소속/직위</label></th>
					<td>
						${baseUserLoginInfo.deptNm }<span class="dashLine"> / </span>
						${baseUserLoginInfo.rankNm }
					</td>
				</tr>
				<tr>
					<th id = "linkDocTh"
						<c:choose>
							<c:when test = "${fn:length(detailMap.approveLinkDocList)>0 }">
								rowspan="2"
							</c:when>
							<c:otherwise>
								rowspan="1"
							</c:otherwise>
						</c:choose>
					>연결 결재문서</th>
					<td colspan="3">
						<div id = "refDocBefore">
							<a href="javascript:openApproveRefDocPop()" class="btn_s_type_g"><em>결재문서 선택</em></a>
						</div>
					</td>
				</tr>
				<tr id = "linkDocTr" <c:if test = "${fn:length(detailMap.approveLinkDocList)<=0 }"> style="display: none;"</c:if>>
					<td colspan="3" class="dot_line" id = "linkDocArea">
						<c:forEach items="${detailMap.approveLinkDocList}" var = "data">
							<span class="linkDoc_list linkDocList" id="linkDocList_${data.appvDocId }"><span>${data.docTitle }</span>
							<input type="hidden" id="refDocIdStr" name="refDocIdStr" value="${data.appvDocId }|${data.docTitle }">
							<a href="javascript:deleteLinkDoc('${data.appvDocId }')" class="btn_delete_employee"><em>삭제</em></a></span>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th>휴직기간</th>
					<td colspan="3">

						<input type="text" id = "dateFrom" name = "dateFrom" value="${detailMap.dateFrom }" class="input_b input_date_type" title="시작일"/>
							~
						<input type="text" id = "dateTo" name = "dateTo" value="${detailMap.dateTo }" class="input_b input_date_type" title="종료일" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="IDNAME07">휴직사유</label></th>
					<td colspan="3" class="conEditor">
						<jsp:include page="/daumeditor/editor.jsp" flush="true">
	                		<jsp:param value="approve" name="type"/>
	                	</jsp:include>
						<input type="hidden" id="memo" name = "memo" value='<c:out value="${detailMap.memo }"></c:out>'>
					</td>
				</tr>
				<tr>
					<th id = "approveLineTh" rowspan="1">결재라인</th>
					<td colspan="3">
					   <span id="appvDocTypeTag" >
	                  		<select id = "appvDocType" name = "appvDocType" class="select_b w100pro">
	                  			<option value="">문서타입선택</option>
	                  		</select>
	                   </span><!-- 문서타입선택 :선택한 문서종류-->

	                   <span id = "appvHeaderNameArea">

	                   </span>
						<%-- <div id = "approveLineArea">
							<jsp:include page="./include/reqPageApproveLine_INC.jsp"></jsp:include>
						</div> --%>
					</td>
				</tr>
				<tr id = "approveLineTr" style="display: none;">
					<td colspan="3" class="dot_line">
						<div id = "approveLineArea">
						</div>
					</td>
				</tr>
				<tr>
					<th>업무인수자</th>
					<td>
						<a href="javascript:openSelectUserPop('workAssign')" class="btn_select_employee">
							<em>직원선택</em>
						</a>
						<span class="employee_list" id = "workAssignArea">
							<span id = "workAssignName">${detailMap.workAgencyNm }</span><em id = "workAssignRankNm"><c:if test = "${not empty detailMap.workAgencyNm }">(${detailMap.workAgencyRankNm })</c:if></em>
							<input type="hidden" id = "workAgencyId" name = "workAgencyId" value="${detailMap.workAgencyId }">
							<c:if test="${detailMap.workAgencyId ne null }">
								<a id = 'workAssignDelete' href="javascript:deleteStaff('workAssign')" class="btn_delete_employee"><em>삭제</em></a>
							</c:if>
						</span>

					<th>대결자</th>
					<td>
						<a href="javascript:openSelectUserPop('appvAssign')" class="btn_select_employee"><em>직원선택</em></a>
						<span class="employee_list" id = "appvAssignArea">
							<span id = "appvAssignName">${detailMap.appvAgencyNm }</span>
							<em id = "appvAssignRankNm"><c:if test = "${not empty detailMap.appvAgencyNm }">(${detailMap.appvAgencyRankNm })</c:if></em>
							<input type="hidden" id = "appvAgencyId" name = "appvAgencyId" value="${detailMap.appvAgencyId }">
							<c:if test="${detailMap.appvAgencyId ne null }">
								<a id = 'appvAssignDelete' href="javascript:deleteStaff('appvAssign')" class="btn_delete_employee"><em>삭제</em></a>
							</c:if>
					</td>
				</tr>

				<tr>
					<th scope="row" id = "approveCcTh"
						<c:choose>
							<c:when test = "${detailMap.approveCcType eq 'SELECT' and fn:length(detailMap.approveCcList)>0 }">
								rowspan="2"
							</c:when>
							<c:otherwise>
								rowspan="1"
							</c:otherwise>
						</c:choose>

					>참조인선택</th>
					<td colspan="3">
						<span class="radio_list2">
							<c:set var = "aproveCcListSize" value="${fn:length(detailMap.approveCcList) }"></c:set>
							<label>
								<input type="radio" name="approveCcType" value="NONE" onclick="approveCcBtnToggle()"
									<c:if test = "${detailMap.approveCcType eq 'NONE'}">checked="checked"</c:if>
								>
								<span>선택안함</span>
							</label>
							<label>
								<input type="radio" name="approveCcType"  value="MY_ORG_ALL" onclick="approveCcBtnToggle()"
									<c:if test = "${detailMap.approveCcType eq 'MY_ORG_ALL'}">checked="checked"</c:if>
								/>
								<span>전체</span>
							</label>
							<label>
								<input type="radio" name="approveCcType" value="MY_TEAM" onclick="approveCcBtnToggle()"
									<c:if test = "${detailMap.approveCcType eq 'MY_TEAM'}">checked="checked"</c:if>
								>
								<span>소속팀</span>
							</label>
							<label>
								<input type="radio" name="approveCcType" value="SELECT" onclick="approveCcBtnToggle()"
									<c:if test = "${detailMap.approveCcType eq 'SELECT'}">checked="checked"</c:if>
								>
								<span>직접선택</span>
							</label>
						</span>
						<a id = "approveCcBtn" href="javascript:openSelectUserPop('approveCc')" class="btn_select_employee mgl10"
							<c:if test = "${detailMap.approveCcType ne 'SELECT'}">style="display:none"</c:if>
						>
							<em>직원선택</em>
						</a>
					</td>
				</tr>
				<tr id = "approveCcTr"
				<c:choose>
					<c:when test = "${detailMap.approveCcType eq 'SELECT' and fn:length(detailMap.approveCcList)>0 }">

					</c:when>
					<c:otherwise>
						style="display:none"
					</c:otherwise>
				</c:choose>
				>
					<td colspan="3" class="dot_line" id = "approveCcArea">
						<c:if test = "${detailMap.approveCcType eq 'SELECT'}">
							<c:forEach var = "data" items="${detailMap.approveCcList }" varStatus="i">
								<span class="employee_list approveCcList" id = 'approveCcList_${data.userId }'>
								<span>
									<c:if test="${i.index != 0 }"><div id = 'approveCcList_comma' style='display:inline'>,</div></c:if>
									${data.userNm }</span><em>(${data.rankNm })</em>
								<input type="hidden" id = "approveCcId" name = "approveCcId" value="${data.userId }">
								<a href="javascript:deleteStaff('approveCc','${data.userId }')" class="btn_delete_employee"><em>삭제</em></a></span>
							</c:forEach>
						</c:if>

					</td>
				</tr>
				<tr>
					<th scope="row" id = "approveRcTh"
						<c:choose>
							<c:when test = "${detailMap.approveRcType eq 'SELECT' and fn:length(detailMap.approveRcList)>0 }">
								rowspan="2"
							</c:when>
							<c:otherwise>
								rowspan="1"
							</c:otherwise>
						</c:choose>

					>수신인선택</th>
					<td colspan="3">
						<span class="radio_list2">
							<c:set var = "aproveCcListSize" value="${fn:length(detailMap.approveRcList) }"></c:set>
							<label>
								<input type="radio" name="approveRcType" value="NONE" onclick="approveRcBtnToggle()"
									<c:if test = "${detailMap.approveRcType eq 'NONE'}">checked="checked"</c:if>
								>
								<span>선택안함</span>
							</label>
							<label>
								<input type="radio" name="approveRcType"  value="MY_ORG_ALL" onclick="approveRcBtnToggle()"
									<c:if test = "${detailMap.approveRcType eq 'MY_ORG_ALL'}">checked="checked"</c:if>
								/>
								<span>전체</span>
							</label>
							<label>
								<input type="radio" name="approveRcType" value="MY_TEAM" onclick="approveRcBtnToggle()"
									<c:if test = "${detailMap.approveRcType eq 'MY_TEAM'}">checked="checked"</c:if>
								>
								<span>소속팀</span>
							</label>
							<label>
								<input type="radio" name="approveRcType" value="SELECT" onclick="approveRcBtnToggle()"
									<c:if test = "${detailMap.approveRcType eq 'SELECT'}">checked="checked"</c:if>
								>
								<span>직접선택</span>
							</label>
						</span>
						<a id = "approveCcBtn" href="javascript:openSelectUserPop('approveRc')" class="btn_select_employee mgl10"
							<c:if test = "${detailMap.approveRcType ne 'SELECT'}">style="display:none"</c:if>
						>
							<em>직원선택</em>
						</a>
					</td>

				</tr>
				<tr id = "approveRcTr"
				<c:choose>
					<c:when test = "${detailMap.approveRcType eq 'SELECT' and fn:length(detailMap.approveRcList)>0 }">

					</c:when>
					<c:otherwise>
						style="display:none"
					</c:otherwise>
				</c:choose>
				>
					<td colspan="3" class="dot_line" id = "approveRcArea">
						<c:if test = "${detailMap.approveRcType eq 'SELECT'}">
							<c:forEach var = "data" items="${detailMap.approveRcList }" varStatus="i">
								<span class="employee_list approveRcList" id = 'approveRcList_${data.userId }'>
								<span>
									<c:if test="${i.index != 0 }"><div id = 'approveRcList_comma' style='display:inline'>,</div></c:if>
									${data.userNm }</span><em>(${data.rankNm })</em>
								<input type="hidden" id = "approveRcId" name = "approveRcId" value="${data.userId }">
								<a href="javascript:deleteStaff('approveRc','${data.userId }')" class="btn_delete_employee"><em>삭제</em></a></span>
							</c:forEach>
						</c:if>

					</td>
				</tr>
				<tr>
					<th scope="row">결재완료전<br>열람허용</th>
					<td colspan="3">
						<label><input type="checkbox" id = "appvBeforeApproveReadYn" class="mgr3" name = "appvBeforeApproveReadYn" value="Y" <c:if test = "${detailMap.appvBeforeApproveReadYn eq 'Y' }">checked="checked"</c:if> ><span>결재/합의 허용</span></label>
						<label><input type="checkbox" id = "appvBeforeCcReadYn" class="mgl10 mgr3" name = "appvBeforeCcReadYn" value="Y" <c:if test = "${detailMap.appvBeforeCcReadYn eq 'Y' }">checked="checked"</c:if>><span>참조 허용</span></label>
						<label><input type="checkbox" id = "appvBeforeReceiveReadYn" class="mgl10 mgr3" name = "appvBeforeReceiveReadYn" value="Y" <c:if test = "${detailMap.appvBeforeReceiveReadYn eq 'Y' }">checked="checked"</c:if>><span>수신 허용</span></label>
					</td>
				</tr>
			</tbody>
		</table>
		<!--// 휴가/휴직/복직/신청서작성 //-->
		<!--버튼모음-->
		<div class="btn_baordZone2">
			<a href="javascript:doSave()" class="btn_blueblack btn_auth">확인</a>
			<a href="javascript:goDraftListPage()" class="btn_witheline">취소</a>
		</div>
		<!--//버튼모음//-->
	</div>
</form>

</section>