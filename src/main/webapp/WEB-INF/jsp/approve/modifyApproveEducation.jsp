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

<%@ include file="./js/modifyApproveEducation_JS.jsp" %>
<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>
<script type="text/javascript">
	/* $(document).ready(function(){
		numberFormatForNumberClass();
	})
	//도움말팝업토글
	function showlayer(id)
	{
		$("#"+id).toggle();
	} */
</script>
<section id="detail_contents">
<form id = "frm" name = "frm" method="post">
	<!-- DocClass 고정.... -->
	<input type="hidden" id = "appvDocClass" name = "appvDocClass" value="EDUCATION">

	<!-- 연차휴가만 고정...(16.10.20) -->
	<input type="hidden" id = "appvDocType" name = "appvDocType" value="EDU_IN">

	<!-- 저장후 상세화면 이동 -->
	<input type="hidden" id = "appvDocId" name = "appvDocId" value="${detailMap.appvDocId }">

	<!-- 프로젝트 정보 -->
	<input type="hidden" id = "activityStartDate" name = "activityStartDate" value="${detailMap.activityStartDate }">
	<input type="hidden" id = "activityEndDate" name = "activityEndDate" value="${detailMap.activityEndDate }">
	<input type="hidden" id = "projectStartDate" name = "projectStartDate" value="${detailMap.projectStartDate }">
	<input type="hidden" id = "lastDate" name = "lastDate" value="${detailMap.lastDate }">
	<input type="hidden" id = "activityId" name = "activityId" value="${detailMap.activityId }">
	<input type="hidden" id = "projectId" name = "projectId" value="${detailMap.projectId }">

	<!-- Popup에서 열렸을때 넘어오는 파라미터 -->
	<input type="hidden" name = "popYn" value="${popYn }">
	<div class="doc_AllWrap">
		<c:if test="${popYn eq 'M' }"><h3 style="font-family:'NanumBarun'; font-size:30px; letter-spacing:0; text-align:center; line-height:1.4; ">교육신청</h3></c:if>
		<!--교육신청/완료보고작성-->
		<table class="tb_regi_basic" summary="교육신청/완료보고 (문서종류, 결재자, 신청자, 연락처, 소속/직위,연락처, 휴가기간, 사용일/잔여일, 사유, 업무인수자, 대결자, 참조인선택)">
			<caption>교육신청/완료보고작성</caption>
			<colgroup>
				<col width="105" />
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
					<th scope="row"><label for="IDNAME05">연락처</label></th>
					<td colspan="3">${baseUserLoginInfo.mobile }</td>
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
					<th>교육기간</th>
					<td colspan="3">
						<input type="text" value="${detailMap.dateFrom }" id="dateFrom" name="dateFrom" class="input_b input_date_type" title="시작일"/>

						 ~
						<input type="text" value="${detailMap.dateTo }" id="dateTo" name="dateTo" class="input_b input_date_type" title="종료일" />
						<select class="select_b mgl20" id = "hourFrom" name = "hourFrom" >
							<c:forEach var = "i" begin="0" end="23" step="1">
								<option value="${i }" <c:if test = "${detailMap.hourFrom eq i }">selected="selected"</c:if>><c:if test = "${i<10}">0</c:if>${i }
							</c:forEach>
							</select>
							 시
							<select class="select_b" id = "minuteFrom" name = "minuteFrom">
								<option value="0"  <c:if test = "${detailMap.minuteFrom eq 0 }">selected="selected"</c:if>>00</option>
								<option value="30" <c:if test = "${detailMap.minuteFrom eq 30 }">selected="selected"</c:if>>30</option>
							</select>
							분
						~
						<select class="select_b" id = "hourTo" name = "hourTo">
							<c:forEach var = "i" begin="0" end="23" step="1">
								<option value="${i }" <c:if test = "${detailMap.hourTo eq i }">selected="selected"</c:if>><c:if test = "${i<10}">0</c:if>${i }</option>
							</c:forEach>
						</select>
							 시
						<select class="select_b" id = "minuteTo" name = "minuteTo">
							<option value="0" <c:if test = "${detailMap.minuteTo eq 0 }">selected="selected"</c:if>>00</option>
							<option value="30" <c:if test = "${detailMap.minuteTo eq 30 }">selected="selected"</c:if>>30</option>
						</select>
							분

						<span class="mgl10">(</span>
						<input type="text" class="input_b w42px" id = "eduDay" name = "eduDay" value="${detailMap.eduDay }" title="교육총일수" maxlength="4" onkeyup="isNumChk($(this))"/>
						<span>일간, 총</span>
						<input type="text" class="input_b w42px" id = "eduTime" name = "eduTime" value="${detailMap.eduTime }" title="교육총시간" maxlength="3" onkeyup="isNumChk($(this))"/>
						<span>시간)</span>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="projectId">${baseUserLoginInfo.projectTitle }</label></th>
					<td colspan="3">
						<div><strong>[${detailMap.projectNm}-${detailMap.activityNm}]</strong> 기간 : ${detailMap.activityStartDate} ~ ${detailMap.activityEndDate}</div>
					</td>
				</tr>
				<tr>
					<th><label for="eduName">교육과정명</label></th>
					<td><input class="input_b w100pro" id="eduName" name="eduName" value="${detailMap.eduName }"/></td>
					<th><label for="eduAgency">교육기관</label></th>
					<td><input class="input_b w100pro" id="eduAgency" name="eduAgency" value="${detailMap.eduAgency }"/></td>
				</tr>
				<tr>
					<th>출근인정여부</th>
					<td>
						<span class="radio_list2">
							<label>
								<input type="radio" id = "attendYn" name="attendYn" value="Y"
									<c:if test = "${detailMap.attendYn eq 'Y' }">checked="checked"</c:if>
								/><span>출근인정</span>
							</label>
							<label>
								<input type="radio" id = "attendYn" name="attendYn" value="N"
									<c:if test = "${detailMap.attendYn eq 'N' }">checked="checked"</c:if>
								><span>출근미인정</span>
							</label>
						</span>
						<span class="tooltip" style="z-index: 999999;">
							<a href="javascript:showlayer('helpEducation')" class="icon_question2 mgl10"><em>출근인정규정</em></a>
							<div id="helpEducation" class="tooltip_box" style="display:none;">
								<h3 class="title">출근인정규정</h3>
								<span class="intext">
									<ul class="list_st_dot">
										<li>교육으로 인한 출근인정은 반드시 부서장과 협의하여 사전 승인을 받아야 합니다.</li>
									</ul>
									<p class="excerption">기준일 (2016.10.11)</p>
								</span>
								<em class="edge_topcenter"></em>
								<a href="javascript:showlayer('helpEducation')" class="closebtn"><img src="../images/network/btn_tooltip_closed.gif" alt="닫기"></a>
							</div>
						</span>
					</td>
					<th><label for="IDNAME89">완료보고여부</label></th>
					<td>
						<span class="radio_list2">
							<label>
								<input type="radio" id ="reportYn" name="reportYn" value="Y"
									<c:if test = "${detailMap.reportYn eq 'Y' }">checked="checked"</c:if>
								 /><span>작성</span>
							</label>
							<label>
								<input type="radio" id ="reportYn" name="reportYn" value="N"
									<c:if test = "${detailMap.reportYn eq 'N' }">checked="checked"</c:if>
								><span>미작성</span>
							</label>
						</span>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="eduPrice">금액</label></th>
					<td colspan="3"><input class="money_input_b w180px number" name = "amount" id="amount"
						value="<fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${detailMap.amount }" />"
					/> <span>원</span></td>
				</tr>
				<tr>
					<th scope="row" id = "eduWorkerTh"
						<c:choose>
							<c:when test = "${fn:length(detailMap.eduWorkerList)>0 }">
								rowspan="2"
							</c:when>
							<c:otherwise>
								rowspan="1"
							</c:otherwise>
						</c:choose>
					>교육참여자</th>
					<td colspan="3">
						<a href="javascript:openSelectUserPop('eduWorker')" class="btn_select_employee"><em>직원선택</em></a>
					</td>
				</tr>
				<tr id = "eduWorkerTr"
					<c:choose>
						<c:when test = "${fn:length(detailMap.eduWorkerList)>0 }">

						</c:when>
						<c:otherwise>
							style="display:none"
						</c:otherwise>
					</c:choose>
				>
					<td colspan="3" class="dot_line" id = "eduWorkerArea">
						<c:forEach var = "data" items="${detailMap.eduWorkerList }" varStatus="i">
							<span class="employee_list eduWorkerList" id = 'eduWorkerList_${data.userId }'>
							<span>
								<c:if test="${i.index != 0 }"><div id = 'eduWorkerList_comma' style='display:inline'>,</div></c:if>
								${data.userNm }</span><em>(${data.userRankNm })</em>
							<input type="hidden" id = "eduWorkerId" name = "eduWorkerId" value="${data.userId }">
							<a href="javascript:deleteStaff('eduWorker','${data.userId }')" class="btn_delete_employee"><em>삭제</em></a></span>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="IDNAME07">교육내용</label></th>
					<td colspan="3" class="conEditor">
						<jsp:include page="/daumeditor/editor.jsp" flush="true">
	                		<jsp:param value="approve" name="type"/>
	                	</jsp:include>
						<input type="hidden" id="memo" name = "memo" value='<c:out value="${detailMap.memo }"></c:out>'>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="IDNAME10">참고사이트</label></th>
					<td colspan="3">
						<textarea class="txtarea_b3 w100pro" id="siteUrl" name="siteUrl" placeholder="참고사이트 입력">${detailMap.siteUrl }</textarea>
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
						<a id = "approveRcBtn" href="javascript:openSelectUserPop('approveRc')" class="btn_select_employee mgl10"
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
		<!--// 교육신청/완료보고작성 //-->
		<!--버튼모음-->
		<div class="btn_baordZone2">
			<a href="javascript:doSave()" class="btn_blueblack btn_auth">확인</a>
			<c:choose>
				<c:when test="${popYn eq 'M' }">
					<a href="javascript:window.close()" class="btn_witheline">닫기</a>
				</c:when>
				<c:otherwise>
					<a href="javascript:goDraftListPage()" class="btn_witheline">취소</a>
				</c:otherwise>
			</c:choose>
		</div>
		<!--//버튼모음//-->
	</div>
</form>

</section>