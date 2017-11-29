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

// 일정 수정/삭제 완료
function ScheduleProcFlagEnd() {
	if($('#EventType').val() == 'Edit') {
		$('#ScheduleProcFlag').attr('target',opener.name);
		$('#ScheduleProcFlag').attr('action', "<c:url value='/scheduleProc.do'/>").submit();
		window.close();
	}
	else {
		if(confirm('일정을 삭제하시겠습니까?')) {
			$('#ScheduleProcFlag').attr('action', "<c:url value='/ScheduleDelEnd.do'/>");
                     commonAjaxSubmit("POST", $("#ScheduleProcFlag"), ScheduleProcFlagEndCallback);
		}
		else alert('삭제 취소 되었습니다.');
	}
}

//일정 삭제후 콜백
 function ScheduleProcFlagEndCallback(result){
     if(result.result == "SUCCESS"){
         alert("정상적으로 삭제되었습니다.");
         opener.parent.closeAction();
         window.close();
     }else if(result.result == "FAIL"){
         alert("삭제에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
     }else{
         alert(result.result);
     }
 }

// 일정 상세보기
function ScheView() {
	window.close();
}
</script>

<form name="ScheduleProcFlag" id="ScheduleProcFlag" action="<c:url value='/ScheduleProcFlag.do'/>" method="post">
<input type="hidden" name="InfoMessage"	id="InfoMessage">
<input type="hidden" name="message"		id="message"		value="${message}">
<input type="hidden" name="cmd"			id="cmd"			value="${vo.cmd}"/>
<input type="hidden" name="EventType"	id="EventType"		value="${vo.eventType}"/>
<input type="hidden" name="ParentPage"	id="ParentPage"		value="${vo.parentPage}"/>
<input type="hidden" name="ScheSeq"		id="ScheSeq"		value="${vo.scheSeq}"/>
<input type="hidden" name="ScheGrpCd"	id="ScheGrpCd"		value="${vo.scheGrpCd}"/>
<input type="hidden" name="ScheSDate"	id="ScheSDate"		value="${vo.scheSDate}"/>
<input type="hidden" name="PerSabun"	id="PerSabun"		value="${baseUserLoginInfo.empNo}"/>

<c:choose>
    <c:when test="${vo.eventType eq 'Edit'}"><c:set var="tag" value="수정"/></c:when>
    <c:otherwise><c:set var="tag" value="삭제"/></c:otherwise>
</c:choose>

    <div id="compnay_dinfo">
        <!--업무일지등록-->
        <div class="modalWrap2">
            <h1><strong>반복 일정 ${tag}</strong></h1>
            <div class="mo_container">
                <table class="tb_list_basic" summary="일정등록 (제목, 일시, 장소, 내용, 참가자, 알림, 진행사항) 등록">
                    <caption>반복 일정</caption>
                    <colgroup>
                        <col width="*" />
                    </colgroup>
                    <tr>
                        <td style="text-align:left;">
                                <label><input type="radio" name="procFlag" id="procFlag1" value="alone" checked /> 이 일정만 ${tag}</label><br/>
                                <label><input type="radio" name="procFlag" id="procFlag2" value="after"/> 이 일정부터 이후 모든 일정 ${tag}</label><br/>
                                <label><input type="radio" name="procFlag" id="procFlag3" value="all" /> 전체 반복 일정 ${tag}</label
                        </td>
                    </tr>
                </table>
                <div class="btnZoneBox">
                    <span><a href="javascript:ScheduleProcFlagEnd();" class="p_blueblack_btn"><strong>확인</strong></a></span>
                    <a href="javascript:ScheView();" class="p_withelin_btn" >취소</a>
                </div>
            </div>
        </div>
    </div>
	</form>