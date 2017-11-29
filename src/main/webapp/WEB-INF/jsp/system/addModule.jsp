<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!-- -------- each page css :S -------- -->

<!-- -------- each page css :E -------- -->



<form name="myForm" method="post">
	<div class="mo_container">
		<table class="tb_basic_left">	<!-- AXFormTable : width 100% >> 98% (재정의) -->
	    	<colgroup>
				<col width="120" />
				<col width="*" />
			</colgroup>
			<tbody>
			<tr style="display:none;">
	 			<th scope="row"><label for="inputModuleId">모듈ID</label></th>
	 			<td bgcolor="#F7F7F7"><input id="inputModuleId" type="text" name="moduleId" placeholder="자동설정" value="" class="input_b" readonly="readonly" /></td>
	 		</tr>
			<tr>
	 			<th scope="row"><label for="inputModuleCode">모듈코드</label></th>
	 			<td bgcolor="#F7F7F7"><input id="inputModuleCode" type="text" name="moduleCode" placeholder="모듈코드 영문명을 입력하세요" value="" class="input_b w200px" /></td>
	 		</tr>
			<tr>
	 			<th scope="row"><label for="inputModuleName">모듈명</label></th>
	 			<td><input id="inputModuleName" type="text" name="moduleName" placeholder="한글명을 입력하세요" value="" class="input_b w200px" /></td>
	 		</tr>
	 		<tr>
	 			<th scope="row"><label for="inputModuleDesc">설명</label></th>
	 			<td><input id="inputModuleDesc" type="text" name="moduleDesc" placeholder="설명을 입력하세요" value="" class="input_b w100" /></td>
	 		</tr>
	 		<tr>
	 			<th scope="row"><label for="inputModuleIncUrl">URL</label></th>
	 			<td><input id="inputModuleIncUrl" type="text" name="moduleIncUrl" placeholder="URL을 입력하세요" value="" class="input_b w100" /></td>
	 		</tr>
	 		<tr>
	 			<th scope="row"><label for="cssTheme">CSS THEME</label></th>
	 			<td><input id="theme" type="text" name="theme" placeholder="URL을 입력하세요" value="" class="input_b w100" /></td>
	 		</tr>
	 		<tr>
	 			<th scope="row"><label for="cssTheme">그룹명</label></th>
	 			<td><input id="moduleGroup" type="text" name="moduleGroup" placeholder="그룹명을 입력하세요" value="" class="input_b w100" /></td>
	 		</tr>
	 		<tr>
                <th scope="row"><label for="coordinateXx">모듈좌표 X축</label></th>
                <td><input id="coordinateXx" type="text" name="coordinateXx" placeholder="모듈좌표 X축 값" value="" class="input_b number"  maxlength="2"/></td>
            </tr>
            <tr>
                <th scope="row"><label for="coordinateYy">모듈좌표 Y축</label></th>
                <td><input id="coordinateYy" type="text" name="coordinateYy" placeholder="모듈좌표 Y축 값" value="" class="input_b number" maxlength="2" /></td>
            </tr>
	 	<!-- 	<tr>
	 			<th scope="row"><label for="inputModuleWidth">폭</label></th>
	 			<td><input id="inputModuleWidth" type="text" name="moduleWidth" placeholder="모듈 폭입력" value="" class="input_b" /></td>
	 		</tr>
	 		<tr>
	 			<th scope="row"><label for="inputModuleHeight">높이</label></th>
	 			<td><input id="inputModuleHeight" type="text" name="moduleHeight" placeholder="모듈 넓이입력" value="" class="input_b" /></td>
	 		</tr> -->
	 		<tr>
	 			<th scope="row"><label for="selEnable">사용여부</label></th>
	 			<td>
	 				<select id="selEnable" name="enable" class="select_b" onchange="fnObj.selEnableChnged(this);">
	   					<option value='Y' style='background-color:;'>Y</option>
	   					<option value='N' style='background-color:silver;'>N</option>
	   				</select>
	 			</td>
	 		</tr>
			</tbody>
		</table>
		<div class="btnZoneBox" style="margin-bottom:10px;">
			<button id="btnSave" type="button" onclick="fnObj.doSave();" class="p_blueblack_btn"><strong>저장</strong></a></button>&nbsp;
			<button id="btnDel" type="button" onclick="fnObj.tryDelete();" class="p_withelin_btn">삭제</a></button>
		</div>
		<!--<div style="margin:10px;text-align:center;">
			<button id="btnSave" type="button" class="AXButton Classic" onclick="fnObj.doSave();"><i class="fa fa-check-circle fa-lg"></i>&nbsp;&nbsp;저&nbsp;&nbsp;&nbsp;&nbsp;장&nbsp;&nbsp;&nbsp;</button>
			<button id="btnDel" type="button" class="AXButton Classic" onclick="fnObj.tryDelete();"><i class="fa fa-trash-o fa-lg" ></i>&nbsp;&nbsp;삭&nbsp;&nbsp;&nbsp;&nbsp;제&nbsp;&nbsp;&nbsp;</button>
		</div>-->
	</div>
