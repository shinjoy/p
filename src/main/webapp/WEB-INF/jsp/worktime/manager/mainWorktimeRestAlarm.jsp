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
    function openDetail(searchDate){
        parent.opener.location = contextRoot+"/worktime/manager/attendanceMgmt.do?searchDate=" + searchDate;
        	//	+ "&searchMonth="+ searchMonth;
        window.close();
    }

  //창 닫기 클릭시 쿠키 처리
    function closeWin() {

        if(document.getElementById("check_today").checked){
            /* setCookie("cookie_"+"${alarm.alarmId}", "done", 1); // 쿠기 만료일 하루 뒤 */
            setCookie("cookie_alarmWorktimeRest", "done", 1); // 쿠기 만료일 하루 뒤
            window.close();
        }else{
            window.close();
        }
    }

</script>

    <div id="compnay_dinfo">
        <!--업무일지등록-->
        <div class="modalWrap2">
            <h1><strong>[복직/출근인정 요청안내]</strong></h1>
            <div class="mo_container2">
                <div class="popalarmWrap">
                    <h3 class="h3_title_basic">출근인정 요청안내</h3>
                    <!--출근인정 요청안내-->
                    <table class="tb_list_basic3" summary="출근인정 요청안내 (이름, 부서(직책), 요청사유, 지각일)">
                        <caption>출근인정 요청안내</caption>
                        <colgroup>
                            <col width="80" />
                            <col width="130" />
                            <col width="*" />
                            <col width="70" />
                            <col width="100" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">이름</th>
                                <th scope="col">부서(직책)</th>
                                <th scope="col">요청사유</th>
                                <th scope="col">구분</th>
                                <th scope="col">근무일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="data" items="${worktimeReqList}" varStatus="status">
                                <tr onClick="openDetail('${data.searchDate}');"  style="cursor:pointer;">
                                    <td>${data.userNm}</td>
                                    <td>${data.deptNm}(${data.userRank})</td>
                                    <td>${data.workReqReason}</td>
                                    <td>${data.workTypeNm}</td>
                                    <td class="txt_letter0 fontRed">${data.workDate}</td>
                                </tr>
                            </c:forEach>
                            <c:if test = "${fn:length(worktimeReqList)<=0}">
                                <tr>
                                    <td colspan="5" class="no_result">
                                        <p class="nr_des">조회된 데이터가 없습니다.</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                    <p class="notice_script">* 목록을 클릭하시면 근태관리 상세페이지로 이동하여 근태상태를 설정 할 수 있습니다.</p>
                    <!--//출근인정 요청안내//-->
                    <h3 class="h3_title_basic mgt30">휴직종료 사전안내</h3>
                    <!--휴직종료 사전안내-->
                    <table class="tb_list_basic3" summary="휴직종료 사전안내 (이름, 부서(직책), 휴직기간, 복직일)">
                        <caption>휴직종료 사전안내</caption>
                        <colgroup>
                            <col width="100" />
                            <col width="150" />
                            <col width="*" />
                            <col width="100" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">이름</th>
                                <th scope="col">부서(직책)</th>
                                <th scope="col">휴직기간</th>
                                <th scope="col">복직일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="data" items="${worktimeRestList}" varStatus="status">
                            <c:set var="arrPerNm" value="${fn:split(data.entryNm,':::::')}" />
	                            <tr>
	                                <td>
	                                    <c:forEach items="${arrPerNm}" var="perNm"  varStatus="scheStatus">
                                           ${fn:split(perNm,'||-||')[0] }<br/>
                                        </c:forEach>
                                    </td>
	                                <td>
	                                    <c:forEach items="${arrPerNm}" var="perNm" varStatus="scheStatus">
                                           ${fn:split(perNm,'||-||')[2]}(${fn:split(perNm,'||-||')[1]})<br/>
                                        </c:forEach>
	                                </td>
	                                <td class="txt_letter0">
	                                    ${fn:replace(data.scheSDate,'-','.')} ~ ${fn:replace(data.scheEDate,'-','.')}(${data.dateDiff}일)
	                                </td>
	                                <td class="txt_letter0 fontBlue">
	                                    ${data.scheEDate1}
                                    </td>
	                            </tr>
	                        </c:forEach>
	                        <c:if test = "${fn:length(worktimeRestList)<=0}">
                                <tr>
                                    <td colspan="4" class="no_result">
                                        <p class="nr_des">조회된 데이터가 없습니다.</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                    <!--//휴직종료 사전안내//-->

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

