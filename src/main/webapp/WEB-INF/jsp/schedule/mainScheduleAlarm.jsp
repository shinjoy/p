<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javaScript" language="javascript">
	$(document).ready(function () {
		$(window).load(function() {

		});
	});

	//상세보기 열기
    function openDetail(idx){
        if( $("#trDetail"+idx).css("display") != "none" ) {
            $("#trDetail"+idx).hide();
        } else {
            $("#trDetail"+idx).show()
        }
        //$("#trDetail"+idx).toggle();
    }

  //창 닫기 클릭시 쿠키 처리
    function closeWin() {
    	/* $('#WinClose').click(function() {
            if($('#WinClose').is(':checked')) setWinCookie('popScheduleAlarmList', 'Y', 1);
            window.close();
        }); */
        if(document.getElementById("check_today").checked){
            /* setCookie("cookie_"+"${alarm.alarmId}", "done", 1); // 쿠기 만료일 하루 뒤 */
            setCookie("cookie_alarmSchedule", "done", 1); // 쿠기 만료일 하루 뒤
            window.close();
        }else{
            window.close();
        }
    }

    function goScheduleMain(){
        $("#ScheduleAlarmList").attr("action",contextRoot+"/ScheduleCal.do").submit();
    }
</script>

	<form name="ScheduleAlarmList" id="ScheduleAlarmList" action="<c:url value='/ScheduleCal.do'/>" method="post">


	<div id="compnay_dinfo">
        <!--업무일지등록-->
        <div class="modalWrap2">
            <h1><strong>일정알림</strong></h1>
            <div class="mo_container2">
                <div class="popalarmWrap">
                    <h3 class="h3_title_basic">내일정 목록</h3>
                    <!--업무일지상세보기-->
                    <table class="tb_acodi_st" summary="부서별통계(1월~12월, 영업관리비, 복리후생비, 대중교통비, 차량유지비, 택배비, 소모품비)">
                        <caption>부서별통계</caption>
                        <colgroup>
                            <col width="90" />
                            <col width="90" />
                            <col width="*" />
                            <col width="70" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">일자</th>   <!-- <a href="#" class="sort_normal">일자</a> -->
                                <th>시간</th>
                                <th>업무내용</th>
                                <th scope="col">D-day</th>  <!-- <a href="#" class="sort_hightolow">D-day<em>내림차순</em></a> -->
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="oldScheSeq" value="0" />
                            <c:forEach var="scheVO" items="${AlarmList}" varStatus="status">
                            <c:if test="${scheVO.scheSeq ne oldScheSeq}">
                            <tr onClick="openDetail('${status.count}');"  style="cursor:pointer;"  class="tr_selected">
                                <td class="num_date_type">
                                    ${fn:replace(scheVO.scheSDate,'-','/')}  <!-- (목) -->
                                </td>
                                <td class="time_bg">
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
                                    <!--  <span class="icon_new"><em>new</em></span>    -->
                                </td>
                                <td class="txt_dday">${scheVO.extraDay} 일</td>
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
                                                        <span class="employee_list" >
                                                            ${scheVO.entryNmDetail}
                                                        </span>
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
                                                                    <li><a class="" ><em>+2</em></a></li>
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
                                                                <span class="st_finish">진행중</span>
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
                                    </div>
                                    <div class="btn_td_control">
                                      <a href="javascript:openDetail('${status.count}');" class="btn_td_close"><em>닫기</em></a>
                                      <%-- <a href="javascript:openDetail('${status.count}');" class="btn_td_open"><em>열기</em></a> --%>
                                     </div>
                                    <!--//상세보기내용//-->
                                </td>
                            </tr>
                            </c:if>
                            <c:set var="oldScheSeq" value="${scheVO.scheSeq}" />
                        </c:forEach>
                        </tbody>
                    </table>
                    <!--//업무일지상세보기//-->
                </div>
            </div>
            <!--창닫기-->
		    <div class="todayclosebox">
		        <div class="fl_block"><label><input type="checkbox"  name="check_today" id="check_today"  onclick="closeWin();"/><span>오늘은 그만보기</span></label></div>
		        <div class="fr_block"><button type="button" class="btn_close" onClick="closeWin();"><span>닫기</span><span>X</span></button></div>
		    </div>
		    <!--//창닫기//-->
        </div>
        <!--//업무일지등록//-->
    </div>
</form>
