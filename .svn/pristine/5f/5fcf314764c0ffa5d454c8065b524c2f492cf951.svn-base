<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="deatailconWrap">

		<div id="spanMsg" style="float:left;text-align:center;display:none;margin:auto;width:100%;">
			<br/><br/><br/><font color="#75c5de">새창으로 열렸습니다</font>
		</div>
	
		<iframe id="mailViewFrame" style="width:100%;height:700px;"></iframe>
	
</div>
<script type='text/javascript'>
$(document).ready(function() {
	var url = '${authUrl}';
		
	// 주소에 http 체크, 없으면 붙여주기
	if( url.indexOf('http') < 0 ){
		url = 'http://' + url;
	}
	
	// 새창 : new, 자창 : child	
	var mode = '${emailLinkType}';
	
	// 익스플로러인 경우 새창으로 띄우기 - 보안이슈
	var agent = navigator.userAgent.toLowerCase();
	if(navigator.userAgent.search('Trident') != -1 || agent.indexOf("msie") != -1) 
		mode = 'new'; 
	
	if( mode == 'child'){
		$('#mailViewFrame').attr('src',url);	
	}
	else{
		window.open(url, "_blank");
		$('#spanMsg').show();	//메세지
	}
	  
	//http://mail.synergynet.co.kr/member/do_login/?domain=synergynet.co.kr&sso=Y&cid=shpark&myvalue=dfd4266f8beba6e8fb044fcc4569f4f3

});
</script>