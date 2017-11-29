<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/JavaScript" src="<c:url value='/js/process.js'/>" ></script>

<script type="text/javascript">
var contextRoot="${pageContext.request.contextPath}";
//데이트피커
var S_DatePickerOpt = {
    inline: true,
    dateFormat: "yy-mm-dd",    /* 날짜 포맷 */
    prevText: 'prev',
    nextText: 'next',
    showButtonPanel: true,    /* 버튼 패널 사용 */
    changeMonth: true,        /* 월 선택박스 사용 */
    changeYear: true,        /* 년 선택박스 사용 */
    showOtherMonths: true,    /* 이전/다음 달 일수 보이기 */
    selectOtherMonths: true,    /* 이전/다음 달 일 선택하기 */
    showOn: "button",
    /* buttonImage: "images/sp/btn_cal.gif", */
    buttonImage:  "<c:url value='/images/sp/btn_cal.gif'/>",
    buttonImageOnly: true,
    buttonText: "Calendar",
    minDate: '-100y',
    yearRange: 'c-99:c+99',
    closeText: '닫기',
    currentText: '오늘',
    showMonthAfterYear: true,        /* 년과 달의 위치 바꾸기 */
    /* 한글화 */
    monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    dayNames : ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
    showAnim: 'slideDown',
//  onSelect : function (SelDate) {
//  },
    /* 날짜 유효성 체크 */
    onClose: function( selectedDate ) {
        if($(this).attr('id') == 'ScheSDate') {
            $('#ScheEDate').datepicker("option","minDate", selectedDate).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
        }
        else $(this).next().next().datepicker("option","minDate", selectedDate).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
    }
};

$(document).ready(function(){
    $('#cstNm').focus();
    numberFormatForDigitClass();

    chkDomestic();

});
function clkPosition(txt){
    if(txt=='ceo'){
        $("#position").val('대표이사');
    }else{
        $("#chkCeo").removeAttr('checked');
        $("#position").val('');
    }
}
//국내외 구분
function chkDomestic(){
	var domesticYn = $("input[name = 'domesticYn']:checked").val();

	if(domesticYn == "Y"){
		$(".domestic").show();
		$(".overseas").hide();
	}else{
		$(".domestic").hide();
		$(".overseas").show();
	}
}
//Global variables :S ---------------

//공통코드
//var comCodeRoleCd;                //권한코드
//var comCodeMenuType;          //메뉴타입
var comCodeCstType;         //고객구분

//var myModal = new AXModal();  // instance
var orgId ="${baseUserLoginInfo.orgId}";
var applyOrgId ="${baseUserLoginInfo.applyOrgId}";
var myGrid = new SGrid();       // instance     new sjs
var myPaging = new SPaging();   // instance     new sjs
var mySorting = new SSorting(); // instance     new sjs

//div popup 방식을 위한 글쓰기,수정 위한 변수
var mode;                       //"new", "view", "update"

