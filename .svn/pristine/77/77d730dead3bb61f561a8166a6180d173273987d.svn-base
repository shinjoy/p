<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
var colorObj = {};
var comAppvDocNumRuleDate = getBaseCommonCode('APPV_DOC_NUM_RULE_DATE', null, 'CD', 'NM', '', '날짜선택','ALL', { orgId : "${baseUserLoginInfo.orgId}" });
var comAppvDocNumRuleSeq = getBaseCommonCode('APPV_DOC_NUM_RULE_SEQ', null, 'CD', 'NM', '', '번호선택','ALL', { orgId : "${baseUserLoginInfo.orgId}" });
$(document).ready(function(){
	numberFormatForNumberClass();
})
//저장
function doSave(){
	var chk = true;
	//유효성체크
	$("input[name*='markDayCnt|']").each(function(i){
		if(!$(this).prop("disabled")){
			if($(this).val()==""){
				var $obj = $(this);
				dialog.push({body:"<b>확인!</b> 경과일수를선택해주세요.", type:"", onConfirm:function(){$obj.focus();}});
				$(this).focus();
				chk = false;
				return false;
			}

			if($(this).val()=="0"){
				var $obj = $(this);
				dialog.push({body:"<b>확인!</b> 경과일수는 0이상 입력해 주세요.", type:"", onConfirm:function(){$obj.focus();}});
				$(this).focus();
				chk = false;
				return false;
			}
		}
	});

	if(!chk) return;

	if(confirm("저장하시겠습니까?")){

		$(".number").each(function(){
			$(this).val($(this).val().split(",").join(""));
		});

		$("#frm").attr("action",contextRoot+"/personnel/management/processMarkRule.do");
		commonAjaxSubmit("POST",$("#frm"),saveCallback);
	}
}

//저장콜백
function saveCallback(data){
	if(data.resultObject.result =="SUCCESS"){
		toast.push('저장되었습니다.');
		doReset();
	}else{
		dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
	}
}

//리셋
function doReset(){
	$("#frm").attr("action",contextRoot+"/personnel/management/getMarkRuleListAjax.do");
	commonAjaxSubmit("POST",$("#frm"),resetCallback);
}
//리셋 콜백
function resetCallback(data){
	$("#listArea").html(data);
}
//숫자 체크
function isNumChk($obj){
	if($obj.val()!=""&&!strInNum($obj.val())){
		alert("숫자만 입력 가능합니다.");
		$obj.val("");
	}

}
//기준설정 체크
function chkReadTime($obj){
	if($obj.prop("checked")){

		var readTimeYnNm = $obj.attr("name");
		var readTimeYnNmBuf = readTimeYnNm.split("|");
		var targetId = "markDayCnt|"+ readTimeYnNmBuf[1]+"|"+readTimeYnNmBuf[2];
		if($obj.val()=="Y"){
			$("input[name='"+targetId+"']").val("");
			$("input[name='"+targetId+"']").prop("disabled",true);
		}else{
			$("input[name='"+targetId+"']").prop("disabled",false);
		}
	}
}
</script>
