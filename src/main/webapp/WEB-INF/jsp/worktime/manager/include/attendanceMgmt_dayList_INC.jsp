<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script type="text/javascript">

    $(document).ready(function(){
    	//$('#searchDate').val("2016-12-10");
        //$('#searchDate').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});

        var choiceYear = parseInt("${fn:split(searchDate,'-')[0]}");
        var choiceMonth = parseInt("${fn:split(searchDate,'-')[1]}")-1;
        var choiceDay = parseInt("${fn:split(searchDate,'-')[2]}");
        var loadDt = new Date(choiceYear,choiceMonth,choiceDay); //현재 날짜 및 시간   //현재시간 기준 계산
        var maxDay = 32 - new Date(choiceYear, choiceMonth, 32).getDate();

    	var nowYear = new Date().getFullYear();
        for (i = (nowYear+3); i > 2000; i--){
            $('#choiceYear').append($('<option />').val(i).html(i));
        }
        for (i = 1; i < 13; i++){
        	var str = lpad(i+'',2,'0');
            $('#choiceMonth').append($('<option />').val(str).html(str));
        }
        for (i = 1; i <= maxDay; i++){
        	var str = lpad(i+'',2,'0');
            $('#choiceDay').append($('<option />').val(str).html(str));
        }


        if ( $.browser.msie ) {
            var expr = new RegExp('>[ \t\r\n\v\f]*<', 'g');
            $('#contentsArea').html( ($('#contentsArea').html() + "").replace(expr, '><')  );
        }

        $("#frm select[name=choiceYear]").val("${fn:split(searchDate,'-')[0]}");
        $("#frm select[name=choiceMonth]").val("${fn:split(searchDate,'-')[1]}");
        $("#frm select[name=choiceDay]").val("${fn:split(searchDate,'-')[2]}");

    });

   // 달력이동
    function moveDay(interVal) {
	    var choiceYear = parseInt($("#choiceYear").val());
	    var choiceMonth = parseInt($("#choiceMonth").val())-1;
	    var choiceDay = parseInt($("#choiceDay").val());

	    var loadDt = new Date(choiceYear,choiceMonth,choiceDay); //현재 날짜 및 시간   //현재시간 기준 계산
	    var newDate= new Date(Date.parse(loadDt) + (interVal * 1000 * 60 * 60 * 24));  //하루전/후
	    var strDate = getFormatDate(newDate,'-');

	    $('#choiceYear').val(strDate.split('-')[0]);
	    $('#choiceMonth').val(strDate.split('-')[1]);
	    $('#choiceDay').val(strDate.split('-')[2]);

	    $("#searchDate").val(strDate);
	    linkPage(1);  //조회
    }
   //날짜선택
   function selectDate(){
       $("#searchDate").val($("#choiceYear").val() + "-" + $("#choiceMonth").val() + "-" + $("#choiceDay").val());
	   linkPage(1);  //조회
   }
 //날짜선택
   function selectMonth(){
       var choiceYear = parseInt($("#choiceYear").val());
       var choiceMonth = parseInt($("#choiceMonth").val())-1;
       var choiceDay = parseInt($("#choiceDay").val());
       var maxDay = 32 - new Date(choiceYear, choiceMonth, 32).getDate();

       $("#choiceDay").find("option").remove();
       for (i = 1; i <= maxDay; i++){
           var str = lpad(i+'',2,'0');
           $('#choiceDay').append($('<option />').val(str).html(str));
       }

       $("#searchDate").val($("#choiceYear").val() + "-" + $("#choiceMonth").val() + "-" + $("#choiceDay").val());
       linkPage(1);  //조회
   }
</script>