//Global variables :E ---------------
/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

    //################# init function :S #################
    //선로딩코드
    preloadCode: function(){
        //공통코드
        comCodeCstType = getBaseCommonCode('CUSTOMER_TYPE', null, 'CD', 'NM', null, null, null, { orgId : "${baseUserLoginInfo.applyOrgId}" });

        //'optionValue','optionText' 프로퍼티를 생성하며 값으로 CD, NM 의 값 할당
        //this.addComCodeArray(comCodeMenuType);
        var cstRadioTag = createRadioTag('rdCstType', comCodeCstType, 'CD', 'NM', '${cst.categoryPersonCd}', '', '', null); //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        $("#cstRadioTag").html(cstRadioTag);

        //담당자(직원)
        var paramStaffObj = {
        	orgId : orgId ,
        	mainYn : 'Y'
	    };
        var staffCusId = '${cst.managerId}';  //담당자
        if(staffCusId == "") staffCusId = '${baseUserLoginInfo.cusId}';

        var colorObj = {};  //{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
        var staffListObj = getCodeInfo(null, 'cusId', 'usrNm', null, null, null, '/common/getStaffListNameSort.do', paramStaffObj);
        var userSelectTag = createSelectTag('selStaff', staffListObj, 'cusId', 'usrNm', staffCusId, null, colorObj, 90, 'selUserStyle select_b');  //select tag creator 함수 호출 (common.js)
        $("#userSelectTag").html(userSelectTag);

        //공통코드 학교구분
        var comCodeSchoolType = getBaseCommonCode('SCHOOL_TYPE', null, 'CD', 'NM', '', '학교구분', null, { orgId : "${baseUserLoginInfo.applyOrgId}" });

        var schoolType1Tag = createSelectTag('schoolType1', comCodeSchoolType, 'CD', 'NM', '${customerSchoolList[0].schoolType}', null, colorObj, '', 'sel_ability');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        $("#schoolType1Tag").html(schoolType1Tag);
        var schoolType2Tag = createSelectTag('schoolType2', comCodeSchoolType, 'CD', 'NM', '${customerSchoolList[1].schoolType}', null, colorObj, '', 'sel_ability');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        $("#schoolType2Tag").html(schoolType2Tag);
        var schoolType3Tag = createSelectTag('schoolType3', comCodeSchoolType, 'CD', 'NM', '${customerSchoolList[2].schoolType}', null, colorObj, '', 'sel_ability');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        $("#schoolType3Tag").html(schoolType3Tag);

        //공통코드 졸업구분
        var comCodeGraduateType = getBaseCommonCode('GRADUATE_TYPE', null, 'CD', 'NM', '', '졸업구분', null, { orgId : "${baseUserLoginInfo.applyOrgId}" });
        var graduate1Tag = createSelectTag('graduate1', comCodeGraduateType, 'CD', 'NM', '${customerSchoolList[0].graduate}', null, colorObj, '', 'sel_ability');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        $("#graduate1Tag").html(graduate1Tag);
        var graduate2Tag = createSelectTag('graduate2', comCodeGraduateType, 'CD', 'NM', '${customerSchoolList[1].graduate}', null, colorObj, '', 'sel_ability');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        $("#graduate2Tag").html(graduate2Tag);
        var graduate3Tag = createSelectTag('graduate3', comCodeGraduateType, 'CD', 'NM', '${customerSchoolList[2].graduate}', null, colorObj, '', 'sel_ability');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        $("#graduate3Tag").html(graduate3Tag);

        //자녀관계 selectbox 세팅
        $("select[id='childM']").val("${cst.childM}");
        $("select[id='childF']").val("${cst.childF}");


        //전화번호
        //$("select[id='phn1_1']").val("${fn:split(cst.phn1,'-')[0]}").prop("selected",true);

        //학력
        //$("select[id='schoolType1']").val("${customerSchoolList[0].schoolType}").prop("selected",true);
        //$("select[id='graduate1']").val("${customerSchoolList[0].graduate}").prop("selected",true);
        //$("select[id='schoolType2']").val("${customerSchoolList[1].graduate}").prop("selected",true);
        //$("select[id='graduate2']").val("${customerSchoolList[1].schoolNm}").prop("selected",true);
        //$("select[id='schoolType3']").val("${customerSchoolList[2].schoolType}").prop("selected",true);
        //$("select[id='graduate3']").val("${customerSchoolList[2].graduate}").prop("selected",true);

        //친밀도
        var val = "${fn:substring(cst.lvCd, 4, 5)}";
        if(val == "") val = 0;
        for(var i=1; i<=5; i++){
            if(i <= val){
                $('#relDeg'+i).attr('class', 'on');
            }else{
                $('#relDeg'+i).attr('class', '');
            }
        }
        $('#relDegree').val('0000'+val);        //친밀도 세팅
        $('#spanRelDeg').text('(+'+val +  ')');        //친밀도 텍스트표시

      //재직기간
        for (i = new Date().getFullYear(); i > 1900; i--){
            $('#startDate1').append($('<option />').val(i).html(i));
            $('#endDate1').append($('<option />').val(i).html(i));
            $('#startDate2').append($('<option />').val(i).html(i));
            $('#endDate2').append($('<option />').val(i).html(i));
        }

        //경력기간
        $("select[id='startDate1']").val("${customerCareerList[0].startDate}").prop("selected",true);
        $("select[id='startDate2']").val("${customerCareerList[1].startDate}").prop("selected",true);
        $("select[id='endDate1']").val("${customerCareerList[0].endDate}").prop("selected",true);
        $("select[id='endDate2']").val("${customerCareerList[1].endDate}").prop("selected",true);

        //달력
        $('#birth').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
        $('#birth').datepicker("option", "minDate", "1930-01-01");
        // $('#birth').datepicker("option", "maxDate", "2016-12-31");

        //담당자 셋팅
        if('${cst.managerId}' == '') $("#staffNm").text($("#selStaff option:selected").text());
        //페이지크기 세팅
        //fnObj.setPageSize();
        if($("#actionType").val() == "UPDATE"){
        	$("#cstNm").show();
        	$("#divDupComment").hide();
        }
    },

    //화면세팅
    pageStart: function(){

    },//end pageStart.
    //################# init function :E #################

    //################# else function :S #################
    //저장
    doSave: function(){
        var cateCd = 0;
        var cstNm = $('#cstNm');
        var cpnId = $('#cpnId');
        var pst   = $('#position');
        var email = $('#email');

        var domesticYn = $("input[name = 'domesticYn']:checked").val();
        var phn1   = "";
        var phn2   = "";
        var homePhone = "";
        var fax = "";
        if(domesticYn == "Y"){
        	 if($("select[id='phn1_1']").val() != "" && $('#phn1_2').val() != "" && $('#phn1_3').val() != ""){
             	phn1 = $("select[id='phn1_1']").val() + "-" + $('#phn1_2').val() + "-" + $('#phn1_3').val();
             }

             if($('#phn2_1').val() != "" && $('#phn2_2').val() != "" && $('#phn2_3').val() != ""){
             	phn2 = $('#phn2_1').val() + "-" + $('#phn2_2').val() + "-" + $('#phn2_3').val();
             }

             if($('#homePhone_1').val() != "" && $('#homePhone_2').val() != "" && $('#homePhone_3').val() != ""){
             	homePhone  = $('#homePhone_1').val() + "-" + $('#homePhone_2').val() + "-" + $('#homePhone_3').val();
             }

             if($('#fax_1').val()  != "" && $('#fax_2').val() != "" && $('#fax_3').val() != ""){
             	fax  = $('#fax_1').val()  + "-" + $('#fax_2').val() + "-" + $('#fax_3').val();
             }

        }else if(domesticYn == "N"){
        	if($("#overseas_phn1_0").val() != "" &&$("#overseas_phn1_1").val() != "" && $('#overseas_phn1_2').val() != "" && $('#overseas_phn1_3').val() != ""){
             	phn1 = $("select[id='overseas_phn1_0']").val() + "-" +$('#overseas_phn1_1').val() + "-" + $('#overseas_phn1_2').val() + "-" + $('#overseas_phn1_3').val();
             }

             if($('#overseas_phn2_0').val() != "" &&$('#overseas_phn2_1').val() != "" && $('#overseas_phn2_2').val() != "" && $('#overseas_phn2_3').val() != ""){
             	phn2 = $('#overseas_phn2_0').val() + "-" +$('#overseas_phn2_1').val() + "-" + $('#overseas_phn2_2').val() + "-" + $('#overseas_phn2_3').val();
             }

             if($('#overseas_homePhone_0').val() != "" &&$('#overseas_homePhone_1').val() != "" && $('#overseas_homePhone_2').val() != "" && $('#overseas_homePhone_3').val() != ""){
             	homePhone  = $('#overseas_homePhone_0').val() + "-" +$('#overseas_homePhone_1').val() + "-" + $('#overseas_homePhone_2').val() + "-" + $('#overseas_homePhone_3').val();
             }

             if($('#overseas_fax_0').val()  != "" &&$('#overseas_fax_1').val()  != "" && $('#overseas_fax_2').val() != "" && $('#overseas_fax_3').val() != ""){
             	fax  = $('#overseas_fax_0').val()  + "-" +$('#overseas_fax_1').val()  + "-" + $('#overseas_fax_2').val() + "-" + $('#overseas_fax_3').val();
             }
        }

        var phn3   = $('#phn3');
        var expo   = $('#exposure');

        var i = 1;
        $('input[class=categoryCd]').each(function(){
            if($('input[class=categoryCd]:checked').length!=0 && this.checked)
                cateCd+=parseInt($('#categoryCd'+i).val());
            i++;
        });
        var page = 0;
        if("popUpReg" == $('#tmpTak').val()){
            page = 1;
        }
        $("input").css('background-color','');

        var cstType = $('input:radio[name=rdCstType]:checked').val();       //document.rgstForm.rdCstType.value;
        if(isEmpty(cstType)){       //인물구분
            alert("인물구분을 입력하세요!");
            return;
        }


        if(cstNm.val().is_null()){
            cstNm.focus();
            alert("이름을 입력하세요!");return;
        }

        if($("#actionType").val() == "INSERT" && $("#customerDupChkCnt").val() == "0"){
            cstNm.focus();
            alert("고객등록을 위해 고객중복체크를 진행해주세요!");
            return;
        }
        if($("#actionType").val() == "UPDATE" &&  $("#cstNm").val() != $("#oldCstNm").val() && $("#customerDupChkCnt").val() == "0"){
        	cstNm.focus();
            alert("고객이름 변경을 위해 고객중복체크를 진행해주세요!");
            return;
        }

        /* if(cpnId.val().is_null()){
        	cpnId.focus();
            alert("소속회사를 입력하세요!");return;
        } */
        /* if($('#team').val().is_null()){
            $('#team').focus();
            alert("소속부서를 입력하세요.");return;
        } */
        if($('#position').val().is_null()){
            $('#position').focus();
            alert("직위을 입력하세요.");return;
        }

        /*if(cpnId.val().is_null()){
            alert("회사를 선택하세요.");
            cpnId.focus();
            return;
        }*/
        /* 이인희 if(pst.val().is_null()){
            pst.focus();
            alert("직위을 입력하세요.");return;
        } */
        if($('#myWork').val().is_null()){
        	$('#myWork').focus();
            alert("담당업무를 입력하세요.");return;
        }
        /* 이인희  if(email.val().is_null()){
            email.focus();
            alert("이메일을 입력하세요.");return;
        } */

        if(domesticYn == "Y"){
        	if($('#phn1_1').val().is_null()){
            	$('#phn1_1').focus();
                alert("핸드폰번호를 입력하세요.");return;
            }else  if($('#phn1_2').val().is_null()){
            	$('#phn1_2').focus();
                alert("핸드폰번호를 입력하세요.");return;
            }else  if($('#phn1_3').val().is_null()){
            	$('#phn1_3').focus();
                alert("핸드폰번호를 입력하세요.");return;
            }

            if(phn2.is_null() && (!$('#phn2_1').val().is_null() || !$('#phn2_2').val().is_null() || !$('#phn2_3').val().is_null())){
                $('#phn2_1').focus();
                alert("회사직통전화번호를 정확히 입력하세요.");return;
            }

            if(homePhone.is_null() && (!$('#homePhone_1').val().is_null() || !$('#homePhone_2').val().is_null() || !$('#homePhone_3').val().is_null())){
                $('#homePhone_1').focus();
                alert("집전화번호를 정확히 입력하세요.");return;
            }

            if(fax.is_null() && (!$('#fax_1').val().is_null() || !$('#fax_2').val().is_null() || !$('#fax_3').val().is_null())){
                $('#fax_1').focus();
                alert("팩스번호를 정확히 입력하세요.");return;
            }
        }else if(domesticYn == "N"){
        	if($('#overseas_phn1_0').val().is_null()){
            	$('#overseas_phn1_0').focus();
                alert("핸드폰번호를 입력하세요.");return;
            }else if($('#overseas_phn1_1').val().is_null()){
            	$('#overseas_phn1_1').focus();
                alert("핸드폰번호를 입력하세요.");return;
            }else  if($('#overseas_phn1_2').val().is_null()){
            	$('#overseas_phn1_2').focus();
                alert("핸드폰번호를 입력하세요.");return;
            }else  if($('#overseas_phn1_3').val().is_null()){
            	$('#overseas_phn1_3').focus();
                alert("핸드폰번호를 입력하세요.");return;
            }

            if(phn2.is_null() && (!$('#overseas_phn2_0').val().is_null() ||!$('#overseas_phn2_1').val().is_null() || !$('#overseas_phn2_2').val().is_null() || !$('#overseas_phn2_3').val().is_null())){
                $('#overseas_phn2_0').focus();
                alert("회사직통전화번호를 정확히 입력하세요.");return;
            }

            if(homePhone.is_null() && (!$('#overseas_homePhone_0').val().is_null() ||!$('#overseas_homePhone_1').val().is_null() || !$('#overseas_homePhone_2').val().is_null() || !$('#overseas_homePhone_3').val().is_null())){
                $('#overseas_homePhone_0').focus();
                alert("집전화번호를 정확히 입력하세요.");return;
            }

            if(fax.is_null() && (!$('#overseas_fax_1').val().is_null() ||!$('#overseas_fax_1').val().is_null() || !$('#overseas_fax_2').val().is_null() || !$('#overseas_fax_3').val().is_null())){
                $('#overseas_fax_1').focus();
                alert("팩스번호를 정확히 입력하세요.");return;
            }
        }



        if($("#relDegree").val().is_null() || $("#relDegree").val() == "00000"){
            $("#relDegree").focus();
            alert("친밀도를 입력하세요!");
            return;
        }

        var school1 = "";
        if($('#schoolType1').val()  != "" && $('#schoolNm1').val() != "" && $('#major1').val() != "" && $('#graduate1').val() != "" ){
        	school1  = $('#schoolType1').val()  + "-" + $('#schoolNm1').val() + "-" + $('#major1').val()+ "-" + $('#graduate1').val();
        }
        if(school1.is_null() && (!$('#schoolType1').val().is_null() || !$('#schoolNm1').val().is_null() || !$('#major1').val().is_null() || !$('#graduate1').val().is_null()) ){
            $('#schoolType1').focus();
            alert("1번째 학력정보를 정확히 입력하세요.");return;
        }
        var school2 = "";
        if($('#schoolType2').val()  != "" && $('#schoolNm2').val() != "" && $('#major2').val() != "" && $('#graduate2').val() != "" ){
            school2  = $('#schoolType2').val()  + "-" + $('#schoolNm2').val() + "-" + $('#major2').val()+ "-" + $('#graduate2').val();
        }
        if(school2.is_null() && (!$('#schoolType2').val().is_null() || !$('#schoolNm2').val().is_null() || !$('#major2').val().is_null() || !$('#graduate2').val().is_null()) ){
            $('#schoolType2').focus();
            alert("2번째 학력정보를 정확히 입력하세요.");return;
        }
        var school3 = "";
        if($('#schoolType3').val()  != "" && $('#schoolNm3').val() != "" && $('#major3').val() != "" && $('#graduate3').val() != "" ){
            school3  = $('#schoolType3').val()  + "-" + $('#schoolNm3').val() + "-" + $('#major3').val()+ "-" + $('#graduate3').val();
        }
        if(school3.is_null() && (!$('#schoolType3').val().is_null() || !$('#schoolNm3').val().is_null() || !$('#major3').val().is_null() || !$('#graduate3').val().is_null()) ){
            $('#schoolType3').focus();
            alert("3번째 학력정보를 정확히 입력하세요.");return;
        }

        var carrer1 = "";
        if($('#companyId1').val()  != "" && $('#departTeam1').val() != "" && $('#careerMemo1').val() != "" ){
        	carrer1  = $('#companyId1').val()  + "-" + $('#departTeam1').val() + "-" + $('#careerMemo1').val();
        }
        if(carrer1.is_null() && (!$('#companyId1').val().is_null() || !$('#departTeam1').val().is_null() || !$('#careerMemo1').val().is_null() ) ){
            $('#companyId1').focus();
            alert("1번째 이력정보를 정확히 입력하세요.");return;
        }

        var carrer2 = "";
        if($('#companyId2').val()  != "" && $('#departTeam2').val() != "" && $('#careerMemo2').val() != "" ){
            carrer2  = $('#companyId2').val()  + "-" + $('#departTeam2').val() + "-" + $('#careerMemo2').val();
        }
        if(carrer2.is_null() && (!$('#companyId2').val().is_null() || !$('#departTeam2').val().is_null() || !$('#careerMemo2').val().is_null() ) ){
            $('#companyId2').focus();
            alert("2번째 이력정보를 정확히 입력하세요.");return;
        }

        if($('#startDate1').val() > $('#endDate1').val()){
        	$('#startDate1').focus();
            alert("1번째 이력정보에 재직기간을 정확히 입력하세요.");return;
        }

        if($('#startDate2').val() > $('#endDate2').val()){
            $('#startDate2').focus();
            alert("2번째 이력정보에 재직기간을 정확히 입력하세요.");return;
        }

        //if(expo.is(":checked")==true) phn1 = '[N]'+phn1.val();
        //else phn1 = phn1.val();

      //---------- 해당 이름 존재 여부 체크

        var url = contextRoot + "/person/getCustomerName.do";
        var param = {
                cstNm: cstNm.val(),
                phn1: phn1
        };

        var callback = function(result){
	        var obj = JSON.parse(result);
	        var rsltObj = obj.resultObject; //결과수
	        if(obj.result == "SUCCESS"){
                //------------------- 등록 프로세스 :S --------------------
                var msg = '';
                if((phn1 != $("#oldPhn1").val()) && (rsltObj.isExist=='MOBILE')){
                	msg = "등록하시려는 핸드폰 번호(" + phn1 + ")는 이미 \'" + rsltObj.cstNmMobile + "\' 고객님 이름으로 등록되어있습니다. ";
                	alert(msg);
                	return;
                }/* else if(($("#cstNm").val() != $("#oldCstNm").val()) && (rsltObj.isExist=='NAME')){
                	msg = '요청하신 이름 \'' + cstNm.val() + '\' 이 존재합니다.\n같은이름으로 등록 하시겠습니까?';
                } */else{
                	msg = '등록 하시겠습니까?\n';
                }

                if(confirm(msg)){
                    var url = "";
                    if($("#actionType").val() == "INSERT") url= contextRoot + "/person/regCustomer.do";
                    else if($("#actionType").val() == "UPDATE") url= contextRoot + "/person/updateCst.do";

                    var param = {
                    		rgId: $('#rgstId').val(),
                    		sNb: $('#sNb').val(),
                    		cstId: $('#cstId').val(),
                    		cstNm: cstNm.val(),
                            //categoryPersonCd: "0000"+cateCd,
                            categoryPersonCd: cstType,              //인물구분
                            cpnId: cpnId.val(),
                            position: pst.val(),
                            email: email.val(),
                            phn1: phn1,
                            phn2: phn2,
                            phn3: phn3.val(),

                            mfSex: $("input:radio[id='mfSex']:checked").val(),
                            married: $("input:radio[id='married']:checked").val(),
                            childM: $('#childM').val(),
                            childF: $('#childF').val(),
                            myWork: $('#myWork').val(),
                            hometown: $('#hometown').val(),
                            fax: fax,
                            homePhone: homePhone,
                            birth: $('#birth').val(),

                            usrCusId: ('${cst.fireStaffYn}' == 'Y' ? '${cst.managerId}' : $('#selStaff').val()) ,     //담당자 cusId
                            relDegree: $('#relDegree').val(),     //담당자 와의 친밀도
                            memo: $('#memo').val(),

                            team: $('#team').val(),

                            //학력
                            schoolType1: $("select[id='schoolType1']").val(),
                            schoolNm1: $('#schoolNm1').val(),
                            major1: $('#major1').val(),
                            graduate1: $("select[id='graduate1']").val(),

                            schoolType2: $("select[id='schoolType2']").val(),
                            schoolNm2: $('#schoolNm2').val(),
                            major2: $('#major2').val(),
                            graduate2: $("select[id='graduate2']").val(),

                            schoolType3: $("select[id='schoolType3']").val(),
                            schoolNm3: $('#schoolNm3').val(),
                            major3: $('#major3').val(),
                            graduate3: $("select[id='graduate3']").val(),

                            //이력
                            companyId1: $('#companyId1').val(),
                            departTeam1: $('#departTeam1').val(),
                            careerMemo1: $('#careerMemo1').val(),
                            startDate1: $("select[id='startDate1']").val(),
                            endDate1: $("select[id='endDate1']").val(),

                            companyId2: $('#companyId2').val(),
                            departTeam2: $('#departTeam2').val(),
                            careerMemo2: $('#careerMemo2').val(),
                            startDate2: $("select[id='startDate2']").val(),
                            endDate2: $("select[id='endDate2']").val(),
                            domesticYn:domesticYn
                    };

                    var callback = function(result){
                        var obj = JSON.parse(result);
                        var rsltObj = obj.resultObject; //결과수
                        var sNb = "";

                        if(obj.result == "SUCCESS"){
                        	if($("#actionType").val() == "INSERT") {
                                alert("등록이 완료되었습니다.");
                                sNb = obj.resultObject.sNb;
                            }else if($("#actionType").val() == "UPDATE") {
                                alert("수정이 완료되었습니다.");
                                sNb = $('#sNb').val();
                            }

                        	//업무화면에서 등록요청한 경우
                        	if($("#openPage").val() == "WORK_PAGE") {
                        		if(opener.cstPopupCallback){
                        	        opener.cstPopupCallback(sNb,$("#cpnId").val(),$("#cstNm").val(),$("#cpnNm").val(),$("#team").val(),$("#position").val());
                        	    }else{
                        	        opener.parent.cstPopupCallback(sNb,$("#cpnId").val(),$("#cstNm").val(),$("#cpnNm").val(),$("#team").val(),$("#position").val());
                        	    }
                        	    window.close();
                        	}else{
                        		window.location.href = "../person/main.do?sNb="+sNb + "&searchOrgId="+applyOrgId;
                        	}


                            //window.parent.location.href = "/person/personMgmt.do";
                            //parent.myModal.close();
                            //$('#srchCustNm', parent.document).val(rsltObj.cstNm);       //등록한 이름으로 검색
                            //이인희 parent.fnObj.doSearch();
                            //window.close();

                            //parent.toast.push("등록 되었습니다!");

                        }else{
                            //alertMsg();
                        }

                    };

                    //alert(JSON.stringify(param));
                    //return;

                    commonAjax("POST", url, param, callback);
                }
                //------------------- 등록 프로세스 :E --------------------


            }else{
                //alertMsg();
            }
        };
        commonAjax("POST", url, param, callback);
    },//end doSave

    //친밀도 체크
    chkRelationDegree: function(th, val){
        for(var i=1; i<=5; i++){
            if(i <= val){
            	$('#relDeg'+i).attr('class', 'on');
            }else{
            	$('#relDeg'+i).attr('class', '');
            }
        }
        $('#relDegree').val('0000'+val);        //친밀도 세팅
        $('#spanRelDeg').text('(+'+val +  ')');        //친밀도 텍스트표시
    }
    //################# else function :E #################
};//end fnObj.

