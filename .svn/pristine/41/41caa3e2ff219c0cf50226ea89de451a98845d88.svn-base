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

        for(j=1;j<13;j++){
        	var month = j;
        	if(j<10) var month = "0" + j;
        	if($("#isData_" +month).val() == 'N') $("#tdMonth_" +month).attr("class","no_list finish");
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
    <a class="btn_g_black mgl10" href="javascript:searchForMonth('All');"><em>검색</em></a>
</div>
<!--//업무일지//-->

<!--연차기본셋팅-->
<h3 class="h3_title_basic mgt20">근태현황 <span class="sub_desc">(${searchYear}년<c:if test="${searchMonth ne 'All' }"> ${searchMonth}월</c:if>)</span></h3>
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

                             <ul class="calandar_cubewrap">
                                <c:forEach items="${worktimeList }" var="data" varStatus="i">
                                <li>
                                    <dl class="calandar_cubeBox">
                                        <dt>
                                            <strong>${data.calMonth }월</strong><span>${data.calMonthNm }</span>
                                            <c:forEach items="${worktimeListEndYn }" var="endData" varStatus="i">
							                    <c:if test="${data.calMonth eq endData.calMonth && endData.endYnCss eq 'finish'}">
							                        <span title="마감" class="icon_cal_finish"></span>
							                        <%-- <span title="${data.endYnNm}" class="icon_cal_${endData.endYnCss}"></span> --%>
							                    </c:if>
							                </c:forEach>
                                        </dt>
                                        <dd>
                                            <table class="calandar_cube_tb" summary="근태현황 요약">
                                                <caption>근태현황 요약(정상근태, 결근/지각)</caption>
                                                <colgroup>
                                                    <col width="85">
                                                    <col width="*">
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th class="lt_st01">정상근태</th>
                                                        <td class="lt_des01">
                                                            <span>${data.normalTotCnt}건</span>
                                                            <c:if test="${data.normalTotCnt ne 0 }">
                                                            <em>
                                                                (
                                                                <c:if test="${data.workCnt ne 0 }">정상출근:${data.workCnt}</c:if>
                                                                <c:if test="${data.leaveCnt ne 0 }">휴가:${data.leaveCnt }</c:if>
                                                                <c:if test="${data.halfCnt ne 0 }">반차:${data.halfCnt }</c:if>
                                                                <c:if test="${data.fEventCnt ne 0 }">경조:${data.fEventCnt }</c:if>
                                                                <c:if test="${data.sickCnt ne 0 }">병가:${data.sickCnt }</c:if>
                                                                <c:if test="${data.restCnt ne 0 }">휴직:${data.restCnt }</c:if>
                                                                <c:if test="${data.attendCnt ne 0 }">현지출근:${data.attendCnt }</c:if>
                                                                )
                                                            </em>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th class="lt_st02">결근/지각</th>
                                                        <td class="lt_des02">
                                                            <span>${data.nonTotCnt}건</span>
                                                            <c:if test="${data.nonTotCnt ne 0 }">
                                                            <em>
                                                                (
                                                                <c:if test="${data.noLoginCnt ne 0 }">미로그인:${data.noLoginCnt}</c:if>
                                                                <c:if test="${data.lateCnt ne 0 }">지각:${data.lateCnt }</c:if>
                                                                <c:if test="${data.noWorkCnt ne 0 }">결근:${data.noWorkCnt }</c:if>
                                                                )
                                                            </em>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td id="tdMonth_${data.calMonth }"  colspan="2">
                                                            <ul class="list_st_dot3">
                                                                <c:set var="isData" value="N"/>
                                                                <c:forEach items="${worktimeNoWorkList }" var="noWorkData" varStatus="i">
                                                                    <c:if test="${data.calMonth eq noWorkData.workMonth }">
                                                                        <li><span class="issue_date">${noWorkData.workDate}</span>
                                                                            <c:choose>
                                                                                <c:when test="${noWorkData.workType eq  'HALF_LATE' || noWorkData.workType eq  'NO_WORK'
                                                                                    || noWorkData.workType eq  'LATE' || noWorkData.workType eq  'NO_LOGIN'}">
                                                                                    <span class="st_${noWorkData.workTypeCss}">${noWorkData.workTypeNm}</span>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <c:set var="arrScheCont" value="${fn:split(noWorkData.scheContents,':::::')}" />
		                                                                            <c:forEach items="${arrScheCont}" var="scheCont" varStatus="scheStatus">
		                                                                               <span class="st_normal">
		                                                                                   <c:choose>
		                                                                                       <c:when test="${fn:split(scheCont,'||-||')[0] eq 'ATTEND'}">현지출근</c:when>
		                                                                                       <c:when test="${not empty fn:split(scheCont,'||-||')[1] }">${fn:split(scheCont,'||-||')[1] }</span>
		                                                                                       </c:when>
		                                                                                   </c:choose>
		                                                                               </span>
		                                                                           </c:forEach>
                                                                                </c:otherwise>
                                                                            </c:choose>

                                                                        <span class="issue_des">${noWorkData.workReqReason} ${noWorkData.scheTitle }</span></li>
                                                                        <c:set var="isData" value="Y"/>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                            <c:if test="${isData eq 'N' }">리스트가 없습니다.</c:if>
                                                            <input type="hidden" name="isData_${data.calMonth }" id="isData_${data.calMonth }" value="${isData}"/>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </dd>
                                    </dl>
                                </li>
                                </c:forEach>
                            </ul>


<!-----------------------------------------------------근태현황 월별 End --------------------------------------------------->

</div>