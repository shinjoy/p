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
	height:23px;
}
.bodyNode{
	color:red;
}
.AXGrid .AXgridScrollBody .AXGridBody .gridFixedBodyTable thead tr td .bodyTdText, .AXGrid .AXgridScrollBody .AXGridBody .gridFixedBodyTable tbody tr td .bodyTdText, .AXGrid .AXgridScrollBody .AXGridBody .gridFixedBodyTable tfoot tr td .bodyTdText {
    position: relative;				/* 그리드 헤드 */
    line-height: 18px;
    min-height: 18px;
    padding: 3px 3px;
    color: #3b3b3b;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.AXGrid .AXgridScrollBody .AXGridBody .gridBodyTable thead tr td .bodyTdText, .AXGrid .AXgridScrollBody .AXGridBody .gridBodyTable tbody tr td .bodyTdText, .AXGrid .AXgridScrollBody .AXGridBody .gridBodyTable tfoot tr td .bodyTdText {
    position: relative;				/* 그리드 바디(라인) */
    line-height: 18px;
    min-height: 18px;
    padding: 3px 3px;
    color: #3b3b3b;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.AXGrid .AXgridPageBody {			/* 상태바 높이 */
    height: 16px;
}
.AXGrid .AXgridPageBody .AXgridStatus {	/* 상태바 오른쪽 글씨 */   
    line-height: 16px;
}
#clearBoth{
	clear:both;
}
</style>
<!-- -------- each page css :E -------- -->



<div style="padding:20px; background-color:white;">
	<div class="sys_search_box">
		<div id="AXSearchTarget"></div>
	</div>	
	<!-- <div style="margin-top:3px;float:right;"><button type="button" class="AXButton Classic" onclick="fnObj.doSearch();"><i class="axi axi-search3"></i>&nbsp;&nbsp;검&nbsp;&nbsp;&nbsp;&nbsp;색&nbsp;&nbsp;&nbsp;</button></div>
		 -->
	<div id="AXGridTarget" style="margin-top:25px;"></div>
	
	<div class="btnZoneBox" style="margin-bottom:20px;">
		<button type="button" class="p_blueblack_btn" onclick="fnObj.selectRowTry();"><strong>선택</strong></button>
	</div>		
</div>



<script type="text/javascript">

//Global variables :S ---------------

var mySearch = new AXSearch(); 			//instance
var myGrid = new AXGrid(); 				//instance
var g_openType ='${openType}';			//type : set 에서 open OR list open ( 자식 코드 셋때문에 추가 구분 값, default:list ) 
var g_orgId = '${orgId}';				//선택된 orgId
var g_CODE_GROUP = '${codeGroup}';		//코드 그룹 (SYSTEM or not)

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {
	
	//################# init function :S #################
	
	//선로딩코드
	preloadCode: function(){


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
   						{label:"검 색", labelWidth:"100", type:"inputText", width:"300", key:"search", placeholder:"검색어입력", addClass:"secondItem", valueBoxStyle:"padding-left:10px;", value:"",
   							onChange: function(changedValue){
   								//아래 2개의 값을 사용 하실 수 있습니다.
   								dialog.push(Object.toJSON(this));
   								dialog.push(changedValue);						
   							}
   						},
   						{type : "button",  width:"40", valueBoxStyle:"padding-left:2px;", value : "검색", addClass:"mgl10",
   	   						onclick: function(){
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
            
            height: 300,		//grid height
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
                {key:"parentSetName", 	label:"부모코드SET", 	width:"140",	align:"center"},
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
                		//fnObj.selectRow(this.list[this.index]);	//코드SET 정보보기 (코드SET정보 객체전달)
                	//}
                	
                	fnObj.selectRow(this.list[this.index]);	//코드SET 정보보기 (코드SET정보 객체전달)
                	
                },
                
                ondblclick: function(){
                	
                	//fnObj.selectRow(this.list[this.index]);	//코드SET 정보보기 (코드SET정보 객체전달)
                	
                	//fnObj.viewArticle(this.list[this.index].BOARD_SEQ);
                }
                
            },
			page:{
				paging:false, 
				status:{formatter: null}
			}
            
        });
    	//-------------------------- 그리드 :E -------------------------
    	
    	
    },//end pageStart.
  	//################# init function :E #################
    
    
    //################# else function :S #################
    
  	//검색
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색 
    	
    	var pars = mySearch.getParam();
    
    	var url = contextRoot + "/system/getCodeSet.do";
    	var param = mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서
    	param.codeGroup = g_CODE_GROUP;					//시스템 or 공통
    	param.targetOrgId = g_orgId;					//관계사 정보 반환
    	
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
    
    
  	//코드SET 선택 시도('선택'버튼을 통한 선택시도)
    selectRowTry: function(){
    	
    	//alert(myGrid.getSelectedItem().index >= 0);
    	//return;
    	
    	if(myGrid.getSelectedItem().index >= 0){
    		this.selectRow(myGrid.getSelectedItem().item);
    	}else{
    		dialog.push({body:"<b>확인!</b>표에서 선택해주세요!", type:""});	//, onConfirm:function(){frm.menuEng.focus();}});
    		return;
    	}
    	
    },//end selectRowTry
    
    
  	//코드SET 선택 (부모창의 부모코드SET 정보에 담고 창을 닫는다.)
    selectRow: function(codeSetInfoObj){
    	
    	if(g_openType != 'list'){
    		$(parent.document).find('#inputParentSetId').val(codeSetInfoObj.codeSetId);
        	$(parent.document).find('#inputParentSetName').val(codeSetInfoObj.codeSetName);
        	$(parent.document).find('#inputParentMeaningKor').val(codeSetInfoObj.meaningKor);
        	$(parent.document).find('#inputParentMeaningEng').val(codeSetInfoObj.meaningEng);
    	}else{	//코드 list 에서 open 시 액션
    		$(parent.document).find('#inputSonSetId').val(codeSetInfoObj.codeSetId);
        	$(parent.document).find('#inputSonSetName').val(codeSetInfoObj.codeSetName);
        	$(parent.document).find('#inputSonMeaningKor').val(codeSetInfoObj.meaningKor);
        	$(parent.document).find('#inputSonMeaningEng').val(codeSetInfoObj.meaningEng);
    	}
    	
    	
    	parent.toast.push("선택 OK!");
    	parent.myModal.close();		//현재 창 닫기(부모창에서 닫도록 호출해준다).
    	
    	
    },//end selectRow
    
    
  	//################# else function :E #################
  	
  	
    
};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();		//검색	
});
</script>