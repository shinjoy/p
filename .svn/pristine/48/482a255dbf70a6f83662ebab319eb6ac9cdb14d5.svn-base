<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%
pageContext.setAttribute("cr", "\r");
pageContext.setAttribute("cn", "\n");
pageContext.setAttribute("crcn", "\r\n");
pageContext.setAttribute("sp", "&nbsp;");
pageContext.setAttribute("br", "<br/>");
%>

<script type="text/javaScript" language="javascript">

			$(document).ready(function () {
				$(window).load(function() {
					//회의실 예약 건도 없고. 권한도 없으면 tr 숨김
					if('${meetRsvRoleEnable}' == 0 && '${meetingRoomChk}' ==0) $("#meetingRoomArea").hide();

					//유저프로필 이벤트 셋팅
					initUserProfileEvent();

				});
			});

			// 일정 수정 페이지
			function ScheduleEdit() {
			    //휴가이고 마감되었으면 수정불가
				if($("#worktimeEndYn").val() == "Y" && ($("#vacationYn").val() == "Y" || $("#attendYn").val() == "Y")){
					alert("근태와 관련된 일정으로 일정중에  근태마감처리된 일정을 포함하고 있으므로 수정할 수 없습니다.");
					return;
				}
				$('#EventType').val('Edit');
				if($('#ScheGrpCd').val() == '' || $('#ScheGrpCd').val() == 'Period'){
					$('#ScheduleView').attr('action', "<c:url value='/scheduleProc.do'/>");
				}else {
					$('#EventType').val('Edit');
					window.open("", 'chkRepeat', 'width=300, height=200, scrollbars=no');
                    $('#ScheduleView').attr('target','chkRepeat');
                    $('#ScheduleView').attr('action', "<c:url value='/ScheduleProcFlag.do'/>");
				}
				$('#ScheduleView').submit();
			}

			// 일정 삭제
			function ScheduleDelEnd() {
				//휴가이고 마감되었으면 수정불가
                if($("#worktimeEndYn").val() == "Y" && ($("#vacationYn").val() == "Y" || $("#attendYn").val() == "Y")){
                    alert("근태와 관련된 일정으로 일정중에  근태마감처리된 일정을 포함하고 있으므로 삭제할 수 없습니다.");
                    return;
                }

				if($('#ScheGrpCd').val() == '' || $('#ScheGrpCd').val() == 'Period') {
					if(confirm('일정을 삭제하시겠습니까?')) {
						$('#ScheduleView').attr('action', "<c:url value='/ScheduleDelEnd.do'/>");
						commonAjaxSubmit("POST", $("#ScheduleView"), ScheduleDelEndCallback);
					}
				} else {
					$('#EventType').val('Del');
					window.open("", 'chkRepeat', 'width=300, height=200, scrollbars=no');
					$('#ScheduleView').attr('target','chkRepeat');
					$('#ScheduleView').attr('action', "<c:url value='/ScheduleProcFlag.do'/>").submit();
				}
			}

			//일정 삭제후 콜백
            function ScheduleDelEndCallback(result){
                if(result.result == "SUCCESS"){
                    alert("정상적으로 삭제되었습니다.");
                    closeAction();
                }else if(result.result == "FAIL"){
                    alert("삭제에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
                }else{
                    alert(result.result);
                }
            }
			function closeAction(){
                try{
                	opener.parent.openPageReload();
                }catch(exception){
                	window.opener.openPageReload();
                }
                window.close();
			}

			// 일정 완료
			function ScheduleChkEnd() {
				$('#ScheduleView').attr('action', "<c:url value='/ScheduleChkEnd.do'/>");
				commonAjaxSubmit("POST", $("#ScheduleView"), ScheduleChkEndCallback);
			}

			//일정 완료 콜백
            function ScheduleChkEndCallback(result){
                if(result.result == "SUCCESS"){
                    alert("일정이 완료처리 되었습니다.");
                    $('#ScheduleView').attr('action', "<c:url value='/ScheduleView.do'/>").submit();
                }else if(result.result == "FAIL"){
                    alert("일정이 완료처리에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
                }else{
                    alert(result.result);
                }
            }

         // 특정일자 일정 리스트 모두 보기
            function SelDateScheduleList() {
                $('#ScheduleView').attr('target', '_self').attr('action', "<c:url value='/ScheduleMoreList.do'/>").submit();
                /* var url = "<c:url value='/ScheduleMoreList.do?SelYear="+SelYear+"&SelMonth="+SelMonth+"&ScheSDate="+ScheSDate+"&PerSabun="+$("#PerSabun").val()+"'/>";
                window.open(url, 'popScheduleMoreList','resizable=no,width=700,height=700,scrollbars=yes'); */
            }
</script>
