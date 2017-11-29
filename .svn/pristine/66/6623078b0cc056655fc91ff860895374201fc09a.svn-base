<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="../js/scheduleProc_JS.jsp" %>

<form name="viewerFrm" id="viewerFrm" action="" method="post">
</form>

<form name="scheduleProc" id="scheduleProc" action="" method="post">
<input type="hidden" name="userStr"  id="userStr"/>
<input type="hidden" name="disabledStr"  id="disabledStr"/>

    <input type="hidden" name="InfoMessage"         id="InfoMessage"/>
    <input type="hidden" name="cmd"                 id="cmd"                value="${vo.cmd}"/>
    <input type="hidden" name="eventType"           id="eventType"          value="${vo.eventType}"/>
    <input type="hidden" name="selDate"             id="selDate"            value="${vo.scheSDate}"/>
    <input type="hidden" name="perSabun"            id="perSabun"           value="${baseUserLoginInfo.empNo}"/>
    <input type="hidden" name="scheSeq"             id="scheSeq"            value="${scheVO.scheSeq}"/>
    <input type="hidden" name="scheGrpCd"           id="scheGrpCd"          value="${scheVO.scheGrpCd}"/>
    <input type="hidden" name="procFlag"            id="procFlag"           value="${vo.procFlag}"/>
    <input type="hidden" name="scheSYear"           id="scheSYear"/>
    <input type="hidden" name="scheSMonth"          id="scheSMonth"/>
    <input type="hidden" name="scheSDay"            id="scheSDay"/>
    <input type="hidden" name="scheEYear"           id="scheEYear"/>
    <input type="hidden" name="scheEMonth"          id="scheEMonth"/>
    <input type="hidden" name="scheEDay"            id="scheEDay"/>
    <input type="hidden" name="schePeriodFlag"      id="schePeriodFlag"     value="${scheVO.schePeriodFlag}"/>
    <input type="hidden" name="scheGubun"           id="scheGubun"          value="${scheVO.scheGubun}"/>
        <input type="hidden" name="contactLoc"          id="contactLoc"/>
    <input type="hidden" name="smsContent"          id="smsContent"/>
    <input type="hidden" name="schePublicFlag"          id="schePublicFlag"  value="${scheVO.schePublicFlag}"/>
    <input type="hidden" name="scheCarId"            id="scheCarId"           value="${scheVO.carId}"/>

    <input type="hidden" name="searchScheSTime"  id="searchScheSTime"  value="${scheVO.scheSTime}"/>
    <input type="hidden" name="searchScheETime"   id="searchScheETime"  value="${scheVO.scheETime}"/>

    <input type="hidden" name="eventPage"   id="eventPage"       value="${vo.eventPage}"/>
    <input type="hidden" name="selYear"  id="selYear"      value="${vo.selYear}"/>
    <input type="hidden" name="selMonth"  id="selMonth"      value="${vo.selMonth}"/>
    <input type="hidden" name="searchScheSDate"  id="searchScheSDate"      value="${vo.searchScheSDate}"/>

    <input type="hidden" name="userSeq"				value="${baseUserLoginInfo.userId }"/>
	<input type="hidden" name="meetingRoomId"	id="meetingRoomId"	value=""/>
    <input type="hidden" name="searchPerSabun"  id="searchPerSabun"      value="${vo.searchPerSabun}"/>

    <input type="hidden" name="vacationYn"   id="vacationYn"  value="${scheVO.vacationYn}"/>

    <input type="hidden" name="appvDocType"   id="appvDocType"  value="${scheVO.appvDocType}"/>

	<div id="compnay_dinfo">
        <!--업무일지등록-->
        <div class="modalWrap2">
            <h1><strong>일정등록화면</strong></h1>
            <div class="mo_container">
                <!--일정등록화면-->
                <table class="tb_basic_left" summary="일정등록 (제목, 일시, 장소, 내용, 참가자, 알림, 진행사항) 등록">
                    <caption>일정등록</caption>
                    <colgroup>
                        <col width="130" />
                        <col width="*" />
                    </colgroup>
                    <tr>
                        <th><label for="projectId">분류</label></th>
                        <td>
                        <input type="hidden" id="attendYn" name="attendYn" value="${scheVO.attendYn}" />
                        <c:choose>
                            <c:when test="${vo.eventType eq 'Edit'}">
                                <input type="hidden" id="projectId" name="projectId" value="${scheVO.projectId}"/>
                                <input type="hidden" id="activityId" name="activityId" value="${scheVO.activityId}"/>
                                <input type="hidden" id="activityStartDate" name="activityStartDate" value="${scheVO.activityStartDate}"/>
                                <input type="hidden" id="activityEndDate" name="activityEndDate" value="${scheVO.activityEndDate}"/>
                                <input type="hidden" id="projectStartDate" name="projectStartDate" value="${scheVO.projectStartDate}"/>
                                <input type="hidden" id="projectEndDate" name="projectEndDate" value="${scheVO.projectEndDate}"/>
                                <input type="hidden" id="lastDate" name="lastDate" value="${scheVO.lastDate}"/>
                                <input type="hidden" id="openFlag" name="openFlag" value="${scheVO.openFlag}"/>
                                <input type="hidden" id="employee" name="employee" value="${scheVO.employee}"/>
                                   <div>
                                       <strong>[${scheVO.projectNm}-${scheVO.activityNm}]</strong>
                                        <span id="attendYnArea"  class="radio_list2"  style="${scheVO.vacationYn eq 'Y' ? 'display:none':''}">
                                            <label><input name="attendYnChk" id="attendYnChk"  type="checkbox"  value="Y" ${scheVO.attendYn eq 'Y' ? 'checked':''}/>
                                            <span>현지출근</span></label>
                                        </span>
                                        <br/>기간 : ${scheVO.activityStartDate} ~ ${scheVO.activityEndDate}
                                   </div>
                                <span id="spanSecret"  class="radio_list2" style="display:none">
                                    <label><input type="checkbox" name="Secret" id="Secret" checked/>비공개</label>
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span id="projectTag">
                                    <select id="projectId" name="projectId" class="select_b"  title="${baseUserLoginInfo.projectTitle}">
                                        <option value="">${baseUserLoginInfo.projectTitle } 선택</option>
                                    </select>
                                </span>
                                <span id="activityTag">
                                    <select id="activityId" name="activityId" class="select_b mgl6"  title="${baseUserLoginInfo.activityTitle}">
                                        <option value="">${baseUserLoginInfo.activityTitle } 선택</option>
                                    </select>
                                </span>
                                <span id="attendYnArea" class="radio_list2" style="display:none">
                                    <label><input name="attendYnChk" id="attendYnChk"  type="checkbox"  value="Y" ${scheVO.attendYn eq 'Y' ? 'checked':''}/><span>현지출근</span></label>
                                </span>
                                <span id="spanSecret"  class="radio_list2" style="display:none">
                                    <label><input type="checkbox" name="Secret" id="Secret" checked/>비공개</label>
                                </span>
                                <div id = "activityDescArea" class="radio_list2" ></div> <!-- style="display: inline;" -->
                                <input type="hidden" id="activityStartDate" name="activityStartDate"/>
                                <input type="hidden" id="activityEndDate" name="activityEndDate"/>
                                <input type="hidden" id="projectStartDate" name="projectStartDate"/>
                                <input type="hidden" id="projectEndDate" name="projectEndDate"/>
                                <input type="hidden" id="lastDate" name="lastDate"/>
                            </c:otherwise>
                        </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="AllTime">기간</label></th>
                        <td>
                            <c:choose>
                                <c:when test="${vo.eventType eq 'Edit' && scheVO.scheGrpCd ne '' && scheVO.scheGrpCd ne 'Period' && vo.procFlag ne 'alone'}">
                                </c:when>
                                <c:otherwise>
                                    <span class="radio_list2"><label><input name="AllTime" id="AllTime"  type="checkbox"  onclick="javascript:AllTimeSet();"/><span>종일일정</span></label></span>
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${vo.eventType eq 'Edit' && scheVO.scheGrpCd ne '' && scheVO.scheGrpCd ne 'Period' && vo.procFlag ne 'alone'}">
                                    <c:choose>
                                        <c:when test="${scheVO.scheAllTime eq 'Y'}">${scheVO.scheSDate} ~ ${scheVO.scheEDate}</c:when>
                                        <c:otherwise>${scheVO.scheSDate} ${scheVO.scheSTime} ~ ${scheVO.scheEDate} ${scheVO.scheETime}</c:otherwise>
                                    </c:choose>
                                    <input type="hidden" name="scheSDate" id="scheSDate" value="${scheVO.scheSDate}">
                                    <input type="hidden" name="scheSTime" id="scheSTime" value="${scheVO.scheSTime}"/>
                                    <input type="hidden" name="scheEDate" id="scheEDate" value="${scheVO.scheEDate}">
                                    <input type="hidden" name="scheETime" id="scheETime" value="${scheVO.scheETime}"/>
                                    <input type="hidden" name="scheAllTime" id="scheAllTime" value="${scheVO.scheAllTime}"/>
                                    <input type="hidden" name="sTime" id="sTime" value="${scheVO.scheSTime}"/>
                                    <input type="hidden" name="eTime" id="eTime" value="${scheVO.scheETime}"/>
                                </c:when>
                                <c:otherwise>
                                    <input type="text" class="input_date_type mgl15" name="scheSDate" id="scheSDate" value="${vo.scheSDate}"
                                        <c:if test="${vo.eventType eq 'Add'}"> onChange="schePeriodChk();" </c:if>  readonly="readonly"  title="시작일"  size="12" maxlength="10" onkeyup="javascript:DateFormat(this.name, this.value);" >
                                    <input type="hidden" name="scheSTime"       id="scheSTime"/>
                                    <select name="sTime" id="sTime" class="select_b type" onchange="javascript:changeStartTime(this.id, this.value);" title="시간선택"></select> ~
                                    <input type="text" class="input_date_type"  name="scheEDate"  title="종료일" id="scheEDate" value="${vo.scheSDate}"  readonly="readonly"  size="12" maxlength="10" onkeyup="javascript:DateFormat(this.name, this.value);" onChange="schePeriodChk();">
                                    <input type="hidden" name="scheETime"       id="scheETime"/>
                                    <select name="eTime" id="eTime" class="select_b type"  title="시간선택" onchange="javascript:TimeChange(this.id, this.value);"></select>
                                    <input type="hidden" name="scheAllTime" id="scheAllTime" value="N"/>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>

					<!-- 차량 -->
                    <tr>
                        <th scope="row">차량사용여부</th>
                        <td>
                            <input type="hidden" name="CarUseFlag" id="CarUseFlag" value="${scheVO.carUseFlag}"  />
                            <span class="radio_list2">
                                <label><input type="checkbox" name="CarUseFlagChk" id="CarUseFlagChk" value="Y"  ${scheVO.carUseFlag eq 'Y' ? 'checked':''} /><span>사용함</span></label>
                            </span>
                            <span class="tooltip">
                            <a href="javascript:carUseList();" class="btn_car_search2 mgl25"><em>차량사용현황</em></a>
                            <div id="caruseMemberList" class="tooltip_box" style="display:none;">
							    <div class="wrap_autoscroll">
							        <h3 class="title">차량사용목록</h3>
							        <span class="intext">
							            <table id="tableCarUseList" class="tb_list_basic3">
							                <colgroup>
							                    <col width="100" />
							                    <col width="*" />
							                    <col width="*" />
							                </colgroup>
							                <thead>
							                    <tr>
							                        <th scope="col">차량번호</th>
							                        <th scope="col">등록자</th>
							                        <th scope="col">사용시간</th>
							                    </tr>
							                </thead>
							                <tbody>

							                </tbody>
							            </table>
							            <ul class="list_st_dot3 mgt10">
							                <li class="f11">일정이 취소되면 차량사용도 자동취소됩니다.</li>
							                <li class="f11">사용후 차량상태 체크와 기름을 채워두는 습관은 다른직원을 위한 배려입니다.</li>
							            </ul>
							            <div class="btn_popZone2 mgt15">
							                <a href="javascript:hideCaruseMemberList();" class="btn_witheline">닫힘</a>
							            </div>
							        </span>
							        <em class="edge_topleft"></em>
							    </div>
							</div>
							</span>
                        </td>
                    </tr>
                    <tr class="dot_line"  id="trCarNum" style="display:none">
                        <th scope="row">차량현황</th>
                        <td>
                        <div id="divCarNum" style="display:none"></div>
                        </td>
                    </tr>
                    <!--// 차량 // -->

                    <!-- 회의실 -->
                    <input type="hidden" id="rsvId" name="rsvId" value="0"/>

                    <tr id="meetRoomArea" class="meetingAreaGroup"><!--  style="display:none" -->
                        <th scope="row">회의실사용여부</th>
                        <td>
                        	<span class="radio_list2">
                                <label><input type="checkbox" name="meetingRoomUseFlag" id="meetingRoomUseFlag" value="Y" onclick="clickMeetUse();"/><span>사용함</span></label>
                            </span>
                            <a href="javascript:meetingRoomRsvList();" class="btn_meet_search mgl25"><em></em></a>
                        </td>
                    </tr>

                    <tr class="dot_line meetingAreaGroup"  id="meetRoomRsvArea" style="display:none">
                        <th scope="row">회의실현황</th>
                        <td>
                        	<span id="meetRoomSelectDiv"></span>
                        	<span id="useTimeArea"></span>

	                        <div id="noticeArea" style="padding:4px;margin-top: 5px;">
								<div>* 회의실 예약 시간은 8 시 ~ 22시 까지 이며, 시간 초과 및 미달 시 자동으로 세팅됨.</div>
								<div style="margin-top:3px;color:#fd6205;">* 반복 일정이거나 기간 일정(시작일과 종료일이 다른 일정)일 경우 회의실 예약 불가.</div>
							</div>
						</td>
                    </tr>

                    <!-- //회의실// -->

                    <tr id="CstView">
                        <th scope="row"><label for="tmpCstNm">고객/회사</label></th>
                        <td >
                            <input type="hidden" name="tmpCstId" id="tmpCstId"  value="${scheVO.customerId}" />
                            <input type="hidden" name="tmpCpnId" id="tmpCpnId" value="${scheVO.companyId}" />

	                        <input type="text" class="input_b w30pro" placeholder="고객명검색" readonly title="고객명"  name="tmpCstNm" id="tmpCstNm"  value="${scheVO.customerNm}"  />
	                        <a href="javascript:customerPopUp();" class="s_violet01_btn mgl6"><em class="search">고객</em></a>
	                        <input type="text" class="input_b w30pro mgl20" placeholder="회사명검색"  readonly title="회사명" name="tmpCpnNm" id="tmpCpnNm" value="${scheVO.companyNm}" />
	                        <a href="javascript:companyPopUp('COMPANY');" class="s_violet01_btn mgl6"><em class="search">회사</em></a>
                        </td>
                    </tr>
                    <tr >
                        <th scope="row" rowspan="2"><label for="IDNAME05">참가자</label></th>
                        <td id="EntryView">
                            <a href="javascript:fnObj.openEmpPopup();" class="btn_select_employee" ><em>직원선택</em></a>
                            <span class="radio_list2"><label><input type="checkbox"  name="smsSendFlag" id="smsSendFlag" value="Y" /><span>등록알림 SMS 발송</span></label></span>
                        </td>
                    </tr>
                    <tr class="dot_line">
                        <td>
                            <span id="spanEmpNmList">
                                <span class="employee_list" >
                                   <strong>${baseUserLoginInfo.userName}</strong>(${baseUserLoginInfo.deptNm})
                                       <input type="hidden" name="arrPerSabun" id="arrPerSabun" value="${baseUserLoginInfo.empNo}"/>
                                       <input type="hidden" name="arrRecieveUserId" id="arrRecieveUserId" value="${baseUserLoginInfo.userId}"/>
                                </span>
                                <c:forEach var="entryResult" items="${ScheduleEntryList}" varStatus="status">
                                    <%-- <c:if test="${status.index eq 1}">,</c:if> --%>
                                    <c:if test="${baseUserLoginInfo.empNo ne  entryResult.perSabun}">
		                                <span class="employee_list" >
		                                    <strong>${entryResult.perNm}</strong>(${entryResult.orgNm}${not empty entryResult.orgNm? '-':'' }${entryResult.deptNm})<a href="#" onClick="deleteEmp(this);"  class="btn_delete_employee"><em>삭제</em></a>
		                                    <%-- <c:if test="${!status.last}">,</c:if> --%>
		                                    <input type="hidden" name="arrPerSabun" id="arrPerSabun" value="${entryResult.perSabun}" />
		                                    <input type="hidden" name="arrRecieveUserId" id="arrRecieveUserId" value="${entryResult.userId}"/>
		                                </span>
		                            </c:if>
	                           </c:forEach>
	                        </span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="ScheTitle">제목</label></th>
                        <td><input type="text"  id="ScheTitle"  name="ScheTitle"   placeholder="제목을 입력해주세요" class="w100"  /></td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="ScheArea">장소</label></th>
                        <td>
                            <%--<span class="radio_list2"><label><input type="checkbox" checked />본사에서</label></span>--%>
                            <input type="text" id="ScheArea" name="ScheArea"  placeholder="장소를 입력해주세요" class="w100"  />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="ScheCon">내용</label></th>
                        <td><textarea id="ScheCon" name="ScheCon" cols="" rows="" placeholder="내용을 입력해주세요" class="txtarea_b w100"  title="일정등록내용입력"></textarea></td>
                    </tr>
                    <tr>
                        <th scope="row">알림설정</th>
                        <td>
                            <span class="radio_list2">
                                <label><input type="checkbox"  id="ScheAlarmHowCheck"  name="ScheAlarmHowCheck"  onClick="javascript:AlarmChk();" /><span>알림</span></label>
                                <input type="hidden" name="ScheAlarmHow" id="ScheAlarmHow" value="None"/>
                                <select id="AlarmHow"  name="AlarmHow"  class="select_b mgl20 mgr10" title="알림종류선택"  disabled="disabled">
                                    <option value="Pop">팝업만 사용</option>
                                    <option value="PopSMS">팝업, 문자 모두 사용</option>
                                </select>
                                <span>(D-day</span>
                                <span><input type="text" name="ScheAlarmFlag" id="ScheAlarmFlag"  size="3"  readonly="readonly" onkeyup="NumFormat(this.name, this.value);" value="0" class="w42px" title="알림기간설정" /></span> <span>일전)</span> <!--직접입력체크시만 보임(기본값 0일전)-->
                                <!-- <span class="spe_color_st4 mgl5"> (당일)</span> -->
                                <%--<span class="spe_color_st4 mgl5">(<em class="txt_letter0">12</em>일전)</span>--%>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">반복설정</th>
                        <td>
                            <span class="radio_list2">
                                <label><input type="radio" name="ScheRepetFlag" id="ScheRepetFlag" value="None" checked /><span>없음</span></label>
                                <label><input type="radio" name="ScheRepetFlag" id="ScheRepetFlag" value="Week"/><span>매주</span></label>
                                <label><input type="radio" name="ScheRepetFlag" id="ScheRepetFlag" value="Month" /><span>매월</span></label>
                                <label><input type="radio" name="ScheRepetFlag" id="ScheRepetFlag" value="Quarter" /><span>분기</span></label>
                                <label><input type="radio" name="ScheRepetFlag" id="ScheRepetFlag" value="Year" /><span>매년</span></label>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">중요도</th>
                        <td>
                            <input type="hidden" name="ScheImportant" id="ScheImportant"  >
                            <ul class="importantGrade mgl5">
                                <li><a href="javascript:chkScheImportant('bottom');" id="ScheImportantViewBottom" ><em>+1</em></a></li>
                                <li><a href="javascript:chkScheImportant('middle');" id="ScheImportantViewMiddle"><em>+2</em></a></li>
                                <li><a href="javascript:chkScheImportant('top');" id="ScheImportantViewTop"><em>+3</em></a></li>
                            </ul>
                        </td>
                    </tr>
                </table>
                <!--//일정등록화면//-->
                <div class="btnZoneBox">
                    <span id="AddEnd" class="btn_auth"><a href="javascript:ScheduleProcEnd();" class="p_blueblack_btn"><strong>저장</strong></a></span>
                    <!-- <span id="EditEnd" class="btn_auth" style="display:none;"><a href="javascript:ScheduleProcEnd();" class="p_blueblack_btn" >수정</a></span> -->
                    <a href="javascript:cancelButton();" class="p_withelin_btn" >취소</a>
                </div>
            </div>
        </div>
        <!--//업무일지등록//-->
    </div>

</form>



