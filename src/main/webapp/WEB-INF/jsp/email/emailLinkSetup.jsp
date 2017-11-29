<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id="linkEmailMenu" class="deatailconWrap" style="display:none;">
	<section id="detail_contents">
		<div class="email_loginWrap">
			<div class="email_titleBox">
				<div class="can_emailset">
					<p class="title">사내메일, 이제 PASS에서 사용하세요.</p>
					<p class="des">메일계정만 추가하면 쉽게 연동이 가능합니다.</p>
				</div>
			</div>
			<div class="email_chBox">
				<div class="email_chCon">
					<p class="idch"><input id="linkId" type="text" class="input_b" placeholder="아이디" /></p>
					<p class="passch"><input id="linkPasswd" type="password" class="input_b" placeholder="비밀번호" onkeypress="if(event.keyCode==13) {linkEmail('new');}"/></p>
					<p class="sys_p_noti"><span class="icon_noti"></span><span>사내메일 연동 시</span> <span class="pointB"> 자동로그인 상태로 변경</span><span>됩니다.</span></p>
					<button type="button" class="email_ckbtn" onclick="javascript:linkEmail('new');">사내메일<br/>연동하기</button>
				</div>
			</div>
		</div>
	</section>
</div>





<div id="unlinkEmailMenu" class="deatailconWrap" style="display:none;">
	<section id="detail_contents">
		<div class="email_loginWrap">
			<div class="email_titleBox">
				<div class="can_emailset">
					<p class="title">PASS는 사내메일을 연동하여 사용합니다.</p>
					<p class="des">사용중인 사내메일 로그인 정보를 입력해주세요.</p>
				</div>
			</div>
			<div class="email_chBox">
				<div class="email_chCon">
					<p class="idch"><input id="unlinkId" type="text" class="input_b" placeholder="아이디"  /></p>
					<p class="passch"><input id="unlinkPasswd" type="password" class="input_b" placeholder="비밀번호" ></p>
					<p class="sys_p_noti"><span class="icon_noti"></span><span>현재 사용중인 사내메일의 연동해제를 원하시면 <a href="javascript:unlinkEmail();" class="pointB">[연동해제]</a>를 눌러주세요.</span><br/><span class="pointred">(연동해제시 등록된 메일계정은 삭제됩니다.)</span></p>
					<button type="button" class="email_ckbtn" onclick="linkEmail('edit');">메일계정<br/>정보변경</button>
				</div>
			</div>
		</div>
	</section>
</div>


<div id="linkSuccessMenu" class="deatailconWrap" style="display:none;">
	<section id="detail_contents">
		<div class="email_loginWrap">
			<div class="email_titleBox">
				<div class="can_emailout">
					<p class="title">메일계정이 정상적으로 변경되었습니다.</p>
					<p class="des">확인버튼 클릭시 메일 서비스로 이동됩니다.</p>
				</div>
			</div>
			<div class="email_btnZone">
				<button type="button" class="btn_blueblack" onclick="goLinkEmail();">확인</button>
			</div>
		</div>
	</section>
</div>


<div id="unlinkSuccessMenu" class="deatailconWrap" style="display:none;">
	<section id="detail_contents">
		<div class="email_loginWrap">
			<div class="email_titleBox">
				<div class="can_emailout">
					<p class="title">계정정보가 정상적으로 삭제되었습니다.</p>
					<p class="des">메일서비스를 이용하시려면 사내메일 로그인 정보를 다시 등록해주세요.</p>
				</div>
			</div>
			<div class="email_btnZone">
				<button type="button" class="btn_blueblack" onclick="goLinkEmail();">계정설정</button><button type="button" class="btn_witheline" onclick="goMain();">메인으로</button>
			</div>
		</div>
	</section>
</div>


<script type='text/javascript'>

var needEmailLink	= "${needEmailLink}";
var emailId			= "${emailId}";
var mode 			= "${mode}";
$(document).ready(function() {
	
	// 일괄 숨기기
	$('#linkEmailMenu').hide();
	$('#unlinkEmailMenu').hide();
	$('#linkSuccessMenu').hide();
	$('#unlinkSuccessMenu').hide();
	
	if( mode == 'new' ){
		$('#linkId').val(emailId);
		$('#linkPasswd').val('${emailPassword}');
		$('#linkEmailMenu').show();
	}	
	else if( mode == 'edit' ){
		$('#unlinkId').val(emailId);
		$('#unlinkPasswd').val('${emailPassword}');
		$('#unlinkEmailMenu').show();
	}

});

function linkEmail(mode){	
	var msg = '';
	if( mode == 'new'){
		msg = "사내메일 연동 시 자동로그인 상태로 변경됩니다.\r\n메일계정을 등록하시겠습니까?";
		
	}else if ( mode == 'edit'){
		msg = "변경 된 계정정보로 메일계정을 등록하시겠습니까?";
	}
	if( !confirm(msg) ) return;
	
	// 메일연동정보 등록 진행
	var url = contextRoot + "/email/updateEmailLinkInfo.do";
	
	var mailId = mode == 'new' ? $('#linkId').val() : $('#unlinkId').val();
	var mailPasswd = mode == 'new' ? $('#linkPasswd').val() : $('#unlinkPasswd').val();
	var param = {
			mailLinkFlag		: 'Y',
			mailId				: mailId,
			mailPassword 	 	: mailPasswd			
	};	
	
	var callback = function(result){
		
		var obj = JSON.parse(result);

		if(obj.result == "SUCCESS"){
			$('#unlinkEmailMenu').hide();
			$('#linkEmailMenu').hide();
			$('#linkSuccessMenu').show();			
				
		}else{
			//dialog.push({body:"<b>수정도중 오류가 발생하였습니다.</b>", type:"warning", onConfirm:function(){return;}});
			alert("등록 중에 장애가 발생하였습니다.");
		}
	};

	commonAjax("POST", url, param, callback);
}

function unlinkEmail(){
	if( !confirm("사내메일 연동 해제 시 자동로그인이 불가능합니다.\r\n연동을 해제하시겠습니까?") ) return;
	
	// 메일연동정보 해제 진행	
	var url = contextRoot + "/email/updateEmailLinkInfo.do";
	var param = {
			mailLinkFlag		: 'N',
			mailId				: '',
			mailPassword 	 	: ''			
	};


	var callback = function(result){

		var obj = JSON.parse(result);

		if(obj.result == "SUCCESS"){
			$('#unlinkEmailMenu').hide();
			$('#unlinkSuccessMenu').show();
		}else{
			//dialog.push({body:"<b>수정도중 오류가 발생하였습니다.</b>", type:"warning", onConfirm:function(){return;}});
			alert("등록 중에 장애가 발생하였습니다.");
		}
	};

	commonAjax("POST", url, param, callback);
}

function goLinkEmail(){
	var url = contextRoot + "/email/emailView.do";
	location.href= url;
}

function goMain(){
	var url = contextRoot;
	location.href= url;
}
</script>