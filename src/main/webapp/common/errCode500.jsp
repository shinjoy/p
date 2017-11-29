<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PASS</title>

<script language="javascript">
function fncGoAfterErrorPage(){
    history.back(-2);
}
</script>
<style>
*{font-family: 맑은 고딕, Trebuchet MS, Verdana, Geneva, sans-serif;}
ul{list-style-type:none;color: #6D625C;}
li{font-weight:bold;}
.title{font-size: 50px;}
.imp{color:#FB7176 !important;}
.cent{text-align:center;}
</style>
</head>
<body>
	<ul>
		<li class="title cent"><span class="imp">500</span> Internal Server Error</li>
		<li class="cent">페이지를 표시할 수 없습니다.</li>
		<li class="cent">시스템 운용 중 뜻하지 않은 오류가 발생되었습니다.</li>
		<li class="cent">다시한번 확인해 보시고 문제가 반복 된다면 연락주세요.</li>
	</ul>
	<a href="javascript:fncGoAfterErrorPage();">이전 페이지로 이동</a>
</body>
</html>
