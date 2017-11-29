<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="./js/projectWbsList_JS.jsp" %>
<section id="detail_contents">
	<form id = "frm" name = "frm" method="POST">

		<!-- 더보기 엑션을 위한 파라미터 -->
		<input type="hidden" id = "pageIndex" name = "pageIndex" value="1">

		<!-- 상시비상시구분 -->
		<input type="hidden" id = "searchPeriodYn" name = "searchPeriodYn" value="N">

		<!-- 진행/마감,보류,중단 -->
		<input type="hidden" id = "projectStatus" name = "projectStatus" value="PROGRESS">
		<!-- 지켜보는업무구분보기 -->
		<input type="hidden" id = "searchprojectViewer" name = "searchProjectViewer" value="N">
		<!-- 사용여부 포함보기 -->
		<input type="hidden" id = "searchnouseYn" name = "searchNoUseYn" value="N">


		<c:set var="cssIndex" value="1"></c:set>
		<c:forEach items="${wbsSummaryMaplist }" var="data" varStatus="i">
			<c:if test="${data.type ne 'TOT' and data.type ne 'COMPLTE' and (data.deleteYn eq 'N' or data.teamTot + data.privateTot>0) }">
				<script type="text/javascript">
					wbsProcessCss["${data.type}"]="etc${cssIndex }_rg";
				</script>
				<c:set var="cssIndex" value="${cssIndex+1 }"></c:set>
			</c:if>
		</c:forEach>

		<div class="carSearchBox mgb20" id = "searchBox">
			<span class="carSearchtitle mgl10">구분 :</span>
			<span class="rd_List">
				<label>
					<select id="employee" name = "employee" class="select_b" onchange="doSearch(0);">
						<option value="">전체</option>
						<option value="Y">직원배정</option>
						<option value="A">전직원</option>
					</select>
				</label>
			</span>
			<span class="carSearchtitle mgl10">유형 :</span>
	        <span class="rd_List">
	            <label>
	                <span id = "projectTypeArea"></span>
	            </label>
	        </span>
	        <span class="carSearchtitle mgl10">공개 :</span>
	        <span class="rd_List">
	            <label>
	                <select id="openFlag" name = "openFlag" class="select_b" onchange="doSearch(0);">
	                    <option value="">전체</option>
	                    <option value="Y">공개</option>
	                    <option value="N">비공개</option>
	                </select>
	            </label>
	        </span>

			<span class="carSearchtitle mgl10">마감 임박 :</span>
	        <span class="rd_List">
	            <label>
	                <input type="checkbox" id = "nearClose" name = "nearClose" value="Y" onclick="doSearch(0);"/>
	            </label>
	        </span>
			<input id="searchTxt" name = "searchTxt" type="text" placeholder="${baseUserLoginInfo.projectTitle}를 검색하세요" value="" onkeypress="if(event.keyCode==13){ doSearch(0);}" class="input_b2 w200px  mgl20" title="${baseUserLoginInfo.projectTitle}검색" />
			<input type="text" style="display: none;">
	        <a href="#" onclick="doSearch(0);" class="btn_g_black mgl10 mgr20"><em>검색</em></a>
		</div>

		<div class="board_classic">
		<div class="leftblock">
			<span class="count_result"><strong>전체</strong><em id="total_count">31</em>건</span>
			<div class="sys_p_noti mgl10" style="display: inline-block;">
				<span class="icon_noti"></span>
				<span onmouseover="openHelpPop($(this));" onmouseout="closeHelpPop()" style="cursor: pointer;">[범례]</span>
				<c:if test="${baseUserLoginInfo.vipAuthYn eq 'Y' }">
					<button type="button" class="btn_toggle on" id="btnEmployee" onclick="searchEmployee()">개인</button>
					<input type="hidden" id = "superAllChkYn" name = "superAllChkYn" value="Y">
				</c:if>
			</div>
		</div>

		<div class="rightblock" id = "searchChkArea">
				<span class="vmbox">
					<label>
						<span>지켜보는 업무구분 보기</span>
						<input type="checkbox" id="projectViewer" value="Y" onclick="searchChkBox('projectViewer')">
					</label>
				</span>
				<span class="vmbox">
					<label>
						<span>마감/보류/중단 포함보기</span>
						<input type="checkbox" id="disableProject" value="Y" onclick="searchChkBox('disableProject')">
					</label>
				</span>
				<span class="vmbox">
					<label>
						<span>사용안함 포함보기</span>
						<input type="checkbox" id="nouseYn" value="Y" onclick="searchChkBox('nouseYn')">
					</label>
				</span>
			</div>
		</div>

	    <ul class="tabZone_st03" id="tabArea">
			<li id="tab_NOPERIOD" class="current"><a href="javascript:moveTab('NOPERIOD')">상시 ${baseUserLoginInfo.projectTitle}</a></li>
			<li id="tab_PERIOD"><a href="javascript:moveTab('PERIOD')">비상시 ${baseUserLoginInfo.projectTitle}</a></li>
		</ul>
		<div id = "projectWbsListArea">
			<jsp:include page="./include/projectWbsList_INC.jsp"></jsp:include>
		</div>

		<!--프로젝트정보팝업-->
		<div style="display: none;">
			<div id="compnay_dinfo2">
				<div class="modalWrap2">
					<h1>${baseUserLoginInfo.projectTitle}상세팝업</h1>
					<div class="mo_container" id = "projectInfoPopArea">
					</div>
					<a href="javascript:myModal.close('my-modal-div');" class="btn_modal_close"><em>창 닫기</em></a>
				</div>
			</div>
		</div>
		<!--//프로젝트팝업//-->
	</form>
</section>

<span id="leaderHelpPop" style="z-index: 9999999999;width: 200px;padding:1px,1px,1px,1px; ">
	<div class="fl_block explain_tooltip">
		<div class="tooltip_box wrap_autoscroll" id = "leaderHelpPopTooltipBox">
			 <span class="intext" id = "leaderHelpPopStr">
			 	리더란? <br>
단위업무의 기간과 참여자, 진척율을 관리하는 담당자입니다
			 </span>
			 <em class="edge_topleft" style="left:40px;"></em>
		</div>
	</div>
</span>


<span id="helpPop" style="z-index: 9999999999;width:160px;padding:1px,1px,1px,10px; ">
	<div class="fl_block explain_tooltip">
		<div class="tooltip_box wrap_autoscroll" id = "helpPopTooltipBox">
			 <span class="intext">
			 	<ul class="wbs_actiList" style="margin-left: 10px;">
					<li class="no_acti_rg">업무 없는 기간(과거)</li>
					<li class="done_rg">완료업무</li>
					<li class="delay_rg">잔여 기간(미래)</li>
					<!-- <li class="incomplete_rg">미완료업무</li> -->

					<c:set var="cssIndex" value="1"></c:set>
					<c:forEach items="${wbsSummaryMaplist }" var="data" varStatus="i">
						<c:if test="${data.type ne 'TOT' and data.type ne 'COMPLTE' and (data.deleteYn eq 'N' or data.teamTot + data.privateTot>0) }">
							<li class="etc${cssIndex }_rg">${data.discription }</li>
							<script type="text/javascript">
								wbsProcessCss["${data.type}"]="etc${cssIndex }_rg";
							</script>
							<c:set var="cssIndex" value="${cssIndex+1 }"></c:set>
						</c:if>
					</c:forEach>

				</ul>
			 </span>
			 <em class="edge_topleft" style="left:40px;"></em>
		</div>
	</div>
</span>

