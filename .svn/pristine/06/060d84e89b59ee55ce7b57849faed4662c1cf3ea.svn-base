<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
	//체크박스 하나만 선택
	function chkOnly($obj){
		if($obj.prop("checked")){
			$("input[type='checkbox']").each(function(){
				if($(this).val()!=$obj.val()) $(this).prop("checked",false);
			})
		}
	}
	//적용버튼
	function selectSche(){
		if($("input[type='checkbox']:checked").length<1){
			alert("일정을 선택해 주세요.");
			return;
		}
		var value = $("input[type='checkbox']:checked").val();

		var valueBuf = value.split("|");

		parent.openSchePopCallback(valueBuf[0],valueBuf[1],valueBuf[2],valueBuf[3],valueBuf[4],valueBuf[5],valueBuf[6]);
		parent.myModal.close();
	}
</script>
<form id = "schePopFrm" name = "schePopFrm">
	<!--최근등록 일정-->
	<div class="car2Popup_st_box">
		<!-- 조회 주차(년도별) , 년도 :S -->
		<input type="hidden" id = "weekNum" name = "weekNum" value="${weekNum }">
		<input type="hidden" id = "year" name = "year" value="${year }">
		<input type="hidden" id = "weekType" name = "weekType">
		<input type="hidden" id = "startStr" value="${startStr }">
		<!-- 조회 주차(년도별) , 년도 :E-->
		<table class="car2Popup_tb_st" summary="최근등록일정">
			<caption> 최근등록일정</caption>
			<colgroup>
				<col width="8%">
				<col width="30%">
				<col width="*">
				<col width="12%">
			</colgroup>
			<thead>
				<tr>
					<th colspan="4">
						<div class="table_car_btnZon">
							<button type="button" class="btn_prev" onclick="moveWeekNum('prev')"><em>이전</em></button>
							<span>${fn:replace(startStr,'-','/') }<em>(월)</em> ~ ${fn:replace(endStr,'-','/') }<em>(일)</em>
							<button type="button" class="btn_next" onclick="moveWeekNum('next')"><em>다음</em></button>
							<button type="button" class="btn_this_week" onclick="moveWeekNum('now')">이번주</button>
						</span></div>
					</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${approveScheduleList }" var = "data">
					<tr>
						<td class="right_txt"><label for=""><input type="checkbox"
							value="${data.scheSeq }|[${data.activityNm }]${data.scheTitle }|${data.projectId}|${data.projectNm}(${data.projectCode })|${data.activityId }|${data.activityNm }|${data.projectNm }"
							onclick="chkOnly($(this))"><span class="blind">선택</span></label></td>
						<td class="left_txt_day txt_left">
							 <c:choose>
	                                <c:when test="${data.scheAllTime eq 'Y' && data.scheGrpCd ne 'Period'}">
	                                     <strong>${fn:replace(data.scheSDate,'-','/')}</strong>(종일)
	                                 </c:when>
	                                 <c:when test="${data.scheAllTime eq 'Y' && data.scheGrpCd eq 'Period'}">
	                                     <strong>${fn:replace(data.scheSDate,'-','/')}</strong> ~ <strong>${fn:replace(data.scheEDate,'-','/')}</strong>(종일)
	                                 </c:when>
	                                 <c:when test="${data.scheGrpCd eq 'Period'}">
	                                     <strong>${fn:replace(data.scheSDate,'-','/')}</strong>
	                                     <span class="sptime mgl10">${data.scheSTime}</span>
	                                     ~
	                                     <strong>${fn:replace(data.scheEDate,'-','/')}</strong>
	                                     <span class="sptime mgl10">${data.scheETime}</span>
	                                 </c:when>
	                                 <c:otherwise>
	                                     <strong>${fn:replace(data.scheSDate,'-','/')}</strong>
	                                     <span class="sptime mgl10">${data.scheSTime}~${data.scheETime}</span>
	                                 </c:otherwise>
	                             </c:choose>
						</td>
						<td class="left_txt_bold">[${data.activityNm }]<em>${data.scheTitle }</em></td>
						<td>
							<c:if test="${data.todayYn eq 'Y' }"><a href="#" class="icon_car_today"><em>TODAY</em></a></c:if>
						</td>
					</tr>
				</c:forEach>
				 <c:if test="${fn:length(approveScheduleList)<=0 }">
	                <tr>
	                    <td colspan="4" class="no_result">
	                        <p class="nr_des">조회된 데이터가 없습니다.</p>
	                    </td>
	                </tr>
	            </c:if>
			</tbody>
		</table>
		<p class="sys_p_noti mgt10"><span>* 원하는 일정이 없을시</span><a href = "javascript:scheAdd()"><span class="pointB"> [일정등록] </span></a><span>하기 에서 신규로 등록해주세요.</span></p>
	</div>
	<!--//최근등록일정//-->

	<div class="btnZoneBox sche_st"><a href="javascript:selectSche()" class="p_blueblack_btn">적용</a><a href="javascript:parent.myModal.close()" class="p_withelin_btn">취소</a></div>
	<!--//검색결과有//-->
</form>
