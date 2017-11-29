<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@ include file="./js/transferUserList_JS.jsp"%>

 <!--
  	 /**
	 *  인수인계자 설정 리스트 화면
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 12.
	 */
-->

<script type="text/javascript" defer="defer">



	$(document).ready(function(){

	});





</script>

<section id="detail_contents">
	<div class="mo_container">

		<!-- 검색영역 -->
		<div class="carSearchBox">
			<label>
				<span class="carSearchtitle">관계사</span>

				<select id="selectOrgId" name="selectOrgId" onChange="linkPage();" ${fn:length(orgList) <= 1 ? 'style="display:none;"' : '' }  class="select_b" title="관계사 선택">
					<c:forEach items="${orgList}" var="data">
						<option value="${data.orgId}"  targetAuth = "${data.orgAccessAuthType }"
							${data.orgId == baseUserLoginInfo.applyOrgId ? "selected=selected" : ""}>${data.orgNm}</option>
					</c:forEach>
				</select>

				<c:if test="${fn:length(orgList) <= 1 }">
					<span>${baseUserLoginInfo.orgNm}</span>
				</c:if>
			</label>

			<input id="searchText" type="text" placeholder="검색어입력" onkeypress="if(event.keyCode==13) linkPage();" class="input_b2 w200px mgl10" title="관계사 코드 검색" /><a href="javascript:linkPage();" class="btn_g_black mgl10"><em>검색</em></a>
		</div>
		<!-- //검색영역// -->

		<div class="sys_p_noti mgt20 mgb10"><span class="icon_noti"></span><span>인수자로 설정된 직원은</span> <span class="pointB">${baseUserLoginInfo.projectTitle}>업무현황 메뉴</span><span>를 통해 인계자가 작성한 업무일지/일정/전자결재 열람이 가능해집니다. </span></div>

		<div id="tableListArea">
			<jsp:include page="./include/transfer_userList_INC.jsp"></jsp:include>
		</div>

		<div class="btnZoneBox">
			<a href="javascript:openCreateTransferUserPop();" class="p_blueblack_btn btn_auth"><strong>인수인계자 설정</strong></a>
		</div>
	</div>
</section>
