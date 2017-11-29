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
	<div class="sys_p_noti mgt20 mgb10">
		<span class="icon_noti"></span><span>권한코드 등록 및 수정은 </span><span class="pointB">권한등록 메뉴</span><span>를 이용하시기 바랍니다.</span>
		<span class="tooltip">
			<a href="javascript:showlayer(code_s_Box)" class="info_type_q">권한코드란?</a>
			<div id="code_s_Box" class="tooltip_box" style="display:none;">
				<h3 class="title">권한코드란?</h3>
				<span class="intext" id="uni_codelist">
					<!-- <p class="excerption">기준일 (2016.10.11)</p> -->
				</span>
				<em class="edge_topcenter"></em>
				<a href="javascript:showlayer(code_s_Box)" class="closebtn"><img src="../images/network/btn_tooltip_closed.gif" alt="닫기"></a>
			</div>
		</span>
	</div>
	<div id="AXGridTarget"></div>
</section>



<script type="text/javascript">

function showlayer(id)
{if(id.style.display == 'none')
	   {id.style.display='block';}
	   else{id.style.display = 'none';}
}

//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드
var roleIdCombo;				//권한Id
var orgCodeCombo;				//ORG 코드

var mySearch = new AXSearch(); 	// instance
var myGrid = new AXGrid(); 		// instance
//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {
	
	//################# init function :S #################
	
	//선로딩코드
	preloadCode: function(){
		
		//권한코드
		var params = {'orgId':'${baseUserLoginInfo.applyOrgId}'};
		roleIdCombo = getCodeInfo(lang, 'CD', 'NM', '', '선택', 'SELECT', '/system/getRoleCodeCombo.do', params);		//권한코드(콤보용) 호출
		if(roleIdCombo == null){
			roleIdCombo = [{'CD': '', 'NM':'선택'}];
		}
		
		//공통코드
		comCodeOrgAccessAuthType = getBaseCommonCode('ORG_ACCESS_AUTH_TYPE', lang, 'CD', 'NM' , null, '', '', {orgId : "${baseUserLoginInfo.applyOrgId}"});	
		
		
		params = {'authOrgId':'Y', 'userId':'${baseUserLoginInfo.userId}'};		//나에게 권한이 있는 관계사만 볼 수 있다 
		orgCodeCombo = getCodeInfo(lang, 'optionValue', 'optionText', null, null, null, '/common/getOrgCodeCombo.do', params);	//ORG코드(콤보용) 호출
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
						{label:"관계사", type:"selectBox", width:"", key:"orgSelBox", addClass:"secondItem", valueBoxStyle:"", value:"${baseUserLoginInfo.applyOrgId}",
							options: orgCodeCombo,
							AXBind:{
								type:"select", config:{
									onChange:function(){   										
										fnObj.doSearch();		//조회
									}
								}
							}
						},
   						{label:"검색", type:"selectBox", width:"", key:"knd", addClass:"secondItem mgl20", valueBoxStyle:"", value:"title",
   							options:[{optionValue:"userName", optionText:"이름"}, {optionValue:"empNo", optionText:"사번"}, {optionValue:"userId", optionText:"아이디"}],
   							AXBind:{
   								type:"select", config:{
   									onChange:function(){
   										//toast.push(Object.toJSON(this));
   										
   									}
   								}
   							}
   						},
   						{label:"", labelWidth:"", type:"inputText", width:"200", key:"search", placeholder:"검색어입력", addClass:"secondItem mgl10", valueBoxStyle:"", value:"",
   							onChange: function(changedValue){
   								//아래 2개의 값을 사용 하실 수 있습니다.
   								dialog.push(Object.toJSON(this));
   								dialog.push(changedValue);						
   							}
   						},
   						{type : "button",  width:"40" ,value : "검색", addClass:"mgl10",
   	   						onClick: function(selectedObject, value){
   								//검색호출
   								fnObj.doSearch();
   							}
      						 
      					}
   						/*,
   						{label:"입력2", labelWidth:"60", type:"inputText", width:"250", key:"inputText2", addClass:"secondItem", valueBoxStyle:"", value:"입력2", title:"타이틀정보",
   							onChange: function(){}
   						}*/
   					]},
			     ]
			
        });//end mySearch.setConfig
    	//-------------------------- 검색 :E ---------------------------
    	
    	//-------------------------- 그리드 :S -------------------------
    	myGrid.setConfig({
            targetID : "AXGridTarget",
            theme : "AXGrid",
            
            fixedColSeq : 3,	//컬럼고정 index
            fitToWidth : true,	//넓이에맞게
            colHeadAlign : "center",	//헤드의 기본 정렬. "left"|"center"|"right"
            
            height: 570,		//grid height
            
            autoChangeGridView: { // autoChangeGridView by browser width
                mobile:[0,600], grid:[600]
            },
            
            //passiveMode:true,
			//passiveRemoveHide:false,
            
            colGroup : [
                {key:"NO", 			label:"NO", 	width:"40", 	align:"center",	sort: false,  formatter:function(){
                	//return (this.list.length - this.index) + ( ( this.page.pageNo - 1) * this.page.pageSize );		//역순
                	return ("<font color=silver><b>" + (this.index + 1) + "</b></font>");
                }},
                
                {key:"name", 		label:"이름", 		width:"130",	align:"center"},                
                {key:"rankNm",		label:"직위", 		width:"70",		align:"center"},
                {key:"oriOrgNm", 	label:"소속관계사", 	width:"130",	align:"center"},
                {key:"orgNm", 		label:"권한관계사", 	width:"180",	align:"left", sort: false, formatter: function(val){
            		
            		var colorObj = {'READ':'#ededed','WRITE':'#FFFFFF'};	//{'1':'#FF9090'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
            		var htmlStr = createSelectTag('selUserRoleRW'+(this.index), comCodeOrgAccessAuthType, 'CD', 'NM', this.item.orgAccessAuthType, 'fnObj.changeRoleCode(this,' + this.index + ',' + this.item.userId + ');', colorObj);	//select tag creator 함수 호출 (common.js)
					return this.value + '&nbsp;&nbsp;&nbsp;&nbsp;' + htmlStr;
					}
				},
                {key:"USER_ROLE", 	label:"권한", width:"150", align:"left", sort: false, formatter: function(val){
	            		
	            		var colorObj = {};	//{'1':'#FF9090'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
	            		var htmlStr = createSelectTag('selUserRole'+(this.index), roleIdCombo, 'CD', 'NM', this.item.roleId, 'fnObj.changeRoleCode(this,' + this.index + ',' + this.item.userId + ');', colorObj);	//select tag creator 함수 호출 (common.js) 
	            		if(isEmpty(this.item.roleId)) htmlStr += '&nbsp;<font color=red>미등록</font>';
						return htmlStr;
					}
				},
                {key:"empNo",		label:"사번", 	width:"120",	align:"center"},
                {key:"loginId", 	label:"아이디", 	width:"150",	align:"center"},
                {key:"mobileTel",	label:"전화", 	width:"100",	align:"center"},
                {key:"email", 		label:"이메일", 	width:"180",	align:"left",  formatter:function(){
                	return (this.value + "&nbsp;&nbsp;&nbsp;");
                }}
                
            ],
            body : {
                onclick: function(){
                    //toast.push(Object.toJSON({index:this.index, item:this.item}));
                	//toast.push("<b>내용</b>:\n" + this.item.CONTENT);
                	//alert(JSON.stringify(this));
                	//if(this.c == 1){
                	//	fnObj.viewArticle(this.list[this.index].BOARD_SEQ);
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
    	
    	
    },//end pageStart.
  	//################# init function :E #################
    
    
    //################# else function :S #################
    
  	//검색
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색 
    	
    	var pars = mySearch.getParam();
    
    	var url = contextRoot + "/system/getUserListByRole.do";
    	var param = mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서
    	param.orgId = param["orgSelBox"];		//orgId key 추가
    	
    	
    	//권한코드 데이터 관계사에 맞게 재세팅
		var params = {'orgId': param.orgId};
		roleIdCombo = getCodeInfo(lang, 'CD', 'NM', '', '선택', 'SELECT', '/system/getRoleCodeCombo.do', params);		//권한코드(콤보용) 호출
    	if(roleIdCombo == null){
    		roleIdCombo = [{'CD':'','NM':'선택'}];
    	}
    	
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
    
    
    //엑셀다운
    excelDownload: function(){    	  
    	 excelDown(myGrid.getExcelFormat('html'), "download");		//common.js    	
    },
    
    
    //권한선택 저장
    changeRoleCode: function(obj, idx, userId){
    	//alert(obj.id + ',' + obj.value + ',userId:' + userId);

    	var url = contextRoot + "/system/changeRoleCode.do";
    	var param = {
    			userRole : $('#selUserRole' + idx).val(),		//obj.value, //roleId
    			userRoleRW : $('#selUserRoleRW' + idx).val(),		//obj.value, //roleId
    			userId: userId,
    			orgId : $("select[name='orgSelBox']").val()
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
    	    	var styleStr = $("#" + obj.id + " > option[value='" + obj.value + "']").attr('style');
    	    	$(obj).attr('style', styleStr);
    	    	
    			
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
    
    //툴팁 세팅
    setTooltip: function(){
    	var tooltipStr = '<ul class="list_st_dot">';
    	for(var i=1; i<roleIdCombo.length; i++){
    		tooltipStr += '<li>'+roleIdCombo[i].NM + " : " + roleIdCombo[i].valueDesc + "</li>";
    	}
    	tooltipStr += '</ul>';
    	
    	$("#uni_codelist").html(tooltipStr);
    	
  		/* AXPopOver.bind({
  	        id:"myPopOver",
  	        theme:"AXPopOverTooltip", 	// 선택항목
  	        width:"200", 				// 선택항목
  	        body:tooltipStr				//"설명입니다.<br/>액시스제이는 이렇게 유용 합니다."
  	    }); */
  		$("#ttipUserRole").bind("mouseover", function(event){
  	        AXPopOver.open({id:"myPopOver", sendObj:{}}, event); // event 직접 연결 방식
  	    });
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
	fnObj.setTooltip();
	
	//검색버튼 동작
	$(".searchButtonItem").on("click", function(){
		fnObj.doSearch();
	});
});
</script>