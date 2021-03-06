<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<style>
#mvBtn{
	position:absolute;
	width:30px;
	top:250px;
}
</style>


<section id="detail_contents">
	<div class="sys_halfWrap">
		<div class="fl_halfBox">
			<h3 class="h3_title_basic mgb10">메뉴리스트</h3>
			<div class="sys_search_box">
				<div id="AXSearchTarget" class="fl_block"></div>
			</div>
			<div id="AXGridTarget" class="mgt40"></div>
		</div>
		<div class="fr_halfBox">
			<h3 class="h3_title_basic mgb10">관계사별 메뉴 권한</h3>
			<div class="sys_search_box">
				<div id="AXSearchTarget2" class="fl_block"></div>
			</div>
			<div class="sys_p_noti mgt10 mgb10"><span class="icon_noti"></span><span class="pointB">[등록방법]</span><span> 수정한 메뉴구조를 적용하시려면 재로그인 하시기 바랍니다.</span> <span class="pointred">(사용여부가 'N' 인 메뉴들로 인해 구조가 깨지지않도록 주의)</span></div>
			<div id="AXGridTarget2"></div>

			<div class="systemBtn_bothz mgt20">
				<div class="fl_block" style="display:none;">
					<span class="sub_title">메뉴위치이동 :</span>
				    <button type="button" class="AXButton graarrow_x" onclick="fnObj.moveUp();"><i class="axi axi-chevron-up"></i></button>
				    <button type="button" class="AXButton graarrow_x" onclick="fnObj.moveDown();"><i class="axi axi-chevron-down"></i></button>
				</div>
                <div class="fr_block">
                	<button type="button" class="AXButton Classic btn_auth" onclick="fnObj.doSave();"><i class="fa fa-check-circle fa-lg"></i> 저장</button>
                 </div>
            </div>
		</div>
		<div class="btn_arrow_halbox" id="mvBtn">
			<button type="button" class="AXButton graarrow" onclick="fnObj.moveRight();"><i class="axi axi-chevron-right2" style="font-size:12px;"></i></button>
			<button type="button" class="AXButton graarrow" onclick="fnObj.moveLeft();"><i class="axi axi-chevron-left2" style="font-size:12px;"></i></button>
		</div>
	</div>
</section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드(외,코드)
//var comCodeMenuLoc;				//메뉴위치코드
var roleCodeCombo;				//권한코드

var mySearch = new AXSearch(); 	// instance
var mySearch2 = new AXSearch(); // instance (오른쪽)
var myGrid = new AXGrid(); 		// instance
var myGrid2 = new AXGrid(); 	// instance	(오른쪽)

var myModal = new AXModal();	// instance
var targetOrgId = "${targetOrgId}";

