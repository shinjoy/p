<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" defer="defer">

var myAgreeModal = new AXModal();		// instance


$(document).ready(function(){

	 //개인정보 동의안함(일단 막음)
	// if("${ruleAgreeYn}" == "N") userRulePop();
	// else{

		alarm();
		alarmSchedule();  //일정알람
		alarmAttendance();  //근태알람

		alarmScheduleSpotWork();  //메인 현지출근 알람 팝업

		alarmWorktimeRest();  //휴직 종료 사전안내
		cardCorpUsedMainPop(); //승인후 1주일이 경과하여도 등록되지 않은 법인카드
		approveAlarmMainPop(); //전자결재 미결알람팝업
	// }





});
//알림 팝업 호출
function alarm(){
	// popUp 규격
	var w = '550';
	var h = '320';
	var init_top = 30;
	var init_left = 30;
	var ah = screen.availHeight - 30;

	h = (ah-40>h?h:ah-40);
	var xc = ((screen.availWidth - 10) - w) / 2;
	var yc = (ah - h) / 2;

	//알림 팝업 해당 사용자인 경우
	if('${popupShow}' == 'Y'){
		<c:forEach items="${popupInfoList}" var="item" varStatus="status">
			var alarmId = '${item}';
			var title = "pop_"+alarmId;
			var cookie = "cookie_"+alarmId;
			if (getCookie(cookie) == ""){
				init_top += 25;
				init_left += 25;
				//모니터 중간 지점을 넘어가지 않도록.
				var left= (init_left < xc) ? init_left : xc;
				var top = (init_top < yc) ? init_top : yc;
				var win1 = window.open(contextRoot + "/alarm/alarmInfo.do?id="+alarmId, title, "resizable=yes,width=550, height=320,left="+left+",top="+top );
				//win1.focus();
			}
		</c:forEach>
	}
}

//일정알람 팝업
function alarmSchedule() {
	// 일정알람 정보가 있는경우 팝업호출함
	if('${schedulePopupShow}' == 'Y'){
		var cookie = "cookie_alarmSchedule";
	    if (getCookie(cookie) == ""){
	        var url = "<c:url value='/mainScheduleAlarm.do'/>";
	        window.open(url, 'alarmSchedule', 'resizable=yes,width=550, height=320, scrollbars=yes');
	    }
	}
}

//근태알람 팝업
function alarmAttendance() {
    // 일정알람 정보가 있는경우 팝업호출함
    if('${attendancePopupShow}' == 'Y'){
        var cookie = "cookie_alarmAttendance";
        if (getCookie(cookie) == ""){
            var url = "<c:url value='/worktime/user/mainAttendanceAlarm.do'/>";
            window.open(url, 'alarmAttendance', 'resizable=yes,width=550, height=320, scrollbars=yes');
        }
    }
}

//메인 현지출근 알람 팝업
function alarmScheduleSpotWork() {
    // 일정알람 정보가 있는경우 팝업호출함
    if('${spotWorkShow}' == 'Y'){
        var cookie = "cookie_alarmSpotWork";
        if (getCookie(cookie) == ""){
            var url = "<c:url value='/schedule/mainSpotWorkAlarm.do'/>";
            window.open(url, 'alarmSpotWork', 'resizable=yes,width=550, height=320, scrollbars=yes');
        }
    }
}

//휴직 종료 사전 안내
function alarmWorktimeRest() {
    // 일정알람 정보가 있는경우 팝업호출함
    if('${worktimeRestShow}' == 'Y'){
        var cookie = "cookie_alarmWorktimeRest";
        if (getCookie(cookie) == ""){
            var url = "<c:url value='/worktime/manager/mainWorktimeRestAlarm.do'/>";
            window.open(url, 'alarmWorktimeRest', 'resizable=yes,width=550, height=320, scrollbars=yes');
        }
    }
}

//승인후 1주일이 경과하여도 등록되지 않은 법인카드
function cardCorpUsedMainPop() {
    // 일정알람 정보가 있는경우 팝업호출함
    if('${cardCorpUsedPopShow}' == 'Y' && "${baseUserLoginInfo.orgId}" == "${baseUserLoginInfo.applyOrgId}"){
        var cookie = "cookie_cardCorpUsedMainPop";
        if (getCookie(cookie) == ""){
            var url = "<c:url value='/card/cardCorpUsedMainPop.do'/>";
            window.open(url, 'cardCorpUsedMainPop', 'resizable=yes,width=800, height=320, scrollbars=yes');
        }
    }
}

//미결알람팝업
function approveAlarmMainPop() {
    // 일정알람 정보가 있는경우 팝업호출함
    if('${approveAlarmYn}' == 'Y' && "${baseUserLoginInfo.orgId}" == "${baseUserLoginInfo.applyOrgId}"){
        var cookie = "cookie_approveAlarmMainPop";
        if (getCookie(cookie) == ""){
            var url = "<c:url value='/approve/approveAlarmMainPop.do'/>";
            window.open(url, 'approveAlarmMainPop', 'resizable=yes,width=800, height=320, scrollbars=yes');
        }
    }
}

//개인정보 취급 방침/이용약관 팝업
function userRulePop() {



	myAgreeModal.setConfig({
		windowID:"myModalCT",

		width:740,
        mediaQuery: {
            mx:{min:0, max:767}, dx:{min:767}
        },
		displayLoading:true,
        scrollLock: false,
		onclose: function(){

		}
        ,contentDivClass: "popup_outline"

	});

    var url =contextRoot+"/mypersonnel/userRuleAgreePop.do";

    myAgreeModal.open({
   		url: url,
   		pars: {},
   		titleBarText: '이용약관 및 개인정보 수집 이용 동의 안내',			//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
   		method:"POST",
   		top: $(document).scrollTop()+150,
   		width: 800,
   		closeByEscKey: false,				//esc 키로 닫기
   		closeButton : false					//닫기버튼 없애기
 	});

 	$('#myModalCT').draggable();


}

</script>

<footer id="IB_footer">
	<div class="footermnZone">
		<ul class="ft_menuList">
			<li><a href="${pageContext.request.contextPath}/mypersonnel/userRuleInfo.do">PASS 이용약관</a></li>
			<li><a href="${pageContext.request.contextPath}/mypersonnel/userProcessInfo.do"><strong>개인정보처리방침</strong></a></li>
		</ul>
	</div>
	<div class="copyright">Copyright @ 2017 synergy partners. all right reserved</div>
</footer>
