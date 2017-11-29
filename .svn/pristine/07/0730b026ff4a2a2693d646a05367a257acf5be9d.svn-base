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
    if($("#workReqReason").val() == ""){
        alert("사유를 입력하여 주시기 바랍니다.");
        $("#workReqReason").focus();
        return;
    }
    $('#frm').attr('action', "<c:url value='/worktime/user/doSaveAttendanceApprovReq.do'/>");
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

    <div id="compnay_dinfo">
        <!--회사상세보기(회사정보)-->
        <div class="modalWrap2">
            <h1><strong>[근태요청화면]</strong> ${worktime.deptNm} ${worktime.name} ${worktime.position}</h1>
            <div class="mo_container">


                <!--회사리스트-->
                <table class="tb_regi_basic" summary="보고서 리스트 (등록일, 제목, 상태, 작성자, 조회)">
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
                            <th scope="col">인정여부</th>
                            <td class="txt_left">
                                <span class="radio_list2">
                                    <c:choose>
                                        <c:when test="${worktime.workType eq 'LATE' }">
                                            <label><input id="workReqType" name="workReqType" type="radio" value="WORK" checked=""><span>출근인정요청</span></label>
                                            <label><input id="workReqType" name="workReqType" type="radio" value="LATE" ><span>지각인정</span></label>
                                        </c:when>
                                        <c:when test="${worktime.workType eq 'NO_WORK' }">
                                            <label><input id="workReqType" name="workReqType" type="radio" value="WORK" checked=""><span>출근인정요청</span></label>
                                            <label><input id="workReqType" name="workReqType" type="radio" value="LATE" ><span>지각인정요청</span></label>
                                            <label><input id="workReqType" name="workReqType" type="radio" value="NO_WORK" ><span>결근인정</span></label>
                                        </c:when>
                                        <c:when test="${empty worktime.workType}">
                                            <label><input id="workReqType" name="workReqType" type="radio" value="WORK" checked=""><span>출근인정요청</span></label>
                                            <label><input id="workReqType" name="workReqType" type="radio" value="LATE" ><span>지각인정요청</span></label>
                                            <label><input id="workReqType" name="workReqType" type="radio" value="NO_WORK" ><span>결근인정</span></label>
                                        </c:when>
                                    </c:choose>
                                </span>
                             </td>
                        </tr>
                        <tr>
                            <th scope="row" class="vt">사유입력</th>
                            <td class="txt_left">
                                <ul class="reasonList">
                                    <c:if test="${not empty worktime.mngWorkPrcReason}">
                                        <li><span class="reason_st">[관리자]</span><span class="date_st">${worktime.mngWorkPrcTypeNm}</span><span class="date_st">${worktime.mngWorkPrcDate}</span>${worktime.mngWorkPrcReason}</li>
                                    </c:if>
                                </ul>
                                <textarea id="workReqReason" name="workReqReason"  class="textarea_basic w100pro" placeholder="사유를 입력하세요.">${worktime.workReqReason}</textarea>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <!--//회사리스트//-->
                <div class="btnZoneBox">
                    <a class="p_blueblack_btn" href="javascript:doSave();"><strong>저장</strong></a>
                    <a class="p_withelin_btn" href="javascript:window.close();">취소</a>
                </div>
                <!--//검색결과有//-->
            </div>
        </div>
        <!--//회사상세보기(회사정보)//-->
    </div>

</form>
