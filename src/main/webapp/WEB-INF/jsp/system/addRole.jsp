<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<form name="myForm" method="post">
	<div class="mo_container">
		<table class="tb_basic_left">	<!-- AXFormTable : width 100% >> 98% (재정의) -->
	    	<colgroup>
				<col width="100" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr style="display:none;">
		 			<th scope="row"><label for="inputRoleId">권한ID</label></th>
		 			<td bgcolor="#F7F7F7"><input id="inputRoleId" type="text" name="roleId" placeholder="자동설정" value="" class="input_b w200px" readonly="readonly" /></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="inputOrgNm">관계사</label></th>
		 			<td class="last" bgcolor="#F7F7F7">
		   				<input id="inputOrgNm" type="text" name="orgNm" placeholder="자동설정" value="" class="input_b" readonly="readonly" />
		   				<input id="inputOrgId" type="hidden" name="orgId" placeholder="자동설정" value="" class="input_b" readonly="readonly" />
		 			</td>
		 		</tr>
				<tr style="display:none;">
		 			<th scope="row"><label for="inputRoleCode">권한코드</label></th>
		 			<td><input id="inputRoleCode" type="text" name="roleCode" placeholder="권한코드를 입력하세요" value="" class="input_b w200px" maxlength="15"/></td>
		 		</tr>
				<tr>
		 			<th scope="row">
		  				<div class="tdRel"><label for="inputRoleKor">권한명</label></div>
		 			</th>
		 			<td><input id="inputRoleKor" type="text" name="roleKor" placeholder="권한명을 입력하세요" value="" class="input_b w200px" /></td>
		 		</tr>
				<tr>
		 			<th scope="row"><label for="inputRoleEng">영문명</label></th>
		 			<td><input id="inputRoleEng" type="text" name="roleEng" placeholder="영문명을 입력하세요" value="" class="input_b w200px" /></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="inputRoleDesc">설명</label></th>
		 			<td><input id="inputRoleDesc" type="text" name="roleDesc" placeholder="설명을 입력하세요" value="" class="input_b w100" /></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="inputSort">정렬값</label></th>
		 			<td><input id="inputSort" type="text" name="sort" placeholder="정렬값 입력" value="" class="input_b" /></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="selEnable">사용여부</label></th>
		 			<td>
		   				<select id="selEnable" name="enable" class="AXSelect" onchange="fnObj.selEnableChnged(this);">
		   					<option value='Y' style='background-color:;'>Y</option>
		   					<option value='N' style='background-color:silver;'>N</option>
		   				</select>
		 			</td>
		 		</tr>
			</tbody>
		</table>
		<div class="btnZoneBox">
			<button id="btnSave" type="button" onclick="fnObj.doSave();" class="p_blueblack_btn btnAuth"><strong>저장</strong></button>&nbsp;
			<button id="btnDel" type="button" onclick="fnObj.tryDelete();" class="p_withelin_btn btnAuth">삭제</button>
		</div>

		<!--<div style="margin:10px;text-align:center;">
			<button id="btnSave" type="button" class="AXButton Classic" onclick="fnObj.doSave();"><i class="fa fa-check-circle fa-lg"></i>&nbsp;&nbsp;저&nbsp;&nbsp;&nbsp;&nbsp;장&nbsp;&nbsp;&nbsp;</button>
			<button id="btnDel" type="button" class="AXButton Classic" onclick="fnObj.tryDelete();"><i class="fa fa-trash-o fa-lg" ></i>&nbsp;&nbsp;삭&nbsp;&nbsp;&nbsp;&nbsp;제&nbsp;&nbsp;&nbsp;</button>
		</div> -->
	</div>
</form>



<script type="text/javascript">

//Global variables :S ---------------
//공통코드
//var comCodeMenuType;				//메뉴타입

