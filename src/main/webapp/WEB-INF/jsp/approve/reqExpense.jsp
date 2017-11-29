<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<% pageContext.setAttribute("LF", "\n"); %>
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
<%@ include file="./js/reqExpense_JS.jsp" %>

<section id="detail_contents">

<form id = "frm" name = "frm" method="post">
	<!-- DocClass 고정.... -->
	<input type="hidden" id = "appvDocClass" name = "appvDocClass" value="EXPENSE">
	<!-- 국내구매만 고정...(16.10.20) -->
	<input type="hidden" id = "appvDocType" name = "appvDocType" value="EXPENSE">

	<!-- 저장후 상세화면 이동 -->
	<input type="hidden" id = "appvDocId" name = "appvDocId">

	<!-- Popup에서 열렸을때 넘어오는 파라미터 -->
	<input type="hidden" name = "popYn"  id = "popYn" value="${popYn }">
	<input type="hidden" name = "selDate"  id = "selDate" value="${selDate }">

	<input type="hidden" id = "amount" name = "amount">
	<div class="doc_AllWrap">
	    <c:if test="${popYn eq 'M' }"><h3 style="font-family:'NanumBarun'; font-size:30px; letter-spacing:0; text-align:center; line-height:1.4; ">지출결의서</h3></c:if>
		<p class="table_notice" style="float: right;"><span class="point">* </span>필수입력입니다.</p>
		<!--구매요청서작성-->
		<table class="tb_regi_basic" summary="구매신청 신청(문서종류, 결재자, 신청자, 연락처, 소속/직위,연락처, 휴가기간, 사용일/잔여일, 사유, 업무인수자, 대결자, 참조인선택)">
			<caption>지출결의서작성</caption>
			<colgroup>
				<col width="120" />
				<col width="*" />
				<col width="110" />
				<col width="28%" />
			</colgroup>
			<tbody>
				<tr>
					<th>신청자</th>
					<td>${baseUserLoginInfo.userName }(${baseUserLoginInfo.mobile })</td>
					<th>소속/직위</th>
					<td>
						${baseUserLoginInfo.deptNm }<span class="dashLine"> / </span>
						${baseUserLoginInfo.rankNm }
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="projectId">${baseUserLoginInfo.projectTitle }<span class="star">*</span></label></th>
					<td colspan="3">
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
					<th id = "linkDocTh">연결 결재문서</th>
					<td>
						<div id = "refDocBefore">
							<a href="javascript:openApproveRefDocPop()" class="btn_s_type_g"><em>결재문서 선택</em></a>
						</div>
					</td>
					<th scope="row">청구/영수</th>
					<td>
						<label>
							<input type="radio" name="chargeType" value="CHARGE" checked="checked"/>
							<span>청구</span>
						</label>
						<label>
							<input type="radio" name="chargeType" value="RECEIVE"/>
							<span>영수</span>
						</label>
					</td>
				</tr>
				<tr id = "linkDocTr" style="display: none;">
					<td colspan="3" class="dot_line" id = "linkDocArea">
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="IDNAME11">제목<span class="star">*</span></label></th>
					<td colspan="3"><input class="input_b w100pro" id="why" name="why" /></td>
				</tr>
				<tr>
					<th>지출내역</th>
					<td colspan="3">
						<p><a href="javascript:addItemList()" class="btn_s_type_g"><em class="add">항목추가</em></a></p>
						<table class="purchase_grid_tb mgt10 mgb10" summary="구매내역입력(구매물품, 단가, 수량, 금액)" id = "itemListTable">
							<caption>구매내역입력</caption>
							<colgroup>
								<col width="120" />
								<col width="100" />
								<col width="80" />
								<col width="*" />
								<col width="120" />
								<col width="*" />
								<col width="60" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">지출일</th>
									<th scope="col">
										계정과목
										<span class="tooltip1" style="z-index: 9999999999;">
											<a href="javascript:showlayer(cardHlep)" class="btn_icon_advice"><em>도움말</em></a>
											<div id="cardHlep" class="tooltip_box" style="display:none;">
												<div class="wrap_autoscroll">
												   <span class="intext">
												       <span id ="accountToolTip"></span>  <!-- 계정과목 안내 툴팁 -->

							                            <h3 class="title">1. 영업관련 지출 등록 시!</h3>
										                <ul class="list_st_dot3 mgb10">
										                    <li class="f11">일정 필수</li>
										                </ul>
											            <h3 class="title">2. 교육비, 부서회식 지출 등록 시!</h3>
											            <ul class="list_st_dot3 mgb10">
										                    <li class="f11">대중교통비 : 해당일의 일정 필수, 부서회식 : 해당 일정 필수</li>
										                </ul>
											            <h3 class="title">3. 소모품 지출 등록 시!</h3>
											            <ul class="list_st_dot3 mgb10">
										                    <li class="f11">구입품목 개별 입력(영수증 내역과 동일할 경우 인정)</li>
										                </ul>
											        </span>
										            <em class="edge_topleft"></em>
										            <a href="javascript:showlayer(cardHlep)" class="closebtn_s"><img src="${pageContext.request.contextPath}/images/common/icon_car_tooltip_close.gif" alt="닫기" /></a>
										        </div>
										    </div>
										</span>
									</th>
									<th scope="col">지불유형</th>
									<th scope="col">적요</th>
									<th scope="col">금액</th>
									<th scope="col">비고</th>
									<th scope="col">삭제</th>
								</tr>
							</thead>
							<tbody id = "itemListTableTbody">
								<tr>
									<td><input type="text" id = "expenseDate_1" name = "expenseDate" value="" class="input_b input_date_type" title="시작일" /></td>
									<td id = "expenseTd">
									</td>
									<td>
										<select id="paymentType" name="paymentType" class="select_b w100pro" onchange="processItemPrice()">
											<option value="CASH">현금</option>
											<option value="CARD">카드</option>
										</select>
									</td>
									<td><input type="text" class="input_b w100pro" id = "summary" name = "summary" title="적요" maxlength="100"/></td>
									<td><input type="text" class="input_mrb w100pro number" id = "expenseAmount" name = "expenseAmount" title="금액" onblur="processItemPrice()"/></td>
									<td><input type="text" class="input_b w100pro" id = "comment" name = "comment" title="비고" maxlength="100"/></td>
									<td><button type="button" class="btn_s_type_g" id = "deleteBtn" onclick="deleteItemList($(this));">삭제</button></td>
								</tr>
							</tbody>
						</table>
						<!-- 총계 -->
						<table class="purchase_grid_tb">
							<caption>지출 총금액</caption>
							<colgroup>
								<col width="100" />
								<col width="80" />
								<col width="*" />
								<col width="120" />
								<col width="*" />
							</colgroup>
							<tbody>
								<tr>

									<th>소계</th>
									<th>현금</th>
									<td class="txt_money" id = "cash_sum">0원</td>
									<th>카드</th>
									<td class="txt_money" id = "card_sum">0원</td>
								</tr>
								<tr>
									<th>총계</th>
									<td class="txt_money" id = "sum" colspan="3">0
									</td>
									<td>원</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<th><label for="memo">내용</label></th>
					<td colspan="3" class="conEditor">
						<jsp:include page="/daumeditor/editor.jsp" flush="true">
	                		<jsp:param value="approve" name="type"/>
                		</jsp:include>
						<input type="hidden" id="memo" name = "memo" value='<c:out value="${fn:replace(appvReceiverSetup.memo, LF, '<br>')}" escapeXml="false"/>'>
					</td>
				</tr>
				<tr>
					<th scope="row">지불요청일</th>
					<td colspan="3">
						<select id = "expenseDay" name = "expenseDay" class="select_b">
							<option value="">선택</option>
							<c:forEach items="${appvDaySetupList }" var="data">
								<option value="${data.expenseDay }">${data.expenseDay eq 32?'말':data.expenseDay }일</option>
							</c:forEach>
						</select>

						 <label ><input id = "advanceWishYn" name = "advanceWishYn" value="Y" type="checkbox" class="mgl10 mgr3" onclick="chkAdvanceWishYn()"><span>선지급요망</span></label>
						 <span id = "advanceWishYArea" style="display: none;">
							 <input type="text" id = "advanceWishDate" name = "advanceWishDate" value="" class="input_b input_date_type mgl15" title="시작일" />

							 <input type="text" class="input_b mgr3 mgl10" style="width: 500px" id = "advanceWishReason" name = "advanceWishReason" placeholder="선지급요청사유를 입력해주세요." title="비고" maxlength="100"/>
						 </span>
					</td>
				</tr>
				<tr>
					<th scope="row">세금계산서<br>발행일</th>
					<td colspan="3">
						<input type="text" id = "taxBillIssueDate" name = "taxBillIssueDate" value="" class="input_b input_date_type" title="세금계산서발행일" />
						<span class="fontGray txt_letter0 mgl6">*발행시 날짜는 변경될수 있습니다.</span>
					</td>
				</tr>
				<tr>
					<th>파일첨부</th>
					<td colspan="3" class="r_addFileList">
		                <p class="posi_btn">

							<span id="fileInputArea" class="file_btn_bg"><input name="upFile" type="file" multiple onchange="newFileUpload();" class="file_btn_cover"></span>
							<span class="fontGray txt_letter0 mgl6 mgb5">*영수증파일의 명칭은 지출내역 번호와 동일하게 해주시면 업무처리에 용이합니다.</span>
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
					   <label ><input id = "individualYn" name = "individualYn" value="Y" type="checkbox" class="mgl10 mgr3" onchange="individualChk()"><span>직접선택</span></label>
					   <a id = "appvLineBtn" class="btn_s_type_g mgl5" href="javascript:openAppvLinePop()" style="display: none;"><em>결재라인작성</em></a>
					</td>
				</tr>
				<tr id = "approveLineTr" style="display: none;">
					<td colspan="3" class="dot_line">
						<div id = "approveLineArea">
						</div>
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
				<tr>
					<th scope="row" id = "approveRcTh">수신인선택<span class="star">*</span></th>
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
						<span class="sys_p_noti  mgl20">
							<span class="icon_noti"></span>
							<span class="pointB">재무담당자 : </span>
							<span>
								<c:forEach items="${appvManagerSetupList }" var="data">
									<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.userId }",$(this),"mouseover",null,5,-80,100)'>${data.userName }</span>(${data.rankNm })&nbsp;
								</c:forEach>
							</span>
						</span>
					</td>
				</tr>
				<tr id = "approveRcTr" style="display: none;">
					<td colspan="3" class="dot_line" id = "approveRcArea">
					</td>
				</tr>
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
	<div id = "lineIndividualArea" style="display: none;"></div>
</form>

</section>
<script type="text" id = "itemListBuf">
<tr>
	<td><input type="text" id = "expenseDate_##index##" name = "expenseDate" value="" class="input_b input_date_type" title="시작일" /></td>
	<td id = "expenseSelect##index##">
	</td>
	<td>
		<select id="paymentType" name="paymentType" class="select_b w100pro" onchange="processItemPrice()">
			<option value="CASH">현금</option>
			<option value="CARD">카드</option>
		</select>
	</td>
	<td><input type="text" class="input_b w100pro" id = "summary" name = "summary" title="적요" maxlength="100"/></td>
	<td>
		<input type="text" class="input_mrb w100pro number" id = "expenseAmount" name = "expenseAmount" title="금액" onblur="processItemPrice()"/>
	</td>
	<td><input type="text" class="input_b w100pro" id = "comment" name = "comment" title="비고" maxlength="100"/></td>
	<td><button type="button" class="btn_s_type_g" id = "deleteBtn" onclick="deleteItemList($(this));">삭제</button></td>
</tr>
</script>