<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<section id="detail_contents">
	<div class="sys_search_box">
		<div id="AXSearchTarget" class="fl_block"></div>
		<div class="fr_block">
			<button name="reg_btn" class="btn_b2_skyblue" onclick="fnObj.excelDownload();"><em class="icon_XLS">파일로 저장</em></button>
		</div>
	</div>
	<div class="sys_p_noti mgt20 mgb10"><span class="icon_noti"></span><span class="pointB">모듈을 수정</span><span>하시려면 테이블 해당 셀을 클릭하시면 수정팝업이 뜹니다.</span></div>
	<div id="AXGridTarget"></div>
	<div class="systemBtnzone">
		<button type="button" class="AXButton Classic btn_auth" onclick="fnObj.addOpen();"><i class="axi axi-add" style="font-size:12px;"></i>모듈등록</button>
	</div>
</section>



<script type="text/javascript">

//Global variables :S ---------------
//공통코드
//var comCodeRoleCd;				//권한코드
//var comCodeMenuType;			//메뉴타입

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

   						{label:"검색", type:"inputText", width:"200", key:"search", placeholder:"검색어입력", addClass:"secondItem", value:"",
   							onChange: function(changedValue){
   								//아래 2개의 값을 사용 하실 수 있습니다.
   								dialog.push(Object.toJSON(this));
   								dialog.push(changedValue);
   							}
   						},
   						{label : "", type : "button",  width:"40",value : "검색", addClass:"mgl10",
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
                	return ("<font color=silver><b>" + (this.index + 1) + "</b></font>");
                }},

                {key:"moduleId", 		label:"ID", 		width:"50",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"moduleCode", 		label:"모듈코드", 	width:"90",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"moduleName",		label:"모듈명", 		width:"120",	align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"moduleDesc",		label:"설명", 		width:"100",	align:"left"},
                {key:"moduleIncUrl",	label:"URL",	 	width:"150",	align:"left"},
                {key:"theme",			label:"CSS",	 	width:"150",	align:"left"},
                {key:"moduleGroup",		label:"그룹명",	 	width:"150",	align:"left"},
             /*    {key:"width", 			label:"폭", 			width:"65",		align:"center"},
                {key:"height", 			label:"높이", 		width:"65",		align:"center"}, */
                {key:"enable", 			label:"사용여부", 	width:"65",		align:"center"},
                {key:"createDate", 		label:"등록일", 		width:"90",		align:"center"},
                {key:"createNm", 		label:"등록자", 		width:"70",		align:"center"},
                {key:"updateDate", 		label:"수정일", 		width:"90",		align:"center"},
                {key:"updateNm", 		label:"수정자", 		width:"70",		align:"center"}

            ],
            body : {
                onclick: function(){

                	if(this.c > 0){	//메뉴보기
                		fnObj.viewModule(this.list[this.index]);	//메뉴정보보기 (메뉴정보 객체전달)
                	}

                },

                ondblclick: function(){

                }

            },
			page:{
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

    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	var pars = mySearch.getParam();

    	var url = contextRoot + "/system/getModuleList.do";
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



  	//모듈등록 버튼 클릭
    addOpen: function(){
    	var url = "<c:url value='/system/addModule.do'/>";
    	var params = {mode:'new'};		//"btype=1&cate=1".queryToObject();		//게시판유형(board_type), 게시판 카테고리 를 넘긴다.

    	//params 에 코드리스트 전달------
    	var list = myGrid.getList();	//그리드 데이터(array object)
    	var codeList  = '';				//코드리스트(','로 연결된 문자열)
    	for(var i=0; i<list.length; i++){
    		codeList += list[i].moduleCode.toUpperCase() + ',';
    	}
    	params.codeList = codeList;		//파라미터에 추가(key,value)
    	//-----------------------------

    	myModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '모듈등록',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: 150,
    		width: 540,
    		closeByEscKey: true				//esc 키로 닫기
    	});

    	$('#myModalCT').draggable();
    },//end writeOpen


  	//모듈보기
    viewModule: function(moduleInfoObj){

    	var url = "<c:url value='/system/addModule.do'/>";
    	var params = {mode:'update',
    				  moduleInfoObj:JSON.stringify(moduleInfoObj)};//("mode=view&boardSeq="+boardSeq+"&btype=1&cate=1").queryToObject();	//게시판유형(board_type), 게시판 카테고리 를 넘긴다.

    	myModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '모듈수정',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: 150,
    		width: 540,
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
	// fnObj.setTooltip();

	//검색버튼 동작
	$(".searchButtonItem").on("click", function(){
		fnObj.doSearch();
	});
});
</script>