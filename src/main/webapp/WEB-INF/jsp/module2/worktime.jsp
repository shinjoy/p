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
<!--조직도/근태현황-->
<div class="org_attenWrap">
	<div class="labelsetLine">
		<h3><strong>조직도/근태현황</strong><a href="#" class="rdmore_btn"><em>더보기</em></a></h3>
	</div>
	<div class="tnavi_title">
		<select class="select_b">
			<option selected="">시너지</option>
			<option>휴버트바이오</option>
			<option>(주)시너지이노베이션</option>
			<option>(주)엠아이텍</option>
			<option>(주)넥스페이</option>
			<option>에이엠테크놀로지(주)</option>
			<option>인트로바이오파마</option>
		</select>
		<button type="button" class="btn_grMgmt" id="groupMgmtButton" style="display:none" onclick="javascript:processUserGroupInfo()">그룹관리</button>
	</div>
	<div class="module_tabList">
		<ul>
			<li class="current">부서별</li>
			<li>직원별</li>
			<li>직급별</li>
			<li>근태현황</li>
		</ul>
	</div>
	<div class="tnavi_treezone">
		<img src="${pageContext.request.contextPath}/images/main/@imsi09.png">
	</div>
</div>
<!--//조직도/근태현황//-->
