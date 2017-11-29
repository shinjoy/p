<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
var colorObj = {};
var comAppvDocNumRuleDate = getBaseCommonCode('APPV_DOC_NUM_RULE_DATE', null, 'CD', 'NM', null, '날짜선택','ALL', { orgId : "${baseUserLoginInfo.orgId}" });
var comAppvDocNumRuleSeq = getBaseCommonCode('APPV_DOC_NUM_RULE_SEQ', null, 'CD', 'NM', null, '번호선택','ALL', { orgId : "${baseUserLoginInfo.orgId}" });

//저장
function doSave(){
	var chk = true;
	//유효성체크
	$("select").each(function(i){
		if($(this).val() == ""){
			var id = $(this).attr("id");

			var chkStr = id.split("|")[0];

			if(chkStr == "appvDocNumRuleDate"){
				var $obj = $(this);
				dialog.push({body:"<b>확인!</b> 날짜를선택해주세요.", type:"", onConfirm:function(){$obj.focus();}});
				$(this).focus();
				chk = false;
				return false;
			}else if(chkStr == "appvDocNumRuleSeq"){
				var $obj = $(this);
				dialog.push({body:"<b>확인!</b> 번호를선택해주세요.", type:"", onConfirm:function(){$obj.focus();}});
				$(this).focus();
				chk = false;
				return false;
			}
		}
	});
	if(!chk) return;

	if(confirm("저장하시겠습니까?")){
		$("#frm").attr("action",contextRoot+"/approve/processAppvDocNumRule.do");
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
	$("#frm").attr("action",contextRoot+"/approve/getAppvDocNumRuleAjax.do");
	commonAjaxSubmit("POST",$("#frm"),resetCallback);
}
//리셋 콜백
function resetCallback(data){
	$("#listArea").html(data);

	if("${baseUserLoginInfo.orgBasicAut}" == "READ"){
		$(".btn_auth").hide();
	}else if("${baseUserLoginInfo.orgBasicAut}" == "SUPER"){
		$(".btn_auth").show();
	}
}

//select box change
function setExText($obj){
	var chgName = $obj.attr("name");

	var chgNameBuf = chgName.split("|");

	var type = chgNameBuf[0];

	var appvDocType = chgNameBuf[1];

	var appvDocClass = chgNameBuf[2];

	var dateCode = $("select[name='appvDocNumRuleDate|"+appvDocType+"|"+appvDocClass+"']").val();
	var seqCode = $("select[name='appvDocNumRuleSeq|"+appvDocType+"|"+appvDocClass+"']").val();

	var now = new Date();
	//날짜 예시 셋팅
	var dateStr = "";

	switch(dateCode){
	case 'YYYYMMDD':
		var yyyy = now.getFullYear().toString();
	    var mm = (now.getMonth() + 1).toString();
	    var dd = now.getDate().toString();

	    dateStr = yyyy + (mm[1] ? mm : '0'+mm[0]) + (dd[1] ? dd : '0'+dd[0]);

		break;
	case 'YYMMDD':
		var yyyy = now.getFullYear().toString();
	    var mm = (now.getMonth() + 1).toString();
	    var dd = now.getDate().toString();
	    dateStr = yyyy.substr(-2) + (mm[1] ? mm : '0'+mm[0]) + (dd[1] ? dd : '0'+dd[0]);
		break;
	case 'YYMM':
		var yyyy = now.getFullYear().toString();
	    var mm = (now.getMonth() + 1).toString();
	    var dd = now.getDate().toString();
	    dateStr = yyyy.substr(-2) + (mm[1] ? mm : '0'+mm[0]);
		break;
	case 'MMDD':
		var yyyy = now.getFullYear().toString();
	    var mm = (now.getMonth() + 1).toString();
	    var dd = now.getDate().toString();
	    dateStr = (mm[1] ? mm : '0'+mm[0]) + (dd[1] ? dd : '0'+dd[0]);
		break;
	}
	var seqStr = "";
	//번호 예시 셋팅
	switch(seqCode){
	case '5DIGIT':
		seqStr="00001";
		break;
	case '4DIGIT':
		seqStr="0001";
		break;
	case '3DIGIT':
		seqStr="001";
		break;
	}

	var $appvDocNumRuleMidName = $("input[name = 'appvDocNumRuleMidName|"+appvDocType+"|"+appvDocClass+"']").clone();
	var beforeEx = $("#exStr_"+appvDocType).text();

	beforeEx = beforeEx.trim();
	var beforeExBuf = beforeEx.split("-");

	var newEx = dateStr+"-"+beforeExBuf[1]+"-"+seqStr;

	$("#exStr_"+appvDocType).text(newEx);

	$("#exStr_"+appvDocType).append($appvDocNumRuleMidName);

}
</script>
