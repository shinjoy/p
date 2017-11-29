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
	//출근
	function procWork(){
		if("${todayWorkInfo.workType}" == "NO_WORK"){
			alert("[결근]상태일때는 출근처리할수 없습니다.");
			return;
		}
		if("${todayWorkInfo.inTime}" != ""){
			//alert("이미 출근처리 되었습니다.");
			return;
		}
		var url = contextRoot + "/mypersonnel/processWorcAjax.do";
    	/*=========== 첨부파일 : E =========== */
    	var loginLoc = mobileCheckMain();

    	var param = {

    			loginLoc : loginLoc
    	}
    	var callbackProcWork = function(data){
    		data = JSON.parse(data);
    		if(data.resultObject.result =="SUCCESS"){
        		alert("출근처리되었습니다.");

        		location.href = contextRoot + '/basic/mainLogo.do';
    		}else{
    			if(data.resultObject.msg != null){
        			alert(data.resultObject.msg);
        			return;
        		}
    		}
    	};
    	commonAjax('POST', url, param, callbackProcWork);
	}

	//퇴근
	function procWorkEnd(){
		if("${todayWorkInfo.workType}" == "NO_WORK"){
			alert("[결근]상태일때는 퇴근처리할수 없습니다.");
			return;
		}
		var url = contextRoot + "/mypersonnel/processWorcEndAjax.do";
    	/*=========== 첨부파일 : E =========== */


    	var loginLoc = mobileCheckMain();

    	var param = {

    			loginLoc : loginLoc
    	}
    	var callbackProcWorkEnd = function(data){
    		data = JSON.parse(data);
    		if(data.resultObject.result =="SUCCESS"){
        		alert("퇴근처리되었습니다.");

        		location.href = contextRoot + '/basic/mainLogo.do';
    		}else{
    			if(data.resultObject.msg != null){
        			//alert(data.resultObject.msg);
        			return;
        		}
    		}


    	};
    	commonAjax('POST', url, param, callbackProcWorkEnd);
	}
	//임시방편
	function mobileCheckMain(){
		var filter = "win16|win32|win64|mac";

		var loginLoc = "";
		if(navigator.platform){
			if(0 > filter.indexOf(navigator.platform.toLowerCase())){
				loginLoc = "MOBILE";
			}else{
				loginLoc = "PC";
			}
		}
		return loginLoc;
	}
</script>
<jsp:useBean id="now" class="java.util.Date" />

