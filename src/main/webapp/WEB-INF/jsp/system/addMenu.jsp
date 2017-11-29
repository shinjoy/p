<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!-- -------- each page css :S -------- -->

<!-- -------- each page css :E -------- -->

<input type="hidden" id="menuParentId" value="">
<input type="hidden" id="menuRootId" value="">
<input type="hidden" id="roleMenuId" value="0">

<form name="myForm" method="post">
	<div class="mo_container">
	<c:if test="${mode eq 'update'}">
		<div class="sys_p_noti mgt10 mgb10 "><span class="icon_noti"></span><span class="pointB">메뉴수정</span><span> 시</span><span class="fontRed"> 코드명</span><span> 변경 주의! 프로그램에 영향을 줄 수 있음.</span></div>
	</c:if>
		<table class="tb_basic_left">	<!-- AXFormTable : width 100% >> 98% (재정의) -->
	    	<colgroup>
				<col width="150" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
		 			<th scope="row"><label for="inputMenuId">메뉴ID</label></th>
		 			<td bgcolor="#F7F7F7"><input id="inputMenuId" type="text" name="menuId" placeholder="자동설정" value="" class="input_b" readonly="readonly" /></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="menuTypeRadioTag">메뉴타입</label></th>
		 			<td><div id="menuTypeRadioTag"></div></td>
		 		</tr>
		 		<tr id="topMenuTr" style="display:none;">
		 			<th scope="row"><label for="menuTypeRadioTag">상위메뉴</label></th>
		 			<td>
		 				<div id="btnTopMenu">
		 					<a href="#" onclick="fnObj.parentSet();return false;" id="cus_id" class="btn_s_type_g" title=""><em>선택</em></a>
		 				</div>
		 				<div id="topMenuArea" style="display:none;"></div>
		 			</td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="inputMenuNum">메뉴번호<em>(바로가기)</em></label></th>
		 			<td><input id="inputMenuNum" type="text" name="menuNum" placeholder="메뉴번호를 입력" value="" class="input_b" /><span class="fontGray txt_letter0 mgl6">4자리 예)0010</span></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="inputMenuEng">코드명</label></th>
		 			<td><input id="inputMenuEng" type="text" name="menuEng" placeholder="코드명을 입력하세요" value="" class="input_b w200px" onchange="fnObj.changeMenuCode();" />
		 				<button type="button" id="btnLoginIdChk" class="btn_s_type2 mgl6" onclick="fnObj.doMenuCodeValidChk();return false;"><em class="icon_search">유효검사</em></button>
		 				<span class="fontRed mgl6">대문자, 공백없이</span>
		 			</td>
		 		</tr>
		 		<tr style="display:none;">
		 			<th scope="row"><label for="inputMenuKor">한글명</label></th>
		 			<td><input id="inputMenuKor" type="text" name="menuKor" placeholder="한글명을 입력하세요" value="" class="input_b w200px" /></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="inputMenuTitleKor">메뉴명(한글)</label></th>
		 			<td><input id="inputMenuTitleKor" type="text" name="menuTitleKor" placeholder="한글명을 입력하세요" value="" class="input_b w200px" /><span class="fontGray mgl6">화면에 보이는 한글명</span></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="inputMenuTitleEng">메뉴명(영문)</label></th>
		 			<td><input id="inputMenuTitleEng" type="text" name="menuTitleEng" placeholder="영문명을 입력하세요" value="" class="input_b w200px" /><span class="fontGray mgl6">화면에 보이는 영문명</span></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="inputMenuDesc">설명</label></th>
		 			<td><input id="inputMenuDesc" type="text" name="menuDesc" placeholder="설명을 입력하세요" value="" class="input_b w100" /></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="inputMenuPath">URL</label></th>
		 			<td><input id="inputMenuPath" type="text" name="menuPath" placeholder="경로를 입력하세요. 예) system/menuMgmt.do" value="" class="input_b w100" /></td>
		 		</tr>

		 		<tr>
		 			<th scope="row"><label for="inputCssNm">CSS스타일명</label></th>
		 			<td><input id="inputCssNm" type="text" name="cssNm" placeholder="스타일명을 입력하세요" value="" class="input_b w200px" /><span class="fontGray mgl6">메뉴 아이콘 표시</span></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="selEnable">사용여부</label></th>
		 			<td>
		 				<select id="selEnable" name="enable" class="select_b" onchange="fnObj.selEnableChnged(this);">
		   					<option value='Y' style='background-color:;'>Y</option>
		   					<option value='N' style='background-color:silver;'>N</option>
		   				</select>
		   			</td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="vipAuthYn">VIP권한여부</label></th>
		 			<td>
		 				<select id="vipAuthYn" name="vipAuthYn" class="select_b" onchange="fnObj.selVipAuthChnged(this);">
		   					<option value='Y' style='background-color:;'>Y</option>
		   					<option value='N' style='background-color:silver;'>N</option>
		   				</select>
		   			</td>
		 		</tr>
			</tbody>
		</table>
		<div class="btnZoneBox">
			<button id="btnSave" type="button" onclick="fnObj.doSave();" class="p_blueblack_btn btn_auth"><strong>저장</strong></button>&nbsp;
			<!-- <button id="btnDel" type="button" onclick="fnObj.tryDelete();" class="p_withelin_btn">삭제</button> -->
		</div>
	</div>
