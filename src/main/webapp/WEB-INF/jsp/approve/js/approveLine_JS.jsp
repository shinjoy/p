<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>
<script type="text/javascript" defer="defer">
	var myModal2 = new AXModal();	// instance
	$(document).ready(function(){
		numberFormatForNumberClass();
		var colorObj = {};
		//문서종류 검색 선택박스
		var comCodeSearchAppvDocClass = getBaseCommonCode('APPV_DOC_CLASS', null, 'CD', 'NM', '', '문서종류전체', null, { orgId : "${baseUserLoginInfo.orgId}" });
        var searchAppvDocClassTag = createSelectTag('searchAppvDocClass', comCodeSearchAppvDocClass, 'CD', 'NM', '${searchAppvDocClass}', null, colorObj, '', 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        $("#searchAppvDocClassTag").html(searchAppvDocClassTag);

        //문서종류 등록 선택박스
        var comCodeAppvDocClass = getBaseCommonCode('APPV_DOC_CLASS', null, 'CD', 'NM', '', '문서종류선택', null, { orgId : "${baseUserLoginInfo.orgId}" });
        var appvDocClassTag = createSelectTag('appvDocClass', comCodeAppvDocClass, 'CD', 'NM', '', null, colorObj, '', 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        $("#appvDocClassTag").html(appvDocClassTag);

        //$("#appvDocTypeTag").attr("disabled",true);

        //문서종류검색
        $("#searchAppvDocClass").change(function(){
        	getAppHeaderList();
        });

        //문서종류 선택
        $("#appvDocClass").change(function(){
        	var appvDocClass = $(this).val().trim();

        	if(appvDocClass!="COMPANY"){
	        	//문서종류 검색 선택박스
	    		var comCodeAppvDocType = getBaseCommonCode('APPV_DOC_TYPE_'+appvDocClass, null, 'CD', 'NM', '', '문서타입선택', null, { orgId : "${baseUserLoginInfo.orgId}" });
	            var searchAppvDocType = createSelectTag('appvDocType', comCodeAppvDocType, 'CD', 'NM', '', null, colorObj, '', 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	            $("#appvDocTypeTag").html(searchAppvDocType);
        	}else{
        		var url = contextRoot +"/approve/getAppvCompanyListForLineAjax.do";
        		var param = {};
        		var callback = function(data){
        			var obj = JSON.parse(data);
					var appvCompanyList = obj.resultObject.appvCompanyList;

					var stStr = '<select id="appvDocType" name="appvDocType" class="select_b w100pro">';
					    stStr+= '<option value="">문서타입선택</option>';

					for(var i = 0 ; i <appvCompanyList.length ; i++){
						stStr+= '<option value = "'+appvCompanyList[i].appvDocTypeName+'">'+appvCompanyList[i].appvDocTypeName+'</option>';
					}
					stStr+= '</select>';
					$("#appvDocTypeTag").html(stStr);
        		}

        		commonAjax("POST", url, param, callback,false);
        	}
        	$("#minAmount").val("");
            $("#maxAmount").val("");
        	//금액 활성화 처리
        	setAmountDisabled(appvDocClass);
        });
        myModal2.setConfig({
    		windowID:"myModalCT",

    		width:740,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		displayLoading:true,
            scrollLock: false,
    		onclose: function(){
    			getAppHeaderList();
        		setInsFormAppHeader();
        		getAppLineList();
    		}
            ,contentDivClass: "popup_outline"

    	});
	});

	//금액 활성화 처리
	function setAmountDisabled(appvDocClass){
		if(appvDocClass == "BUY"){  //구매신청
            $("#minAmount").attr("disabled",false);
            $("#maxAmount").attr("disabled",false);
            $("#appvHeaderName").attr("disabled",true);
            $("#appvHeaderName").val("");

            $("input[name = 'decisionYn']").prop("disabled",false);
        }else{
            $("#minAmount").attr("disabled",true);
            $("#maxAmount").attr("disabled",true);
            $("#appvHeaderName").attr("disabled",false);

            $("input[name = 'decisionYn']").prop("disabled",true);
        }
	}

	//결재라인 검색
    function getAppHeaderList() {
        var url = contextRoot + "/approve/getApproveHeaderListAjax.do";
        $('#frmApprove').attr('action', url);
        commonAjaxSubmit("POST", $("#frmApprove"), getAppHeaderListCallback);
    }

    //결재라인 검색 Ajax 콜백
    function getAppHeaderListCallback(result){
        $("#listArea1").empty();
        $("#listArea1").html(result);
        setInsFormAppHeader();
        getAppLineList();
        clearSelectedApprovalHeaderCss();
    }

    //결재라인 등록폼 활성화(신규문서추가 버튼)
    function setInsFormAppHeader(){
    	$("#actionType").val("INSERT");
        //$("#appvHeaderId").val("");
        $("#frmApprove input[name='appvHeaderId']").val("");
        $("#appvDocClass").val("");
        $("#appvDocType").html('<option value="">문서타입선택</option>');

        $("#appvHeaderName").val("");
        //$("#appvDocType").val("");
        $("#minAmount").val("");
        $("#maxAmount").val("");
        $('input:radio[name=enable][value=Y]').attr('checked', true);
        $('input:radio[name=closed][value=N]').attr('checked', true);

         //활성화 처리
        $("#appvDocClass").attr("disabled",false);  //문서종류
        $("#appvDocType").attr("disabled",false);  //문서타입
		$("input[name = 'decisionYn'][value = 'Y']").prop("checked",true);
		$("input[name = 'decisionYn']").prop("disabled",true);


        $("#lineTable tbody").html("<tr><td id=\"lineTableNoData1\"  colspan=\"8\" class=\"no_result\">조회된 데이터가 없습니다.</td></tr>");


    }

    //결재헤더 저장
    function doSaveAppHeader(){
    	var appvDocClass = $("#appvDocClass").val().trim();
    	var appvDocType = $("#appvDocType").val().trim();
    	if(appvDocClass == ""){  //문서종류
    		alert("문서종류를 선택하여 주시기 바랍니다.");
    		$("#appvDocClass").focus();
    		return;
    	}else if(appvDocType == ""){  //문서타입
            alert("문서타입을 선택하여 주시기 바랍니다.");
            $("#appvDocType").focus();
            return;
        }
		if(!$("#appvHeaderName").prop("disabled")){
	    	if($("#appvHeaderName").val() == ""){
	    		alert("결재라인명을 입력하여 주시기 바랍니다.");
	    		$("#appvHeaderName").focus();
	    		return;
	    	}
		}
    	//금액 FROM, TO

    	var decisionYn = $("input[name = 'decisionYn']:checked").val();

        if(appvDocClass == "BUY"&&decisionYn=="Y"){  //구매신청
        	if($("#minAmount").val() == ""){
        		alert("금액(from)을 입력하여 주시기 바랍니다.");
                $("#minAmount").focus();
                return;
        	}else if($("#maxAmount").val() == ""){
        		alert("금액(to)을 입력하여 주시기 바랍니다.");
                $("#maxAmount").focus();
                return;
            }
        	var minAmount = $("#minAmount").val().split(",").join("");
        	var maxAmount = $("#maxAmount").val().split(",").join("");
        	if(parseInt(minAmount) >= parseInt(maxAmount)){
        		alert("금액(from)이 금액(to)보다 큰값은 입력하실수 없습니다.");
                $("#minAmount").focus();
                return;
        	}
        }

         //비활성화 활성화처리
        $("#appvDocClass").attr("disabled",false);  //문서종류
        $("#appvDocType").attr("disabled",false);  //문서타입

        $("#minAmount").val($("#minAmount").val().split(",").join(""));
        $("#maxAmount").val($("#maxAmount").val().split(",").join(""));
        var url = contextRoot + "/approve/doSaveApproveHeader.do";
        $('#frmApprove').attr('action', url);
        commonAjaxSubmit("POST", $("#frmApprove"), doSaveAppHeaderCallback);
    }

    //결재헤더 저장 Ajax 콜백
    function doSaveAppHeaderCallback(result){
    	if(result.result == "SUCCESS"){
    		//toast.push("저장OK!");
    		alert("정상적으로 저장되었습니다.");
    		getAppHeaderList();
    		setInsFormAppHeader();
    		getAppLineList();
    	}else if(result.result == "DUPLICATE"){
            alert("중복된 결재라인이 존재합니다. 문서종류, 문서타입 , 결재라인명을 확인하시기 바랍니다.");
        }else if(result.result == "BUY_AMOUNT_DUP"){
            alert("구매금액의 구간이 중첩됩니다. 금액을 확인하시기 바랍니다.");
        }else if(result.result == "FAIL"){
        	alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
    	}

    }

  //결재라인 수정폼 활성화
    function setUpdFormAppHeader(trObj, appvHeaderId, appvDocClass, appvDocType, appvHeaderName, minAmount, maxAmount, enable, closed,decisionYn){
        this.setSelectedApprovalHeaderCss(trObj);

        $("#frmLine input[name='appvHeaderId']").val(appvHeaderId);
        $("#frmApprove input[name='appvHeaderId']").val(appvHeaderId);
        //결재라인 수정폼 값 셋팅
        $("#actionType").val("UPDATE");
        $("#appvDocClass").val(appvDocClass);  //문서종류
        $("#appvDocClass").trigger("change");
        $("#appvDocType").val(appvDocType);  //문서타입

        $("#appvHeaderName").val(appvHeaderName); //결재라인명

        //금액 관련 필드들 셋팅 :S
        if(minAmount!="")
        	$("#minAmount").val(parseInt(minAmount).toLocaleString('en').split(".")[0]);
        else
        	$("#minAmount").val('');

        if(maxAmount!="")
        	$("#maxAmount").val(parseInt(maxAmount).toLocaleString('en').split(".")[0]);
        else
        	$("#maxAmount").val('');

        if(decisionYn!="") {
        	$("input[name='decisionYn'][value='"+decisionYn+"']").prop("checked",true);

        	decisionYnChk();
        	//$("input[name='decisionYn'][value='"+decisionYn+"']").click();
        }
      	//금액 관련 필드들 셋팅 :E

        $('input:radio[name=enable][value='+ enable +']').attr('checked', true);
        $('input:radio[name=closed][value='+ closed +']').attr('checked', true);

        //비활성화 처리
        $("#appvDocClass").attr("disabled","disabled");  //문서종류
        $("#appvDocType").attr("disabled","disabled");  //문서타입

        //금액 활성화 처리
        //setAmountDisabled(appvDocClass);

        //결재라인 상세정보 조회
        getAppLineList();
    }

    //결재라인 상세정보
    //결재라인 검색
    function getAppLineList() {
        var url = contextRoot + "/approve/getApproveLineListAjax.do";
        $('#frmApprove').attr('action', url);
        commonAjaxSubmit("POST", $("#frmApprove"), getAppLineListCallback);
    }

    //결재라인 검색 Ajax 콜백
    function getAppLineListCallback(result){
        $("#listArea2").empty();
        $("#listArea2").html(result);


        if("${baseUserLoginInfo.orgBasicAuth}" == "READ"){
        	$(".btn_auth").hide();
        }

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
	    trHtml += '        <input type="text" id="appVoList.appvSeq" name="appVoList.appvSeq"  value=""  maxlength="4"  class="input_b w_st06" title="승인순서입력" />';
	    trHtml += '    </td>';
	    trHtml += '    <td class="txt_center">';
	    /* trHtml += '        <span id="appvClassTag">'; */
	    trHtml += '    <select id="appVoList.appvClass" name="appVoList.appvClass" class="select_b w100pro" title="승인방식선택">';
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
	    trHtml += '        <select id="appVoList.appvLineType" name="appVoList.appvLineType" onChange="changeAppvLineType(this);" class="select_b w100pro" title="결재유형선택">';
	    trHtml += '            <option value="" selected>결재유형선택</option>';
	    <c:forEach var="cmmCd2" items="${cmmCdAppvLineTypeList}" varStatus="status2">
	        trHtml += '        <option value="${cmmCd2.cd}">${cmmCd2.nm}</option>';
	    </c:forEach>
	    trHtml += '        </select>';
	    trHtml += '    </td>';
	    trHtml += '    <td>';
	    trHtml += '        <span id="spanSelectAppvLineBtn"></span>';
	    trHtml += '        <span id="spanAppvLineDisplayNm"></span>';
	    trHtml += '    </td>';
	    trHtml += '    <td class="txt_center"></td>';
	    /* trHtml += '    <td class="txt_center"></td>'; */
	    trHtml += '    <td class="txt_center"><button type="button" onClick="deleteRowLine(this);" class="btn_s_type_g btn_auth">삭제</button></td>';
	    trHtml += '</tr>';

	    if($('#lineTableNoData').length > 0){
	        $('#lineTable > tbody:last > tr:last').remove();
	    }

	    $('#lineTable').append(trHtml);
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
            alert("소속부서 이후에 상위부서를 결재순서로 지정해야 합니다.");
            resetApprovalLine(selectedInx);
            $(obj).val("");
            return;
        }
        else if(validateDeptApprovaTypeResult == 2) {
            alert("소속부서는 중복지정할 수 없습니다.");
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

    var myModal = new AXModal();    // instance
    myModal.setConfig({contentDivClass: "popup_outline"});		//팝업창 내용에 맞게 보이게 하기위해
    var selUserIndex = -1;          //직원배정을 위해 직원선택 팝업시킨 row 의 index.
    var selUserType = "DEPT";

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


    	        selUserType = knd;
				if(selUserType=="DEPT"){
    	        	paramObj ={ name : 'isDeptSelect' ,value : 'Y'};
	    	        paramList.push(paramObj);  //부서 단일 선택
				}else if(selUserType == "USER"){
					paramObj ={ name : 'hasDeptTopLevel' ,value : 'Y'};
	    	        paramList.push(paramObj);  //부서의 회장 부서 표시여부
				}

				paramObj ={ name : 'isAppoveLineAdd' ,value : 'Y'};
    	        paramList.push(paramObj);  //결재 라인 결재자 공개여부

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
    	            top: $(window).scrollTop() + 150,
    	            width: 750,
    	            closeByEscKey: true             //esc 키로 닫기
    	        }); */
    	        //$('#myModalCT').draggable();
    	    },
    	    //사원 및 부서 선택 팝업에서 선택한 데이터를 처리
		    getResult: function(list){

		    	fnObj.actionBySelData(list);
		    },
    	    //사원 및 부서 선택 팝업에서 선택한 데이터를 처리
    	    actionBySelData: function(listObj){
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
                    $(appvLineDisplayNmSpan ).html(listObj[0].userNm);
    	    	}else if(selUserType == "DEPT"){
                    $(deptIdInput           ).attr("value", listObj[0].deptId);
                    $(appvUserIdInput       ).attr("value", "");
                    $(appvLineDisplayNmSpan ).html(listObj[0].deptNm);
                }
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
	}

	//결재라인 저장
    function doSaveAppLine(){

    	if($("#frmApprove input[name='appvHeaderId']").val() == ""){
            alert("먼저 상단의 결재라인을 선택하여 주시기 바랍니다.");
            return;
        }

    	var appLineCnt = $("#frmLine input[name='appVoList.deptId']").length;

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
			alert("승인방식 '결재'를 한건 이상 등록하셔야 합니다.");
			return;
		}else{
			if(agreeMinSeq != "agree"){
				if(parseInt(approveMaxSeq)>=parseInt(agreeMinSeq)){
					alert("승인박식 '합의'의 승인순서는 '결재'이후이어야 합니다. ");
					return;
				}
			}
		}

        //저장을 위한 Object 순번 부여
        this.setIdxApproveLineObjectForSave();

        $("#frmLine input[name='appvHeaderId']").val($("#frmApprove input[name='appvHeaderId']").val());
        var url = contextRoot + "/approve/doSaveApproveLine.do";
        $('#frmLine').attr('action', url);
        commonAjaxSubmit("POST", $("#frmLine"), doSaveAppLineCallback);
    }

    //결재라인 저장 Ajax 콜백
    function doSaveAppLineCallback(result){
        if(result.result == "SUCCESS"){
            //toast.push("저장OK!");
            alert("정상적으로 저장되었습니다.");
            getAppLineList();  //결재라인 상세정보 조회
        }else if(result.result == "FAIL"){
            alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
        }
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

    //구매 > 금액 > 전결규정 선택
    function decisionYnChk(){
    	var decisionYn = $("input[name = 'decisionYn']:checked").val();

    	if(decisionYn == "N"){
    		$("#minAmount").val("");
    		$("#maxAmount").val("");
    		$("#minAmount").attr("disabled",true);
            $("#maxAmount").attr("disabled",true);
            $("#appvHeaderName").attr("disabled",false);
    	}else if(decisionYn == "Y"){
    		$("#minAmount").attr("disabled",false);
            $("#maxAmount").attr("disabled",false);
            $("#appvHeaderName").attr("disabled",true);
    	}
    }
	//결재라인 복사 팝업 오픈
	function openCopyAppvLinePop(){
		var url = "<c:url value='/approve/copyApproveLinePop.do'/>";
    	var params = { orgId : $("select[name='orgId']").val() };

    	myModal2.open({
    		windowID:"myModalCT",
			url: url,
			pars: params,
			titleBarText: '결재라인 복사',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
			method:"POST",
			top: $(window).scrollTop() + 150,
			width: 500,
			closeByEscKey: true			//esc 키로 닫기
    	});

    	$('#myModalCT').draggable();
	}
</script>
