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
<%@ include file="./js/updateApproveCompanyForm_JS.jsp" %>

<section id="detail_contents">
<form id = "frm" name = "frm" method="post">
	<input type="hidden" id = "popYn" name = "popYn" value="Y">
	<input type="hidden" id = "appvCompanyFormId" name = "appvCompanyFormId" value="${companyFormMap.appvCompanyFormId}">

	<div class="doc_AllWrap">
		<%-- <div class="board_classic">
			<div class="rightblock">
				<!-- 공개비공개여부 -->
				<input type="hidden" id = "openYn" name = "openYn" value="${companyFormMap.openYn}">
				<span class="doc_read_check" id = "openYArea" <c:if test = "${companyFormMap.openYn eq 'N' }">style="display:none;"</c:if>><a href="javascript:chgOpenYn('Y')" class="btn_s_type_red">&nbsp;공개문서&nbsp;</a></span>
				<span class="doc_read_check" id = "openNArea" <c:if test = "${companyFormMap.openYn eq 'Y' }">style="display:none;"</c:if>><a href="javascript:chgOpenYn('N')" class="btn_s_type_blue">&nbsp;비공개문서&nbsp;</a></span>
			</div>
		</div> --%>
		<!--사내서식 관리-->
		<table class="tb_regi_basic" summary="휴가신청(문서종류, 결재자, 신청자, 연락처, 소속/직위,연락처, 휴가기간, 사용일/잔여일, 사유, 업무인수자, 대결자, 참조인선택)">
			<caption>사내서식 관리</caption>
			<colgroup>
				<col width="90" />
				<col width="*" />
				<col width="110" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th>문서타입</th>
					<td><input class="input_b w100pro" id="appvDocTypeName" name="appvDocTypeName" value="${companyFormMap.appvDocTypeName }" placeholder="문서타입"/></td>
					<th>구분</th>
					<td>
						<input type="hidden" id = "appvDocNumRuleMidNameChk" value="Y">
						<input class="input_b w200px" id="appvDocNumRuleMidName" name="appvDocNumRuleMidName" value="${companyFormMap.appvDocNumRuleMidName }" onblur="appvDocNumRuleMidNameBlur()" placeholder="구분"/>
						<button type="button" class="btn_s_type2 mgl6" onclick="doAppvDocNumRuleMidNameChk();return false;"><em class="icon_search">유효검사</em></button>
						<span id = "appvDocNumRuleMidNameResult" style="color: red;"></span>
					</td>
				</tr>

				<tr>
					<th scope="row" id = "userTypeStaffTh"><label for="userType">대상자</label></th>
					<td>
						<span class="radio_list2">
							<label><input type="radio" name = "userType" value="LOGIN" <c:if test = "${companyFormMap.userType eq 'LOGIN' }">checked="checked"</c:if>><span>로그인사용자</span></label>
							<label><input type="radio" name = "userType" value="STAFF" <c:if test = "${companyFormMap.userType eq 'STAFF' }">checked="checked"</c:if>><span>직원선택</span></label>
						</span>
					</td>
					<th scope="row"><label for="projectType">${baseUserLoginInfo.projectTitle }</label></th>
					<td>
						<span class="radio_list2">
							<label><input type="radio" name = "projectType" value="ING" <c:if test = "${companyFormMap.projectType eq 'ING' }">checked="checked"</c:if>><span>진행중인 ${baseUserLoginInfo.projectTitle }만</span></label>
							<label><input type="radio" name = "projectType" value="ALL" <c:if test = "${companyFormMap.projectType eq 'ALL' }">checked="checked"</c:if>><span>진행과 중단/마감된 ${baseUserLoginInfo.projectTitle }포함</span></label>
						</span>
					</td>
				</tr>

				<tr>
					<th scope="row"><label for="approveLineType">결재라인</label></th>
					<td>
						<span class="radio_list2">
							<label><input type="radio" name = "approveLineType" value="SETTING" <c:if test = "${companyFormMap.approveLineType eq 'SETTING' }">checked="checked"</c:if>><span>결재라인 세팅값 사용</span></label>
							<label><input type="radio" name = "approveLineType" value="INPUT" <c:if test = "${companyFormMap.approveLineType eq 'INPUT' }">checked="checked"</c:if>><span>직접입력기능 함께사용</span></label>
						</span>
					</td>
					<th scope="row">일정</th>
					<td>
						<label><input type="checkbox" id = "scheduleUseYn" class="mgr3" <c:if test = "${companyFormMap.scheduleUseYn eq 'Y' }">checked="checked"</c:if> name = "scheduleUseYn" value="Y" onclick="chkUseYn('scheduleUseYn')"><span>사용</span></label>
						<span class="radio_list2 mgl10" id = "scheduleUseYnArea" <c:if test = "${companyFormMap.scheduleUseYn ne 'Y' }">style="display: none;"</c:if>>
							<label><input type="radio" name = "scheduleUseType" value="MANDATORY" <c:if test = "${empty companyFormMap.scheduleUseType or companyFormMap.scheduleUseType eq 'MANDATORY' }">checked="checked"</c:if>><span>필수입력</span></label>
							<label><input type="radio" name = "scheduleUseType" value="OPTION" <c:if test = "${companyFormMap.scheduleUseType eq 'OPTION' }">checked="checked"</c:if>><span>선택입력</span></label>
						</span>
					</td>
				</tr>

				<tr>
					<th scope="row">연결 결재문서</th>
					<td>
						<label><input type="checkbox" id = "linkDocUseYn" class="mgr3" name = "linkDocUseYn" <c:if test = "${companyFormMap.linkDocUseYn eq 'Y' }">checked="checked"</c:if> onclick="chkUseYn('linkDocUseYn')" value="Y"><span>사용</span></label>
						<span class="radio_list2 mgl10" id = "linkDocUseYnArea" <c:if test = "${companyFormMap.linkDocUseYn ne 'Y' }">style="display: none;"</c:if>>
							<label><input type="radio" name = "linkDocUseType" value="MANDATORY" <c:if test = "${empty companyFormMap.linkDocUseType or companyFormMap.linkDocUseType eq 'MANDATORY' }">checked="checked"</c:if>><span>필수입력</span></label>
							<label><input type="radio" name = "linkDocUseType" value="OPTION" <c:if test = "${companyFormMap.linkDocUseType eq 'OPTION' }">checked="checked"</c:if>><span>선택입력</span></label>
						</span>
					</td>
					<th scope="row">다른 ${baseUserLoginInfo.projectTitle } 선택 허용</th>
					<td>
						<span class="radio_list2">
							<%-- <label><input type="radio" name = "projectChoiceYn" value="Y" <c:if test = "${companyFormMap.projectChoiceYn eq 'Y' }">checked="checked"</c:if>><span>허용</span></label>
							<label><input type="radio" name = "projectChoiceYn" value="N" <c:if test = "${companyFormMap.projectChoiceYn eq 'N' }">checked="checked"</c:if>><span>비허용</span></label> --%>
							<label><input type="radio" name = "projectChoiceYn" value="Y" checked="checked"><span>허용</span></label>
							<label onclick="alert('준비중입니다.')"><input type="radio" name = "projectChoiceYn" value="N" disabled="disabled"><span>비허용</span></label>
						</span>
					</td>
				</tr>

				<tr>
					<th scope="row" id = "userTypeStaffTh">제목</th>
					<td>
						<label><input type="checkbox" id = "titleUseYn" class="mgr3" name = "titleUseYn" value="Y" <c:if test = "${companyFormMap.titleUseYn eq 'Y' }">checked="checked"</c:if>><span>사용(필수입력)</span></label>

					</td>
					<th scope="row">파일첨부</th>
					<td>
						<label><input type="checkbox" id = "fileUseYn" class="mgr3" name = "fileUseYn" onclick="chkUseYn('fileUseYn')" value="Y" <c:if test = "${companyFormMap.fileUseYn eq 'Y' }">checked="checked"</c:if>><span>사용</span></label>
						<span class="radio_list2 mgl10" id = "fileUseYnArea" <c:if test = "${companyFormMap.fileUseYn ne 'Y' }">style="display: none;"</c:if>>
							<label><input type="radio" name = "fileUseType" value="MANDATORY" <c:if test = "${empty companyFormMap.fileUseType or companyFormMap.fileUseType eq 'MANDATORY' }">checked="checked"</c:if>><span>필수입력</span></label>
							<label><input type="radio" name = "fileUseType" value="OPTION" <c:if test = "${companyFormMap.fileUseType eq 'OPTION' }">checked="checked"</c:if>><span>선택입력</span></label>
						</span>
					</td>
				</tr>

				<tr>
					<th scope="row">내용</th>
					<td colspan="3" class="conEditor">
						<jsp:include page="/daumeditor/editor.jsp" flush="true">
	                		<jsp:param value="approve" name="type"/>
	                	</jsp:include>
						<input type="hidden" id="docContent" name = "docContent" value='<c:out value="${companyFormMap.docContent }" />'>
					</td>
				</tr>
				<tr>
					<th scope="row">공개여부</th>
					<td colspan="3">
						<span class="radio_list2">
							<label><input type="radio" name = "openYn" value="Y" onclick="javascript:chgOpenYn('Y')" <c:if test = "${companyFormMap.openYn eq 'Y' }">checked="checked"</c:if>><span>공개</span></label>
							<label><input type="radio" name = "openYn" value="N" onclick="javascript:chgOpenYn('N')" <c:if test = "${companyFormMap.openYn eq 'N' }">checked="checked"</c:if>><span>비공개</span></label>
						</span>
					</td>
				</tr>
			</tbody>
		</table>
		<!--// 휴가/휴직/복직/신청서작성 //-->
		<!--버튼모음-->
		<div class="btn_baordZone2">
			<c:if test = "${companyFormMap.deleteFlag ne 'Y' }">
				<a href="javascript:openPreViewPop()" class="btn_witheline">미리보기</a>
				<a href="javascript:doSave()" class="btn_blueblack btn_auth">수정</a>
				<a href="javascript:doDelete()" class="btn_witheline btn_auth">삭제</a>
			</c:if>
			<a href="javascript:goListPage()" class="btn_witheline">목록</a>
		</div>
		<!--//버튼모음//-->
	</div>

	<!-- 검색조건유지 -->
	<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${searchMap.recordCountPerPage }">
	<input type="hidden" id = "searchOpenYn" name = "searchOpenYn" value="${searchMap.searchOpenYn }">
	<input type="hidden" id = "searchDeleteFlag" name = "searchDeleteFlag" value="${searchMap.searchDeleteFlag }">
	<input type="hidden" id = "searchSelect" name = "searchSelect" value="${searchMap.searchSelect }">
	<input type="hidden" id = "searchTitle" name = "searchTitle" value="${searchMap.searchTitle }">
</form>

</section>