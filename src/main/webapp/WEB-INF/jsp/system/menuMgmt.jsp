<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>



<section id="detail_contents">
	<div class="sys_search_box">
		<div id="AXSearchTarget" class="fl_block"></div>
		<div class="fr_block">
			<button name="reg_btn" class="btn_b2_skyblue" onclick="fnObj.excelDownload();"><em class="icon_XLS">파일로 저장</em></button>
			<!-- <button class="btn_b2_skyblue" style="padding:2px;"><em><a href="/manualView/menu1.pdf">MENUAL</a></em></button> -->
		</div>
	</div>
	<div class="sys_p_noti mgt20 mgb10"><span class="icon_noti"></span><span class="pointB">메뉴를 수정</span><span>하시려면 테이블 해당 셀을 클릭하시면 수정팝업이 뜹니다.</span></div>
	<div id="AXGridTarget"></div>
	<div class="systemBtnzone">
		<button type="button" class="AXButton Classic btn_auth" onclick="fnObj.addOpen();"><i class="axi axi-add" style="font-size:12px;"></i> 메뉴등록</button><!-- <button type="button" class="AXButton Classic" onclick="fnObj.excelDownload();"><i class="axi axi-download" style="font-size:12px;"></i> 엑셀다운</button> -->
	</div>
</section>



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드
//var comCodeRoleCd;				//권한코드
var comCodeMenuType;			//메뉴타입

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
		comCodeMenuType = getBaseCommonCode('MENU_TYPE', lang, 'CD', 'NM', '', '전체보기', 'ALL', { orgId : "${baseUserLoginInfo.orgId}" });

		//'optionValue','optionText' 프로퍼티를 생성하며 값으로 CD, NM 의 값 할당
		this.addComCodeArray(comCodeMenuType);

	},


	//화면세팅
    pageStart: function(){

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


   						{label:"메뉴타입 :", type:"radioBox", key:"menuType", addClass:"", value:"",	//value:"TREE" 기본선택값
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

   						{type:"inputText", key:"search", width:"200", placeholder:"검색어입력", addClass:"secondItem mgl30", value:"",
   							onChange: function(changedValue){
   								//아래 2개의 값을 사용 하실 수 있습니다.
   								dialog.push(Object.toJSON(this));
   								dialog.push(changedValue);
   							}
   						},

   						{label : "", type : "button",  width:"40", value : "검색", addClass:"mgl10",
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

            fixedColSeq : 3,	//컬럼고정 index
            fitToWidth : true,	//true,	//넓이에맞게
            colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"

            height: 570,		//grid height
            //width: '95%',

            autoChangeGridView: { // autoChangeGridView by browser width
                mobile:[0,600], grid:[600]
            },

            //passiveMode:true,
			//passiveRemoveHide:false,

            colGroup : [
                {key:"NO", 		label:"NO", 	width:"40", 	align:"center",	sort: false,  formatter:function(){
                	//return (this.list.length - this.index) + ( ( this.page.pageNo - 1) * this.page.pageSize );		//역순
                	return ("<span>" + (this.index + 1) + "</span>"); /*글번호*/
                }},

                {key:"menuId", 			label:"ID", 		width:"45",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"menuNum",			label:"메뉴번호", 	width:"65",		align:"center",	 formatter:function(){return ("<b>" + (this.value==null?'':this.value) + "</b>");}},
                {key:"menuEng", 		label:"코드명", 		width:"140",	align:"left",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"menuTitleKor", 	label:"메뉴명(한글)", width:"140",	align:"left"},
                {key:"menuTitleEng", 	label:"메뉴명(영문)", width:"140",	align:"left"},

                {key:"menuTypeNm",		label:"메뉴타입", 	width:"65",		align:"center"},
                {key:"menuTitle",		label:"상위메뉴", 	width:"65",		align:"center"},
                {key:"menuDesc", 		label:"설명", 		width:"150",	align:"left"},
                {key:"menuPath", 		label:"URL", 		width:"190",	align:"left"},

                {key:"cssNm",		 	label:"CSS명",		width:"90",		align:"center"},
                {key:"enable", 			label:"사용",	 	width:"50",		align:"center"},
                {key:"createDate", 		label:"등록일", 		width:"80",		align:"center"},
                {key:"createNm", 		label:"등록자", 		width:"60",		align:"center"},
                {key:"updateDate", 		label:"수정일", 		width:"80",		align:"center"},
                {key:"updateNm", 		label:"수정자", 		width:"60",		align:"center"}


            ],
            body : {
                onclick: function(){

                	if(this.c > 1 ){		//메뉴보기
                		fnObj.viewMenu(this.list[this.index]);	//메뉴정보보기 (메뉴정보 객체전달)
                	}

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

    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	var pars = mySearch.getParam();

    	var url = contextRoot + "/system/getMenuList.do";
    	var param = mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서

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
    		myGrid.clearSort();			//소팅초기화

    		myGrid.setData(gridData);	//그리드에결과반영

    	};

    	commonAjax("POST", url, param, callback);
    },//end doSearch


    //엑셀다운
    excelDownload: function(){
    	 excelDown(myGrid.getExcelFormat('html'), "download");		//common.js
    },



  	//메뉴등록 버튼 클릭
    addOpen: function(){
    	var url = "<c:url value='/system/addMenu.do'/>";
    	var params = {mode:'new'};	//"btype=1&cate=1".queryToObject();		//게시판유형(board_type), 게시판 카테고리 를 넘긴다.

    	//params 에 코드리스트 전달------
    	var list = myGrid.getList();	//그리드 데이터(array object)
    	var codeList  = '';				//코드리스트(','로 연결된 문자열)
    	var menuNumList  = '';			//메뉴번호 리스트(메뉴번호 중복으로인한 오류때문에 추가 - sjy)
    	for(var i=0; i<list.length; i++){
    		codeList += list[i].menuEng.toUpperCase() + ',';
    		if(list[i].menuNum != "" && list[i].menuNum != null)
    			menuNumList += list[i].menuNum.toUpperCase() + ',';
    	}

    	params.codeList = codeList;		//파라미터에 추가(key,value)
    	params.menuNumList = menuNumList;		//파라미터에 추가(key,value)
    	//-----------------------------

    	myModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '메뉴등록',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: $(window).scrollTop() + 150,
    		width: 650,
    		closeByEscKey: true				//esc 키로 닫기
    	});

    	$('#myModalCT').draggable();
    },//end writeOpen


  	//글보기
    viewMenu: function(menuInfoObj){
    	var url = "<c:url value='/system/addMenu.do'/>";
    	var params = {mode:'update',
    				  menuInfoObj:JSON.stringify(menuInfoObj)};//("mode=view&boardSeq="+boardSeq+"&btype=1&cate=1").queryToObject();	//게시판유형(board_type), 게시판 카테고리 를 넘긴다.

    	myModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '메뉴수정',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: $(window).scrollTop() + 150,
    		width: 650,
    		closeByEscKey: true			//esc 키로 닫기
    	});

    	$('#myModalCT').draggable();
    },//end writeOpen


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
	fnObj.doSearch();		//검색

	//검색버튼 동작
	$(".searchButtonItem ").on("click", function(){
		fnObj.doSearch();
	});


});
</script>