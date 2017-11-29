<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<div id="IB_Snb">
	<c:choose>
	
		<c:when test="${(leftMenuStr eq 'userRuleInfo') or (leftMenuStr eq 'userProcessInfo')}">
			<p class="Snb_title">약관 및 방침</p>
		    <ul class="Snb_List">
		    	<li class="${leftMenuStr eq 'userRuleInfo' ? 'current':'' }"><a href="${pageContext.request.contextPath}/mypersonnel/userRuleInfo.do">이용약관</a></li>
		    	<li class="${leftMenuStr eq 'userProcessInfo' ? 'current':'' }"><a href="${pageContext.request.contextPath}/mypersonnel/userProcessInfo.do" >개인정보처리방침</a></li>
		    </ul>
		</c:when>
		
		<c:otherwise>
			<p class="Snb_title">My Page</p>
		    <ul class="Snb_List">
		    	<li class="${leftMenuStr eq 'myPageMain' ? 'current':'' }"><a href="${pageContext.request.contextPath}/mypersonnel/myPageMain.do">마이페이지</a></li>
		    	
		    	<c:if test="${baseUserLoginInfo.mailUseYn ne 'N' }">
		    	<li class="${leftMenuStr eq 'emailLinkSetup' || leftMenuStr eq 'emailLinkView'? 'current':'open_mn'}">
		    		<a href="#" onclick="javascript:menuFoldIt(this);">메일</a>    	
		    		<ul class="Snb_de_List">
		       			<li class="${leftMenuStr eq 'emailLinkView' ? 'current':''}"><a id="mailMenuUrl" href="${pageContext.request.contextPath}/email/emailView.do">메일</a></li>
		       			<li class="${leftMenuStr eq 'emailLinkSetup' ? 'current':''}"><a id="mailMenuUrl" href="${pageContext.request.contextPath}/email/emailLinkSetup.do">계정설정</a></li>
		   			</ul>
		   		</li>
		   		</c:if>
		    	
		    	<c:if test="${baseUserLoginInfo.orgId eq baseUserLoginInfo.applyOrgId }">
		    		<li class="${leftMenuStr eq 'changePass' ? 'current':'' }"><a href="${pageContext.request.contextPath}/login/modifyUsrInfo.do">비밀번호 변경</a></li>
		    	</c:if>
		        
		        <li class="${leftMenuStr eq 'bookmark' ? 'current':'' }"><a href="${pageContext.request.contextPath}/basic/bookMarkList.do" >메뉴 바로가기</a></li>
		        
		        <c:if test="${baseUserLoginInfo.orgId eq baseUserLoginInfo.applyOrgId }">
			        <li class="${leftMenuStr eq 'attendanceInfo' ? 'current':'' }"><a href="${pageContext.request.contextPath}/worktime/user/attendanceInfo.do">근태정보</a></li>
			        <li class="${leftMenuStr eq 'myPersonnelInfo' ? 'current':'' }"><a href="${pageContext.request.contextPath}/mypersonnel/getMyPersonnelInfo.do">인사정보</a></li>
		        </c:if>
		    </ul>
		</c:otherwise>
	</c:choose>

	
</div>




<script>

function menuFoldIt(obj){
	var p = $(obj).parent();
	if($(p).attr('class') == 'open_mn'){	//열려있는 상태이면
		$(p).children('ul').hide();
		$(p).attr('class', 'close_mn');
	}else if($(p).attr('class') == 'close_mn'){	//열려있는 상태이면
		$(p).children('ul').show();
		$(p).attr('class', 'open_mn');
	}
	}

$(function() {
	 //alert('${leftMenuStr}');
});
	
</script>