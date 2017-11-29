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

<%@ include file="./js/modifyApproveBasic_JS.jsp" %>
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
	<input type="hidden" id = "appvDocClass" name = "appvDocClass" value="BASIC">

	<!-- 연차휴가만 고정...(16.10.20) -->
	<input type="hidden" id = "appvDocType" name = "appvDocType" value="BASIC">

	<!-- 저장후 상세화면 이동 -->
	<input type="hidden" id = "appvDocId" name = "appvDocId" value="${detailMap.appvDocId }">

	<!-- 프로젝트 정보 -->
	<input type="hidden" id = "activityStartDate" name = "activityStartDate" value="${detailMap.activityStartDate }">
	<input type="hidden" id = "activityEndDate" name = "activityEndDate" value="${detailMap.activityEndDate }">
	<input type="hidden" id = "projectStartDate" name = "projectStartDate" value="${detailMap.projectStartDate }">
	<input type="hidden" id = "lastDate" name = "lastDate" value="${detailMap.lastDate }">
	<input type="hidden" id = "docStatus" name = "docStatus" value="${detailMap.docStatus }">

	<!-- Popup에서 열렸을때 넘어오는 파라미터 -->
	<input type="hidden" name = "popYn" value="${popYn }">
	<div class="doc_AllWrap">
		<c:if test="${popYn eq 'M' }"><h3 style="font-family:'NanumBarun'; font-size:30px; letter-spacing:0; text-align:center; line-height:1.4; ">기본양식</h3></c:if>
		<!--기본양식/완료보고작성-->
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
					<th scope="row"><label for="docTitle">문서타이틀</label></th>
					<td colspan="3"><input class="input_b w100pro" id="docTitle" name="docTitle" placeholder="문서타이틀" value="${detailMap.title }"/></td>
				</tr>
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
					<th>${baseUserLoginInfo.projectTitle }</th>
					<td colspan="3">
						<div id = "projectSelectBefore" <c:if test = "${not empty detailMap.projectId}">style="display: none;"</c:if>>
							<a href="javascript:openApproveProjectPop()" class="btn_s_type_g"><em>${baseUserLoginInfo.projectTitle }선택</em></a>
						</div>
						<div id = "projectSelectAfter" <c:if test = "${empty detailMap.projectId}">style="display: none;"</c:if>>
							<span id = "projectName">${detailMap.projectNm }(${detailMap.projectCode })</span>
							<span id = "activityArea">
								<select id = "activityId" name = "activityId" class="select_b mgl6">
									<option value="">${baseUserLoginInfo.activityTitle } 선택</option>
								</select>
							</span>
							<span id = "activityDescArea" class="mgl10"></span>
							<button type="button" class="mgl6 btn_s_replay" onclick="doRefleshProject()"><em>부모코드초기화</em></button>
							<c:if test = "${not empty detailMap.projectId}">
								<script type="text/javascript">
									var commonActivity = getCommonProject('CD', 'NM', '', '${baseUserLoginInfo.activityTitle } 선택', { orgId : "${baseUserLoginInfo.orgId }",projectId : "${detailMap.projectId}"  ,type:"ACTIVITY",incApproveActivity:"Y",enableChk:"N"});
									var activityTag = createSelectTagForProject('activityId', commonActivity, 'CD', 'NM', '${detailMap.activityId}', "activityIdChg($(this))", colorObj, null, 'select_b mgl6','ACTIVITY');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
									$("#activityArea").html(activityTag);

									activityIdChg($("#activityId"));

								</script>
							</c:if>
						</div>

						<input type="hidden" id = "projectId" name = "projectId" value="${detailMap.projectId }">
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="why">제목</label></th>
					<td colspan="3"><input class="input_b w100pro" id="why" name="why" placeholder="제목입력" value="${detailMap.why }"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="IDNAME07">내용</label></th>
					<td colspan="3" class="conEditor">
						<jsp:include page="/daumeditor/editor.jsp" flush="true">
	                		<jsp:param value="approve" name="type"/>
	                	</jsp:include>
						<input type="hidden" id="memo" name = "memo" value='<c:out value="${detailMap.memo }"></c:out>'>
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
	                   <label ><input id = "individualYn" name = "individualYn" value="Y" type="checkbox"
	                   			<c:if test = "${detailMap.individualYn eq 'Y' }">checked="checked"</c:if>
	                   			class="mgl10 mgr3" onchange="individualChk()"><span>직접선택</span></label>
	                   	<a id = "appvLineBtn" class="btn_s_type_g mgl5" href="javascript:openAppvLinePop()" style="display: none;"><em>결재라인작성</em></a>
						<%-- <div id = "approveLineArea">
							<jsp:include page="./include/reqPageApproveLine_INC.jsp"></jsp:include>
						</div> --%>
					</td>
				</tr>
				<tr id = "approveLineTr" style="display: none;">
					<td colspan="3" class="dot_line">
						<div id = "approveLineArea">
							<c:if test = "${detailMap.individualYn eq 'Y' }">
								<jsp:include page="./include/reqPageApproveLine_INC.jsp"></jsp:include>
							</c:if>
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
		<!--// 기본양식/완료보고작성 //-->
		<div id = "lineIndividualArea" style="display: none;">
		<c:if test="${fn:length(approveLineList)>0}">
		<!-- 등록/수정페이지 -->
	    <table id="lineTable" class="datagrid_input" summary="결재라인 관리 (문서이름, 타입, 금액, 사용여부, 마감여부, 수정자, 등록자)"  arrayVoName="approveVoList" >
	        <caption>프로젝트목록</caption>
	        <colgroup>
	            <col width="100" />
	            <col width="14%" />
	            <col width="14%" />
	            <col width="*" />
	            <col width="80" />
	        </colgroup>
	        <thead>
	            <tr>
	                <th scope="col">승인순서</th>
	                <th scope="col">승인방식</th>
	                <th scope="col">결재유형</th>
	                <th scope="col">상세유형</th>
	                <!-- <th scope="col">수정자</th> -->
	                <th scope="col">삭제</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="result" items="${approveLineList}" varStatus="status">
	            <tr id="lineTableTr">
	                <td class="txt_center">
	                    <input type="hidden" id="appVoList.deptId" name="appVoList.deptId" value="${result.deptId}" />
	                    <input type="hidden" id="appVoList.appvUserId" name="appVoList.appvUserId" value="${result.appvUserId}" />
	                    <input type="text" id="appVoList.appvSeq" name="appVoList.appvSeq"  value="${result.appvSeq}"  maxlength="4"  class="input_b w_st06" title="승인순서입력" />
	                </td>
	                <td class="txt_center">
	                    <select id="appVoList.appvClass" name="appVoList.appvClass" class="select_b w100pro" title="승인방식선택">
	                        <!-- <option value="">승인방식선택</option> -->
	                        <!-- <option value="APPROVAL">결재</option> -->
	                        <c:forEach var="cmmCd1" items="${cmmCdAppvClassList}" varStatus="status1">
	                            <option value="${cmmCd1.cd}"  ${result.appvClass eq cmmCd1.cd ? 'selected' : ''}>${cmmCd1.nm}</option>
	                        </c:forEach>
	                    </select>
	                </td>
	                <td>
	                    <select id="appVoList.appvLineType" name="appVoList.appvLineType" disabled = "disabled" onChange="changeAppvLineType(this);" class="select_b w100pro" title="결재유형선택">
	                        <option value="">결재유형선택</option>
	                        <c:forEach var="cmmCd2" items="${cmmCdAppvLineTypeList}" varStatus="status2">
	                            <option value="${cmmCd2.cd}"  ${result.appvLineType eq cmmCd2.cd ? 'selected' : ''}>${cmmCd2.nm}</option>
	                        </c:forEach>
	                    </select>
	                </td>
	                <td>
	                    <span id="spanSelectAppvLineBtn">
	                        <c:choose>
	                            <c:when test="${result.appvLineType eq 'OTHER_DEPT'}">
	                                <a onclick="javascript:fnObj.openUserPopup(this, 'DEPT');" class="btn_select_team"><em>부서선택</em></a>
	                            </c:when>
	                            <c:when test="${result.appvLineType eq 'USER'}">
	                                <a onclick="javascript:fnObj.openUserPopup(this, 'USER');" class="btn_select_employee"><em>직원선택</em></a>
	                            </c:when>
	                        </c:choose>
	                    </span>
	                    <span id="spanAppvLineDisplayNm" class="spanAppvLineDisplayNm">
	                        <c:choose>
	                            <c:when test="${result.appvLineType eq 'OTHER_DEPT'}">
	                                ${result.deptNm}
	                            </c:when>
	                            <c:when test="${result.appvLineType eq 'USER'}">
	                                ${result.appvUserNm}(${result.appvDeptNm}/${result.rankNm})
	                            </c:when>
	                            <c:otherwise>
	                                ${result.appvLineTypeNm}
	                            </c:otherwise>
	                        </c:choose>
	                     </span>
	                </td>
	                <%-- <td class="txt_center">${result.updatedNm}</td> --%>
	                <td class="txt_center"><button type="button" onClick="deleteRowLine(this);" class="btn_s_type_g btn_auth">삭제</button></td>
	            </tr>
	            </c:forEach>
	            <c:if test="${fn:length(approveLineList) <= 0 }">
	            <tr>
	                <td id="lineTableNoData" class="no_result" colspan="6">결재라인을 추가해 주세요.</td>
	            </tr>
	            </c:if>
	        </tbody>
	    </table>
	    <!--버튼영역-->
		<div class="btn_baordZone2">
		    <a href="javascript:addRowLine();" class="btn_blueblack btn_auth">결재라인 추가</a>
		    <a href="javascript:doSaveAppLine();" class="btn_witheline btn_auth">저장</a>
		    <a href="javascript:parent.myModal2.close();" class="btn_witheline btn_auth">닫기</a>
		</div>
		<!--//버튼영역//--></c:if></div>
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