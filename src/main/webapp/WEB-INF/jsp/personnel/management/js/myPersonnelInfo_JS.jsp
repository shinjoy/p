<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
//직위 공통코드
var comCodeRankType = getBaseCommonCode('RANK', null, 'CD', 'NM', '', '직위선택','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
var comCodeFamilyType = getBaseCommonCode('FAMILY_RELATION', null, 'CD', 'NM', '', '관계선택','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
var comCodeSchoolTypeType = getBaseCommonCode('SCHOOL_TYPE', null, 'CD', 'NM', '', '선택','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
var comCodeGraduateType = getBaseCommonCode('GRADUATE_TYPE', null, 'CD', 'NM', '', '선택','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
var comCodeUserStatusType = getBaseCommonCode('USER_STTS', null, 'CD', 'NM', '', '선택','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
var colorObj = {};
var now = new Date();
var year = now.getFullYear();
var month = now.getMonth();
var day = now.getDate();

$(document).ready(function(){
	makeUserStatusSelect();
	makeSosTelWhoSelect();
	makeBloodArea();
	makeReligionArea();
	//입사일 datePicker
	$('#hiredDate').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$('#hiredDate').attr("readonly","readonly");

	//정직원 발령 datePicker
	$('#joinDate').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$('#joinDate').attr("readonly","readonly");

	//생일 datePicker
	$('#birth').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$('#birth').attr("readonly","readonly");
	$("#birth").datepicker( "option", "maxDate", year+"-"+(month+1)+"-"+(day) );

	//결혼일datePicker
	$('#marriedDate').datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$('#marriedDate').attr("readonly","readonly");
	//$("#marriedDate").datepicker( "option", "maxDate", year+"-"+(month+1)+"-"+(day) );

	$('#marriedDate').datepicker("option", "onClose", function ( selectedDate ) {
       if(selectedDate==""){
			$("#nomarried").prop("checked",true);
       }else{
    	   $("#married").prop("checked",true);
       }
     });
	$("input[name='promotionDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='promotionDt']").attr("readonly","readonly");
	$("input[name='birthDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='birthDt']").attr("readonly","readonly");
	$("input[name='birthDt']").datepicker( "option", "maxDate", year+"-"+(month+1)+"-"+(day) );

	/* monthPickerWrap("input[name='enteredDt']");
	monthPickerWrap("input[name='graduateDt']"); */


	$("input[name='enteredDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='enteredDt']").attr("readonly","readonly");
	$("input[name='graduateDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='graduateDt']").attr("readonly","readonly");
	$("input[name='joinCpnDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='joinCpnDt']").attr("readonly","readonly");
	$("input[name='resignCpnDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='resignCpnDt']").attr("readonly","readonly");
	$("input[name='obtainDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='obtainDt']").attr("readonly","readonly");


	$("input[name='sttsFromDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='sttsFromDt']").attr("readonly","readonly");


	$("input[name='sttsEndDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='sttsEndDt']").attr("readonly","readonly");

	//$("input[name='sttsFromDt']").val(year+"-"+(month+1)+"-"+(day));
	//$("input[name='sttsFromDt']").datepicker("option", "minDate", year+"-"+(month+1)+"-"+(day));

	$("input[name='sttsEndDt']").datepicker("option", "onClose", function ( selectedDate ) {
        $("input[name='sttsFromDt']").datepicker( "option", "maxDate", selectedDate );
     });
	$("input[name='sttsFromDt']").datepicker("option", "onClose", function ( selectedDate ) {
            $("input[name='sttsEndDt']").datepicker( "option", "minDate", selectedDate );
      });
	//가족 타이틀 로우스팬
	$("#familyTitle").attr("rowspan",$("#familyTable tr").length);
	$("#academicTitle").attr("rowspan",$("#academicTable tr").length);
	$("#careerTitle").attr("rowspan",$("#careerTable tr").length);
	//setPromotionDt();
});
//재직 상태 추가
function addStts(){
	$("#sttsInputArea").show();
	$("#sttsAddBtn").hide();
	$("#sttsFlag").val("Y");
}
//재직 상태 추가 취소
function deleteStts(){
	$("#sttsInputArea").hide();
	$("#sttsAddBtn").show();
	$("#sttsFlag").val("N");
}
//자격증 추가
function addLicense(){
	$("#licenseTable tbody").append($("#licenseTmpl").text());
	$("input[name='obtainDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='obtainDt']").attr("readonly","readonly");
	$("#licenseTitle").attr("rowspan",$("#licenseTable tr").length);
}
//자격증 삭제
function deleteLicense($obj){
	$obj.parent().parent().remove();

	if($("#licenseTable tr").length == 1){
		addLicense();
	}
}
//경력 추가
function addCareer(){
	$("#careerTable tbody").append($("#careerTmpl").text());

	$("input[name='joinCpnDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='joinCpnDt']").attr("readonly","readonly");
	$("input[name='resignCpnDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='resignCpnDt']").attr("readonly","readonly");

	//id/name , codeStr, value , text ,selectValue ,onchange....
	var careerRankLength = $("select[name='careerRank']").length;
	var comTag = createSelectTag('careerRank', comCodeRankType, 'CD', 'NM', '${data.rank}', null, colorObj, 100, 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	$("select[name='careerRank']").eq(careerRankLength-1).html(comTag);

	$("#careerTitle").attr("rowspan",$("#careerTable tr").length);

}
//경력 삭제
function deleteCareer($obj){
	$obj.parent().parent().remove();

	if($("#careerTable tr").length == 1){
		addCareer();
	}
}
//진급 날짜 셋팅
function setPromotionDt(){

	//$("#rankNew").html(comTag);
	/* var dtLength = $("input[name='promotionDt']").length;
	for(var i = 0 ; i < dtLength;i++){
		if(i!=0){
			$("input[name='promotionDt']").eq(i).datepicker( "option", "minDate", $("input[name='promotionDt']").eq(i-1).val() );
			$("input[name='promotionDt']").eq(i).datepicker("option", "onClose", function ( selectedDate ) {
				$("input[name='promotionDt']").eq(i-1).datepicker( "option", "maxDate", selectedDate );
	      });
		}
		if(i != dtLength-1){
			$("input[name='promotionDt']").eq(i).datepicker( "option", "maxDate", $("input[name='promotionDt']").eq(i+1).val() );
			$("input[name='promotionDt']").eq(i).datepicker("option", "onClose", function ( selectedDate ) {
				$("input[name='promotionDt']").eq(i+1).datepicker( "option", "minDate", selectedDate );
	      });
		}

	} */
}
//학력 추가
function addAcademic(){
	$("#academicTable tbody").append($("#academicTmpl").text());

	$("input[name='enteredDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='enteredDt']").attr("readonly","readonly");
	$("input[name='graduateDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='graduateDt']").attr("readonly","readonly");

	var schoolLength = $("select[name='schoolType']").length;
	//id/name , codeStr, value , text ,selectValue ,onchange....
	var schoolTypeTag = createSelectTag('schoolType', comCodeSchoolTypeType, 'CD', 'NM', '', null, colorObj, 100, 'select_b');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	$("select[name='schoolType']").eq(schoolLength-1).html(schoolTypeTag);

	var graduateLength = $("select[name='graduateType']").length;
	//id/name , codeStr, value , text ,selectValue ,onchange....
	var graduateTypeTag = createSelectTag('graduateType', comCodeGraduateType, 'CD', 'NM', '${data.relation}', null, colorObj, 100, 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	$("select[name='graduateType']").eq(graduateLength-1).html(graduateTypeTag);

	$("#academicTitle").attr("rowspan",$("#academicTable tr").length);
}
//학력 삭제
function deleteAcademic($obj){
	$obj.parent().parent().remove();

	if($("#academicTable tr").length == 1){
		addAcademic();
	}
}
//가족추가
function addFamily(){
	$("#familyTable tbody").append($("#familyTmpl").text());

	var familyTypeTag = createSelectTag('relation', comCodeFamilyType, 'CD', 'NM', '', null, colorObj, 100, 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	var relationLength = $("select[name='relation']").length;
	$("select[name='relation']").eq(relationLength-1).html(familyTypeTag);

	$("input[name='birthDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='birthDt']").attr("readonly","readonly");
	$("input[name='birthDt']").datepicker( "option", "maxDate", year+"-"+(month+1)+"-"+(day) );

	$("#familyTitle").attr("rowspan",$("#familyTable tr").length);
}
//가족삭제
function deleteFamily($obj){

	$obj.parent().parent().remove();

	if($("#familyTable tr").length == 1){
		addFamily();
	}
}
//진급추가
function addRank(){
	$("#rankFlag").val("Y");
	$("#rankTable").append($("#rankTmpl").text());
	$("input[name='promotionDt']").datepicker(S_DatePickerOpt).parent().children('img').css({'vertical-align':'middle', 'line-height':'23px', 'margin-left':'5px'});
	$("input[name='promotionDt']").attr("readonly","readonly");
	var dtLength = $("select[name='rank']").length;
	var comTag = createSelectTag('rank', comCodeRankType, 'CD', 'NM', '', null, colorObj, 100, 'select_b w100pro');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	$("select[name='rank']").eq(dtLength-1).html(comTag);
	$("#rankAddBtn").hide();
	//진급 날자 셋팅
	setPromotionDt();
}
//진급 삭제
function deleteRank($obj){
	$obj.parent().parent().remove();
	$("#rankAddBtn").show();
	$("#rankFlag").val("N");
}
//종교관련 공통태그를 만든다
function makeReligionArea(){
	//혈액형 공통코드 생성
	var comCodeReligionType = getBaseCommonCode('RELIGION', null, 'CD', 'NM', null, '','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
	//id/name , codeStr, value , text ,selectValue ,onchange....
	var religionTypeTag = createRadioTag('religion', comCodeReligionType, 'CD', 'NM', '${userDetail.religion}', null, colorObj, 100, '');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	$("#religionArea").append(religionTypeTag);
}
//혈액형관련 공통태그를 만든다
function makeBloodArea(){
	//혈액형 공통코드 생성
	var comCode = getBaseCommonCode('BLOOD_RH', null, 'CD', 'NM', '', '선택','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
	//id/name , codeStr, value , text ,selectValue ,onchange....
	var comTag = createSelectTag('bloodRh', comCode, 'CD', 'NM', '${userDetail.bloodRh}', null, colorObj, 100, 'sel_phone');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	$("#bloodArea").append(comTag);

	//혈액형 공통코드 생성
	var comCodeBloodType = getBaseCommonCode('BLOOD', null, 'CD', 'NM', null, '','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
	//id/name , codeStr, value , text ,selectValue ,onchange....
	var bloodTypeTag = createRadioTag('blood', comCodeBloodType, 'CD', 'NM', '${userDetail.blood}', null, colorObj, 100, '');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	$("#bloodArea").append(bloodTypeTag);


}
//긴급 연락 번호 관계 selectBox
function makeSosTelWhoSelect(){
	//긴급 연락 번호 관계 selectBox 생성
	var comCode = getBaseCommonCode('SOS_WHO', null, 'CD', 'NM', '', '선택','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
	//id/name , codeStr, value , text ,selectValue ,onchange....
	var comTag = createSelectTag('sosWho', comCode, 'CD', 'NM', '${userDetail.sosWho}', null, colorObj, 100, 'select_b mgl6');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	$("#sosTelArea").append(comTag);
}
//채용형태 공통코드 selectBox를 생성한다
function makeUserStatusSelect(){
	//채용형태selectBox 생성
	var comCode = getBaseCommonCode('EMP_TYPE', null, 'CD', 'NM', '', '선택','ALL', { orgId : "${baseUserLoginInfo.applyOrgId}" });
	//id/name , codeStr, value , text ,selectValue ,onchange....
	var comTag = createSelectTag('empType', comCode, 'CD', 'NM', '${userDetail.empType}', null, colorObj, 100, '');   //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
	$("#userStatusArea").html(comTag);
}
//우편번호검색
function fn_postCall(){
 	execDaumPostcodePop(fn_postCallCallback);
    $("#homeAddr2").val("");
    $("#homeAddr2").prop("readonly",true);
}
//우편번호찾기콜백
function fn_postCallCallback(zip,fullAddr){
	$("#zip").val(zip);
	$("#addr").val(fullAddr);
	if($("#addr").val()!= ""){
		$("#homeAddr2").prop("readOnly",false);
	}
};

//이미지 미리보기
function previewImage(targetObj, previewId) {
    var preview = document.getElementById(previewId); //div id
    var ua = window.navigator.userAgent;
    var re = /^.+\.((jpg)|(jpeg)|(gif)|(png)|(bmp))$/i;
    if (!re.test(targetObj.value)) {
    	alert("이미지 파일만 첨부 가능합니다.");  //
    	targetObj.value = "";
        return;
    }
    if (ua.indexOf("MSIE") > -1) {//ie일때

        targetObj.select();

        try {
            var src = document.selection.createRange().text; // get file full path
            var ie_preview_error = document
                    .getElementById("ie_preview_error_" + previewId);

            /* if (ie_preview_error) {
                preview.removeChild(ie_preview_error); //error가 있으면 delete
            } */

            var img = document.getElementById("previewId"); //이미지가 뿌려질 곳
            img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"
                    + src + "', sizingMethod='scale')"; //이미지 로딩, sizingMethod는 div에 맞춰서 사이즈를 자동조절 하는 역할
        } catch (e) {
            if (!document.getElementById("ie_preview_error_" + previewId)) {
                var info = document.createElement("<p>");
                info.id = "ie_preview_error_" + previewId;
                info.innerHTML = "a";
                preview.insertBefore(info, null);
            }
        }
    } else { //ie가 아닐때
        var files = targetObj.files;
        for ( var i = 0; i < files.length; i++) {

            var file = files[i];

            var imageType = /image.*/; //이미지 파일일경우만.. 뿌려준다.
            if (!file.type.match(imageType))
                continue;

            var prevImg = document.getElementById("previewId"); //이전에 미리보기가 있다면 삭제
           /*  if (prevImg) {
                preview.removeChild(prevImg);
            } */
			$("#prev_previewId").remove();
            var img = document.createElement("img"); //크롬은 div에 이미지가 뿌려지지 않는다. 그래서 자식Element를 만든다.
            img.id = "prev_previewId";
            img.file = file;
            img.style.width = document.getElementById('previewId').style.width;//'150px'; //기본설정된 div의 안에 뿌려지는 효과를 주기 위해서 div크기와 같은 크기를 지정해준다.
            img.style.maxHeight = document.getElementById('previewId').style.height;//'200px';

            preview.appendChild(img);

            if (window.FileReader) { // FireFox, Chrome, Opera 확인.
                var reader = new FileReader();
                reader.onloadend = (function(aImg) {
                    return function(e) {
                        aImg.src = e.target.result;
                    };
                })(img);
                reader.readAsDataURL(file);
            } else { // safari is not supported FileReader
                //alert('not supported FileReader');
                if (!document.getElementById("sfr_preview_error_"
                        + previewId)) {
                    var info = document.createElement("p");
                    info.id = "sfr_preview_error_" + previewId;
                    info.innerHTML = "not supported FileReader";
                    preview.insertBefore(info, null);
                }
            }
        }
    }
}

//부서삭제
function deleteDept($obj){
	if($("#mainDept").val() == ""){
		alert("대표부서를 먼저 선택해 주세요.");
		return;
	}
	var deleteDeptId = $obj.parent().find("input[name='deptId']").val();
	var chk = true;

	if($(".employee_list").length==1){
		alert("부서는 최소 1개이상 지정되어야 합니다.");
		return;
	}

	$("#mainDept option").each(function(){
		if($(this).val() == deleteDeptId){
			if($(this).prop("selected")){
				alert("대표부서로 선택된 부서는 삭제할수 없습니다.");
				chk = false;
				return false;
			}
			$(this).remove();
		}
	});
	if(!chk) return;
	//$obj.parent().find("input[type='hidden']").attr("name","deleteDeptId");
	$obj.parent().hide();
	$obj.parent().find("input[name='deleteFlag']").val("Y");
	//$obj.parent().removeClass();
	$(".employee_list").each(function(){
		if($(this).css("display")!="none"){
			var firstDeptNm = $(this).find("span").eq(0).html();
			$(this).find("span").eq(0).html(firstDeptNm.split(",").join(""));
			return false;
		}
	});
	//var firstDeptNm = $(".employee_list").eq(0).find("span").eq(0).html();
	//$(".employee_list").eq(0).find("span").eq(0).html(firstDeptNm.split(",").join(""));


}
var myModal = new AXModal();	// instance

var fnObj = {
		//사원선택 팝업	(idx : activity index, knd : 'project' 프로젝트전체에 배정하는 케이스)
	    openUserPopup: function(idx, knd){
	    	var deptInchargeList = new Array();
	    	selUserIndex = idx;			//row index
	    	var url = "<c:url value='/user/selectDeptInchargePopup.do'/>";

	    	var deptInchargeObj = "[";
	    	var i = 0;
	    	$(".employee_list").each(function(){
	    		if($(this).find("input[name='deleteFlag']").val()=="N"){
		    		if(i!=0) deptInchargeObj+=",";
		    		deptInchargeObj+="{\"deptId\"\:\"";
		    		deptInchargeObj+=$(this).find("input[name='deptId']").val();
		    		deptInchargeObj+="\",\"incharge\"\:\"";
		    		deptInchargeObj+=$(this).find("input[name='incharge']").val();
		    		deptInchargeObj+="\",\"deptNm\"\:\"";
		    		deptInchargeObj+=$(this).find("input[name='deptNm']").val();
		    		deptInchargeObj+="\"}";
					i++;
	    		}
	    	});
	    	deptInchargeObj+="]";

	    	//var tmpObj = JSON.parse(deptInchargeObj.replace(/&#034;/gi,'"').replace(/&amp;/gi,'&'));
	    	var tmpObj = JSON.parse(deptInchargeObj);
	    	if(tmpObj!=null){
	    		deptInchargeList = tmpObj;													//부서(직책)정보 ...배열객체
	    	}
	    	var params = {
	    					deptInchargeList : JSON.stringify(deptInchargeList),
	    					orgId :'${baseUserLoginInfo.applyOrgId}'
	    				//	isOnlyOne:'Y'	//검색옵션('Y': 한명, 그외,: 다수(default))
	    				};	//{mode:'new'};	//"btype=1&cate=1".queryToObject();		//게시판유형(board_type), 게시판 카테고리 를 넘긴다.

	    	myModal.open({
	    		url: url,
	    		pars: params,
	    		titleBarText: '부서선택',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
	    		method:"POST",
	    		top: 10,
	    		width: $(window).scrollTop() + 750,
	    		closeByEscKey: true				//esc 키로 닫기
	    	});

	    	//$('#myModalCT').draggable();

	    },
	    concatDeptInchargeList:function(list){
	    	var chk = true;
	    	var mainDeptId = $("#mainDept").val();

	    	var mainDeptChk = false;
	    	for(var i=0; i<list.length; i++){
	    		if(list[i].deptId==mainDeptId){
	    			mainDeptChk = true;
	    		}
	    	}

	    	if(!mainDeptChk){
	    		alert("대표부서로 선택된 부서는 삭제할수 없습니다.");
	    		return;
	    	}

	    	$("input[name='deleteFlag']").val("Y");
	    	$("input[name='deleteFlag']").parent().parent().hide();
	    	//$("input[name='deleteFlag']").parent().parent().removeClass()

	    	//$("#deptArea").empty();
	    	$("#mainDept").empty();
			$("#mainDept").append("<option value = ''>선택</option>");
	   		//추가
	    	for(var i=0; i<list.length; i++){
	    		/* $("input[name='addDept'],input[name='deptId']").each(function(){
		    		if($(this).val()==list[i].deptId){
		    			chk = false;
		    			return false;
		    		}
		    	});
	    		if(!chk) return; */
	    		$("#mainDept").append("<option value = '"+list[i].deptId+"'>"+list[i].deptNm+"</option>");

	    		if($("input[name='deptId'][value='"+list[i].deptId+"']").length>0){
	    			$("input[name='deptId'][value='"+list[i].deptId+"']").parent().find("input[name='deleteFlag']").val("N");
	    			$("input[name='deptId'][value='"+list[i].deptId+"']").parent().show();
	    			continue;
	    		}



    			var stStr = "<span class=\"employee_list\">";

    			stStr += '<span>';

    			stStr += "<input type=\"hidden\" name = \"incharge\" value=\""+list[i].incharge+"\">";
    			stStr += "<input type=\"hidden\" name = \"deptNm\" value=\""+list[i].deptNm+"\">";
    			stStr += "<input type=\"hidden\" name = \"deleteFlag\" value=\"N\">";


    			//if(i!=0)
    				stStr += ',';

    			stStr += list[i].deptNm;
    			if(list[i].incharge!=undefined&&list[i].incharge!=""){
    				stStr += "(부서장)";
    			}
    			stStr +="</span>";
    			stStr += '<input type="hidden" name="deptId" value="'+list[i].deptId+'">';
    			if(list[i].incharge!="DEPT_MGR")
    				stStr += '<a href="#this" onclick="deleteDept($(this))" class="btn_delete_employee"><em>삭제</em></a></span>';

    			$("#deptArea").append(stStr);
	    	}
	    	$("#mainDept").val(mainDeptId);
	    	$(".employee_list").each(function(){
	    		if($(this).css("display")!="none"){
	    			var firstDeptNm = $(this).find("span").eq(0).html();
	    			$(this).find("span").eq(0).html(firstDeptNm.split(",").join(""));
	    			return false;
	    		}
	    	});
	    }
}

//저장
function doSave(){
	var chk = true;
	if($("#name").val()==""){
		alert("한글이름을 입력해 주세요");
		$("#name").focus();
		return;
	}
	if($("#empType").val()==""){
		alert("채용형태를 선택해 주세요");
		$("#empType").focus();
		return;
	}
	if($("#mainDept").val()==""){
		alert("대표부서를 선택해 주세요");
		$("#mainDept").focus();
		return;
	}

	/* if($("#sttsFlag").val()=="Y"){
		var isEmpty = true;

		var userStatus = $("select[name='userStatus']").val();
		if(userStatus == 'R'||userStatus == 'F'){
			$("input[name='sttsEndDt']").val($("input[name='sttsFromDt']").val());
		}

		$("#sttsTable select,#sttsTable input").each(function(){
			if($(this).val()!=""){
				isEmpty = false;
				return false;
			}
		});
		if(isEmpty!=true){

			$("#sttsTable select,#sttsTable input").each(function(){
				if($(this).val()==""){
					alert("재직상태 정보를 모두 입력해 주세요.");
					$(this).focus();
					chk = false;
					return false;
				}
			});
		}
	}
	if(!chk) return; */

	if($("#userStatusNew").val()!=""){
		if($("input[name='sttsFromDt']").val()==""){
			alert("퇴직날짜를 선택해 주세요.");
			$("input[name='sttsFromDt']").focus();
			return;
		}

		if($("input[name='sttsMemo']").val()==""){
			alert("퇴직 사유를 입력해 주세요.");
			$("input[name='sttsMemo']").focus();
			return;
		}
	}

	if($("input[name='sttsFromDt']").val()!=""){
		if($("#userStatusNew").val()==""){
			alert("퇴직구분을 선택해 주세요.");
			$("#userStatusNew").focus();
			return;
		}

		if($("input[name='sttsMemo']").val()==""){
			alert("퇴직 사유를 입력해 주세요.");
			$("input[name='sttsMemo']").focus();
			return;
		}
	}

	if($("input[name='sttsMemo']").val()!=""){
		if($("input[name='sttsFromDt']").val()==""){
			alert("퇴직날짜를 선택해 주세요.");
			$("input[name='sttsFromDt']").focus();
			return;
		}
		if($("#userStatusNew").val()==""){
			alert("퇴직구분을 선택해 주세요.");
			$("i#userStatusNew']").focus();
			return;
		}
	}

	if($("#rankFlag").val()=="Y"){
		$("#rankTable select,#rankTable input").each(function(){
			var isEmpty = true;
			$("#rankTable select,#rankTable input").each(function(){
				if($(this).val()!=""){
					isEmpty = false;
					return false;
				}
			});
			if(isEmpty!=true){
				$("#rankTable select,#rankTable input").each(function(){
					if($(this).val()==""){
						alert("재직상태 정보를 모두 입력해 주세요.");
						$(this).focus();
						chk = false;
						return false;
					}
				});
			}
		});
	}
	if(!chk) return;

	/* if($("#mobileTel1").val() == ""){
		alert("전화번호 앞자리번호를 선택해 주세요.");
		return ;
	}
	if($("#mobileTel2").val() == ""){
		alert("핸드폰 중간번호를선택해 주세요.");
		return ;
	}
	if($("#mobileTel3").val() == ""){
		alert("핸드폰 마지막번호를 입력해 주세요.");
		return ;
	} */
	if($("#mobileTel1").val()!=""||$("#mobileTel2").val()!=""||$("#mobileTel3").val()!=""){
		$("#mobileTel").val($("#mobileTel1").val()+"-"+$("#mobileTel2").val()+"-"+$("#mobileTel3").val());

		if($("#mobileTel").val()!="" &&!isMobileNumber($("#mobileTel").val())){
			alert("핸드폰 번호 형식에 맞지 않습니다.");
			$("#mobileTel1").focus();
			return;
		}
	}
	if($("#companyTel1").val()!=""||$("#companyTel2").val()!=""||$("#companyTel3").val()!=""){
		$("#companyTel").val($("#companyTel1").val()+"-"+$("#companyTel2").val()+"-"+$("#companyTel3").val());

		if($("#companyTel").val()!="" &&!isPhoneNumber($("#companyTel").val())){
			alert("내선전화 형식에 맞지 않습니다.");
			$("#companyTel1").focus();
			return;
		}
	}
	if($("#homeTel1").val()!=""||$("#homeTel2").val()!=""||$("#homeTel3").val()!=""){
		$("#homeTel").val($("#homeTel1").val()+"-"+$("#homeTel2").val()+"-"+$("#homeTel3").val());

		if($("#homeTel").val()!="" &&!isPhoneNumber($("#homeTel").val())){
			alert("집전화 형식에 맞지 않습니다.");
			$("#homeTel1").focus();
			return;
		}
	}
	/* if($("#sosTel1").val()!=""&&$("#sosTel2").val()!=""&&$("#sosTel3").val()!=""){ */
		$("#sosTel").val($("#sosTel1").val()+"-"+$("#sosTel2").val()+"-"+$("#sosTel3").val());

		if($("#sosTel").val()!="" &&!isPhoneNumber($("#sosTel").val())){
			alert("긴급전화 형식에 맞지 않습니다.");
			$("#sosTel1").focus();
			return;
		}
	/* } */


	if($("#sosWho").val() == ""){
		alert("긴급연락처 관계를 선택해 주세요.");
		$("#sosWho").focus();
		return;
	}

	if($("#email").val()!="" && !isEmail($("#email").val())){
		alert("이메일 형식에 맞지 않습니다.");
		$("#email").focus();
		return;
	}
	var emptychk = true;
	$("#rankTable select,#rankTable input").each(function(){
		if($(this).val()!="") {
			emptychk = false;
			return false;
		}
	});
	if(!emptychk){
		$("#rankTable select,#rankTable input").each(function(){
			if($(this).val()==""){
				alert("진급 정보를 모두 입력해 주세요.");
				$(this).focus();
				chk = false;
				return false;
			}
		});
	}
	if(!chk) return;

	emptychk = true;
	$("#familyTable select,#familyTable input").each(function(){
		if($(this).val()!="") {
			emptychk = false;
			return false;
		}
	});
	var familyTableMsg = {"relation":"가족의 관계를 선택해 주세요.","familyNm":"가족의 이름을 입력해 주세요.","liveinYn":"가족과 동거여부를 선택해 주세요."};
	if(!emptychk){
		$("#familyTable select,#familyTable input").each(function(){
			if($(this).attr("name")=="birthDt" ||$(this).attr("name")=="job") {
				return true;
			}
			if($(this).val()==""){
				alert(familyTableMsg[$(this).attr("name")]);
				$(this).focus();
				chk = false;
				return false;
			}
		});
	}
	if(!chk) return;

	emptychk = true;

	$("#academicTable select,#academicTable input").each(function(){
		if($(this).val()!="") {
			emptychk = false;
			return false;
		}
	});

	var academicTableMsg = {"enteredDt":"입학일을 선택해 주세요.","graduateDt":"졸업일을 선택해 주세요.","schoolType":"학교구분을 선택해 주세요.","academicNm":"학교명을 입력해 주세요.","major":"전공학과를 입력해 주세요.","graduateType":"졸업여부를 선택해 주세요."};
	if(!emptychk){
		$("#academicTable select,#academicTable input").each(function(){
			if($(this).val()==""){
				alert(academicTableMsg[$(this).attr("name")]);
				$(this).focus();
				chk = false;
				return false;
			}
		});
	}
	if(!chk) return;

	emptychk = true;
	$("#careerTable select,#careerTable input").each(function(){
		if($(this).val()!="") {
			emptychk = false;
			return false;
		}
	});
	var careerTableMsg = {"joinCpnDt":"입사일을 선택해 주세요.","resignCpnDt":"퇴사일을 선택해 주세요.","companyNm":"회사명을 선택해 주세요.","careerRank":"직위을 선택해 주세요.","careerJob":"직무를 입력해 주세요."};
	if(!emptychk){
		$("#careerTable select,#careerTable input").each(function(){
			if($(this).val()==""){
				alert(careerTableMsg[$(this).attr("name")]);
				$(this).focus();
				chk = false;
				return false;
			}
		});
	}
	if(!chk) return;

	emptychk = true;
	$("#licenseTable select,#licenseTable input").each(function(){
		if($(this).val()!="") {
			emptychk = false;
			return false;
		}
	});
	var licenseTableMsg = {"licenseNm":"자격증/면허증 이름을 입력해 주세요.","issue":"발행처/기관을 입력해 주세요.","obtainDt":"취득일자를 선택해 주세요."};
	if(!emptychk){
		$("#licenseTable select,#licenseTable input").each(function(){
			if($(this).val()==""){
				alert(licenseTableMsg[$(this).attr("name")]);
				$(this).focus();
				chk = false;
				return false;
			}
		});
	}
	if(!chk) return;

	if(confirm("저장하시겠습니까?")){
		$("#frm").attr("action",contextRoot+"/personnel/management/processPersonnerInfo.do");

		var file = frm.shadowFile.files;
		var param = {userId:$("input[name='userId']").val()};
		imageFileUpload(file, contextRoot+"/personnel/management/basicInfoImg.do", param);
		//Ajax 요청
		commonAjaxSubmit("POST",$("#frm"),callback);
	}

}

function callback(data){
	alert("정상적으로 저장되었습니다.");
	$("#frm").attr("action",contextRoot+"/personnel/management/index.do").submit();
}

//프로필사진 수정
function imageFileUpload(fileObj, url, paramObj){
	var data = new FormData();

	//파일 첨부
	if(fileObj!=null){
		data.append('files-upload', fileObj[0]);
	}
	//파일 외 정보 첨부
	for(var key in paramObj){
		var obj = paramObj[key];
		if(obj instanceof Array){
			//배열인 경우
			data.append(key, JSON.stringify(obj));

		}else{
			data.append(key, paramObj[key]);
		}
	}

	//ajax 호출
	$.ajax({
		type	: "POST",        			//"POST" "GET"
		url		: url,    					//PAGEURL
		dataType: "text",
		data	: data,					//parameter object
		processData: false,
		contentType: false,
		timeout : 30000,       				//제한시간 지정(millisecond)
		cache 	: false,        			//true, false
		//success	: callbackFn,				//SUCCESS FUNCTION
		success : function(result) {
			//alert("사진저장 ok")
		},
		async	: true,
		error	: function whenError(x,e){	//ERROR FUNCTION
			//alert(x.responseText);
			//alertMsg("[FAIL!!]\n\n실패하였습니다!\n\n재시도후 문의바랍니다!");
			alert("사진 저장에 실패했습니다. 답당자에게 문의해주세요.");
		}
	});
}

//목록페이지로 이동
function goListPage(){
	$("#frm").attr("action",contextRoot + "/personnel/management/index.do").submit();
}

//재직상테 selectBox제어
/* function selectedUserStatus(){
	var userStatusVal = $("select[name='userStatus']").val();
	if(userStatusVal == "F" || userStatusVal == "R"){
		$("#sttsEndDtArea").hide();
	}else{
		$("#sttsEndDtArea").show();
	}
} */

//영문이름 영문만 입력
function engNmChk(){
	var engNm = $("#engNm").val().split(" ").join("");
	if(engNm!=""&&strInNumNEn(engNm)){
		alert("영문,숫자만 입력 가능합니다.");
		$("#engNm").val("");
		$("#engNm").focus();
		return;
	}

}
</script>
