<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>


function projectViewLinkPage(pageNo){

	$("#pageIndex").val(pageNo);
	
	var url = contextRoot+"/project/viewProjectHistoryListAjax.do"
	
	var param = {
			pageIndex : pageNo,
			projectId : "${projectId}"
	};
	
	var callback = function(result){
		
		$("#listArea").html(result);
		parent.myModal2.resize();
	};
	
	commonAjax("POST", url, param, callback);

}




</script>
