<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<form name="myForm" method="post">
	<div class="mo_container">
		<table class="tb_basic_left">	<!-- AXFormTable : width 100% >> 98% (재정의) -->
	    	<colgroup>
				<col width="150" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="roleSelectTagTop">복사 원본</label></th>
		 			<td><div id="roleSelectTagTop"></div></td>
		 		</tr>
		 		<tr>
		 			<td colspan="2" class="txt_center"><i class="axi axi-ion-arrow-down-a" style="font-size:20px; color:#d1d1d1;"></i></td>
		 		</tr>
		 		<tr>
		 			<th scope="row"><label for="">복사 대상</label></th>
		 			<td><div id="roleSelectTagDown"></div></td>
		 		</tr>
			</tbody>
		</table>
		<div class="btnZoneBox">
			<button id="btnSave" type="button" onclick="fnObj.trySave();" class="p_blueblack_btn"><strong>복사</strong></button>
		</div>
	</div>
</form>


<script type="text/javascript">

//Global variables :S --------------- 
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드
var roleCodeCombo;					//권한코드

var menuType = '${menuType}';		//메뉴타입  (권한별 메뉴 복사 : '', 권한별 탭 복사 : 'TREE')
var isModule = '${isModule}';		//권한별 모듈 복사 에서 팝업시켰는지 여부 ('YES' or '')
var targetOrgId = "${orgId}";
//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {
	
	//################# init function :S #################
	
	//선로딩코드
	preloadCode: function(){
		//공통코드
		//comCodeRoleCd = getCommonCode('ROLE_CODE', lang, 'CD', 'NM', '', '선택', 'SELECT');		//권한 공통코드 (Sync ajax)
		//roleCodeCombo = getCodeInfo(lang, 'CD', 'NM', '', '선택', 'SELECT', '/system/getRoleCodeCombo.do', { "orgId" : targetOrgId });		//권한코드(콤보용) 호출
		roleCodeCombo = getCodeInfo(lang, 'CD', 'NM', null, null, null, '/system/getRoleCodeByOrgCombo.do',{ enable : 'Y' });		//관계사별 권한코드(콤보용) 호출
		
		//권한코드
		//var roleCodeList = this.getRoleCodeList('CD', 'NM', '', '선택');		//권한코드리스트 호출    ........ 어떻게 할지  결정후 진행!!!!!!!!!!!!!!!!!
	//	var colorObj = {};	//{'DEVELOP':'#F15F5F'};	//{'IT':'#F15F5F', 'ADMIN':'#F2CB61', 'WORK':'#BCE55C', 'USER':'#B2CCFF'};
	//	var roleSelectTagUp = createSelectTag('selUserRoleUp', roleCodeCombo, 'CD', 'NM', '', '', colorObj, 150);	//select tag creator 함수 호출 (common.js)
	//	var roleSelectTagDown = createSelectTag('selUserRoleDown', roleCodeCombo, 'CD', 'NM', '', '', colorObj, 150);	//select tag creator 함수 호출 (common.js)
	//	$("#roleSelectTagTop").html(roleSelectTagUp);
	//	$("#roleSelectTagDown").html(roleSelectTagDown);
		
		
		/*================ 복사원본 SELECT :S ===============*/
		var beforeOrgId = '';
		var str = '<select id="selUserRoleUp" class="select_b" style="height:23px;">';
		str += '<option value="">선택</option>';
		for(var i=0; i< roleCodeCombo.length; i++){
			if(beforeOrgId != roleCodeCombo[i].orgId){
				if(i>0){
					str += '</optgroup>';
				}
				str += '<optgroup label="'+roleCodeCombo[i].orgNm+'">';
			}
			
			str += '<option value="'+roleCodeCombo[i].roleId+'">'+roleCodeCombo[i].roleNm+'</option>';
			
			beforeOrgId = roleCodeCombo[i].orgId;
		}
		if(roleCodeCombo.length>0) str += '</optgroup>';
		
		$("#roleSelectTagTop").html(str);
		/*================ 복사원본 SELECT :E ===============*/
		/*================ 복사대상 SELECT :S ===============*/
		beforeOrgId = '';
		str = '<select id="selUserRoleDown" class="select_b">';
		str += '<option value="">선택</option>';
		for(var i=0; i< roleCodeCombo.length; i++){
			if(beforeOrgId != roleCodeCombo[i].orgId){
				if(i>0){
					str += '</optgroup>';
				}
				str += '<optgroup label="'+roleCodeCombo[i].orgNm+'">';
			}
			
			str += '<option value="'+roleCodeCombo[i].roleId+'">'+roleCodeCombo[i].roleNm+'</option>';
			
			beforeOrgId = roleCodeCombo[i].orgId;
		}
		if(roleCodeCombo.length>0) str += '</optgroup>';
		
		$("#roleSelectTagDown").html(str);
		/*================ 복사대상 SELECT :E ===============*/
		
		
	},
	
	
	//화면세팅
    pageStart: function(){
    	
    	
    },//end pageStart.
  	//################# init function :E #################
    
    
    //################# else function :S #################
        
  	//복사확인
    trySave: function(){
    	
    	//---------------------- validation :S -----------------------
    	var selUserRoleUp = $("#selUserRoleUp");
    	if(selUserRoleUp.val() == '' || selUserRoleUp.val() == 'undefined' ){
    		parent.alertM('복사원본을 선택하시기 바랍니다!', function(){selUserRoleUp.focus();});    		
    		return;		//끝낸다.
    	}
    	var selUserRoleDown = $("#selUserRoleDown");
	    if($("#selUserRoleDown").val() == ''  || selUserRoleDown.val() == 'undefined' ){
			parent.alertM('복사대상을 선택하시기 바랍니다!', function(){selUserRoleDown.focus();});
			return;		//끝낸다.
		}
    	if($("#selUserRoleUp").val() == $("#selUserRoleDown").val()){
    		parent.alertM('원본과 대상이 동일합니다!', function(){selUserRoleDown.focus();});    		
    		return;		//끝낸다.
    	}
    	//---------------------- validation :E -----------------------
    	
    	dialog.push({
		    body:'<b>Caution</b>&nbsp;&nbsp;복사하시겠습니까?', top:0, type:'Caution', buttons:[
                {buttonValue:'복사', buttonClass:'Red', onClick:fnObj.doSave},	//, data:{param:"222"}},	//Red W100
                {buttonValue:'취소', buttonClass:'Blue', onClick:function(){}}	//, data:'data2'}                
		    ]});
    },
    
    
  	//복사(저장)
    doSave: function(){ 
    	
    	var url;		//경로
    	var param;		//파라미터 객체
    	
    	if(isModule == 'YES'){		//권한별 모듈 복사
    		url = contextRoot + "/system/doCopyModuleByRole.do";
        	param = {
        			roleCodeOri:	$("#selUserRoleUp").val(),		//복사원본
        			roleCodeTrgt:	$("#selUserRoleDown").val(),	//복사대상        			
        	};
        	
    	}else{						//권한별 메뉴 복사(menuType:''), 권한별 탭 복사(menuType:'NOTTREE')
    		url = contextRoot + "/system/doCopyMenuByRole.do";
        	param = {
        			roleCodeOri:	$("#selUserRoleUp").val(),		//복사원본
        			roleCodeTrgt:	$("#selUserRoleDown").val(),	//복사대상
        			menuType:		menuType,						//복사할 메뉴의 유형 ('': 메뉴, 'NOTTREE': 탭,버튼)
        			orgId 	: 		targetOrgId
        	};
        	
    	}
    	
    	var callback = function(result){
    			
    		var obj = JSON.parse(result);
    		
    		var cnt = obj.resultVal;	//결과수
    		
    		if(obj.result == "SUCCESS"){
    		
    			parent.mySearch2.setItemValue('roleCode',$("#selUserRoleDown").val());		//저장결과 확인을 위해 복사대상 권한으로 검색조건 세팅
    			parent.mySearch2.setItemValue('menuLoc', 'TOP');							//저장결과 확인을 위해 복사대상 권한으로 검색조건 세팅
    			parent.fnObj.doSearch2();					//목록화면 재조회 호출.
    			parent.myModal.close();						//창 닫기.
    			//parent.dialog.push("등록OK!");	
    			parent.toast.push("저장OK!"); 
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
	//선로딩
	fnObj.preloadCode();
	//화면세팅
	fnObj.pageStart();
	
});

</script>