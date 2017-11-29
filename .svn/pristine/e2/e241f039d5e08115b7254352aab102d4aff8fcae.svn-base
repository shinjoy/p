<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Main</title>
<link href="<c:url value='/css/content.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet" type="text/css">
<script type="text/JavaScript" src="<c:url value='/js/html5.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/jquery.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/process.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/multiFileUpload.js'/>" ></script>
<script>
$(document).ready(function(){
	if( ${upload == 1} ) {
		var rVal = new Object();
		rVal.f = 'files';
		rVal.n = '${MDn}';
		rVal.nm = '${nm}';
		rVal.snb = '${maxSnb}';
		rVal.path = $('#filePath').val();
		rVal.status = $('.status:last').val();
		
		/* rVal.name1 = null, rVal.name2 = null, rVal.name3 = null, rVal.name4 = null, rVal.name5 = null;
		
		rVal.name1 = $('#fileRealNm1').val();
		rVal.name2 = $('#fileRealNm2').val();
		rVal.name3 = $('#fileRealNm3').val();
		rVal.name4 = $('#fileRealNm4').val();
		rVal.name5 = $('#fileRealNm5').val(); */

		if (window.opener) window.opener.returnPopUp(rVal);
		window.close();
	}
	
	if(null != Request("n"  )&&''!=Request("n"  )) $('#num').val(Request('n'  ));
	if(null != Request("day")&&''!=Request("day"))$('#tmDt').val(Request('day'));
	if(null != Request("snb")&&''!=Request("snb")) $('#sNb').val(Request('snb'));
	if(null != Request("report")&&''!=Request("report"))$('#reportYN').val(Request('report'));
	if(null != Request("subSnb")&&''!=Request("subSnb"))$('#subCd').val(Request('subSnb'));
	if(null != Request("nm"    )&&''!=Request("nm"    ))$('#tmN').val(Request('nm'));
});

</script>
<style>.action{padding:10px 10px 5px 10px;}.files{padding-left:10px;}</style>
 <base target="_self">
 
</head>

<body>
	<c:if test="${not empty fileInfList }">
		<c:forEach var="fileS" items="${fileInfList}" varStatus="statusF">
			<input type="hidden" id="fileRealNm${statusF.count }" value="${fileS.realName}">
			<input type="hidden" id="filePath" value="${fileS.path}">
			<input type="hidden" class="status" value="${statusF.count }">
		</c:forEach>
	</c:if>

	<form id="multiFile_N_comment" name="fileNcomment" method="post" action="<c:url value='/work/multiUploadProcess.do' />" enctype="multipart/form-data">
		<input type="hidden" name="tmDt" id="tmDt">
		<input type="hidden" name="sNb" id="sNb">
		<input type="hidden" name="reportYN" id="reportYN">
		<input type="hidden" name="subCd" id="subCd">
		<input type="hidden" name="tmpNum1" id="tmN">
		<input type="hidden" id="num" name="modalNum">
		<input id="files-upload" name="files-upload" type="file" multiple style="display:none;">
	</form>

		<div class="action">
			<a class="btn glass s" onclick="$('#files-upload').click();" style="color:blue;width:60px;font-weight:bold;"><img src="<c:url value='../images/file/fileDisk.png' />" align="absmiddle">File</a>
			<span id="uploadsubmitbtn" style="display:none;"><a class="btn s glass" href="javascript:saveComment('','')">전송</a></span></div>
		<div class="files"><table id="file_list"></table></div>


</body>
</html>