//이동위해 체크한 값 저장 array
var chkDataJar = new Array();

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		if(targetOrgId == ''){
			targetOrgId = "${baseUserLoginInfo.applyOrgId}";
		}
		//공통코드
		roleCodeCombo = getCodeInfo(lang, 'orgId', 'cpnNm', null, null, null, '/common/getOrgCodeCombo.do', { orgId : targetOrgId});		//권한코드(콤보용) 호출
		if(roleCodeCombo == null){
			roleCodeCombo = [{'orgId':'','cpnNm':'선택'}];
		}

		this.addComCodeArrayForOrgId(roleCodeCombo);


	},


	//화면세팅
    pageStart: function(){

    	//=================================================== 왼쪽 :s ======================================================
    	//-------------------------- 검색 :S ---------------------------
    	mySearch.setConfig({
            targetID : "AXSearchTarget",
            theme : "AXSearch",

            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },

            onsubmit: function(){	// 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
				fnObj.doSearch();
			},

			rows:[
					{display:true, addClass:"", style:"", list:[
   						{label:"검 색", type:"inputText", width:"150", key:"search", placeholder:"검색어입력", addClass:"secondItem" ,value:"",
   							onChange: function(changedValue){
   								//아래 2개의 값을 사용 하실 수 있습니다.
   								dialog.push(Object.toJSON(this));
   								dialog.push(changedValue);
   							}
   						},
   						{type : "button",  width:"40", value : "검색", addClass:"mgl10",
	   						onclick: function(selectedObject, value){
								//검색호출
								fnObj.doSearch();

							}

   						}
   					]}
			     ]

        });//end mySearch.setConfig
    	//-------------------------- 검색 :E ---------------------------

    	//-------------------------- 그리드 :S -------------------------
    	myGrid.setConfig({
            targetID : "AXGridTarget",
            theme : "AXGrid",

            fixedColSeq : 4,	//컬럼고정 index
            fitToWidth : true,	//true,	//넓이에맞게
            colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"

            colHeadTool : false,	//컬럼 display 여부를 설정

            height: 600,		//grid height

            autoChangeGridView: { // autoChangeGridView by browser width
                mobile:[0,600], grid:[600]
            },

            colGroup : [
                {key:"NO", 		label:"NO", 	width:"40", 	align:"center",	sort: false,  formatter:function(){
                	return ("<font color=silver><b>" + (this.index + 1) + "</b></font>");
                }},

                {key:"chk", 	label:"<input type='checkbox' name='allChkLeft' readonly='true' onclick='fnObj.allCheck(0);' />",  width:"30",	align:"center", sort: false,  formatter:function(){return ("<input type='checkbox' name='mCheckLeft' onclick='fnObj.clickCheckboxL(this, " + this.index + ");' " + ((this.value==1)?"checked":"") + " />");}},

                {key:"menuId", 			label:"ID", 		width:"50",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"menuTypeNm", 		label:"메뉴타입", 	width:"70",		align:"center"},
                {key:"menuTitleKor", 	label:"메뉴제목", 	width:"150",	align:"center"},
               /*  {key:"menuTitleEng", 	label:"메뉴제목영문", 	width:"150",	align:"center"}, */
                {key:"menuPath", 		label:"URL", 		width:"200",	align:"left"}


            ],
            body : {
                onclick: function(){

                },

                ondblclick: function(){

                }

            },
			page:{
				fullSizeButton: true,		//grid full size button

				paging:false,
				status:{formatter: null}
			}

        });
    	//-------------------------- 그리드 :E -------------------------

    	//-------------------------- 모달창 :S -------------------------
    	myModal.setConfig({
    		windowID:"myModalCT",
    		//openModalID:"kkkkk",
    		width:740,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
    		displayLoading:true,
            scrollLock: true,
    		onclose: function(){

    		}
            ,contentDivClass: "popup_outline"
    	});
    	//-------------------------- 모달창 :E -------------------------
    	//=================================================== 왼쪽 :E ======================================================


    	//=================================================== 오른쪽 :S =====================================================
    	//-------------------------- 검색 :S ---------------------------
    	//mySearch2 (오른쪽)
        mySearch2.setConfig({
            targetID : "AXSearchTarget2",
            theme : "AXSearch",

            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },

            onsubmit: function(){	// 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
				fnObj.doSearch2();
			},

			rows:[
					{display:true, addClass:"", style:"", list:[
   						{label:"관계사", type:"selectBox", width:"150", key:"targetOrgId", addClass:"secondItem", value:targetOrgId,
   							options: roleCodeCombo,
   							AXBind:{
   								type:"select", config:{
   									onChange:function(){
   										//toast.push(Object.toJSON(this));
   										fnObj.doSearch2();
   									}
   								}
   							}
   						},
   						{label:"", type:"inputText", width:"150", key:"searchMenu", placeholder:"검색어입력", addClass:"secondItem mgl10" ,value:"",
   							onchange: function(changedValue){
   								//아래 2개의 값을 사용 하실 수 있습니다.
   								dialog.push(Object.toJSON(this));
   								dialog.push(changedValue);
   							}
   						},
   						{type : "button",  width:"40", valueBoxStyle:"padding-left:2px;", value : "검색", addClass:"mgl10",
	   						onclick: function(selectedObject, value){
								//검색호출
								fnObj.doSearch2();

							}

   						}
   					]},
			     ]

        });//end mySearch2.setConfig
    	//-------------------------- 검색 :E ---------------------------

    	//-------------------------- 그리드 :S -------------------------
    	myGrid2.setConfig({
            targetID : "AXGridTarget2",
            theme : "AXGrid",

            fixedColSeq : 3,	//컬럼고정 index
            fitToWidth : true,	//true,	//넓이에맞게
            colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"
            colHeadTool : false,	//컬럼 display 여부를 설정
            height: 600,		//grid height

            autoChangeGridView: { // autoChangeGridView by browser width
                mobile:[0,600], grid:[600]
            },

            //passiveMode:true,
			//passiveRemoveHide:false,

            colGroup : [
                {key:"NO", 		label:"NO", 	width:"40", 	align:"center",	sort: false,  formatter:function(){
                	//return (this.list.length - this.index) + ( ( this.page.pageNo - 1) * this.page.pageSize );		//역순
                	return ("<font color=silver><b>" + (this.index + 1) + "</b></font>");
                }},

                {key:"chk", 	label:"<input type='checkbox' name='allChkRight' readonly='true' onclick='fnObj.allCheck(1);' />",  width:"30",	align:"center", sort: false,  formatter:function(){return ("<input type='checkbox' name='mCheckRight' onclick='fnObj.clickCheckboxR(this, " + this.index + ");' " + ((this.value==1)?"checked":"") + " />");}},

                {key:"menuId", 			label:"ID", 		width:"50",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"menuTypeNm", 		label:"메뉴타입", 	width:"70",		align:"center"},
                {key:"menuTitleKor", 	label:"메뉴제목한글", width:"150",	align:"center", formatter:function(){return ("<span class='titleKor'>" + (this.value) + "</span>");}},
               /*  {key:"menuTitleEng", 	label:"메뉴제목영문", width:"150",	align:"center"}, */
                {key:"menuPath", 		label:"URL", 		width:"250",	align:"left"},
                {key:"menuEnable", 		label:"메뉴사용여부", 	width:"70",	align:"center",  	formatter:function(){return (this.value == 'N' ? "<b>" + (this.value) + "</b>" : this.value);}},
            /*     {key:"orgMenuEnable", 	label:"관계사사용여부", 	width:"50",	align:"center",  	formatter:function(){return (this.value = 'N' ? "<b>" + (this.value) + "</b>" : this.value);}} */

            ],
            body : {
                onclick: function(){

                },

                ondblclick: function(){

                }

            },
			page:{
				fullSizeButton: true,		//grid full size button

				paging:false,
				status:{formatter: null}
			}

        });
    	//-------------------------- 그리드 :E -------------------------
    	//=================================================== 오른쪽 :E =====================================================

    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색(메뉴리스트)
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	var pars = mySearch.getParam();

    	var url = contextRoot + "/system/getMenuList.do";
    	var param = mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서
    	//param.enable = 'Y';	//사용여부 'Y' 인것만 권한별메뉴설정위해 ///////일단 N 도 메뉴설정할 수 있도록 해놓고 바서 바꾸자!!!!!!!!!!!!!!!!!!!!!!!
    	param.allTree = 'Y';	//메뉴타입이 'TREE' 인 것만
		param.enable ='Y';
    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var cnt = obj.resultVal;	//결과수
    		var list = obj.resultList;	//결과데이터JSON

    		var gridData = {list:list};

    		myGrid.clearSort();			//소팅초기화
    		myGrid.setData(gridData);	//그리드에결과반영
    	};

    	commonAjax("POST", url, param, callback);
    },//end doSearch


  	//검색(권한 위치별 메뉴리스트)
    doSearch2: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	var pars = mySearch2.getParam();

    	var url = contextRoot + "/system/getMenuListByOrg.do";
    	var param = mySearch2.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}

    		var cnt = obj.resultVal;	//결과수
    		var list = obj.resultList;	//결과데이터JSON

    		var gridData = {list:list};

    		myGrid2.clearSort();		//소팅초기화
    		myGrid2.setData(gridData);	//그리드에결과반영

    		fnObj.searchMenu(param.searchMenu);
    	};

    	commonAjax("POST", url, param, callback);
    },//end doSearch


  	//저장(메뉴구조)
    doSave: function(){

    	//--------------- validation :S ---------------
    	var list = myGrid2.getList();					//그리드 데이터 리스트


    	//------ 부모아이디, 루트아이디, 정렬값 구해서 세팅
    	var pArray = [];		//저장을 위해 새로운 배열객체를 만든다.
    	var rObj;				//row object
    	var cntLvl0 = 0;		//데이터 레벨

    	for(var i=0; i<list.length; i++){
    		rObj = new Object();	//row object

    		cntLvl0 ++;
    		rObj.sort = (cntLvl0 * 10000).toString();				// sort 값 세팅
    		rObj.orgId = $("select[name='targetOrgId']").val()		//타겟 orgid 값 세팅

    		rObj.menuId = list[i].menuId.toString();			//메뉴아이디 key,value 추가

    		//// 객체 추가
    		pArray.push(rObj);
    	}


    	//--------------- validation :E ---------------


    	//저장
    	var sObj = mySearch2.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서

    	var url = contextRoot + "/system/saveMenuListByOrg.do";
    	var param = {
    			pList:	  JSON.stringify(pArray),		//그리드 데이터 (JSON 문자열)
    			targetOrgId : $("select[name='targetOrgId']").val()
    	}
    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){
    			toast.push("저장OK!");
    			fnObj.doSearch2();
    		}else{
    			alertMsg("저장도중 오류가 발생하였습니다.");
    			return;
    		}

    	};

    	commonAjax("POST", url, param, callback);


    },//end doSave


    //배열에 새로운 인자로 추가 (공통코드 이상문제해결)
    addComCodeArray: function(obj){
		for(var i=0; i<obj.length; i++){
			obj[i].optionValue = obj[i].CD;		//'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
			obj[i].optionText  = obj[i].NM;		//'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
		}
    },
    //배열에 새로운 인자로 추가 (공통코드 이상문제해결)
    addComCodeArrayForOrgId: function(obj){
		for(var i=0; i<obj.length; i++){
			obj[i].optionValue = obj[i].orgId;		//'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
			obj[i].optionText  = obj[i].cpnNm;		//'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
		}
    },


  	//권한코드리스트 호출
    getRoleCodeList: function(code, name, emptyCode, emptyName){
    	var returnObj = null;	//array object

    	var emptyObj = null;	//select 박스용 첫번째 공백값
    	if(emptyCode != null){
    		var emptyJson = '{"';
    		emptyJson += (code + '":"' + emptyCode + '", "' + name + '":"' + emptyName + '"}');
    		emptyObj= JSON.parse(emptyJson);
    	}


    	var url = contextRoot + "/system/getRoleCodeList.do";

    	var paramObj = {
    		code : (code==null)?'CD':code,
    		name : (name==null)?'NM':name,
    	};
    	//callback function
    	var callback = function(result){ //SUCCESS FUNCTION
    		var obj = JSON.parse(result);

    		var cnt = obj.resultVal;	//결과수
    		var list = obj.resultList;	//결과데이터JSON

    		if(cnt>0){
    			returnObj = list;
    			if(emptyObj != null)
    				returnObj.unshift(emptyObj);	//select 박스용 첫번째 공백값 추가
    		}

    	};
    	//공통 ajax 호출 (Sync 로)
    	commonAjaxForSync("POST", url, paramObj, callback);

    	return returnObj;
    },


    //오른쪽으로 이동 (메뉴리스트 >> 권한별메뉴등록)
    moveRight: function(){
    	var leftList = myGrid.getList();								//왼쪽   그리드 데이터

    	var chkCnt = 0;			//이동을 위해 체크한 수
    	var chkIndex = -1;		//체크한 row index
    	var moveObj;			//체크해서 이동할 row Object
    	for(var i=0; i<leftList.length; i++){
    		if(leftList[i].chk == 1){	//체크되어 있는 것을
    			chkCnt++;
    			moveObj = leftList[i];									//이동할 row data

    			if(!fnObj.checkMoveRight(moveObj, myGrid2.getList())){
    				continue;
    			}
    			//추가(key,value)
    			moveObj.sort = 100;

    			myGrid2.pushList(moveObj);								//오른쪽 그리드에 추가
    		}
    	}

    	if(chkCnt == 0){
    		alertM("이동할 메뉴를 먼저 선택해주세요!");
    		return;
    	}

    	//그리드 사이즈 변경(데이터에 맞게)
    	//myGrid2.setHeight( myGrid2.getList().length * 28 + 56);
    	//fnObj.fullGridSize();
    	if($('#' + myGrid2.config.targetID + '_FullSizeButton').hasClass('open')){
    		$('#' + myGrid2.config.targetID + '_FullSizeButton').click();		//전체펼침 버튼 클릭
    	}
    },
    //메뉴 아이디를 체크하여 오른쪽 그리드 추가 여부 체크
    checkMoveRight : function(obj, list){
    	var moveYn = true;
    	for(var i = 0 ;i < list.length ;i++){
    		var item = list[i];
    		if(item.menuId == obj.menuId){
    			moveYn = false;
    		}
    	}

    	return moveYn;
    },

  	//왼쪽으로 이동 (메뉴리스트 << 권한별메뉴등록) ... 실제는 삭제로 구현
    moveLeft: function(){
    	var rightList = myGrid2.getList();								//오른쪽 그리드 데이터

    	var chkCnt = 0;			//이동을 위해 체크한 수
    	var chkIndex = -1;		//체크한 row index
    	var moveObj;			//체크해서 이동할 row Object
    	for(var i=rightList.length-1; i>=0; i--){
    		if(rightList[i].chk == 1){	//체크되어 있는 것을
    			chkCnt++;
    			rightList.splice(i, 1);									//체크 요소를 삭제
    		}
    	}

    	if(chkCnt == 0){
    		alertM("이동할 메뉴를 먼저 선택해주세요!");
    		return;
    	}

    	//그리드 싱크
    	myGrid.dataSync();
    	//myGrid2.dataSync();
    	myGrid2.redrawGrid();	//하단 상태바 count(s) 숫자도 반영되게하려면 redrawGrid().
    },

    //왼쪽 그리드 체크박스 클릭 이벤트 핸들러 (그리드 data Sync)
    clickCheckboxL: function(obj, idx){
    	var list = myGrid.getList();
    	if(obj.checked){
    		list[idx].chk = 1;
    	}else{
    		list[idx].chk = 0;
    	}
    },

  	//오른쪽 그리드 체크박스 클릭 이벤트 핸들러 (그리드 data Sync)
    clickCheckboxR: function(obj, idx){
    	var list = myGrid2.getList();
    	if(obj.checked){
    		list[idx].chk = 1;
    	}else{
    		list[idx].chk = 0;
    	}
    },

    //체크박스 전체 체크
    allCheck: function(knd){
    	if(knd == 0){	//왼쪽 그리드

    		var list = myGrid.getList();
    		var toBe = document.getElementsByName('allChkLeft')[1].checked;
    		for(var i=0; i<list.length; i++){
        		list[i].chk = toBe?1:0;	//그리드데이터도 함께 변환(아직 그리드 데이터는 변하지 않은 상태이기때문에)
        	}

    		myGrid.redrawGrid();
    		document.getElementsByName('allChkLeft')[1].checked = toBe;

    	}else{	// knd == 1 오른쪽


        	var list = myGrid2.getList();
    		var toBe = document.getElementsByName('allChkRight')[1].checked;
    		for(var i=0; i<list.length; i++){
        		list[i].chk = toBe?1:0;	//그리드데이터도 함께 변환(아직 그리드 데이터는 변하지 않은 상태이기때문에)
        	}

    		myGrid2.redrawGrid();
    		document.getElementsByName('allChkRight')[1].checked = toBe;

    	}
    },


    //오른쪽 체크박스 전체 해지
    uncheckAll: function(){
    	var chkList = document.getElementsByName('mCheckRight');
    	var list = myGrid2.getList();
    	var addIdx = chkList.length/2;
    	for(var i=chkList.length/2; i<chkList.length; i++){
    		chkList[i].checked = false;		//체크해지
    		list[i-addIdx].chk = 0;			//그리드데이터도 함께 변환(아직 그리드 데이터는 변하지 않은 상태이기때문에)
    	}
    },

    //찾기
    searchMenu : function(key){

    	if(key != '') if($('#' + myGrid2.config.targetID + '_FullSizeButton').hasClass('open')) $('#' + myGrid2.config.targetID + '_FullSizeButton').click();

    	$(".titleKor:contains('"+key+"')").css({"text-decoration" : "underline" , "background" : "#c6f55a" , "font-weight" : "bold", "padding" : "3px"});

    }

  	//################# else function :E #################



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();		//검색(메뉴리스트)
	fnObj.doSearch2();		//검색(권한별메뉴)

});
</script>