<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javaScript" language="javascript">

  	//창 닫기 클릭시 쿠키 처리
    function closeWin() {

        if(document.getElementById("check_today").checked){
            /* setCookie("cookie_"+"${alarm.alarmId}", "done", 1); // 쿠기 만료일 하루 뒤 */
            setCookie("cookie_alarmProjectEnd", "done", 1); // 쿠기 만료일 하루 뒤
            window.close();
        }else{
            window.close();
        }
    }

</script>
<div id="compnay_dinfo">
		<!--업무일지등록-->
		<div class="modalWrap2">
			<h1><strong>[기간종료예정 ${baseUserLoginInfo.projectTitle}]</strong></h1>
			<div class="mo_container">
				<div class="sys_p_noti mgb10"><span class="icon_noti"></span><span class="pointB">${baseUserLoginInfo.projectTitle}이/가 곧 종료됩니다.</span><span> 마감되지 않은 업무는 기간 내에 처리해주세요.</span></div>

				<table class="tb_regi_basic2" summary="프로젝트 종료예정목록  (등록일,Project,Activity,업무명,프로젝트 종료일)">
					<caption>프로젝트 종료예정목록 </caption>
					<colgroup>
                        <col width="100">
                        <col width="*">
                        <col width="*">
                        <col width="*">
                        <col width="100">
                    </colgroup>
					<thead>
					    <tr>
                            <th scope="col">등록일</th>
                            <th scope="col">${baseUserLoginInfo.projectTitle}</th>
                            <th scope="col">${baseUserLoginInfo.activityTitle}</th>
                            <th scope="col">업무명</th>
                            <th scope="col">${baseUserLoginInfo.projectTitle} 종료일</th>
                        </tr>
					</thead>
					<tbody>
						<c:forEach items="${projectEndList }" var = "data">
						    <tr>
	                            <td class="bg_skyblue">${data.workDate}</td>
	                            <td>${data.projectNm }</td>
	                            <td>${data.activityNm }</td>
	                            <td>${data.title }</td>
	                            <td class="txt_center d_day_st">${data.lastDate}</td>
	                        </tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<br/>
		<br/>
		 <!--창닫기-->
	    <div class="todayclosebox">
	        <div class="fl_block"><label><input type="checkbox"  name="check_today" id="check_today"  onclick="closeWin();"/><span>오늘은 그만보기</span></label></div>
	        <div class="fr_block"><button type="button" class="btn_close" onClick="closeWin();"><span>닫기</span><span>X</span></button></div>
	    </div>
	    <!--//창닫기//-->
		<!--//업무일지등록//-->
	</div>

