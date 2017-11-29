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
.AXSearchTable tbody td {
    min-height: 36px;
    height: 36px;
    overflow: visible;
    border-bottom:0px;
    color: #666666;
    background: url('images/dx-grid-body-border.png') repeat-y 100% 0px;
}

</style>
<!-- -------- each page css :E -------- -->



<section id="detail_contents">

	<div>
		<table cellpadding="5" cellspacing="0" width="1200" style="border-width:0;">
		    <colgroup>
		    	
		        <col width="43%" />
		        <col width="2"/>
		        <col width="57%"/>		        
		    </colgroup>
		    <tbody>
		    	
		    	<tr class="gray">
		    	
		            <td valign="top" colspan="3" >  	            
		           <div id="AXSearchTarget" style="border-top:1px solid #ccc;"></div>	
		           </td></td>
		        </tr>

		        <tr class="gray">
		    		<td valign="bottom">부서 목록</td>
		    		<td valign="top"></td>
		    		<td valign=bottom>사용자 목록</td>
		    	</tr>
		    	
		        <tr class="gray">
		          
		             <td valign="top" colspan="0">
		             	
		                <div class="tdRel">
		                    <!-- ------------------------------------------ 왼쪽 :S ------------------------------------------- -->
		                                        
							
							<div id="AXGridTarget" style="margin-top:10px;"></div>
		                    <!-- ------------------------------------------ 왼쪽 :E ------------------------------------------- -->
		                </div>
		            </td>
		            
		            
		            <td></td>
		            
		            <td valign="top">
		                <div class="tdRel">
		                    <!-- ------------------------------------------ 오른쪽 :S ------------------------------------------ -->
		                    
		                    
		                    
							<div id="AXGridTarget2" style="margin-top:10px;"></div>
						
							
		                    <div style="float:left;">
							<button type="button" class="AXButton Classic" style="margin-top:3px;" onclick="fnObj.doSaveManager();"><i class="axi axi-content-copy" style="font-size:15px;"></i>&nbsp;부서장 지정</button>&nbsp;
		                    </div>
		                    <!-- ------------------------------------------ 오른쪽 :E ------------------------------------------ -->
		                </div>
		            </td>
		           
		        </tr>
		     </tbody>
		</table>
	</div>

</section>		
	


<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드(외,코드)
var comCodeDeptClass ;				//부서분류


var mySearch = new AXSearch(); 	// instance
var mySearch2 = new AXSearch(); // instance (오른쪽)

var myGrid = new AXGrid(); 		// instance
var myGrid2 = new AXGrid(); 	// instance	(오른쪽)

