<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
//탭 이동
function moveTab(type){
    $("#actionType").val(type);
    $("#moveTabArea").find("li").removeClass();

    var targetLi = type + "Li"; // //expenseLi

    $("#"+targetLi).addClass("current");

    doSearch();
}
// 조회
function doSearch(){
    var url = "";
    // 지출입력설정
    if( $("#actionType").val()=="expense" ){
        url = contextRoot+"/card/cardExpenseSetupAjax.do";
        $("#tabFrm").attr("action", url);
        commonAjaxSubmit("POST", $("#tabFrm"), searchCallback);
    // 법인카드 설정
    }else{
        url = contextRoot+"/card/getCorporationCardSetupMainAjax.do";
        $("#tabFrm").attr("action", url);
        commonAjaxSubmit("POST", $("#tabFrm"), searchCorpCallback);
    }
}

// 리셋콜백
function searchCallback(data){
    $("#expenseBodyArea").html(data);
    setCardCorpInfoArea();  // 법인카드 등록
}

//리셋콜백
function searchCorpCallback(data){
	$("#expenseBodyArea").html(data);
	setCardCorpInfoArea();  // 법인카드 등록
    setCardCorpSetupArea(); // 법인카드 사용내역 연동기능 사용여부

}

//법인카드 등록 영역 화면 표시
function setCardCorpInfoArea(){
    var url = contextRoot + "/card/cardCorpInfo.do";
    $("#cardCorpInfoBodyFrm").attr("action", url);
    commonAjaxSubmit("POST", $("#cardCorpInfoBodyFrm"), setCardCorpInfoAreaCallback);
}
//법인카드 등록 영역 화면 표시 Callback
function setCardCorpInfoAreaCallback(data){
    $("#cardCorpInfoArea").html(data);
    initCardCorpInfoArea();
}

function initCardCorpInfoArea(){
    var colorObj = {};
    var comCardCompany = getBaseCommonCode('CARD_COMPANY', null, 'CD', 'NM', '', '선택','SELECT', { orgId : "${baseUserLoginInfo.applyOrgId}" });
    var docStatusTypeTag = createSelectTag('cardCompany', comCardCompany, 'CD', 'NM', '${searchMap.cardCompany}', null, colorObj, 100, 'search_type2 mgl8');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)

    $(".cardCorpInfoInput").hide(); // (수정)input박스
    $("#cardCompanyTag").html(docStatusTypeTag); // 카드사
    var t1 = $("input[name='cardNo']").val();

    if( $("input:radio[name='orgCardLinkYn']:checked").val() == "Y" ){
        if( "${getCardCorpSetup.orgCardLinkYn}" == "Y" ){
            $("#loadInfoBtn").show();
        }
    }else if( $("input:radio[name='orgCardLinkYn']:checked").val() == "N" ){
        $("#loadInfoBtn").hide();
    }
}

//법인카드 사용내역 연동 기능 사용여부 화면 표시
function setCardCorpSetupArea(){
    var url = contextRoot + "/card/cardCorpSetupAjax.do";
    $("#cardCorpInfoBodyFrm").attr("action", url);
    commonAjaxSubmit("POST", $("#cardCorpInfoBodyFrm"), setCardCorpSetupAreaCallback);
}
//법인카드 등록 영역 화면 표시 Callback
function setCardCorpSetupAreaCallback(data){
    $("#cardCorpSetupArea").html(data);
    initCardCorpSetupArea();
}

function initCardCorpSetupArea(){
    var colorObj = {};
    var comLinkCorpCode = getBaseCommonCode('LINK_CORP_CODE', null, 'CD', 'NM', null, '선택','SELECT', { orgId : "${baseUserLoginInfo.applyOrgId}" });
    var agentTag = createSelectTag('linkCorpCode', comLinkCorpCode, 'CD', 'NM', '${searchMap.linkCorpCode}', null, colorObj, 100, 'search_type2 mgl8');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)

    $("#agentSelectTag").html(agentTag); // (select)대행업체

    var bizNo = $("#bizNo").val().replace(/\-/g, '');

    if( $("input:radio[name='orgCardLinkYn']:checked").val() == "Y" ){

        $("#bizNum1").val(bizNo.substr(0,3));
        $("#bizNum2").val(bizNo.substr(3,2));
        $("#bizNum3").val(bizNo.substr(5,5));

        if( "${getCardCorpSetup.orgCardLinkYn}" == "Y" ){
            $("#loadInfoBtn").show();
        }
    }else if( $("input:radio[name='orgCardLinkYn']:checked").val() == "N" ){

            $("#loadInfoBtn").hide();
            $("#bizNum1").val(bizNo.substr(0,3));
            $("#bizNum2").val(bizNo.substr(3,2));
            $("#bizNum3").val(bizNo.substr(5,5));

            $(".disableUse").prop("disabled", true);      // disabled
            $("#linkCorpCode").prop("disabled", true);    // (select)disabled
    }

    if(getOrgAccessAuth("${baseUserLoginInfo.applyOrgId}") == 'READ')  $(".authChk").prop("disabled", true);      // disabled


}


