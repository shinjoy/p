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

<input type="hidden" name = "searchDate"  id = "searchDate"  value="${searchDate}" />
<input type="hidden" name = "searchMonth" id = "searchMonth" value="${searchMonth}" />

<input type="hidden" name = "endYn"  id = "endYn" value="${worktimeEndInfo.endYn}" />
<input type="hidden" name = "notApproveCnt"  id = "notApproveCnt" value="${worktimeEndInfo.notApproveCnt}" />
<input type="hidden" name = "notApproveWorkDay"  id = "notApproveWorkDay" value="${worktimeEndInfo.notApproveWorkDay}" />
<input type="hidden" name = "endDateYn"  id = "endDateYn" value="${worktimeEndInfo2.endDateYn}" />

<!--업무일지-->
<div id="contentsArea" >
<div  class="carSearchBox mgt20">
	<span class="carSearchtitle"><label for="searchYear">년도선택</label></span>
	<select class="select_b w_date" id="searchYear" name = "searchYear"   onchange="linkPage(1)"></select>
	<span class="btn_monthZone mgl10">
		 <button type="button" onClick="searchForMonth(this,'01')" class="${searchMonth eq '01' ? 'on':''}">1월</button>
		 <button type="button" onClick="searchForMonth(this,'02')" class="${searchMonth eq '02' ? 'on':''}">2월</button>
		 <button type="button" onClick="searchForMonth(this,'03')" class="${searchMonth eq '03' ? 'on':''}">3월</button>
		 <button type="button" onClick="searchForMonth(this,'04')" class="${searchMonth eq '04' ? 'on':''}">4월</button>
		 <button type="button" onClick="searchForMonth(this,'05')" class="${searchMonth eq '05' ? 'on':''}">5월</button>
		 <button type="button" onClick="searchForMonth(this,'06')" class="${searchMonth eq '06' ? 'on':''}">6월</button>
		 <button type="button" onClick="searchForMonth(this,'07')" class="${searchMonth eq '07' ? 'on':''}">7월</button>
		 <button type="button" onClick="searchForMonth(this,'08')" class="${searchMonth eq '08' ? 'on':''}">8월</button>
		 <button type="button" onClick="searchForMonth(this,'09')" class="${searchMonth eq '09' ? 'on':''}">9월</button>
		 <button type="button" onClick="searchForMonth(this,'10')" class="${searchMonth eq '10' ? 'on':''}">10월</button>
		 <button type="button" onClick="searchForMonth(this,'11')" class="${searchMonth eq '11' ? 'on':''}">11월</button>
		 <button type="button" onClick="searchForMonth(this,'12')" class="${searchMonth eq '12' ? 'on':''}">12월</button>
		 <button type="button" onClick="searchForMonth(this,'All')" class="${searchMonth eq 'All' ? 'on':''}">전체보기</button>
	 </span>
<c:if test="${pageType eq 'MGMT'}">
	 <div class="btnRightZone">
        <button name="reg_btn" class="btn_b2_skyblue" onclick="javascript:excelDownMonthList();return false;"><em class="icon_XLS">파일로 저장</em></button>
    </div>
</c:if>
</div>
<!--//업무일지//-->

<!--연차기본셋팅-->

<h3 class="h3_title_basic mgt20 porelaive2">근태현황 <span id="capSearch" class="sub_desc">(${searchYear}년 ${searchMonth}월)</span>
<c:if test="${targetOrgId eq baseUserLoginInfo.orgId && pageType eq 'MGMT'}">
	<c:choose>
	    <c:when test="${worktimeEndInfo2.endYn eq 'N' }">
	        <a class="btn_s_type3 mgl10 btn_auth" href="javascript:processWorkTimeMonthEnd();" ><em class="icon_calcheck">월근태마감</em></a>
	    </c:when>
	    <c:when test="${worktimeEndInfo2.endYn eq 'Y'}">
	        <a class="btn_s_type3 mgl10 btn_auth" ><em class="icon_calcheck">월근태마감 완료</em></a>
	    </c:when>
	</c:choose>
