<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" defer="defer">
	$(document).ready(function(){


	});

</script>
<div class="bottomWarp">
	<ul id="sortable_Bmodule">
		<li class="ui-state-default">
			<!--지켭보는업무-->
			<div class="watch_taskWrap">
				<div class="labelsetLine">
					<h3><strong>지켜보는 업무구분</strong><a href="#" class="rdmore_btn"><em>더보기</em></a></h3>
				</div>
				<div class="watch_taskList">
					<h3 class="h3_title_basic">
						<span>프로젝트명</span>
						<a href="javascript:void(window.open('${pageContext.request.contextPath}//project/pop_project_info.jsp', 'newcr','resizable=no,width=900,height=720,scrollbars=yes'));" class="btn_s_type3 mgl15"><em class="icon_info">프로젝트 정보</em></a>
						<button type="button" class="btn_nowatch"><em>지켜보기 해지</em></button>
					</h3>
					<h4 class="h3_table_title2 line_add"><button type="button" class="btn_prev_yr mgr20"><em>이전해</em></button><span>Gantt Chart (2017)</span><button type="button" class="btn_next_yr mgl20"><em>다음해</em></button></h4>
					<table class="tb_wbsChart" summary="전체통계(1월~12월, 영업관리비, 복리후생비, 대중교통비, 차량유지비, 택배비, 소모품비)">
						<tbody>
							<tr>
								<td class="pd0">
									<!--간트차트-->
									<table class="tb_ganttChart" summary="Gantt Chart (2017) 연간 Activity 진행차트">
										<caption>Gantt Chart</caption>
										<colgroup>
											<col width="49">
											<col width="*" span="48">
										</colgroup>
										<thead>
											<tr>
												<th scope="col" rowspan="2">&nbsp;</th>
												<th scope="col" colspan="4">1월</th>
												<th scope="col" colspan="4">2월</th>
												<th scope="col" colspan="4">3월</th>
												<th scope="col" colspan="4">4월</th>
												<th scope="col" colspan="4">5월</th>
												<th scope="col" colspan="4">6월</th>
												<th scope="col" colspan="4">7월</th>
												<th scope="col" colspan="4">8월</th>
												<th scope="col" colspan="4">9월</th>
												<th scope="col" colspan="4">10월</th>
												<th scope="col" colspan="4">11월</th>
												<th scope="col" colspan="4">12월</th>
											</tr>
											<tr>
												<td>1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
											</tr>
										</thead>
										<tbody>
											<tr class="totalrow">
												<th scope="row"><p class="name">프로<br>젝트</p></th>
												<td class="start">
													<div class="ganttBar">
														<div class="startDate">
															<span class="txt_date">01/01<em class="point"></em></span>
															<span class="txt_des">시작</span>
														</div>
														<ul class="acti_RgList">
															<li class="acti_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList n2">
															<li class="no_actiRg"></li>
															<li class="delay_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="delay_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList n2">
															<li class="delay_Rg"></li>
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>

													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"><span class="num">55%</span></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline current">
													<div class="timeline"><span class="date">(09/07)</span></div>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="acti_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="acti_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="finish">
													<div class="ganttBar" style="width:90%;">
														<div class="endDate">
															<span class="txt_date">10/27<em class="point"></em></span>
															<span class="txt_des">완료</span>
														</div>
														<ul class="acti_RgList">
															<li class="acti_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td class="divline">&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
										</tbody>
									</table>
									<!--//간트차트//-->
								</td>
							</tr>
						</tbody>
					</table>
					<h3 class="h3_title_basic mgt30">
						<span>프로젝트명</span><span class="icon_secret mgl10"><em>비공개</em></span>
						<a href="javascript:void(window.open('${pageContext.request.contextPath}//project/pop_project_info.jsp', 'newcr','resizable=no,width=900,height=720,scrollbars=yes'));" class="btn_s_type3 mgl15"><em class="icon_info">프로젝트 정보</em></a>
						<button type="button" class="btn_nowatch"><em>지켜보기 해지</em></button>
					</h3>
					<h4 class="h3_table_title2 line_add"><button type="button" class="btn_prev_yr mgr20"><em>이전해</em></button><span>Gantt Chart (2017)</span><button type="button" class="btn_next_yr mgl20"><em>다음해</em></button></h4>
					<table class="tb_wbsChart" summary="전체통계(1월~12월, 영업관리비, 복리후생비, 대중교통비, 차량유지비, 택배비, 소모품비)">
						<tbody>
							<tr>
								<td class="pd0">
									<!--간트차트-->
									<table class="tb_ganttChart" summary="Gantt Chart (2017) 연간 Activity 진행차트">
										<caption>Gantt Chart</caption>
										<colgroup>
											<col width="49">
											<col width="*" span="48">
										</colgroup>
										<thead>
											<tr>
												<th scope="col" rowspan="2">&nbsp;</th>
												<th scope="col" colspan="4">1월</th>
												<th scope="col" colspan="4">2월</th>
												<th scope="col" colspan="4">3월</th>
												<th scope="col" colspan="4">4월</th>
												<th scope="col" colspan="4">5월</th>
												<th scope="col" colspan="4">6월</th>
												<th scope="col" colspan="4">7월</th>
												<th scope="col" colspan="4">8월</th>
												<th scope="col" colspan="4">9월</th>
												<th scope="col" colspan="4">10월</th>
												<th scope="col" colspan="4">11월</th>
												<th scope="col" colspan="4">12월</th>
											</tr>
											<tr>
												<td>1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
												<td class="divline">1</td>
												<td>2</td>
												<td>3</td>
												<td>4</td>
											</tr>
										</thead>
										<tbody>
											<tr class="totalrow">
												<th scope="row"><p class="name">프로<br>젝트</p></th>
												<td class="start">
													<div class="ganttBar">
														<div class="startDate">
															<span class="txt_date">01/01<em class="point"></em></span>
															<span class="txt_des">시작</span>
														</div>
														<ul class="acti_RgList">
															<li class="acti_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList n2">
															<li class="no_actiRg"></li>
															<li class="delay_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="delay_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList n2">
															<li class="delay_Rg"></li>
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>

													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="done_Rg"><span class="num">55%</span></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline current">
													<div class="timeline"><span class="date">(09/07)</span></div>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="plan_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="acti_Rg"></li>
														</ul>
													</div>
												</td>
												<td>
													<div class="ganttBar">
														<ul class="acti_RgList">
															<li class="acti_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="finish">
													<div class="ganttBar" style="width:90%;">
														<div class="endDate">
															<span class="txt_date">10/27<em class="point"></em></span>
															<span class="txt_des">완료</span>
														</div>
														<ul class="acti_RgList">
															<li class="acti_Rg"></li>
														</ul>
													</div>
												</td>
												<td class="divline">&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td class="divline">&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
										</tbody>
									</table>
									<!--//간트차트//-->
								</td>
							</tr>
						</tbody>
					</table>
				</div>

			<!--//지켭보는업무//-->
		</li>
	</ul>
</div>
<!--//하단전체//-->
