<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="customTagUi" uri="/WEB-INF/tlds/ui.tld"%>
<customTagUi:useConstants var="Constants" className="ib.common.constants.Constants" />
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<!DOCTYPE html>
<head>
<html lang="ko">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<!-- <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, height=device-height"> -->
<%--
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
--%>
<title>PASS</title>
<%-- <meta property="og:url" content="${pageContext.request.contextPath}"> --%>
<meta property="og:title" content="나의 업무관리 시스템 PASS">
<meta property="og:image" content="${pageContext.request.contextPath}/images/og_pass_11.png">
<meta property="og:description" content="회사 업무관리 시스템 PASS를 통해 업무 효율성을 높이세요.">

<meta name="keywords" content="PASS, 업무파트너, 업무관리시스템, 스케쥴관리, 업무관리, 인사관리, 팀업무관리, 영업관리, 정보관리, 네트워크, 내부인트라넷, 그룹웨어, 지출관리, 지출통계, Project, Activity" />
<meta name="description" content="PASS : Project based Activity Analysis " />
<meta name="author" content="admin@synergynet.co.kr" />
<meta name="copyright" content="COPYRIGHT@ Synergy. All Rights Reserved." />

<link href="<c:url value='/css/new_ib.css'/>" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/content.css'/>" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/images/pass.ico" rel="shortcut icon" type="image/x-icon">		<!-- icon -->
<script type="text/JavaScript" src="<c:url value='/js/html5.js'/>"></script>
<script type="text/JavaScript" src="<c:url value='/js/jquery.min.js'/>" ></script>
<script type="text/JavaScript" src="<c:url value='/js/placeholders.min.js'/>"></script>
<script>var contextRoot="${pageContext.request.contextPath}";</script>
<script type="text/JavaScript" src="<c:url value='/js/sys/utils.js?version=${Constants.DELPOYEE_DATE_VERSION}'/>" ></script><!-- 20160108 -->
<script type="text/JavaScript" src="<c:url value='/js/common.js?version=${Constants.DELPOYEE_DATE_VERSION}'/>"></script><!-- jquery , ajaxRequest, etc -->

<!-- -------------- axisj source include (JS, CSS) :S -------------- -->
<%@ include file="/includeAxisj.jsp" %>
<!-- -------------- axisj source include (JS, CSS) :E -------------- -->

<script>
g_other_org_yn = "N";
$(document).ready(function(){
	var mobileKeyWords = new Array('iPhone', 'iPod', 'BlackBerry', 'Android', 'Windows CE', 'LG', 'MOT', 'SAMSUNG', 'SonyEricsson');
	for (var word in mobileKeyWords){
	    if (navigator.userAgent.indexOf(mobileKeyWords[word]) != -1){
	    	<c:if test="${baseUserLoginInfo == null}">
	        $("#loginCheckBox").css("min-width","100%");
	        $("#loginCheckBox").css("min-width","100%");
	        </c:if>

	        break;
        }else{
	        $("#loginCheckBox").css("min-width","1126px");
	        // $("#main").css("min-width","560px");
	        //$("#mainTopMenu").css("width","70%");
	        $("#loginOut span").css("display","");
        }
	}
	if($(window).width()<1010){
		widthAuto();
		//$("#main").css("min-width","1126px");
	}


	jQuery(function () {
	    if (!("placeholder" in document.createElement("input"))) {
	        jQuery(":input[placeholder]").each(function () {
	            var $this = jQuery(this);
	            var pos = $this.offset();
	            if (!this.id) this.id = "jQueryVirtual_" + this.name;

	        }).focus(function () {
	            var $this = jQuery(this);
	            $this.addClass("focusbox");
	            jQuery("#jQueryVirtual_label_" + $this.attr("id")).hide();
	        }).blur(function () {
	            var $this = jQuery(this);
	            $this.removeClass("focusbox");
	            if(!jQuery.trim($this.val()))
	                jQuery("#jQueryVirtual_label_" + $this.attr("id")).show();
	            else jQuery("#jQueryVirtual_label_" + $this.attr("id")).hide();
	        }).trigger("blur");
	    }
	if('<c:out value='${idCnt}'/>' == 0 && '<c:out value='${idCnt}'/>' != '') {
		alert("ID를 확인하세요.");
		document.getElementById('usrId').focus();

	}else if('<c:out value='${passCnt}'/>' == 0 && '<c:out value='${passCnt}'/>' != '') {
		alert("PASSWORD를 잘못입력하셨습니다.");
		document.getElementById('usrPw').focus();

	}
	});

	$('#ckbx').click(function(){
		 var isRemember;
		 var checkbox = $(this);

		 if(checkbox.attr('checked'))
		 {
			 isRemember = confirm("이 PC에 로그인 정보를 저장하시겠습니까? PC방등의 공공장소에서는 개인정보가 유출될 수 있으니 주의해주십시오.");
			 if(!isRemember)
				 checkbox.attr('checked',false);
		 }
	});
	$("#usrId").focus();
});