</form>





<script type="text/javascript">

//Global variables :S ---------------
//공통코드
//var comCodeMenuType;				//메뉴타입

var mode = "<c:out value='${mode==null?"new":mode}'/>";		//"new", "update"
//var menuId = "<c:out value='${menuId}'/>";	//"update" mode 메뉴아이디
var moduleInfoObj = "<c:out value='${moduleInfoObj}'/>";	//"update" mode 메뉴정보
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
		//comCodeMenuType = getBaseCommonCode('MENU_TYPE', 'CD', 'NM');		//메뉴타입 공통코드 (Sync ajax)


		//var menuTypeRadioTag = createRadioTag('rdMenuType', comCodeMenuType, 'CD', 'NM', 'TREE');	//radio tag creator 함수 호출 (common.js)
		//$("#menuTypeRadioTag").html(menuTypeRadioTag);
	},


	//화면세팅
    pageStart: function(){

    	if(mode=="new")		//신규일때 삭제버튼 hide
    		$('#btnDel').hide();


    	numberFormatForNumberClass();

    	// $('#inputModuleWidth').bindNumber({min:1, max:1000});
    	// $('#inputModuleHeight').bindNumber({min:1, max:1000});
    	$('#coordinateXx').bindNumber({min:0, max:10});
    	$('#coordinateYy').bindNumber({min:0, max:10});

    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//저장
    doSave: function(){

    	//-------------------- validation :S --------------------
    	var frm = document.myForm;

    	if(isEmpty(frm.moduleCode.value)){		//모듈코드
    		dialog.push({body:"<b>확인!</b> 모듈코드를 입력해주세요!", type:"", onConfirm:function(){frm.moduleCode.focus();}});
    		return;
    	}
    	if(isEmpty(frm.moduleName.value)){		//모듈명
    		dialog.push({body:"<b>확인!</b> 모듈명을 입력해주세요!", type:"", onConfirm:function(){frm.moduleName.focus();}});
    		return;
    	}
    	if(isEmpty(frm.moduleDesc.value)){		//설명
    		dialog.push({body:"<b>확인!</b> 설명을 입력해주세요!", type:"", onConfirm:function(){frm.moduleDesc.focus();}});
    		return;
    	}
    /* 	if(isEmpty(frm.moduleWidth.value)){		//폭
    		dialog.push({body:"<b>확인!</b> 폭을 입력해주세요!", type:"", onConfirm:function(){frm.moduleWidth.focus();}});
    		return;
    	}
    	if(isEmpty(frm.moduleHeight.value)){	//높이
    		dialog.push({body:"<b>확인!</b> 높이를 입력해주세요!", type:"", onConfirm:function(){frm.moduleHeight.focus();}});
    		return;
    	} */
    	if(isEmpty(frm.theme.value)){			//테마
    		dialog.push({body:"<b>확인!</b> 테마를 입력해주세요!", type:"", onConfirm:function(){frm.theme.focus();}});
    		return;
    	}

    	if(isEmpty(frm.coordinateXx.value)){     //모듈좌표 X축
            dialog.push({body:"<b>확인!</b> 모듈좌표 X축값을 입력해주세요!", type:"", onConfirm:function(){frm.moduleName.focus();}});
            return;
        }

    	if(isEmpty(frm.coordinateYy.value)){     //모듈좌표 Y축
            dialog.push({body:"<b>확인!</b> 모듈좌표 Y축값을 입력해주세요!", type:"", onConfirm:function(){frm.moduleName.focus();}});
            return;
        }

    	//----- 코드명이 존재하는 코드명인지
		var moduleCode = frm.moduleCode.value.toUpperCase();		//등록하려는 코드명
    	var codeListArr = codeList.split(',');
    	for(var i=0; i<codeListArr.length; i++){
    		if(codeListArr[i] == moduleCode){		//기 등록 코드명이면
    			dialog.push({body:"<b>확인!</b> 이미 등록된 모듈코드 입니다! <br><br> 다른 코드명을 입력해주세요!", type:"", onConfirm:function(){frm.moduleCode.select();}});
        		return;
    		}
    	}

    	//-------------------- validation :E --------------------

    	var url = contextRoot + "/system/doSaveModule.do";
    	var param = {
    			mode: mode,			//화면 모드 mode : "new", "update"
    			moduleId: frm.moduleId.value,
    			moduleCode: frm.moduleCode.value,
    			moduleName: frm.moduleName.value,
    			moduleDesc: frm.moduleDesc.value,
    			moduleIncUrl: frm.moduleIncUrl.value,
    			theme: frm.theme.value,
    			moduleGroup: frm.moduleGroup.value,
    			width: 1,
    			height: 1,
    			enable: frm.enable.value,
    			coordinateXx: frm.coordinateXx.value,
    			coordinateYy: frm.coordinateYy.value,
    	}
    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    		}

    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){

    			parent.fnObj.doSearch();				//목록화면 재조회 호출.
    			parent.myModal.close();					//글쓰기 창 닫기.
    			//parent.dialog.push("등록OK!");
    			parent.toast.push("저장OK!");
    		}else{
    			//alertMsg();
    		}

    	};

    	commonAjax("POST", url, param, callback);
    },//end doSave


    //메뉴정보 가져오기
    getModuleInfo: function(){
		var frm = document.myForm;
    	var moduleInfo = JSON.parse(moduleInfoObj.replace(/&#034;/gi,'"'));
    	//메뉴정보 세팅
		frm.moduleId.value = moduleInfo.moduleId;
		frm.moduleCode.value = moduleInfo.moduleCode;
		frm.moduleName.value = moduleInfo.moduleName;
		frm.moduleDesc.value = moduleInfo.moduleDesc;
		frm.moduleIncUrl.value = (moduleInfo.moduleIncUrl==undefined)?"":moduleInfo.moduleIncUrl;
		frm.theme.value = (moduleInfo.theme==undefined || moduleInfo.theme==null)?"":moduleInfo.theme;
	/* 	frm.moduleWidth.value =(moduleInfo.width==undefined || moduleInfo.width==null)?"":moduleInfo.width;
		frm.moduleHeight.value = (moduleInfo.height==undefined || moduleInfo.height==null)?"":moduleInfo.height; */
		frm.enable.value = moduleInfo.enable;

		fnObj.selEnableChnged(frm.enable);	//enable 'N'배경색 반영

		frm.coordinateXx.value = moduleInfo.coordinateXx;
		frm.coordinateYy.value = moduleInfo.coordinateYy;

    },//end getArticle


    //메뉴삭제 (일단 enable(사용여부 N 으로... 사용여부N으로 하고 저장하는 부분과 중복이나, 바서 진짜 삭제해도 되면 삭제!!!!!!))
    tryDelete: function(){
    	/*
    	dialog.push({body:'<b>Caution</b> 삭제하시겠습니까?',
    				 type:'Caution',
    				 onConfirm:fnObj.doDelete,
    				 data:'onConfirmData'});
    	*/

    	dialog.push({
		    body:'<b>Caution</b>&nbsp;&nbsp;삭제하시겠습니까?', top:0, type:'Caution', buttons:[
                {buttonValue:'삭제', buttonClass:'Red', onClick:fnObj.doDelete},	//, data:{param:"222"}},	//Red W100
                {buttonValue:'취소', buttonClass:'Blue', onClick:function(){}}	//, data:'data2'},
                //{buttonValue:'button3', buttonClass:'Green', onClick:fnObj.btnClick, data:'data3'}
		    ]});
    },
    doDelete: function(){

    	var url = contextRoot + "/system/deleteModule.do";
    	var param = {
    			moduleId: document.myForm.moduleId.value
    	}
    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    		}

    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){
    			parent.fnObj.doSearch();				//목록화면 재조회 호출.
    			parent.myModal.close();					//글쓰기 창 닫기.
    			//parent.dialog.push("등록OK!");
    			parent.toast.push("삭제OK!");
    		}else{
    			//alertMsg();
    		}

    	};

    	commonAjax("POST", url, param, callback);

    },

    //사용여부 선택
    selEnableChnged: function(obj){
    	//background-color
    	var styleStr = $("#" + obj.id + " > option[value='" + obj.value + "']").attr('style');
    	$(obj).attr('style', styleStr);
    }

  	//################# else function :E #################

};//end fnObj.



/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅

	//수정모드일때 내용가져오기
	if(mode=="update" && moduleInfoObj.length>0){
		fnObj.getModuleInfo();
	}

});

</script>