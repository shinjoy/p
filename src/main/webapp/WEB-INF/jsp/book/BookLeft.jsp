<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Left</title>
<link href="<c:url value='/css/leftMenu.css'/>" rel="stylesheet" type="text/css">
<script type="text/JavaScript" src="<c:url value='/js/html5.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/jquery.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/process.min.js'/>" ></script>
<script>
$(document).ready(function(){
//	$("li:even").css("background-color", "#E0F8F7");
});
</script>
</head>
<body>
	<form id="staffName" name="cName" method="post" action="<c:url value='/selfImprovement/index.do' />">
		<input type="hidden" id="s_Id" name="usrId">
	</form>
	
	<section>
		<div id="menubody">
		<!-- <ul style="height:40px;"></ul> -->
		<ul class="dual">
			<li class="leftTitle">직원별</li>
			<li>
				<a onclick="sortUser(this,'','');">전체</a>
			</li><li>
				<c:forEach var="staff" items="${userList}" varStatus="status">
					<a onclick="sortUser(this,'${staff.usrNm}','${staff.usrId}');">${staff.usrNm}</a>
					<c:if test="${(status.count)%2 == 0}"></li><li></c:if>
				</c:forEach>
			</li>			
		</ul>
		</div>
	</section>
</div>
</body>
</html>