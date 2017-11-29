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
<%@ include file="./js/reqTrip_JS.jsp" %>
<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>

<script type="text" id = "tripListBuf">
<tr>
	<td>
		<div class = "tripTypeArea"></div>
	</td>
	<td><input type="text" class="input_b w100pro" id = "tripMemo" name = "tripMemo" title="산출근거" /></td>
	<td><input type="text" class="input_mrb w100pro number" id = "price" name = "price" title="금액" /></td>
	<td><button type = 'button' class="btn_s_type_g" onclick="deleteTripList($(this))">삭제</button></td>
</tr>
</script>


<section id="detail_contents">

<form id = "frm" name = "frm" method="post">
	<!-- 자동 submit방지 -->
	<!-- DocClass 고정.... -->
	<input type="hidden" id = "appvDocClass" name = "appvDocClass" value="TRIP">

	<!-- 연차휴가만 고정...(16.10.20) -->
	<input type="hidden" id = "appvDocType" name = "appvDocType" value="TRIP_IN">

	<!-- 저장후 상세화면 이동 -->
	<input type="hidden" id = "appvDocId" name = "appvDocId">

	<!-- Popup에서 열렸을때 넘어오는 파라미터 -->
	<input type="hidden" name = "popYn" value="${popYn }">
	<div class="doc_AllWrap">
	    <c:if test="${popYn eq 'M' }"><h3 style="font-family:'NanumBarun'; font-size:30px; letter-spacing:0; text-align:center; line-height:1.4; ">출장신청</h3></c:if>
		<!--구매요청서작성-->
		<table class="tb_regi_basic" summary="출장신청 신청(문서종류, 결재자, 신청자, 연락처, 소속/직위,연락처, 휴가기간, 사용일/잔여일, 사유, 업무인수자, 대결자, 참조인선택)">
			<caption>출장신청 신청서작성</caption>
			<colgroup>
				<col width="100" />
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
					<th>차량사용여부</th>
					<td colspan="3">
						<span class="radio_list2">
							<label><input type="radio" name="tripCar" value="Y" /><span>사용</span></label>
							<label><input type="radio" name="tripCar" value="N" checked="checked"/><span>사용안함</span></label>
						</span>
					</td>
				</tr>
				<tr>
					<th>출장기간</th>
					<td>
						<input type="text" value="2015/06/15" id="dateFrom" name="dateFrom" class="input_b input_date_type" title="시작일" />
						<span class="dashLine">~</span>
						<input type="text" value="2015/06/15" id="dateTo" name="dateTo" class="input_b input_date_type" title="종료일" />
					</td>
					<th><label for="IDNAME89">완료보고여부</label></th>
					<td>
						<span class="radio_list2">
							<label><input type="radio" id ="reportYn" name="reportYn" value="Y" checked="checked" /><span>작성</span></label>
							<label><input type="radio" id ="reportYn" name="reportYn" value="N"><span>미작성</span></label>
						</span>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="projectId">${baseUserLoginInfo.projectTitle }</label></th>
					<td colspan="3">
					<!-- <select class="select_b" title="일정분류선택" id = "scheType" name = "scheType">
					</select> -->

						<span id = "projectArea"></span>
						<span id = "activityArea">
							<select id = "activityId" name = "activityId" class="select_b mgl6">
								<option value="">${baseUserLoginInfo.activityTitle } 선택</option>
							</select>
						</span>
						<span id = "activityDescArea" class="mgl10"></span>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="IDNAME11">출장지</label></th>
					<td colspan="3">
						<div id = "selectTripLoc" style="display: inline;">
							<a href="javascript:openSearchCompanyPop()" class="btn_s_type_g">
								<em>회사선택</em>
							</a>
							<input class="input_b w30pro mgl6" id = "cpnNm" readonly="readonly" placeholder="회사선택" title="회사선택" />
							<input type="hidden" name = "cpnId" id = "cpnId" >



							<a href="javascript:customerPopUp()" class="btn_s_type_g mgl20">
								<em>고객선택</em>
							</a>

							<input class="input_b w30pro mgl6" id="userNm" readonly="readonly" placeholder="고객선택" title="고객선택" />
							<input type="hidden" name = "cstId" id = "cstId" >
						</div>
						<div id = "inputTripLoc" style="display: none;">
							<input class="input_b" style="width:82%;" id="tripLoc" name = "tripLoc" placeholder="출장지 직접입력" />
						</div>
						<span style="display: inline;" class="radio_list2 mgl10"><label><input type="checkbox" id="toggleTlipLoc" onclick="toggleTlipLoc2()" /><span><strong>직접입력</strong></span></label></span>

					</td>
				</tr>
				<tr>
					<th scope="row"><label for="IDNAME99">출장목적</label></th>
					<td colspan="3">
						<input class="input_b w100pro" id="tripWhy" name = "why" placeholder="출장목적 직접입력" />
					</td>
				</tr>
				<tr>
					<th>출근인정여부</th>
					<td colspan="3">
						<span class="radio_list2">
							<label>
								<input type="radio" id = "attendYn" name="attendYn" value="Y" checked="checked" /><span>출근인정</span>
							</label>
							<label>
								<input type="radio" id = "attendYn" name="attendYn" value="N"><span>출근미인정</span>
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
				</tr>
				<tr>
					<th scope="row"><label for="IDNAME99">출장내용</label></th>
					<td colspan="3" class="conEditor">
						<jsp:include page="/daumeditor/editor.jsp" flush="true">
	                		<jsp:param value="approve" name="type"/>
	                	</jsp:include>
						<input type="hidden" id="memo" name = "memo">
					</td>
				</tr>
				<tr>
					<th scope="row" id = "tripWorkerTh">출장동행자</th>
					<td colspan="3">
						<a href="javascript:openSelectUserPop('tripWorker')" class="btn_select_employee"><em>직원선택</em></a>
					</td>
				</tr>
				<tr id = "tripWorkerTr" style="display: none;">
					<td colspan="3" id = "tripWorkerArea" class="dot_line">

					</td>
				</tr>
				<tr>
					<th scope="row" rowspan="1" id = "beforeReqAmountTh">출장비<br>산출내역</th>
					<td colspan="3">
						<span class="radio_list2"><label><input type="checkbox" id="beforeReqAmount" onclick="beforeReqAmountChk()" /><span><strong>출장비 사전신청</strong></span></label></span>
						<!--체크박스활성시 나타남--><span class="spe_color_st6 mgl10">* 출장비내역을 입력해주세요!</span>
					</td>
				</tr>
				<tr id = "beforeReqAmountArea" style="display: none;">
					<td colspan="3" class="dot_line">
						<p><a href="javascript:addTripList()" class="btn_s_type_g"><em class="add">항목추가</em></a></p>
						<table class="purchase_grid_tb mgt10 mgb10" summary="출장비내역 입력(구분, 산출근거, 금액)" id = "tripListTable">
							<caption>출장비내역 입력</caption>
							<colgroup>
								<col width="120" />
								<col width="*" />
								<col width="23%" />
								<col width="62" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">구분</th>
									<th scope="col">산출근거</th>
									<th scope="col">금액</th>
									<th scope="col"></th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<th colspan="2">합계</th>
									<td class="txt_money" id = "sum">0</td>
									<td>원
										<input type="hidden" id = "amount" name = "amount" value="0">
									</td>
								</tr>
							</tfoot>
							<tbody>
								<tr>
									<td>
										<div class = "tripTypeArea"></div>
									</td>
									<td><input type="text" class="input_b w100pro" id = "tripMemo" name = "tripMemo" title="산출근거" /></td>
									<td><input type="text" class="input_mrb w100pro number" id = "price" name = "price" title="금액" /></td>
									<td><button type="button" class="btn_s_type_g" onclick="deleteTripList($(this));">삭제</button></td>
								</tr>
							</tbody>
						</table>
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
						<a id = "approveCcBtn" href="javascript:openSelectUserPop('approveCc')" class="btn_select_employee" style="display: none;">
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
		<!--// 구매요청서작성 //-->
		<!--버튼모음-->
		<div class="btn_baordZone2">
			<a href="javascript:doSave()" class="btn_blueblack btn_auth btn_myOrg">임시저장</a>
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
