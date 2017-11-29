<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="endDtBuf" value="${fn:split(endDt,'-') }"></c:set>
<c:set var="startDtBuf" value="${fn:split(startDt,'-') }"></c:set>
<!-- 완료일표시여부 -->
<c:set var = "endYn" value="Y" />

<!-- 시작일로부터 카운트 -->
<c:set var  = "sartDtAfterCnt" value="0"/>
<td colspan="8" class="pd0">
	<h3 class="h3_table_title3"><c:if test = "${startDtBuf[0] ne thisYear}"><button type="button" class="btn_prev_yr mgr20" style="display: none;"><em>이전해</em></button></c:if><span>Gantt Chart (${thisYear })</span><c:if test = "${endDtBuf[0] ne thisYear}"><button type="button" class="btn_next_yr mgl20" style="display: none;"><em>다음해</em></button></c:if></h3>
	<!--간트차트-->
	<table class="tb_ganttChart" summary="Gantt Chart (2017) 연간 Activity 진행차트" id = "activityDtTable_${activityId }">
		<caption>Gantt Chart</caption>
		<colgroup>
			<col width="49">
			<col width="*" span="48">
		</colgroup>
		<thead>
			<tr>
				<th scope="col" rowspan="2">&nbsp;</th>
				<c:forEach var = "data" items="${weekNumList }" varStatus="i">
					<th scope="col" colspan="${data }" style="cursor: pointer;" onclick="wbsActivityViewMonth2('${activityId}','${thisYear }','${i.index }','${weekNum }','${startDt }','${endDt }')">${i.index+1 }월</th>
				</c:forEach>
			</tr>
			<tr>
				<c:set var="yearOfWeekNum" value="0"></c:set>
				<c:forEach var = "data" items="${weekNumList }" varStatus="i">
					<c:forEach begin="1" end="${data }" var="weekNum">
						<td <c:if test = "${i.index ne 0 }"> class="divline"</c:if>>
							${weekNum }
							<c:set var="yearOfWeekNum" value="${yearOfWeekNum+1 }"></c:set>
						</td>
					</c:forEach>
				</c:forEach>
			</tr>
		</thead>
		<tbody>
			<tr class="totalrow" id = "activityDtTotArea_${activityId }">
				<th scope="row"><p class="name" id = "activityDtTotAreaNm">전체</p><p class="taskCount" id = "activityDtTotAreaTot">(0)</p></th>
				<c:set var = "yearWeekNum" value="0" />
				<c:set var = "endYn" value="Y" />
				<c:forEach var = "data" items="${weekNumList }" varStatus="i">
					<c:forEach begin="1" end="${data }" var="weekNum" varStatus="j">
						<td class="<c:if test = "${i.index eq 0 and weekNum eq 1 }">start</c:if><c:if test="${nowMonth eq i.index and nowWeekNum eq weekNum }"> current</c:if><c:if test = "${i.index ne 0 and j.index eq 1 }"> divline</c:if><c:if test = "${i.index+1 eq fn:length(weekNumList) and j.index eq data }"> finish</c:if>">
							<c:if test="${nowYear eq thisYear and nowMonth eq i.index and nowWeekNum eq weekNum }">
								<div class="timeline"></div>
							</c:if>

							<div class="ganttBar noneRg" id="activityDtTotArea_${i.index+1 }_${weekNum}">
								<c:if test = "${endYn eq 'N' }">
									<c:set var="sartDtAfterCnt" value="${sartDtAfterCnt+1 }" />
								</c:if>


								<c:if test="${startDtBuf[0] eq thisYear and startDtBuf[1] eq i.index+1 and startWeekNum eq weekNum }">
									<div class="startDate" id = "startDate_${i.index+1 }_${weekNum}" <c:if test="${i.index+1>1 }"></c:if>>
										<span class="txt_date">${startDtBuf[1]}/${startDtBuf[2]}<em class="point"></em></span>
										<span class="txt_des">
										<%--  시작
											<c:if test="${startDt eq  endDt}">
												(완료)
											</c:if>
											<c:set var = "endYn" value="N" /> --%>
										</span>

									</div>
								</c:if>

								<c:if test="${endDtBuf[0] eq thisYear and endDtBuf[1] eq i.index+1 and endWeekNum eq weekNum  }">
									<div class="endDate" id = "endDate_${i.index+1 }_${weekNum}">

										<span class="txt_date">${endDtBuf[1]}/${endDtBuf[2]}<em class="point"></em></span>
										<c:if test="${endYn ne 'N' or sartDtAfterCnt>4}">
										<!-- <span class="txt_des">완료</span> -->
										</c:if>

									</div>
								</c:if>

								<ul class="acti_RgList n1" style="cursor: pointer;" onclick="wbsActivityViewMonth('${activityId}','${thisYear }','${i.index }','${weekNum }','##userId##','##userNm##','##rankNm##')">
									<c:set var="startDtStr">${startDtBuf[0] }-${startDtBuf[1] }-${startWeekNum }</c:set>
									<c:set var="endDtStr">${endDtBuf[0] }-${endDtBuf[1] }-${endWeekNum }</c:set>
									<c:set var="thisDtStr">${thisYear }-${i.index<9?0:'' }${i.index+1 }-${weekNum }</c:set>
									<c:set var="nowDtStr">${nowYear }-${nowMonth<9?0:'' }${nowMonth+1 }-${nowWeekNum }</c:set>
									<c:choose>
										<c:when test="${thisDtStr>=startDtStr and thisDtStr<=nowDtStr and thisDtStr<=endDtStr }"><li class="no_acti_rg"></li></c:when>

										<c:when test="${thisDtStr<=endDtStr and thisDtStr>=nowDtStr }"><li class="delay_rg"></li></c:when>
									</c:choose>
								</ul>
							</div>
						</td>
						<c:set var = "yearWeekNum" value="${yearWeekNum+1 }" />
					</c:forEach>
				</c:forEach>
			</tr>

		</tbody>
	</table>
	<!--//간트차트//-->
