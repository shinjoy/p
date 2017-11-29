<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<section id="detail_contents">
	<h3 class="h3_title_basic mgb10">코드 SET</h3>
	<div class="sys_search_box">
		<div id="AXSearchTarget" class="fl_block"></div>
		<!-- <div class="fr_block">
			<button name="reg_btn" class="btn_b2_skyblue" onclick="fnObj.excelDownload();"><em class="icon_XLS">파일로 저장</em></button>
		</div> -->
	</div>
	<div class="sys_p_noti mgt20 mgb10"><span class="icon_noti"></span><span class="pointB">신규등록</span><span>은 입력폼에 입력하여 저장을 합니다.</span><span class="pointred"> (수정을 하시려면 해당 ROW를 클릭하여 수정 후 저장하시기 바랍니다.)</span></div>
	<div id="AXGridTarget"></div>

	<h3 class="sys_grid_title">[ 코드SET - <span id="displayCodeNm" class="pointsetcolor"></span><span id="displayMode">신규등록</span> ]</h3>
	<table class="datagrid_input" summary="코드SET 입력 (코드SET, 코드SET명, 코드SET영문, 코드타입, 설명, 초기화)">
		<caption>프로젝트목록</caption>
		<colgroup>
			<col width="140"> <!--구분-->
			<col width="15%" span="3"> <!--구분-->
			<col width="100"> <!--코드타입-->
			<col width="*"> <!--설명-->
			<col width="80"> <!--삭제여부-->
			<col width="80"> <!--초기화-->
		</colgroup>
		<thead>
			<tr>
				<th scope="col">구분</th>
				<th scope="col">코드SET</th>
				<th scope="col">코드SET명</th>
				<th scope="col">코드SET영문</th>
				<th scope="col">코드타입</th>
				<th scope="col">설명</th>
				<th scope="col">삭제여부</th>
				<th scope="col">초기화</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th class="bg_gary"><strong>코드</strong></th>
				<td>
					<input id="inputCodeSetNameBefore" type="text" name="inputCodeSetNameBefore" placeholder="기존코드셋명" value="" class="sy_input_b w100" readonly="readonly" style="display:none;" />
					<input id="inputCodeSetId" type="text" name="codeSetId" placeholder="신규" value="" class="sy_input_b w100" readonly="readonly" style="display:none;" />
					<input id="inputCodeSetName" type="text" name="codeSetName" placeholder="코드SET" value="" class="sy_input_b w100" />
				</td>
				<td><input id="inputMeaningKor" type="text" name="meaningKor" placeholder="코드SET명" value="" class="sy_input_b w100" /></td>
				<td><input id="inputMeaningEng" type="text" name="meaningEng" placeholder="코드SET영문" value="" class="sy_input_b w100" /></td>
				<td class="txt_center"><span id="codeTypeSelectTag"></span></td>
				<td><input id="inputDesc" type="text" name="description" placeholder="설명" value="" class="sy_input_b w100" /></td>
				<td class="txt_center"><span id="deleteFlagSelectTag"></span></td>
				<td class="txt_center"><button type="button" class="btn_s_replay" onclick="fnObj.resetCodeSet();"><em>신규추가</em></button></td>
			</tr>
			<tr>
				<th class="bg_gary"><strong>부모코드</strong><button type="button" class="btn_s_type2 mgl10" onclick="fnObj.openParentIdPop();"><em class="icon_search">검색</em></button></th>
				<td>
					<input id="inputParentSetId" type="text" name="parentSetId" placeholder="부모아이디" value="" class="sy_input_b w100" readonly="readonly" style="display:none;" />
					<input id="inputParentSetName" type="text" name="parentSetName" placeholder="부모코드SET" value="" class="sy_input_b w100" readonly="readonly"/>
				</td>
				<td><input id="inputParentMeaningKor" type="text" name="parentMeaningKor" placeholder="부모코드SET명" value="" class="sy_input_b w100" readonly="readonly"/></td>
				<td><input id="inputParentMeaningEng" type="text" name="parentMeaningEng" placeholder="부모코드SET영문" value="" class="sy_input_b w100" readonly="readonly"/></td>
				<td></td>
				<td></td>
				<td></td>
				<td class="txt_center"><button type="button" class="btn_s_replay" onclick="fnObj.doRefreshCodeSet();"><em>부모코드초기화</em></button></td>
			</tr>
		</tbody>
	</table>
	<div class="btn_baordZone2">
        <a href="javascript:fnObj.doSaveCodeSet();" class="btn_blueblack btn_auth"><span id="editBtnName">저장</span></a>
        <!-- <a href="javascript:fnObj.tryDel();" id="deleteBtn" class="btn_witheline">삭제</a> -->
    </div>

	<h3 class="h3_title_basic mgb10">코드 LIST <span class="sp_sys_subtitle mgl10"><span id="codeSetInfoTag"></span></span></h3>
	<div id="AXGridTarget2"></div>
	<h3 class="sys_grid_title">[ 코드LIST - <span id="displayCodeNmList" class="pointlistcolor"></span><span id="displayModeList">신규등록</span> ]</h3>
	<table class="datagrid_input" summary="코드SET 입력 (코드SET, 코드SET명, 코드SET영문, 코드타입, 설명, 초기화)">
		<caption>프로젝트목록</caption>
		<colgroup>
			<col width="140"> <!--구분-->
			<col width="80"> <!--구분-->
			<col width="10%"> <!--구분-->
			<col width="15%" span="2"> <!--구분-->
			<col width="100"> <!--코드타입-->
			<col width="*"> <!--설명-->
			<col width="80"> <!--삭제여부-->
			<col width="80"> <!--초기화-->
		</colgroup>
		<thead>
			<tr>
				<th scope="col">구분</th>
				<th scope="col" colspan="2">코드값</th>
				<th scope="col">한글명</th>
				<th scope="col">코드SET영문</th>
				<th scope="col">정렬값</th>
				<th scope="col">설명</th>
				<th scope="col">삭제여부</th>
				<th scope="col">초기화</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th class="bg_gary"><strong>코드</strong></th>
				<td>
					<input id="inputValueBefore" type="text" name="inputValueBefore" placeholder="코드영문코드" value="" class="sy_input_b w100" readonly="readonly" style="display:none;"/>
					<input id="inputCodeListId" type="text" name="codeListId" placeholder="신규" value="" class="sy_input_b w100" readonly="readonly" />
				</td>
				<td><input id="inputValue" type="text" name="value" placeholder="코드값" value="" class="sy_input_b w100" /></td>
				<td><input id="inputMeaningKor2" type="text" name="meaningKor2" placeholder="한글명" value="" class="sy_input_b w100" /></td>
				<td><input id="inputMeaningEng2" type="text" name="meaningEng2" placeholder="영문명" value="" class="sy_input_b w100" /></td>
				<td class="txt_center"><input id="inputSort" type="number" name="sort" placeholder="정렬값" value="" class="sy_input_b w100" /></td>
				<td><input id="inputDesc2" type="text" name="description2" placeholder="설명" value="" class="sy_input_b w100" /></td>
				<td class="txt_center"><span id="deleteFlagSelectTag2"></span></td>
				<td class="txt_center"><button type="button" class="btn_s_replay" onclick="fnObj.resetCodeList();"><em>신규추가</em></button></td>
			</tr>
			<tr>
				<th class="bg_gary"><strong>자식코드</strong><button type="button" class="btn_s_type2 mgl10" onclick="fnObj.openParentIdPop('list');"><em class="icon_search">검색</em></button></th>
				<td colspan="2">
					<input id="inputSonSetId" type="text" name="sonSetId" placeholder="자식아이디" value="" class="sy_input_b w100" readonly="readonly" style="display:none;" />
					<input id="inputSonSetName" type="text" name="sonSetName" placeholder="자식코드SET" value="" class="sy_input_b w100" readonly="readonly"/>
				</td>
				<td><input id="inputSonMeaningKor" type="text" name="sonMeaningKor" placeholder="자식코드SET명" value="" class="sy_input_b w100" readonly="readonly"/></td>
				<td><input id="inputSonMeaningEng" type="text" name="sonMeaningEng" placeholder="자식코드SET영문" value="" class="sy_input_b w100" readonly="readonly"/></td>
				<td></td>
				<td></td>
				<td></td>
				<td class="txt_center">
					<button type="button" class="btn_s_replay" onclick="fnObj.doRefreshSonset();"><em>자식코드 초기화</em></button>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="btn_baordZone2">
        <a href="javascript:fnObj.doSaveCodeList();" class="btn_blueblack btn_auth"><span id="editBtnName">저장</span></a>
        <!-- <a href="javascript:fnObj.tryDel();" id="deleteBtn" class="btn_witheline">삭제</a> -->
    </div>
