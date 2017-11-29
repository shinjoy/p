<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <tiles:insertAttribute name="header"/>
</head>
<script type="text/javascript">
/*
    function getSessionStorage(){
        var id = window.sessionStorage['loginId'];
        if(typeof(id) =="undefined"){
            //alert('정상적인 접근 경로가 아닙니다.');
            //location.href='<%=response.encodeURL(request.getContextPath())%>/view/common/login.html';
        }
    }

    getSessionStorage();
*/
</script>
<body>
<div id="skipNavigation">
	<p><a href="#detail_contents">메뉴 건너뛰기</a></p>
</div>
<hr />

<div id="wrap">	

	<tiles:insertAttribute name="topMenu"/>
	
	<div id="container">
	
		<%-- <tiles:insertAttribute name="leftMenu"/> --%>
		
		<div id="contentsWrap">
            <div class="contents_n">

				<tiles:insertAttribute name="content"/>

			</div>
			
			<tiles:insertAttribute name="footer"/>
			
		</div>
	</div>
</div>
</body>
<tiles:insertAttribute name="authStyle"/>
</html>