//회사 검색 팝업
function companyPopUp(companyPopType){
	$("#companyPopType").val(companyPopType);
	var option = "width=650px,height=720px,resizable=yes,scrollbars = yes";
    commonPopupOpen("searchCpnPop",contextRoot+"/company/popUpCpn.do",option,$("#viewerFrm"));
}

function cpnPopupCallback(cpnId,cpnNm,sNb,refOrgid){
	if(refOrgid != undefined && refOrgid!=""){
		alert("선택한 회사는 고객 신규등록이 불가능합니다.");
		return;
	}
	var companyPopType = $("#companyPopType").val();
	if(companyPopType == "COMPANY"){
		$("#cpnId").val(cpnId);
	    $("#cpnNm").val(cpnNm);
	}else if(companyPopType == "COMPANY_HIST1"){
		$("#companyId1").val(sNb);
        $("#companyNm1").val(cpnNm);
    }else if(companyPopType == "COMPANY_HIST2"){
        $("#companyId2").val(sNb);
        $("#companyNm2").val(cpnNm);
    }
}

//고객중복체크 검색 팝업
function customerDupChkPopup(companyPopType){
	$("#searchCstNm").val($("#cstNm").val());
	var option = "width=650px,height=610px,resizable=yes,scrollbars = yes";
    commonPopupOpen("searchCpnPop",contextRoot+"/person/customerDupChkPopup.do",option,$("#viewerFrm"));
}

//고객중복체크 검색 팝업 callback
function cstDupChkPopupCallback(cstNm){
	$("#cstNm").show();
	$("#cstNm").val(cstNm);
	$("#cstNm").focus();
	$("#customerDupChkCnt").val(parseInt($("#customerDupChkCnt").val()) + 1);
	/* $("#tmpCstNm").val(cstNm);
    $("#tmpCstId").val(sNb);
    $("#tmpCpnNm").val(cpnNm);
    $("#tmpCpnId").val(cpnSnb);
    $('#ScheArea').val(cpnNm);      //장소 표시 */
}

//메인화면 재로딩
function reloadMainPage(){
    opener.parent.openPage();
    window.close();
}

/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
    fnObj.preloadCode();    //공통코드 or 각종선로딩코드
    //fnObj.pageStart();        //화면세팅
    //fnObj.doSearch();     //검색
    //fnObj.setTooltip();

    //업무페이지에서 신규등록으로 넘어온 경우
    if($("#openPage").val() == "WORK_PAGE" && $("#actionType").val() == "INSERT"){
    	cstDupChkPopupCallback($("#workCstNm").val());
    }
});
</script>


