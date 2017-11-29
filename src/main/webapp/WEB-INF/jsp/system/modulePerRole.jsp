<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="customTagUi" uri="/WEB-INF/tlds/ui.tld"%>
<style>
.row_disable_class td{text-decoration: line-through;text-decoration-color:red!important;}
</style>

<section id="detail_contents">
	<div class="sys_halfWrap" id="modulePerRole">
		<div class="fl_halfBox">
			<h3 class="h3_title_basic mgb10">모듈리스트</h3>
			<div class="sys_search_box">
				<div id="AXSearchTarget" class="fl_block"></div>
				<!-- <div class="fr_block">
					<button name="reg_btn" class="btn_b2_skyblue" onclick="fnObj.excelDownload();"><em class="icon_XLS">파일로 저장</em></button>
				</div> -->
			</div>
			<div id="AXGridTarget" class="mgt40"></div>
		</div>
		<div class="fr_halfBox">
			<h3 class="h3_title_basic mgb10">권한별모듈등록</h3>
			<div class="sys_search_box">
				<div id="AXSearchTarget2" class="fl_block"></div>
				<!-- <div class="fr_block">
					<button name="reg_btn" class="btn_b2_skyblue" onclick="fnObj.excelDownload();"><em class="icon_XLS">파일로 저장</em></button>
				</div> -->
			</div>
			<div class="sys_p_noti mgt10 mgb10"><span class="icon_noti"></span><span class="pointB">[등록방법]</span><span> 수정한 메뉴구조를 적용하시려면 재로그인 하시기 바랍니다.</span> <span class="pointred">(사용여부가 'N' 인 메뉴들로 인해 구조가 깨지지않도록 주의)</span></div>
			<div id="AXGridTarget2"></div>
			<div class="systemBtn_bothz mgt20">
				<div class="fl_block">
					<span class="sub_title">모듈순서이동 :</span>
				    <button type="button" class="AXButton graarrow_x" onclick="fnObj.moveUp();"><i class="axi axi-chevron-up"></i></button>
				    <button type="button" class="AXButton graarrow_x" onclick="fnObj.moveDown();"><i class="axi axi-chevron-down"></i></button>
                </div>
                <div class="fr_block">
                	<customTagUi:authBtn txt="<i class='axi axi-content-copy'></i> 권한별모듈 복사" orgId="${empty targetOrgId ? baseUserLoginInfo.applyOrgId:targetOrgId}" event="onclick='fnObj.copyRole();'" ele="button" classValue="AXButton Classic btn_auth" id="btnSave"/>
                	<customTagUi:authBtn txt="<i class='fa fa-check-circle fa-lg'></i> 저장" orgId="${empty targetOrgId ? baseUserLoginInfo.applyOrgId:targetOrgId}" event="onclick='fnObj.doSave();'" ele="button" classValue="AXButton Classic btn_auth" id="btnSave"/>
                 </div>
            </div>
		</div>
		<div class="btn_arrow_halbox">

			<button type="button" class="AXButton graarrow" onclick="fnObj.moveRight();"><i class="axi axi-chevron-right2" style="font-size:12px;"></i></button>
			<button type="button" class="AXButton graarrow" onclick="fnObj.moveLeft();"><i class="axi axi-chevron-left2" style="font-size:12px;"></i></button>
		</div>
	</div>
</section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드
var comCodeModulePosType;		//모듈배치타입	('RELATIVE', 'ABSOLUTE')
var roleCodeCombo;				//권한코드
var orgCodeCombo; 				//관계사
var targetOrgId = '${targetOrgId}';	//관계사 아이디

var mySearch = new AXSearch(); 	// instance
var mySearch2 = new AXSearch(); // instance (오른쪽)
var myGrid = new AXGrid(); 		// instance
var myGrid2 = new AXGrid(); 	// instance	(오른쪽)

