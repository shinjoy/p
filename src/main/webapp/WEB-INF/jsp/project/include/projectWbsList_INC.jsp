<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach items="${projectWbsList }" var="data">
	<h3 class="h3_title_basic mgt20">
		<span>${data.name }</span>
		<a href="javascript:showProjectDetailPop('${data.projectId }')" class="btn_s_type3 mgl15">
			<em class="icon_info">${baseUserLoginInfo.projectTitle} 정보</em>
		</a>
	</h3>


	<c:set var="endDtBuf" value="${fn:split(data.endDt,'-') }"></c:set>
	<c:set var="startDtBuf" value="${fn:split(data.startDt,'-') }"></c:set>

	<h3 class="h3_table_title2" style="border-top: #b9c1ce solid 1px"><c:if test = "${startDtBuf[0] ne data.thisYear}"><button type="button" class="btn_prev_yr mgr20" style="display: none;"><em>이전해</em></button></c:if><span>Gantt Chart (${data.thisYear })</span><c:if test = "${endDtBuf[0] ne data.thisYear}"><button type="button" class="btn_next_yr mgl20" style="display: none;"><em>다음해</em></button></c:if></h3>

	<table class="tb_wbsChart" summary="전체통계(1월~12월, 영업관리비, 복리후생비, 대중교통비, 차량유지비, 택배비, 소모품비)">
	<tbody>
		<tr>
			<td class="pd0">
				<!--간트차트-->
				<table class="tb_ganttChart" summary="Gantt Chart (2017) 연간 project 진행차트" id = "projectDtTable_${data.projectId }">
					<caption>Gantt Chart</caption>
					<colgroup>
						<col width="80">
						<col width="*" span="()">
					</colgroup>
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
					<tbody>
						<tr class="totalrow" id = "projectDtTotArea_${data.projectId }">
							<th scope="row" style="cursor: pointer;" onclick="viewActivityDt(${data.projectId },${data.thisYear })">
								<p class="name">
									${baseUserLoginInfo.projectTitle}<br>전체
									<span id = "toggleDtImageArea_${data.projectId }">
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

										<div class="ganttBar noneRg" id="projectDtTotArea_${i.index+1 }_${weekNum}">

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
			</td>
		</tr>
		<tr id = "activityDtTr_${data.projectId }">
		</tr>
	</tbody>
</table>
<script type="text/javascript">
	$(document).ready(function(){
		//프로젝트 전체 진척현황 표시
		var progressRate = parseInt("${data.progressMap.progressRate}");

		if(progressRate == 0){
			var $targetObj = $("#projectDtTable_${data.projectId}").find(".startDate");

			if($targetObj.length == 0){
				$targetObj = $("#projectDtTable_${data.projectId}").find(".start");
			}else{
				$targetObj = $targetObj.parent();
			}

			$targetObj.find(".acti_RgList li").eq(0).html("<span class=\"num\">"+progressRate+"%</span>");

		}else{

			var totCnt = $("#projectDtTotArea_${data.projectId}").find(".acti_RgList").has("li").length;
			try{
			totCnt = totCnt.toFixed(0);
			progressRate = progressRate.toFixed(0);
			}catch(e){

			}

			var comCnt = parseInt(totCnt*(progressRate/100));
			if(comCnt == 0) comCnt = 1;
			$("#projectDtTotArea_${data.projectId}").find(".acti_RgList").has("li").each(function(i){
				$(this).empty();

				var stStr = "";

				if(i+1 == comCnt){
					stStr+="<span class=\"num\">"+progressRate+"%</span>"
				}

				$(this).append("<li class=\"done_rg\">"+stStr+"</li>");

				if(i+1 == comCnt){
					return false;
				}
			});
		}

		$("#total_count").text("${paginationInfo.totalRecordCount}");
	});


</script>
</c:forEach>

<c:if test = "${paginationInfo.totalPageCount>paginationInfo.currentPageNo}">
	<div class="btn_morelist" id="btnAllViewList">
		<a href="javascript:doSearch('${paginationInfo.currentPageNo }')"><em>더보기</em></a>
	</div>
</c:if>

<c:if test="${fn:length(projectWbsList)<=0 }">
<dd class="pro_historyList">
	<div class="nocontents">조회 내용이 없습니다.</div>
</dd>
</c:if>
