<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="js/personMgmt_JS.jsp" %>

<div class="wrap-loading display-none">
    <div><img src="${pageContext.request.contextPath}/images/ajax_loading.gif" /></div>
</div>

<form id="frmPerson" name="frmPerson" >
<input type="hidden" id="cstType" name="cstType"/>
<input type="hidden" id="searchStaffId" name="searchStaffId" value="" />
<input type="hidden" id="cusId" name="cusId" value="${baseUserLoginInfo.cusId }" />
<input type="hidden" id="userId" name="cusId" value="${baseUserLoginInfo.userId }" />

<input type="hidden" id="actionType" name="actionType"  value="Alone"/>
<input type="hidden" id="isStock" name="isStock"/>
<input type="hidden" id="srchCustNmKor" name="srchCustNmKor"/>
<input type="hidden" id="searchOrgId" name="searchOrgId" value="${baseUserLoginInfo.applyOrgId }"/>


<div class="verticalWrap">
	<!-- ======================================= 왼쪽 메뉴 :S ======================================== -->
	<div class="addAreaZone">
	    <div id="userListAreaTree"></div>
	</div>
	<!-- ======================================= 왼쪽 메뉴 :E ======================================== -->
	<section id="detail_contents">
		<!--tab영역-->
		<div id="customerTypeTab" >
			<ul class="tabZone_st06">
			    <li id="liCusType" class="current"><a href="#" onclick="fnObj.clickRdCstType('',this);">전체</a></li>
				<c:forEach var="result" items="${customerTypeList}" varStatus="status">
					<li id="liCusType" ><a href="#"  onClick="fnObj.clickRdCstType('${result.cd}',this);">${result.nm}</a></li>
				</c:forEach>
			</ul>
		</div>
		<!--//tab영역//-->
		<!--검색부분-->
		<div class="carSearchBox mgt20">
		    <label>
		        <span class="carSearchtitle">회사명</span>
		        <input id="srchCpnNm" name="srchCpnNm"  onkeypress="if(event.keyCode==13){fnObj.doSearchName();}" class="input_b2 w150px" />
			</label>
			<label>
			    <span class="carSearchtitle mgl30">고객명</span>
			    <input id="srchCustNm"  name="srchCustNm" onkeypress="if(event.keyCode==13){fnObj.doSearchName();}" class="input_b2 w150px" />
			</label>
			<button type="button" onClick="fnObj.doSearchName();" class="btn_g_black mgl10">조회</button>
			<label class="mgl15">
				<input type="checkbox" id = "searchFireStaff" name = "searchFireStaff" value="Y" onclick="fnObj.doSearchFireStaff();"/>
				<span>퇴사자담당</span>
			</label>
			<label class="mgl15">
				<input type="checkbox" id = "searchNoStaff" name = "searchNoStaff" value="Y" onclick="fnObj.doSearchNoStaff();"/>
				<span>미담당고객</span>
			</label>
		     <div class="btnRightZone">
			    <button type="button" onClick="excelDownload();" class="btn_b2_skyblue"><em class="icon_XLS">파일로 저장</em></button>
			</div>
		</div>
		<!--//검색부분//-->

		<div id="rightPanel">
		     <jsp:include page="include/personMgmt_content_INC.jsp"></jsp:include>
		</div>

		<!--버튼영역-->
		<div class="btn_baordZone">
		   	<a href="javascript:fnObj.regCstPopup();" class="btn_blueblack btn_auth">고객신규등록</a>
		    <!-- <a href="javascript:fnObj.delCst();"  id="aDelCust"  class="btn_witheline btn_auth" >고객삭제</a> -->
		    <a href="javascript:fnObj.chngChrgStaff();" id="aChngChrgStaff" class="btn_blueblack2 btn_auth">담당자변경</a>
		</div>
		<!--버튼영역-->
	</section>
</div>
</form>