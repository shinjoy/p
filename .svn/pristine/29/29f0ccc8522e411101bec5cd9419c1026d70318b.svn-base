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
    function openDetail(scheSeq,perSabun,projectId){
    	var url = contextRoot + "/ScheduleView.do?ScheSeq="+scheSeq+"&PerSabun="+perSabun+"&projectId="+projectId+"&EventType=View&ParentPage=Cal";
        window.open(url, 'scheduleView','resizable=no,width=700,height=750,scrollbars=yes');
    }

  //창 닫기 클릭시 쿠키 처리
    function closeWin() {

        if(document.getElementById("check_today").checked){
            setCookie("cookie_alarmSpotWork", "done", 1); // 쿠기 만료일 하루 뒤
            window.close();
        }else{
            window.close();
        }
    }
  function goAttendanceMgmtPage(){
	  parent.opener.location = contextRoot+"/worktime/manager/attendanceMgmt.do";
      window.close();
  }

</script>

    <div id="compnay_dinfo">
        <!--업무일지등록-->
        <div class="modalWrap2">
            <h1><strong>[금일 현지출근 직원안내]</strong></h1>
            <div class="mo_container2">
                <div class="popalarmWrap">
                    <h3 class="h3_title_basic mgt20">
                        <span>현지출근 직원</span>
                        <a href="javascript:goAttendanceMgmtPage();"  class="btn_s_type3 mgl15"><em class="icon_calcheck">근태관리 바로가기</em></a>
                    </h3>
                    <!--현지출근 직원목록-->
                    <table class="tb_list_basic3" summary="현지출근 직원목록(이름, 부서(직책), 현지출근 사유, 시간)">
                        <caption>현지출근 직원목록</caption>
                        <colgroup>
                            <col width="80" />
                            <col width="140" />
                            <col width="*" />
                            <col width="100" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">이름</th>
                                <th scope="col">부서(직책)</th>
                                <th scope="col">현지출근 사유</th>
                                <th scope="col">시간</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="data" items="${resultList}" varStatus="status">
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
	                                <td class="txt_b_title"><a href="javascript:openDetail('${data.scheSeq}', '${data.perSabun}' , '${data.projectId}' );" class="ellipsis">[${data.activityNm}]${data.scheTitle}</a></td>
	                                <td>
                                    <c:choose>
                                          <c:when test="${data.scheAllTime eq 'Y' && data.scheGrpCd ne 'Period'}">
                                              <p>(종일)${fn:replace(data.scheSDate,'-','.')}</p>
                                           </c:when>
                                           <c:when test="${data.scheAllTime eq 'Y' && data.scheGrpCd eq 'Period'}">
                                              <p>(종일)${fn:replace(data.scheSDate,'-','.')} ~ ${fn:replace(data.scheEDate,'-','.')}</p>
                                           </c:when>
                                           <c:when test="${data.scheGrpCd eq 'Period'}">
                                               <p>${fn:replace(data.scheSDate,'-','.')} ${data.scheSTime}</p>
                                                ~
                                               <p>${fn:replace(data.scheEDate,'-','.')} ${data.scheETime}</p>
                                           </c:when>
                                           <c:otherwise>
                                               <p>${fn:replace(data.scheSDate,'-','.')}</p>
                                               <p>[${data.scheSTime}~${data.scheETime}]</p>
                                           </c:otherwise>
                                       </c:choose>
	                                </td>
	                            </tr>
	                        </c:forEach>
                        </tbody>
                    </table>
                    <p class="notice_script fontRed">* 목록을 클릭하시면 근태관리 상세페이지로 이동하여 근태상태를 설정 할 수 있습니다.</p>
                    <!--//현지출근 직원목록//-->
                </div>
            </div>
            <!--창닫기-->
            <div class="todayclosebox">
                <div class="fl_block"><label><input type="checkbox" name="check_today" id="check_today"  onclick="closeWin();"/><span>오늘하루열지 않음</span></label></div>
                <div class="fr_block"><button type="button" class="btn_close" onClick="closeWin();"><span>닫기</span><span>X</span></button></div>
            </div>
            <!--//창닫기//-->
        </div>
        <!--//업무일지등록//-->
    </div>

