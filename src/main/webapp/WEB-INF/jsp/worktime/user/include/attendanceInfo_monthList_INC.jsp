<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script type="text/javascript">
    $(document).ready(function(){
        var nowYear = new Date().getFullYear();
        for (i = (nowYear+3); i > 2000; i--){
            $('#searchYear').append($('<option />').val(i).html(i));
        }

        if ( $.browser.msie ) {
            var expr = new RegExp('>[ \t\r\n\v\f]*<', 'g');
            $('#contentsArea').html( ($('#contentsArea').html() + "").replace(expr, '><')  );
        }

        $("#frm select[name=searchYear]").val('${searchYear}');

    });
</script>

<input type="hidden" name = "searchMonth" id = "searchMonth" value="${searchMonth}" />

<div id="contentsArea" >
<!--업무일지-->
<div class="carSearchBox mgt20">
	<span class="carSearchtitle"><label for="searchYear">년도선택</label></span>
	<select class="select_b w_date" id="searchYear" name = "searchYear"   onchange="linkPage(1)"></select>
	<span class="btn_monthZone mgl10">
		 <button type="button" onClick="searchForMonth('01')" class="${searchMonth eq '01' ? 'on':''}">1월</button>
		 <button type="button" onClick="searchForMonth('02')" class="${searchMonth eq '02' ? 'on':''}">2월</button>
		 <button type="button" onClick="searchForMonth('03')" class="${searchMonth eq '03' ? 'on':''}">3월</button>
		 <button type="button" onClick="searchForMonth('04')" class="${searchMonth eq '04' ? 'on':''}">4월</button>
		 <button type="button" onClick="searchForMonth('05')" class="${searchMonth eq '05' ? 'on':''}">5월</button>
		 <button type="button" onClick="searchForMonth('06')" class="${searchMonth eq '06' ? 'on':''}">6월</button>
		 <button type="button" onClick="searchForMonth('07')" class="${searchMonth eq '07' ? 'on':''}">7월</button>
		 <button type="button" onClick="searchForMonth('08')" class="${searchMonth eq '08' ? 'on':''}">8월</button>
		 <button type="button" onClick="searchForMonth('09')" class="${searchMonth eq '09' ? 'on':''}">9월</button>
		 <button type="button" onClick="searchForMonth('10')" class="${searchMonth eq '10' ? 'on':''}">10월</button>
		 <button type="button" onClick="searchForMonth('11')" class="${searchMonth eq '11' ? 'on':''}">11월</button>
		 <button type="button" onClick="searchForMonth('12')" class="${searchMonth eq '12' ? 'on':''}">12월</button>
	 </span>
</div>
<!--//업무일지//-->

<!--연차기본셋팅-->
<h3 class="h3_title_basic mgt20">근태현황  <span class="sub_desc">(${searchYear}년<c:if test="${searchMonth ne 'All' }"> ${searchMonth}월</c:if>)</span></h3>
<table class="tb_regi_basic" summary="연차기본셋팅 입력화면 (기본연차, 근속년수에 따른 연차, 연차 상한일수, 입사1년미만시 연차부여선택, 제공휴가 모두 소진시, 연차가 남은경우, 지각관련 연차차감)">
	<caption>연차기본셋팅 입력화면</caption>
	<colgroup>
		<col width="160" />
		<col width="*" />
	</colgroup>
	<tbody>
		<tr>
			<th>정상근태</th>
			<td>
			    <strong class="state_tt">${worktimeStatistics.normalTotCnt }건</strong>
                <span class="attend_list">
                    ( <span class="st_normal">정상출근:<em>${worktimeStatistics.workCnt}</em></span>
                    <span class="st_vaca">휴가:<em>${worktimeStatistics.leaveCnt }</em></span>
                    <span class="st_vaca">반차:<em>${worktimeStatistics.halfCnt }</em></span>
                    <span class="st_edu">경조:<em>${worktimeStatistics.fEventCnt }</em></span>
                    <span class="st_sick">병가:<em>${worktimeStatistics.sickCnt }</em></span>
                    <span class="st_stopw">휴직:<em>${worktimeStatistics.restCnt }</em></span>
                    <span class="st_vaca">기타휴가:<em>${worktimeStatistics.etcLeaveCnt }</em></span>
                    <span class="st_vaca">기타반차:<em>${worktimeStatistics.etcHalfCnt }</em></span>
                    <span class="st_stopw">현지출근:<em>${worktimeStatistics.attendCnt }</em></span>
                    )
                    <%--<span class="st_bsstrip">출장:<em>3</em></span>
                    <span class="st_edu">교육:<em>2</em></span>--%>
                </span>
                <button type="button" class="btn_s_replay mgl10" onclick="linkPage(1);"><em>부모코드초기화</em></button>
            </td>
		</tr>

		<tr>
			<th>무단 및 미확인 근태</th>
			<td>
			     <strong class="state_tt2">${worktimeStatistics.nonTotCnt }건</strong>
                <span class="attend_list">
                    ( <span class="st_login">미로그인:<em>${worktimeStatistics.noLoginCnt }</em></span>
                    <span class="st_late">지각:<em>${worktimeStatistics.lateCnt }</em></span>
                    <span class="st_absence">결근:<em>${worktimeStatistics.noWorkCnt }</em></span>
                    )
                </span>
            </td>
		</tr>
	</tbody>