</section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드

var g_CODE_GROUP = 'SYSTEM'		//시스템코드(삭제불가 코드)
var g_orgId = "${baseUserLoginInfo.orgId}";		//관계사 코드

var comCodeCodeType;			//코드타입
var comCodeCodeGroup;			//코드그룹

var mySearch = new AXSearch(); 	// instance
var myGrid = new AXGrid(); 		// instance
var myGrid2 = new AXGrid(); 	// instance

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
		comCodeCodeType = getBaseCommonCode('CODE_TYPE', lang, 'CD', 'NM', null, '','', {orgId :g_orgId } );
		//코드타입 공통코드 (Sync ajax)
		//comCodeCodeGroup = getBaseCommonCode('CODE_GROUP', lang, 'CD', 'NM', '', '선택', 'ALL', {orgId :g_orgId } );
		//코드그룹 공통코드 (Sync ajax) => 그룹은 무조건 'SYSTEM'이므로

		//'optionValue','optionText' 프로퍼티를 생성하며 값으로 CD, NM 의 값 할당
		//this.addComCodeArray(comCodeCodeType);
		//this.addComCodeArray(comCodeCodeGroup);

		var colorObj = {};	//{'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
		var codeTypeSelectTag = createSelectTag('selCodeType', comCodeCodeType, 'CD', 'NM', null, '', colorObj, 70);	//select tag creator 함수 호출 (common.js)
		$("#codeTypeSelectTag").html(codeTypeSelectTag);
		/* var codeGroupSelectTag = createSelectTag('selCodeGroup', comCodeCodeGroup, 'CD', 'NM', null, '', colorObj, 70);	//select tag creator 함수 호출 (common.js)
		$("#codeGroupSelectTag").html(codeGroupSelectTag); */
		var deleteFlagSelectTag = createSelectTag('selDeleteFlag', [{CD:'N',NM:'N'},{CD:'Y',NM:'Y'}], 'CD', 'NM', 'N', '', colorObj, 50);	//select tag creator 함수 호출 (common.js)
		$("#deleteFlagSelectTag").html(deleteFlagSelectTag);
		var deleteFlagSelectTag2 = createSelectTag('selDeleteFlag2', [{CD:'N',NM:'N'},{CD:'Y',NM:'Y'}], 'CD', 'NM', 'N', '', colorObj, 50);	//select tag creator 함수 호출 (common.js)
		$("#deleteFlagSelectTag2").html(deleteFlagSelectTag2);
	},


	//화면세팅
    pageStart: function(){

    	//-------------------------- 시스템 코드그룹 으로 기본 세팅 :S ----
    	$('#selCodeGroup').val(g_CODE_GROUP);
    	//-------------------------- 시스템 코드그룹 으로 기본 세팅 :E ----


    	//-------------------------- 콤포넌트 세팅 :S -------------------
    	$("#inputSort").bindNumber({min:0, max:1000});

    	//-------------------------- 콤포넌트 세팅 :E -------------------

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
   						/*{label:"검 색", labelWidth:"100", type:"selectBox", width:"", key:"knd", addClass:"", valueBoxStyle:"", value:"title",
   							options:[{optionValue:"userName", optionText:"이름"}, {optionValue:"userSabun", optionText:"사번"}, {optionValue:"userId", optionText:"아이디"}],
   							AXBind:{
   								type:"select", config:{
   									onChange:function(){
   										//toast.push(Object.toJSON(this));

   									}
   								}
   							}
   						},*/
   						{label:"검색", type:"inputText", width:"200", key:"search", placeholder:"검색어입력", addClass:"secondItem", value:"",
   							onChange: function(changedValue){
   								//아래 2개의 값을 사용 하실 수 있습니다.
   								dialog.push(Object.toJSON(this));
   								dialog.push(changedValue);
   							}
   						},
   						{type : "button",  width:"40", valueBoxStyle:"padding-left:2px;", value : "검색", addClass:"mgl10",
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
    	myGrid.setConfig({		//코드SET 그리드
            targetID : "AXGridTarget",
            theme : "AXGrid",

            fixedColSeq : 4,	//컬럼고정 index
            fitToWidth : true,	//true,	//넓이에맞게
            colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"

            height: 240,		//grid height
            //width: '95%',

            autoChangeGridView: { // autoChangeGridView by browser width
                mobile:[0,600], grid:[600]
            },

            //passiveMode:true,
			//passiveRemoveHide:false,

            colGroup : [
                /* {key:"NO", 		label:"NO", 	width:"40", 	align:"center",	sort: false,  formatter:function(){
                	//return (this.list.length - this.index) + ( ( this.page.pageNo - 1) * this.page.pageSize );		//역순
                	return ("<font color=silver><b>" + (this.index + 1) + "</b></font>");
                }}, */

                //{key:"codeSetId",		label:"아이디", 			width:"50",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"codeSetName", 	label:"코드SET", 		width:"140",	align:"left",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"meaningKor",		label:"코드SET명", 		width:"140",	align:"left",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"meaningEng",		label:"코드SET영문", 	width:"140",	align:"left"},
                {key:"codeTypeNm",		label:"코드타입", 		width:"80",		align:"center"},
                {key:"codeGroupNm",		label:"코드그룹", 		width:"80",		align:"center"},
                {key:"description",		label:"설명", 			width:"150",	align:"left"},

              	//{key:"parentSetId", 	label:"부모아이디", 		width:"75",		align:"center"},
                {key:"parentSetName", 	label:"부모코드SET", 	width:"140",	align:"left"},
                {key:"parentMeaningKor",label:"부모코드SET명", 	width:"140",	align:"center"},
                {key:"parentMeaningEng",label:"부모코드SET영문", 	width:"140",	align:"center"},

                {key:"createDate", 		label:"등록일", 			width:"85",		align:"center"},
                {key:"createNm", 		label:"등록자", 			width:"60",		align:"center"},
                {key:"updateDate", 		label:"수정일", 			width:"85",		align:"center"},
                {key:"updateNm", 		label:"수정자", 			width:"60",		align:"center"},
                {key:"deleteFlag", 		label:"삭제여부", 		width:"63",		align:"center"},
                {key:"deleteDate", 		label:"삭제일", 			width:"85",		align:"center"},
                {key:"deleteNm", 		label:"삭제자", 			width:"60",		align:"center"}
            ],
            body : {
                onclick: function(){
                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                	//toast.push("<b>내용</b>:\n" + this.item.CONTENT);
                	//alert(JSON.stringify(this));
                	//if(this.c == 1 || this.c == 2 || this.c == 3 ){		//코드SET보기
                		//fnObj.viewMenu(this.item.menuId);
                		fnObj.selectRowCodeSet(this.list[this.index]);	//코드SET 정보보기 (코드SET정보 객체전달)
                	//}

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


        //------ 하단 그리드
    	myGrid2.setConfig({		//코드LIST 그리드
            targetID : "AXGridTarget2",
            theme : "AXGrid",

            fixedColSeq : 5,	//컬럼고정 index
            fitToWidth : true,	//true,	//넓이에맞게
            colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"

            height: 270,		//grid height
            //width: '95%',

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

                //{key:"codeListId",		label:"아이디", 			width:"50",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"codeSetNameId",	label:"코드SET", 			width:"110",	align:"left",  	formatter:function(){return ("<b>" + (this.item.codeSetName) + "</b>");}},		// " (" + (this.item.codeSetId) + ")</b>");}},
                {key:"value",			label:"코드값", 			width:"110",	align:"left",	formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"meaningKor",		label:"한글명", 			width:"140",	align:"left",	formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"meaningEng",		label:"영문명", 			width:"140",	align:"left",	formatter:function(){return ("<b>" + ((this.value==undefined)?'':this.value) + "</b>");}},
                {key:"sort",			label:"정렬값", 			width:"70",		align:"center",	formatter:function(){return ("<b><font color=#ff7777>" + this.value + "</font></b>")}},
                {key:"description",		label:"설명", 			width:"150",	align:"left"},

                {key:"sonSetName", 		label:"자식코드SET", 		width:"140",	align:"left"},
                {key:"sonMeaningKor",	label:"자식코드SET명", 		width:"120",	align:"center"},
                {key:"sonMeaningEng",	label:"자식코드SET영문", 	width:"140",	align:"center"},

                {key:"createDate", 		label:"등록일", 			width:"85",		align:"center"},
                {key:"createNm", 		label:"등록자", 			width:"60",		align:"center"},
                {key:"updateDate", 		label:"수정일", 			width:"85",		align:"center"},
                {key:"updateNm", 		label:"수정자", 			width:"60",		align:"center"},
                {key:"deleteFlag", 		label:"삭제여부", 			width:"63",		align:"center"},
                {key:"deleteDate", 		label:"삭제일", 			width:"85",		align:"center"},
                {key:"deleteNm", 		label:"삭제자", 			width:"60",		align:"center"}
            ],
            body : {
                onclick: function(){
                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                	//toast.push("<b>내용</b>:\n" + this.item.CONTENT);
                	//alert(JSON.stringify(this));
                	//if(this.c == 1 || this.c == 2 || this.c == 3 ){		//코드SET보기
                		//fnObj.viewMenu(this.item.menuId);
                		fnObj.selectRowCodeList(this.list[this.index]);	//코드SET 정보보기 (코드SET정보 객체전달)
                	//}

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
    		width:1200,
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

    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색(코드SET)
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	var pars = mySearch.getParam();

    	var url = contextRoot + "/system/getCodeSet.do";
    	var param = mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서
    	param.codeGroup = g_CODE_GROUP;		//시스템코드 조회
    	param.targetOrgId = g_orgId;		//관계사 정보.

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


  	//검색(코드LIST)
    doSearch2: function(setId){

       	var url = contextRoot + "/system/getCodeList.do";
    	var param = {codeSetId:setId};	//mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서

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
    },//end doSearch2


    //툴팁 세팅
    //setTooltip: function(){
    	//var tooltipStr = '';
    	/*for(var i=1; i<comCodeRoleCd.length; i++){
    		tooltipStr += comCodeRoleCd[i].NM + " : " + comCodeRoleCd[i].DESCRIPTION + "<br>";
    	}*/
    	//tooltipStr += "<strong><font color=#3456c2>신규등록은 입력폼에 입력하여 저장을 합니다.</font><br><br>수정을 하시려면 해당 ROW 를 클릭하여 수정후 저장하시기 바랍니다.</strong>";

  		/*AXPopOver.bind({
  	        id:"myPopOver",
  	        theme:"AXPopOverTooltip", 	// 선택항목
  	        width:"200", 				// 선택항목
  	        body:tooltipStr				//"설명입니다.<br/>액시스제이는 이렇게 유용 합니다."
  	    });
  		$("#ttipUserRole").bind("mouseover", function(event){
  	        AXPopOver.open({id:"myPopOver", sendObj:{}}, event); // event 직접 연결 방식
  	    });
  	},*/

  	//부모코드SET 버튼 클릭
    openParentIdPop: function(openType){
    	var url = "<c:url value='/system/searchCodeSetPop.do'/>";
    	var params = {openType : openType};		// type : set 에서 open OR list open ( 자식 코드 셋때문에 추가 구분 값, default:list )
    	params.codeGroup = g_CODE_GROUP;		//SYSTEM 코드
    	params.orgId = g_orgId;					//관계사 아이디

    	myModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '코드SET검색',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: $(window).scrollTop() + 150,		//screenY
    		width: 1020,
    		closeByEscKey: true				//esc 키로 닫기
    	});

    	$('#myModalCT').draggable();
    },//end writeOpen


  	//코드SET 선택
    selectRowCodeSet: function(codeSetInfoObj){

    	//코드SET 모드 상태 표시
    	$('#displayCodeNm').html(codeSetInfoObj.codeSetName);
    	$('#displayMode').html(' 수정');


    	//전체 ORGID 처리를 위한 코드셋 이름 저장.
    	$('#inputCodeSetNameBefore').val(codeSetInfoObj.codeSetName);
    	$('#inputCodeSetId').val(codeSetInfoObj.codeSetId);			//아이디
    	$('#inputCodeSetName').val(codeSetInfoObj.codeSetName);		//코드SET
    	$('#inputMeaningKor').val(codeSetInfoObj.meaningKor);		//코드SET명
    	$('#inputMeaningEng').val(codeSetInfoObj.meaningEng);		//코드SET영문
    	$('#selCodeType').val(codeSetInfoObj.codeType);				//코드타입
    	$('#selCodeGroup').val(codeSetInfoObj.codeGroup);			//코드그룹
    	$('#inputDesc').val(codeSetInfoObj.description);			//설명
    	$('#selDeleteFlag').val(codeSetInfoObj.deleteFlag);			//삭제여부

    	//부모코드SET
    	$('#inputParentSetId').val(codeSetInfoObj.parentSetId);
    	$('#inputParentSetName').val(codeSetInfoObj.parentSetName);
    	$('#inputParentMeaningKor').val(codeSetInfoObj.parentMeaningKor);
    	$('#inputParentMeaningEng').val(codeSetInfoObj.parentMeaningEng);


    	//코드LIST 그리드 위에 어느 코드SET의 코드LIST정보인지 보여주는 태그
    	var codeSetInfoTag = "( <strong>" + codeSetInfoObj.codeSetName + "</strong> 의 코드값 )";
    	$('#codeSetInfoTag').html(codeSetInfoTag);

    	$('#inputCodeSetName').attr("readonly",true);

    	//하위 코드 LIST 목록 로딩
    	this.doSearch2(codeSetInfoObj.codeSetId);
    	//하위 코드 LIST 입력 창 초기화
    	this.resetCodeList("REFRESH");

    },//end selectRowCodeSet


  	//코드SET RESET
    resetCodeSet: function(){

    	//코드SET 상태표시 초기화
    	$('#displayCodeNm').html('');
    	$('#displayMode').html('신규등록');


    	$('#inputCodeSetNameBefore').val('');	//기존 코드셋 명
    	$('#inputCodeSetId').val('');			//아이디
    	$('#inputCodeSetName').val('');			//코드SET
    	$('#inputMeaningKor').val('');			//코드SET명
    	$('#inputMeaningEng').val('');			//코드SET영문
    	$('#selCodeType').val('LOOKUP');		//코드타입
    	$('#selCodeGroup').val('');				//코드그룹
    	$('#inputDesc').val('');				//설명
    	$('#selDeleteFlag').val('N');			//삭제여부

    	//부모코드SET
    	$('#inputParentSetId').val('');
    	$('#inputParentSetName').val('');
    	$('#inputParentMeaningKor').val('');
    	$('#inputParentMeaningEng').val('');

    	$('#inputCodeSetName').attr("readonly",false);


    	//코드LIST 그리드 위에 어느 코드SET의 코드LIST정보인지 보여주는 태그
    	$('#codeSetInfoTag').html("");	//리셋


    	//코드LIST 그리드 clear
    	myGrid2.clearSort();		//소팅초기화
		myGrid2.setData({list:[]});	//그리드데이터 초기화


		//코드LIST 선택 리셋
		fnObj.resetCodeList();

		//toast.push("리셋 OK!");

    },//end resetCodeSet


  	//배열에 새로운 인자로 추가 (공통코드 이상문제해결)
    addComCodeArray: function(obj){
		for(var i=0; i<obj.length; i++){
			obj[i].optionValue = obj[i].CD;		//'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
			obj[i].optionText  = obj[i].NM;		//'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
		}
    },


  	//저장 (코드SET)
    doSaveCodeSet: function(){

    	//-------------------- validation :S --------------------

    	if(isEmpty($('#inputCodeSetName').val())){			//코드SET
    		dialog.push({body:"<b>확인!</b> 코드SET을 입력해주세요!", type:"", onConfirm:function(){$('#inputCodeSetName').focus();}});
    		return;
    	}
    	if(isEmpty($('#inputMeaningKor').val())){			//코드SET명
    		dialog.push({body:"<b>확인!</b> 코드SET명을 입력해주세요!", type:"", onConfirm:function(){$('#inputMeaningKor').focus();}});
    		return;
    	}
    	if(isEmpty($('#inputMeaningEng').val())){			//코드SET영문
    		dialog.push({body:"<b>확인!</b> 코드SET영문을 입력해주세요!", type:"", onConfirm:function(){$('#inputMeaningEng').focus();}});
    		return;
    	}
    	if(isEmpty($('#inputDesc').val())){					//설명
    		dialog.push({body:"<b>확인!</b> 설명을 입력해주세요!", type:"", onConfirm:function(){$('#inputDesc').focus();}});
    		return;
    	}


		//영문코드 확인
		var addYn = true;
		regExp = /^[A-Za-z0-9\_]*$/;
		if(!regExp.test($('#inputCodeSetName').val())){
			addYn = false;
		}

		if(!addYn){
			dialog.push({body:"<b>확인!</b> 코드값은 영문자,숫자,_만 가능합니다!", type:"", onConfirm:function(){$('#inputCodeSetName').focus();}});
    		return;
		}

		//----- 코드명이 존재하는 코드명인지
		var codeSetName = $('#inputCodeSetName').val();		//등록하려는 코드명


    	//코드SET NAME 대문자 처리
    	codeSetName = codeSetName.toUpperCase();
    	$('#inputCodeSetName').val(codeSetName);

		var codeSetId = $('#inputCodeSetId').val();			//등록하려는 코드SET 아이디
    	var list = myGrid.getList();
    	for(var i=0; i<list.length; i++){
    		if(list[i].codeSetName == codeSetName && list[i].codeSetId != codeSetId){			//기 등록 코드명이면
    			dialog.push({body:"<b>확인!</b> 이미 등록된 코드SET 입니다! <br><br> 다른 코드SET 을 입력해주세요!", type:"", onConfirm:function(){$('#inputCodeSetName').select();}});
        		return;
    		}
    	}

    	//공통코드 dup chk :S
    	var cheUrl =  contextRoot + "/system/getCodeDupChk.do";
    	var chkParam = {
	    	codeSetName: $('#inputCodeSetName').val(),
	    	codeGroup : "SYSTEM"
    	}
    	var chkCnt = 0 ;
    	var chkCallback = function(result){
    		var obj = JSON.parse(result);
			chkCnt = obj.resultObject.chkCnt;
    	};

    	commonAjax("POST", cheUrl, chkParam, chkCallback,false);


    	if(chkCnt>0){
    		dialog.push({body:"<b>확인!</b> 이미 공통코드로 등록된 코드SET 입니다! <br><br> 다른 코드SET 을 입력해주세요!", type:"", onConfirm:function(){$('#inputCodeSetName').select();}});
    		return;
    	}
    	//공통코드,시스템코드 통합 dup chk :E

    	//-------------------- validation :E --------------------
    	var codeSetId = $('#inputCodeSetId').val();		//신규,수정 판단위해


    	var url = contextRoot + "/system/doSaveCodeSetForSystem.do";
    	var param = {
    			mode: isEmpty(codeSetId)?"new":"update",			//화면 모드 mode : "new", "update"
    			codeSetId: $('#inputCodeSetId').val(),
    			codeSetNameBefore : $('#inputCodeSetNameBefore').val(),	//코드셋 수정 시 사용할 코드셋 코드명
    			codeSetName: $('#inputCodeSetName').val(),
    			meaningKor: $('#inputMeaningKor').val(),
    			meaningEng: $('#inputMeaningEng').val(),
    			codeType: $('#selCodeType').val(),
    			codeGroup: 'SYSTEM',
    			description: $('#inputDesc').val(),
    			deleteFlag: $('#selDeleteFlag').val(),
    			parentSetId: $('#inputParentSetId').val(),
    			parentSetName: $('#inputParentSetName').val(),
    			parentMeaningKor: $('#inputParentMeaningKor').val(),
    			parentMeaningEng: $('#inputParentMeaningEng').val(),
    	}
    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){

    			fnObj.doSearch();	//목록화면 재조회 호출.
    			toast.push("저장OK!");
    		}else{
    			alertM("저장하는 도중 오류가 발생하였습니다.");
    		}

    	};

    	commonAjax("POST", url, param, callback);
    },//end doSave


  	//코드LIST 선택
    selectRowCodeList: function(codeListInfoObj){
    	//코드SET 모드 상태 표시
    	$('#displayCodeNmList').html(codeListInfoObj.value);
    	$('#displayModeList').html(' 수정');


    	$("#inputValueBefore").val(codeListInfoObj.value);			//코드리스트 영문코드(기존값)
    	$('#inputCodeListId').val(codeListInfoObj.codeListId);		//아이디
    	$('#inputValue').val(codeListInfoObj.value);				//코드값
    	$('#inputMeaningKor2').val(codeListInfoObj.meaningKor);		//한글명
    	$('#inputMeaningEng2').val(codeListInfoObj.meaningEng);		//영문명
    	$('#inputSort').val(codeListInfoObj.sort);					//정렬값
    	$('#inputDesc2').val(codeListInfoObj.description);			//설명
    	$('#selDeleteFlag2').val(codeListInfoObj.deleteFlag);		//삭제여부

    	//자식코드SET
    	$('#inputSonSetId').val(codeListInfoObj.sonSetId);			//자식코드셋 아이디
    	$('#inputSonSetName').val(codeListInfoObj.sonSetName);		//자식코드셋 명
    	$('#inputSonMeaningKor').val(codeListInfoObj.sonMeaningKor);
    	$('#inputSonMeaningEng').val(codeListInfoObj.sonMeaningEng);

    	$('#inputValue').attr("readonly",true);  //코드LIST 코드값 변경불가

    },//end selectRowCodeList


  	//코드LIST RESET
    resetCodeList: function(type){

    	//코드SET 상태표시 초기화
    	$('#displayCodeNmList').html('');
    	$('#displayModeList').html('신규등록');


    	$("#inputValueBefore").val('');
    	$('#inputCodeListId').val('');						//아이디
    	$('#inputValue').val('');							//코드값
    	$('#inputMeaningKor2').val('');						//한글명
    	$('#inputMeaningEng2').val('');						//영문명
    	$('#inputSort').val('');							//정렬값
    	$('#inputDesc2').val('');							//설명
    	$('#selDeleteFlag2').val('N');						//삭제여부

    	$('#inputSonSetId').val('');						//자식코드셋 아이디
    	$('#inputSonSetName').val('');						//자식코드셋 명
    	$('#inputSonMeaningKor').val('');
    	$('#inputSonMeaningEng').val('');

    	$('#inputValue').attr("readonly",false);

    	if(type != "REFRESH")
    		toast.push("추가 준비 OK!");

    },//end resetCodeSet


  	//저장 (코드LIST)
    doSaveCodeList: function(){

    	//-------------------- validation :S --------------------

    	if(isEmpty($('#inputCodeSetId').val())){			//코드SET 아이디
    		dialog.push({body:"<b>확인!</b> 코드SET을 먼저 선택해주세요!", type:"", onConfirm:function(){}});
    		return;
    	}


    	if(isEmpty($('#inputValue').val())){				//코드값
    		dialog.push({body:"<b>확인!</b> 코드값을 입력해주세요!", type:"", onConfirm:function(){$('#inputValue').focus();}});
    		return;
    	}

    	if(isEmpty($('#inputSort').val())){				// 정렬값
    		dialog.push({body:"<b>확인!</b> 정렬값을 입력해주세요!", type:"", onConfirm:function(){$('#inputSort').focus();}});
    		return;
    	}

    	if(isEmpty($('#inputMeaningKor2').val())){			//한글명
    		dialog.push({body:"<b>확인!</b> 한글명을 입력해주세요!", type:"", onConfirm:function(){$('#inputMeaningKor2').focus();}});
    		return;
    	}
    	if(isEmpty($('#inputMeaningEng2').val())){			//영문명
    		dialog.push({body:"<b>확인!</b> 영문명을 입력해주세요!", type:"", onConfirm:function(){$('#inputMeaningEng2').focus();}});
    		return;
    	}
    	if(isEmpty($('#inputDesc2').val())){				//설명
    		dialog.push({body:"<b>확인!</b> 설명을 입력해주세요!", type:"", onConfirm:function(){$('#inputDesc2').focus();}});
    		return;
    	}


		//영문코드 확인
		var addYn = true;
		regExp = /^[A-Za-z0-9\_]*$/;
		if(!regExp.test($('#inputValue').val())){
			addYn = false;
		}

		if(!addYn){
			dialog.push({body:"<b>확인!</b> 코드값은 영문자,숫자,_만 가능합니다!", type:"", onConfirm:function(){$('#inputValue').focus();}});
    		return;
		}

		//----- 코드명이 존재하는 코드명인지
		var value = $('#inputValue').val();					//등록하려는 코드값


    	//코드SET NAME 대문자 처리
    	value = value.toUpperCase();
    	$('#inputValue').val(value);

    	//----- 코드명이 존재하는 코드명인지
		var codeListId = $('#inputCodeListId').val();		//등록하려는 코드LIST 아이디
    	var list = myGrid2.getList();
    	for(var i=0; i<list.length; i++){
    		if(list[i].value == value && list[i].codeListId != codeListId){			//기 등록 코드명이면
    			dialog.push({body:"<b>확인!</b> 이미 등록된 코드값 입니다! <br><br> 다른 코드값 을 입력해주세요!", type:"", onConfirm:function(){$('#inputValue').select();}});
        		return;
    		}
    	}

    	//-------------------- validation :E --------------------



    	var codeListId = $('#inputCodeListId').val();		//신규,수정 판단

    	var url = contextRoot + "/system/doSaveCodeListForSystem.do";
    	var param = {
    			mode: isEmpty(codeListId)?"new":"update",			//모드 mode : "new", "update"
    			codeValueBefore : $("#inputValueBefore").val(),
    			codeListId: codeListId,
    			codeSetId: $('#inputCodeSetId').val(),
    			codeSetName : $("#inputCodeSetName").val(),
    			value: $('#inputValue').val(),
    			meaningKor: $('#inputMeaningKor2').val(),
    			meaningEng: $('#inputMeaningEng2').val(),
    			sort: $('#inputSort').val(),
    			description: $('#inputDesc2').val(),
    			deleteFlag: $('#selDeleteFlag2').val(),
    			sonSetId:	$('#inputSonSetId').val(),				//자식 codeSet
    			sonSetName : $("#inputSonSetName").val()

    	}
    	var callback = function(result){

    		var obj = JSON.parse(result);

    		var cnt = obj.resultVal;	//결과수

    		if(obj.result == "SUCCESS"){

    			fnObj.doSearch2($('#inputCodeSetId').val());	//목록화면 재조회 호출.
    			toast.push("저장OK!");


    			//코드LIST 선택 리셋
    			fnObj.resetCodeList("REFRESH");

    		}else{
    			//alertMsg();
    			alertM("코드 리스트 저장 도중 오류가 발생하였습니다.");
    			return;
    		}

    	};

    	commonAjax("POST", url, param, callback);
    },//end doSaveCodeList


  	//부모 코드 set 초기화
  	doRefreshCodeSet : function(){
  		$("#inputParentSetId").val("");
  		$("#inputParentSetName").val("");
  		$("#inputParentMeaningKor").val("");
  		$("#inputParentMeaningEng").val("");
  	},
  	//자식 코드 set 초기화
    doRefreshSonset : function(){
    	$('#inputSonSetId').val("");
    	$('#inputSonSetName').val("");
    	$('#inputSonMeaningKor').val("");
    	$('#inputSonMeaningEng').val("");
    }


};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();		//검색

	//검색버튼 동작
	$(".searchButtonItem").on("click", function(){
		fnObj.doSearch();
	});
});
</script>