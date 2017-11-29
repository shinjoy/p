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
	<!--간트차트-->
	<table class="tb_ganttChart" style="table-layout:auto;" summary="Gantt Chart (2017) 연간 Activity 진행차트" id = "activityMonthDtTable_${activityId }">
		<caption>Gantt Chart</caption>
		<colgroup>
			<col width="49">
			<col width="*" span="48">
		</colgroup>
		<thead>
			<tr>
				<th scope="col" rowspan="2">&nbsp;</th>
				<th scope="col" colspan="${lastDay }" style="cursor: pointer;" onclick="wbsActivityViewMonthHide('${activityId}')">${month+1 }월</th>
			</tr>
			<tr>
				<c:forEach begin="1" end="${lastDay }" var="data">
					<td>
						${data }
					</td>
				</c:forEach>
			</tr>
		</thead>
		<tbody>
			<tr class="totalrow" id = "activityMonthDtTotArea_${activityId }">
				<th scope="row"><p class="name" id = "activityMonthDtTotAreaNm">전체</p><p class="taskCount" id = "activityMonthDtTotAreaTot">(0)</p></th>
				<c:set var = "endYn" value="Y" />

				<c:forEach begin="1" end="${lastDay }" var="data">
					<td class="<c:if test = "${data eq 1 }">start</c:if><c:if test="${nowMonth eq month and nowDay eq data }"> current</c:if><c:if test = "${data eq lastDay}"> finish</c:if>">
					<c:if test="${nowMonth eq month and nowDay eq data }">
						<div class="timeline"></div>
					</c:if>
					<div class="ganttBar noneRg" id="activityMonthDtTotArea_${activityId }_${data }">
							<c:if test = "${endYn eq 'N' }">
								<c:set var="sartDtAfterCnt" value="${sartDtAfterCnt+1 }" />
							</c:if>

							<c:if test="${startDtBuf[0] eq thisYear and startDtBuf[1] eq month+1 and startDtBuf[2] eq data }">
								<div class="startDate" id = "startDate_${month }_${data}">
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

							<c:if test="${endDtBuf[0] eq thisYear and endDtBuf[1] eq month+1 and endDtBuf[2] eq data  }">
								<div class="endDate" id = "endDate_${month }_${data}">

									<span class="txt_date">${endDtBuf[1]}/${endDtBuf[2]}<em class="point"></em></span>
									<c:if test="${endYn ne 'N' or sartDtAfterCnt>4}">
									<!-- <span class="txt_des">완료</span> -->
									</c:if>

								</div>
							</c:if>

							<ul class="acti_RgList n1">
								<c:set var="startDtStr">${startDt }</c:set>
								<c:set var="endDtStr">${endDt }</c:set>
								<c:set var="thisDtStr">${thisYear }-${month<9?0:'' }${month+1 }-${data<10?0:'' }${data }</c:set>
								<c:set var="nowDtStr">${nowYear }-${nowMonth<9?0:'' }${nowMonth+1 }-${nowDay<10?0:'' }${nowDay }</c:set>
								<c:choose>
									<c:when test="${thisDtStr>=startDtStr and thisDtStr<=nowDtStr and thisDtStr<=endDtStr }"><li class="no_acti_rg"></li></c:when>

									<c:when test="${thisDtStr<=endDtStr and thisDtStr>=nowDtStr }"><li class="delay_rg"></li></c:when>
								</c:choose>
							</ul>
						</div>
					</td>

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
					var copyHtml = $("#activityMonthDtTotArea_${activityId }").html();
					var stStr = "<tr id = 'activityMonthDtUserArea_${activityId }_"+empObj.userId+"'>";

					var nameStr = empObj.userNm;

					if(empObj.leaderYn=="Y"){
						nameStr += "<br>[리더]"
					}

					copyHtml=copyHtml.split("전체").join(nameStr);
					copyHtml=copyHtml.split("##userId##").join(empObj.userId);
					copyHtml=copyHtml.split("##userNm##").join(empObj.userNm);
					copyHtml=copyHtml.split("##rankNm##").join(empObj.position);


					copyHtml=copyHtml.split("activityMonthDtTotAreaNm").join("activityMonthDtTotAreaNm_${activityId }_"+empObj.userId);
					copyHtml=copyHtml.split("activityMonthDtTotArea_${activityId }").join("activityMonthDtTotArea_${activityId }_"+empObj.userId);
					copyHtml=copyHtml.split("activityMonthDtTotAreaTot").join("activityMonthDtTotAreaTot_${activityId }_"+empObj.userId);

					stStr = stStr + copyHtml + "</tr>";

					$("#activityMonthDtTable_${activityId } tbody").append(stStr);

				}

				$("#activityMonthDtTable_${activityId} tbody").find(".endDate").each(function(i){
					if(i>0) $(this).remove();
				});
				$("#activityMonthDtTable_${activityId} tbody").find(".startDate").each(function(i){
					if(i>0) $(this).remove();
				});
			}
		}
		searchActivityMonthWbsWorkDetail("${activityId }","${thisYear}",activityObj.startDate,activityObj.endDate,"${thisYear }-${month<9?0:'' }${month+1 }-01","${thisYear }-${month<9?0:'' }${month+1 }-${lastDay}");
	});

</script>