</td>

<script type="text/javascript">
	$(document).ready(function(){
		var activityObj;
		for(var i = 0 ; i<actList.length; i++){
			if(parseInt(actList[i].activityId) == parseInt("${activityId }")){
				activityObj = actList[i];
				var empList = activityObj.empList;
				for(var j = 0 ; j <empList.length;j++){
					var empObj = empList[j];
					var copyHtml = $("#activityDtTotArea_${activityId }").html();
					var stStr = "<tr id = 'activityDtUserArea_${activityId }_"+empObj.userId+"'>";
					var nameStr = empObj.userNm;

					if(empObj.leaderYn=="Y"){
						nameStr += "<br>[리더]"
					}

					copyHtml=copyHtml.split("전체").join(nameStr);
					copyHtml=copyHtml.split("##userId##").join(empObj.userId);
					copyHtml=copyHtml.split("##userNm##").join(empObj.userNm);
					copyHtml=copyHtml.split("##rankNm##").join(empObj.position);


					copyHtml=copyHtml.split("activityDtTotAreaNm").join("activityDtUserAreaNm_${activityId }_"+empObj.userId);
					copyHtml=copyHtml.split("activityDtTotArea").join("activityDtUserArea_${activityId }_"+empObj.userId);
					copyHtml=copyHtml.split("activityDtTotAreaTot").join("activityUserTotAreaTot_${activityId }_"+empObj.userId);

					stStr = stStr + copyHtml + "</tr>";

					$("#activityDtTable_${activityId } tbody").append(stStr);

				}

				$("#activityDtTable_${activityId} tbody").find(".endDate").each(function(i){
					if(i>0) $(this).remove();
				});
				$("#activityDtTable_${activityId} tbody").find(".startDate").each(function(i){
					if(i>0) $(this).remove();
				});
			}
		}
		searchActivityWbsWorkDetail("${activityId }","${thisYear}",activityObj.startDate,activityObj.endDate,"${startWeekNum}","${endWeekNum}");
	});

</script>
