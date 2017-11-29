<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<jsp:useBean id="toDay" class="java.util.Date" />

<h3 class="h3_title_basic mgt20" id="h3Title">
<c:choose>
	<c:when test="${deptInfo.deptNm ne null }" >
		${deptInfo.deptNm }
	</c:when>
	<c:when test="${userInfo.userNm ne null }" >
		${userInfo.userNm }
	</c:when>
	<c:otherwise>
		전체
	</c:otherwise>
</c:choose>
<span id="capSearch"  class="sub_desc">(<fmt:formatDate value="${toDay}" pattern="yyyy년 MM월 dd일" />)</span>
</h3>

<!-- 부서별Top -->
<div class="statsBoxWrap">
	<ul class="pro_layoutList case01 mgt20">
		<!--프로젝트전체-->
		<li class="w01">
			<div class="pro_statsBox">
				<h4 class="box_title">프로젝트 전체</h4>
				<table class="pro_stats_tb" summary="프로젝트 전체(임시저장, 예정, 진행, 보류, 중단, 마감대기, 마감)">
					<caption class>프로젝트 전체</caption>
					<thead>
						<tr>
							<th scope="col">프로젝트전체</th>
							<th scope="col">임시저장</th>
							<th scope="col">예정</th>
							<th scope="col">진행</th>
							<th scope="col">보류</th>
							<th scope="col">중단</th>
							<th scope="col">마감대기</th>
							<th scope="col">마감</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">${projectStatus.totalCnt }</th>
							<td>${projectStatus.tempSaveCnt }</td>
							<td>${projectStatus.expectCnt }</td>
							<td>${projectStatus.progressCnt }</td>
							<td>${projectStatus.pendingCnt }</td>
							<td>${projectStatus.stopCnt }</td>
							<td>${projectStatus.closeReadyCnt }</td>
							<td>${projectStatus.closedCnt }</td>
						</tr>
						<tr>
							<th scope="row">${projectStatus.totalCnt eq 0?'0':'100' }<em>%</em></th>
							<td>${projectStatus.totalCnt eq 0?'0':projectStatus.tempSaveRate }<em>%</em></td>
							<td>${projectStatus.totalCnt eq 0?'0':projectStatus.expectRate }<em>%</em></td>
							<td>${projectStatus.totalCnt eq 0?'0':projectStatus.progressRate }<em>%</em></td>
							<td>${projectStatus.totalCnt eq 0?'0':projectStatus.pendingRate }<em>%</em></td>
							<td>${projectStatus.totalCnt eq 0?'0':projectStatus.stopRate }<em>%</em></td>
							<td>${projectStatus.totalCnt eq 0?'0':projectStatus.closeReadyRate }<em>%</em></td>
							<td>${projectStatus.totalCnt eq 0?'0':projectStatus.closedRate }<em>%</em></td>
						</tr>
					</tbody>
				</table>
				<div class="pro_stats_graWrap">
					<div class="pro_grabox">
						<h5 class="gra_title">[프로젝트 진행상태]</h5>
						<!-- 프로젝트전체 pieChart -->
						<div id="projectPieChart" class="real_graph" >해당내역이 없습니다.</div>
					</div>
				</div>
			</div>
		</li>
		<!--액티비티전체-->
		<li class="w02">
			<div class="pro_statsBox">
				<h4 class="box_title">액티비티 전체</h4>
				<table class="pro_stats_tb" summary="액티비티 전체(임시저장, 예정, 진행, 보류, 중단, 마감대기, 마감)">
					<caption>액티비티 전체</caption>
					<thead>
						<tr>
							<th scope="col">액티비티전체</th>
							<th scope="col">예정</th>
							<th scope="col">진행</th>
							<th scope="col">사용안함</th>
							<th scope="col">마감</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">${activityStatus.totalCnt }</th>
							<td>${activityStatus.expectCnt }</td>
							<td>${activityStatus.progressCnt }</td>
							<td>${activityStatus.disableCnt }</td>
							<td>${activityStatus.closedCnt }</td>
						</tr>
						<tr>
							<th scope="row">${activityStatus.totalCnt eq 0?'0':'100' }<em>%</em></th>
							<td>${activityStatus.totalCnt eq 0?'0':activityStatus.expectRate }<em>%</em></td>
							<td>${activityStatus.totalCnt eq 0?'0':activityStatus.progressRate }<em>%</em></td>
							<td>${activityStatus.totalCnt eq 0?'0':activityStatus.disableRate }<em>%</em></td>
							<td>${activityStatus.totalCnt eq 0?'0':activityStatus.closedRate }<em>%</em></td>
						</tr>
					</tbody>
				</table>
				<div class="pro_stats_graWrap">
					<div class="pro_grabox">
						<h5 class="gra_title">[액티비티 진행상태]</h5>
						<div id="activityPieChart" class="real_graph">해당내역이 없습니다.</div>
					</div>
				</div>
			</div>
		</li>
		<!--업무일지(팀업무/개인업무)-->
		<li class="w03">
			<div class="pro_statsBox">
				<h4 class="box_title">업무일지 전체</h4>
				<table class="pro_stats_tb" summary="업무일지 전체(임시저장, 예정, 진행, 보류, 중단, 마감대기, 마감)">
					<caption>업무일지 전체</caption>
					<thead>
						<tr>
							<th scope="col">업무일지전체</th>
							<th scope="col">팀업무</th>
							<th scope="col">개인업무</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">${officeDaily.workTotalCnt }</th>
							<td>${officeDaily.workTeamCnt }</td>
							<td>${officeDaily.workPrivateCnt }</td>
						</tr>
						<tr>
							<th scope="row">${empty officeDaily.workTotalRate?'0':'100' }<em>%</em></th>
							<td>${officeDaily.workTeamRate }<em>%</em></td>
							<td>${officeDaily.workPrivateRate }<em>%</em></td>
						</tr>
					</tbody>
				</table>
				<div class="pro_stats_graWrap">
					<div class="pro_grabox">
						<h5 class="gra_title">[업무일지 진행상태]</h5>
						<div id="officePieChart" class="real_graph" >해당내역이 없습니다.</div>
					</div>
				</div>
			</div>
		</li>
	</ul>
</div>
<!--//부서별Top//-->