//-- include로 인한 초기화면 세팅을 여기서 처리함
    // 직원선택 삭제
    function deleteInfoEmp(obj){
        var span = $(obj).parent();
        span.remove();
    }

    // 직원선택
    var g_userType = "";
    var g_spanKey  = "";
    var g_appvKey  = "";
    var g_userTargetType  = "EXPENSE";
    var indexParam = "";
    //-- 분기(법인카드등록/지출입력설정)



//-- 법인카드등록
function doSaveCard(type, index){
    var url = contextRoot + "/card/processCardCorpor.do";
    var cardCorpInfoId  = $("#"+type).find("input[name='cardCorpInfoId']").val();          // cardCorpInfoId
    var cardCompany     = $("#"+type).find("[name='cardCompany']").val();                  // 카드사

    var cardNum1Chk     = $("#cardNum1"+index);                                            // 카드번호1
    var cardNum2Chk     = $("#cardNum2"+index);                                            // 카드번호2
    var cardNum3Chk     = $("#cardNum3"+index);                                            // 카드번호3
    var cardNum4Chk     = $("#cardNum4"+index);                                            // 카드번호4
    var cardNum         =      cardNum1Chk.val()
                          +"-"+cardNum2Chk.val()
                          +"-"+cardNum3Chk.val()
                          +"-"+cardNum4Chk.val();

    var cardNickname    = $("#"+type).find("input[name='cardNickname']").val();            // 카드별명
    var cardOwnerUserId = $("#arrUserId").val();                                           // 소유자
    var useYn           = $("#"+type).find("input[name='useYn_"+type+"']:checked").val();  // 사용여부
    var comment         = $("#"+type).find("input[name='comment']").val();                 // 코멘트

    if( type=="new" ){

        cardNum1Chk = $("#cardNum1");                                      // 카드번호1
        cardNum2Chk = $("#cardNum2");                                      // 카드번호2
        cardNum3Chk = $("#cardNum3");                                      // 카드번호3
        cardNum4Chk = $("#cardNum4");                                      // 카드번호4

        cardNum = cardNum1Chk.val()+"-"+cardNum2Chk.val()+"-"+cardNum3Chk.val()+"-"+cardNum4Chk.val();
        // 카드사
        if( cardCompany=="" ){
            alert("카드사를 입력하여주세요");
            //$("#cardCompanyTag").find("#cardCompany").focus();
            $("input[name='cardCompany']").focus();
            return;
        }
        // 카드번호
        if( cardNum1Chk.val()=="" || cardNum2Chk.val()=="" || cardNum3Chk.val()=="" || cardNum4Chk.val()=="" || cardNum.length !=19 ){
            alert("카드번호를 입력해주세요");
            if( cardNum1Chk.val().length !="4" ) cardNum1Chk.focus();
            if( cardNum2Chk.val().length !="4" ) cardNum2Chk.focus();
            if( cardNum3Chk.val().length !="4" ) cardNum3Chk.focus();
            if( cardNum4Chk.val().length !="4" ) cardNum4Chk.focus();
            return;
        }
        // 카드별명
        if( cardNickname=="" ){
            alert("카드별명을 입력해주세요");
            $("input[name='cardNickname']").focus();
            return;
        }
        // 소유자
        if( cardOwnerUserId=="" ){
            alert("소유자를 선택해주세요");
            $(".btn_select_employee").focus();
            return;
        }
    // 수정 -> 저장 클릭 시...
    }else{
        // 연동된카드정보에서 소유자가 없을 시...
        /* if( cardOwnerUserId == "" || cardOwnerUserId==undefined ){
        } */
        cardOwnerUserId = $("#cardOwnerUserId_"+index).val();
        cardCompany     = $("#cardCompany_"+index).val()
        //카드사
        if( cardCompany=="" ){
            alert("카드사를 입력하여주세요");
            //$("#cardCompany"+index).find("#cardCompany").focus();
            $("#cardCompany"+index).focus();
            return;
        }
        //카드번호
        if( cardNum1Chk.val()=="" || cardNum2Chk.val()=="" || cardNum3Chk.val()=="" || cardNum4Chk.val()=="" || cardNum.length !=19 ){
            alert("카드번호를 입력해주세요");
            if( cardNum1Chk.val().length !="4" ) $("#cardNum1"+index).focus();
            if( cardNum2Chk.val().length !="4" ) $("#cardNum2"+index).focus();
            if( cardNum3Chk.val().length !="4" ) $("#cardNum3"+index).focus();
            if( cardNum4Chk.val().length !="4" ) $("#cardNum4"+index).focus();
            return;
        }
        //카드별명
        if( cardNickname=="" ){
            alert("카드별명을 입력해주세요");
            $("#cardNickname"+index).focus();
            return;
        }
        //소유자
        if( cardOwnerUserId=="undefined" || cardOwnerUserId=="" ){
            alert("소유자를 선택해주세요.");
            $("#cardCorpInfoInput_"+index).focus();
            return;
        }
    }

    var param = {cardCorpInfoId  : cardCorpInfoId,
                 cardCompany     : cardCompany,
                 cardNum         : cardNum,
                 cardNickname    : cardNickname,
                 cardOwnerUserId : cardOwnerUserId,
                 useYn           : useYn,
                 comment         : comment}

    var callback = function(result){
        var obj  = JSON.parse(result);
        var cnt  = obj.resultVal;    // 결과수
        var rObj = obj.resultObject; // 결과 데이터

        if(rObj.result == "USERFAIL"){
            alert("이미 등록된 소유자입니다.\n카드 소유자는 카드당 1인만 선택가능합니다.");
            return;
        }else if(rObj.result == "NUMFAIL"){
            alert("이미 등록된 카드번호입니다.\n확인후 다시 입력해주세요.");
            return;
        }

        if( obj.result == "SUCCESS" ){
            setCardCorpInfoArea();
            alert("저장되었습니다.");
        }else{
            alertM("저장도중 오류가 발생하였습니다.");
            return;
        }

    };

    commonAjax("POST", url, param, callback);
}

