<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
$(document).ready(function(){

});
</script>

<ul class="tabZone_st06">
    <li id="liCusType" class="current"><a href="#" onclick="fnObj.clickRdCstType('',this);">전체</a></li>
    <c:forEach var="result" items="${customerTypeList}" varStatus="status">
        <li id="liCusType" ><a href="#"  onClick="fnObj.clickRdCstType('${result.cd}',this);">${result.nm}</a></li>
    </c:forEach>
</ul>



