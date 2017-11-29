<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script type="text/javascript">
$(document).ready(function(){
    //
});

// 저장
function doSave(){
	if($("#mngWorkPrcReason").val() == ""){
        alert("사유를 입력하여 주시기 바랍니다.");
        $("#mngWorkPrcReason").focus();
        return;
    }
    $('#frm').attr('action', "<c:url value='/worktime/manager/doSaveAttendanceApprov.do'/>");
    commonAjaxSubmit("POST", $("#frm"), doSaveCallback);
}
//저장후 콜백
function doSaveCallback(result){
    if(result.result == "SUCCESS"){
        alert("정상적으로 저장되었습니다.");
        opener.parent.openPage();
        window.close();
    }else if(result.result == "FAIL"){
        alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
    }else{
        alert(result.result);
    }
}
</script>

<form id = "frm" name = "frm">
<input type="hidden" name = "worktimeId"  id = "worktimeId" value="${worktime.worktimeId }" />
<input type="hidden" name = "workReqType"  id = "workReqType" value="${worktime.workReqType }" />
<input type="hidden" name = "actionType"  id = "actionType"  value="${actionType}" />

    <div id="compnay_dinfo">
        <!--회사상세보기(회사정보)-->
        <div class="modalWrap2">
            <h1>
                <c:choose>
                    <c:when test="${actionType eq 'MANAGEMENT' }"><strong>[근태관리]</strong></c:when>
                    <c:otherwise><strong>[근태요청화면]</strong></c:otherwise>
                </c:choose>
                ${worktime.deptNm} ${worktime.name} ${worktime.position}
            </h1>
            <div class="mo_container">


                <!--회사리스트-->
                <table class="tb_regi_basic2" summary="보고서 리스트 (등록일, 제목, 상태, 작성자, 조회)">
                    <caption>보고서 리스트</caption>
                    <colgroup>
                        <col width="120">
                        <col width="*">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="col">날짜</th>
                            <td class="txt_letter0">${worktime.workDate}(${worktime.workDateWeek})</td>
                        </tr>
                        <tr>
                            <th scope="col">출근</th>
                            <td class="txt_time p_color_wrong">${worktime.inTime }</td>
                        </tr>
                        <tr>
                            <th scope="col">근태여부</th>
                            <td class="txt_time p_color_wrong">${worktime.workTypeNm }</td>
                        </tr>
                        <tr>
                            <th scope="col">근태요청구분</th>
                            <td class="txt_left">
                                <c:choose>
                                    <c:when test="${worktime.workReqType eq 'WORK' }">
                                        <strong>출근인정요청</strong>
                                    </c:when>
                                    <c:when test="${worktime.workReqType eq 'LATE' }">
                                        <strong>지각인정요청</strong>
                                    </c:when>
                                    <c:otherwise>
                                        <strong>요청내역 없음</strong>
                                    </c:otherwise>
                                </c:choose>
                             </td>
                        </tr>
                        <tr>
                            <th scope="col">근태요청마감일</th>
                            <td class="txt_letter0">${worktime.workDateEnd}(${worktime.workDateEndWeek})</td>
                        </tr>
                        <c:if test="${actionType eq 'APPROVE' && not empty worktime.workReqReason}">
	                        <tr>
	                            <th class="vt" scope="col">사용자 사유</th>
	                            <td class="txt_left">
	                                <div class="conview_Box2">${worktime.workReqReason }</div>
	                            </td>
	                        </tr>
                        </c:if>
                        <%-- <c:choose>
	                        <c:when test="${actionType eq 'APPROVE' && not empty worktime.mngWorkPrcReason}">
	                            <tr>
		                            <th class="vt" scope="col">관리자 사유</th>
		                            <td class="txt_left">
		                               <div class="conview_Box2">${worktime.mngWorkPrcReason}</div>
		                            </td>
		                        </tr>
	                        </c:when>
	                        <c:when test="${actionType eq 'UPDATE' || actionType eq 'MANAGEMENT'}">
		                        <tr>
		                            <th class="vt" scope="col">사유입력</th>
		                            <td class="txt_left">
	                                    <div class="conview_Box2">
	                                        <textarea class="textarea_basic w100pro" id="mngWorkPrcReason" name="mngWorkPrcReason"     placeholder="근태 수정사유을 입력해 주세요.">${worktime.mngWorkPrcReason}</textarea>
	                                    </div>
		                            </td>
		                        </tr>
		                    </c:when>
	                    </c:choose> --%>
	                    <c:if test="${actionType ne 'APPROVE'}">
		                    <tr>
	                            <th scope="row" class="vt">사유입력</th>
	                            <td class="txt_left">
	                                <ul class="reasonList">
	                                    <c:if test="${actionType eq 'UPDATE' && not empty worktime.workReqReason}">
	                                        <li><span class="reason_st">[사용자]</span><span class="date_st"></span>${worktime.workReqReason}</li>
	                                    </c:if>
	                                    <%-- <c:if test="${actionType eq 'APPROVE' && not empty worktime.mngWorkPrcReason}">
	                                        <li><span class="reason_st">[${worktime.mngWorkPrcTypeNm}]</span><span class="date_st">${worktime.mngWorkPrcDate}</span>${worktime.mngWorkPrcReason}</li>
	                                    </c:if> --%>
	                                </ul>
	                                <c:if test="${actionType eq 'UPDATE' || actionType eq 'MANAGEMENT'}">
	                                    <textarea id="mngWorkPrcReason" name="mngWorkPrcReason"  class="textarea_basic w100pro" placeholder="사유를 입력하세요.">${worktime.mngWorkPrcReason}</textarea>
	                                </c:if>
	                            </td>
	                        </tr>
	                    </c:if>
                    </tbody>
                </table>
                <!--//회사리스트//-->
                <table class="tb_regi_basic2 mgt10" summary="보고서 리스트 (등록일, 제목, 상태, 작성자, 조회)">
                    <caption>보고서 리스트</caption>
                    <colgroup>
                        <col width="120">
                        <col width="*">
                    </colgroup>
                    <tbody>
                        <c:choose>
                            <c:when test="${actionType eq 'APPROVE' }">
                                <tr>
                                    <th scope="col">최종승인</th>
                                    <td class="txt_left">
                                        <span class="radio_list2">
                                            <label><input id="workReqAcceptYn" name="workReqAcceptYn" type="radio" value="Y" checked=""><span>승인</span></label>
                                            <label><input id="workReqAcceptYn" name="workReqAcceptYn" type="radio" value="N" ><span>반려</span></label>
                                        </span>
                                   </td>
                                </tr>
                            </c:when>
                            <c:when test="${actionType eq 'UPDATE' || actionType eq 'MANAGEMENT'}">
                                <tr>
                                    <th scope="col">근태처리</th>
                                    <td class="txt_left">
                                        <span class="radio_list2">
                                            <label><input id="workType" name="workType" type="radio" value="WORK" ${worktime.workType eq 'WORK' || empty worktime.workType  ? 'checked': '' }><span>출근</span></label>
                                            <label><input id="workType" name="workType" type="radio" value="LATE"  ${worktime.workType eq 'LATE' ? 'checked': '' }><span>지각</span></label>
                                            <label><input id="workType" name="workType" type="radio" value="NO_WORK" ${worktime.workType eq 'NO_WORK' ? 'checked': '' }><span>결근</span></label>
                                        </span>
                                   </td>
                                </tr>
                            </c:when>
		                </c:choose>
                    </tbody>
                </table>
                <div class="btnZoneBox">
                    <a class="p_blueblack_btn btn_auth" href="javascript:doSave();"><strong>저장</strong></a>
                    <a class="p_withelin_btn" href="javascript:window.close();">취소</a>
                </div>
                <!--//검색결과有//-->
            </div>
        </div>
        <!--//회사상세보기(회사정보)//-->
    </div>


</form>