</table>
<!--// 연차기본셋팅 //-->

<!-----------------------------------------------------근태현황 월별 Start --------------------------------------------------->
<!--근태현황목록-->
<table class="tb_list_month mgt30" summary="근태현황목록(번호, 이름, 부서, 직위, 출근, 퇴근, 근태여부, 비고)">
    <caption>근태현황목록</caption>
    <colgroup>
        <col width="9%" /> <!--날짜-->
        <col width="7%" /> <!--출근-->
        <col width="7%" /> <!--퇴근-->
        <col width="8%" /> <!--근태여부-->
        <col width="8%" /> <!--퇴근체크-->
        <col width="*" /> <!--일정-->
        <col width="*" /> <!--비고-->
        <col width="100" /> <!--출근인정-->
    </colgroup>
    <thead>
        <tr>
            <th scope="col">날짜</th>
            <th scope="col">출근</th>
            <th scope="col">퇴근</th>
            <th scope="col">근태</th>
            <th scope="col">퇴근체크</th>
            <th scope="col">일정</th>
            <th scope="col">비고</th>
            <th scope="col">출근인정</th>
        </tr>
    </thead>
    <tbody>
       <c:forEach items="${worktimeList }" var="data" varStatus="i">
        <tr  class="${data.noWorkDateWeekCss}">
            <td class="df_${data.workDateWeekCss}"><strong>${data.workDateMmdd }</strong><em>(${data.workDateWeek })</em></td>
            <c:choose>
                <c:when test="${data.futureYn eq 'Y'}">
                    <td class="txt_time"></td>
                    <td class="txt_time"></td>
                    <td class="txt_time"></td>
                    <td></td>
                </c:when>
                <c:otherwise>
                    <td class="txt_time">${empty data.inTime ? '-':data.inTime }</td>
		            <td class="txt_time">${empty data.outTime ? '-':data.outTime }</td>
		            <td><span class="st_at_${data.workTypeCss}">${empty data.workTypeNm ? '-':data.workTypeNm }</span></td>
		            <td class="txt_time">${data.outContactLoc eq 'secom' ? 'secom' : '-' }</td>
                </c:otherwise>
            </c:choose>

            <td class="txt_etccon">
                <c:set var="arrScheCont" value="${fn:split(data.scheContents,':::::')}" />
                <c:forEach items="${arrScheCont}" var="scheCont" varStatus="scheStatus">
                    <%-- <c:choose>
                        <c:when test="${fn:split(scheCont,'||-||')[0] eq 'LEAVE' }"><!-- 휴가 --><span class="st_at_vaca">${fn:split(scheCont,'||-||')[1] }</span></c:when>
                        <c:when test="${fn:split(scheCont,'||-||')[0] eq 'HALF' }"><!-- 반차 --><span class="st_at_vaca">${fn:split(scheCont,'||-||')[1] }</span></c:when>
                        <c:when test="${fn:split(scheCont,'||-||')[0] eq 'F_EVENT' }"><!-- 경조휴가 --><span class="st_at_bsstrip">${fn:split(scheCont,'||-||')[1] }</span></c:when>
                        <c:when test="${fn:split(scheCont,'||-||')[0] eq 'SICK' }"><!-- 병가 --><span class="st_at_sick">${fn:split(scheCont,'||-||')[1] }</span></c:when>
                        <c:when test="${fn:split(scheCont,'||-||')[0] eq 'REST' }"><!-- 휴직 --><span class="st_at_bsstrip">${fn:split(scheCont,'||-||')[1] }</span></c:when>
                        <c:when test="${fn:split(scheCont,'||-||')[0] eq 'EDU' }"><!-- 교육 --><span class="st_at_edu">${fn:split(scheCont,'||-||')[1] }</span></c:when>
                        <c:when test="${fn:split(scheCont,'||-||')[0] eq 'TRIP' }"><!-- 출장신청 --><span class="st_at_bsstrip">${fn:split(scheCont,'||-||')[1] }</span></c:when>
                        <c:otherwise><span class="st_at_edu">${fn:split(scheCont,'||-||')[1] }</span></c:otherwise>
                   </c:choose> --%>
                   <span class="">
                       <c:choose>
                           <c:when test="${fn:split(scheCont,'||-||')[0] eq 'ATTEND'}">[현지출근-${fn:split(scheCont,'||-||')[1] }]</c:when>
                           <c:when test="${not empty fn:split(scheCont,'||-||')[1] }">[${fn:split(scheCont,'||-||')[1] }]</c:when>
                       </c:choose>
                   </span>
                    <span>${fn:split(scheCont,'||-||')[2]}</span>
                    <br/>
               </c:forEach>
            </td>

            <td class="txt_etccon">
                <a class="approv_txt agree">
                 <c:choose>
                    <c:when test="${data.workReqType eq 'WORK'  && empty data.workReqAcceptYn}">
                        <strong>[출근인정요청 승인중]</strong>
                    </c:when>
                    <c:when test="${data.workReqType eq 'LATE'  && empty data.workReqAcceptYn}">
                        <strong>[지각인정요청 승인중]</strong>
                    </c:when>
                    <c:when test="${data.workReqType eq 'WORK'  && data.workReqAcceptYn eq 'Y'}">
                        <strong>[출근인정 승인완료]</strong>
                    </c:when>
                    <c:when test="${data.workReqType eq 'LATE'  && data.workReqAcceptYn eq 'Y'}">
                        <strong>[지각인정 승인완료]</strong>
                    </c:when>
                    <c:when test="${data.workReqType eq 'WORK'  && data.workReqAcceptYn eq 'N'}">
                        <strong>[출근인정 반려완료]</strong>
                    </c:when>
                    <c:when test="${data.workReqType eq 'LATE'  && data.workReqAcceptYn eq 'N'}">
                        <strong>[지각인정 반려완료]</strong>
                    </c:when>
                    <c:when test="${data.workReqType eq 'NO_WORK'}">
                        <strong>[결근인정]</strong>
                    </c:when>
                </c:choose>
                </a>
                <span>${data.workReqReason }</span>
                <c:if test="${not empty data.mngWorkPrcReason}">
                    <a class="approv_txt agree"><strong>[관리자]</strong></a>${data.mngWorkPrcReason }
               </c:if>
            </td>
            <td><%-- :${data.workReqType }:${data.workType }:${data.workReqAcceptYn }:${data.endYn }:${data.endDateYn }:${data.todayYn } --%>
                <!--  WORK, NO_WORK, LATE(정상, 결근, 지각) -->
                <c:choose>
                    <c:when test="${not empty data.workReqType && empty data.workReqAcceptYn && data.endYn eq 'N' && data.endDateYn eq 'Y'}">
                        <a href="javascript:openAttendanceApprovReq('${data.worktimeId }')" class="s_gray01_btn btn_auth"><em>요청내용수정</em></a>
                    </c:when>
                    <c:when test="${data.workType eq 'LATE' && empty data.workReqAcceptYn  && data.endYn eq 'N' && data.endDateYn eq 'Y'}">
                        <a href="javascript:openAttendanceApprovReq('${data.worktimeId }')" class="s_gray01_btn btn_auth"><em>출근인정요청</em></a>
                    </c:when>
                    <c:when test="${(data.workType eq 'NO_WORK' || data.workType eq 'NO_LOGIN') && empty data.workReqAcceptYn  && data.endYn eq 'N'
                                          && data.endDateYn eq 'Y' && data.todayYn eq 'N'}">
                        <a href="javascript:openAttendanceApprovReq('${data.worktimeId }')" class="s_gray01_btn btn_auth"><em>출근인정요청</em></a>
                    </c:when>
                </c:choose>
            </td>

        </tr>
        </c:forEach>
        <c:if test = "${fn:length(worktimeList)<=0 }">
            <tr>
                <td colspan="9" class="no_result">
                    <p class="nr_des">조회된 데이터가 없습니다.</p>
                </td>
            </tr>
        </c:if>
    </tbody>
</table>
<!--// 근태현황목록 //-->
<!-----------------------------------------------------근태현황 월별 End --------------------------------------------------->

</div>