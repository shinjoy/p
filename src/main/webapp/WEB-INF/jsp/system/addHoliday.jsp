<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>




<form name="myForm" method="post">
	<div class="mo_container">
		<input type="hidden" name="holPaid" value="N"> <!--  연차 -->
		<input type="hidden" name="allHalf" value="ALL"> <!-- 종일 -->
		<input type="hidden" name="orgId" value="${orgId }">
		<input type="hidden" name="holId" value="0">

		<table class="tb_basic_left">
	    	<colgroup>
				<col width="120" />
				<col width="*" />
			</colgroup>
			<tbody>
		 		<tr>
		 			<th scope="row">관계사</th>
		 			<td bgcolor="#F7F7F7">${orgText}</td>
		 		</tr>
				<tr>
		 			<th scope="row"><label for="inputHolidayDate">날짜</label></th>
		 			<td>
		 				<c:if test="${mode eq 'new' }">
	   						<input id="inputHolidayDate" type="text" name="holidayDate" readonly="readonly" placeholder="날짜를 입력하세요" value="" class="input_b w100px" />
	   						<a href="#" onclick="$('#inputHolidayDate').datepicker('show');return false;" class="icon_calendar"></a>
	   					</c:if>
	   					<c:if test="${mode eq 'update' }">
	   						<input id="inputHolidayDate" type="text" name="holidayDate" readonly="readonly" class="input_b w100px" />
	   					</c:if>
		 			</td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="inputHolType">휴일 종류</label></th>
		 			<td><input id="inputHolType" type="text" name="holType" placeholder="재량휴일명을 입력하세요" value="" maxlength="8" class="input_b w100pro" /></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="selRepeatYn">반복여부</label></th>
		 			<td>
		   				<select id="selRepeatYn" name="repeatYn" class="select_b w50px" onchange="">
		   					<option value='Y' style='background-color:;'>Y</option>
		   					<option value='N' style='background-color:silver;' selected="selected">N</option>
		   				</select>
						&nbsp;<font color=silver>(연간반복)</font>
		 			</td>
		 		</tr>
		 		<!-- <tr>
		 			<th scope="row"><label for="selEnable">사용여부</label></th>
		 			<td class="last">
		  				<select id="selEnable" name="enable" class="select_b w50px" onchange="">
		   					<option value='Y' style='background-color:;'  selected="selected">Y</option>
		   					<option value='N' style='background-color:silver;'>N</option>
		   				</select>
		 			</td>
		 		</tr> -->
		 		<input type="hidden" name="enable" value='Y'>
	 		</tbody>
		</table>
		<div id="editBtnArea" class="btnZoneBox">
			<button id="btnSave" type="button" class="p_blueblack_btn" onclick="fnObj.doSave();"><strong>저장</strong></button>
			<button id="btnDel" type="button" class="p_withelin_btn" onclick="fnObj.tryDelete();">삭제</button>
		</div>
	</div>
</form>





<script type="text/javascript">

//Global variables :S ---------------
var lang = '${baseUserLoginInfo.lang}';

//공통코드
var comCodeDeptClass;				//부서분류
var deptListCombo;				//부서리스트

var mode = "<c:out value='${mode==null?"new":mode}'/>";		//"new", "update"
//var menuId = "<c:out value='${menuId}'/>";	//"update" mode 메뉴아이디
var holidayInfoObj = "<c:out value='${holidayInfoObj}'/>";	//"update" mode 메뉴정보
var codeList = "${codeList}";								//기존 등록된 코드 리스트 문자열 ex) 'EAM,SYSTEM,ROL_PER_USER,...'

