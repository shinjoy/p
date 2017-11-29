<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="../js/scheduleView_JS.jsp" %>

	<form name="ScheduleView" id="ScheduleView" action="" method="post">
	<input type="hidden" name="command"		 	id="command"		value="Schedule"/>
	<input type="hidden" name="cmd"				id="cmd"			value="${vo.cmd}"/>
	<input type="hidden" name="EventType"		id="EventType"		value="${vo.eventType}"/>
	<input type="hidden" name="ParentPage"		id="ParentPage"		value="${vo.parentPage}"/>
	<input type="hidden" name="SelDate"			id="SelDate"		value="${scheVO.scheSDate}"/>
	<input type="hidden" name="ScheAlarmFlag"	id="ScheAlarmFlag"/>
	<input type="hidden" name="PerSabun"		id="PerSabun"		value="${baseUserLoginInfo.empNo}"/>
	<input type="hidden" name="ScheSeq"			id="ScheSeq"		value="${scheVO.scheSeq}"/>
	<input type="hidden" name="ScheGrpCd"		id="ScheGrpCd"		value="${scheVO.scheGrpCd}"/>
	<input type="hidden" name="SchePeriodFlag"	id="SchePeriodFlag"	value="${scheVO.schePeriodFlag}"/>


	<input type="hidden" name="SelYear"  id="SelYear"      value="${vo.selYear}"/>
    <input type="hidden" name="SelMonth"  id="SelMonth"      value="${vo.selMonth}"/>
    <input type="hidden" name="searchScheSDate"  id="searchScheSDate"      value="${vo.searchScheSDate}"/>

    <input type="hidden" name="eventPage"   id="eventPage"       value="${vo.eventPage}"/>

    <input type="hidden" name="searchPerSabun"  id="searchPerSabun"      value="${vo.searchPerSabun}"/>

    <input type="hidden" name="worktimeEndYn"   id="worktimeEndYn"  value="${scheVO.worktimeEndYn}"/>
    <input type="hidden" id="vacationYn" name="vacationYn" value="${scheVO.vacationYn}"/>
    <input type="hidden" id="attendYn" name="attendYn" value="${scheVO.attendYn}"/>

	<div id="compnay_dinfo">
        <!--업무일지등록-->
        <div class="modalWrap2">
            <h1><strong>일정상세화면</strong></h1>

            <div class="mo_container">
                <h4 class="h4_view_title">
                    <!-- <span class="icon_teamwork_b"><em>team</em></span> -->
                    <span class="icon_important_b_${scheVO.scheImportant eq 'top' ? 'L3' : scheVO.scheImportant eq 'middle' ? 'L2' : scheVO.scheImportant eq 'bottom' ? 'L1' : ''}"></span>
                    <span>[${scheVO.projectNm}-${scheVO.activityNm}] <c:out value="${scheVO.scheTitle}"/></span>
                    <span class="writerinfo">
                    	<em class="writer">
                    		<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${scheVO.regUserId}",$(this),"mouseover",null,5,-200,200)'>
                    			${scheVO.regPerNm }
                    		</span>
                 		</em>
                    	<em class="teamname">(${scheVO.regPerRankNm } ${fn:replace(scheVO.regDateStr,'-','/') })</em>
                    </span>
                    <!-- <span class="icon_new"><em>new</em></span> -->
                </h4>
                <!--업무일지상세보기-->
                <table class="tb_view_simple2" summary="업무일지상세보기 (제목, 중요도, 내용)">
                    <caption>업무일지상세보기</caption>
                    <colgroup>
                        <col width="90">
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
                            <td>
                            	<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${scheVO.regUserId}",$(this),"mouseover",null,5,-80,80)'>
                            		${scheVO.regPerNm}
                            	</span>
                            	&nbsp; ${scheVO.regPerRankNm}</td>
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
                                	<c:set var="contents"><c:out value='${scheVO.scheCon }'/></c:set>
                                    ${fn:replace(contents, cn, br)}
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>참가자</th>
                            <td>
                                <c:forEach var="entryResult" items="${ScheduleEntryList}" varStatus="status">
                                	<c:choose>
                                		<c:when test="${(status.index+1)%4 eq 1 or (status.index+1)%4 eq 2}">
	                                		<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${entryResult.userId}",$(this),"mouseover",null,0,-80,80)'>
		                                        ${entryResult.perNm}
		                                    </span>
                                		</c:when>
                                		<c:otherwise>
                                			<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox("${entryResult.userId}",$(this),"mouseover",null,0,-200,200)'>
		                                        ${entryResult.perNm}
		                                    </span>
                                		</c:otherwise>

                                	</c:choose>

                                        (${entryResult.orgNm}${not empty entryResult.orgNm? '-':'' }${entryResult.deptNm})
                                        <c:if test="${!status.last}">,</c:if><c:if test = "${(status.index+1)%4 eq 0}"><br></c:if>
                                </c:forEach>
                                <%-- <span id="Entry">${scheVO.regPerNm}</span> --%>
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
                        <tr id="meetingRoomArea">
                            <th>회의실사용</th>
                            <td>
                                <c:choose>
				                    <c:when test="${meetingRoomChk > 0}">
				                       <strong style="color:${meetingRoom.titleColor}">${meetingRoom.meetingRoomNm} </strong>(${meetingRoom.showStartTime} ~ ${meetingRoom.showEndTime})
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
                <!--//업무일지상세보기//-->
                <div class="btnZoneBox">
                    <c:if test="${scheVO.scheChkFlag eq 'N' && baseUserLoginInfo.empNo eq scheVO.regPerSabun && empty scheVO.appvDocId}">
                        <span class="btn_auth"><a href="javascript:ScheduleChkEnd();" class="p_blueblack_btn" >일정 완료처리</a></span>
                        <span class="btn_auth"><a href="javascript:ScheduleEdit();" class="p_blueblack_btn" >수정</a></span>
                        <span class="btn_auth"><a href="javascript:ScheduleDelEnd();" class="p_blueblack_btn" >삭제</a></span>
                    </c:if>
                    <c:if test="${vo.eventPage eq 'MoreView'}">
                       <a href="javascript:SelDateScheduleList();" class="p_withelin_btn" >목록</a>
                    </c:if>
	                <a href="javascript:closeAction();" class="p_withelin_btn" >닫기</a>
                </div>
            </div>
        </div>
        <!--//업무일지등록//-->
    </div>

</form>
