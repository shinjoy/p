<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="../js/scheduleMoreList_JS.jsp" %>

<form name="frmScheduleMore"  id="frmScheduleMore"  action=""  method="post">

	<input type="hidden" name="InfoMessage"	id="InfoMessage">
	<input type="hidden" name="message"		id="message"		value="${message}">
	<input type="hidden" name="EventType"	id="EventType"		value="${vo.eventType}">
	<input type="hidden" name="OrderType"	id="OrderType"		value="${spCmmVO.orderType}"/>
	<input type="hidden" name="OrderKey"	id="OrderKey"		value="${spCmmVO.orderKey}"/>
	<input type="hidden" name="OrderObj"	id="OrderObj"		value="${spCmmVO.orderObj}"/>
	<input type="hidden" name="OrderObjNm"	id="OrderObjNm"		value="${spCmmVO.orderObjNm}"/>
	<input type="hidden" name="OrderFlag"	id="OrderFlag"		value="${spCmmVO.orderFlag}"/>
	<input type="hidden" name="ScheSeq"		id="ScheSeq"/>
	<input type="hidden" name="PerSabun"	id="PerSabun"		value="${baseUserLoginInfo.empNo}"/>

	<input type="hidden" name="SelYear"  id="SelYear"      value="${vo.selYear}"/>
	<input type="hidden" name="SelMonth"  id="SelMonth"      value="${vo.selMonth}"/>
	<input type="hidden" name="searchScheSDate"  id="searchScheSDate"      value="${vo.searchScheSDate}"/>

	<input type="hidden" name="eventPage"   id="eventPage"       value="${vo.eventPage}"/>

	<input type="hidden" name="searchPerSabun"  id="searchPerSabun"      value="${vo.searchPerSabun}"/>


	<div id="compnay_dinfo">
        <!--업무일지등록-->
        <div class="modalWrap2">
            <h1><strong>전체일정상세보기(${fn:replace(vo.searchScheSDate,'-','/')})</strong></h1>
            <div class="mo_container">
                <!--업무일지상세보기-->
                <table class="tb_acodi_st" summary="전체일정상세보기(번호,시간,업무내용,직원)">
                    <caption>전체일정상세보기</caption>
                    <colgroup>
                        <col width="30" />
                        <col width="100" />
                        <col width="*" />
                        <col width="70" />
                    </colgroup>
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>시간</th>
                            <th>업무내용</th>
                            <th>직원</th>
                        </tr>
                    </thead>
                    <tbody>
                        <input type="hidden" id="alarmListSize" name="alarmListSize" value="${fn:length(AlarmList)}"/>
                        <c:forEach var="scheVO" items="${AlarmList}" varStatus="status">
	                        <tr onClick="openDetail('${status.count}');"  style="cursor:pointer;" class="tr_selected">
	                            <td class="txt_center">${status.count}</td>
	                            <td class="txt_center">
	                               <c:choose>
	                                   <c:when test="${scheVO.scheAllTime eq 'Y'}">
	                                       (종일)
	                                    </c:when>
	                                    <c:otherwise>
	                                       ${scheVO.scheSTime}~${scheVO.scheETime}
	                                    </c:otherwise>
	                                </c:choose>
	                             </td>
	                            <td class="txt_projectname">
	                               <span class="icon_important_${scheVO.scheImportant eq 'top' ? 'L3' : scheVO.scheImportant eq 'middle' ? 'L2' : scheVO.scheImportant eq 'bottom' ? 'L1' : ''}"></span>
	                               <strong>[${scheVO.projectNm}-${scheVO.activityNm}] ${scheVO.scheTitle}</strong>
	                            </td>
	                            <td class="txt_center">
	                               ${scheVO.regPerNm}
	                            </td>
	                        </tr>
	                        <tr id="trDetail${status.count}" style="display:none">
	                            <td colspan="4" class="conmorebox">
	                                <!--상세보기내용-->
	                                <div class="conmoreboxwrap">
	                                   <h4 class="h4_view_title">
						                    <!-- <span class="icon_teamwork_b"><em>team</em></span> -->
						                    <span class="icon_important_b_${scheVO.scheImportant eq 'top' ? 'L3' : scheVO.scheImportant eq 'middle' ? 'L2' : scheVO.scheImportant eq 'bottom' ? 'L1' : ''}"></span>
						                    <span>[${scheVO.projectNm}-${scheVO.activityNm}] ${scheVO.scheTitle}</span>
						                    <!-- <span class="icon_new"><em>new</em></span> -->
						                </h4>
	                                    <table class="tb_view_simple2" summary="업무일지상세보기 (제목, 중요도, 내용)">
	                                        <caption>업무일지상세보기</caption>
	                                        <colgroup>
	                                            <col width="80">
	                                            <col width="*">
	                                        </colgroup>
	                                        <tbody>
	                                            <tr>
	                                                <th>일시</th>
	                                                <td class="work_period">
	                                                   <c:choose>
	                                                       <c:when test="${scheVO.scheAllTime eq 'Y' && scheVO.scheGrpCd ne 'Period'}">
	                                                           (종일)
                                                                <strong>${fn:replace(scheVO.scheSDate,'-','/')}</strong>
                                                            </c:when>
                                                            <c:when test="${scheVO.scheAllTime eq 'Y' && scheVO.scheGrpCd eq 'Period'}">
                                                               (종일)
                                                                <strong>${fn:replace(scheVO.scheSDate,'-','/')}</strong> ~ <strong>${fn:replace(scheVO.scheEDate,'-','/')}</strong>
                                                            </c:when>
						                                    <c:when test="${scheVO.scheGrpCd eq 'Period'}">
						                                        <strong>${fn:replace(scheVO.scheSDate,'-','/')}</strong>
						                                        <span class="sptime mgl10">${scheVO.scheSTime}</span>
						                                         ~
						                                        <strong>${fn:replace(scheVO.scheEDate,'-','/')}</strong>
						                                        <span class="sptime mgl10">${scheVO.scheETime}</span>
						                                    </c:when>
						                                    <c:otherwise>
						                                        <strong>${fn:replace(scheVO.scheSDate,'-','/')}</strong>
						                                        <span class="sptime mgl10">${scheVO.scheSTime}~${scheVO.scheETime}</span>
						                                    </c:otherwise>
						                                </c:choose>
					                                    <c:if test="${scheVO.attendYn eq 'Y'}">
					                                         현지출근
					                                     </c:if>
	                                                </td>
	                                            </tr>
	                                            <tr>
						                            <th>작성자</th>
						                            <td>${scheVO.regPerNm}&nbsp; ${scheVO.regPerRankNm}</td>
						                        </tr>
	                                            <tr>
						                            <th>고객/회사</th>
						                            <td>${scheVO.customerNm}${not empty scheVO.customerNm && not empty scheVO.companyNm ? '/':''} ${scheVO.companyNm}</td>
						                        </tr>
	                                            <tr>
	                                                <th>장소</th>
	                                                <td>${scheVO.scheArea}</td>
	                                            </tr>
	                                            <tr>
	                                                <th>내용</th>
	                                                <td>
	                                                    <div class="conview_Box">
	                                                       ${fn:replace(scheVO.scheCon, cn, br)}
	                                                    </div>
	                                                </td>
	                                            </tr>
	                                            <tr>
						                            <th>참가자</th>
						                            <td>
						                                <!-- <span class="employee_list" > -->
                                                            ${scheVO.entryNmDetail}
                                                        <!-- </span> -->
						                            </td>
						                        </tr>
	                                            <tr>
						                            <th>차량사용</th>
						                            <td>
						                                <c:choose>
						                                    <c:when test="${scheVO.carUseFlag eq 'Y'}">
						                                        사용함 (${scheVO.carNumber})
						                                    </c:when>
						                                    <c:otherwise>사용안함</c:otherwise>
						                                </c:choose>
						                            </td>
						                        </tr>
	                                            <tr>
	                                                <th>알림</th>
	                                                <td>${scheVO.scheAlarmFlagNm} / ${scheVO.scheAlarmHowNm}</td>
	                                            </tr>
	                                            <tr>
						                            <th>반복설정</th>
						                            <td>
						                                ${scheVO.scheRepetFlagNm}
						                            </td>
						                        </tr>
						                        <tr>
						                            <th>중요도</th>
						                            <td>
						                                <ul class="importantGrade mgl5">
						                                    <c:choose>
						                                        <c:when test="${scheVO.scheImportant eq 'bottom'}">
						                                            <li><a class="on" ><em>+1</em></a></li>
						                                            <li><a  class="" ><em>+2</em></a></li>
						                                            <li><a class="" ><em>+3</em></a></li>
						                                        </c:when>
						                                        <c:when test="${scheVO.scheImportant eq 'middle'}">
						                                            <li><a class="on" ><em>+1</em></a></li>
						                                            <li><a  class="on" ><em>+2</em></a></li>
						                                            <li><a class="" ><em>+3</em></a></li>
						                                        </c:when>
						                                        <c:when test="${scheVO.scheImportant eq 'top'}">
						                                            <li><a class="on" ><em>+1</em></a></li>
						                                            <li><a  class="on" ><em>+2</em></a></li>
						                                            <li><a class="on" ><em>+3</em></a></li>
						                                        </c:when>
						                                        <c:otherwise>
						                                            <li><a class="" ><em>+1</em></a></li>
                                                                    <li><a  class="" ><em>+2</em></a></li>
                                                                    <li><a class="" ><em>+3</em></a></li>
						                                        </c:otherwise>
						                                    </c:choose>
						                                </ul>
						                            </td>
						                        </tr>
	                                            <tr>
	                                                <th>진행사항</th>
	                                                <td class="project_state">
	                                                   <jsp:useBean id="now" class="java.util.Date" />
                                                       <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
	                                                   <c:choose>
						                                    <c:when test="${scheVO.scheChkFlag eq 'Y'}">
						                                        <span class="st_finish">${scheVO.scheChkDate} 완료</span>
						                                    </c:when>
						                                    <c:when test="${scheVO.scheChkFlag ne 'Y' && scheVO.scheSDate <= today }">
						                                        <span class="st_ing">진행중</span>
						                                    </c:when>
						                                    <c:otherwise>
						                                        <span class="st_ing">계획</span>
						                                    </c:otherwise>
						                                </c:choose>
						                                <!-- <span class="st_drop">보류</span> -->
						                            </td>
	                                            </tr>
	                                        </tbody>
	                                    </table>
	                                    <div class="min_footer mgb30">
	                                        <div class="btnZone">
							                    <a href="javascript:ScheView('${scheVO.scheSeq}');" ><strong>상세</strong></a>
							                    <a href="javascript:openDetail('${status.count}');">닫기</a>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="btn_td_control">
	                                  <a href="javascript:openDetail('${status.count}');" class="btn_td_close"><em>닫기</em></a>
	                                  <%-- <a href="javascript:openDetail('${status.count}');" class="btn_td_open"><em>열기</em></a> --%>
	                                 </div>
	                                <!--//상세보기내용//-->
	                            </td>
	                        </tr>
	                    </c:forEach>
                    </tbody>
                </table>

                <!--//업무일지상세보기//-->
                <div class="btnZoneBox">
                    <%--<a href="#" class="p_blueblack_btn"><strong>등록</strong></a>--%>
                    <a href="javascript:window.close();" class="p_withelin_btn">닫기</a>
                </div>
            </div>
        </div>
        <!--//업무일지등록//-->
    </div>


</form>
