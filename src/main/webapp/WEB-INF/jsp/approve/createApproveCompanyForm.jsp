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
<%@ include file="./js/createApproveCompanyForm_JS.jsp" %>

<section id="detail_contents">
<form id = "frm" name = "frm" method="post">
	<input type="hidden" id = "popYn" name = "popYn" value="Y">
	<div class="doc_AllWrap">
		<div class="board_classic">
			<div class="leftblock">
				<span class="doc_read_check"><a href="javascript:openHelpPop()" class="btn_s_type_blue">&nbsp;사내서식 생성 방법 안내&nbsp;</a></span>
			</div>
			<!-- <div class="rightblock">
				공개비공개여부
				<input type="hidden" id = "openYn" name = "openYn" value="N">

				<span class="doc_read_check" id = "openYArea" style="display: none;"><a href="javascript:chgOpenYn('Y')" class="btn_s_type_red">&nbsp;공개문서&nbsp;</a></span>
				<span class="doc_read_check" id = "openNArea"><a href="javascript:chgOpenYn('N')" class="btn_s_type_blue">&nbsp;비공개문서&nbsp;</a></span>
			</div> -->
		</div>
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
					<td><input class="input_b w100pro" id="appvDocTypeName" name="appvDocTypeName" placeholder="문서타입"/></td>
					<th>구분</th>
					<td>
						<input type="hidden" id = "appvDocNumRuleMidNameChk" value="N">
						<input class="input_b w200px" id="appvDocNumRuleMidName" name="appvDocNumRuleMidName" onblur="appvDocNumRuleMidNameBlur()" placeholder="구분"/>
						<button type="button" class="btn_s_type2 mgl6" onclick="doAppvDocNumRuleMidNameChk();return false;"><em class="icon_search">유효검사</em></button>
						<span id = "appvDocNumRuleMidNameResult" style="color: red;"></span>
					</td>
				</tr>

				<tr>
					<th scope="row" id = "userTypeStaffTh"><label for="userType">대상자</label></th>
					<td>
						<span class="radio_list2">
							<label><input type="radio" name = "userType" value="LOGIN" checked="checked"><span>로그인사용자</span></label>
							<label><input type="radio" name = "userType" value="STAFF"><span>직원선택</span></label>
						</span>
					</td>
					<th scope="row"><label for="projectType">${baseUserLoginInfo.projectTitle }</label></th>
					<td>
						<span class="radio_list2">
							<label><input type="radio" name = "projectType" value="ING" checked="checked"><span>진행중인 ${baseUserLoginInfo.projectTitle }만</span></label>
							<label><input type="radio" name = "projectType" value="ALL"><span>진행과 중단/마감된 ${baseUserLoginInfo.projectTitle }포함</span></label>
						</span>
					</td>
				</tr>

				<tr>
					<th scope="row"><label for="approveLineType">결재라인</label></th>
					<td>
						<span class="radio_list2">
							<label><input type="radio" name = "approveLineType" value="SETTING" checked="checked"><span>결재라인 세팅값 사용</span></label>
							<label><input type="radio" name = "approveLineType" value="INPUT"><span>직접입력기능 함께사용</span></label>
						</span>
					</td>
					<th scope="row">일정</th>
					<td>
						<label><input type="checkbox" id = "scheduleUseYn" class="mgr3" name = "scheduleUseYn" value="Y" onclick="chkUseYn('scheduleUseYn')"><span>사용</span></label>
						<span class="radio_list2 mgl10" id = "scheduleUseYnArea" style="display: none;">
							<label><input type="radio" name = "scheduleUseType" value="MANDATORY" checked="checked"><span>필수입력</span></label>
							<label><input type="radio" name = "scheduleUseType" value="OPTION"><span>선택입력</span></label>
						</span>
					</td>
				</tr>

				<tr>
					<th scope="row">연결 결재문서</th>
					<td>
						<label><input type="checkbox" id = "linkDocUseYn" class="mgr3" name = "linkDocUseYn" onclick="chkUseYn('linkDocUseYn')" value="Y"><span>사용</span></label>
						<span class="radio_list2 mgl10" id = "linkDocUseYnArea" style="display: none;">
							<label><input type="radio" name = "linkDocUseType" value="MANDATORY" checked="checked"><span>필수입력</span></label>
							<label><input type="radio" name = "linkDocUseType" value="OPTION"><span>선택입력</span></label>
						</span>
					</td>
					<th scope="row">다른 ${baseUserLoginInfo.projectTitle } 선택 허용</th>
					<td>
						<span class="radio_list2">
							<label><input type="radio" name = "projectChoiceYn" value="Y" checked="checked"><span>허용</span></label>
							<label onclick="alert('준비중입니다.')"><input type="radio" name = "projectChoiceYn" value="N" disabled="disabled"><span>비허용</span></label>
						</span>
					</td>
				</tr>

				<tr>
					<th scope="row" id = "userTypeStaffTh">제목</th>
					<td>
						<label><input type="checkbox" id = "titleUseYn" class="mgr3" name = "titleUseYn" value="Y"><span>사용(필수입력)</span></label>

					</td>
					<th scope="row">파일첨부</th>
					<td>
						<label><input type="checkbox" id = "fileUseYn" class="mgr3" name = "fileUseYn" onclick="chkUseYn('fileUseYn')" value="Y"><span>사용</span></label>
						<span class="radio_list2 mgl10" id = "fileUseYnArea" style="display: none;">
							<label><input type="radio" name = "fileUseType" value="MANDATORY" checked="checked"><span>필수입력</span></label>
							<label><input type="radio" name = "fileUseType" value="OPTION"><span>선택입력</span></label>
						</span>
					</td>
				</tr>

				<tr>
					<th scope="row">내용</th>
					<td colspan="3" class="conEditor">
						<jsp:include page="/daumeditor/editor.jsp" flush="true">
	                		<jsp:param value="approve" name="type"/>
	                	</jsp:include>
						<input type="hidden" id="docContent" name = "docContent">
					</td>
				</tr>
				<tr>
					<th scope="row">공개여부</th>
					<td colspan="3">
						<span class="radio_list2">
							<label><input type="radio" name = "openYn" value="Y" onclick="javascript:chgOpenYn('Y')"><span>공개</span></label>
							<label><input type="radio" name = "openYn" value="N" onclick="javascript:chgOpenYn('N')" checked="checked"><span>비공개</span></label>
						</span>
						<span class="fontGray txt_letter0 mgl6">*미리보기로 설정내용 확인후 공개설정 필요</span>
					</td>
				</tr>
			</tbody>
		</table>
		<!--// 휴가/휴직/복직/신청서작성 //-->
		<!--버튼모음-->
		<div class="btn_baordZone2">
			<a href="javascript:openPreViewPop()" class="btn_blueblack2">미리보기</a>
			<a href="javascript:doSave()" class="btn_blueblack btn_auth">저장</a>
			<a href="javascript:goListPage()" class="btn_witheline">목록</a>
		</div>
		<!--//버튼모음//-->
	</div>
</form>
<div style="display: none;">
<div id="appvCompanyHelpPop" >
	<!--업무일지등록-->
	<div class="modalWrap2">
		<h1>사내서식 생성방법 안내</h1>
		<div class="mo_container">
			<!--guide이미지-->
			<p><img src="${pageContext.request.contextPath}/images/approve/img_doccom_info.png" alt="사내서식 생성방법 안내" /></p>
			<!--/guide이미지/-->
			<div class="btnZoneBox"><a href="javascript:myModal.close('my-modal-div')" class="p_withelin_btn">닫기</a></div>
		</div>
	</div>
</div>
</div>
</section>