<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<% pageContext.setAttribute("LF", "\n"); %>
<div class="doc_viewWarp">
    <div class="topline"></div>
    <div class="doc_viewWarp2">
    	<!-- 신규 수신확인/문서번호 : S -->
		<c:if test="${detailMap.docStatus ne 'WORKING'}">
			<p class="doc_codenum">문서번호 ${detailMap.appvDocNum}</p>
		</c:if>
		<!-- 신규 수신확인/문서번호 : E -->
        <!-- <p class="doc_codenum">품의번호 A2015-0125-5425</p> -->
        <h3 class="print_h3title">
        	<c:choose>
        		<c:when test="${detailMap.appvDocType eq 'ANNUAL' or detailMap.appvDocType eq 'ETC'}">
        			휴가신청서
        			<c:set var="dateStr" value="휴가기간"/>
        			<c:set var="memoStr" value="휴가내용"/>
        			<c:set var="titleStr" value="휴가  신청서"/>
        		</c:when>
        		<c:when test="${detailMap.appvDocType eq 'SICK' }">
        			병가신청서
        			<c:set var="dateStr" value="병가기간"/>
        			<c:set var="memoStr" value="병가내용"/>
        			<c:set var="titleStr" value="병가 신청서"/>
        		</c:when>
        		<c:when test="${detailMap.appvDocType eq 'REST' }">
        			휴직신청서
        			<c:set var="dateStr" value="휴직기간"/>
        			<c:set var="memoStr" value="휴직내용"/>
        			<c:set var="titleStr" value="휴직 신청서"/>
        		</c:when>

        	</c:choose>
        </h3>
        <table class="doc_print_tb_st01" summary="휴가신청서 보기(작성자, 신청일, 소속(직위), 연락처, 휴가기간, 휴가기간, 휴가내용, 업무대행자, 대결자, 참조인)">
            <caption>휴가신청서 보기</caption>
            <colgroup>
                <col width="120" />
                <col width="*" />
                <col width="120" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row">대상자</th>
                    <td>
					<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${detailMap.userId}",$(this),"mouseover",null,0,0,0)'>
						<strong>${detailMap.userNm}</strong>
					</span>
					</td>
                    <th scope="row">신청일</th>
                    <td><span class="txt_num"><fmt:formatDate value='${detailMap.createDate}' pattern='yyyy-MM-dd'/>(<fmt:formatDate value="${detailMap.createDate}" type="both" pattern="E"/>)</span></td>
                </tr>
                <tr>
                    <th scope="row">소속(직위)</th>
                    <td>${detailMap.userDeptNm}(${detailMap.userRankNm})</td>
                    <th scope="row">연락처</th>
                    <td><span class="txt_num">${detailMap.mobileTel}</span></td>
                </tr>
                <c:if test = "${fn:length(detailMap.approveLinkDocList)>0 }">
					<tr>
						<th scope="row">연결 결재문서</th>
						<td colspan="3">
							<c:forEach items="${detailMap.approveLinkDocList }" var="data">
								<div onclick="openAppvDocPop('${data.appvDocId}','${data.appvDocClass}','${data.appvDocType}')" style="cursor: pointer;text-decoration: underline;">
									문서번호&nbsp;${data.appvDocNum }&nbsp;&nbsp;${data.docTitle }
								</div>
							</c:forEach>

						</td>
					</tr>
				</c:if>
                <tr>
                    <th scope="row">${dateStr }</th>
                    <td colspan="3">
                        <span class="txt_num"><fmt:formatDate value='${detailMap.dateFrom}' pattern='yyyy-MM-dd'/>(<fmt:formatDate value="${detailMap.dateFrom}" type="both" pattern="E"/>)</span> ~
                        <span class="txt_num"><fmt:formatDate value='${detailMap.dateTo}'   pattern='yyyy-MM-dd'/>(<fmt:formatDate value="${detailMap.dateTo}" type="both" pattern="E"/>)</span>
                        <c:if test="${detailMap.allHalf eq 'ALL'}">
                        총<span class="txt_num">${detailMap.diffDay}</span>일
                        </c:if>
                        <c:if test="${not empty detailMap.appvDocTypeEtc }">
                        	${detailMap.appvDocTypeEtcNm }
                        </c:if>
                        <c:if test="${detailMap.allHalf ne 'ALL'}">
                        ${detailMap.allHalfNm}
                        </c:if>
                    </td>
                </tr>

                <tr>
                    <th scope="row">
                    	${memoStr }
                    	<a id = "btnMemoModify" class="btn_s_type_g mgl5 printOut btnAppvModify" href="javascript:openModify('CONTENTS')" style="display: none;"><em>수정</em></a>
                    	<a id = "btnMemoSave" class="btn_s_type_g mgl5 printOut" href="javascript:openSavePop('CONTENTS')" style="display: none;"><em>저장</em></a>
                    </th>
                    <td colspan="3"><div class="doc_subcon" id = "memoArea"><c:out value="${detailMap.memo}" escapeXml="false"/></div></td>
                </tr>
                <tr>
                    <th scope="row">업무대행자</th>
					<td>
						<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${detailMap.workAgencyId}",$(this),"mouseover",null,0,0,0)'>
							<strong>${detailMap.workAgencyNm}</strong>
						</span>
					</td>
					<th scope="row">대결자</th>
					<td>
						<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${detailMap.appvAgencyId}",$(this),"mouseover",null,0,0,0)'>
							<strong>${detailMap.appvAgencyNm}</strong>
						</span>
					</td>
                </tr>
               <tr class="printOut ccViewArea">
                	<th scope="row" <c:if test = "${fn:length(ccSetupList)>0 }">rowspan="2"</c:if>>참조인<a id = "btnMemoModify" class="btn_s_type_g mgl5 printOut btnAppvModify" href="javascript:openModify('CC')" style="display: none;"><em>수정</em></a></th>
                	<td colspan="3">
                		<c:choose>

                			<c:when test="${detailMap.approveCcType eq 'NONE' }">선택안함</c:when>
                			<c:when test="${detailMap.approveCcType eq 'MY_ORG_ALL' }">전체</c:when>
                			<c:when test="${detailMap.approveCcType eq 'MY_TEAM' }">소속팀</c:when>
                			<c:when test="${detailMap.approveCcType eq 'SELECT' }">
	                			<c:forEach items="${detailMap.approveCcList }" var="data" varStatus="i">
		                			<c:if test="${i.index !=0 }">
		                				,
		                				<c:if test="${(i.index+1)%7 eq 0 }"><br></c:if>
		                			</c:if>
		                			<span class='userProfileTargetArea printOut' onmousedown = 'openUserProfileBox("${data.userId }",$(this),"mouseover",null,-0,0,0)'>
		                			${data.userNm }
		                			</span>
		                			&nbsp;${data.rankNm }
		                		</c:forEach>
		                		<c:if test="${fn:length(detailMap.approveCcList)<=0 }">없음</c:if>
                			</c:when>
                		</c:choose>

                	</td>
                </tr>
                 <tr class="printOut ccViewArea" <c:if test = "${fn:length(ccSetupList)<=0 }">style="display: none;"</c:if>>
					<td colspan="3" class="dot_line">
					<span class="sys_p_noti">
							<span class="icon_noti"></span>
							<span class="pointB">필수참조인 : </span>
							<span>
								<c:forEach items="${ccSetupList }" var="data">
									<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.userId }",$(this),"mouseover",null,5,-80,100)'>${data.userNm }</span>(${data.userRankNm })&nbsp;
								</c:forEach>
							</span>
						</span>
					</td>
				</tr>
				<c:if test = "${searchMap.listType eq 'pendList' or searchMap.listType eq 'previous' }">
				<tr id = "ccUpdateArea" style="display: none;">
					<th scope="row" id = "approveCcTh"
						<c:choose>
							<c:when test = "${detailMap.approveCcType eq 'SELECT' and fn:length(detailMap.approveCcList)>0 }">
								rowspan="2"
							</c:when>
							<c:otherwise>
								rowspan="1"
							</c:otherwise>
						</c:choose>

					>참조인<a id = "btnFileSave" class="btn_s_type_g mgl5 printOut" href="javascript:openSavePop('CC')"><em>저장</em></a></th>
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
				<tr id = "approveCcTr" style="display:none"
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
				</c:if>
                <tr class="printOut rcViewArea">
                	<th scope="row" <c:if test = "${fn:length(receiverSetupList)>0 }">rowspan="2"</c:if>>수신인<a id = "btnMemoModify" class="btn_s_type_g mgl5 printOut btnAppvModify" href="javascript:openModify('RECEIVER')" style="display: none;"><em>수정</em></a></th>
                	<td colspan="3">
                		<c:choose>
                			<c:when test="${detailMap.approveRcType eq 'NONE' }">선택안함</c:when>
                			<c:when test="${detailMap.approveRcType eq 'MY_ORG_ALL' }">전체</c:when>
                			<c:when test="${detailMap.approveRcType eq 'MY_TEAM' }">소속팀</c:when>
                			<c:when test="${detailMap.approveRcType eq 'SELECT' }">
	                			<c:forEach items="${detailMap.approveRcList }" var="data" varStatus="i">
		                			<c:if test="${i.index !=0 }">
		                				,
		                				<c:if test="${(i.index+1)%7 eq 0 }"><br></c:if>
		                			</c:if>
		                			<span class='userProfileTargetArea printOut' onmousedown = 'openUserProfileBox("${data.userId }",$(this),"mouseover",null,-0,0,0)'>
		                			${data.userNm }
		                			</span>
		                			&nbsp;${data.rankNm }
		                		</c:forEach>
		                		<c:if test="${fn:length(detailMap.approveRcList)<=0 }">없음</c:if>
                			</c:when>
                		</c:choose>

                	</td>
                </tr>
                <tr class="printOut rcViewArea" <c:if test = "${fn:length(receiverSetupList)<=0 }">style="display: none;"</c:if>>
					<td colspan="3" class="dot_line">
					<span class="sys_p_noti">
							<span class="icon_noti"></span>
							<span class="pointB">필수수신인 : </span>
							<span>
								<c:forEach items="${receiverSetupList }" var="data">
									<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${data.userId }",$(this),"mouseover",null,5,-80,100)'>${data.userNm }</span>(${data.userRankNm })&nbsp;
								</c:forEach>
							</span>
						</span>
					</td>
				</tr>
				 <c:if test = "${searchMap.listType eq 'pendList' or searchMap.listType eq 'previous' }">
				<!-- 수신인 수정 -->
				<tr id = "rcUpdateArea" style="display: none;">
					<th scope="row" id = "approveRcTh"
						<c:choose>
							<c:when test = "${detailMap.approveRcType eq 'SELECT' and fn:length(detailMap.approveRcList)>0 }">
								rowspan="2"
							</c:when>
							<c:otherwise>
								rowspan="1"
							</c:otherwise>
						</c:choose>

					>수신인선택<a id = "btnFileSave" class="btn_s_type_g mgl5 printOut" href="javascript:openSavePop('RECEIVER')"><em>저장</em></a></th>
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
				<tr id = "approveRcTr" style="display:none"
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
				</c:if>
				<tr class="printOut" >
					<th scope="row">결재 완료전 열람허용</th>
					<td colspan="3">
						<label ><input type="checkbox" class="mgl10 mgr3" disabled="disabled" <c:if test="${detailMap.appvBeforeApproveReadYn eq 'Y'}">checked="checked"</c:if>><span>결재/합의허용</span></label>
						<label ><input type="checkbox" class="mgl10 mgr3" disabled="disabled" <c:if test="${detailMap.appvBeforeCcReadYn eq 'Y'}">checked="checked"</c:if>><span>참조 허용</span></label>
						<label ><input type="checkbox" class="mgl10 mgr3" disabled="disabled" <c:if test="${detailMap.appvBeforeReceiveReadYn eq 'Y'}">checked="checked"</c:if>><span>결재/합의허용</span></label>

					</td>
				</tr>
                <c:if test="${detailMap.appvCancelMemo ne null }">
	                <tr>
	                    <th scope="row">회수요청사유</th>
	                    <td colspan="3">${detailMap.appvCancelMemo}</td>
	                </tr>
                </c:if>
            </tbody>
        </table>
        <p class="doc_des_st">위와 같이 ${titleStr }를 제출합니다.</p>
        <div class="signBoxWrap">
            <jsp:include page="./approveDocDetail_stamp_INC.jsp"></jsp:include>
        </div>
        <div class="doc_bottomcopy">${baseUserLoginInfo.orgNm } ${fn:split(baseUserLoginInfo.domain,';')[0] }</div>
        <!-- 신규 수신확인/문서번호 : S -->
		<c:if test="${detailMap.docStatus ne 'WORKING'}">
			<c:if test="${searchMap.listType eq 'rcList' and detailMap.rcReceiptCnt eq 0 }">
				<span class="doc_read_check"><a href="javascript:processAppvRc()" class="btn_s_type_red">&nbsp;수신확인&nbsp;</a></span>
			</c:if>
			<c:if test="${searchMap.listType eq 'rcList' and detailMap.rcReceiptCnt >0 }">
				<span class="doc_read_check"><a href="javascript:openRcPop()" class="btn_s_type_blue">수신확인완료 : <strong>${detailMap.rcReceiptName }</strong> (${detailMap.rcReceiptCnt }/${detailMap.totReceiptCnt })</a></span>
			</c:if>
		</c:if>
    </div>
</div>