</c:if>
</h3>
<!-----------------------------------------------------근태현황 월별 Start --------------------------------------------------->
<!--연차상세옵션-->
<table id="SGridTarget" class="tb_list_basic4" summary="2016년 지각현황 (이름, 입사일, 소속, 월별현황, 총지각횟수,휴가차감일수, 총근무시간)">
    <caption>근태현황 (${searchYear}년 ${searchMonth}월)</caption>
    <colgroup>
        <col width="2%" /> <!--순번-->
        <col width="6%" /> <!--성명-->
        <col width="6%" /> <!--입사일-->
        <col width="*" /> <!--소속-->
        <col width="2.5%" span="31" /> <!--요일-->
    </colgroup>
    <thead>
        <tr>
            <th rowspan="3" scope="col">번호</th>
            <th rowspan="3" scope="col">이름</th>
            <th rowspan="3" scope="col">입사일</th>
            <th rowspan="3" scope="col">소속</th>
            <th colspan="${fn:length(calendarPerMonth)}" scope="col">${searchYear}년 ${searchMonth}월 근태현황</th>
            <!-- <th rowspan="2" scope="col">근태내역</th> -->
        </tr>
        <tr>
            <c:forEach items="${calendarPerMonth }" var="calendar" varStatus="i">
                <c:choose>
                    <c:when test="${calendar.holiType eq 'SATURDAY' }">
                        <th scope="col"><span class="df_saturday">${calendar.dd}</span></th>
                    </c:when>
                    <c:when test="${calendar.holiType eq 'SUNDAY' }">
                        <th scope="col"><span class="df_sunday">${calendar.dd}</span></th>
                    </c:when>
                    <c:when test="${calendar.holiType eq 'HOLIDAY' }">
                        <th scope="col"><span class="df_sunday">${calendar.dd}</span></th>
                    </c:when>
                    <c:otherwise>
                        <th scope="col">${calendar.dd}</th>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </tr>
        <tr class="icon">
            <c:forEach items="${calendarPerMonth }" var="calendar" varStatus="i">
                <c:forEach items="${worktimeListEndYn }" var="data" varStatus="i">
                    <c:if test="${calendar.dd eq data.calDay}">
                        <th scope="col"><span title="${data.endYnNm}" class="icon_cal_${data.endYnCss}"></span></th>
                    </c:if>
                </c:forEach>
            </c:forEach>
        </tr>
    </thead>
    <tbody>
        <c:choose>
        <c:when test = "${fn:length(worktimeList)<=0  or  fn:length(calendarPerMonth) eq 0}">
            <tr>
                <td colspan="36" class="no_result">
                    <p class="nr_des">조회된 데이터가 없습니다.</p>
                </td>
            </tr>
        </c:when>
        <c:otherwise>
	       <c:forEach items="${worktimeList }" var="data" varStatus="i">
	        <tr>
	            <td>${(paginationInfo.recordCountPerPage*(paginationInfo.currentPageNo-1))+(i.index+1) }</td>
	            <td>${data.name }</td>
	            <td class="txt_letter0">${data.hiredDate }</td>
	            <td>${data.deptNm }</td>
	            <c:forEach items="${calendarPerMonth }" var="calendar" varStatus="i">
	                <c:choose>
	                    <c:when test="${calendar.dd eq '01' }"><td class="txt_state_att" title="${data.day01}">${fn:split(data.day01,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '02' }"><td class="txt_state_att" title="${data.day02}">${fn:split(data.day02,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '03' }"><td class="txt_state_att" title="${data.day03}">${fn:split(data.day03,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '04' }"><td class="txt_state_att" title="${data.day04}">${fn:split(data.day04,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '05' }"><td class="txt_state_att" title="${data.day05}">${fn:split(data.day05,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '06' }"><td class="txt_state_att" title="${data.day06}">${fn:split(data.day06,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '07' }"><td class="txt_state_att" title="${data.day07}">${fn:split(data.day07,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '08' }"><td class="txt_state_att" title="${data.day08}">${fn:split(data.day08,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '09' }"><td class="txt_state_att" title="${data.day09}">${fn:split(data.day09,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '10' }"><td class="txt_state_att" title="${data.day10}">${fn:split(data.day10,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '11' }"><td class="txt_state_att" title="${data.day11}">${fn:split(data.day11,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '12' }"><td class="txt_state_att" title="${data.day12}">${fn:split(data.day12,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '13' }"><td class="txt_state_att" title="${data.day13}">${fn:split(data.day13,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '14' }"><td class="txt_state_att" title="${data.day14}">${fn:split(data.day14,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '15' }"><td class="txt_state_att" title="${data.day15}">${fn:split(data.day15,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '16' }"><td class="txt_state_att" title="${data.day16}">${fn:split(data.day16,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '17' }"><td class="txt_state_att" title="${data.day17}">${fn:split(data.day17,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '18' }"><td class="txt_state_att" title="${data.day18}">${fn:split(data.day18,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '19' }"><td class="txt_state_att" title="${data.day19}">${fn:split(data.day19,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '20' }"><td class="txt_state_att" title="${data.day20}">${fn:split(data.day20,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '21' }"><td class="txt_state_att" title="${data.day21}">${fn:split(data.day21,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '22' }"><td class="txt_state_att" title="${data.day22}">${fn:split(data.day22,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '23' }"><td class="txt_state_att" title="${data.day23}">${fn:split(data.day23,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '24' }"><td class="txt_state_att" title="${data.day24}">${fn:split(data.day24,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '25' }"><td class="txt_state_att" title="${data.day25}">${fn:split(data.day25,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '26' }"><td class="txt_state_att" title="${data.day26}">${fn:split(data.day26,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '27' }"><td class="txt_state_att" title="${data.day27}">${fn:split(data.day27,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '28' }"><td class="txt_state_att" title="${data.day28}">${fn:split(data.day28,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '29' }"><td class="txt_state_att" title="${data.day29}">${fn:split(data.day29,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '30' }"><td class="txt_state_att" title="${data.day30}">${fn:split(data.day30,'/')[0]}</td></c:when>
						<c:when test="${calendar.dd eq '31' }"><td class="txt_state_att" title="${data.day31}">${fn:split(data.day31,'/')[0]}</td></c:when>
			        </c:choose>
	            </c:forEach>
	            <%-- <td class="txt_etccon">
	                <c:if test="${data.leaveSum ne 0}"><strong>[휴가:${data.leaveSum}]</strong>&nbsp;</c:if>
	                <c:if test="${data.halfSum ne 0}"><strong>[반차:${data.halfSum}]</strong>&nbsp;</c:if>
	                <c:if test="${data.fEventSum ne 0}"><strong>[경조휴가:${data.fEventSum}]</strong>&nbsp;</c:if>
	                <c:if test="${data.sickSum ne 0}"><strong>[병가:${data.sickSum}]</strong>&nbsp;</c:if>
	                <c:if test="${data.restSum ne 0}"><strong>[휴직:${data.restSum}]</strong>&nbsp;</c:if>

	                <c:if test="${data.noLoginSum ne 0}"><strong>[미로그인:${data.noLoginSum}]</strong>&nbsp;</c:if>
	                <c:if test="${data.lateSum ne 0}"><strong>[지각:${data.lateSum}]</strong>&nbsp;</c:if>
	                <c:if test="${data.noWorkSum ne 0}"><strong>[결근:${data.noWorkSum}]</strong>&nbsp;</c:if>
	            </td> --%>
	        </tr>
	        </c:forEach>
	    </c:otherwise>
	</c:choose>

    </tbody>
</table>
<!--// 연차상세옵션 //-->
<!-----------------------------------------------------근태현황 월별 End --------------------------------------------------->
</div>

