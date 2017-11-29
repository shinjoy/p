<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!-- 추후삭제2Line -->
<c:set var="appvDocNumRuleDateEX" value=""/>
<c:set var="appvDocNumRuleSeqEX" value=""/>
<!-- //추후삭제2Line// -->

                        <form id="frm" name="frm">
                            <div class="doc_AllWrap"  id="listArea">

							    <h3 class="h3_title_basic mgt20">
							        <span>1. 승인자 지정</span>
							        <a class="s_violet01_btn mgl15" href="javascript:fnObj.openEmpPopup();"><em>직원선택</em></a>
							    </h3>
							    <p class="notice_script">* 지출입력된 내역을 확인하고 승인하는 담당자를 지정하는 기능으로 승인자는 1인만 지정 가능합니다.</p>
							    <article class="paymentsetBox">
                                    <div class="gray_notibox" id="spanExpense">
                                        <c:forEach items="${cardManagerSetupList}" var="data" varStatus="status">
                                            <span class="employee_list" >
                                              <span>${data.userName }<em>(${data.rankNm})</em></span><a href="#" onClick="deleteEmp(this);"  class="btn_delete_employee"><em>삭제</em></a>
                                              <input type="hidden" name="arrUserId" id="arrUserId" value="${data.staffUserId }" />
                                            </span>
                                        </c:forEach>
                                    </div>
                                    <p class="notice_script">* 승인자 미지정시 지출등록 승인 기능을 사용하실 수 없습니다.</p>
                                </article>

                                <h3 class="h3_title_basic mgt20">
                                    <span>2. 관리부서 지정</span>
                                    <a class="s_violet01_btn mgl15" href="javascript:fnObj.openDeptPopup();"><em>부서선택</em></a>
                                </h3>
                                <article class="paymentsetBox">
                                    <div class="gray_notibox" id="spanExpenseDept">
                                        <c:forEach items="${cardManagerSetupList}" var="data" varStatus="status">
                                            <span class="employee_list" >
                                              <span>${data.staffDeptNm }</span><a href="#" onClick="deleteEmp(this);"  class="btn_delete_employee"><em>삭제</em></a>
                                              <input type="hidden" name="staffDeptId" id="staffDeptId" value="${data.staffDeptId }" />
                                            </span>
                                        </c:forEach>
                                    </div>
                                </article>

							    <h3 class="h3_title_basic">3. 지출입력 유의사항 설정</h3>
							    <p class="notice_script">* 아래 입력하신 내용은 계정과목 안내하는 팝업 하단에 노출되어 지출등록시 유의사항을 안내 할 수 있습니다.</p>
							    <article class="paymentsetBox last">
							        <c:choose>
                                         <c:when test="${not empty cardReceiverSetup.note}">
                                              <textarea class="txtarea_b w100pro" id="note" name="note"  style="height:200px">${cardReceiverSetup.note}</textarea>
                                         </c:when>
                                         <c:otherwise>
                                             <textarea class="txtarea_b w100pro" id="note" name="note"  style="height:200px">1. 영업비관련 지출 등록 시!
                                             &#13;&#10;   - 일정 등록 필요
                                             &#13;&#10;2. 교육비, 부서회식 지출 등록 시!
                                             &#13;&#10;   - 대중교통비 : 해당일의 일정 필요, 부서회식 : 해당 일정 필요
                                             &#13;&#10;3. 소모품 지출 등록 시!
                                             &#13;&#10;   - 구입품목 개별 입력(영수증 내역과 동일할 경우 인정)</textarea>
                                          </c:otherwise>
                                     </c:choose>
							    </article>

							    <!--버튼영역-->
	                            <div class="btn_baordZone2">
	                                <a href="javascript:doSaveCardExpenseSetup();" class="btn_blueblack btn_auth">저장</a>
	                                <a href="javascript:doSearch();" class="btn_witheline btn_auth">취소</a>
	                            </div>
	                            <!--//버튼영역//-->

							    <input type="hidden" name="createdBy"  value="${data.createdBy } ">
							    <input type="hidden" name="createDate" value="${data.createDate }">
						    </div>
						</form>