var mode = "<c:out value='${mode==null?"new":mode}'/>";		//"new", "update"
//var menuId = "<c:out value='${menuId}'/>";	//"update" mode 메뉴아이디
var roleInfoObj = "<c:out value='${roleInfoObj}'/>";	//"update" mode 메뉴정보
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
		//comCodeMenuType = getCommonCode('MENU_TYPE', 'CD', 'NM');		//메뉴타입 공통코드 (Sync ajax)


		//var menuTypeRadioTag = createRadioTag('rdMenuType', comCodeMenuType, 'CD', 'NM', 'TREE');	//radio tag creator 함수 호출 (common.js)
		//$("#menuTypeRadioTag").html(menuTypeRadioTag);
	},


	//화면세팅
    pageStart: function(){

    	$("#inputSort").bindNumber({min:0, max:1000});


    	if(mode=="new"){		//신규일때
    		$('#btnDel').hide();		//삭제버튼 hide
    	}


    	//관계사 정보 세팅
    	var pOrgId = parent.mySearch.getParam().queryToObjectDec()["orgSelBox"];		//부모창의(권한등록 화면) 관계사 선택한 orgId
    	var pObj = getRowObjectWithValue(parent.orgCodeCombo, "optionValue", pOrgId);	//부모창에서 선택한 관계사 콤보박스의 값으로 객체추출
    	$("#inputOrgId").val(pObj["optionValue"]);		//orgId
    	$("#inputOrgNm").val(pObj["optionText"]);		//관계사명

    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//저장
    doSave: function(){

    	//-------------------- validation :S --------------------
    	var frm = document.myForm;

    	/* if(isEmpty(frm.roleCode.value)){		//권한코드
    		dialog.push({body:"<b>확인!</b> 권한코드를 입력해주세요!", type:"", onConfirm:function(){frm.roleCode.focus();}});
    		return;
    	} */
    	if(isEmpty(frm.roleKor.value)){			//권한명
    		dialog.push({body:"<b>확인!</b> 권한명을 입력해주세요!", type:"", onConfirm:function(){frm.roleKor.focus();}});
    		return;
    	}
    	if(isEmpty(frm.roleEng.value)){			//권한영문명
    		dialog.push({body:"<b>확인!</b> 영문명을 입력해주세요!", type:"", onConfirm:function(){frm.roleEng.focus();}});
    		return;
    	}
    	/* if(isEmpty(frm.roleDesc.value)){		//설명
    		dialog.push({body:"<b>확인!</b> 설명을 입력해주세요!", type:"", onConfirm:function(){frm.roleDesc.focus();}});
    		return;
    	} */

    	//----- 코드명이 이미 존재하는 코드명인지
		/* var roleCode = frm.roleCode.value.toUpperCase();		//등록하려는 코드명
    	var codeListArr = codeList.split(',');

    	for(var i=0; i<codeListArr.length; i++){
    		if(codeListArr[i] == roleCode){		//기 등록 코드명이면
    			dialog.push({body:"<b>확인!</b> 이미 등록된 권한코드 입니다! <br><br> 다른 코드명을 입력해주세요!", type:"", onConfirm:function(){frm.roleCode.select();}});
        		return;
    		}
    	} */

    	//-------------------- validation :E --------------------

    	var url = contextRoot + "/system/doSaveRole.do";
    	var param = {
    			mode: mode,			//화면 모드 mode : "new", "update"
    			orgId: frm.orgId.value,
    			roleId: frm.roleId.value,
    			//roleCode: frm.roleCode.value,
    			roleKor: frm.roleKor.value,
    			roleEng: frm.roleEng.value,
    			roleDesc: frm.roleDesc.value,
    			sort: frm.sort.value,
    			enable: frm.enable.value,
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


    //권한정보 가져오기
    getRoleInfo: function(){
		var frm = document.myForm;
    	var roleInfo = JSON.parse(roleInfoObj.replace(/&#034;/gi,'"'));

    	//권한정보 세팅
		frm.roleId.value = roleInfo.roleId;
		//frm.roleCode.value = roleInfo.roleCode;
		frm.roleKor.value = roleInfo.roleKor;
		frm.roleEng.value = isEmpty(roleInfo.roleEng)?'':roleInfo.roleEng;
		frm.roleDesc.value = roleInfo.roleDesc;
		frm.sort.value = roleInfo.sort;
		frm.enable.value = roleInfo.enable;

		fnObj.selEnableChnged(frm.enable);	//enable 'N'배경색 반영

		var orgAccessAuth = getOrgAccessAuth(roleInfo.orgId);
		if(orgAccessAuth == "READ" || orgAccessAuth == "NONE"){
			$(".btnAuth").hide();
		}else{
			$(".btnAuth").show();
		}

    },//end getArticle


    //권한삭제 (일단 enable(사용여부 N 으로... 사용여부N으로 하고 저장하는 부분과 중복이나, 바서 진짜 삭제해도 되면 삭제!!!!!!))
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

    	var url = contextRoot + "/system/deleteRole.do";
    	var param = {
    			roleId: document.myForm.roleId.value
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
	if(mode=="update" && roleInfoObj.length>0){
		fnObj.getRoleInfo();
	}



});

</script>