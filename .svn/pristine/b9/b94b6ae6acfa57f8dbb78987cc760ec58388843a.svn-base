<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<section id="detail_contents">
	<div class="sys_search_box">
		<div id="AXSearchTarget" class="fl_block"></div>

	</div>

	<div class="sys_p_noti mgt20 mgb10"><span class="icon_noti"></span><span>화면권한 수정은 </span><span class="pointB">체크박스</span><span>를 통해 수정 하실수 있습니다.</span></div>

	<div id="AXGridTarget"></div>

</section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드
var roleCodeCombo;				//권한코드
var orgCodeCombo;				//관계사 리스트
var targetOrgId ="${targetOrgId}";	//관계사 코드
var mySearch = new AXSearch(); 	// instance
var myGrid = new AXGrid(); 		// instance

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
		if(targetOrgId == ''){
			targetOrgId = '${baseUserLoginInfo.applyOrgId}' ;
		}
		comCodeMenuType = getBaseCommonCode('MENU_TYPE', lang, 'CD', 'NM', '', '전체보기', 'ALL', {"orgId": targetOrgId});		//메뉴타입 공통코드 (Sync ajax)
		if(comCodeMenuType == null){
			comCodeMenuType= [{ 'CD' : '', 'NM' : '전체보기'}];
		}
		var params = {'authOrgId':'N', 'userId':'${baseUserLoginInfo.userId}'};		//나에게 권한이 있는 관계사만 볼 수 있다
		orgCodeCombo = getCodeInfo(lang, 'optionValue', 'optionText', null, null, null, '/common/getOrgCodeCombo.do', params);	//ORG코드(콤보용) 호출

		roleCodeCombo = getCodeInfo(lang, 'CD', 'NM', null, null, null, '/system/getRoleCodeCombo.do', { 'orgId': targetOrgId , enable : 'Y'});	 //권한코드(콤보용) 호출
		if(roleCodeCombo == null){
			roleCodeCombo= [{ 'CD' : '', 'NM' : '선택'}];
		}
		//'optionValue','optionText' 프로퍼티를 생성하며 값으로 CD, NM 의 값 할당
		this.addComCodeArray(comCodeMenuType);
		this.addComCodeArray(roleCodeCombo);
	},
	//관계사 선택 시 권한 창 달라지게하기위함.
	doMove : function(){

		$("<form />", { name : "myForm", id : "myForm", method : "post", action : contextRoot +"/system/pageRolePerRole.do"}).appendTo("#detail_contents");
		$("<input />", { name : "targetOrgId", id : "targetOrgId", value : $("select[name='orgId']").val() }).appendTo("#myForm");
		$("#myForm").submit();

	},

	//화면세팅
    pageStart: function(){

    	//-------------------------- 검색 :S ---------------------------
    	//mySearch
        mySearch.setConfig({
            targetID : "AXSearchTarget",
            theme : "AXSearch",

            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },

            onsubmit: function(){	// 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
				//fnObj.doSearch2();
			},

			rows:[
					{display:true, addClass:"", style:"", list:[
					 {label:"관계사", type:"selectBox", width:"", key:"orgId", addClass:"secondItem mgr20", valueBoxStyle:"", value:targetOrgId,
						options: orgCodeCombo,
					   AXBind:{
					    type:"select", config:{
					    	onChange:function(){
					                 	fnObj.doMove();		//orgID에 해당하는 화면 표시.
					         	}
					     	}
					   	}
					   },
   						{label:"권한", type:"selectBox", width:"", key:"roleId", addClass:"secondItem mgr20", valueBoxStyle:"", value:"title",
   							//options:[{optionValue:"userName", optionText:"이름"}, {optionValue:"userSabun", optionText:"사번"}, {optionValue:"userId", optionText:"아이디"}],
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
   						{label:"타입 :", type:"radioBox", width:"", key:"menuType", addClass:"secondItem", valueBoxStyle:"", value:"",	//value:"TREE" 기본선택값
   							options: comCodeMenuType,
   							onChange: function(selectedObject, value){
   								//아래 3개의 값을 사용 하실 수 있습니다.
   								//toast.push(Object.toJSON(this));
   								//toast.push(Object.toJSON(selectedObject));
   								//toast.push(value);

   								//검색호출
   								fnObj.doSearch();

   							}
   						},
   						{type : "button",  width:"40", value : "검색", addClass:"mgl10",
   	   						onClick: function(selectedObject, value){
   								//검색호출
   								fnObj.doSearch();

   							}

      					}
   					]}
			     ]

        });//end
    	//-------------------------- 검색 :E ---------------------------

    	//-------------------------- 그리드 :S -------------------------
    	myGrid.setConfig({
            targetID : "AXGridTarget",
            theme : "AXGrid",

            fixedColSeq : 3,	//컬럼고정 index
            fitToWidth : true,	//true,	//넓이에맞게
            colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"
            colHeadTool : false,	//컬럼 display 여부를 설정
            height: 550,		//grid height

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

                //{key:"chk", 	label:"<input type='checkbox' name='allChkRight' readonly='true' onclick='fnObj.allCheck(1);' />",  width:"30",	align:"center", sort: false,  formatter:function(){return ("<input type='checkbox' name='mCheckRight' value='" + this.value + "' onclick='fnObj.clickCheckboxR(this, " + this.index + ");' " + ((this.value==1)?"checked":"") + " />");}},

                //{key:"menuId", 			label:"아이디", 		width:"50",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"menuTypeNm",		label:"타입", 		width:"70",		align:"center"},
                {key:"menuEng", 		label:"코드명", 		width:"140",	align:"center"},
                {key:"menuTitleKor", 	label:"제목한글", 	width:"150",	align:"center"},
                //{key:"menuTitleEng", 	label:"제목영문", 	width:"150",	align:"center"},
                {key:"menuDesc", 		label:"설명", 		width:"150",	align:"center"},
                {key:"menuPath", 		label:"URL", 		width:"200",	align:"left"},

                {key:"open", 			label:"<input type='checkbox' name='OPEN'   readonly='true' onclick='fnObj.tryAllCheck(this);' />&nbsp;OPEN",    width:"80",	align:"center", sort: false,  formatter:function(){return ("<input type='checkbox' name='OPEN'   onclick='fnObj.clickCheckbox(this, " + this.index + ");' " + ((this.value=='Y')?"checked":"") + " />");}},
                {key:"select", 			label:"<input type='checkbox' name='SELECT' readonly='true' onclick='fnObj.tryAllCheck(this);' />&nbsp;SELECT",  width:"80",	align:"center", sort: false,  formatter:function(){return ("<input type='checkbox' name='SELECT' onclick='fnObj.clickCheckbox(this, " + this.index + ");' " + ((this.value=='Y')?"checked":"") + " />");}},
                {key:"insert", 			label:"<input type='checkbox' name='INSERT' readonly='true' onclick='fnObj.tryAllCheck(this);' />&nbsp;INSERT",  width:"80",	align:"center", sort: false,  formatter:function(){return ("<input type='checkbox' name='INSERT' onclick='fnObj.clickCheckbox(this, " + this.index + ");' " + ((this.value=='Y')?"checked":"") + " />");}},
                {key:"update", 			label:"<input type='checkbox' name='UPDATE' readonly='true' onclick='fnObj.tryAllCheck(this);' />&nbsp;UPDATE",  width:"80",	align:"center", sort: false,  formatter:function(){return ("<input type='checkbox' name='UPDATE' onclick='fnObj.clickCheckbox(this, " + this.index + ");' " + ((this.value=='Y')?"checked":"") + " />");}},
                {key:"delete", 			label:"<input type='checkbox' name='DELETE' readonly='true' onclick='fnObj.tryAllCheck(this);' />&nbsp;DELETE",  width:"80",	align:"center", sort: false,  formatter:function(){return ("<input type='checkbox' name='DELETE' onclick='fnObj.clickCheckbox(this, " + this.index + ");' " + ((this.value=='Y')?"checked":"") + " />");}}

            ],
            body : {
                onclick: function(){
                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                	//toast.push("<b>내용</b>:\n" + this.item.CONTENT);
                	//alert(JSON.stringify(this));
                	if(this.c == 3 || this.c == 4 || this.c == 5 || this.c == 6 ){		//메뉴보기
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


    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색(메뉴리스트)
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	var pars = mySearch.getParam();

    	var url = contextRoot + "/system/getPageRoleList.do";
    	var param = mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서
    	//param.enable = 'Y';	//사용여부 'Y' 인것만 권한별메뉴설정위해 ///////일단 N 도 메뉴설정할 수 있도록 해놓고 바서 바꾸자!!!!!!!!!!!!!!!!!!!!!!!
    	//param.isNotTree = 'Y';		//메뉴타입이 'TREE' 아닌 것만

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

    		if("${baseUserLoginInfo.orgBasicAuth}" == "READ"){
    			$("input[type='checkbox']").prop("disabled",true);
    		}
    	};

    	commonAjax("POST", url, param, callback);
    },//end doSearch


    //툴팁 세팅
   // setTooltip: function(){
    	//var tooltipStr = '';
    	/*for(var i=1; i<roleCodeCombo.length; i++){
    		tooltipStr += roleCodeCombo[i].NM + " : " + roleCodeCombo[i].DESCRIPTION + "<br>";
    	}*/
    	//tooltipStr += "<strong><font color=#3456c2>[등록방법]</font><br>1. 체크박스를 통해 수정 하시기 바립니다.</strong>";

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


  	//체크박스 선택(권한 저장)
  	clickCheckbox: function(obj, index){

  		var list = myGrid.getList();
  		var rowData = list[index];

    	var url = contextRoot + "/system/changePageRole.do";
    	var param = {
    			menuType	: rowData.menuType,
    			roleId		: rowData.roleId,
    			menuId		: rowData.menuId,
    			orgId 		: $("select[name='orgId']").val(),

    			chkCol		: obj.name,
    			chkVal		: (obj.checked?'Y':'N')
    	};

    	var callback = function(result){

    		var obj = JSON.parse(result);

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


  	//체크박스 전체 체크 시도
    tryAllCheck: function(obj){

    	dialog.push({
		    body:'<b>Caution</b>&nbsp;&nbsp;변경하시겠습니까?<br/><br/>(일괄 변경됩니다!!)', top:0, type:'Caution', buttons:[
                {buttonValue:'확인', buttonClass:'Red', onClick:fnObj.allCheck, data:obj},
                {buttonValue:'취소', buttonClass:'Blue', onClick:function(){}}
		    ]});
    },

  	//체크박스 전체 체크
    allCheck: function(obj){

    	var sObj = mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서

    	var url = contextRoot + "/system/changePageRoleAll.do";
    	var param = {
    			menuType	: sObj.menuType,
    			roleId	: sObj.roleId,

    			chkCol		: obj.name,
    			chkVal		: (obj.checked?'Y':'N')
    	};

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}

    		var rObj = obj.resultObject;		//결과

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


    //배열에 새로운 인자로 추가 (공통코드 이상문제해결)
    addComCodeArray: function(obj){

		for(var i=0; i<obj.length; i++){
			obj[i].optionValue = obj[i].CD;		//'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
			obj[i].optionText  = obj[i].NM;		//'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
		}
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
	//fnObj.setTooltip();
});
</script>