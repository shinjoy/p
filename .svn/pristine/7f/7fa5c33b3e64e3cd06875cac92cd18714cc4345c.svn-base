<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<style>
.display-none {
    display:none;
}
</style>

<%@ include file="./js/cardList_JS.jsp" %>

<div class="wrap-loading display-none">
    <div><img src="<c:url value='/images/ajax_loading.gif'/>" /></div>
</div>

<div class="verticalWrap">
	<!--====================== 메모 박스 : S ===================-->
	<input type="hidden" id="cardSnb"/> <!-- 메모 등록시 snb 세팅-->
	<!--====================== 메모 박스 : E ===================-->
	<input type="hidden" id="usrId">
	<input type="hidden" id="searchOrgId" name="searchOrgId" value="${baseUserLoginInfo.applyOrgId }"/>
	<!--============== LEFT MENU : S =============-->
	<div class="addAreaZone" id = "userTreeArea">
		<div id="userListAreaTree"></div><!-- 사용자트리 -->
	</div>

	<!-- ======================================= 왼쪽 메뉴(팀장) :S ======================================== -->
    <div class="addAreaZone" id = "userDeptTreeArea" style="display: none;">
    	<input type="hidden" id = "searchDeptId" name = "searchDeptId">
        <div class="tnavi_title">
            <span>
                <!-- 마스터 권한에만 회사 선택 란이 보인다 -->
                <c:choose>
                    <c:when test="${ (pageType eq 'MGMT' && baseUserLoginInfo.orgId eq '1') || (pageType eq 'VIEW' && deptLevel eq 'L00')}">
                        <select id="targetOrgId" name="targetOrgId" class="select_b w_date" onChange="fnObj.doLoadTreeviewPage()">
                            <c:forEach items="${orgCompList}" var="item">
                                <option value="${item.orgId}" ${ item.orgId == baseUserLoginInfo.applyOrgId ? "selected" : "" }>${item.cpnNm}</option>
                            </c:forEach>
                        </select>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${orgCompList}" var="item">
                            <c:if test="${item.orgId eq baseUserLoginInfo.applyOrgId}">${item.cpnNm}</c:if>
                        </c:forEach>
                        <input type="hidden" id="targetOrgId" name = "targetOrgId" value="${baseUserLoginInfo.applyOrgId}"/>
                    </c:otherwise>
                </c:choose>
            </span>
            <button type="button" class="btn_s_replay" onclick="doRefreshPage();"><em>검색초기화</em></button>

        </div>
        <div id="AXJSTree" class="tnavi_treezone"></div>
    </div>
    <!-- ======================================= 왼쪽 메뉴(팀장) :E ======================================== -->
	<!--============== LEFT MENU : E =============-->

    <!--============== RIGHT MENU : S =============-->
 	<section id="detail_contents" style="overflow: auto;">
   		<input type="hidden" id="choiceMonth"/>
   		<!--검색영역-->
   		<div class="carSearchBox withcal">
   			<div class="blocktype mgr10">
				<span id="searchTypeDiv"></span>		  	<!-- 분류 -->
				<span id="yearDiv"></span>					<!-- 년도 -->
			</div>
			<div class="blocktype mgr10">
				<span id="monthDiv" class="btn_monthZone"></span>
			</div>

			<div class="blocktype">
				<span class="carSearchtitle">기간조회</span>
				<input type="text" id="startDate" class="input_date_type input_b mgl5" readonly="readonly"/>
				<a href="#" onclick="$('#startDate').datepicker('show');return false;" class="icon_calendar"><em>날짜선택</em></a>
				<span class="dashLine">~</span>
				<input type="text" id="endDate" class="input_date_type input_b mgl5" readonly="readonly"/>
				<a href="#" onclick="$('#endDate').datepicker('show');return false;" class="icon_calendar"></a>
	          	<button type="button" name="reg_btn" class="btn_g_black mgl10" onclick="fnObj.clickSearch();">조회</button>

			    <!-- 툴팁 -->
	            <span class="memotooltip">
	            	<a href="javascript:showlayer(SpendingaDvice)" class="btn_icon_advice"><em>도움말</em></a>
	               	<div id="SpendingaDvice" class="tooltip_box" style="display:none;">
						<div class="wrap_autoscroll">
						    <span class="intext">
						    <h3 class="title">1. 일정 필수 항목 - 영업관련 및 대중교통비,부서회식<br>&nbsp;&nbsp;[해당건에 대한 일정을 등록 후 사용]</h3>

						    <h3 class="title">2. 영업관련 입력 시 대상자 필수</h3>
						    <ul class="list_st_dot3 mgb15">
						        <li class="f12">대상자 외 1명 이상 - 추가대상자 입력</li>
						    </ul>
						    <h3 class="title">3. 대중교통비 입력 시 출발지 목적지 기재</h3>
						    <h3 class="title">4. 소모품 입력 시 구입품목 개별 기재</h3>

						    <em class="edge_topcenter"></em>
						    <a href="javascript:showlayer(SpendingaDvice)" class="closebtn_s"><img src="../images/common/icon_car_tooltip_close.gif" alt="닫기" /></a>
						    </span>
						    <em class="edge_topleft"></em>
						</div>
					</div>
				</span>
	            <!--// 툴팁 //-->
	        </div>

			<div class="btnRightZone">
				<button name="reg_btn" class="btn_b2_skyblue" onclick="fnObj.excelDownList();"><em class="icon_XLS">파일로 저장</em></button>
			</div>
		</div>
		<!--//검색영역//-->
        <div class="board_classic mgt20">
    		<div class="leftblock">
    			<span class="count_result"><strong>전체</strong><em><span id="total_count"></span></em>건</span>
    		</div>
    		<!-- 2016.12.29. 이인희 지출입력 필수자 여부가 'N'이면 업무등록 불가함 -->
    		<c:if test="${baseUserLoginInfo.expenseYn ne 'N' }">
    		    <div class="rightblock">
	                <span class="btn_auth">
	                    <button type="button" id="regYnBtn" class="btn_b_black btn_auth btn_myOrg" name="reg_btn" onclick="fnObj.cardReg(0);"><span id="regTxtSpan">지출등록</span></button>
	                </span>
	            </div>
    		</c:if>
         </div>

		 	<!-- 데이터 그리드 -->
			<div id="listArea"></div>

			<!--========================== 합계 :S =======================-->
	        <div class="total_tb_listwrap">

				<div class="btn_baordZone">
	                <a href="javascript:fnObj.regApproval('Y');" class="btn_blueblack btnApproval" style="display:none;">승인</a>
	            </div>

				<table id="SGridTargetSum" class="total_tb_list_basic" summary="지출 목록 총합계(영업관련, 복리후생, 교통비, 차량유지, 운반비, 구입비)">
					<caption>지출 목록</caption>
					<colgroup>
						<col width="*" /> <!--세부항목-->
						<col width="*" /> <!--구분-->
						<col width="*" /> <!--금액-->
					</colgroup>
					<tbody id="detailSum">
						<tr>
							<th rowspan="6">세<br>부<br>항<br>목</th>
							<th class="bg_gray">영업관련</th>
							<td class="txt_money"><span>0</span><em>원</em></td>
						</tr>
						<tr>
							<th class="bg_gray">복리후생</th>
							<td class="txt_money"><span>0</span><em>원</em></td>
						</tr>
						<tr>
							<th class="bg_gray">교통비</th>
							<td class="txt_money"><span>0</span><em>원</em></td>
						</tr>
						<tr>
							<th class="bg_gray">차량유지</th>
							<td class="txt_money"><span>0</span><em>원</em></td>
						</tr>
						<tr>
							<th class="bg_gray">운반비</th>
							<td class="txt_money"><span>0</span><em>원</em></td>
						</tr>
						<tr>
							<th class="bg_gray">구입비</th>
							<td class="txt_money"><span>0</span><em>원</em></td>
						</tr>

					</tbody>
					<tfoot>
						<tr>
							<th colspan="2">전체총계</th>
							<td class="txt_money"><span id="totalSum">0</span><em>원</em></td>
						</tr>
					</tfoot>
				</table>
			</div>
	        <!--=========================== 합계 :E =========================-->
	        <div class="btn_baordZone2"></div>
	</section>
	<!--============== RIGHT MENU : E =============-->
</div>