var myModal = new AXModal();	// instance
//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//공통코드
		//comCodeRoleCd  = getCommonCode('ROLE_CODE', 'optionValue', 'optionText');		//권한 공통코드 (Sync ajax)
		//comCodeMenuLoc = getCommonCode('MENU_LOC',  'optionValue', 'optionText');		//메뉴위치 공통코드 (Sync ajax)
		//comCodeRoleCd  = getCommonCode('ROLE_CODE', lang, 'CD', 'NM');				//권한 공통코드 (Sync ajax)

		if(targetOrgId == ''){
			targetOrgId = '${baseUserLoginInfo.applyOrgId}' ;
		}
		var params = {'authOrgId':'Y', 'userId':'${baseUserLoginInfo.userId}'};		//나에게 권한이 있는 관계사만 볼 수 있다
		orgCodeCombo = getCodeInfo(lang, 'optionValue', 'optionText', null, null, null, '/common/getOrgCodeCombo.do', params);	//ORG코드(콤보용) 호출
		if(orgCodeCombo == null){
			orgCodeCombo = [{'CD':'','NM':'선택'}];
    	}
		comCodeModulePosType = getBaseCommonCode('MODULE_POS_TYPE', lang, 'CD', 'NM', null, '','',  { 'orgId' : targetOrgId });		//모듈배치타입 공통코드 (Sync ajax)
		if(comCodeModulePosType == null ){
			comCodeModulePosType = [{  CD : '', NM : '선택'}];
		}
		roleCodeCombo = getCodeInfo(lang, 'CD', 'NM', null, null, null, '/system/getRoleCodeCombo.do' , { 'orgId' : targetOrgId , enable : 'Y' });		//권한코드(콤보용) 호출
		if(roleCodeCombo == null ){
			roleCodeCombo = [{  CD : '', NM : '선택'}];
		}
		//'optionValue','optionText' 프로퍼티를 생성하며 값으로 CD, NM 의 값 할당
		this.addComCodeArray(roleCodeCombo);
		this.addComCodeArray(comCodeModulePosType);

	},
	//관계사 선택 시 권한 창 달라지게하기위함.
	doMove : function(){

		$("<form />", { name : "myForm", id : "myForm", method : "post", action : contextRoot +"/system/modulePerRole.do"}).appendTo("#modulePerRole");
		$("<input />", { name : "targetOrgId", id : "targetOrgId", value : $("select[name='orgId']").val() }).appendTo("#myForm");
		$("#myForm").submit();

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
						{label:"관계사", labelWidth:"", type:"selectBox", width:"", key:"orgId", addClass:"secondItem", valueBoxStyle:"", value: targetOrgId,
							options: orgCodeCombo,
							AXBind:{
								type:"select", config:{
									onChange:function(){
										fnObj.doMove();		//orgID에 해당하는 화면 표시.
									}
								}
							}
						},
   						{ type:"inputText", width:"150", key:"search", placeholder:"검색어입력", addClass:"secondItem mgl10",  value:"",
   							onChange: function(changedValue){
   								//아래 2개의 값을 사용 하실 수 있습니다.
   								dialog.push(Object.toJSON(this));
   								dialog.push(changedValue);
   							}
   						},
   						{type : "button",  width:"40", value : "검색", addClass:"mgl10",
   	   						onClick: function(selectedObject, value){
   								//검색호출
   								fnObj.doSearch();

   							}

      					}
   					]},
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

            height: 570,		//grid height

            autoChangeGridView: { // autoChangeGridView by browser width
                mobile:[0,600], grid:[600]
            },

            //passiveMode:true,
			//passiveRemoveHide:false,

            colGroup : [
                {key:"NO", 		label:"NO", 	width:"40", 	align:"center",	sort: false,  formatter:function(){
                	//return (this.list.length - this.index) + ( ( this.page.pageNo - 1) * this.page.pageSize );		//역순
                	return ("<span>" + (this.index + 1) + "</span>");
                }},

                {key:"chk", 	label:"<input type='checkbox' name='allChkLeft' readonly='true' onclick='fnObj.allCheck(0);' />",  width:"30",	align:"center", sort: false,  formatter:function(){return ("<input type='checkbox' name='mCheckLeft' onclick='fnObj.clickCheckboxL(this, " + this.index + ");' " + ((this.value==1)?"checked":"") + " />");}},

                {key:"moduleId", 		label:"ID", 		width:"40",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"moduleCode",		label:"모듈코드", 		width:"100",	align:"center"},
                {key:"moduleName", 		label:"모듈명", 		width:"140",	align:"center"},
                {key:"moduleDesc", 		label:"설명", 		width:"140",	align:"center"},
                {key:"moduleIncUrl", 	label:"URL",		width:"200",	align:"left"}
            ],
            body : {
                onclick: function(){
                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                	//toast.push("<b>내용</b>:\n" + this.item.CONTENT);
                	//alert(JSON.stringify(this));
                	if(this.c == 2 || this.c == 3 || this.c == 4 ){		//메뉴보기
                		//fnObj.viewMenu(this.item.menuId);
                		//fnObj.viewMenu(this.list[this.index]);	//메뉴정보보기 (메뉴정보 객체전달)
                	}

                },

                ondblclick: function(){
                	//fnObj.viewArticle(this.list[this.index].BOARD_SEQ);
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
    			//toast.push("모달 close");

				//if(window[myModal.winID].isSaved == false){		//저장을 안한상태로 창이 닫힐때, 이미 업로드한 파일은 삭제
    			//	window[myModal.winID].fnObj.deleteFile();	//팝업창 내 파일삭제함수 호출.
    			//}
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
   						{label:"권 한", labelWidth:"", type:"selectBox", width:"150", key:"roleId", addClass:"secondItem", valueBoxStyle:"", value:"title",
   							//options:[{optionValue:"userName", optionText:"이름"}, {optionValue:"userSabun", optionText:"사번"}, {optionValue:"userId", optionText:"아이디"}],
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
   						{type : "button",  width:"40", value : "검색", addClass:"mgl10",
   	   						onClick: function(selectedObject, value){
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

            fixedColSeq : 4,	//컬럼고정 index
            fitToWidth : true,	//true,	//넓이에맞게
            colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"
            colHeadTool : false,	//컬럼 display 여부를 설정
            height: 570,		//grid height

            autoChangeGridView: { // autoChangeGridView by browser width
                mobile:[0,600], grid:[600]
            },

            //passiveMode:true,
			//passiveRemoveHide:false,

            colGroup : [
                {key:"NO", 		label:"NO", 	width:"30", 	align:"center",	sort: false,  formatter:function(){
                	//return (this.list.length - this.index) + ( ( this.page.pageNo - 1) * this.page.pageSize );		//역순
                	return ("<font color=silver><b>" + (this.index + 1) + "</b></font>");
                }},
                {key:"chk", 	label:"<input type='checkbox' name='allChkRight' readonly='true' onclick='fnObj.allCheck(1);' />",  width:"30",	align:"center", sort: false,  formatter:function(){return ("<input type='checkbox' name='mCheckRight' onclick='fnObj.clickCheckboxR(this, " + this.index + ");' " + ((this.value==1)?"checked":"") + " />");}},
                {key:"sort", 	label:"정렬", 	width:"40", 	align:"center",	sort: false,  formatter:function(){
                	//return (this.list.length - this.index) + ( ( this.page.pageNo - 1) * this.page.pageSize );		//역순
                	return ("<font color=darkblue><b>" + (this.index + 1) + "</b></font>");
                }},
                {key:"moduleId", 		label:"ID", 		width:"40",		align:"center",	formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"moduleCode",		label:"모듈코드", 	width:"100",	align:"center"},
                {key:"moduleName", 		label:"모듈명", 		width:"120",	align:"center"},

               /*  {key:"position", 		label:"배치유형",	width:"75",		align:"center",	formatter:function(val){
																			                	if(Object.isObject(this.value)){
																			                		return this.value.optionText;
																								}else{
																									return this.item.positionNm;
																								}
																			                },
																			                editor: {
																								type: "select",
																								optionValue: "optionValue",
																								optionText: "optionText",
																								options: comCodeModulePosType,	//json object
																								beforeUpdate: function(val){ // 수정이 되기전 value를 처리 할 수 있음.
																									// 선택된 값은
																									//console.log(val);
																									return val;		//필수!!
																								},
																								afterUpdate: function(val){ // 수정이 처리된 후
																									// 수정이 된 후 액션.
																									//console.log(this);
																								}
																							}
                }, */
                /* {key:"width", 			label:"폭", 			width:"60",		align:"center",		editor:{type: "number", updateWith: ["number","_CUD"]}},
                {key:"height", 			label:"높이", 		width:"60",		align:"center",		editor:{type: "number", updateWith: ["number","_CUD"]}}, */
               /*  {key:"leftPosX",		label:"좌측X위치", 	width:"65",		align:"center",		editor:{type: "number", updateWith: ["number","_CUD"]}},
                {key:"leftPosY",		label:"좌측Y위치", 	width:"65",		align:"center",		editor:{type: "number", updateWith: ["number","_CUD"]}}, */
                {key:"moduleIncUrl", 	label:"URL",		width:"200",	align:"left"},
                {key:"enable", 			label:"모듈사용",	width:"60",	align:"center",  formatter:function(){return (this.value == 'N' ? "<b>" + (this.value) + "</b>" : this.value);}},
                {key:"moduleOrgEnable", label:"관계사사용",	width:"80",	align:"center",  formatter:function(){return (this.value == 'N' ? "<b>" + (this.value) + "</b>" : this.value);}}
            ],
            body : {
                onclick: function(){
                },

                ondblclick: function(){

                },

                addClass: function(){
                	if(this.item.enable == 'N' || this.item.moduleOrgEnable == 'N') return "row_disable_class";		//"gray";

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

  	//검색(모듈리스트)
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	var pars = mySearch.getParam();
    	var params = mySearch.getParam().queryToObjectDec();

    	var url = contextRoot + "/system/getModuleListByOrg.do";

    	var param = {
    			targetOrgId : $("select[name=orgId]").val(),
    			search		: params.search
    	};/*

    	var url = contextRoot + "/system/getModuleListByOrg.do";

    	var param = {
    			targetOrgId : $("select[name=orgId]").val()
    	}; */


    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var cnt = obj.resultVal;	//결과수
    		var list = obj.resultList;	//결과데이터JSON

    		var gridData = {list:list,
    						page:{listCount:cnt}};

    		myGrid.clearSort();			//소팅초기화
    		myGrid.setData(gridData);	//그리드에결과반영
    	};

    	commonAjax("POST", url, param, callback);
    },//end doSearch


  	//검색(권한별 모듈리스트)
    doSearch2: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	var pars = mySearch2.getParam();

    	var url = contextRoot + "/system/getModulePerRole.do";
    	var param = mySearch2.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서
    	param.orgId = $("select[name=orgId]").val();

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var cnt = obj.resultVal;	//결과수
    		var list = obj.resultList;	//결과데이터JSON

    		var gridData = {list:list,
    						page:{listCount:cnt}};

    		myGrid2.clearSort();		//소팅초기화
    		myGrid2.setData(gridData);	//그리드에결과반영
    	};

    	commonAjax("POST", url, param, callback);
    },//end doSearch


    //툴팁 세팅
    setTooltip: function(){
    	var tooltipStr = '';
    	/*for(var i=1; i<roleCodeCombo.length; i++){
    		tooltipStr += roleCodeCombo[i].NM + " : " + roleCodeCombo[i].DESCRIPTION + "<br>";
    	}*/
    	tooltipStr += "<strong><font color=#3456c2>[등록방법]</font><br>1. 수정한 모듈구조를 적용하시려면 재로그인 하시기 바립니다.<br><br><font color=#3456c2>**주의사항**</font><br>1. 사용여부가 'N' 인 메뉴들로 인해 구조가 깨지지않도록 주의</strong>";

  		AXPopOver.bind({
  	        id:"myPopOver",
  	        theme:"AXPopOverTooltip", 	// 선택항목
  	        width:"200", 				// 선택항목
  	        body:tooltipStr				//"설명입니다.<br/>액시스제이는 이렇게 유용 합니다."
  	    });
  		$("#ttipUserRole").bind("mouseover", function(event){
  	        AXPopOver.open({id:"myPopOver", sendObj:{}}, event); // event 직접 연결 방식
  	    });
  	},


  	//저장(메뉴구조)
    doSave: function(){

    	//--------------- validation :S ---------------

    	//------ 부모아이디, 루트아이디, 정렬값 구해서 세팅
    	var list = myGrid2.getList();					//그리드 데이터 리스트

    	var pArray = [];		//저장을 위해 새로운 배열객체를 만든다.
    	var rObj;				//row object
    	var cntLvl0 = 0;
    	var cntLvl1 = 0;
    	var cntLvl2 = 0;

    	for(var i=0; i<list.length; i++){
    		rObj = new Object();	//row object

    		rObj.moduleId = list[i].moduleId.toString();	//모듈아이디 key,value 추가
    		//rObj.depth  = list[i].depth.toString();			//레벨 key,value 추가
    		if(Object.isObject(list[i].position))
    			rObj.position = list[i].position.optionValue.toString();	//모듈배치타입 key,value 추가
    		else
    			rObj.position = list[i].position.toString();				//모듈배치타입 key,value 추가

    		switch(0){			//list[i].depth * 1){		//해당 레벨의 값을 1증가, 하위는 0 초기화... (cntLvl0 * 100 + cntLvl1 * 10 + cntLvl2) 가 sort(정렬)값이 된다.
    			case 0: cntLvl0 ++;
    					cntLvl1 = 0;
    					cntLvl2 = 0;
    					break;
    			case 1: cntLvl1 ++;
						cntLvl2 = 0;
						break;
    			case 2: cntLvl2 ++;
    					break;
    		}
    		rObj.sort = (cntLvl0 * 100 + cntLvl1 * 10 + cntLvl2).toString();					// sort 값 세팅

    		//rObj.width = list[i].width;					//폭 key,value 추가
    		//rObj.height = list[i].height;				//높이 key,value 추가
    		rObj.leftPosX = list[i].leftPosX;			//좌측X위치 key,value 추가
    		rObj.leftPosY = list[i].leftPosY;			//좌측Y위치 key,value 추가


    		//(typeof rObj.width == null)
    		//모듈 사이즈(폭, 높이)정보 입력체크
    		/* if(isEmpty(rObj.width) || isEmpty(rObj.height)){
    			alertM("모듈 사이즈(폭, 높이) 정보가 입력되지 않았습니다 !");
        		return;
    		} */
    		//좌표배치이면서 좌표값이 없으면 중단
    		if(rObj.position == 'ABSOLUTE'  && (isEmpty(rObj.leftPosX) || isEmpty(rObj.leftPosY))){
    			alertM("좌표배치 를 위한 좌표값(좌측X위치, 좌측Y위치) 정보가 입력되지 않았습니다!");
        		return;
    		}

    		//// 객체 추가
    		pArray.push(rObj);
    	}

    	//alert(JSON.stringify(pArray));
    	//return;

    	//--------------- validation :E ---------------


    	//저장
    	var sObj = mySearch2.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서

    	var url = contextRoot + "/system/doSaveModulePerRole.do";
    	var param = {
    			pList: JSON.stringify(pArray),			//그리드 데이터 (JSON 문자열)
    			roleId: sObj.roleId,					//권한코드
    			orgId : $("select[name=orgId]").val()	//sObj.orgId
    	};
    	/* alert(JSON.stringify(param));
    	return;
    	console.log(param); */
    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){

    			//parent.fnObj.doSearch(parent.curPageNo);	//목록화면 재조회 호출.
    			//parent.myModal.close();						//글쓰기 창 닫기.
    			//parent.dialog.push("등록OK!");
    			parent.toast.push("저장OK!");
    		}else{
    			//alertMsg();
    		}

    	};

    	commonAjax("POST", url, param, callback);


    },//end doSave


    //권한별모듈복사
    copyRole: function(){

    	var list = myGrid.getList();
    	if(list == null || list.length < 1){
    		alertM("'관계사별 모듈권한' 메뉴에서 먼저 모듈을 등록해주세요.");
    		return;
    	}
    	var url = "<c:url value='/system/copyRoleModule.do'/>";
    	//var params = {};	//{mode:'new'};	//"btype=1&cate=1".queryToObject();		//게시판유형(board_type), 게시판 카테고리 를 넘긴다.
    	var params = mySearch.getParam().queryToObjectDec();
    	myModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '권한별 모듈 복사',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: 200,
    		width: 450,
    		closeByEscKey: true				//esc 키로 닫기
    	});

    	$('#myModalCT').draggable();
    },


    //배열에 새로운 인자로 추가 (공통코드 이상문제해결)
    addComCodeArray: function(obj){
		for(var i=0; i<obj.length; i++){
			obj[i].optionValue = obj[i].CD;		//'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
			obj[i].optionText  = obj[i].NM;		//'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
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


    //오른쪽으로 이동 (모듈리스트 >> 권한별모듈등록)
    moveRight: function(){
    	var leftList = myGrid.getList();								//왼쪽   그리드 데이터
    	var rightList= myGrid2.getList();								//오른쪽 그리드 데이터

    	var chkCnt = 0;			//이동을 위해 체크한 수
    	var chkIndex = -1;		//체크한 row index
    	var moveObj;			//체크해서 이동할 row Object
    	for(var i=0; i<leftList.length; i++){
    		if(leftList[i].chk == 1){	//체크되어 있는 것을
    			chkCnt++;
    			moveObj = leftList[i];									//이동할 row data
    			//leftList.splice(i, 1);								//체크 요소를 삭제

    			//추가(key,value)
    			moveObj.position = 'RELATIVE';		//자동배치
    			moveObj.positionNm = '자동배치';		//자동배치
    			moveObj.sort = 100;					//임의값세팅(저장시에 재세팅된다)
    			moveObj.width= null;				//폭
    			moveObj.height= null;				//높이
    			moveObj.leftPosX= null;				//좌측X위치
    			moveObj.leftPosY= null;				//좌측Y위치


    			if(getRowIndexWithValue(rightList, 'moduleId', leftList[i].moduleId) == -1){	//이미 추가한 것은 제외하고
	    			myGrid2.pushList(moveObj);								//오른쪽 그리드에 추가
    			}
    		}
    	}

    	if(chkCnt == 0){
    		alertM("이동할 메뉴를 먼저 선택해주세요!");
    		return;
    	}

    	//그리드 싱크 ....pushList 는 싱크도 되는듯
    	//myGrid.dataSync();
    	//myGrid2.dataSync();

    },

  	//왼쪽으로 이동 (모듈리스트 << 권한별모듈등록) ... 실제는 삭제로 구현
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

    /*
    //레벨변경
    chngLevel: function(){

    	//변경할 레벨값확인
    	var rdLevel = document.getElementsByName('rdLevel');
    	var toLevel = -1;
    	for(var i=0; i<rdLevel.length; i++){
    		if(rdLevel[i].checked) toLevel = rdLevel[i].value;
    	}
    	if(toLevel == -1){
    		alert("변경하실 레벨을 선택해주세요!");
    		return;
    	}


    	//레벨변경
    	var list = myGrid2.getList();		//권한별모듈리스트
    	var chkList = document.getElementsByName('mCheckRight');
    	var zIdx = chkList.length/2;		//** AxisJ 의 고정컬럼 그리드에서는 고정컬럼으로 표현되는 부분은 2중으로 겹치게 표현하는것 같다... 따라서 체크박스가 2배수로 생겼다.
    	for(var i=zIdx; i<chkList.length; i++){
    		if(chkList[i].checked){
    			list[i-zIdx].depth = toLevel;		//레벨 변경(선택한 레벨로)
    		}

    	}

    	//myGrid2.redrawGrid();	//변경한(DB미적용) 데이터로 화면에서 보이도록(redraw)
    	myGrid2.dataSync();	//변경한(DB미적용) 데이터로 화면에서 보이도록

    	//this.dataSyncCheckboxR();	//'chk' 컬럼 값으로 체크박스 체크상태 싱크

    },
    */


  	//체크박스 체크 validation (위,아래 이동)
	checkChkValidUpDown: function(){
		var chkList = document.getElementsByName('mCheckRight');
    	var chkCnt = 0;
    	var chkIndex = -1;
    	for(var i=chkList.length/2; i<chkList.length; i++){
    		if(chkList[i].checked){
    			chkCnt++;
    			chkIndex = i-chkList.length/2;
    		}
    	}

    	if(chkCnt==0){
    		alertM("이동할 메뉴를 먼저 선택해주세요!");
    		//dialog.push({body:"<b>확인!</b> ", type:"", onConfirm:function(){}});
    		return -1;
    	}else if(chkCnt>1){
    		alertM("이동할 메뉴는 한번에 1개만 선택해주세요!");
    		//dialog.push({body:"<b>확인!</b> ", type:"", onConfirm:function(){}});
    		return -1;
    	}else{
    		return chkIndex;
    	}
    },

    //메뉴위치 위로
    moveUp: function(){
    	//체크박스 체크 validation
    	var chkIndex = this.checkChkValidUpDown();
    	if(chkIndex == -1){		//false(체크된것이 없거나, 2개이상)
    		return;				//끝낸다.
    	}

    	/////////////////// 이동 ///////////////////
    	var list = myGrid2.getList();
    	if(chkIndex == 0){						//이미 처음 index
    		return;
    	}

    	var chkObj = list[chkIndex];			//이동할 배열객체를 담고
    	list.splice(chkIndex, 1);				//chkIndex 요소를 원본에서 삭제

    	var toIndex = chkIndex - 1;				//위로 1칸

    	myGrid2.setData({list:addToArray(list, toIndex, chkObj)});	//이동할 위치로 이동후 그리드에 세팅.
    	myGrid2.dataSync();						//그리드 data sync (화면)

    },

  	//메뉴위치 아래로
    moveDown: function(){
    	//체크박스 체크 validation
    	var chkIndex = this.checkChkValidUpDown();
    	if(chkIndex == -1){		//false(체크된것이 없거나, 2개이상)
    		return;				//끝낸다.
    	}

    	/////////////////// 이동 ///////////////////
    	var list = myGrid2.getList();
    	if(chkIndex == (list.length-1)){		//이미 마지막 index
    		return;
    	}


    	var chkObj = list[chkIndex];			//이동할 배열객체를 담고
    	list.splice(chkIndex, 1);				//chkIndex 요소를 원본에서 삭제

    	var toIndex = chkIndex + 1;				//아래로 1칸

    	myGrid2.setData({list:addToArray(list, toIndex, chkObj)});	//이동할 위치로 이동
    	myGrid2.dataSync();						//그리드 data sync (화면)

    },

    /*
    //다음이동할 index 구하기
    getIndexToGo: function (upDown, chkIndex, chkObj){		//upDown : 'UP'(위로), 'DOWN'(아래로)
    	var list = myGrid2.getList();	//그리드 data list

    	var level = chkObj.depth;		//이동할 메뉴 레벨
    	if(upDown == 'UP'){				//위로 이동
    		if(level == 0){
    			for(var i=chkIndex-1; i >= 0; i--){
        			if(list[i].depth == 0 || i==0) return i;
        		}
    		}else if(level == 1){
    			for(var i=chkIndex-1; i >= 0; i--){
        			if(list[i].depth == 0 || i==0) return i;
        		}
    		}else if(level == 2){
    			for(var i=chkIndex-1; i >= 0; i--){
        			if(list[i].depth == 0 || i==0) return i;
        		}
    		}

    	}else{	//upDown == 'DOWN'
    		if(level == 0){
    			for(var i=chkIndex-1; i >= 0; i--){
        			if(list[i].depth == 0 || i==0) return i;
        		}
    		}else if(level == 1){
    			for(var i=chkIndex-1; i >= 0; i--){
        			if(list[i].depth == 0 || i==0) return i;
        		}
    		}else if(level == 2){
    			for(var i=chkIndex-1; i >= 0; i--){
        			if(list[i].depth == 0 || i==0) return i;
        		}
    		}
    	}


    },
    */


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
    		var chkList = document.getElementsByName('mCheckLeft');
    		var list = myGrid.getList();
    		var addIdx = chkList.length/2;
    		var toBe = document.getElementsByName('allChkLeft')[1].checked;
    		for(var i=chkList.length/2; i<chkList.length; i++){
        		chkList[i].checked = toBe;		//체크여부
        		list[i-addIdx].chk = toBe?1:0;	//그리드데이터도 함께 변환(아직 그리드 데이터는 변하지 않은 상태이기때문에)
        	}

    	}else{	// knd == 1 오른쪽
    		var chkList = document.getElementsByName('mCheckRight');
    		var list = myGrid2.getList();
    		var addIdx = chkList.length/2;
    		var toBe = document.getElementsByName('allChkRight')[1].checked;
    		for(var i=chkList.length/2; i<chkList.length; i++){
        		chkList[i].checked = toBe;		//체크여부
        		list[i-addIdx].chk = toBe?1:0;	//그리드데이터도 함께 변환(아직 그리드 데이터는 변하지 않은 상태이기때문에)
        	}

    	}
    },

    /*
  	//'chk' 컬럼 값으로 체크박스 체크상태 싱크
    dataSyncCheckboxL: function(){
    	var chkList = document.getElementsByName('mCheckLeft');
    	var addIdx = chkList.length/2;
    	var list = myGrid.getList();

    	for(var i=0; i<list.length; i++){
    		if(list[i].chk == 1){
    			chkList[i+addIdx].checked = true;
    		}else{	//chk == 0
    			chkList[i+addIdx].checked = false;
    		}
    	}
    },

  	//'chk' 컬럼 값으로 체크박스 체크상태 싱크
    dataSyncCheckboxR: function(){
    	var chkList = document.getElementsByName('mCheckRight');
    	var addIdx = chkList.length/2;
    	var list = myGrid2.getList();

    	for(var i=0; i<list.length; i++){
    		if(list[i].chk == 1){
    			chkList[i+addIdx].checked = true;
    			//alert(1);
    		}else{	//chk == 0
    			chkList[i+addIdx].checked = false;
    			//alert(list[i].chk);
    		}
    	}
    }
    */



  	//################# else function :E #################



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();		//검색(모듈리스트)
	fnObj.doSearch2();		//검색(권한별모듈)
	fnObj.setTooltip();
	//검색버튼 동작
	$(".searchButtonItem").on("click", function(){
		fnObj.doSearch();
	});
});
</script>