//-- 저장/수정후 리프레쉬
function resetProc(){
    $("#cardCorpInfoFrm").attr("action", contextRoot+"/card/getCorporationCardSetupAjax.do");
    commonAjaxSubmit("POST", $("#cardCorpInfoFrm"), resetProcCallback);
}

//-- 저장/수정후 리프레쉬 콜백
function resetProcCallback(data){
    $("#cardCorpInfoArea").html(data); // 리프레쉬 -> HTML을 그려줌
    $(".cardCorpInfoInput").hide();    // 카드사 셀렉트박스
}

//-- 수정 영역 활성화
function showUpdateForm(type,index){
    $(".cardCompanyView").show();
    $(".cardCorpInfoInput").hide();
    //$(".cardCompanyView").show();
    $("input[name=cardNum]").prop("readonly", false); // 연동'N'-> readonly(카드사)
    $("input[name=cardNum]").prop("readonly", false); // 연동'N'-> readonly(카드번호)

    $("#"+type).find(".cardCompanyView").hide();
    //$("#"+type).find(".cardCompanyView_"+index).hide();
    $("#"+type).find(".cardCorpInfoInput").show();
    //$("#"+type).find(".cardCorpInfoInput_"+index).show();

    // 초기화 버튼
    $("#"+type).find("#btnReset").click(function(){
        reset(type);
    });

    // 사용여부
    $("input[name='useYn_"+type+"']").prop("disabled", false);

    // 카드사
    //$("#cardCompanyTag"+index).find("#cardCompany").val($("#cardCompany_"+index).val());
    $("#cardCompany").val($("#cardCompany_"+index).val());

    // 소유자
    $("#arrUserId").val($("#cardOwnerUserId_"+index).val());

    // 연동'Y'-> readonly
    if( $("input[name=cardLinkYn_"+index+"]").val()=="Y" ){
        $("input[name=cardNum]").prop("readonly", true);
        $("input[name=cardCompanyModi]").prop("readonly", true);
    }
}

//-- 새로고침버튼
function reset(type){
    if( type == "new" ){
        $("#"+type).find("input[name='cardNum']").val("");      // 카드번호
        $("#"+type).find("input[name='cardNickname']").val(""); // 카드별명
        $("#"+type).find("input[name='comment']").val("");      // 비고
        $("#"+type).find("input[name='useYn_"+type+"'][value='Y']").prop("checked",true);
    }else{
        $("input[name='useYn_"+type+"']").prop("disabled", true);

        $("#cardCompany_"+type+"").prop("selected", "true");

        $(".AXanchorNumberContainer").remove();
        $(".AXanchor").remove();
    }

    $(".cardCompanyView").show();
    $(".cardCorpInfoInput").hide();
}

