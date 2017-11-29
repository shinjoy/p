<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>회사리스트 | 회사 | 네트워크 | PASS (Project based Activity analysis and Sharing system)</title>
<meta name="copyright" content="COPYRIGHT@ Synergy Group" />
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" type="text/css" href="/css/style.css"/>
<script type="text/JavaScript" src="/js/jquery-1.11.1.min.js"></script>
<script type="text/JavaScript" src="/js/base.js"></script>
    <!--html5새로생성된 태그가 IE6~8에서 적용되게 하는 js파일-->
    <!--[if lt IE 9]>
            <script src="/js/html5shiv.js" ></script>
    <![endif]-->

    <!--미디어쿼리가 IE6~8에서 적용되게 하는 js파일-->
    <!--[if lt IE 9]>
            <script src="/js/respond.min.js" ></script>
    <![endif]-->
    <!-- Load jQuery Here -->
    <!--[if lt IE 9]>
            <script src="//ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js"></script>
            <script src="//ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js"></script>
            <script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
<script type="text/javascript">
function selectStaff(){
	var value = $("#staffList").val();
	var valueBuf = value.split("_")
	opener.openSelectUserPopCallback(valueBuf[2],valueBuf[1],valueBuf[0]);
	window.close();
}
</script>
</head>
<body>
	<div id="compnay_dinfo">
		<div class="modalWrap2">
			<h1><strong>회사소개</strong></h1>
			<!--tab-->
			<!-- <div class="gtabZone">
				<ul>
					<li class="on"><a href="/network/pop_employee_tree.jsp">트리구조</a></li>
					<li><a href="/network/pop_employee_array.jsp">전체나열</a></li>
				</ul>
			</div>
			//tab//
			<div class="mo_container">
				<img src="../images/common/@treemenu.png">

				<div class="btnZoneBox"><a href="#" class="p_blueblack_btn"><strong>신규입력하기</strong></a><a href="#" class="p_withelin_btn">취소</a></div>
				//검색결과有//
			</div> -->
			<select id = "staffList" style="width: 200px" onchange="selectStaff()">
				<c:forEach items="${staffList }" var = "data">
						<option value="${data.userId }_대리_${data.userName }">${data.userName }</option>
				</c:forEach>
			</select>
		</div>
		<!--//회사상세보기(회사정보)//-->
	</div>
</body>
</html>
