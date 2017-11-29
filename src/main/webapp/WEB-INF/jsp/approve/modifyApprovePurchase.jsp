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
<%@ include file="./js/modifyApprovePurchase_JS.jsp" %>
<section id="detail_contents">
<form id = "frm" name = "frm" method="post">
	<!-- DocClass 고정.... -->
	<input type="hidden" id = "appvDocClass" name = "appvDocClass" value="BUY">
	<!-- 국내구매만 고정...(16.10.20) -->
	<input type="hidden" id = "appvDocType" name = "appvDocType" value="BUY_IN">

	<!-- 저장후 상세화면 이동 -->
	<input type="hidden" id = "appvDocId" name = "appvDocId" value="${detailMap.appvDocId }">

	<!-- 검색조건유지 : S -->
	<input type="hidden" id = "searchDocStatus" name = "searchDocStatus" value="${searchMap.searchDocStatus }">
	<input type="hidden" id = "searchTitle" name = "searchTitle" value="${searchMap.searchTitle }">
	<input type="hidden" id = "recordCountPerPage" name = "recordCountPerPage" value="${searchMap.recordCountPerPage }">
	<input type="hidden" id = "pageIndex" name = "pageIndex" value="${searchMap.pageIndex }">
	<!-- 검색조건유지 : E -->

	<!-- 프로젝트 정보 -->
	<input type="hidden" id = "activityId" name = "activityId" value="${detailMap.activityId }">
	<input type="hidden" id = "projectId" name = "projectId" value="${detailMap.projectId }">

	<!-- Popup에서 열렸을때 넘어오는 파라미터 -->
	<input type="hidden" name = "popYn" value="${popYn }">
	<input type="hidden" id = "amount" name = "amount" value="${detailMap.amount }">
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
					<th scope="row"><label for="projectId">${baseUserLoginInfo.projectTitle }</label></th>
					<td colspan="3">
						<div><strong>[${detailMap.projectNm}-${detailMap.activityNm}]</strong> 기간 : ${detailMap.activityStartDate} ~ ${detailMap.activityEndDate}</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="IDNAME11">제목</label></th>
					<td colspan="3"><input class="input_b w100pro" id="why" name="why" value="${detailMap.why }" /></td>
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
									<td class="txt_money" id = "sum">
										<fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${detailMap.amount }" />
									</td>
									<td>원</td>
									<td></td>
								</tr>
							</tfoot>
							<tbody>
								<c:forEach items="${detailMap.buyList }" var = "data">
									<tr>
										<td><input type="text" class="input_b w100pro" id = "itemNm" name= "itemNm" value="${data.itemNm }" title="구매물품명" /></td>
										<td><input type="text" class="input_mrb w100pro number" id = "price" name = "price" value="<fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${data.price }" />" title="단가"/></td>
										<td><input type="text" class="input_mrb w100pro number" id = "qty" name = "qty" value="<fmt:formatNumber type="CURRENCY" pattern="#,##0" value="${data.qty }" />" title="수량" maxlength="5"/></td>
										<td><input type="text" class="input_mrb w100pro number" id = "money" name = "money"  title="금액" readonly="readonly"/></td>
										<td><input type="text" class="input_b w100pro" id = "purMemo" name = "purMemo" title="비고" value="${data.memo }"  maxlength="100"/></td>
										<td><input type="button" class="btn_s_type_g" id = "deleteBtn" onclick="deleteItemList($(this));" value="삭제"></td>
									</tr>

								</c:forEach>

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
						<input type="hidden" id="memo" name = "memo" value='<c:out value="${detailMap.memo }"></c:out>'>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="siteUrl">참고사이트</label></th>
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
				<%-- <tr>
					<th scope="row">결재전열람</th>
					<td colspan="3"><label><input type="checkbox" id = "appvBeforeCcReadYn" name = "appvBeforeCcReadYn"
								value="Y" <c:if test="${detailMap.appvBeforeCcReadYn eq 'Y' }">checked="checked"</c:if>> 참조문서 결재완료전 보기 허용</label></td>
				</tr> --%>
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
		<!--// 구매요청서작성 //-->
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

<script type="text" id = "itemListBuf">
<tr>
	<td><input type="text" class="input_b w100pro" id = "itemNm" name= "itemNm" title="구매물품명" /></td>
	<td><input type="text" class="input_mrb w100pro number" id = "price" name = "price" title="단가"/></td>
	<td><input type="text" class="input_mrb w100pro number" id = "qty" name = "qty" title="수량" maxlength="5"/></td>
	<td><input type="text" class="input_mrb w100pro number" id = "money" name = "money" title="금액" readonly="readonly"/></td>
	<td><input type="text" class="input_b w100pro" id = "purMemo" name = "purMemo" title="비고"  maxlength="100"/></td>
	<td><input type="button" class="btn_s_type_g" id = "deleteBtn" onclick="deleteItemList($(this));" value="삭제"></td>
</tr>
</script>
</section>