//-- 삭제
function deleteCard(cardCorpInfoId){
    var url   = contextRoot + "/card/deleteCardCorpInfo.do";
    var param = {cardCorpInfoId : cardCorpInfoId};

    if( !confirm("삭제하시겠습니까?") ) return;

    var callback = function(result){
        var obj = JSON.parse(result);
        var cnt = obj.resultVal; //결과수
        if( obj.result == "SUCCESS" ){
            resetProc();
            alert("삭제되었습니다.");
        }else{
            alertM("삭제도중 오류가 발생하였습니다.");
            return;
        }
    };

    commonAjax("POST", url, param, callback);
}

//숫자 체크
function cardNumChk($obj){
    if( $obj.val()!=""&&!strInNum($obj.val()) ){
        alert("숫자만 입력 가능합니다.");
        $obj.val("");
    }
}

//////////////////////////////////////////////////////////
//이인희 추가
///////////////////////////////////////////////////////////
//연동된 법인 카드정보 불러오기
// linkAuthCode(연동인증코드), corpNum(사업자등록번호), cardInputSetupId(법인카드연동정보ID)
function getCorporationCardLinkList(){
    /*
    var cardCorpSetupId = $("#cardCorpSetupId").val();
    if( cardCorpSetupId==null || cardCorpSetupId=="undefined" ){
        alert("연동저장 후 사용 후 가능합니다.");
        return;
    }
    */
    var url = contextRoot+"/card/getCorporationCardLinkListAjax.do";
    $("#linkAgefrm").attr("action", url);
    commonAjaxSubmit("POST", $("#linkAgefrm"), getCorporationCardLinkListCallback);
}

//리셋콜백
function getCorporationCardLinkListCallback(data){
    if(data.resultMsg == "FAIL"){
        alert("카드정보 불러오기에 실패하였습니다 \n연동정보를 다시 확인하신 후 재실행하시기 바랍니다." );
    }else{
    	alert("카드정보 불러오기를 정상적으로 완료하였습니다." );
        //$("#expenseBodyArea").html(data);
        setCardCorpInfoArea();  // 법인카드 등록
        setCardCorpSetupArea(); // 법인카드 사용내역 연동기능 사용여부
    }
}
/////////////////////////////////////////////////////////
// cardCorpSetupSetting_INC.jsp
////////////////////////////////////////////////////////

//-- 연동정보 사용여부
function linkageYn(id){
    var cardCorpSetupId = $("#cardCorpSetupId").val();

    if( id=="Y" ){
        $(".disableUse").prop("disabled", false);     // disabled
        $("#linkCorpCode").prop("disabled", false);   // (select)disabled

        $(".cardLinkYnView").show(); // 연동여부 셀

        if( cardCorpSetupId != "" ){
            //$("#loadInfoBtn").show();
            doSaveLinkage('update');
        }

    }else{


        $(".disableUse").prop("disabled", true);      // disabled
        $("#linkCorpCode").prop("disabled", true);    // (select)disabled

        $("#loadInfoBtn").hide(); // 카드정보불러오기

        if( cardCorpSetupId !="" ){
            if( confirm("해지 하시면 법인카드 승인내역을\n  자동으로 받을 수 없습니다\n  연동을 해지하시겠습니까?") ){
                doCancelLinkage(cardCorpSetupId);
                $(".cardLinkYnView").hide();
            }else{
                // 취소 시...강제로 풀어줌
                $("input:radio[name='orgCardLinkYn'][value='Y']").prop('checked', true);
                $(".disableUse").prop("disabled", false);     // disabled
                $("#linkCorpCode").prop("disabled", false);   // (select)disabled

            }
        }
    }
}

