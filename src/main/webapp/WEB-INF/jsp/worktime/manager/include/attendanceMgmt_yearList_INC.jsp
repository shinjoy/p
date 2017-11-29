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

<div id="contentsArea" >
<!--업무일지-->
<div class="carSearchBox mgt20">
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
<h3 class="h3_title_basic mgt20 porelaive2">
    <span>근태현황</span>
     <span id="capSearch"  class="sub_desc">(${searchYear}년)</span>
</h3>
<!-----------------------------------------------------근태현황 년별 Start --------------------------------------------------->

<!--연차상세옵션-->
<table id="SGridTarget" class="tb_list_basic4" summary="2016년 지각현황 (이름, 입사일, 소속, 월별현황, 총지각횟수,휴가차감일수, 총근무시간)">
    <caption>근태현황 (${searchYear}년)</caption>
    <colgroup>
        <col width="3%" /> <!--순번-->
        <col width="7%" /> <!--성명-->
        <col width="7%" /> <!--입사일-->
        <col width="*" /> <!--소속-->
        <col width="3.5%" span="12" /> <!--1월-->
        <col width="15%"> <!--정상근태-->
        <col width="13%"> <!--무단 및 미확인-->
    </colgroup>
    <thead>
        <tr>
            <th rowspan="3" scope="col">번호</th>
            <th rowspan="3" scope="col">이름</th>
            <th rowspan="3" scope="col">입사일</th>
            <th rowspan="3" scope="col">소속</th>
            <th colspan="12" scope="col" >${searchYear}년 전체 근태현황</th>
            <th colspan="3">근태요약</th>
        </tr>
        <tr>
            <th scope="col">01월</th>
            <th scope="col">02월</th>
            <th scope="col">03월</th>
            <th scope="col">04월</th>
            <th scope="col">05월</th>
            <th scope="col">06월</th>
            <th scope="col">07월</th>
            <th scope="col">08월</th>
            <th scope="col">09월</th>
            <th scope="col">10월</th>
            <th scope="col">11월</th>
            <th scope="col">12월</th>
            <th rowspan="2" scope="col">정상근태</th>
            <th rowspan="2" scope="col">무단 및 미확인근태</th>
        </tr>
        <tr>
            <c:forEach items="${worktimeListEndYn }" var="data" varStatus="i">
                <th scope="col"><span title="${data.endYnNm}" class="icon_cal_${data.endYnCss}"></span></th>
            </c:forEach>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${worktimeList }" var="data" varStatus="i">
        <tr>
            <td>${(paginationInfo.recordCountPerPage*(paginationInfo.currentPageNo-1))+(i.index+1) }</td>
            <td>${data.name }</td>
            <td class="txt_letter0">${data.hiredDate }</td>
            <td>${data.deptNm }</td>
                       <td class="txt_letter0">
                <span class="tooltip">
                    <a class="attblock" href="javascript:openWortimeListPopup('${data.userId }','01')">${data.month01 eq 0 ? '': data.month01}</a>
                     <div id="attendanceBox"  name="attendanceBox_${data.userId }01" class="tooltip_box" style="display:none" ></div>
                </span>
            </td>
           <td class="txt_letter0">
                <span class="tooltip">
                    <a class="attblock" href="javascript:openWortimeListPopup('${data.userId }','02')">${data.month02 eq 0 ? '': data.month02}</a>
                     <div id="attendanceBox"  name="attendanceBox_${data.userId }02" class="tooltip_box" style="display:none" ></div>
                </span>
            </td>           <td class="txt_letter0">
                <span class="tooltip">
                    <a class="attblock" href="javascript:openWortimeListPopup('${data.userId }','03')">${data.month03 eq 0 ? '': data.month03}</a>
                     <div id="attendanceBox"  name="attendanceBox_${data.userId }03" class="tooltip_box" style="display:none" ></div>
                </span>
            </td>           <td class="txt_letter0">
                <span class="tooltip">
                    <a class="attblock" href="javascript:openWortimeListPopup('${data.userId }','04')">${data.month04 eq 0 ? '': data.month04}</a>
                     <div id="attendanceBox"  name="attendanceBox_${data.userId }04" class="tooltip_box" style="display:none" ></div>
                </span>
            </td>           <td class="txt_letter0">
                <span class="tooltip">
                    <a class="attblock" href="javascript:openWortimeListPopup('${data.userId }','05')">${data.month05 eq 0 ? '': data.month05}</a>
                     <div id="attendanceBox"  name="attendanceBox_${data.userId }05" class="tooltip_box" style="display:none" ></div>
                </span>
            </td>           <td class="txt_letter0">
                <span class="tooltip">
                    <a class="attblock" href="javascript:openWortimeListPopup('${data.userId }','06')">${data.month06 eq 0 ? '': data.month06}</a>
                     <div id="attendanceBox"  name="attendanceBox_${data.userId }06" class="tooltip_box" style="display:none" ></div>
                </span>
            </td>           <td class="txt_letter0">
                <span class="tooltip">
                    <a class="attblock" href="javascript:openWortimeListPopup('${data.userId }','07')">${data.month07 eq 0 ? '': data.month07}</a>
                     <div id="attendanceBox"  name="attendanceBox_${data.userId }07" class="tooltip_box" style="display:none" ></div>
                </span>
            </td>           <td class="txt_letter0">
                <span class="tooltip">
                    <a class="attblock" href="javascript:openWortimeListPopup('${data.userId }','08')">${data.month08 eq 0 ? '': data.month08}</a>
                     <div id="attendanceBox"  name="attendanceBox_${data.userId }08" class="tooltip_box" style="display:none" ></div>
                </span>
            </td>           <td class="txt_letter0">
                <span class="tooltip">
                    <a class="attblock" href="javascript:openWortimeListPopup('${data.userId }','09')">${data.month09 eq 0 ? '': data.month09}</a>
                     <div id="attendanceBox"  name="attendanceBox_${data.userId }09" class="tooltip_box" style="display:none" ></div>
                </span>
            </td>
            <td class="txt_letter0">
                <span class="tooltip">
                    <a class="attblock" href="javascript:openWortimeListPopup('${data.userId }','10')">${data.month10 eq 0 ? '': data.month10}</a>
                     <div id="attendanceBox"  name="attendanceBox_${data.userId }10" class="tooltip_box" style="display:none" ></div>
                </span>
            </td>
            <td class="txt_letter0">
                <span class="tooltip">
                    <a class="attblock" href="javascript:openWortimeListPopup('${data.userId }','11')">${data.month11 eq 0 ? '': data.month11}</a>
                     <div id="attendanceBox"  id="attendanceBox_${data.userId }11" class="tooltip_box" style="display:none" ></div>
                </span>
            </td>
            <td class="txt_letter0">
                <span class="tooltip">
                    <a class="attblock" href="javascript:openWortimeListPopup('${data.userId }','12')">${data.month12 eq 0 ? '': data.month12}</a>
                     <div id="attendanceBox"  name="attendanceBox_${data.userId }12" class="tooltip_box" style="display:none" ></div>
                </span>
            </td>
            <td class="state_normal_td">
                <span class="attend_list">
                    <c:if test="${data.leaveSum ne 0}"><span class="st_vaca">휴가:<em>${data.leaveSum}</em></span></c:if>
                    <c:if test="${data.halfSum ne 0}"><span class="st_vaca">반차:<em>${data.halfSum}</em></span></c:if>
                    <c:if test="${data.fEventSum ne 0}"><span class="st_edu">경조휴가:<em>${data.fEventSum}</em></span></c:if>
                    <c:if test="${data.sickSum ne 0}"><span class="st_sick">병가:<em>${data.sickSum}</em></span></c:if>
                    <c:if test="${data.restSum ne 0}"><span class="st_stopw">휴직:<em>${data.restSum}</em></span></c:if>
                    <c:if test="${data.etcLeaveSum ne 0}"><span class="st_vaca">기타휴가:<em>${data.etcLeaveSum}</em></span></c:if>
                    <c:if test="${data.etcHalfSum ne 0}"><span class="st_vaca">기타반차:<em>${data.etcHalfSum}</em></span></c:if>
                    <c:if test="${data.attendSum ne 0}"><span class="st_stopw">현지출근:<em>${data.attendSum}</em></span></c:if>
                </span>
            </td>
            <td class="state_wrong_td">
                <span class="attend_list">
	                <c:if test="${data.noLoginSum ne 0}"><span class="st_sick">미로그인:<em>${data.noLoginSum}</em></span></c:if>
	                <c:if test="${data.lateSum ne 0}"><span class="st_stopw">지각:<em>${data.lateSum}</em></span></c:if>
	                <c:if test="${data.noWorkSum ne 0}"><span class="st_stopw">결근:<em>${data.noWorkSum}</em></span></c:if>
	            </span>
            </td>
        </tr>
        </c:forEach>
        <c:if test = "${fn:length(worktimeList)<=0 }">
            <tr>
                <td colspan="18" class="no_result">
                    <p class="nr_des">조회된 데이터가 없습니다.</p>
                </td>
            </tr>
        </c:if>
    </tbody>
</table>
<!--// 연차상세옵션 //-->
<!-----------------------------------------------------근태현황 년별 End --------------------------------------------------->
</div>

