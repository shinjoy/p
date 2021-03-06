<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<section id="detail_contents">
	<div class="sys_search_box">
		<div id="AXSearchTarget" class="fl_block"></div>

	</div>
	<div class="sys_p_noti mgt20 mgb10"><span class="icon_noti"></span><span class="pointB">신규등록</span><span>은 입력폼에 입력하여 저장을 합니다.</span><span class="pointred"> (수정을 하시려면 해당 ROW를 클릭하여 수정 후 저장하시기 바랍니다.)</span></div>
	<div id="AXGridTarget"></div>
</section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드
var comCodeCodeType;			//코드타입
var comCodeCodeGroup;			//코드그룹

var orgCodeCombo;				//ORG 코드


var mySearch = new AXSearch(); 	// instance
var myGrid = new AXGrid(); 		// instance
var myGrid2 = new AXGrid(); 	// instance

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//공통코드
		var params = {'authOrgId':'N', 'userId':'${baseUserLoginInfo.userId}'};		//나에게 권한이 있는 관계사만 볼 수 있다
		orgCodeCombo = getCodeInfo(lang, 'optionValue', 'optionText', null, null, null, '/common/getOrgCodeCombo.do', params);		//ORG코드(콤보용) 호출
		if(orgCodeCombo == null){
			orgCodeCombo = [{'CD':'','NM':'선택'}];
    	}
		params.orgId = '${baseUserLoginInfo.applyOrgId}';		//default 검색 ORG
		params.enable = 'Y';		//default 검색 ORG
		roleCodeCombo = getCodeInfo(lang, 'optionValue', 'optionText', null, null, null, '/system/getRoleCodeCombo.do', params);	 //권한코드(콤보용) 호출
		if(roleCodeCombo == null){
			roleCodeCombo = [{'CD':'','NM':'선택'}];
    	}
	},


	//화면세팅
    pageStart: function(){

    	//-------------------------- 검색 :S ---------------------------
    	fnObj.setSearchCondition();						//검색조건 박스 세팅
    	//-------------------------- 검색 :E ---------------------------


    	//-------------------------- 그리드 :S -------------------------
    	myGrid.setConfig({		//코드SET 그리드
            targetID : "AXGridTarget",
            theme : "AXGrid",

            fixedColSeq : 3,	//컬럼고정 index
            fitToWidth : true,	//true,	//넓이에맞게
            colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"

            height: 550,		//grid height
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

                /* {key:"codeSetId",		label:"ID", 			width:"30",		align:"center",  formatter:function(){return (this.value);}}, */
                {key:"codeSetName", 	label:"코드SET", 		width:"130",	align:"center",  formatter:function(){return ("<b>" + (this.item.chk=='1'?'<strike><font color="#FF6C6C">':'') + (this.value) + "</b>");}},
                {key:"codeSetNmKor",	label:"코드SET명", 		width:"140",	align:"center",  formatter:function(){return ("<b>" + (this.item.chk=='1'?'<strike><font color="#FF6C6C">':'') + (this.value) + "</b>");}},
                //{key:"description",		label:"설명", 			width:"150",	align:"left"},
                //{key:"codeListId",		label:"아이디", 			width:"50",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"value",			label:"코드값", 			width:"100",	align:"center",  formatter:function(){return ("<b>" + (this.item.chk=='1'?'<strike><font color="#FF6C6C">':'') + (this.value) + "</b>");}},
                {key:"valueNmKor",		label:"한글명", 			width:"140",	align:"center",	 formatter:function(){return ("<b>" + (this.item.chk=='1'?'<strike><font color="#FF6C6C">':'') + (this.value) + "</b>");}},
                {key:"sort",			label:"정렬", 			width:"50",		align:"center",	 formatter:function(){return ((this.item.chk=='1'?'<strike><font color="#FF6C6C">':'') + (typeof this.value=='undefined' || this.value == null?'':this.value));}},
                {key:"valueDesc",		label:"설명", 			width:"140",	align:"left",	 formatter:function(){return ((this.item.chk=='1'?'<strike><font color="#FF6C6C">':'') + (typeof this.value=='undefined' || this.value == null?'':this.value));}},

                {key:"chk",				label:"제외여부", 		width:"100",		align:"center",	 formatter:function(){
                																					var rStr = "<b>" + (this.value=='1'?'<span style="line-height:13px; padding:4px 5px; text-align:center; min-width:34px; vertical-align:middle; box-sizing:border-box; display:inline-block; font-size:11px; border-radius:3px; float:left; margin-left:5px; font-family:"돋움"; border-left:#fc4e4e solid 1px; border-right:#fc4e4e solid 1px; border-top:#fc4e4e solid 1px; border-bottom:#fc4e4e solid 1px;">&nbsp;제외&nbsp;</span>':'<span style="color:#666666; line-height:13px; padding:4px 5px; text-align:center; min-width:34px; vertical-align:middle; box-sizing:border-box; display:inline-block; font-size:11px; border-radius:3px; float:left; margin-left:5px; font-family:"돋움"; border-left:#c8c9cb solid 1px; border-right:#c8c9cb solid 1px; border-top:#c8c9cb solid 1px; border-bottom:#c8c9cb solid 1px;">&nbsp;선택&nbsp;') + "</b>";
                																					return rStr;}}
            ],
            body : {
                onclick: function(){
                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                	//toast.push("<b>내용</b>:\n" + this.item.CONTENT);
                	//alert(JSON.stringify(this));
                	if(this.c == 7){
                		//fnObj.viewMenu(this.item.menuId);
                		//fnObj.selectRowCodeSet(this.list[this.index]);	//코드SET 정보보기 (코드SET정보 객체전달)

                		fnObj.changeExclusion(this.item);

                	}

                },

                /* ondblclick: function(){
                	//fnObj.viewArticle(this.list[this.index].BOARD_SEQ);
                } */

            },
			page:{
				//fullSizeButton: true,		//grid full size button

				paging:false,
				status:{formatter: null}
			}

        });

    	//-------------------------- 그리드 :E -------------------------


    },//end pageStart.


    //검색조건 박스 세팅
    setSearchCondition: function(){
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
						{label:"관계사", type:"selectBox", width:"", key:"orgSelBox", addClass:"secondItem mgr20", valueBoxStyle:"", value:"${baseUserLoginInfo.applyOrgId}",
							options: orgCodeCombo,
							AXBind:{
								type:"select", config:{
									onChange:function(){
										fnObj.changeOrg();		//관계사 변경
									}
								}
							},
						},
   						{label:"권한", type:"selectBox", width:"", key:"roleId", addClass:"secondItem mgr10", valueBoxStyle:"", value:"title",
   							options: roleCodeCombo,
   							AXBind:{
   								type:"select", config:{
   									onChange:function(){
   										//toast.push(Object.toJSON(this));
   										fnObj.doSearch();
   									}
   								}
   							}
   						},
   						{type:"inputText", width:"200", key:"search", placeholder:"검색어입력", addClass:"secondItem", value:"",
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

    },
  	//################# init function :E #################


    //################# else function :S #################

  	//검색(코드SET)
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	var url = contextRoot + "/system/getCodeSetValuePerRole.do";
    	var param = mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서
    	param.orgId = param["orgSelBox"];		//orgId key 추가

    	/* alert(JSON.stringify(param));
    	return; */

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}


    		var cnt = obj.resultVal;	//결과수
    		var list = obj.resultList;	//결과데이터JSON

    		var gridData = {list:list,
    						page:{listCount:cnt}};

    		myGrid.clearSort();			//소팅초기화
    		myGrid.setData(gridData);	//그리드에결과반영
    	};

    	commonAjax("POST", url, param, callback);
    },//end doSearch


    //관계사콤보 변경 핸들러
    changeOrg: function(){

    	//fnObj.doSearch();		//조회
		var ps = mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서
		var params = {};
		params.orgId = ps["orgSelBox"];		//orgId key 추가
		params.enable = 'Y';		//사용가능여부
		//var params = {'orgId' : '${baseUserLoginInfo.applyOrgId}'};		//default 검색 ORG
		roleCodeCombo = getCodeInfo(lang, 'optionValue', 'optionText', null, null, null, '/system/getRoleCodeCombo.do', params);	 //권한코드(콤보용) 호출



		fnObj.setSearchCondition();						//검색조건 박스 세팅
		mySearch.setItemValue('orgSelBox', params.orgId);


		fnObj.doSearch();		//검색
    },


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


  	//배열에 새로운 인자로 추가 (공통코드 이상문제해결)
    addComCodeArray: function(obj){
		for(var i=0; i<obj.length; i++){
			obj[i].optionValue = obj[i].CD;		//'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
			obj[i].optionText  = obj[i].NM;		//'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
		}
    },

  	//체크박스 선택(제외여부 변경)
  	changeExclusion: function(obj){

  		var param = mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서
    	var orgId = param["orgSelBox"];		//orgId key 추가


    	var url = contextRoot + "/system/changeExclusion.do";
    	var param = {
    			orgId		: orgId,

    			roleId		: obj.roleId,
    			codeSetName : obj.codeSetName,
    			value		: obj.value,

    			knd			: (obj.chk == '0'?'INS':'DEL')	//'0'(제외아닌상태) 일때 버튼을 누르면, 제외로 전환('INS')... 반대경우는('DEL') 삭제시켜 사용허가(black list방식)
    	};


    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}

    		var cnt = obj.resultVal;	//결과수

    	    if(obj.result == "SUCCESS"){ //alert("저장하였습니다!");
    			toast.push("저장하였습니다!");

    			//background-color
    	    	//var styleStr = $("#" + obj.id + " > option[value='" + obj.value + "']").attr('style');
    	    	//$(obj).attr('style', styleStr);

    			fnObj.doSearch();	//재검색

    		}/*else{		   //"FAIL"
    			if(obj.resultVal == "SESSION"){		//session out
    				alertLogin();					//login pop
    			}else{
    				alertMsg("[FAIL!!]\n\n" + decodeURIComponent(obj.resultMsg));
    			}
    		}*/

    	};

    	commonAjax("POST", url, param, callback);
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

    	//----- 코드명이 존재하는 코드명인지
		var codeSetName = $('#inputCodeSetName').val();		//등록하려는 코드명
		var codeSetId = $('#inputCodeSetId').val();			//등록하려는 코드SET 아이디
    	var list = myGrid.getList();
    	for(var i=0; i<list.length; i++){
    		if(list[i].codeSetName == codeSetName && list[i].codeSetId != codeSetId){			//기 등록 코드명이면
    			dialog.push({body:"<b>확인!</b> 이미 등록된 코드SET 입니다! <br><br> 다른 코드SET 을 입력해주세요!", type:"", onConfirm:function(){$('#inputCodeSetName').select();}});
        		return;
    		}
    	}

    	//-------------------- validation :E --------------------

    	var codeSetId = $('#inputCodeSetId').val();		//신규,수정 판단위해

    	var url = contextRoot + "/system/doSaveCodeSet.do";
    	var param = {
    			mode: isEmpty(codeSetId)?"new":"update",			//화면 모드 mode : "new", "update"
    			codeSetId: $('#inputCodeSetId').val(),
    			codeSetName: $('#inputCodeSetName').val(),
    			meaningKor: $('#inputMeaningKor').val(),
    			meaningEng: $('#inputMeaningEng').val(),
    			codeType: $('#selCodeType').val(),
    			codeGroup: $('#selCodeGroup').val(),
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
    			//alertMsg();
    		}

    	};

    	commonAjax("POST", url, param, callback);
    },//end doSave


  	//################# else function :E #################

};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();		//검색
	//fnObj.setTooltip();
});
</script>