</form>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드
var comCodeMenuType;				//메뉴타입

var mode = "<c:out value='${mode==null?"new":mode}'/>";	//"new", "update"
//var menuId = "<c:out value='${menuId}'/>";	//"update" mode 메뉴아이디
var menuInfoObj = "<c:out value='${menuInfoObj}'/>";	//"update" mode 메뉴정보
var codeList = "${codeList}";							//기존 등록된 코드 리스트 문자열 ex) 'EAM,SYSTEM,ROL_PER_USER,...'
var menuNumList = "${menuNumList}";						//기존 등록된 메뉴번호
var inputTitleBorder;				//제목 border style
var contentBorder;					//내용 border style

var g_oriMenuCode = '';				//수정 모드시 원래 메뉴코드
var g_validCodeYn = ''; 			//메뉴코드 유효성 검사 '':미검사, 'Y':유효, 'N':적합치않은

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//공통코드
		comCodeMenuType = getBaseCommonCode('MENU_TYPE', lang, 'CD', 'NM', null, '','', { orgId : "${baseUserLoginInfo.orgId}" });		//메뉴타입 공통코드 (Sync ajax)

		var menuTypeRadioTag = createRadioTag('rdMenuType', comCodeMenuType, 'CD', 'NM', 'TREE', '', '', 'fnObj.clickMenuType();');	//radio tag creator 함수 호출 (common.js)
		$("#menuTypeRadioTag").html(menuTypeRadioTag).addClass("rd_systemList");
	},


	//화면세팅
    pageStart: function(){

    	//입력값 패턴 지정
    	$('#inputMenuNum').bindPattern({pattern:'custome', max_length:4, patternString:'9999'});		//메뉴번호(퀵넘버)


    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//저장
    doSave: function(){

    	//-------------------- validation :S --------------------
    	var frm = document.myForm;

    	if(isEmpty(frm.menuEng.value)){			//코드명
    		dialog.push({body:"<b>확인!</b> 코드명을 입력해주세요!", type:"", onConfirm:function(){frm.menuEng.focus();}});
    		return;
    	}


    	if(mode=='new' || g_oriMenuCode != frm.menuEng.value){
	   		if(isEmpty(g_validCodeYn)){
	   			dialog.push({body:"<b>확인!</b> 코드명 유효검사를 해주세요!", type:"", onConfirm:function(){frm.menuEng.focus();}});
	       		return;
	   		}else if(g_validCodeYn == 'N'){
	   			dialog.push({body:"<b>확인!</b> 코드명이 이미 존재합니다. 다른 코드를 선택해주세요!", type:"", onConfirm:function(){frm.menuEng.focus();}});
	       		return;
	   		}
    	}



    	if(isEmpty(frm.menuTitleKor.value)){	//메뉴제목한글
    		dialog.push({body:"<b>확인!</b> 메뉴명(한글)을 입력해주세요!", type:"", onConfirm:function(){frm.menuTitleKor.focus();}});
    		return;
    	}
    	if(isEmpty(frm.menuTitleEng.value)){	//메뉴제목영문
    		dialog.push({body:"<b>확인!</b> 메뉴명(영문)을 입력해주세요!", type:"", onConfirm:function(){frm.menuTitleEng.focus();}});
    		return;
    	}
    	if(isEmpty(frm.menuDesc.value)){		//설명
    		dialog.push({body:"<b>확인!</b> 설명을 입력해주세요!", type:"", onConfirm:function(){frm.menuDesc.focus();}});
    		return;
    	}
    	//----- 코드명이 존재하는 코드명인지

    	var menuCode = frm.menuEng.value.toUpperCase();		//등록하려는 코드명
		var codeListArr = codeList.split(',');
    	for(var i=0; i<codeListArr.length; i++){
    		if(codeListArr[i] == menuCode){		//기 등록 코드명이면
    			dialog.push({body:"<b>확인!</b> 이미 등록된 코드명입니다! <br><br> 다른 코드명을 입력해주세요!", type:"", onConfirm:function(){frm.menuEng.select();}});
        		return;
    		}
    	}

    	//----- 메뉴번호 중복검사

    	var menuNum = frm.menuNum.value;		//등록하려는 메뉴번호
		var menuNumArr = menuNumList.split(',');
    	for(var i=0; i<menuNumArr.length; i++){
    		if(menuNum!='' && menuNumArr[i] == menuNum){		//기 등록 코드명이면
    			dialog.push({body:"<b>확인!</b> 이미 등록된 메뉴번호 입니다! <br><br> 다른 메뉴번호를 입력해주세요!", type:"", onConfirm:function(){frm.menuNum.select();}});
        		return;
    		}
    	}

    	//----- 탭 일때 상위메뉴 필수.

    	var menuRootId =$("#menuRootId").val();
    	var menuParentId =$("#menuParentId").val();
    	var checkVal = $("input[name=rdMenuType]:checked").val();
    	if(checkVal == 'TAB' && menuParentId ==""){
    		dialog.push({body:"<b>확인!</b> 상위메뉴를 선택해주세요!", type:""});
    		return;
    	}

    	//------ 부모 아이디 세팅

    	//타입이 탭과 팝업이 아니면,빈값세팅
    	if(checkVal != 'TAB' && checkVal != 'ALONE'){
    		menuParentId = ""; menuRootId = "";
    	}
    	//if(menuParentId == menuRootId) menuParentId = "";			//같으면(최상위 메뉴) menuRootId 에만 세팅을 해준다.기존에 그렇게되어있음..

    	//-------------------- validation :E --------------------

    	var url = contextRoot + "/system/doSaveMenu.do";
    	var param = {
    			mode: mode,			//화면 모드 mode : "new", "update"
    			menuId: frm.menuId.value,
    			menuNum: frm.menuNum.value,
    			menuType: $('input[name=rdMenuType]:checked').val(),
    			menuClass: 'WHOLE',					//임시!!!!!!!!!!!!!!!!!!!!!!!!!!바꾸자!!!!!!어케할지!!!!!!!!!!!!!!!!!!!!!!!!
    			menuKor: frm.menuTitleKor.value,
    			menuEng: frm.menuEng.value,
    			menuDesc: frm.menuDesc.value,
    			menuPath: frm.menuPath.value,
    			menuTitleKor: frm.menuTitleKor.value,
    			menuTitleEng: frm.menuTitleEng.value,
    			cssNm: frm.cssNm.value,
    			enable: frm.enable.value,
    			vipAuthYn: frm.vipAuthYn.value,
    			menuParentId: menuParentId,
    			menuRootId : menuRootId,
    			roleMenuId : $("#roleMenuId").val()
    	}



    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    		}

    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){

    			parent.fnObj.doSearch(parent.curPageNo);	//목록화면 재조회 호출.
    			parent.myModal.close();						//글쓰기 창 닫기.
    			//parent.dialog.push("등록OK!");
    			parent.toast.push("저장OK!");
    		}else{
    			//alertMsg();
    		}

    	};

    	commonAjax("POST", url, param, callback);
    },//end doSave


    //메뉴정보 가져오기
    getMenuInfo: function(){
		var frm = document.myForm;
    	var menuInfo = JSON.parse(menuInfoObj.replace(/&#034;/gi,'"'));

    	//메뉴정보 세팅
		frm.menuId.value = menuInfo.menuId;
		var menuType = menuInfo.menuType;


		$("input[value='"+menuType+"']").attr("checked",true);

		if(menuType=='TAB' || menuType=='ALONE' || menuType=='M_TREE'){

			$("#menuParentId").val(menuInfo.menuParentId);
			$("#menuRootId").val(menuInfo.menuRootId);
			$("#roleMenuId").val(menuInfo.roleMenuId);

			$("#topMenuTr").show();
		}


		if(menuInfo.menuTitle != ''){
			$("#btnTopMenu").hide();
	    	$("#topMenuArea").html(menuInfo.menuTitle+'<a href="#" style="margin-left: 7px;" onclick="fnObj.clearTopMenu();return false;" class="btn_s_type_g" title=""><em>초기화</em></a>');
	    	$("#topMenuArea").show();
		}

		 if(menuInfo.menuNum != null) frm.menuNum.value =menuInfo.menuNum;
		frm.menuKor.value = menuInfo.menuTitleKor;
		frm.menuEng.value = menuInfo.menuEng;
		g_oriMenuCode = menuInfo.menuEng;			//original menu code
		frm.menuDesc.value = menuInfo.menuDesc;
		frm.menuPath.value = (menuInfo.menuPath==undefined)?"":menuInfo.menuPath;
		frm.menuTitleKor.value = menuInfo.menuTitleKor;
		frm.menuTitleEng.value = menuInfo.menuTitleEng;
		 if(menuInfo.cssNm != null) frm.cssNm.value = menuInfo.cssNm;
		frm.enable.value = menuInfo.enable;
		frm.vipAuthYn.value = menuInfo.vipAuthYn;

		fnObj.selEnableChnged(frm.enable);	//enable 'N'배경색 반영
		fnObj.selVipAuthChnged(frm.vipAuthYn);	//vipAuthYn 'N'배경색 반영

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

    	var url = contextRoot + "/system/deleteMenu.do";
    	var param = {
    			menuId: document.myForm.menuId.value
    	}
    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    		}

    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){
    			parent.fnObj.doSearch(parent.curPageNo);	//목록화면 재조회 호출.
    			parent.myModal.close();						//글쓰기 창 닫기.
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
    },

    //특별권한사용여부
    selVipAuthChnged: function(obj){
    	//background-color
    	var styleStr = $("#" + obj.id + " > option[value='" + obj.value + "']").attr('style');
    	$(obj).attr('style', styleStr);
    },

    //메뉴 종류 변경시
    clickMenuType : function(){

    	var checkVal = $("input[name=rdMenuType]:checked").val();

    	if(checkVal == 'TAB' || checkVal == 'ALONE'){
    		$("#topMenuTr").show();

    	}else{
    		$("#topMenuTr").hide();
    	}
    	parent.myModal.resize();
    },

    parentSet : function(){

    	var url = "${pageContext.request.contextPath}/system/setTopMenuPop.do";
    	var option = "left=" + (screen.width > 1400?"500":"0") + ", top=" + (screen.height > 810?"50":"0") + ", width=800, height=900, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=no";
    	window.open(url, "_blank", option);

    },

    //상위메뉴 세팅
    setTopMenu : function(menuStr,menuRootId){
    	var menuObj = JSON.parse(menuStr);
    	$("#btnTopMenu").hide();
    	$("#topMenuArea").html(menuObj.menuTitleKor+'<a href="#" style="margin-left: 7px;" onclick="fnObj.clearTopMenu();return false;" class="btn_s_type_g" title=""><em>초기화</em></a>');
    	$("#topMenuArea").show();
    	$("#menuParentId").val(menuObj.menuId);
    	$("#menuRootId").val(menuRootId);
    //	alert(menuObj.menuId+":"+menuRootId);
    },

    //초기화 버튼 액션
    clearTopMenu : function(){
    	$("#btnTopMenu").show();
    	$("#topMenuArea").empty();
    	$("#topMenuArea").hide();
    	$("#menuParentId").val('');
    	$("#menuRootId").val('');
    },


    //메뉴코드 변경 이벤트 핸들러
    changeMenuCode: function(){
    	g_validCodeYn = '';			//메뉴코드 유효성체크 초기화.
    },


  	//유효검사
    doMenuCodeValidChk: function(){

    	var menuCode = $('#inputMenuEng').val();		//메뉴 코드


    	//-------------------- validation :S --------------------

    	if(isEmpty(menuCode)){
    		dialog.push({body:"<b>확인!</b> 메뉴코드를 입력하시기 바랍니다!", type:"", onConfirm:function(){$('#inputMenuEng').focus();return;}});
    		return;
    	}

    	menuCode = menuCode.trim().toUpperCase();
    	$('#inputMenuEng').val(menuCode);

    	//첫문자가 영문인지
    	if(strInNum(menuCode.substring(0,1))){
    		dialog.push({body:"<b>확인!</b> 첫문자는 영문으로 입력해주세요!", type:"", onConfirm:function(){$('#inputMenuEng').focus();return;}});
    		return;
    	}


    	if(mode=='update' && g_oriMenuCode == $('#inputMenuEng').val()){
    		dialog.push({body:"<b>기존 코드 유지!</b><br/> 기존 코드 유지이므로 유효합니다!", type:"", onConfirm:function(){$('#inputMenuEng').focus();return;}});
    		return;		//중복체크 안해도 되는 케이스 skip
    	}


    	var url = contextRoot + "/system/getMenuCodeExist.do";
    	var param = {
    			menuCode : menuCode
    	};
    	var callback = function(result){

    		var obj = JSON.parse(result);
    		var resultObj = obj.resultObject;	//결과	'Y' or 'N'

    		if(obj.result == "SUCCESS"){
    			if(resultObj == 'N'){
	    			dialog.push({body:"<b>OK!</b> 사용가능한 코드입니다.", type:"", onConfirm:function(){
	    				g_validCodeYn = 'Y';
					}});
    			}else{
    				dialog.push({body:"<b>이미존재!</b> &nbsp;중복된 코드입니다. 다른 코드를 입력해주세요!", type:"warning", onConfirm:function(){
    					$('#inputMenuEng').select();
    					g_validCodeYn = 'N';
					}});
    			}
    		}else{
    			alertM("유효성 검사 도중 오류가 발생하였습니다.");
    			return;
    		}

    	};

    	commonAjax("POST", url, param, callback);

    	//-------------------- validation :E --------------------


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
	if(mode=="update" && menuInfoObj.length>0){
		fnObj.getMenuInfo();
	}else{
		$("#vipAuthYn").val("N");
		var frm = document.myForm;
		fnObj.selVipAuthChnged(frm.vipAuthYn);	//vipAuthYn 'N'배경색 반영
	}

});

</script>