<input type="hidden" name = "endYn"  id = "endYn" value="${worktimeEndInfo.endYn}" />
<input type="hidden" name = "notApproveCnt"  id = "notApproveCnt" value="${worktimeEndInfo.notApproveCnt}" />
<input type="hidden" name = "strSearchDate"  id = "strSearchDate" value="${fn:split(searchDate,'-')[0]}년 ${fn:split(searchDate,'-')[1]}월 ${fn:split(searchDate,'-')[2]}일" />
<input type="hidden" name = "endDateYn"  id = "endDateYn" value="${worktimeEndInfo.endDateYn}" />
<input type="hidden" name = "searchDate"  id = "searchDate" value="${searchDate}" />

<div id="contentsArea" >
<!--기간선택(일)-->
<div class="carSearchBox mgt20">
	<span class="carSearchtitle"><label for="choiceYear">날짜선택</label></span>
	<button type="button" class="btn_arrow_calleft mgl10" onClick="moveDay(-1);"><em>이전</em></button>
	<select id="choiceYear"  name="choiceYear"  class="select_b w_date mgr3"  onchange="selectMonth();"></select><span>년</span>
	<select id="choiceMonth" name="choiceMonth"  class="select_b w_monthday mgr3 mgl6"  onchange="selectMonth();"></select><span>월</span>
	<select id="choiceDay" name="choiceDay"  class="select_b w_monthday mgr3 mgl6"  onchange="selectDate();"></select><span>일</span>
	<button type="button" class="btn_arrow_calright" onClick="moveDay(1);"><em>다음</em></button>
<c:if test="${pageType eq 'MGMT'}">
    <div class="btnRightZone">
        <button name="reg_btn" class="btn_b2_skyblue" onclick="javascript:excelDownDayList();return false;"><em class="icon_XLS">파일로 저장</em></button>
    </div>
</c:if>
</div>
<!--//기간선택(일)//-->

<!--연차기본셋팅-->
<h3 class="h3_title_basic mgt20">근태현황 <span id="capSearch"  class="sub_desc">(${fn:split(searchDate,'-')[0]}년 ${fn:split(searchDate,'-')[1]}월 ${fn:split(searchDate,'-')[2]}일)</span>
<c:if test="${targetOrgId eq baseUserLoginInfo.orgId && pageType eq 'MGMT'}">
	<c:choose>
	    <c:when test="${worktimeEndInfo.endYn eq 'N'}">
	        <a class="btn_s_type3 mgl10 btn_auth" href="javascript:processWorkTimeDayEnd();" ><em class="icon_calcheck">일근태마감</em></a>
	    </c:when>
	    <c:when test="${worktimeEndInfo.endYn eq 'Y'}">
	        <a class="btn_s_type3 mgl10 btn_auth" ><em class="icon_calcheck">일근태마감 완료</em></a>
	    </c:when>
	    <c:otherwise>

	    </c:otherwise>
	</c:choose>
</c:if>
</h3>

<c:if test="${pageType eq  'MGMT' || viewAuth ne 'USER'}">
<table id="SGridTargetSum"  class="tb_regi_basic" summary="근태현황">
	<caption>근태현황 (${fn:split(searchDate,'-')[0]}년 ${fn:split(searchDate,'-')[1]}월 ${fn:split(searchDate,'-')[2]}일)</caption>
	<colgroup>
		<col width="160" />
		<col width="*" />
	</colgroup>
	<tbody>
		<tr>
			<th>전체직원</th>
			<td><strong class="fontB">${worktimeStatistics.totalCnt }명</strong></td>
		</tr>
		<tr>
			<th>정상근태</th>
			<td>
			    <%-- <strong class="state_tt">${worktimeStatistics.normalTotCnt }명</strong> --%>
				<span class="attend_list">
					<span class="st_normal">정상출근:<em>${worktimeStatistics.workCnt }</em></span>
					<span class="st_vaca">휴가:<em>${worktimeStatistics.leaveCnt }</em></span>
					<span class="st_vaca">반차:<em>${worktimeStatistics.halfCnt }</em></span>
					<span class="st_edu">경조:<em>${worktimeStatistics.fEventCnt }</em></span>
					<span class="st_sick">병가:<em>${worktimeStatistics.sickCnt }</em></span>
					<span class="st_stopw">휴직:<em>${worktimeStatistics.restCnt }</em></span>
					<span class="st_vaca">기타휴가:<em>${worktimeStatistics.etcLeaveCnt }</em></span>
                    <span class="st_vaca">기타반차:<em>${worktimeStatistics.etcHalfCnt }</em></span>
					<span class="st_stopw">현지출근:<em>${worktimeStatistics.attendCnt }</em></span>
					<%--<span class="st_bsstrip">출장:<em>3</em></span>
					<span class="st_edu">교육:<em>2</em></span>--%>
				</span>
				<button type="button" class="btn_s_replay mgl10" onclick="linkPage(1);"><em>부모코드초기화</em></button>
			</td>
		</tr>
		<tr>
			<th>무단 및 미확인 근태</th>
			<td>
			     <%-- <strong class="state_tt2">${worktimeStatistics.nonTotCnt }명</strong> --%>
				<span class="attend_list">
					<span class="st_login">미로그인:<em>${worktimeStatistics.noLoginCnt }</em></span>
					<span class="st_late">지각:<em>${worktimeStatistics.lateCnt }</em></span>
					<span class="st_absence">결근:<em>${worktimeStatistics.noWorkCnt }</em></span>
				</span>
			</td>
		</tr>
	</tbody>
