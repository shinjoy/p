<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<jsp:scriptlet>
		pageContext.setAttribute("cr", "\r");
		pageContext.setAttribute("lf", "\n");
		pageContext.setAttribute("crlf", "\r\n");
	</jsp:scriptlet>

<link href="<c:url value='/css/memo.css'/>" rel="stylesheet" type="text/css">

<form id="downName" name="downName" action="<c:url value='/work/downloadProcess.do' />" method="post">
	<input type="hidden" name="makeName" id="makeName"/>
	<input type="hidden" name="recordCountPerPage" value="0"/>
</form>
<%-- <script type="text/JavaScript" src="<c:url value='/js/jquery-ui.js'/>" ></script> --%>
<script>
$("#closeTab").mousedown(function(){
	$("#offerPr").draggable();
});

function resizeTextarea(th){
	var obj=$(th);
	obj.css('height','1px');
	obj.css('height',(th.scrollHeight)+'px');
}
</script>
<!-- 메모 -->
	<div class="popUpMenu title_area" id="offerPr" style="display:block;width:485px;">
		<input type="hidden" id="memoSndName">
		<%--<p class="closePopUpMenu" name="textR" title="닫기" onclick="javascript:if(typeof(closePopUpMenu)=='function') closePopUpMenu(this);">ⅹ닫기</p>--%>
		<p id="closeTab" name="textR"><span class="closePopUpMenu" onclick="javascript:if(typeof(closePopUpMenu)=='function') closePopUpMenu(this);" title="닫기">ⅹ닫기</span></p>
		<div style="clear:both;height:5px;"></div>
		<div class="M_basicInfoR">나<br/>
			<span style="margin:3px;" class="btn s green" onclick="sndMemo_btnOk(this)"><a>메모</a></span>
			<!-- <span style="margin:3px;" class="btn s green" onclick="memo_btnOk(this)"><a>메모,문자</a></span> -->
			<div style="padding:1px;border-radius:5px;border:1px solid gray;margin:5px 0px;">
				중요도<br/>
				<select id="importance">
					<option value="0">-</option>
					<option value="1">하</option>
					<option value="2">중</option>
					<option value="3">상</option>
				</select>
			</div>
			<div style="padding:1px;border-radius:5px;border:1px solid gray;">
				비밀<br/>여부<br/>
				<select id="priv">
					<option value="N">N</option>
					<option value="Y">Y</option>
				</select>
			</div>
		</div>
		<div class="triRn">&nbsp;</div>
		<div class="M_comRinTAn"><div><textarea id="memoarea0" placeholder="메모를 입력하세요."></textarea></div></div>
		<div style="clear:both;height:5px;"></div>
	</div>
<!-- 메모 -->

