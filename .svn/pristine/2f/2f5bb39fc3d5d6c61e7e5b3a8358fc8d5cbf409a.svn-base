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
    function openDetail(searchYear,searchMonth){
        parent.opener.location = contextRoot+"/worktime/user/attendanceInfo.do?searchYear" + searchYear + "&searchMonth="+ searchMonth;
        window.close();
    }
	//상세보기 버튼
	function openDetail2(){
		parent.opener.location = contextRoot+"/worktime/user/attendanceInfo.do";
        window.close();
	}
  //창 닫기 클릭시 쿠키 처리
    function closeWin() {

        if(document.getElementById("check_today").checked){
            /* setCookie("cookie_"+"${alarm.alarmId}", "done", 1); // 쿠기 만료일 하루 뒤 */
            setCookie("cookie_alarmAttendance", "done", 1); // 쿠기 만료일 하루 뒤
            window.close();
        }else{
            window.close();
        }
    }

</script>
<div class="popModal_wrap">
		<h3 class="pop_title">근태확인</h3>
		<a href="javascript:closeWin();" class="popup_close"><em>닫힘</em></a>
		<div class="conBox">
			<h3 class="h3_title_basic">${baseUserLoginInfo.deptNm} ${baseUserLoginInfo.userName} ${baseUserLoginInfo.rankNm}</h3>
			<table class="tb_list_basic" summary="알림내용 (알림날짜, 분류, 사원선택, 알림타입, 내용)">
				<caption>알림내용</caption>
				<colgroup>
					<col width="*" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
					<col width="*" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">날짜</th>
						<th scope="col">출근</th>
						<!-- <th scope="col">퇴근</th> -->
						<th scope="col">근태여부</th>
						<th scope="col">근태 마감기간</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="data" items="${worktimeList}" varStatus="status">
                        <tr onClick="openDetail('${data.workYear}', '${data.workMonth}');">
                            <td><span class="df_normal"><strong>${data.workDateMmdd }</strong><em>(${fn:substring(data.workDateWeek,0,1) })</em></span></td>
                            <td class="txt_time  <c:if test = "${data.inTime ne null}">p_color_wrong</c:if>">${data.inTime eq null?'-':data.inTime}</td>
                           <%--  <td class="txt_time">${data.outTime eq null?'-':data.outTime}</td> --%>
                            <td><span class="${data.workType eq 'NO_LOGIN'?'st_login':'st_at_late'}">${data.workTypeNm }</span></td>
                            <td><span class="${data.workType eq 'NO_LOGIN'?'limit_date':'limit_date hurryup'}">${data.workDateEnd }</span></td>
                        </tr>
                    </c:forEach>
				</tbody>
			</table>

			<!--버튼모음-->
			<div class="btnZoneBox" style="padding-bottom: 20px;">
				<a href="javascript:openDetail2();" class="p_blueblack_btn"><strong>상세보기</strong></a>
			</div>
			<!--//버튼모음//-->
			<!--창닫기-->
		    <div class="todayclosebox">
		        <div class="fl_block"><label><input type="checkbox"  name="check_today" id="check_today"  onclick="closeWin();"/><span>오늘은 그만보기</span></label></div>
		        <div class="fr_block"><button type="button" class="btn_close" onClick="closeWin();"><span>닫기</span><span>X</span></button></div>
		    </div>
		    <!--//창닫기//-->
		</div>
	</div>
</body>