</table>
</c:if>
<!--// 연차기본셋팅 //-->


<!--근태현황목록-->
<c:set var="compareDeptId" value="0"></c:set>

<c:set var="idx" value="1"></c:set>

<c:forEach items="${worktimeList }" var="data" varStatus="i">
	<c:if test="${data.deptId ne compareDeptId }">
		<c:if test = "${i.index ne 0  }">
					</tbody>
				</table>
			</div>
		</div>
		<c:set var="idx" value="1"></c:set>
		</c:if>

		<!-- header -->
		<div id="weekwork_wrap">

		<h3 class="h3_title_basic mgt20"><span>${data.deptNm}</span></h3>
		<div class="weekwork_header">
		<table id="SGridTarget" class="tb_list_basic" summary="근태현황목록(번호, 이름, 부서, 직위, 출근, 퇴근, 근태여부, 비고)">
			<caption>근태현황목록</caption>
			<colgroup>
				<col width="4%" /> <!--번호-->
				<col width="10%" /> <!--이름-->
				<col width="15%" /> <!--부서-->
				<col width="10%" /> <!--직위-->
				<col width="5%" /> <!--출근-->
				<col width="5%" /> <!--퇴근-->
				<col width="6%" /> <!--근태여부-->
				<col width="6%" /> <!--퇴근체크-->
				<col width="19%" /> <!--일정-->
		        <col width="*" /> <!--비고-->
		        <c:if test="${pageType eq 'MGMT'}">
		        	<col width="100" /> <!--출근인정-->
		        </c:if>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">이름</th>
					<th scope="col">부서</th>
					<th scope="col">직위</th>
					<th scope="col">출근</th>
					<th scope="col">퇴근</th>
					<th scope="col">근태여부</th>
					<th scope="col">퇴근체크</th>
					<th scope="col">일정</th>
		            <th scope="col">비고</th>
		            <c:if test="${pageType eq 'MGMT'}">
		                <th scope="col">출근인정</th>
		            </c:if>
				</tr>
			</thead>
		</table>
		</div>
		<!-- //header// -->
		<!-- body -->
		<div class="weekwork_conBox">
		<table id="SGridTarget" class="tb_list_basic" summary="근태현황목록(번호, 이름, 부서, 직위, 출근, 퇴근, 근태여부, 비고)">
				<caption>근태현황목록</caption>
				<colgroup>
					<col width="4%" /> <!--번호-->
					<col width="10%" /> <!--이름-->
					<col width="15%" /> <!--부서-->
					<col width="10%" /> <!--직위-->
					<col width="5%" /> <!--출근-->
					<col width="5%" /> <!--퇴근-->
					<col width="6%" /> <!--근태여부-->
					<col width="6%" /> <!--퇴근체크-->
					<col width="19%" /> <!--일정-->
			        <col width="*" /> <!--비고-->
			        <c:if test="${pageType eq 'MGMT'}">
			        	<col width="100" /> <!--출근인정-->
			        </c:if>
				</colgroup>
				<tbody>
				<c:set var="compareDeptId" value="${data.deptId }"></c:set>
	 </c:if>
				<tr>
					<td class="txt_letter0">${idx}</td>
					<td>${data.name }</td>
					<td>${data.deptNm }</td>
					<td>${data.position }</td>
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
		                <span>${data.workReqReason}</span>
		                <c:if test="${not empty data.mngWorkPrcReason}">
		                    <a class="approv_txt agree"><strong>[관리자]</strong></a>${data.mngWorkPrcReason }
		                </c:if>
					</td>
					<c:if test="${pageType eq 'MGMT'}">
						<td>
			                <!--  WORK, NO_WORK, LATE(정상, 결근, 지각) -->
			                <c:choose>
			                    <c:when test="${(data.workReqType eq 'WORK' || data.workReqType eq 'LATE') && empty data.workReqAcceptYn}">
			                        <a href="javascript:openAttendanceApprov('${data.worktimeId }','APPROVE')" class="btn_s_type_blue2 orgAuth"><em>근태승인</em></a>
			                    </c:when>
			                    <c:when test="${(data.workReqType eq 'WORK' || data.workReqType eq 'LATE') && not empty data.workReqAcceptYn}">
			                        <a href="javascript:openAttendanceApprov('${data.worktimeId }','UPDATE')" class="btn_s_type_blue2 orgAuth"><em>승인수정</em></a>
			                    </c:when>
			                    <c:otherwise>
			                        <a href="javascript:openAttendanceApprov('${data.worktimeId }','MANAGEMENT')" class="s_gray01_btn orgAuth"><em>근태관리</em></a>
			                    </c:otherwise>
			                </c:choose>
			            </td>
			        </c:if>
				</tr>
