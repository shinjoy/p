<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="./js/annualInfoList_JS.jsp" %>



<section id="detail_contents">

<form id ="frm" name = "frm" method="post">
	<input type="hidden" name = "pageIndex" id = "pageIndex" value="${paginationInfo.currentPageNo }" />
	<!-- 상세화면이동을위한파라미터 -->
	<input type="hidden" name = "orgId" id = "orgId" />
	<input type="hidden" name = "userId" id = "userId" />
	<input type="hidden" name = "searchDeptId" id = "searchDeptId" />
	<input type="hidden" name = "leaveId"  id = "leaveId" />


	<div class="carSearchBox">

		<!-- 마스터 권한에만 회사 선택 란이 보인다 -->
		<label for="year"><span class="carSearchtitle">연도</span></label>
        <select class="select_b w_date mgr20" id="year" name = "year"   onchange="linkPage('1')"></select>
		<label for="searchDeptIdBuf"><span class="carSearchtitle">부서선택</span></label>
		<select class="select_b" id="searchDeptIdBuf" name = "searchDeptIdBuf" onchange="linkPage('1')"><!-- onchange="searchDeptId()" -->
		      <option value="" >전체</option>
              <c:forEach items="${accessOrgDeptUserList }"  var = "data">
                  <c:set var = "searchDeptId" value="${data.orgId}_${data.deptId }" />
                  <option value="value_${data.orgId }_${data.deptId }" >${data.deptNm }</option>
              </c:forEach>
		</select>
		<input class="input_b2 w200px mgl10" id = "searchText" name = "searchText" placeholder="직원검색" onkeypress="if(event.keyCode==13) {linkPage('1'); return false;}" value="${searchMap.searchTitle}">
		<a href="javascript:linkPage('1')" class="btn_g_black mgl10"><em>검색</em></a>
	</div>

	<!--게시판정렬목록-->
	<div class="board_classic mgt20">
		<div class="leftblock">
			<span class="count_result"><strong>전체</strong><em id = "totalCnt"></em>건</span>
			<select class="sh_count_type" id = "recordCountPerPage" name = "recordCountPerPage" title="정렬방법 선택" onchange="linkPage('1')">
				<option value="10" <c:if test = "${searchMap.recordCountPerPage eq '10' }">selected="selected"</c:if>>10개씩 보기</option>
				<option value="15" <c:if test = "${searchMap.recordCountPerPage eq '15' }">selected="selected"</c:if>>15개씩 보기</option>
				<option value="20" <c:if test = "${searchMap.recordCountPerPage eq '20' }">selected="selected"</c:if>>20개씩 보기</option>
				<option value="50" <c:if test = "${searchMap.recordCountPerPage eq '50' }">selected="selected"</c:if>>50개씩 보기</option>
			</select>
		</div>
		<div class="rightblock">

		</div>
	</div>
	<!--//게시판정렬목록//-->

	<!-- ======================================= 연차관리 목록 :S ======================================== -->
	<div id = "listArea">
		<jsp:include page="./include/annualInfoList_INC.jsp"></jsp:include>
	</div>
	<!-- ======================================= 연차관리 목록 :S ======================================== -->


	<!-- ======================================= 연차관리 상세정보 :S ======================================== -->
	<h3 class="sys_grid_title">[ 연차수정 <span id="displaynameTag" class="pointlistcolor"></span>]</h3>
       <table class="datagrid_input" summary="연차목록">
           <caption>연차목록</caption>
           <colgroup>
	        <col width="5%" />
	        <col width="7%" />
	        <col width="10%" />
	        <col width="10%" />
	        <col width="10%" />
	        <col width="7%" />
	        <col width="10%" />
	        <col width="9%" />
	        <col width="9%" />
	        <col width="9%" />
	        <col width="7%" />
	        <col width="7%" />
	    </colgroup>
	    <thead>
	    	<tr>
	    		<th scope="col"></th>
	    		<th scope="col">사번</th>
	    		<th scope="col">이름</th>
	    		<th scope="col">회사</th>
	    		<th scope="col">부서</th>
	    		<th scope="col">직책</th>
	    		<th scope="col">입사일</th>
	    		<th scope="col">기본<br>년차일수</th>
	    		<th scope="col">근속년수<br>년차일수</th>
	    		<th scope="col">임의추가<br>년차일수</th>
	    		<th scope="col">수정자</th>
	    		<th scope="col">등록자</th>
	    	</tr>
	    </thead>
           <tbody>
               <tr id="trdata" style="display:none;" >
                   <td>&nbsp;</td>
                   <td class="txt_center num_date_type"><span id="empNoViewTag" ></span></td>
                   <td class="txt_center"><span id="nameTag" ></span></td>
                   <td class="txt_center"><span id="cpnNmTag" ></span></td>
                   <td class="txt_center"><span id="deptNmTag" ></span></td>
                   <td class="txt_center"><span id="positionTag" ></span></td>
                   <td class="txt_center num_date_type"><span id="hiredDateTag" ></span></td>
                   <td class="txt_center"><input type="text" id="annualLeaveDay"  name="annualLeaveDay"  maxlength="4" class="w50p" /></td>
                   <td class="txt_center"><input type="text" id="workAnnualLeaveDay"  name="workAnnualLeaveDay"  maxlength="4" class="w50p" /></td>
                   <td class="txt_center"><input type="text" id="userAnnualLeaveDay"  name="userAnnualLeaveDay"  maxlength="4" class="w50p" /></td>
                   <td class="txt_center">&nbsp;</td>
                   <td class="txt_center">&nbsp;</td>
               </tr>
               <tr id="trNodata" >
                   <td class="txt_center" colspan="12">선택된 직원이 없습니다.</td>
               </tr>
           </tbody>
       </table>
    <!--버튼영역-->
    <div  class="btn_baordZone2">
        <a href="javascript:doSaveUserLeaveH();" class="btn_blueblack">저장</a>
    </div>
    <!--//버튼영역//-->
    <!-- ======================================= 연차관리 상세정보 :E ======================================== -->
</form>

</section>