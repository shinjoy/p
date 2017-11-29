<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
pageContext.setAttribute("cr", "\r");
pageContext.setAttribute("cn", "\n");
pageContext.setAttribute("crcn", "\r\n");
pageContext.setAttribute("sp", "&nbsp;");
pageContext.setAttribute("br", "<br/>");
%>
<c:forEach items="${projectStatusList }" var = "data" varStatus="i">
	<!--개인업무st-->
	<script type="text/javascript">
		makeFileArea("${data.type }","${data.keyId }","${data.name}","${data.rankNm}","${data.activityNm }","${data.startDate }","${data.fileUploadId}");
	</script>
	<!--//개인업무st//-->
</c:forEach>
<c:if test="${fn:length(projectStatusList)<=0 }">
<dd class="pro_historyList">
	<div class="nocontents">조회된 파일이 없습니다.</div>
</dd>
</c:if>
</div>
