<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

 <!--  	
  	 /**
	 *  프로젝트 수정이력 팝업
	 *
	 * @param		:
	 * @return		:
	 * @exception	:
	 * @author		: sjy
	 * @date		: 2017. 10. 17.
	 */
-->

<jsp:include page="../js/viewProjectHistoryList_JS.jsp"></jsp:include>

<div class="mo_container">
	<div class="mgb5">
		<span style="letter-spacing: 1px;"><strong>${baseUserLoginInfo.projectTitle}명 : </strong>${projectInfoMap.name}(${projectInfoMap.createNm} ${projectInfoMap.position} PM)</span>
	</div>
	<div id = "listArea">
		<jsp:include page="../include/viewProjectHistoryList_INC.jsp"></jsp:include>
	</div>
	
	<!--버튼영역-->
	<div class="btn_baordZone">
		<a href="javascript:parent.myModal2.close()" class="btn_witheline btn_auth">닫기</a>
	</div>
</div>

<!--//버튼영역//-->