<c:set var="idx" value="${idx+1}"></c:set>
</c:forEach>

<c:if test = "${fn:length(worktimeList)<=0 }">
	<table id="SGridTarget" class="tb_list_basic mgt30" summary="근태현황목록(번호, 이름, 부서, 직위, 출근, 퇴근, 근태여부, 비고)">
					<caption>근태현황목록</caption>
					<colgroup>
						<col width="4%" /> <!--번호-->
						<col width="10%" /> <!--이름-->
						<col width="15%" /> <!--부서-->
						<col width="10%" /> <!--직위-->
						<col width="5%" /> <!--출근-->
						<col width="5%" /> <!--퇴근-->
						<col width="6%" /> <!--근태여부-->
						<col width="6%" /> <!--퇴근체크-->
						<col width="19%" /> <!--일정-->
				        <col width="*" /> <!--비고-->
				        <c:if test="${pageType eq 'MGMT'}">
				        	<col width="100" /> <!--출근인정-->
				        </c:if>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">이름</th>
							<th scope="col">부서</th>
							<th scope="col">직위</th>
							<th scope="col">출근</th>
							<th scope="col">퇴근</th>
							<th scope="col">근태여부</th>
							<th scope="col">퇴근체크</th>
							<th scope="col">일정</th>
				            <th scope="col">비고</th>
				            <c:if test="${pageType eq 'MGMT'}">
				                <th scope="col">출근인정</th>
				            </c:if>
						</tr>
					</thead>
					<tbody>
					    <tr>
					        <td colspan="${pageType eq 'MGMT' ? 11 : 10}" class="no_result">
					            <p class="nr_des">조회된 데이터가 없습니다.</p>
					        </td>
					    </tr>
					</tbody>
	</table>
</c:if>
<!--// 근태현황목록 //-->
<!--페이지목록-->

</div>
<script type="text/javascript">
    // $("#totalCnt").text("${paginationInfo.totalRecordCount }");
</script>