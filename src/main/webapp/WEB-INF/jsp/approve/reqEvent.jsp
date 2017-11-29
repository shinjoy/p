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
<%@ include file="./js/reqEvent_JS.jsp" %>

<section id="detail_contents">

<form id = "frm" name = "frm" method="post">
	<!-- DocClass 고정.... -->
	<input type="hidden" id = "appvDocClass" name = "appvDocClass" value="EVENT">

	<!-- 연차휴가만 고정...(16.10.20) -->
	<input type="hidden" id = "appvDocType" name = "appvDocType" value="EVENT">

	<!-- 저장후 상세화면 이동 -->
	<input type="hidden" id = "appvDocId" name = "appvDocId">

	<!-- 검색조건유지 : S -->
	<input type="hidden" id = "searchDocStatus" name = "searchDocStatus" value="${searchMap.searchDocStatus }">
	<input type="hidden" id = "searchTitle" name = "searchTitle" value="${searchMap.searchTitle }">
	<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${searchMap.recordCountPerPage }">
	<input type="hidden" id = "pageIndex" name = "pageIndex" value="${searchMap.pageIndex }">
	<!-- 검색조건유지 : E -->

	<!-- 경조사 분류 select -->
	<input type="hidden" id = "familyEventsId" name = "familyEventsId">

	<div class="doc_AllWrap">
		<!--휴가신청서작성-->
		<table class="tb_regi_basic" summary="휴가신청(문서종류, 결재자, 신청자, 연락처, 소속/직위,연락처, 휴가기간, 사용일/잔여일, 사유, 업무인수자, 대결자, 참조인선택)">
			<caption>휴가신청서작성</caption>
			<colgroup>
				<col width="90" />
				<col width="*" />
				<col width="110" />
				<col width="28%" />
			</colgroup>
			<tbody>
				<tr>
					<th>대상자</th>
					<td><span id = "staffNameArea">${baseUserLoginInfo.userName }</span>
							<a href="javascript:openSelectUserPop('userType')" class="btn_select_employee"><em>직원선택</em></a>
							<input type="hidden" id = "selectStaffId" name = "selectStaffId" value="${baseUserLoginInfo.userId}">
					</td>
					<th><label for="IDNAME04">소속/직위</label></th>
					<td>
						<span id = "selectStaffInfoArea">
						${baseUserLoginInfo.deptNm }<span class="dashLine"> / </span>
						${baseUserLoginInfo.rankNm }
						</span>
					</td>
				</tr>
			<tr>
				<th scope="row"><label for="IDNAME05">연락처</label></th>
				<td><span id = "selectStaffMobileArea">${baseUserLoginInfo.mobile }</span></td>

				<th scope="row"><label for="IDNAME21">경조사분류</label></th>
				<td>
					<select class="select_b w_196px" title="경조사분류선택" id = "familyEventsIdSelect" name = "familyEventsIdSelect">
						<c:forEach items="${familyEventsIdList }" var = "data">
							<c:choose>
								<c:when test="${data.familyEventsId eq '0' }">
									<optgroup label="${data.valueNm }">
								</c:when>
								<c:otherwise>
									<option value="${data.familyEventsId }|${data.amount}|${data.period}|${data.holiday}">${data.eventName }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th id = "linkDocTh">연결 결재문서</th>
				<td colspan="3">
					<div id = "refDocBefore">
						<a href="javascript:openApproveRefDocPop()" class="btn_s_type_g"><em>결재문서 선택</em></a>
					</div>
				</td>

			</tr>
			<tr id = "linkDocTr" style="display: none;">
				<td colspan="3" class="dot_line" id = "linkDocArea">
				</td>
			</tr>
			<tr>
				<th>금액</th>
				<td>
					<div id = "amountArea">
						<strong class="f_bluePoint" id = "event_amount"></strong>
						<a id = "amountModifyBtn" class="btn_s_type_g mgl5" href="javascript:amountModify()"><em>수정</em></a>
					</div>
					<div id = "amountModifyArea" style="display: none;">
						<input type="text" class="input_mrb number" id = "amount" name = "amount">원
						<a id = "amountModifyBtn" class="btn_s_type_g mgl5" href="javascript:amountConfirm()"><em>적용</em></a>
					</div>
				</td>
				<th>경조휴일</th>
				<td>
					<strong id = "event_period"></strong><font id = "event_holiday"></font>
				</td>
			</tr>
			<tr>
				<th><label for="IDNAME22">경조일자</label></th>
				<td><input type="text" id = "eventDate" name="eventDate" class="input_b input_date_type" title="경조일" /></td>
				<th><label for="IDNAME23">경조휴가설정</label></th>
				<td>
					<span  id = "eventPeriodArea">
						<input type="text"  id = "dateFrom" name="dateFrom" class="input_b input_date_type" title="시작일" />
							~
						<input type="text" id = "dateTo" name="dateTo" class="input_b input_date_type" title="종료일"  readonly="readonly"/>
					</span>
				</td>
			</tr>
			<tr>
				<th scope="row"><label for="memo">내용</label></th>
				<td colspan="3" class="conEditor">
					<jsp:include page="/daumeditor/editor.jsp" flush="true">
	                		<jsp:param value="approve" name="type"/>
	                	</jsp:include>
						<input type="hidden" id="memo" name = "memo">
				</td>
			</tr>
			<tr>
				<th>파일첨부</th>
				<td colspan="3" class="r_addFileList">
	                <p class="posi_btn">
						<span id="fileInputArea" class="file_btn_bg"><input name="upFile" type="file" multiple onchange="newFileUpload();" class="file_btn_cover"></span>
					</p>

	                    <!--파일없을땐 지워주세요-->
	                    <ul id="uploadFileList" class="fileList" style="display: none;">
	                	</ul>
	                    <!--//파일없을땐 지워주세요//-->
	                    <p class="file_notice">* 전체 최대용량 100MB 까지 첨부 가능합니다.</p>
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
							<span id = "workAssignName"></span><em id = "workAssignRankNm"></em>
							<input type="hidden" id = "workAgencyId" name = "workAgencyId">
							<!-- <a href="#" class="btn_delete_employee"><em>삭제</em></a> -->
						</span>

					<th>대결자</th>
					<td>
						<a href="javascript:openSelectUserPop('appvAssign')" class="btn_select_employee"><em>직원선택</em></a>
						<span class="employee_list" id = "appvAssignArea">
							<span id = "appvAssignName"></span><em id = "appvAssignRankNm"></em>
							<input type="hidden" id = "appvAgencyId" name = "appvAgencyId">
							<!-- <a href="#" class="btn_delete_employee"><em>삭제</em></a></span> -->
						</span>
					</td>
				</tr>

				<tr>
					<th scope="row" id = "approveCcTh">참조인선택</th>
					<td colspan="3">
						<span class="radio_list2">
							<label>
								<input type="radio" name="approveCcType" value="NONE" checked="checked" onclick="approveCcBtnToggle()">
								<span>선택안함</span>
							</label>
							<label>
								<input type="radio" name="approveCcType" value="MY_ORG_ALL" onclick="approveCcBtnToggle()"/>
								<span>전체</span>
							</label>
							<label>
								<input type="radio" name="approveCcType" value="MY_TEAM" onclick="approveCcBtnToggle()">
								<span>소속팀</span>
							</label>
							<label>
								<input type="radio" name="approveCcType" value="SELECT" onclick="approveCcBtnToggle()">
								<span>직접선택</span>
							</label>
						</span>
						<a id = "approveCcBtn" href="javascript:openSelectUserPop('approveCc')" class="btn_select_employee mgl10" style="display: none;">
							<em>직원선택</em>
						</a>
					</td>
				</tr>
				<tr id = "approveCcTr" style="display: none;">
					<td colspan="3" class="dot_line" id = "approveCcArea">
					</td>
				</tr>
				<!-- 수신 추가 :S -->
				<tr>
					<th scope="row" id = "approveRcTh">수신인선택</th>
					<td colspan="3">
						<span class="radio_list2">
							<label>
								<input type="radio" name="approveRcType" value="NONE" checked="checked" onclick="approveRcBtnToggle()">
								<span>선택안함</span>
							</label>
							<label>
								<input type="radio" name="approveRcType" value="MY_ORG_ALL" onclick="approveRcBtnToggle()"/>
								<span>전체</span>
							</label>
							<label>
								<input type="radio" name="approveRcType" value="MY_TEAM" onclick="approveRcBtnToggle()">
								<span>소속팀</span>
							</label>
							<label>
								<input type="radio" name="approveRcType" value="SELECT" onclick="approveRcBtnToggle()">
								<span>직접선택</span>
							</label>
						</span>
						<a id = "approveRcBtn" href="javascript:openSelectUserPop('approveRc')" class="btn_select_employee mgl10" style="display: none;">
							<em>직원선택</em>
						</a>
					</td>
				</tr>
				<tr id = "approveRcTr" style="display: none;">
					<td colspan="3" class="dot_line" id = "approveRcArea">
					</td>
				</tr>
				<!-- 수신 추가 :E -->
				<tr>
					<th scope="row">결재완료전<br>열람허용</th>
					<td colspan="3">
						<label><input type="checkbox" id = "appvBeforeApproveReadYn" class="mgr3" name = "appvBeforeApproveReadYn" value="Y" <c:if test = "${appvReadDocSetupMap.approveYn eq 'Y' }">checked="checked"</c:if> ><span>결재/합의 허용</span></label>
						<label><input type="checkbox" id = "appvBeforeCcReadYn" class="mgl10 mgr3" name = "appvBeforeCcReadYn" value="Y" <c:if test = "${appvReadDocSetupMap.ccYn eq 'Y' }">checked="checked"</c:if>><span>참조 허용</span></label>
						<label><input type="checkbox" id = "appvBeforeReceiveReadYn" class="mgl10 mgr3" name = "appvBeforeReceiveReadYn" value="Y" <c:if test = "${appvReadDocSetupMap.receiveYn eq 'Y' }">checked="checked"</c:if>><span>수신 허용</span></label>
					</td>
				</tr>
		</tbody>
	</table>
	<!--// 교육신청/완료보고작성 //-->
	<!--버튼모음-->
	<div class="btn_baordZone2">
		<a href="javascript:doSave()" class="btn_blueblack btn_auth btn_myOrg">임시저장</a>
		<a href="javascript:goDraftListPage()" class="btn_witheline">취소</a>
	</div>
	<!--//버튼모음//-->
</div>

</form>

</section>