function widthAuto(w){
	if(w!='' && parseInt(w) > 0){
		$("#loginCheckBox").css("min-width",w);
	}else{
		$("#loginCheckBox").css("min-width","100%");
	}

	$("#loginCheckBox").css("min-width","");
	$("#loginCheckBox").css("background-color","white");
}

function getTodayTime(){
	var today = new Date();

	var h=today.getHours();
	//if(h>12){h-=12;ap='PM';}else{ap='AM';}
	var m=today.getMinutes();
	//var s=today.getSeconds();

	if(h===6){
		if(m===30){
			setTimeout("window.location.reload()",1*60*1000);
		}
		setTimeout("getTodayTime()", 1*60*1000);
	}else{
		setTimeout("getTodayTime()", 40*60*1000);
	}
}
getTodayTime();

function reloadpage(){
	location.reload();
	location.href ="<c:url value='/index.do' />";
}

function setsave(name, value, expiredays){
	var today = new Date();
	today.setDate( today.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + today.toGMTString() + ";";
}

function saveLogin(id){
	if(id != ""){
		// userid 쿠키에 id 값을 7일간 저장
		setsave("passuserid", id, 7);
	}else{
		// userid 쿠키 삭제
		setsave("passuserid", id, -1);
	}
}

function getLogin(){
	// userid 쿠키에서 id 값을 가져온다.
	var cook = document.cookie + ";";
	var idx = cook.indexOf("passuserid", 0);
	var val = "";
	if(idx != -1){
		cook = cook.substring(idx, cook.length);
		begin = cook.split("=");
		end = begin[1].indexOf(";");
		val = unescape( begin[1].substring(0, end));
	}
	// 가져온 쿠키값이 있으면
	if(val != ""){
		$('#usrId').val(val);
	  	$('#ckbx').attr('checked',true);
	  	$('#usrPw').focus();
	}
}

function submit0(){
	if($('#ckbx').attr('checked')) saveLogin($('#usrId').val());
	else saveLogin("");

	document.getElementById('companyName').submit();
}

function dispLeft(){
	return $('#left').css('display');
}

//로긴
function doLogin(){
	var frm = document.companyName;

	var url = contextRoot + "/loginProcess.do";

	var loginLoc = contactDeviceChk();


	var param = {
			ip:			frm.ip.value,
			loginDt:	frm.loginDt.value,
			usrId:		frm.usrId.value,
			usrPw:		frm.usrPw.value,
			loginLoc: loginLoc
	}

	var callback = function(result){

		var obj = JSON.parse(result);

		var cnt = obj.resultVal;		//결과수
		var rObj = obj.resultObject;	//결과데이터JSON

        //2016.12.29. 이인희 시스템 사용여부가 'N'이면 로그인 비허용함
        if(rObj.systemYn == "N"){
            alert("시스템 접속 권한이 없습니다. 담당자에게 문의 하십시요.");
            return;
        }

        //2017.01.03. 이인희 사용여부 'N' 또는 유효여부 'N' 이면 접속불가
        if(rObj.checkUseYn == "N"){
            alert("로그인에 실패하였습니다. 담당자에게 문의하세요.");
            return;
        }

        //2017.03.15. 등록된 도메인으로 접속하지 않을시 접속불가
        if(rObj.domainYn == "N"){
            alert("등록된 도메인으로만 접속하실 수 있습니다. 담당자에게 문의하세요.");
            return;
        }

        if(result.length == 0){
            alert("로그인에 실패하였습니다. 아이디 또는 패스워드를 확인하세요.");
            return;
        }


		if(rObj.loginId == '' ){
			alert("로그인에 실패하였습니다. 아이디 또는 패스워드를 확인하세요.");
			return;
		}


		//localStorage 에 메뉴객체저장
		window.localStorage['menuTop'] = JSON.stringify(rObj.menu);							//■■■■■■ 메뉴정보 ■■■■■■

		//localStorage 에 접근 가능한 관계사 리스트 저장
		window.localStorage['accessOrgIdList'] = JSON.stringify(rObj.accessOrgIdList);		//■■■■■■ 접근 가능한 관계사 리스트 ■■■■■■

		//localStorage 에 헤더 부분 조직도 신규등록 여부 정보 저장
		window.localStorage['orgNewYn'] =  rObj.orgNewYn;

		/////////// main page go //////////

		//모달에서 로그인을 하는 경우
		var axmodal = parent.document.getElementsByClassName("AXModalBox");
		if(axmodal != null && axmodal.length > 0){
			var modal = $(axmodal).attr("id"); //modal의 ID를 가져옴
			for(key in parent){
				if(parent.hasOwnProperty(key)){
					var item = parent[key];
					if(typeof item !== 'function'){
					    if(item != null && item != ''){
						    for(k in item){
						    	var value = k;
						    	if(value == "config"){
						    		var val = item[value];
						    		if(val.windowID == modal){
						    			parent[key].close();
						    		}
						    	}
						    }
					    }
				    }
				}
			}

			return;

		}else{
			//일반 팝업일때 로그인후 닫아준다.
			if(opener){
				window.close();
			}
		}

		if($('#ckbx').attr('checked')) saveLogin($('#usrId').val());
	    else saveLogin("");

		document.location.href = contextRoot;		//main

	};

	var failcallback = function(){
		alert("로그인에 실패하였습니다. 아이디 또는 패스워드를 확인하세요.");
	};

	commonAjaxForFail("POST", url, param, callback, failcallback);
}

</script>
</head>
<body onLoad="getLogin()"  id="loginWrap">

<!--[if lt IE 9]> <mce:script src="//html5shiv.googlecode.com/svn/trunk/html5.js" mce_src="https://html5shiv.googlecode.com/svn/trunk/html5.js"></mce:script> <![endif]-->
<!-- [if lt IE]>
<script src="//ajax.googleapis.com/ajax/libs/chrome-frame/1.0.3/CFInstall.min.js"></script>
<script>window.attachEvent('onload',function(){CFInstall.check({mode:'overlay'})})</script>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/chrome-frame/1/CFInstall.min.js"></script>
    <load target="http://ajax.googleapis.com/ajax/libs/chrome-frame/1.0.3/CFInstall.min.js" targetie="IE" />
    <script type="text/javascript">window.attachEvent('onload',function(){CFInstall.check({mode:'overlay'})})</script>
<![endif]-->
<input type="hidden" id="rgstId" value="<c:out value='${baseUserLoginInfo.loginId}'/>">
<input type="hidden" id="rgstSabun" value="<c:out value='${baseUserLoginInfo.empNo}'/>">
<div id="wrap">
	<section>
		<article>
	<form id="companyName" name="companyName" onkeydown="javascript:if(event.keyCode==13){doLogin();}"  method="post">

	<input type="hidden" name="ip" value="<%=request.getRemoteAddr() %>"/>
	<input type="hidden" name="loginDt" value="<%= new java.util.Date() %>"/>
	<div id="skipNavigation">
        <p><a href="#login_inputBox">메뉴 건너뛰기</a></p>
    </div>
    <hr />
	<!--로그인-->
    <div id="loginCheckBox">
    	<%-- <h1><img src="<c:url  value='/images/main/h1_logo_ib.gif'/>" alt="SYNERGY IB-SYSTEM" /></h1> --%>
    	<h1><img src="<c:url  value='/images/common/h1_logo_pass.png'/>" alt="PASS GROUPWARE" /></h1>
        <!-- <p class="loginDes"><strong>PASS 그룹웨어를 이용해 주셔서 감사합니다~!</strong></p> -->
        <p class="loginDes2"><strong>브라우저 :</strong><span>Chrome, IE9이상</span><strong class="divline">해상도 :</strong><span>1280이상</span></p>

        <div id="login_inputBox">
        	<ul>
            	<li class="userID_st"><label><em class="hide">아이디입력</em><input id="usrId" name="usrId" type="text" required="required" placeholder="ID" /></label></li>
                <li class="pass_st"><label><em class="hide">비밀번호입력</em><input id="usrPw" name="usrPw" type="password" required="required" placeholder="PASSWORD"/></label></li>
                <li class="remembertxt"><label><input id="ckbx" type="checkbox" class="check_st" />ID 저장하기</label></li>
               <li class="remembertxt"><a href="javascript:doLogin();" class="LoginBtnNew"><em class="hide">LOGIN</em></a></li>
	           <!--<li ><input type="image" src="<c:url value='/images/main/btn_login.png'/>" alt="로그인" onclick="submit0();$(this).parent('form').submit();"/></li>-->
            </ul>
        </div>
        <div class="login_copy">
            <p>Copyright (c) 2017 Synergy. All Rights Reserved.<!--  이용문의: 070-7465-5831 --></p>
        </div>
    </div>
 </form>
 </article>
	</section>
<!-- main contents -->

<!-- main contents -->
<!-- footer -->
	<footer>
	</footer>
<!-- footer -->
</div>
</body>
</html>