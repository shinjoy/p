<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">

var myModal = new AXModal();    // instance
var selUserIndex = -1;          //직원배정을 위해 직원선택 팝업시킨 row 의 index.
var selUserType = "DEPT";
$(document).ready(function(){
	//-------------------------- 모달창 :S -------------------------
	myModal.setConfig({
		windowID:"myModalCT",

		width:740,
        mediaQuery: {
            mx:{min:0, max:767}, dx:{min:767}
        },
		displayLoading:true,
        scrollLock: false,
		onclose: function(){
			$(".mo_container2").css("min-height","");
			popupReSize();
		}
        ,contentDivClass: "popup_outline"

	});
	//-------------------------- 모달창 :E -------------------------

	var modifyType = parent.modifyType;
	if(modifyType == "modify"){
		$("#frmLine").html(parent.getAppvLineHtml());
	}

	$("#tempInput").focus();
	$("#tempInput").hide();
});
function popupReSize(){
	parent.myModal2.resize();
}
//결재라인 Row 추가
function addRowLine(){

	if($("#frmApprove input[name='appvHeaderId']").val() == ""){
        alert("먼저 상단의 결재라인을 선택하여 주시기 바랍니다.");
        return;
    }

    var trHtml = "";
    trHtml += '<tr id="lineTableTr">';
    trHtml += '    <td class="txt_center">';
    trHtml += '        <input type="hidden" id="appVoList.deptId" name="appVoList.deptId"  />';
    trHtml += '        <input type="hidden" id="appVoList.appvUserId" name="appVoList.appvUserId"  />';
    trHtml += '        <input type="text" id="appVoList.appvSeq" name="appVoList.appvSeq"  value=""  maxlength="2" style="text-align:center;text-indent:0px!important;" class="input_b w_st06" title="승인순서입력" placeholder="숫자" />';
    trHtml += '    </td>';
    trHtml += '    <td class="txt_center">';
    /* trHtml += '        <span id="appvClassTag">'; */
    trHtml += '    <select id="appVoList.appvClass" name="appVoList.appvClass" class="select_b w100pro appvClass" title="승인방식선택">';
    trHtml += '        <option value="" selected>승인방식선택</option>';
    <c:forEach var="cmmCd1" items="${cmmCdAppvClassList}" varStatus="status1">
        trHtml += '        <option value="${cmmCd1.cd}">${cmmCd1.nm}</option>';
    </c:forEach>

    /* trHtml += '        <option value="APPROVAL" selected>결재</option>'; */
    /* trHtml += '        <option value="AGREE" >합의</option>'; */
    trHtml += '    </select>';
   /*  trHtml += '       <span class="radio_list2">';
    trHtml += '            <label><input type="radio" id="appVoList.appvClass" name="appVoList.appvClass" value="APPROVAL" checked/><span>결재</span></label>';
    trHtml += '            <label><input type="radio" id="appVoList.appvClass" name="appVoList.appvClass" value="AGREE" /><span>합의</span></label>';
    trHtml += '        </span>'; */
    trHtml += '    </td>';
    trHtml += '    <td>';
    /* trHtml += '        <span id="appvLineTypeTag">'; */
    trHtml += '        <select id="appVoList.appvLineType" name="appVoList.appvLineType" onChange="changeAppvLineType(this);" disabled = "disabled" class="select_b w100pro" title="결재유형선택">';
    trHtml += '            <option value="" selected>결재유형선택</option>';
    <c:forEach var="cmmCd2" items="${cmmCdAppvLineTypeList}" varStatus="status2">
        trHtml += '        <option value="${cmmCd2.cd}"';
        <c:if test = "${cmmCd2.cd eq 'USER'}">
        trHtml +=  ' selected = "selected"';
        </c:if>
        trHtml +=  ' >${cmmCd2.nm}</option>';
    </c:forEach>
    trHtml += '        </select>';
    trHtml += '    </td>';
    trHtml += '    <td>';
    trHtml += '        <span id="spanSelectAppvLineBtn"><a onclick="javascript:fnObj.openUserPopup(this, \'USER\');" class="btn_select_employee"><em>직원선택</em></a></span>';
    trHtml += '        <span id="spanAppvLineDisplayNm" class="spanAppvLineDisplayNm"></span>';
    trHtml += '    </td>';
    /* trHtml += '    <td class="txt_center"></td>'; */
    trHtml += '    <td class="txt_center"><button type="button" onClick="deleteRowLine(this);" class="btn_s_type_g btn_auth">삭제</button></td>';
    trHtml += '</tr>';

    if($('#lineTableNoData').length > 0){
        $('#lineTable > tbody:last > tr:last').remove();
    }

    $('#lineTable').append(trHtml);

    parent.myModal2.resize();
    $("#tempInput").show();
	$("#tempInput").focus();
	$("#tempInput").hide();
}
//결재유형 선택시
function changeAppvLineType(obj){

    var selectedInx = -1;   //선택된 순번

    var appvLineTypeArray = $("#frmLine select[name='appVoList.appvLineType']");
    var appvLineTypeArrayLength = appvLineTypeArray.length;

    for(var i = 0; i < appvLineTypeArrayLength; i++){
        if(appvLineTypeArray[i] == obj){
            selectedInx = i;
            break;
        }
    }

    //부서간 정합선 체크
    var validateDeptApprovaTypeResult = this.validateDeptApprovaType(selectedInx);
    if(validateDeptApprovaTypeResult == 1) {
        alert("소속부서 이후에 상위부서를 결재순서로 지정해야 합니다..");
        resetApprovalLine(selectedInx);
        $(obj).val("");
        return;
    }
    else if(validateDeptApprovaTypeResult == 2) {
        alert("소속부서는 중복지정할 수 없습니다");
        resetApprovalLine(selectedInx);
        $(obj).val("");
        return;
    }

    //셋팅대상 OBJ
    var deptIdInput             = $("#frmLine input[name='appVoList.deptId']:eq("+selectedInx+")");     //부서id
    var appvUserIdInput         = $("#frmLine input[name='appVoList.appvUserId']:eq("+selectedInx+")"); //결재자id
    var appvLineDisplayNmSpan   = $("span[id^='spanAppvLineDisplayNm']:eq("+selectedInx+")");  //선택된 부서명
    var selectAppvLineBtnSpan   = $("span[id^='spanSelectAppvLineBtn']:eq("+selectedInx+")");  //버튼

	//결재유형 선택에 따른 분기
	if(obj.value.trim() == "MY_DEPT"){  //소속부서
        $(deptIdInput           ).attr("value", "");
        $(appvUserIdInput       ).attr("value", "");
        $(appvLineDisplayNmSpan ).html("소속부서");
        $(selectAppvLineBtnSpan ).html("");
	}
    else if(obj.value.trim() == "HIGH_DEPT"){  //상위부서
        $(deptIdInput           ).attr("value", "");
        $(appvUserIdInput       ).attr("value", "");
        $(appvLineDisplayNmSpan ).html("상위부서");
        $(selectAppvLineBtnSpan ).html("");
    }
    else{
        this.resetApprovalLine(selectedInx);    //해당라인초기화

        if(obj.value.trim() == "OTHER_DEPT"){  //부서지정
            $(selectAppvLineBtnSpan).html('<a onclick="javascript:fnObj.openUserPopup(this, \'DEPT\');" class="btn_select_team"><em>부서선택</em></a>');
            //$(selectAppvLineBtnSpan).html('<a onclick="javascript:alert(this.tagName)"><em>부서선택</em></a>');
        }else if(obj.value.trim() == "USER"){  // 결재자지정
            $(selectAppvLineBtnSpan).html('<a onclick="javascript:fnObj.openUserPopup(this, \'USER\');" class="btn_select_employee"><em>직원선택</em></a>');
        }
    }

    //상위부서정보 가져오기
    //this.getHighDeptInfo();
}