//-- 연동정보 수정(해지)
function doCancelLinkage(linkAgeCancelId){
    var url             = contextRoot + "/card/updateCardLkCancel.do";
    var corpNum         = $("input[name='bizNum1']").val()+"-"+$("input[name='bizNum2']").val()+"-"+$("input[name='bizNum3']").val();
    var linkCorpCode    = $("select[name='linkCorpCode']").val();       // 연동대행업체
    var orgCardLinkYn   = $("input[name=orgCardLinkYn]:checked").val(); // 관계사법인카드연동여부
    var linkAuthCode    = $("input[name='linkAuthCode']").val();        // 연동인증코드
    var linkAuthId      = $("input[name='linkAuthId']").val();          // 연동인증ID
    var linkAuthPw      = $("input[name='linkAuthPw']").val();          // 연동인증비밀번호
    var linkAgeCancelId = linkAgeCancelId;                              // 해지

    if( corpNum.length=="2" ) corpNum = "";

    // 해지
    //if( cardCorpSetupId !="" && orgCardLinkYn=="N" ){
    if( linkAgeCancelId !="" && orgCardLinkYn=="N" ){
        //-- 연동저장 체크
//      if( confirm("해지 하시면 법인카드 승인내역을\n  자동으로 받을 수 없습니다\n  연동을 해지하시겠습니까?") ){
            var param = {cardCorpSetupId : linkAgeCancelId,
                         corpNum         : corpNum,
                         linkCorpCode    : linkCorpCode,
                         orgCardLinkYn   : orgCardLinkYn,
                         linkAuthCode    : linkAuthCode,
                         linkAuthId      : linkAuthId,
                         linkAuthPw      : linkAuthPw
                        }

        commonAjax("POST", url, param, doCancelLinkageCb);
    }
}

// 연동정보 수정(해지) 콜백
function doCancelLinkageCb(result){
    var obj = JSON.parse(result);
    var cnt = obj.resultVal; // 결과수
    if( obj.result == "SUCCESS" ){
        alert("연동 해지되었습니다.");
        cardCorpSearch();
    }else{
        alertM("해지도중 오류가 발생하였습니다.");
        return;
    }
}

//연동정보 등록
function doSaveLinkage(type){
    var url             = contextRoot + "/card/processCardLinkage.do";
    var corpNum         = $("input[name='bizNum1']").val()+"-"+$("input[name='bizNum2']").val()+"-"+$("input[name='bizNum3']").val();
    var linkCorpCode    = $("select[name='linkCorpCode']").val();       // 연동대행업체
    var orgCardLinkYn   = $("input[name=orgCardLinkYn]:checked").val(); // 관계사법인카드연동여부
    var linkAuthCode    = $("input[name='linkAuthCode']").val();        // 연동인증코드
    var linkAuthId      = $("input[name='linkAuthId']").val();          // 연동인증ID
    var linkAuthPw      = $("input[name='linkAuthPw']").val();          // 연동인증비밀번호
    var cardCorpSetupId = $("#cardCorpSetupId").val();                  // 법인카드연동정보ID

    //-- 연동정보 키가 있고 해지 후 사용으로 하는 경우...
    if( type=="update" ){
        var param = {
                    cardCorpSetupId : cardCorpSetupId,
                    corpNum         : corpNum,
                    linkCorpCode    : linkCorpCode,
                    orgCardLinkYn   : orgCardLinkYn,
                    linkAuthCode    : linkAuthCode,
                    linkAuthId      : linkAuthId,
                    linkAuthPw      : linkAuthPw
                    }
        commonAjax("POST", url, param, doUpdateLinkageCb);
    }else{
        //-- 연동저장 체크
        if( linkAuthChk() ){
            if( confirm("저장 하시겠습니까?") ){
                var param = {
                             cardCorpSetupId : cardCorpSetupId,
                             corpNum         : corpNum,
                             linkCorpCode    : linkCorpCode,
                             orgCardLinkYn   : orgCardLinkYn,
                             linkAuthCode    : linkAuthCode,
                             linkAuthId      : linkAuthId,
                             linkAuthPw      : linkAuthPw
                            }

            commonAjax("POST", url, param, doSaveLinkageCb);
            }else return;
        }
    }
}

//연동정보 등록 콜백
function doSaveLinkageCb(result){
    var obj = JSON.parse(result);
    if( obj.resultObject.result == "SUCCESS" ){
        alert("정상 연동되었습니다.");
        $("#loadInfoBtn").show(); // 카드정보 불러오기 버튼보이기
        setCardCorpSetupArea();
    }else{
    	alert("일치하는 연동 정보가 없습니다. \n다시 확인 후 입력해 주세요.");
        return;
    }
}

//연동정보 등록 콜백
function doUpdateLinkageCb(result){
    var obj = JSON.parse(result);
    var cnt = obj.resultVal; // 결과수
    if( obj.result == "SUCCESS" ){
        $("#loadInfoBtn").show(); // 카드정보 불러오기 버튼보이기
        setCardCorpSetupArea();
    }else{
        alert("연동중 오류가 발생하였습니다.");
        return;
    }
}

