<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">  <%-- SCRIPT --%>
$(document).ready(function(){
	<%--
		***** description *****
		*
		* 권한 설정을 위한 세팅
		*
		* 1. SUPER 무조건 보임
		* 2. VIP,WRITE
		* 3. READ 무조건 히든
		* 4. DOCUMENT READY 함수는 순차적 실행되므로 해당 jsp는 마지막에 로드되야한다.
		***********************
	 --%>

	<!-- ============== 관계사 권한에 따른 세팅 :S ============== -->
	<!-- 1. 다른 관계사를 볼때를 위한 설정 -->
	<c:choose>
		<c:when test="${baseUserLoginInfo.orgBasicAuth eq 'SUPER'}"> <%-- 특별권한 유저설정 위한 설정 --%>
			$(".btn_auth").show();                        /* 버튼 무조건보이기 */
		</c:when>
		<c:when test="${baseUserLoginInfo.orgBasicAuth eq 'READ'}">	<%-- 읽기권한일때 --%>
			$(".btn_auth").hide();                        /* 버튼 숨김 */

			$('.change_direct').attr('disabled', true);				/* 바로바뀌는 이벤트 리스너가 걸려있는 SELECT, INPUT 에 대해 */
		</c:when>
	</c:choose>

	//선택 관계사가 바뀌면 숨기는버튼
	if(g_other_org_yn == "Y"){
		$(".btn_myOrg").hide();
	}
});
<%-- <c:if test="${baseUserLoginInfo.isSynergyYn eq 'N'}">    로그인한 사용자가 다른관계사일때(시너지가 아닐때)
<style>     CSS
.btn_synergy_auth{display:none!important;}                          /* 버튼,화면 숨기기 */
</style>

</c:if> --%>

<!-- 2. 다른 관계사를 볼때, 해당 관계사의 기본 권한('READ'/'WRITE')에 따른 설정 -->
<%-- <c:if test="${baseUserLoginInfo.orgBasicAuth eq 'WRITE' or baseUserLoginInfo.masterKey eq 'MASTER'}">	'WRITE' 권한일때 or  'MASTER' 권한이 있을때
<style>		CSS
.org_basic_auth{display:inline-block!important;}			/* 버튼 보이게 */
</style>
</c:if> --%>


</script>
<!-- ============== 관계사 권한에 따른 세팅 :E ============== -->