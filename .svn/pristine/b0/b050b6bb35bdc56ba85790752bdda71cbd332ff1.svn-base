<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/jquery.multisortable.js"></script>
<style>
.selected {background:#eff0f1;/* #f2f2f5; */}
</style>


<!-- 세팅 화면 띄우기위한 폼 -->
<form id="setMenuForm" name="setMenuForm" action="${pageContext.request.contextPath}/system/showPreviewMenu.do" method="POST" target="setMenuForm">
	<input type="hidden" name="menuList" id="menuList"/>
	<input type="hidden" name="copyMenuList" id="copyMenuList"/>
	<input type="hidden" name="roleObj" id="roleObj"/>
	<input type="hidden" name="rowIdx" id="rowIdx"/>
	<input type="hidden" name="openFlag" id="openFlag" value="setting"/>	
</form>


<div class="wrap_select_tree mgt20 mgb20">
	
	<!-- 왼쪽 메뉴리스트 -->
	<div id="copyMenuArea" class="left_block" style="width:55%">
		<h3 class="h3_title_basic mgb10 mgt10 mgl10">선택 메뉴리스트</h3>
		<!-- <div class="sys_p_noti mgt10 mgb5 mgl10"><span class="icon_noti"></span><span class="pointred">GNB 값은 Y</span> 로 설정됩니다.</div> -->
		<table class="board_list_st01 mgt10 mgl10" id="SGridTarget" style="width:95%;">
			<colgroup>
				<col width="50" />
				<col width="50" />
				<col width="150" />
				<col width="*" />
				
			</colgroup>
			<thead>
				<tr>
					<th>레벨</th>
					<th>ID</th>
					<th>메뉴명</th>
					<th>URL</th>
				</tr>
			</thead>
			
			<tbody>
			</tbody>
		</table>
		<div class="mgt10 mgb10">
			<strong class="mgl10 ">레벨변경 :</strong>
			<span class="rd_systemList  mgr10">
				<label><input type="radio" name="rdLevel" value="0" checked="checked"/><span>0</span></label>
	            <label><input type="radio" name="rdLevel" value="1" /><span>1</span></label>
	            <label><input type="radio" name="rdLevel" value="2" /><span>2</span></label>
		     </span> 
		     <button type="button" class="AXButton graarrow_x" onclick="fnObj.chngLevel();"><strong>적용</strong></button>
		</div>          
	</div>
	<!--// 왼쪽 메뉴리스트 //-->
	
	<!--오른쪽 복사 -->
	<div class="right_block" >
		<h3 class="h3_title_basic mgb10 mgt10">복사대상</h3>
		<table class="tb_basic_left" id="roleTable">	<!-- AXFormTable : width 100% >> 98% (재정의) -->
	    	<colgroup>
				<col width="*" />
				<col width="150" />
			</colgroup>
			<tbody>
				<tr>
		 			<td class="txt_center">
		 				<span id="copyResultArea0"></span>
		 				<span id="roleSelectArea0"></span>
		 				<span class="mgl10">
		 					<button type="button" class="AXButton graarrow" onclick="fnObj.getOrgMenuExist(0);">
		 						<i class="axi axi-ion-android-settings" style="font-size:9px;"></i>
		 					</button>
		 				</span>
		 			</td>
		 			<td class="txt_center">
		 				<a href="javascript:fnObj.addRow();" class="btn_s_type_g"><em>추가</em></a>
		 			</td>
		 		</tr>
			</tbody>
		 </table>
	 </div>
	 <!--//오른쪽 복사// -->
</div>	



<script type="text/javascript">

//Global variables :S --------------- 
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드
var roleCodeCombo;					//권한코드

var g_menuType = '${menuType}';				//메뉴타입  (권한별 메뉴 복사 : '', 권한별 탭 복사 : 'TREE')

var g_targetOrgId = "${orgId}";
var g_copyMenuListStr = '${copyMenuList}';	//선택메뉴 리스트
var g_copyMenuList = JSON.parse(g_copyMenuListStr);	//선택메뉴 리스트
var myGrid = new SGrid();

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {
	
	//################# init function :S #################
	
	//선로딩코드
	preloadCode: function(){
		//공통코드
		roleCodeCombo = getCodeInfo(lang, 'CD', 'NM', null, null, null, '/system/getRoleCodeByOrgCombo.do',{ enable : 'Y' });		//관계사별 권한코드(콤보용) 호출
		
		$("#roleSelectArea0").html(fnObj.getRoleList(0)); 
	
	},
	
	
	//화면세팅
    pageStart: function(){
    	
    	//-------------------------- 그리드 :S -------------------------
   	 	var configObj = {
       		columnCountForEmpty : 5,
       		targetID : "SGridTarget",		//그리드의 id

       		//그리드 컬럼 정보
       		colGroup : [
	        		
	                
	                {key:"depth", 		 	formatter:function(obj){return ("<b>" + (obj.item.depth) + "</b>");}},
	                {key:"menuId"},
	                {key:"menuTitleKor"},
	                {key:"menuPath"}
	           ],


               body : {
                   onclick: function(obj, e){
                   	
                   	
                   }
               }
       	};
    	
	   	var rowHtmlStr = '<tr id="left_#[1]">';
	 	rowHtmlStr +=	 '<td class="txt_center">#[0]</td>';
	 	rowHtmlStr +=	 '<td class="b_title" style="cursor:pointer;"><b> #[1] </b></td>';		//td 에 이벤트를 준 케이스
	 	rowHtmlStr +=	 '<td class="b_title" style="cursor:pointer;">#[2]</td>';		//td 에 이벤트를 준 케이스
	 	rowHtmlStr +=	 '<td class="b_title" style="cursor:pointer;">#[3]</td>';		//td 에 이벤트를 준 케이스
	 	rowHtmlStr +=	 '</tr>';
	 	configObj.rowHtmlStr = rowHtmlStr;
	
	
	 	myGrid.setConfig(configObj);
    	
    	
   		//-------------------------- 그리드 :E -------------------------
    	
    },//end pageStart.
  	//################# init function :E #################
  	
  	//왼쪽 세팅
    doSearch : function(){
    	
    	var copyMenuList = JSON.parse(g_copyMenuListStr);
    	
    	var newCopyMenuList = [];
    	for(var i=0;i<copyMenuList.length;i++){
    		copyMenuList[i].newYn = 'Y';
	   		newCopyMenuList.push(copyMenuList[i]);
	   		
    	}
    	
    	var gridData = {list:newCopyMenuList};
		
		myGrid.setGridData(gridData);	//그리드에결과반영
    	
    },
    
  	//레벨 변경
    chngLevel : function(){
    	
    	var list= myGrid.getList();
    	var selectDepth = $(":input:radio[name=rdLevel]:checked").val();
    	var selectList = $(".selected");	//selected 된 리스트
    	
    	
    	for(var i=0;i<selectList.length;i++){
    		
    		var id= ($(selectList[i]).attr('id')).split('_')[1];	
    		var idx = getRowIndexWithValue(list,'menuId',id);		//id 값이 같은 row index
    		list[idx].depth = selectDepth;							//level 변경.
    	}
    	
    	$('.selected').removeClass('selected');
    	myGrid.refresh();	
    	
    },
    
    //순서변경
    moveRow : function(){
    	
    	var sortList = [];
    	var gridList = myGrid.getList();
    	var newGridList = [];
    	
    	var trList = $("#SGridTarget tbody").find('tr');
    	
    	//아이디 리스트 순서대로 
    	for(var i=0;i<trList.length;i++){
    		var id = ($(trList[i]).attr('id')).split('_')[1];
    		sortList.push(id);
    	}
    	
    	//순서에 맞게 그리드 리스트 재 세팅 
    	for(var i=0;i<sortList.length;i++){
    		
    		var menuObj = getRowObjectWithValue(gridList, "menuId", sortList[i]);  
    		newGridList.push(menuObj);
    	
    	}
    	
    	myGrid.setGridData({list:newGridList});	//새로 정렬해서 다시 
    	
    	$('.selected').removeClass('selected');
    },
    
    //################# else function :S #################
    
    //행추가
    addRow : function(){
    	var table = document.getElementById("roleTable");
    	var rowIndex = table.rows.length;      // 테이블(TR) row 개수 행의 idx 를 찾을때 사용.
    	var roleSelect = fnObj.getRoleList(rowIndex);
    	newTr = table.insertRow(rowIndex);
		newTr.id = "newTr" + rowIndex;			 //g_rowId -> 전역변수로 세팅 tr 생성시마다 1증가. (고유 아이디값을 주어 삭제시 삭제하기위해) 이후, 삭제시 해당 tr 삭제.
		//newTd=newTr.insertCell(0);
		
		//두번째 열
		newTd=newTr.insertCell(0);
		newTd.style = "text-align:center";
		newTd.innerHTML= '<span id="copyResultArea'+rowIndex+'"></span><span id="roleSelectArea'+rowIndex+'">' + roleSelect +'</span><span class="mgl10"><button type="button" class="AXButton graarrow" onclick="fnObj.getOrgMenuExist('+rowIndex+');"><i class="axi axi-ion-android-settings" style="font-size:9px;"></i></button></span>';
		
		//세번째 열
		newTd=newTr.insertCell(1);
		newTd.style = "text-align:center";
		newTd.innerHTML='<a href="javascript:fnObj.addRow();" class="btn_s_type_g"><em>추가</em></a> '; //<a href="javascript:fnObj.deleteRow();" class="btn_s_type_g"><em>삭제</em></a>'; 
    	
		
		parent.myModal.resize();
    },
    
    //행삭제
    deleteRow : function(){
    	var table = document.getElementById('roleTable');
        if (table.rows.length < 1) return;
        table.deleteRow( table.rows.length-1 ); // 하단부터 삭제
        
        parent.myModal.resize();
    },
    
    //해당 관계사에 선택 메뉴들을 사용하는지 판별해 선택메뉴 리스트 재 세팅
    getOrgMenuExist : function(idx){
    	
    	var url = contextRoot + "/system/getMenuListByOrg.do";
   		var param = {roleId : $("#selUserRoleDown"+idx).val()};
   		
   		var callback = function(result){
   			
   			var obj = JSON.parse(result);
   			var list = obj.resultList;
   			
   			var selectList = myGrid.getList();
   			var newList = [];
   			var strArr =[];
   			for(var i=0;i<selectList.length;i++){
   				if(getRowObjectWithValue(list, 'menuId', selectList[i].menuId)){
   					newList.push(selectList[i]);
   				}else{
   					strArr.push(selectList[i].menuTitleKor);
   				}
   			}
   			
   			if(strArr.length >0) alert(strArr.join(',') +' 메뉴는 해당 권한의 관계사에 사용 메뉴가 아니기 때문에 제외됩니다.');
   			$("#copyMenuList").val(JSON.stringify(newList));	//선택 메뉴리스트 세팅 
   			
   			fnObj.getMenuListRole(idx);	//해당 role의 메뉴 리스트 세팅
   			
   		};
   		
   		commonAjax("POST", url, param, callback,false);
    },

    //설정 버튼 눌렀을시 role에 해당하는 메뉴를 가져온다
    getMenuListRole : function(idx){
    	
		var roleId = $("#selUserRoleDown"+idx).val();
    	
    	if(roleId == '' || roleId < 1){
    		alert("권한을 선택해 주세요.");
    		return false;
    	}
    	
    	var url = contextRoot + "/system/getMenuByRole.do";
    	var param = { menuLoc : 'TOP'};
    	param.roleId = roleId;
    	
		var callback = function(result){
    		
    		var obj = JSON.parse(result);
    		
    		//세션로그아웃 >> 재로그인
    		if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
    			window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
    			return;
    		}
    		
    		var cnt = obj.resultVal;	//결과수    		
    		var list = obj.resultList;	//결과데이터JSON
    		fnObj.showPreview(list,idx);		//팝업세팅
    		
    	};
    	
    	commonAjax("POST", url, param, callback,false);
    	
    },
    
    
  	//세팅 팝업
  	showPreview : function(menuList,idx){
  		
  		var roleId = $("#selUserRoleDown"+idx).val();
    	var roleObj = getRowObjectWithValue(roleCodeCombo,'roleId',roleId);
    	
    	$("#rowIdx").val(idx);
    	$("#roleObj").val(JSON.stringify(roleObj));
  		$("#menuList").val(JSON.stringify(menuList));
  	
  		var url = contextRoot+"/system/showPreviewMenu.do";
  		var option = "left=" + (screen.width > 1400?"250":"0") + ", top=" + (screen.height > 810?"100":"0") + ", width=1600, height=750, menubar=no, status=no, toolbar=no, location=no, scrollbars=no, resizable=no";
  		window.open('','setMenuForm',option);
  		
  		document.setMenuForm.submit(); // target에 쏜다.
  
  	},
    
    //권한 리스트 세팅 
    getRoleList : function(idx){
    	
    	beforeOrgId = '';
		str = '<select id="selUserRoleDown'+idx+'" class="select_b">';
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
		
		str += '</select>';
		return str;
		
    	
    },
    
    //팝업창 저장 후 결과 받기
    getCopyResult : function(rowIdx){
    	
    	
    	var roleTxt = $("#selUserRoleDown"+rowIdx+' option:selected').text();
    	
    	//체크 표시
    	$("#copyResultArea"+rowIdx).html('<i class="axi axi-ion-checkmark-round" style="color:#60d875;padding-right:5px;font-size:14px;"></i>'+roleTxt);
    	$("#roleSelectArea"+rowIdx).hide();
    }
    
    
    
  	//################# else function :E #################
    
};//end fnObj.



$(function(){
	
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();
	
	$( '#SGridTarget tbody' ).multisortable({
		items: "tr",
	    selectedClass: "selected",
	    sort : function(){},
	    stop: function(event, elem) {
	    	fnObj.moveRow();
	    	
	    }
	});
});


</script>