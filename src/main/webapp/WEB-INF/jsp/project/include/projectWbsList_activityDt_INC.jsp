<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<td colspan="8" class="pd0">
	<h3 class="h3_table_title2" style="border-top: #b9c1ce solid 1px">${baseUserLoginInfo.activityTitle}</h3>

	<table class="tb_wbsChart" summary="전체통계(1월~12월, 영업관리비, 복리후생비, 대중교통비, 차량유지비, 택배비, 소모품비)">
	<tbody>
		<c:forEach items="${projectWbsActivityList }" var="data" varStatus="cnt">
			<c:set var="endDtBuf" value="${fn:split(data.endDt,'-') }"></c:set>
			<c:set var="startDtBuf" value="${fn:split(data.startDt,'-') }"></c:set>
			<tr>
				<td class="pd0">
					<!--간트차트-->
					<table class="tb_ganttChart" summary="Gantt Chart (2017) 연간 project 진행차트" id = "activityDtTable_${data.activityId }">
						<caption>Gantt Chart</caption>
						<colgroup>
							<col width="80">
							<col width="*" span="*">
						</colgroup>
						<c:if test="${cnt.index eq 0 }">
							<thead>
								<tr>
									<th scope="col" rowspan="2">&nbsp;</th>
									<c:forEach var = "weekData" items="${data.weekNumList }" varStatus="i">
										<th scope="col" colspan="${weekData }">${i.index+1 }월</th>
									</c:forEach>
								</tr>
								<tr>
									<c:set var="yearOfWeekNum" value="0"></c:set>
									<c:forEach var = "weekData" items="${data.weekNumList }" varStatus="i">
										<c:forEach begin="1" end="${weekData }" var="weekNum">
											<td <c:if test = "${i.index ne 0 }"> class="divline"</c:if>>
												${weekNum }
												<c:set var="yearOfWeekNum" value="${yearOfWeekNum+1 }"></c:set>
											</td>
										</c:forEach>
									</c:forEach>
								</tr>
							</thead>
						</c:if>
						<tbody>
							<tr class="totalrow" id = "activityDtTotArea_${data.activityId }">
									<th scope="row" style="cursor: pointer;" onclick="viewActivityUserDt(${data.activityId })">
									<p class="name joinmb_list">
										${data.name}<span id = "activityDtTotAreaTot"></span>
										<span id = "toggleActivityDtImageArea_${data.activityId }">
											<img src="${pageContext.request.contextPath}/images/support_w/th_icon_closed.gif">
										</span>
									</p>
								</th>
								<c:set var = "yearWeekNum" value="0" />
								<c:set var = "endYn" value="Y" />
								<c:forEach var = "weekData" items="${data.weekNumList }" varStatus="i">
									<c:forEach begin="1" end="${weekData }" var="weekNum" varStatus="j">
										<td class="<c:if test = "${i.index eq 0 and weekNum eq 1 }">start</c:if><c:if test="${data.nowMonth eq i.index and data.nowWeekNum eq weekNum }"> current</c:if><c:if test = "${i.index ne 0 and j.index eq 1 }"> divline</c:if><c:if test = "${i.index+1 eq fn:length(weekNumList) and j.index eq data }"> finish</c:if>">
											<c:if test="${data.nowYear eq data.thisYear and data.nowMonth eq i.index and data.nowWeekNum eq weekNum }">
												<div class="timeline"></div>
											</c:if>

											<div class="ganttBar noneRg" id="activityDtTotArea_${i.index+1 }_${weekNum}">

												<c:if test="${startDtBuf[0] eq data.thisYear and startDtBuf[1] eq i.index+1 and data.startWeekNum eq weekNum }">
													<div class="startDate" id = "startDate_${i.index+1 }_${weekNum}" <c:if test="${i.index+1>1 }"></c:if>>
														<span class="txt_date">${startDtBuf[1]}/${startDtBuf[2]}<em class="point"></em></span>
														<span class="txt_des">시작
															<c:if test="${data.startDt eq  data.endDt}">
																<c:set var = "endYn" value="N" />
																(완료)
															</c:if>
														</span>

													</div>
												</c:if>

												<c:if test="${endDtBuf[0] eq data.thisYear and endDtBuf[1] eq i.index+1 and data.endWeekNum eq weekNum and endYn eq 'Y' }">
													<div class="endDate" id = "endDate_${i.index+1 }_${weekNum}">
														<span class="txt_date">${endDtBuf[1]}/${endDtBuf[2]}<em class="point"></em></span>
														<span class="txt_des">완료</span>

													</div>
												</c:if>

												<ul class="acti_RgList n1">
													<c:set var="startDtStr">${startDtBuf[0] }-${startDtBuf[1] }-${data.startWeekNum }</c:set>
													<c:set var="endDtStr">${endDtBuf[0] }-${endDtBuf[1] }-${data.endWeekNum }</c:set>
													<c:set var="thisDtStr">${data.thisYear }-${i.index<9?0:'' }${i.index+1 }-${weekNum }</c:set>
													<c:set var="nowDtStr">${data.nowYear }-${data.nowMonth<9?0:'' }${data.nowMonth+1 }-${data.nowWeekNum }</c:set>
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
					<script type="text/javascript">
					</script>
				</td>
			</tr>

			<tr id = "activityDtTr_${data.activityId }">
			</tr>

			<!--//간트차트//-->
			<script type="text/javascript">
			searchActivityWbsWorkDetail(${data.projectId },${data.activityId },${data.thisYear },'${data.startDate }','${data.endDate }','${data.startWeekNum }','${data.endWeekNum }','${data.name}')

			</script>
		</c:forEach>
	</tbody>
</table>

</td>