//var inputTitleBorder;				//제목 border style
//var contentBorder;					//내용 border style

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//공통코드
		comCodeDeptClass = getBaseCommonCode('DEPT_CLASS', lang, 'CD', 'NM');		//메뉴타입 공통코드 (Sync ajax)
		deptListCombo = getCodeInfo(lang, 'CD', 'NM', '', '', '', '/system/getDeptListCombo.do');		//부서목록(콤보용) 호출

		var colorObj = {};
		var deptClassSelectTag = createSelectTag('selDeptClass', comCodeDeptClass, 'CD', 'NM', this.value, '', colorObj);		//select tag creator 함수 호출 (common.js)
		$("#deptClassSelectTag").html(deptClassSelectTag);
	},


	//화면세팅
    pageStart: function(){
    	if(mode == 'new'){
    		fnObj.setDatepicker('inputHolidayDate');
			var nowDate = new Date();
			$("#inputHolidayDate").val(addDate(1).yyyy_mm_dd());
			$("#btnDel").hide();
    	}

    },//end pageStart.
  	//################# init function :E #################
    setDatepicker : function(obj){		//datepicker 설정
		$('#'+obj).datepicker({
			dateFormat: 'yy-mm-dd',
			changeMonth: true,
			changeYear: true,
			showOn: "button",
		 	monthNames: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], // 개월 텍스트 설정
		    monthNamesShort: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], // 개월 텍스트 설정
		    dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'], // 요일 텍스트 설정
		    dayNamesShort: ['일','월','화','수','목','금','토'], // 요일 텍스트 축약 설정
		    dayNamesMin: ['일','월','화','수','목','금','토'], // 요일 최소 축약 텍스트 설정
		    showButtonPanel: false,
			isRTL: false,
		    buttonText: ""
		});
   },

    //################# else function :S #################

  	//저장
    doSave: function(){

    	//-------------------- validation :S --------------------
    	var frm = document.myForm;

    	if(isEmpty(frm.holidayDate.value)){		//부서분류
    		dialog.push({body:"<b>확인!</b> 휴일날짜를 입력해주세요!", type:"", onConfirm:function(){frm.holidayDate.focus();}});
    		return;
    	}
    	if(isEmpty(frm.holType.value)){
    		dialog.push({body:"<b>확인!</b> 휴일내용을 입력해주세요!", type:"", onConfirm:function(){frm.holType.focus();}});
    		return;
    	}

    	//-------------------- validation :E --------------------


    	var res = frm.holidayDate.value.split("-");

    	var url = contextRoot + "/system/doSaveHoliday.do";
    	var param = {
    			mode: mode,			//화면 모드 mode : "new", "update"
    			holId			: frm.holId.value,
    			holidayDate		: res[0] + '-' + res[1]*1 + '-' + res[2]*1,
    			holYyyy			: res[0],
    			holMm			: res[1]*1,
    			holDd			: res[2]*1,
    			holType			: frm.holType.value,
    			allHalf			: frm.allHalf.value,
    			repeatYn		: frm.repeatYn.value,
    			holPaid			: frm.holPaid.value,
    			enable			: frm.enable.value,
    			orgId			: frm.orgId.value,		 //적용되는 관계사
    	}

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){

    			parent.fnObj.doSearchHoliday();
    			parent.fnObj.doSearch();
    			parent.myModal.close();
    			parent.toast.push("저장OK!");

    		}else{
    			if(obj.result != "FAIL"){
    				alertM(obj.result);
    				return;
    			}
    			alertM("등록도중 오류가 발생하였습니다.");
    			return;
    		}

    	};

    	commonAjax("POST", url, param, callback);
    },//end doSave


    //휴일 정보 가져오기
    getHoildayInfo: function(){
		var frm = document.myForm;
    	var holidayInfo = JSON.parse(holidayInfoObj.replace(/&#034;/gi,'"'));
    	var tmpMm;

    	//부서정보 세팅
    	frm.holId.value = holidayInfo.holId;
    	if( holidayInfo.holMm < 10 ) tmpMm = "0" + holidayInfo.holMm;
    	else tmpMm = holidayInfo.holMm;
		frm.holidayDate.value = holidayInfo.holiday;
		frm.holType.value = holidayInfo.holType;
		frm.allHalf.value = holidayInfo.allHalf;
		frm.repeatYn.value = holidayInfo.repeatYn;
		frm.holPaid.value = holidayInfo.holPaid;
		frm.enable.value = holidayInfo.enable;

		//수정할 날짜가 지금 날짜이전이면 수정할수 없다.
		if(new Date().yyyy_mm_dd() > holidayInfo.holiday) $("#editBtnArea").hide();

		//fnObj.selEnableChnged(frm.enable);	//enable 'N'배경색 반영

    },//end getArticle


    //삭제버튼 클릭시 -> enable :'N'
    tryDelete: function(){

    	dialog.push({
		    body:'<b>Caution</b>&nbsp;&nbsp;삭제하시겠습니까?', top:0, type:'Caution', buttons:[
                {buttonValue:'삭제', buttonClass:'Red', onClick:fnObj.doDelete},
                {buttonValue:'취소', buttonClass:'Blue', onClick:function(){}}
            ]});
    },


    doDelete: function(){
    	var frm = document.myForm;
    	var res = frm.holidayDate.value.split("-");

    	var url = contextRoot + "/system/deleteHoliday.do";
    	var param = {
    			holId			: frm.holId.value,
    			holidayDate		: res[0] + '-' + res[1]*1 + '-' + res[2]*1,
    			holYyyy			: res[0],
    			holMm			: res[1]*1,
    			holDd			: res[2]*1,
    			enable			: 'N',
    			orgId			: frm.orgId.value		 //적용되는 관계사

    	}
    	var callback = function(result){

    		var obj = JSON.parse(result);


    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){
    			parent.fnObj.doSearchHoliday();			//목록화면 재조회 호출.
    			parent.fnObj.doSearch();
    			parent.myModal.close();					//글쓰기 창 닫기.
    			parent.toast.push("삭제OK!");
    		}

    	};

    	commonAjax("POST", url, param, callback);

    },



  	//################# else function :E #################

};//end fnObj.



/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅

	//수정모드일때 내용가져오기
	if(mode=="update" && holidayInfoObj.length>0){
		fnObj.getHoildayInfo();
	}

});

</script>