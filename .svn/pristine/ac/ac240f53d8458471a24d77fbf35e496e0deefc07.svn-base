<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>
.popcon_uni { border:#cfcfcf solid 1px; padding:10px 15px 40px; }
</style>
<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%>


	<div id="compnay_dinfo">
		<div class="modalWrap2">
			<h1><strong>팝업공지</strong></h1>
			 <div class="mo_container2">
			 	<div class="popalarmWrap">
			 		<h3 class="h3_title_basic">팝업공지</h3>
			 		<%-- <textarea name="pop_content" readonly style="width:98%;margin-left:10px;margin-top:10px;"><c:out value="${alarm.alarmText}" escapeXml="false"/></textarea> --%>
			 		<div class="popcon_uni">${fn:replace(alarm.alarmText, crcn, br)}</div>
			 	</div>
			 </div>

            <!--창닫기-->
		    <div class="todayclosebox">
		        <div class="fl_block"><label><input type="checkbox"  name="check_today" id="check_today"  onclick="closeWin();"/><span>오늘은 그만보기</span></label></div>
		        <div class="fr_block"><button type="button" class="btn_close" onClick="javascript:closeWin();"><span>닫기</span><span>X</span></button></div>
		    </div>

		</div>
	</div>











<script type="text/javascript">
$(function(){
	//팝업 내부 사이즈 초기화
	var window_height = $(window).height() - 100;
	$("textarea[name='pop_content']").css("height",window_height);

	//팝업창 사이즈 변경에 의한 알림창 css 변경
	$(window).resize(function() {
	      resizeContent();
	});
});

function resizeContent(){
	 var window_height = $(window).height() - 100;
	 $("textarea[name='pop_content']").height(window_height);
}

//창 닫기 클릭시 쿠키 처리
function closeWin() {
    if(document.getElementById("check_today").checked){
    	setCookie("cookie_"+"${alarm.alarmId}", "done", 1); // 쿠기 만료일 하루 뒤
     	window.close();
    }else{
       	window.close();
    }
}

//쿠기설정
function setCookie(name, value, expiredays){
	var today = new Date();
	today.setDate( today.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + today.toGMTString() + ";";
}
</script>