// 조회
function cardCorpSearch(){
    $("#linkAgefrm").attr("action", contextRoot+"/card/cardCorpSetupAjax.do");
    commonAjaxSubmit("POST", $("#linkAgefrm"), cardCorpSearchCallback);
}

//-- 저장/수정후 리프레쉬 콜백
function cardCorpSearchCallback(data){
    $("#linkAgefrm").html(data); // 리프레쉬 -> HTML을 그려줌
    initCardCorpSetupArea();
}

// 연동저장 체크
function linkAuthChk(){
    var corpNum1Chk     = $("input[name='bizNum1']");                // 사업자번호1
    var corpNum2Chk     = $("input[name='bizNum2']");                // 사업자번호2
    var corpNum3Chk     = $("input[name='bizNum3']");                // 사업자번호3
    var corpNumChk      = corpNum1Chk.val() +"-"+ corpNum2Chk.val() +"-"+ corpNum3Chk.val(); // 사업자번호('-'포함 12자리)
    var linkAuthCodeChk = $("input[name='linkAuthCode']");           // 연동인증코드
    var linkAuthIdChk   = $("input[name='linkAuthId']");             // 연동인증ID
    var linkAuthPwChk   = $("input[name='linkAuthPw']");             // 연동인증비밀번호
    // 사업자번호 공백
    var str_space = /\s/;

    if( str_space.exec(corpNum1Chk.val()) ){
        alert('공백은 사용할 수 없습니다.');
        corpNum1Chk.val("");
        corpNum1Chk.focus();
        return;
    }
    if( str_space.exec(corpNum2Chk.val()) ){
        alert('공백은 사용할 수 없습니다.');
        corpNum2Chk.val("");
        corpNum2Chk.focus();
        return;
    }
    if( str_space.exec(corpNum3Chk.val()) ){
        alert('공백은 사용할 수 없습니다.');
        corpNum3Chk.val("");
        corpNum3Chk.focus();
        return;
    }

    if( corpNum1Chk.val()=="" || corpNum2Chk.val()=="" || corpNum3Chk.val()=="" || corpNumChk.length !=12 ){
        alert("귀하의 사업자 번호를 입력해주세요");
        if( corpNum1Chk.val().length !="3" ) corpNum1Chk.focus();
        if( corpNum2Chk.val().length !="2" ) corpNum2Chk.focus();
        if( corpNum3Chk.val().length !="5" ) corpNum3Chk.focus();
        return;
    }

    if( linkAuthCodeChk.val()=="" ){
        alert("인증코드를 입력해주세요");
        linkAuthCodeChk.focus();
        return;
    }

    if( linkAuthIdChk.val()=="" ){
        alert("아이디를 입력해주세요");
        linkAuthIdChk.focus();
        return;
    }

    if( linkAuthPwChk.val()=="" ){
        alert("비밀번호를 입력해주세요");
        linkAuthPwChk.focus();
        return;
    }

    return true;
}

// 숫자 체크
function isNumChk($obj){
    if($obj.val()!=""&&!strInNum($obj.val())){
        alert("숫자만 입력 가능합니다.");
        $obj.val("");
    }
}

// 숫자+영문+하이픈 체크
function setNumChk($obj){
    var linkAuthCd = $obj.val();
    var regexp     = /[0-9a-zA-Z-]/; // 숫자+영문+특수문자

    for( var loop=0; loop<linkAuthCd.length; loop++ ){
        if( linkAuthCd.charAt(loop) !="" && regexp.test(linkAuthCd.charAt(loop)) == false ){
            alert("영문 및 특수문자('-')제외 한 입력은 불가합니다.");
            return;
            break;
        }
    }
}

// 초기화
function linkageReset(){
    $('input[type="text"]').val("");
    $('input[type="password"]').val("");
}

//직원선택 삭제
function deleteEmp(obj){
    var span = $(obj).parent();
    span.remove();
}

//저장
function doSaveCardExpenseSetup(){
    var chk = true;
    var url = contextRoot+"/card/processCardExpenseSetup.do";

    if( $("input[name='arrUserId']").length==0 ){
        alert("승인자를 등록해주세요.");
        $('a:has(em)').focus();
        return;
    }

    if( $("input[name='staffDeptId']").length==0 ){
        alert("관리부서를 등록해주세요.");
        $('a:has(em)').focus();
        return;
    }

    if( $("#note").val().trim()=="" ){
        alert("지출입력을 입력해주세요.");
        $("#note").focus();
        return;
    }

    if( confirm("저장하시겠습니까?") ){
        $("#frm").attr("action", url);
        commonAjaxSubmit("POST", $("#frm"), saveCardExpenseSetupCallback);
    }
}

