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

<%@ include file="./js/reqPurchase_JS.jsp" %>

<section id="detail_contents">

<form id = "frm" name = "frm" method="post">
	<!-- DocClass 고정.... -->
	<input type="hidden" id = "appvDocClass" name = "appvDocClass" value="BUY">
	<!-- 국내구매만 고정...(16.10.20) -->
	<input type="hidden" id = "appvDocType" name = "appvDocType" value="BUY_IN">

	<!-- 저장후 상세화면 이동 -->
	<input type="hidden" id = "appvDocId" name = "appvDocId">

	<!-- 검색조건유지 : S -->
	<input type="hidden" id = "searchDocStatus" name = "searchDocStatus" value="${searchMap.searchDocStatus }">
	<input type="hidden" id = "searchTitle" name = "searchTitle" value="${searchMap.searchTitle }">
	<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${searchMap.recordCountPerPage }">
	<input type="hidden" id = "pageIndex" name = "pageIndex" value="${searchMap.pageIndex }">
	<!-- 검색조건유지 : E -->

	<!-- Popup에서 열렸을때 넘어오는 파라미터 -->
	<input type="hidden" name = "popYn" value="${popYn }">
	<input type="hidden" id = "amount" name = "amount">
	<div class="doc_AllWrap">
	    <c:if test="${popYn eq 'M' }"><h3 style="font-family:'NanumBarun'; font-size:30px; letter-spacing:0; text-align:center; line-height:1.4; ">구매신청</h3></c:if>
		<!--구매요청서작성-->
		<table class="tb_regi_basic" summary="구매신청 신청(문서종류, 결재자, 신청자, 연락처, 소속/직위,연락처, 휴가기간, 사용일/잔여일, 사유, 업무인수자, 대결자, 참조인선택)">
			<caption>구매신청 신청서작성</caption>
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
					<th scope="row"><label for="projectId">${baseUserLoginInfo.projectTitle }</label></th>
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
					<th scope="row"><label for="IDNAME11">제목</label></th>
					<td colspan="3"><input class="input_b w100pro" id="why" name="why" /></td>
				</tr>
				<tr>
					<th>구매내역</th>
					<td colspan="3">
						<p><a href="javascript:addItemList()" class="btn_s_type_g"><em class="add">항목추가</em></a></p>
						<table class="purchase_grid_tb mgt10 mgb10" summary="구매내역입력(구매물품, 단가, 수량, 금액)" id = "itemListTable">
							<caption>구매내역입력</caption>
							<colgroup>
								<col width="*" />
								<col width="15%" />
								<col width="60" />
								<col width="17%" />
								<col width="25%" />
								<col width="60" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">구매물품</th>
									<th scope="col">단가</th>
									<th scope="col">수량</th>
									<th scope="col">금액</th>
									<th scope="col">비고</th>
									<th scope="col"></th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<th colspan="3">총계</th>
									<td class="txt_money" id = "sum">0

									</td>
									<td>원</td>
									<td></td>
								</tr>
							</tfoot>
							<tbody>
								<tr>
									<td><input type="text" class="input_b w100pro" id = "itemNm" name= "itemNm" title="구매물품명" /></td>
									<td><input type="text" class="input_mrb w100pro number" id = "price" name = "price" title="단가"/></td>
									<td><input type="text" class="input_mrb w100pro number" id = "qty" name = "qty" title="수량" maxlength="5"/></td>
									<td><input type="text" class="input_mrb w100pro number" id = "money" name = "money" title="금액" readonly="readonly"/></td>
									<td><input type="text" class="input_b w100pro" id = "purMemo" name = "purMemo" title="비고" maxlength="100"/></td>
									<td><button type="button" class="btn_s_type_g" id = "deleteBtn" onclick="deleteItemList($(this));">삭제</button></td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<th><label for="memo">구매목적/<br>기대효과</label></th>
					<td colspan="3" class="conEditor">
						<jsp:include page="/daumeditor/editor.jsp" flush="true">
	                		<jsp:param value="approve" name="type"/>
                		</jsp:include>
						<input type="hidden" id="memo" name = "memo">
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="siteUrl">참고사이트</label></th>
					<td colspan="3">
						<textarea class="txtarea_b3 w100pro" id="siteUrl" name="siteUrl" placeholder="참고사이트 입력"></textarea>
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
						<input id = "decisionYn" name = "decisionYn" value="Y" type="checkbox" class="mgl10 mgr3" onchange="decisionYnChk()"><span>금액별 전결규정 자동 적용</span></label>
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

<script type="text" id = "itemListBuf">
<tr>
	<td><input type="text" class="input_b w100pro" id = "itemNm" name= "itemNm" title="구매물품명" /></td>
	<td><input type="text" class="input_mrb w100pro number" id = "price" name = "price" title="단가"/></td>
	<td><input type="text" class="input_mrb w100pro number" id = "qty" name = "qty" title="수량" maxlength="5"/></td>
	<td><input type="text" class="input_mrb w100pro number" id = "money" name = "money" title="금액" readonly="readonly"/></td>
	<td><input type="text" class="input_b w100pro" id = "purMemo" name = "purMemo" title="비고"  maxlength="100"/></td>
	<td><button type="button" class="btn_s_type_g" id = "deleteBtn" onclick="deleteItemList($(this));">삭제</button></td>
</tr>
</script>