var fnObj = {
		//사원선택 팝업   (idx : activity index, knd : 'project' 프로젝트전체에 배정하는 케이스)
	    openUserPopup: function(obj, knd){
            //선택된 OBJ 순번
            var spanSelectAppvLineBtnArray = $("span[id^='spanSelectAppvLineBtn']");
            var spanSelectAppvLineBtnArrayLength = spanSelectAppvLineBtnArray.length;

            for(var i = 0; i < spanSelectAppvLineBtnArrayLength; i++){
                if(spanSelectAppvLineBtnArray[i] == obj.parentElement){
                    selUserIndex = i;
                    break;
                }
            }

            var paramList = [];
            var paramObj ={ name : 'isOneOrg' ,value : 'Y'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isAllOrg' ,value : 'N'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'oneOrg' ,value : '${baseUserLoginInfo.orgId}'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isCheckDisable' ,value : 'N'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isOneUser' ,value : 'Y'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'hasDeptTopLevel' ,value : 'Y'};
	        paramList.push(paramObj);  //부서의 회장 부서 표시여부
	        paramObj ={ name : 'isAppoveLineAdd' ,value : 'Y'};
	        paramList.push(paramObj);  //결재 라인 결재자 공개여부

	        selUserType = knd;

	        userSelectPopCall(paramList);		//공통 선택 팝업 호출
	       /*  var url = "<c:url value='/user/selectUserOrDeptPopup.do'/>";
	        var params = {
	        	parentKey: 'PJT_REG'
	        	, popupType: (knd=='USER') ? 'USER' : 'DEPT'
                , isOnlyOne: 'Y'
                , oneOrg : '${baseUserLoginInfo.applyOrgId}'
                ,isAllOrg:'N'       //전체ORG 여부
	                    //    parentKey: (knd==undefined)?'PJT_REG':'PJT_REG_ALL'     //'PJT_REG' activity , 'PJT_REG_ALL' project 전체
	                    //  ,isOnlyOne:'Y'      //한건선택 여부
	                    //  ,isAllOrg:'Y'       //전체ORG 여부
	                    //  ,isCloseBySelect:'N'//선택과동시에 창닫기 여부     ('N': 안닫힌다,     그외: 닫힌다)            ... default 'Y'
	                    //  ,popupType:'DEPT'   //선택 팝업 유형 ('USER' or 'DEPT)..defualt 'USER'
	                    };  //{mode:'new'}; //"btype=1&cate=1".queryToObject();     //게시판유형(board_type), 게시판 카테고리 를 넘긴다.

	        myModal.open({
	            url: url,
	            pars: params,
	            titleBarText: (knd=='USER') ? '직원선택' : '부서선택',      //titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
	            method:"POST",
	            top: 0,
	            width: 750,
	            closeByEscKey: true,	//esc 키로 닫기
	    		onclose: function(){
	    		}
	        });
	        //$('#myModalCT').draggable();
			$(".mo_container2").css("min-height","500px");
	        parent.myModal2.resize(); */
	    },
	    //사원 및 부서 선택 팝업에서 선택한 데이터를 처리
	    getResult: function(list){
	    	fnObj.actionBySelData(list);
	    },
	    //사원 및 부서 선택 팝업에서 선택한 데이터를 처리
	    actionBySelData: function(listObj, pKey){
            /*
	        alert(selUserType);
	    	alert(selUserIndex);
	    	alert(listObj[0].userNm);
	    	alert(listObj[0].deptNm);
            */

            //셋팅대상 OBJ
            var deptIdInput             = $("#frmLine input[name='appVoList.deptId']:eq("+selUserIndex+")");     //부서id
            var appvUserIdInput         = $("#frmLine input[name='appVoList.appvUserId']:eq("+selUserIndex+")"); //결재자id
            var appvLineDisplayNmSpan   = $("span[id^='spanAppvLineDisplayNm']:eq("+selUserIndex+")");  //선택된 부서명
            var selectAppvLineBtnSpan   = $("span[id^='spanSelectAppvLineBtn']:eq("+selUserIndex+")");  //버튼

	    	if(selUserType == "USER"){
                $(deptIdInput           ).attr("value", "");
                $(appvUserIdInput       ).attr("value", listObj[0].userId);
                $(appvLineDisplayNmSpan ).html(listObj[0].userNm+"("+listObj[0].deptNm+"/"+listObj[0].rankNm+")");
	    	}else if(selUserType == "DEPT"){
                $(deptIdInput           ).attr("value", listObj[0].deptId);
                $(appvUserIdInput       ).attr("value", "");
                $(appvLineDisplayNmSpan ).html(listObj[0].deptNm);
            }
	    	$(".mo_container2").css("min-height","");
			parent.myModal2.resize();
	    }
};//end fnObj.

//결제라인 테이블 Row 삭제
function deleteRowLine(obj){

    if($("#frmLine input[name='appVoList.deptId']").length == 1){
        alert("결제라인을 모두 삭제할 수 없습니다");
        return;
    }

    if(!confirm("삭제하시겠습니까?")) return;  //삭제하시겠습니까?
    var tr = $(obj).parent().parent();
    tr.remove();

    //상위부서정보 가져오기
    //this.getHighDeptInfo();

    parent.myModal2.resize();
}

//결재라인 저장
function doSaveAppLine(){

	var appLineCnt = $("#frmLine input[name*='appVoList.deptId']").length;
    if(appLineCnt == 0){
        alert("결재라인을 설정하여 주시기 바랍니다.");
        return;
    }

    if(appLineCnt>10){
    	alert("결재라인은 최대 10개까지 생성할 수 있습니다.");
    	return;
    }
	//결재 maxSeq
    var approveMaxSeq = "approve";
	//합의 minSeq
	var agreeMinSeq = "agree";

	//결재는 1개이상
	//합의는 결재보다 승인순서가 앞설수 없다.
	//approveMaxSeq , agreeMinSeq 가 숫자가아닌 기본 영문자면 한건도 없는것으로 벨리데이션 체크


    for(var i=0;i<appLineCnt;i++){

        if($("#frmLine input[name='appVoList.appvSeq']:eq("+i+")").val() == ""){
            alert("승인순서를 입력하시기 바랍니다.");
            $("#frmLine input[name='appVoList.appvSeq']:eq("+i+")").focus();
            return;
        }else if(!strInNum($("#frmLine input[name='appVoList.appvSeq']:eq("+i+")").val())){
        	 alert("승인순서는 숫자만 입력하시기 바랍니다.");
             $("#frmLine input[name='appVoList.appvSeq']:eq("+i+")").focus();
             return;
        }

        if($("#frmLine select[name='appVoList.appvClass']:eq("+i+")").val() == ""){
            alert("승인방식을 선택하여 주시기 바랍니다.");
            $("#frmLine select[name='appVoList.appvClass']:eq("+i+")").focus();
            return;
        }

        if(i != 0){
            if(parseInt($("#frmLine input[name='appVoList.appvSeq']:eq("+i+")").val()) < parseInt($("#frmLine input[name='appVoList.appvSeq']:eq("+(i-1)+")").val())){
                alert("승인순서를 정확히 입력하시기 바랍니다.");
                $("#frmLine input[name='appVoList.appvSeq']:eq("+i+")").focus();
                return;
            }
        }

        var appvLineTypeValue   = $("#frmLine select[name='appVoList.appvLineType']:eq("+i+")").val();
        var dpetIdValue         = $("#frmLine input[name='appVoList.deptId']:eq("+i+")").val();
        var appvUserIdValue     = $("#frmLine input[name='appVoList.appvUserId']:eq("+i+")").val();

        if(appvLineTypeValue == ""){
            alert("결재유형을 선택하여 주시기 바랍니다.");
            $("#frmLine select[name='appVoList.appvLineType']:eq("+i+")").focus();
            return;
        }else if(appvLineTypeValue == "OTHER_DEPT"){  //부서
            if(dpetIdValue == "" || dpetIdValue == "0"){
                alert("선택된 부서정보가 없습니다. 결재라인을 확인하시기 바랍니다.");
                $("#frmLine select[name='appVoList.appvLineType']:eq("+i+")").focus();
                return;
            }
        }else if(appvLineTypeValue == "USER"){  //결재자지정
            if(appvUserIdValue == ""){
                alert("결재유형이 결재자지정인 경우 직원선택을 선택하셔야 합니다.");
                $("#frmLine select[name='appVoList.appvLineType']:eq("+i+")").focus();
                return;
            }
        }
        var appvClass = $("#frmLine select[name='appVoList.appvClass']:eq("+i+")").val();

        //결재이면 approveMaxSeq 셋팅
        if(appvClass == "APPROVAL"){
        	if(approveMaxSeq == "approve") approveMaxSeq = $("#frmLine input[name='appVoList.appvSeq']:eq("+i+")").val();
        	else{
        		if(approveMaxSeq<parseInt($("#frmLine input[name='appVoList.appvSeq']:eq("+i+")").val()))
        			approveMaxSeq = $("#frmLine input[name='appVoList.appvSeq']:eq("+i+")").val();
        	}
        }else if(appvClass == "AGREE"){
			if(agreeMinSeq == "agree") agreeMinSeq = $("#frmLine input[name='appVoList.appvSeq']:eq("+i+")").val();
			else{
        		if(agreeMinSeq>parseInt($("#frmLine input[name='appVoList.appvSeq']:eq("+i+")").val()))
        			agreeMinSeq = $("#frmLine input[name='appVoList.appvSeq']:eq("+i+")").val();
        	}
        }
    }
	if(approveMaxSeq == "approve"){
		alert("승인방식이 '결재'인 결재라인은 한건 이상 등록하셔야 합니다.");
		return;
	}else{
		if(agreeMinSeq != "agree"){
			if(parseInt(approveMaxSeq)>=parseInt(agreeMinSeq)){
				alert("승인방식이 '합의'인 결재라인은 '결재'인 결재라인보다 승인순서가 클수 없습니다.");
				return;
			}
		}
	}

    //저장을 위한 Object 순번 부여
    //this.setIdxApproveLineObjectForSave();

    $("input").each(function(){
    	$(this).attr("value",$(this).val());
    });

    $("select").each(function(){
    	var value = $(this).val();

    	$(this).find("option").removeAttr("selected");
    	$(this).find("option[value='"+value+"']").attr("selected","selected");
    });
    parent.individualChkCallback($("#frmLine").html());
    parent.myModal2.close();

}

//결재유형부서 정합성
function validateDeptApprovaType(selectedInx){
    var appvLineTypeArray = $("#frmLine select[name='appVoList.appvLineType']");

    //소속부서 개수
    var muDeptCount = 0;
    for(var i = 0; i < appvLineTypeArray.length; i++){
        if($(appvLineTypeArray[i]).val() == "MY_DEPT"){
            muDeptCount++;

            //소속부서이전에 상위부서가 있는 경우
            for(var j=0;j<i;j++){
                var highAppvLineType = $("#frmLine select[name='appVoList.appvLineType']:eq("+j+")").val();
                if(highAppvLineType == "HIGH_DEPT"){
                    return 1;
                }
            }
        }
    }

    if(muDeptCount > 1){
        return 2;
    }

    return 0;
}

//선택결재라인 초기화
function resetApprovalLine(selectedInx){
    $("#frmLine input[name='appVoList.deptId']:eq("+selectedInx+")").attr("value", "");     //부서id
    $("#frmLine input[name='appVoList.appvUserId']:eq("+selectedInx+")").attr("value", ""); //결재자id
    $("span[id^='spanAppvLineDisplayNm']:eq("+selectedInx+")").html("");  //선택된 부서명
    $("span[id^='spanSelectAppvLineBtn']:eq("+selectedInx+")").html("");  //버튼
}

//직원별 상위부서정보. 지우지 말것
/*
function getHighDeptInfo(){
    this.setIdxApproveLineObject(); //결재라인 객체 순번 부여

    var url = contextRoot + "/approve/getApproveLineHighDeptInfoAjax.do";
    $('#frmLine').attr('action', url);
    commonAjaxSubmit("POST", $("#frmLine"), getHighDeptInfoCallback);
}

//상위부서정보 가져오기 Ajax 콜백
function getHighDeptInfoCallback(result){

    this.reSetIdxApproveLineObject() //결재라인 객체 순번 해제

	var resultList = result.resultList;   //결과데이터JSON
    for(var i=0;i<resultList.length;i++){
        var objIdx = resultList[i].objIdx;
        if($("#frmLine select[name='appVoList.appvLineType']:eq("+objIdx+")").val() == "HIGH_DEPT"){
            if(resultList[i].deptId != "0"){
                $("#frmLine input[name='appVoList.deptId']:eq("+objIdx+")").attr("value", resultList[i].deptId);
                $("span[id^='spanAppvLineDisplayNm']:eq("+objIdx+")").html(resultList[i].deptName);
            }
            else{
                $("#frmLine input[name='appVoList.deptId']:eq("+objIdx+")").attr("value", "");
                $("span[id^='spanAppvLineDisplayNm']:eq("+objIdx+")").html("");
            }
        }

    }
}
*/

//부서를 가져오기 위해 Object들의 순번을 부여
function setIdxApproveLineObject(){
    var appvLineTypeArray = $("#frmLine select[name='appVoList.appvLineType']");
    for(var i = 0; i < appvLineTypeArray.length; i++){
        $(appvLineTypeArray[i]).attr("name", "appVoList["+i+"].appvLineType");
        $("span[id^='spanAppvLineDisplayNm']:eq("+i+")").attr("id", "spanAppvLineDisplayNm["+i+"]");
    }
}

//부서를 가져오기 위한 Object들의 순번을 삭제
function reSetIdxApproveLineObject(){
    var appvLineTypeArray = $("#frmLine select[name$='].appvLineType']");
    for(var i = 0; i < appvLineTypeArray.length; i++){
        $(appvLineTypeArray[i]).attr("name", "appVoList.appvLineType");
        $("span[id^='spanAppvLineDisplayNm']:eq("+i+")").attr("id", "spanAppvLineDisplayNm");
    }
}

//저장을 위해 결재라인의 Object들의 순번을 부여
function setIdxApproveLineObjectForSave(){
    var appvSeqArray      = $("#frmLine input[name='appVoList.appvSeq']");
    var appvClassArray    = $("#frmLine select[name='appVoList.appvClass']");
    var appvLineTypeArray = $("#frmLine select[name='appVoList.appvLineType']");
    var deptIdArray       = $("#frmLine input[name='appVoList.deptId']");
    var appvUserIdArray   = $("#frmLine input[name='appVoList.appvUserId']");
    for(var i = 0; i < appvSeqArray.length; i++){
        $(appvSeqArray     [i]).attr("name", "appVoList["+i+"].appvSeq");
        $(appvClassArray   [i]).attr("name", "appVoList["+i+"].appvClass");
        $(appvLineTypeArray[i]).attr("name", "appVoList["+i+"].appvLineType");
        $(deptIdArray      [i]).attr("name", "appVoList["+i+"].deptId");
        $(appvUserIdArray  [i]).attr("name", "appVoList["+i+"].appvUserId");
    }
}

//선택된 Row CSS
function setSelectedApprovalHeaderCss(trObj){
    this.clearSelectedApprovalHeaderCss();

    if(trObj != undefined){
        $(trObj).attr("id", "selectedApproveHeaderTr");
        $(trObj).addClass("tr_selected");
    }
}

//선택된 Row CSS 해제
function clearSelectedApprovalHeaderCss(){
    $("#selectedApproveHeaderTr").removeClass("tr_selected");
    $("#selectedApproveHeaderTr").attr("id", "");
}
</script>
<div class="mo_container2">
	<form id = "frmLine" name = "codeFrm" method="post">
	<!-- 등록/수정페이지 -->
	    <table id="lineTable" class="datagrid_input" summary="결재라인 관리 (문서이름, 타입, 금액, 사용여부, 마감여부, 수정자, 등록자)"  arrayVoName="approveVoList" >
	        <caption>프로젝트목록</caption>
	        <colgroup>
	            <col width="100" />
	            <col width="14%" />
	            <col width="14%" />
	            <col width="*" />
	            <col width="80" />
	        </colgroup>
	        <thead>
	            <tr>
	                <th scope="col">승인순서</th>
	                <th scope="col">승인방식</th>
	                <th scope="col">결재유형</th>
	                <th scope="col">상세유형</th>
	                <!-- <th scope="col">수정자</th> -->
	                <th scope="col">삭제</th>
	            </tr>
	        </thead>
	        <tbody>

	            <tr>
	                <td id="lineTableNoData" class="no_result" colspan="6">결재라인을 추가해 주세요.</td>
	            </tr>
	        </tbody>
	    </table>
	    <!--버튼영역-->
		<div class="btn_baordZone2">
		    <a href="javascript:addRowLine();" class="btn_blueblack btn_auth">결재라인 추가</a>
		    <a href="javascript:doSaveAppLine();" class="btn_witheline btn_auth">확인</a>
		    <a href="javascript:parent.myModal2.close();" class="btn_witheline btn_auth">닫기</a>
		</div>
		<!--//버튼영역//-->
	</form>
</div>
<div style="height: 30px;"></div>

<input type="text" name="tempInput"  id="tempInput" />
