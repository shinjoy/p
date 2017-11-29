<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!-- -------- each page css :S -------- -->
<style type="text/css">
.AXGrid .AXgridScrollBody .AXGridColHead .colHeadTable tbody tr td .colHeadTdText{		/* grid head */
	font-weight: bold;
	/*
	height:20px;
	background: linear-gradient(silver, white);
	vertical-align: middle;	*/
}
.AXSelect{
	height:16px;
}
.bodyNode{
	color:red;
}
.AXGrid .AXgridScrollBody .AXGridBody .gridFixedBodyTable thead tr td .bodyTdText, .AXGrid .AXgridScrollBody .AXGridBody .gridFixedBodyTable tbody tr td .bodyTdText, .AXGrid .AXgridScrollBody .AXGridBody .gridFixedBodyTable tfoot tr td .bodyTdText {
    position: relative;				/* 그리드 헤드 */
    line-height: 15px;
    min-height: 15px;
    padding: 3px 3px;
    color: #3b3b3b;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.AXGrid .AXgridScrollBody .AXGridBody .gridBodyTable thead tr td .bodyTdText, .AXGrid .AXgridScrollBody .AXGridBody .gridBodyTable tbody tr td .bodyTdText, .AXGrid .AXgridScrollBody .AXGridBody .gridBodyTable tfoot tr td .bodyTdText {
    position: relative;				/* 그리드 바디(라인) */
    line-height: 20px;
    min-height: 20px;
    padding: 3px 3px;
    color: #3b3b3b;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}


html {overflow:hidden;}

.AXButton{
	padding:0 1px;
}

.wrap-loading{ /*화면 전체를 어둡게 합니다.*/
    position: fixed;
    left:0;
    right:0;
    top:0;
    bottom:0;
    background: rgba(0,0,0,0.2); /*not in ie */
    filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');    /* ie */
    z-index: 1000000;
}
.wrap-loading div{ /*로딩 이미지*/
    position: fixed;
    top:50%;
    left:50%;
    margin-left: -21px;
    margin-top: -21px;
    z-index: 1000000;
}
.display-none{ /*감추기*/
    display:none;
}


</style>
<div class="wrap-loading display-none">
	    <div><img src="${pageContext.request.contextPath}/images/ajax_loading.gif" /></div>
</div>

	<div class="popModal_wrap">
		<h3 class="pop_title">주소(우편번호)검색</h3>
		<div class="mo_container">
			<div class="sys_search_box">
				<div id="AXSearchTarget" class="fl_block"></div>
				<!-- <div class="fr_block">
					<button name="reg_btn" class="btn_b2_skyblue" onclick="fnObj.excelDownload();"><em class="icon_XLS">파일로 저장</em></button>
				</div> -->
			</div>
			<div class="sys_p_noti mgt20 mgb10"><span class="icon_noti"></span><span class="pointB">주소의 일부</span><span>를 검색합니다.</span></div>
			<div id="AXGridTarget"></div>
		</div>
	</div>



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

//grid page
var curPageNo;
var pageSize = 10;
//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//공통코드
		//comCodeMenuType = getCommonCode('MENU_TYPE', lang, 'CD', 'NM', '', '전체보기', 'ALL');		//메뉴타입 공통코드 (Sync ajax)

		//'optionValue','optionText' 프로퍼티를 생성하며 값으로 CD, NM 의 값 할당
		//this.addComCodeArray(comCodeMenuType);

	},


	//화면세팅
    pageStart: function(){

    	//-------------------------- 검색 :S ---------------------------
    	mySearch.setConfig({
            targetID : "AXSearchTarget",
            theme : "AXSearch",

            mediaQuery: {
                mx:{min:0, max:650}, dx:{min:650}
            },

            onsubmit: function(){	// 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
				fnObj.doSearch(1);
			},

			rows:[
					{display:true, addClass:"", style:"", list:[
   						{label:"검색", type:"inputText", width:"200", key:"search", placeholder:"검색어입력", addClass:"secondItem", valueBoxStyle:"", value:"",
   							onChange: function(changedValue){
   								//아래 2개의 값을 사용 하실 수 있습니다.
   								dialog.push(Object.toJSON(this));
   								dialog.push(changedValue);
   							}
   						},
   						{label : "", type : "button",  width:"30", value : "검색", addClass:"mgl10",
   							onclick: function(){
								//검색호출
								fnObj.doSearch(1);
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

            fixedColSeq : -1,	//컬럼고정 index
            fitToWidth : true,	//true,	//넓이에맞게
            colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"

            height: 438,		//grid height
            //width: '95%',

            autoChangeGridView: { // autoChangeGridView by browser width
                mobile:[0,500], grid:[500]
            },

            //passiveMode:true,
			//passiveRemoveHide:false,

            colGroup : [
                {key:"NO", 		label:"NO", 	width:"40", 	align:"center",	sort: false,  formatter:function(){
                	//return (this.list.length - this.index) + ( ( this.page.pageNo - 1) * this.page.pageSize );		//역순
                	return ("<span class='fontGray'\>" + (this.index + 1 + ((curPageNo-1)*pageSize)) + "</span>");
                }},

                {key:"knd", 		label:"종류", 		width:"50",		align:"center", formatter:function(){
                	var htmlStr = '<img src="' + contextRoot + '/images/contents/roadAddr.png" style="padding-bottom:5px;"><br><img src="' + contextRoot + '/images/contents/jibunAddr.png">';
                	return htmlStr;}},
                {key:"addr", 		label:"주소", 		width:"330",	align:"left",	formatter:function(){return ("<b>" + (this.item.lnmAdres['#text'] + "<br>" + (this.item.rnAdres['#text'])) + "</b>");}},
                {key:"zip", 		label:"우편번호",	width:"70",		align:"center", formatter:function(){return ("<b>" + (this.item.zipNo['#text']) + "</b>");}},
                {key:"sel", 		label:"선택", 		width:"55",		align:"center", formatter:function(){
                	return '<button type="button" class="btn_s_type_g" onclick="fnObj.selectRow(' + this.index + ');"><em>선택</em></button>';
                }},

            ],
            body : {
                onclick: function(){
                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                	//toast.push("<b>내용</b>:\n" + this.item.CONTENT);
                	//alert(JSON.stringify(this));
                	if(this.c == 1 || this.c == 2 || this.c == 3 || this.c == 4 ){		//메뉴보기
                		//fnObj.viewMenu(this.item.menuId);
                		//fnObj.viewUser(this.list[this.index]);	//메뉴정보보기 (메뉴정보 객체전달)
                	}

                },

                ondblclick: function(){
                	//fnObj.viewArticle(this.list[this.index].BOARD_SEQ);
                }

            },
			/*page:{
				paging:false,
				status:{formatter: null}
			}*/
            page:{
                paging : true	//페이징 사용여부
                ,
                onchange:function(pageNo){
					//페이지 버튼 클릭 이벤트 핸들러 //////
					fnObj.doSearch(pageNo);	//검색
				}
            }

        });
    	//-------------------------- 그리드 :E -------------------------


    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	var pars = mySearch.getParam();

    	var url = contextRoot + "/user/doSearchZipAddr.do";
    	var param = mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서

    	//추가 param
    	param.countPerPage = pageSize;	//위 글로벌 변수에서 정의
    	param.currentPage = page;

    	var callback = function(result){

    		var obj = JSON.parse(result);

    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}

    		var cnt = obj.resultVal;	//결과수
    		var list = obj.resultList;	//결과데이터JSON

    		//var strjson = xml2json.fromStr(list, 'string');
    		//alert(strjson);

    		var jobj = xml2json.fromStr(list);
    		var rootObj = jobj.NewAddressListResponse;

    		//alert(rootObj.cmmMsgHeader.totalCount['#text']);		//totalCount

    		var listObj = rootObj.newAddressListAreaCdSearchAll;

    		curPageNo = rootObj.cmmMsgHeader.currentPage['#text'];		//현재페이지세팅.

    		//var gridData = {list:listObj};


    		var gridData = {list:listObj,
							page:{
								pageNo: rootObj.cmmMsgHeader.currentPage['#text'],		//현재 페이지
								//pageSize:10,				//페이지크기(없어도..)
								pageCount: rootObj.cmmMsgHeader.totalPage['#text'],		//총 페이지수
								listCount: rootObj.cmmMsgHeader.totalCount['#text'],	//총 수
							}
						};


    		myGrid.clearSort();				//소팅초기화
    		if(rootObj.cmmMsgHeader.totalCount['#text'] == undefined){
    			//데이터초기화
    			myGrid.setData({list:[], page:{pageNo: 0,		//현재 페이지
											   pageCount: 0,	//총 페이지수
											   listCount: 0,	//총 수
											}
    							});
    		}
    		myGrid.setData(gridData);		//그리드에결과반영
    	};

    	commonAjax("POST", url, param, callback, true);
    },//end doSearch


    //엑셀다운
    excelDownload: function(){
    	 excelDown(myGrid.getExcelFormat('html'), "download");		//common.js
    },


    //툴팁 세팅
    setTooltip: function(){
    	var tooltipStr = '';
    	/*for(var i=1; i<comCodeRoleCd.length; i++){
    		tooltipStr += comCodeRoleCd[i].NM + " : " + comCodeRoleCd[i].DESCRIPTION + "<br>";
    	}*/
    	tooltipStr += "주소의 일부를 검색합니다";

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


  	//배열에 새로운 인자로 추가 (공통코드 이상문제해결)
    addComCodeArray: function(obj){
		for(var i=0; i<obj.length; i++){
			obj[i].optionValue = obj[i].CD;		//'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
			obj[i].optionText  = obj[i].NM;		//'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
		}
    },


  	//주소(우편번호)선택
    selectRow: function(idx){

    	var addrInfoObj = myGrid.getList()[idx];

    	$(opener.document).find('#inputHomeZip').val(addrInfoObj.zipNo['#text']);
    	$(opener.document).find('#inputHomeAddr1').val(addrInfoObj.lnmAdres['#text']);
    	//$(parent.document).find('#inputHomeAddr2').val(addrInfoObj.rnAdres);

    	//opener.toast.push("선택 OK!");
    	//parent.myModal.close();		//현재 창 닫기(부모창에서 닫도록 호출해준다).
    	window.close();					//현재 창 닫기

    	$(opener.document).find('#inputHomeAddr2').focus();		//나머지주소 입력란에 포커싱

    },//end selectRow

  	//################# else function :E #################



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	//fnObj.doSearch();		//검색
	fnObj.setTooltip();

	$(document.getElementsByName('search')[0]).focus();		//검색입력란에 포커싱
});
</script>