// 저장콜백
function saveCardExpenseSetupCallback(data){
    if( data.resultObject.result =="SUCCESS" ){
        toast.push('저장되었습니다.');
        doSearch();
    }else{
        alert("서버오류");
        dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
    }
}

var fnObj = {

	    // 직원선택 팝업(1인만 지정)
	    openEmpPopup: function(){
	    	g_userTargetType  = "EXPENSE";

	        // 필수수신참조자 넣기 값: userId|APPV_DOC_CLASS|APPV_DOC_TYPE[또는 APPV_COMPANY_FORM_ID(사내서직인경우)]|RECEIVER[또는CC]|USER_ID값
	        var userStr = '';
	        var arr = [];
	        var selectUserList = $("input[name=arrUserId]");

	        for( var i=0; i<selectUserList.length; i++ ){
	            arr.push(selectUserList[i].value);
	        }

	        userStr = arr.join(',');
	        var paramList = [];

	        var paramObj = { name : 'userList', value : userStr};
	        paramList.push(paramObj);

	        paramObj = { name : 'hasDeptTopLevel' ,value : 'Y'};
	        paramList.push(paramObj); // 부서의 회장 부서 표시여부
	        // 단건선택
	        paramObj ={ name : 'isOneOrg' ,value : 'Y'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isAllOrg' ,value : 'N'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'oneOrg' ,value : '${baseUserLoginInfo.orgId}'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isCheckDisable' ,value : 'N'};
	        paramList.push(paramObj);
	        paramObj ={ name : 'isOneUser' ,value : 'Y'};
	        paramList.push(paramObj);

	        userSelectPopCall(paramList); // 공통 선택 팝업 호출
	    },

	 // 직원선택 팝업(1인만 지정)
        openEmpPopupCorp: function(userType, appvKey, spanKey,index){
        	g_userTargetType  = "CORP";

            g_userType = userType;
            g_appvKey = appvKey;
            g_spanKey = spanKey;

            indexParam = index;

            userStr = '';
            var arr = [];
            var selectUserList = $("input[name=arrUserId]");

            for( var i=0; i<selectUserList.length; i++ ){
                //selectUserList[i] = $("#cardOwnerUserId");
                arr.push(selectUserList[i].value);
            }

            userStr = arr.join(',');

            var paramList = [];

            var paramObj = { name : 'userList', value : userStr};
            paramList.push(paramObj);

            paramObj = { name : 'hasDeptTopLevel' ,value : 'Y'};
            paramList.push(paramObj); // 부서의 회장 부서 표시여부

            // 단건선택
            paramObj ={ name : 'isOneOrg' ,value : 'Y'};
            paramList.push(paramObj);
            paramObj ={ name : 'isAllOrg' ,value : 'N'};
            paramList.push(paramObj);
            paramObj ={ name : 'oneOrg' ,value : '${baseUserLoginInfo.orgId}'};
            paramList.push(paramObj);
            paramObj ={ name : 'isCheckDisable' ,value : 'N'};
            paramList.push(paramObj);
            paramObj ={ name : 'isOneUser' ,value : 'Y'};
            paramList.push(paramObj);

            userSelectPopCall(paramList); // 공통 선택 팝업 호출
        },

	    // 사원 및 부서 선택 팝업에서 선택한 데이터를 처리
	    getResult: function(resultList){
	    	if(g_userTargetType == "EXPENSE"){
	    		fnObj.getResultExpense(resultList);
	    	}else if(g_userTargetType == "CORP"){
	    		fnObj.getResultCorp(resultList);
	    	}else if(g_userTargetType == "DEPT"){
                fnObj.getResultDept(resultList);
            }


	    },

     // 사원 및 부서 선택 팝업에서 선택한 데이터를 처리
        getResultExpense: function(resultList){
            var usrHtml       = '';
            var spanName      = "";
            var inputUserName = "";

            // 이름 보여줄 곳
            spanName = "spanExpense";
            inputUserName = "";

            $("#"+spanName).html(""); // 리셋

            for( var i=0; i<resultList.length; i++ ){
                var orgNm = "";
                   if(resultList[i].orgId != '${baseUserLoginInfo.orgId}') orgNm = resultList[i].orgNm + "-";
                   else orgNm = "";

                   usrHtml = '';
                   usrHtml += '<span class="employee_list" >';
                   usrHtml += '<span>'+ resultList[i].userNm +'<em>('+ resultList[i].rankNm +')</em></span><a href="#" onClick="deleteEmp(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                   usrHtml += '<input type="hidden" name="arrUserId" id="arrUserId" value="'+inputUserName +resultList[i].userId+'"/>';
                   usrHtml += '</span>';

                   $("#"+spanName).append(usrHtml);
            }
        },
      //사원 및 부서 선택 팝업에서 선택한 데이터를 처리
        getResultCorp: function(resultList){

            //name의 val이 머머인것들...

            var usrHtml = '';
            var spanName = "";
            var inputUserName = "";
            if( g_userType == "EXPENSE" ){
                spanName = "spanExpense";
                inputUserName = "";
            }else if( g_userType == "CARD" ){
                spanName = "spanCard";  //이름 보여줄 곳
                inputUserName = "";
            }else{
                spanName = "spanCardModi_"+indexParam;  //이름 보여줄 곳
                inputUserName = "";
            }

            $("#"+spanName).html("");  //리셋



            if( spanName=="spanCardModi_"+indexParam ){

                for(var i=0;i<resultList.length ;i++){
                    var orgNm = "";
                       if( resultList[i].orgId != '${baseUserLoginInfo.orgId}' ) orgNm = resultList[i].orgNm + "-";
                       else orgNm = "";

                       usrHtml = '';
                       usrHtml += '<span class="cardCorpInfo_list" >';
                       //usrHtml += '<span>'+ resultList[i].userNm +'<em>('+ resultList[i].rankNm +')</em></span><a href="#" onClick="deleteEmp(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                       usrHtml += '<br>';
                       usrHtml += '<span>'+ resultList[i].userNm +'<em>('+ resultList[i].rankNm +')</em></span>';
                       usrHtml += '</span>';

                       $("#cardOwnerUserId_"+indexParam).val(resultList[i].userId);
                       $("#"+spanName).append(usrHtml);
                       //}

                }
            }else{

                for(var i=0;i<resultList.length ;i++){
                    var orgNm = "";
                       if( resultList[i].orgId != '${baseUserLoginInfo.orgId}' ) orgNm = resultList[i].orgNm + "-";
                       else orgNm = "";
                       usrHtml = '';
                       usrHtml += '<span class="cardCorpInfo_list" >';
                       //usrHtml += '<span>'+ resultList[i].userNm +'<em>('+ resultList[i].rankNm +')</em></span><a href="#" onClick="deleteEmp(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                       usrHtml += '<br>'
                       usrHtml += '<span>'+ resultList[i].userNm +'<em>('+ resultList[i].rankNm +')</em></span>';
                       //usrHtml += '<a href="#" onClick="deleteEmp(this);" class="btn_delete_employee"><em>삭제</em></a>';
                       usrHtml += '<input type="hidden" name="arrUserId" id="arrUserId" value="'+inputUserName +resultList[i].userId+'"/>';
                       usrHtml += '</span>';
                       $("#"+spanName).append(usrHtml);
                }

            }
            // 법인카드등록에서 소유자[직원선택] 'X'안나오게하기 위함
            /*if( g_userType == "CARD" ){
                $(".btn_delete_employee").hide();
            }*/
        },

      //부서선택 팝업
        openDeptPopup: function(type){

        	g_userTargetType  = "DEPT";
        	var arrDeptId = [];
        	arrDeptId.push($("#staffDeptId").val());

            var paramList = [];
            var paramObj ={ name : 'userList'   ,value :  arrDeptId.join() };
            paramList.push(paramObj);
            paramObj ={ name : 'isOneOrg' ,value : 'Y'};
            paramList.push(paramObj);
            paramObj ={ name : 'isAllOrgSelect' ,value : 'N'};  //관계사 직원 다중선택가능 옵션
            paramList.push(paramObj);
            paramObj ={ name : 'isDeptSelect' , value :  'Y'};  //직원,부서 옵션
            paramList.push(paramObj);
            paramObj ={ name : 'isOneDept' ,value : 'Y'};
            paramList.push(paramObj);

            userSelectPopCall(paramList);       //공통 선택 팝업 호출

        },
      //부서 선택
        getResultDept : function(resultList){
        	$("#spanExpenseDept").empty();

        	for(var i = 0 ; i <resultList.length; i++){
        		var usrHtml = '';
        		usrHtml += '<span class="employee_list" >';
                usrHtml += '<span>'+ resultList[i].deptNm +'</span><a href="#;" onClick="deleteEmp(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                usrHtml += '<input type="hidden" name="staffDeptId" id="staffDeptId" value="'+resultList[i].deptId+'"/>';
                usrHtml += '</span>';
                $("#spanExpenseDept").append(usrHtml);
        	}

        }


}

</script>