<li class="ui-state-default notDraggable">
	<!--마이체크리스트-->
	<div class="MycheckBox">
		<h3>My Check List</h3>
		<div class="useinfoBox">
			<span class="user_name">${baseUserLoginInfo.userName }</span>
			<span class="position">(${baseUserLoginInfo.rankNm })</span>
			<span class="team_name">${baseUserLoginInfo.deptNm }</span>
			<button type="button" class="btn_logout" onclick="logout();">로그아웃</button>
		</div>
		<c:if test="${baseUserLoginInfo.orgId eq baseUserLoginInfo.applyOrgId and attendCount>0 }"><!--  and checkLogin eq true -->
			<div class="selectDayBox">
				<button type="button" class="btn_pre"><em>이전날</em></button>
				<span><fmt:formatDate value="${now}" pattern="yyyy.MM.dd" /></span><em>(<fmt:formatDate value="${now}" pattern="E" />)</em>
				<button type="button" class="btn_next"><em>다음날</em></button>
			</div>
			<div class="attendanceBox">
				<c:if test="${checkLogin eq true}">
					<button type="button" class="btn_attendance" onclick="procWork()">출근</button>
				</c:if>
				<span><fmt:formatDate value="${todayWorkInfo.inTime}" type="both" pattern="HH:mm"/></span>
				<c:if test="${todayWorkInfo.inTime ne null}">
					<c:choose>
						<c:when test="${todayWorkInfo.workType eq 'WORK' or todayWorkInfo.workType eq 'HOLIDAY'}"><em>(정상)</em></c:when>
						<c:when test="${todayWorkInfo.workType eq 'LATE' }"><em>(지각)</em></c:when>
						<c:when test="${todayWorkInfo.workType eq 'NO_WORK' }"><em>(결근)</em></c:when>
					</c:choose>
					<button type="button" class="btn_work_off" onclick="procWorkEnd()">퇴근</button>
					<c:if test="${todayWorkInfo.outTime ne null}">
						<span><fmt:formatDate value="${todayWorkInfo.outTime}" type="both" pattern="HH:mm"/></span>
					</c:if>
				</c:if>

			</div>
		</c:if>
		<p class="ipaddress">IP :<%= request.getRemoteAddr() %></p>
		<div class="mypageMnBox">
			<c:if test="${fn:contains(menuFilterStr,'approve/approveProduct') }">
				<dl class="mypageMnList">
					<dt class="icon_work"><a href="javascript:mainleftMenuObj.movePage('approveWorking')">전자결재</a></dt>
					<dd>
						<ul>
							<li class="notDraggable" style="cursor: pointer;" onclick="mainleftMenuObj.movePage('approveWorking')">
								<strong class="catename">받은결재 :</strong><span class="sub_catename">미결</span><em class="count">${approveReqCnt }</em>
							</li>
							<li class="notDraggable" style="cursor: pointer;" onclick="mainleftMenuObj.movePage('approveReq')">
								<span class="fl_block">
									<strong class="catename">보낸결재 :</strong>
									<span class="sub_catename">진행</span>
									<em class="count newup">
										${approveWorkingCnt>99?'99+':approveWorkingCnt }
									</em>
								</span>
								<span class="fr_block">
									<span class="sub_catename">종결</span>
									<em class="count newup">${approveEndCnt>99?'99+':approveEndCnt }</em>
								</span>
							</li>
						</ul>
					</dd>
				</dl>
			</c:if>
			<c:if test="${fn:contains(menuFilterStr,'card/cardIndex') }">
			<dl class="mypageMnList">
				<dt class="icon_work"><a href="javascript:mainleftMenuObj.movePage('cardIndex')">지출등록</a></dt>
				<dd>
					<p class="cateall_tt">[My 지출등록현황]</p>
					<ul>
						<c:if test="${orgCardLinkYn eq 'Y' }">
							<li class="notDraggable" style="cursor: pointer;" onclick="mainleftMenuObj.movePage('cardIndex')"><strong class="catename">미등록건 :</strong><em class="count">${cardCorpUserCnt }</em></li>
						</c:if>
						<li class="notDraggable" style="cursor: pointer;" onclick="mainleftMenuObj.movePage('cardIndex')">
							<c:forEach items="${userCardApproveYnList }" var="data">
								<c:choose>
									<c:when test="${data.approveYn eq 'Y' }">
										<span class="fl_block"><strong class="catename">승인여부 :</strong><span class="sub_catename">승인</span><em class="count">${data.cnt }</em></span>
									</c:when>
									<c:when test="${data.approveYn eq 'N' }">
										<span class="fr_block"><span class="sub_catename">미승인</span><em class="count">${data.cnt }</em></span>
									</c:when>
								</c:choose>
							</c:forEach>
							<c:if test="${fn:length(userCardApproveYnList)<=0 }">
								<span class="fl_block"><strong class="catename">승인여부 :</strong><span class="sub_catename">승인</span><em class="count">0</em></span>
								<span class="fr_block"><span class="sub_catename">미승인</span><em class="count">0</em></span>
							</c:if>
						</li>
					</ul>
					<c:if test="${staffYn eq 'Y' }">
						<p class="cateall_tt">[전체 지출등록현황]</p>
						<ul>
							<c:forEach items="${orgCardApproveYnList }" var="data">
								<c:if test="${data.approveYn eq 'Y' }">
									<li class="notDraggable" style="cursor: pointer;" onclick="mainleftMenuObj.movePage('cardIndex')"><strong class="catename">승인대기 :</strong><em class="count">${data.cnt }</em></li>
								</c:if>
							</c:forEach>
							<c:if test="${fn:length(orgCardApproveYnList)<=0 }">
								<li class="notDraggable" style="cursor: pointer;" onclick="mainleftMenuObj.movePage('cardIndex')"><strong class="catename">승인대기 :</strong><em class="count">0</em></li>
							</c:if>
							<c:if test="${orgCardLinkYn eq 'Y' }">
								<li class="notDraggable" style="cursor: pointer;" onclick="mainleftMenuObj.movePage('cardIndex')">
									<span class="fl_block"><strong class="catename">미등록건 :</strong><em class="count">${cardCorpCnt }</em></span>
									<span class="fr_block"><strong class="catename">장기미등록건 :</strong><em class="count">${cardCorpLongCnt }</em></span>
								</li>
							</c:if>
						</ul>
					</c:if>
				</dd>
			</dl>
			</c:if>
			<dl class="mypageMnList">
				<dt class="icon_info"><a href="${pageContext.request.contextPath}/work/workDairy.jsp">사내<br>게시판</a></dt>
				<dd>
					<ul>
						<li class="notDraggable"><strong class="catename">미열람 게시글 :</strong><em class="count newup">99+</em></li>
						<li class="notDraggable"><strong class="catename">미열람 덧글 :</strong><em class="count">0</em></li>
					</ul>
				</dd>
			</dl>
			<dl class="mypageMnList">
				<dt class="icon_info"><a href="${pageContext.request.contextPath}/work/workDairy.jsp">공지<br>게시판</a></dt>
				<dd>
					<ul>
						<li class="notDraggable"><strong class="catename">미열람 공지글 :</strong><em class="count newup">99+</em></li>
						<li class="notDraggable"><strong class="catename">미열람 덧글 :</strong><em class="count">0</em></li>
					</ul>
				</dd>
			</dl>
			<dl class="mypageMnList">
				<dt class="icon_approve"><a href="${pageContext.request.contextPath}/work/workDairy.jsp">영업정보</a></dt>
				<dd>
					<ul>
						<li class="notDraggable"><strong class="catename">미열람 영업정보 :</strong><em class="count newup">99+</em></li>
						<li class="notDraggable"><strong class="catename">미열람 코멘트 :</strong><em class="count">15</em></li>
					</ul>
				</dd>
			</dl>
			<dl class="mypageMnList">
				<dt class="icon_memo"><a href="${pageContext.request.contextPath}/work/workDairy.jsp">업무구분</a></dt>
				<dd>
					<ul>
						<li class="notDraggable"><strong class="catename">마감된 업무구분 :</strong><em class="count">0</em></li>
						<li class="notDraggable"><strong class="catename">마감예정 업무구분 :</strong><em class="count">0</em></li>
					</ul>
					<ul>
						<li class="notDraggable"><strong class="catename">마감된 업무구분 :</strong><em class="count">0</em></li>
						<li class="notDraggable"><strong class="catename">마감예정 업무구분 :</strong><em class="count">0</em></li>
					</ul>
				</dd>
			</dl>
		</div>
	</div>
	<!--//마이체크리스트//-->
</li>