var selDeptId;
var setUserId;

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
		
		comCodeDeptClass = getBaseCommonCode('DEPT_CLASS', lang, 'CD', 'NM' );						//코드타입 공통코드 (Sync ajax)
		this.addComCodeArray(comCodeDeptClass);
		
		
		<%--	혹시 필요할 수 있을것같아 남김...개발후 삭제!!!!
		//권한코드관리 권한코드 선택메뉴
		<div style="float:left;display:none;"><!-- /////////////////////////// 일단 숨겨놓고 추가하자!!!!!!!!!!!!!!!!!!!!!!! ////////////////// -->														
			<h3>권한코드관리</h3>
			<div id="roleSelectTag"></div>
	    </div>
		//var roleCodeList = this.getRoleCodeList('CD', 'NM', '', '선택');		//권한코드리스트 호출    ........ 어떻게 할지  결정후 진행!!!!!!!!!!!!!!!!!
		var colorObj = {'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
		var roleSelectTag = createSelectTag('selUserRole', comCodeRoleCd, 'CD', 'NM', 'DEVELOP', 'fnObj.changeRoleCode(this);', colorObj);	//select tag creator 함수 호출 (common.js)
		$("#roleSelectTag").html(roleSelectTag);
		--%>
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
   						{label:"검 색", labelWidth:"100", type:"inputText", width:"300", key:"search", placeholder:"검색어입력", addClass:"secondItem", valueBoxStyle:"padding-left:10px;", value:"",
   							onChange: function(changedValue){
   								//아래 2개의 값을 사용 하실 수 있습니다.
   								dialog.push(Object.toJSON(this));
   								dialog.push(changedValue);						
   							}
   						},
   						{label:"부서분류", labelWidth:"100", type:"radioBox", width:"", key:"deptClass", addClass:"secondItem", valueBoxStyle:"", value:"ORG",	//value:"TREE" 기본선택값
							options: comCodeDeptClass,
							onChange: function(selectedObject, value){
								//아래 3개의 값을 사용 하실 수 있습니다.
								//toast.push(Object.toJSON(this));
								//toast.push(Object.toJSON(selectedObject));
								//toast.push(value);
								
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
            
            fixedColSeq : 5,	//컬럼고정 index
            fitToWidth : true,	//true,	//넓이에맞게
            colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"
            
            colHeadTool : false,	//컬럼 display 여부를 설정
            
            height: 500,		//grid height
            
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
                
                {key:"deptId",	 		label:"부서ID", 		width:"50",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"deptClassName",	label:"부서분류", 	width:"90",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"deptCode",		label:"부서코드", 		width:"120",	align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"korName",			label:"한글부서명", 		width:"120",	align:"center"},
                {key:"parentDept", 		label:"상위부서코드", 		width:"90",		align:"center"},                
            ],
            body : {
                onclick: function(){
                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                	//toast.push("<b>내용</b>:\n" + this.item.CONTENT);
                	//alert(JSON.stringify(this));
                	if(this.c == 2 || this.c == 3 || this.c == 4 ){		//메뉴보기
                		//fnObj.viewMenu(this.item.menuId);
                		fnObj.searchUsersPerDept(this.list[this.index]);	//부서정보보기 (부서정보 객체전달)
                		selDeptId = this.list[this.index].deptId;
                	}
                	
                },
                
                ondblclick: function(){
                	//fnObj.viewArticle(this.list[this.index].BOARD_SEQ);
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
    	//=================================================== 왼쪽 :E ======================================================
    	
    		
    	//=================================================== 오른쪽 :S =====================================================
    	//-------------------------- 검색 :S ---------------------------
    	//mySearch2 (오른쪽)
       
    	//-------------------------- 검색 :E ---------------------------
    	
    	//-------------------------- 그리드 :S -------------------------
    	myGrid2.setConfig({
            targetID : "AXGridTarget2",
            theme : "AXGrid",
            
            fixedColSeq : 4,	//컬럼고정 index
            //fitToWidth : true,	//true,	//넓이에맞게
            colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"
            colHeadTool : false,	//컬럼 display 여부를 설정
            height: 500,		//grid height
            
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
                
                {key:"userId", 		label:"ID", 			width:"50",		align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},                
                {key:"userNo", 		label:"사번", 			width:"100",	align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},
                {key:"loginId",		label:"로그인ID",		width:"110",	align:"center",  formatter:function(){return ("<b>" + (this.value) + "</b>");}},                
                {key:"name",		label:"이름", 			width:"65",		align:"center"},
                {key:"empTypeNm",	label:"채용형태", 		width:"65",		align:"center"},
                {key:"company", 	label:"소속회사", 		width:"120",	align:"center"},
                {key:"incharge", 	label:"직책", 			width:"65",		align:"left"},
                {key:"position", 	label:"직위", 			width:"65",		align:"center"},
                {key:"department", 	label:"부서", 			width:"120",	align:"center"},
                {key:"companyTel", 	label:"회사전화", 		width:"95",		align:"center",  formatter:function(){return toPhoneFormat(this.value);}},
                {key:"companyFax", 	label:"회사팩스", 		width:"95",		align:"center",  formatter:function(){return toPhoneFormat(this.value);}},
                
                /*{key:"USER_ROLE", label:"권한 <i class='axi axi-help2'></i>", width:"200", align:"center", sort: false, formatter: function(val){
                		var colorObj = {'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
						return createSelectTag('selUserRole'+(this.index), comCodeRoleCd, 'CD', 'NM', this.item.roleCode, 'fnObj.changeRoleCode(this,' + this.item.userId + ');', colorObj);	//select tag creator 함수 호출 (common.js)
					}
				}*/
                //{key:"USER_ROLE",		label:"권한", 	width:"200",	align:"center"},
            ],
            body : {
                onclick: function(){
                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                	//toast.push("<b>내용</b>:\n" + this.item.CONTENT);
                	//alert(JSON.stringify(this));
                	if(this.c >= 1 && this.c <= 4 ){		//메뉴보기
                		//fnObj.viewMenu(this.item.menuId);
                		//fnObj.viewMenu(this.list[this.index]);	//메뉴정보보기 (메뉴정보 객체전달)
                		selUserId = this.list[this.index].userId;
                		
                	}
                	
                },
                
                ondblclick: function(){
                	//fnObj.viewArticle(this.list[this.index].BOARD_SEQ);
                }
                
            },
			page:{
				paging:false, 
				status:{formatter: null}
			}
            
        });
    	//-------------------------- 그리드 :E -------------------------
    	//=================================================== 오른쪽 :E =====================================================
    	
    },//end pageStart.
  	//################# init function :E #################
    
    
    //################# else function :S #################
    
  //검색
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색
    	
    	var pars = mySearch.getParam();
    	
    	var url = contextRoot + "/system/getDeptList.do";
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
          	
    
    // 선택된 부서 사용자 리스트 조회
    searchUsersPerDept: function(selDeptInfo){		//knd : null - 검색버튼, 숫자 - 페이지검색
    	
    	var url = contextRoot + "/system/getUserListOfDept.do";
    	//var param = mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서
    	var param = {deptCode: selDeptInfo.deptCode};    	
    	
    	
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
    		
    		myGrid2.clearSort();			//소팅초기화
    		myGrid2.setData(gridData);	//그리드에결과반영
    	};
    	
    	commonAjax("POST", url, param, callback);
    },//end doSearch
  
    
    
 	// 부서장 지정
    doSaveManager: function(setDeptInfo, selUserInfo){		//knd : null - 검색버튼, 숫자 - 페이지검색
    	
    	var url = contextRoot + "/system/doSaveManager.do";
    	
    	var param = {
    			deptId: selDeptId, 			// 부서ID
    			manager: selUserId			// 매니저ID
    			};   
    	
    	
    	var callback = function(result){
    		
    		var obj = JSON.parse(result);
    		
    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}
    		
    		var cnt = obj.resultVal;	//결과수
    		
    		if(obj.result == "SUCCESS"){
    			
    			parent.toast.push("저장OK!");
    		}else{
    			//alertMsg();
    		}
    	};
    	
    	commonAjax("POST", url, param, callback);
    },//end doSearch
    
    
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
    
  	//################# else function :E #################
  	
  	
    
};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();		//검색(부서리스트)
});
</script>