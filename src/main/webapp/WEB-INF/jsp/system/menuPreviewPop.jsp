<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/jquery.multisortable.js"></script>

<style>

#menuPreview {
    float: none;
    font-size: 12px;
    padding:0px;
    box-sizing: border-box;
    position: relative;
    width:100%;
    overflow-x: scroll;
    overflow-y: auto;
    height:500px; 
}

#menuArea{
    list-style: none;
    margin: 0;
    padding: 0;
    width:100%;
}

.topMenu {
    border-left: #10223c solid 1px;
    border-right: #324d74 solid 1px;
    border-bottom: 2px solid #184aa5;
    vertical-align: middle;
    box-sizing: border-box;
    display: inline-block;
    margin:auto;
    height: 76px;
    text-align: center;
    width:135px;
  
  
}

.subUl {
   
    position: absolute;
    border-bottom-left-radius: 5px;
    border-bottom-right-radius: 5px;
    border: #152F57 solid 1px;
   /*  width: 8.8%; */
    width: 132px;
}

.menuGroup{
	border-top: 1px solid #2b2b4a;
}

.menuSortable > li{
	border-top: 1px dotted #f3f387;
}
.grayFont{
	color:#cacdd2;
}

.existMenu{
	font-size: 13px;
    color: #f7640c;
    font-weight: bold;
}
   


.row_disable_class td{background:#EEE!important;text-decoration: line-through;text-decoration-color:red!important;}
.selected {background:#eff0f1;/* #f2f2f5; */}
</style>

<div class="mgt20" style="overflow: hidden;">
	<div id="copyMenuArea" class="left_block" style="width:30%;padding:0px 20px 0px 20px;float: left;">
		<h3 class="h3_title_basic mgb10 mgt10 ">선택 메뉴리스트</h3>
		<div class="sys_p_noti mgt10"><span class="icon_noti"></span>이미 등록된 메뉴는 선택 리스트에서 제외됩니다.</div>
		<div class="sys_p_noti mgt5 mgb5 "><span class="icon_noti"></span>메뉴는 <strong class="pointred">LV.0</strong> 부터 세팅해주세요.</div>
		<div id="existMenuArea" class="mgb5 existMenu" style="display:none;"></div>
		
		<table class="board_list_st01" id="SGridTarget">
			<colgroup>
				<col width="50" />
				<col width="50" />
				<col width="250" />
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
			<strong>레벨변경 :</strong>
			<span class="rd_systemList  mgr10">
				<label><input type="radio" name="rdLevel" value="0" checked="checked"/><span>0</span></label>
	            <label><input type="radio" name="rdLevel" value="1" /><span>1</span></label>
	            <label><input type="radio" name="rdLevel" value="2" /><span>2</span></label>
		     </span> 
		     <button type="button" class="AXButton graarrow_x" onclick="fnObj.chngLevel();"><strong>적용</strong></button>
		     <button type="button" id="doSetBtn" class="AXButton Classic" onclick="fnObj.setChkBox();" style="float:right;"><i class="axi axi-keyboard-arrow-right"></i>위치수동지정</button>
		     <button type="button" id="doCancelBtn" class="AXButton Red" onclick="fnObj.setRefresh();" style="float:right;"><i class="axi axi-keyboard-arrow-right"></i>반영취소</button>
		     <button type="button" id="doSetTopBtn" class="AXButton Classic" onclick="fnObj.setTopBox();" style="float:right;margin-right: 10px;"><i class="axi axi-keyboard-arrow-right"></i>위치자동지정 (TOP)</button>
		     
	    </div>          
	</div>
	
 	<div class="right_block" style="display: inline-block;width: 65%;">
		<h3 class="h3_title_basic mgb10 mgt10 mgl5" id="roleArea"></h3>
		<div class="sys_p_noti mgt10 mgb5 mgl10"><span class="icon_noti"></span><span class="pointred">노란색</span> 글씨는 GNB 'N' 메뉴 (메뉴 리스트에 노출되지 않는 메뉴) 입니다.<span class="pointred mgl10">연두색</span> 글씨는 모바일 메뉴 입니다.</div>
		<div id="menuPreview"  class="mgb10" style="background: #1b3964;white-space: nowrap;overflow-x: scroll;">
			<ul id="menuArea"></ul>
		</div>
	</div>
	<div class="txt_center" id="btnArea" style="border-top:#cfcfcf solid 1px;padding:40px;">
		<button type="button" class="AXButton Classic" onclick="fnObj.doSave();"><i class="fa fa-check-circle fa-lg"></i> 저장</button>
	</div>
</div>	


<script type="text/javascript">

//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

//공통코드
var g_menuListStr = '${menuList}';
var g_menuList = [];
var g_copyMenuListStr ='${copyMenuList}';
var myGrid = new SGrid();
var g_roleObjStr  = '${roleObj}';
var g_roleObj;

var g_openFlag = '${openFlag}';				//preview - 미리보기 용도 , setting - 권한 메뉴 세팅
var g_changeMenuList = [];

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {
	
	//################# init function :S #################
	
	//선로딩코드
	preloadCode: function(){
		
		g_menuList = JSON.parse(g_menuListStr);
		
		if(g_openFlag != 'preview'){	//권한 메뉴 세팅에서 열었으면
			g_roleObj  = JSON.parse(g_roleObjStr);
	    }else{
	    	$("#btnArea").hide();
	    	$("#copyMenuArea").hide();
	    }
		
	},
	
	
	//화면세팅
    pageStart: function(){
    	
    	
    	//--------------오른쪽 메뉴 UI 세팅
       	$("#doCancelBtn").hide();
       	fnObj.setRightMenuGrid(g_menuList);
    	
       	if(g_openFlag == 'preview') $(".right_block").css('width','100%');
    	
    	if(g_openFlag != 'preview') {	//권한 메뉴 세팅에서 열었으면
    		
    		$("#roleArea").html(g_roleObj.roleNm+' [ '+g_roleObj.orgNm+' ]');
	    	//-----------------------------왼쪽 그리드 :S -------------------------
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
    	
    	}
    	
    },
    
    //왼쪽 세팅
    doSearch : function(){
    	
    	var copyMenuList = JSON.parse(g_copyMenuListStr);
    	var existArr =[];
    	
    	var newCopyMenuList = [];
    	for(var i=0;i<copyMenuList.length;i++){
    	
	   		//이미 리스트에 있다면
	   		if( getRowObjectWithValue(g_menuList, 'menuId' , copyMenuList[i].menuId) != null){
	   			existArr.push(' '+copyMenuList[i].menuTitleKor);
	   		}else{
	   			//copyMenuList[i].basicTreeYn = 'Y';
	   			newCopyMenuList.push(copyMenuList[i]);
	   		}
    	}
    	
    	if(existArr.length >0 ){
    		$("#existMenuArea").html(' <strong> -> 제외 리스트 : </strong>'+existArr.join(",")+' ');
    		$("#existMenuArea").show();
    	}
    	
    	var gridData = {list:newCopyMenuList};
		
		myGrid.setGridData(gridData);	//그리드에결과반영
    	
    },
    
    //오른쪽 세팅
    setRightMenuGrid : function(menuList){
    	
    	var str='';
    	var beforeRoot='-1';
    	var beforeDept='0';
    	var beforeParent='0';
    	var menuCount =0;
    	
    	for(var i=0;i<menuList.length;i++){
    		
			//GNB 메뉴들만 , 사용가능 메뉴들 
			
			//미리보기면 사용 가능한 메뉴들만 세팅
    		if(
    				g_openFlag == 'preview' ?
    				menuList[i].enable == 'Y' && menuList[i].orgEnable == 'Y' : true
    				
    		){
    			
    			var fontColor = '';
				
				if(menuList[i].basicTreeYn == 'N') fontColor = 'style="color:#f5d946;"';
				if(menuList[i].menuType == 'M_TREE') fontColor = 'style="color:#a9ff87;"';
				if(menuList[i].enable == 'N' || menuList[i].orgEnable == 'N') fontColor = 'style="text-decoration: line-through;text-decoration-color:red!important;"';
    		
			
				if(menuList[i].menuRootId != beforeRoot && menuList[i].depth == 0){		//루트메뉴가 바뀌었을때
	    			
	    			if(beforeRoot != 0){
	    				str+='</ul></li>';
	    			}
				
					
					
					str+='<li class="topMenu"><a href="#;" style="color:white;"><span class="mn_icon06" '+fontColor+'>';		//최상위 top 
					
	    			str+='	<input type="radio" name="menuChk" class="depth'+menuList[i].depth+' mgr10" style="display:none;" onclick="fnObj.setPreviewMenu();" value="'+menuList[i].menuId+'" />';
					str+='	<input type="hidden" name="menuIdArr" value="'+menuList[i].menuId+'"/>'+menuList[i].menuTitleKor+'';
					str+='</span></a><ul id="sort'+menuList[i].menuId+'" class="subUl">';
					
					
	    			menuCount =0;
	    			
	    		}else{												//루트메뉴가 같을때
	    			
		    			var childCount = getCountWithValue(menuList, 'menuParentId', menuList[i].menuId);
		    			var parentObj = getRowObjectWithValue(menuList, 'menuId', menuList[i].menuParentId);
		    			
		    			//미리보기면 사용 가능한 메뉴들만 세팅
		    			if(
		        				g_openFlag == 'preview' ?
		        				parentObj.enable == 'Y' && parentObj.orgEnable == 'Y' : true
		        				
		        		){
		    				
		    				
			    			if(childCount>0 && menuList[i].depth == 1){		//하위 메뉴가 있고, 레벨이 1일때
			    				
			    				
			    				
			    				str+='<li style="padding:7px 0 6px 0px;" '+(menuCount !=0 ? 'class="menuGroup"' : '') +'"><a href="#;" style="color:#639df5;"><span '+fontColor+'>';
			    				str+='	<input type="radio" name="menuChk" class="depth'+menuList[i].depth+' mgr10" style="display:none;" onclick="fnObj.setPreviewMenu();" value="'+menuList[i].menuId+'" />';
			    				str+='	<input type="hidden" name="menuIdArr" value="'+menuList[i].menuId+'"/>'+menuList[i].menuTitleKor+'';
			    				str+='</span></a>';
			    				str+='<ul id="sort'+menuList[i].menuId+'">'+fnObj.childNode(menuList,'',menuList[i].menuId)+'</ul></li>';
			    				
			    			}else if(menuList[i].depth == 1){
			    				
			    				str+='<li style="padding:7px 0 6px 0px;" '+(menuCount !=0 ? 'class="menuGroup"' : '') +'"><ul><li><a href="#;"><span class="grayFont" '+fontColor+'>';
			    				str+='	<input type="radio" name="menuChk" class="depth'+menuList[i].depth+' mgr10" style="display:none;" onclick="fnObj.setPreviewMenu();" value="'+menuList[i].menuId+'" />';
			    				str+='	<input type="hidden" name="menuIdArr" value="'+menuList[i].menuId+'"/>'+menuList[i].menuTitleKor+'';
			    				str+='</span></a></li></ul></li>';
				    			
			    			}
		    			
		    			
		    				menuCount++;
		    			}
	    		} 
	    		
	    		beforeRoot = menuList[i].menuRootId; 
	    		beforeDept = menuList[i].depth;
	    		beforeParent = menuList[i].menuParentId;
    		}
		}
		
		str+='</ul></li>';
		if(g_openFlag == 'setting') str+='<li class="topMenu"><a href="#;" style="color:white;" ><span class="mn_icon06"><label><input type="radio" name="menuChk" id="topMenuChk" class="depth mgr10" style="display:none;" onclick="fnObj.setPreviewMenu();"  value="0" />추가</label></span></a></li>';
    	$("#menuArea").html(str);
    },
    
    
    //최하위 노드 세팅
    childNode : function(menuList,str,menuId){
    	
    	
		
    	
    	for(var i=0;i<menuList.length;i++){
    		
    		var fontColor = '';
    		
    		if(menuList[i].basicTreeYn == 'N') fontColor = 'style="color:#f5d946;"';
    		if(menuList[i].enable == 'N' || menuList[i].orgEnable == 'N') fontColor = 'style="text-decoration: line-through;text-decoration-color:red!important;"';
    		
    												//미리보기면 사용 가능한 메뉴들만 세팅
    		if(menuId == menuList[i].menuParentId &&(g_openFlag == 'preview' ?  menuList[i].enable == 'Y' && menuList[i].orgEnable == 'Y' : true) ) { 
    			str += '<li style="text-align:center;padding-top:6px;"><a href="#;" ><span class="grayFont" '+fontColor+'><input type="hidden" name="menuIdArr" value="'+menuList[i].menuId+'"/>'+menuList[i].menuTitleKor+'</span></a></li>';
    		}
    	}
    	
    	return str;
    },
    
    //레벨 변경
    chngLevel : function(){
    	
    	var list= myGrid.getList();
    	var selectDepth = $("input:radio[name=rdLevel]:checked").val();
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
    		if($(trList[i]).attr('id')!=undefined){
    			var id = ($(trList[i]).attr('id')).split('_')[1];
        		sortList.push(id);
    		}
    	}
    	
    	//순서에 맞게 그리드 리스트 재 세팅 
    	for(var i=0;i<sortList.length;i++){
    		
    		var menuObj = getRowObjectWithValue(gridList, "menuId", sortList[i]);  
    		newGridList.push(menuObj);
    	
    	}
    	
    	myGrid.setGridData({list:newGridList});	//새로 정렬해서 다시 
    	
    	$('.selected').removeClass('selected');
    },
    
    //체크박스 세팅 
    setChkBox : function(){
    	
    	$('[name="menuChk"]').hide();
    	
    	var list = myGrid.getList();
    	
    	
    	if(true==fnObj.chkTreeValidate(list)){	//트리적합성 판별 후 
    	
    		//--체크박스 세팅 
	    	var depthArr =[];
	    	for(var i=0;i<list.length;i++){
	    		depthArr.push(list[i].depth);
	    	}
	    	
	    	var maxDepth = Math.max.apply(null, depthArr);
	    	
	    	
	    	//maxDepth 0 -> 1개 2depth 까지 
			if(maxDepth == 0){
				$('.depth1').show();
	    		$('.depth0').show();
	    		$('.depth').show();
	    	}
			//maxDepth 1 -> 2개 1depth 까지 
	    	if(maxDepth == 1){
	    		
	    		$('.depth0').show();
	    		$('.depth').show();
	    	}
	    	
	    	//maxDepth 2  -> 3개 0depth 까지 
	    	if(maxDepth == 2){
	    		$('.depth').show();
	    	}
    	}
    	
    },
    
    //트리 적합성 판별
    chkTreeValidate : function(menulist){
    	
    	var chk= true;
    	
    	
    	var invalIdx = -1;								//부적합한 row index
    	var list = menulist;						
    	var preLevel = -1;								//이전데이터 레벨
    	for(var i=0; i<list.length; i++){
    		if(i == 0){
    			if(list[i].depth * 1>0){					//첫번째는 무조건 0 level
        			invalIdx = i;
        			break;
    			}
    			
    		}else{    			
    			preLevel = list[i-1].depth * 1;				//이전 데이터의 level
        		if(preLevel==0 && list[i].depth * 1==2){	//0 다음에는 1 or 0
        			invalIdx = i;
           			break;
        		}
    		}
    	}
    	
    	if(invalIdx > -1){
    		alertM("부적합한 트리구조가 있습니다!");
    		
    		chk= false;
    	}
    	
    	return chk;
    	
    },
    
    
  	
  	//진짜 메뉴 그리드에 비로소 세팅!!
    setPreviewMenu : function(){
    	
    	var selectMenuParentId= $("input:radio[name=menuChk]:checked").val();	//라디오 버튼 선택 값
    	
    	if(confirm("적용하시겠습니까?")){
    		
    		var list = g_menuList.clone();
    		var selectList = myGrid.getList();
    		
    		var copySelectList =[];
    		
    		
    		
    		//부모없는 최상위 메뉴 세팅 시
    		if(selectMenuParentId == '0'){
    			var chk = getCountWithValue(selectList, 'depth', 0);
    			if(chk >1){
    				alertM("최상위 메뉴 추가시 LEVEL 0 값은 하나만 세팅할 수 있습니다.(하나의 루트메뉴만 세팅할수 있음)");
    				return;
    			}
    		}
    		 
    		
    		//부모로 선택한 노드 객체
    		var parentObj = getRowObjectWithValue(list,'menuId',selectMenuParentId);
    		
    		//부모없는 최상위 메뉴 세팅 시 임의의 부모 객체 생성
    		if(parentObj == null) parentObj={menuId : 0, menuRootId : 0, depth: -1};
    		
    		
    		
    		//선택 메뉴에 루트메뉴와 부모 메뉴 세팅 
    		for(var i=0;i<selectList.length;i++){
    			
    			//-- 리스트 복제가 안되서 노가다함.    
    			var menuObj = {};
    			
    			menuObj.menuId			= selectList[i].menuId;
    			menuObj.menuTitleKor 	= selectList[i].menuTitleKor;
    			menuObj.basicTreeYn 	= selectList[i].basicTreeYn;
    			menuObj.enable 			= selectList[i].enable;
    			menuObj.orgEnable 		= selectList[i].orgEnable;
    			menuObj.newYn	 		= 'Y';						//신규 추가
    			menuObj.childCount 		= selectList[i].childCount;
    			menuObj.chk 			= selectList[i].chk;
    			menuObj.menuClass 		= selectList[i].menuClass;
    			menuObj.menuDesc 		= selectList[i].menuDesc;
    			menuObj.menuEng 		= selectList[i].menuEng;
    			menuObj.menuKor 		= selectList[i].menuKor;
    			menuObj.menuLoc 		= selectList[i].menuLoc;
    			menuObj.path 			= selectList[i].path;
    			menuObj.menuSubPath 	= selectList[i].menuSubPath;
    			menuObj.menuTitleEng 	= selectList[i].menuTitleEng;
    			menuObj.menuTitleKor 	= selectList[i].menuTitleKor;
    			menuObj.menuType 		= selectList[i].menuType;
    			menuObj.menuUpId 		= selectList[i].menuUpId;
    			menuObj.roleMenuId 		= selectList[i].roleMenuId;
    			menuObj.sort 			= selectList[i].sort;
    			
    			if(selectList[i].depth == 0){			//첫번째 LEVEL 노드 
    				menuObj.menuParentId = parentObj.menuId;	//부모 아이디 세팅
    				
    				//depth 세팅
    				var changeDept =  (parentObj.depth == -1 ? selectList[i].depth :  (parseInt(parentObj.depth) + parseInt(selectList[i].depth) + 1));  
    				menuObj.depth = changeDept;
    				
    			}else{									//첫번째 LEVEL 이외 
    				
    				var idx =0;
    				
    				for(var k=0; k<i ; k++){
    					
    					if(selectList[k].depth == parseInt(selectList[i].depth-1)){idx = k;}
    				}
    				
    				menuObj.menuParentId = selectList[idx].menuId.toString(); //부모 아이디 세팅
    				
    				//depth 세팅
    				var changeDept =   parseInt(parentObj.depth)  +  parseInt(selectList[i].depth) + 1;
    				menuObj.depth = changeDept ;
        			
    			}
    			
    			
    			//--root 세팅
    			if(selectMenuParentId!=0) menuObj.menuRootId = parentObj.menuRootId;
    			else{ //최상위
    				
    				if(selectList[i].depth == 0) menuObj.menuRootId = selectList[i].menuId;
        			else menuObj.menuRootId = selectList[0].menuId;
    				
    				
    			}
    			copySelectList.push(menuObj);
    			
    			
    		}
    	
    		
    		//---최종적으로 데이터를 그린다.
    		//일단 부모에 자식중 마지막 idx 
    		var idx = -1;
    		if(selectMenuParentId!=0){		//최상위 top이 아니다.
	    		for(var i=0; i <list.length; i++){		
	    			if(list[i].menuParentId == selectMenuParentId){
	    				idx = i;
	    			}
	    		}
    		}
    		
    		//자식이 없을때 부모의 다음으로 세팅
    		if(idx<0){
    			if(selectMenuParentId ==0) idx=list.length;				//1depth 면 맨 마지막 으로
    			else idx=getRowIndexWithValue(list, 'menuId', selectMenuParentId);
    		}
    		
    		//메뉴 리스트에 추가 해준다
    		for(var i=0; i<copySelectList.length; i++){
    			
    			list=addToArray(list, idx+1, copySelectList[i]);
    			idx++;
    		}
    		
    		
    		fnObj.setRightMenuGrid(list);		//오른쪽 그리드 재 세팅 
    		
    		g_changeMenuList = list;			//바뀐 메뉴를 전역변수에 담아둔다
    		
    		$("#doCancelBtn").show();			//취소버튼 보이기
    		$("#doSetBtn").hide();				//반영버튼 감추기
    		$("#doSetTopBtn").hide();			//반영버튼 감추기(TOP)
    		
    		//--sortable 세팅 
    		
    		$("#sort"+selectMenuParentId).addClass('menuSortable');
    		
    		$( ".menuSortable" ).sortable();
    		$( ".menuSortable" ).disableSelection();
    	    
    	    $(".menuSortable").find('.grayFont').css('color','rgb(243, 243, 236)');
    	}
    },
    
    //저장 버튼 클릭
    doSave : function(){
    	
    	
    	var idArr = $('input[name="menuIdArr"]');
    	var newMenuList = [];
    	
    	
    	//새로  newMenuList (그리드 순서대로)
    	for(var i=0;i<idArr.length;i++){
			
    		var menuObj = getRowObjectWithValue(g_changeMenuList,'menuId',idArr[i].value);
    		if(menuObj!=null) newMenuList.push(menuObj);
		}
    	
    	//------------validation : S
    	if(newMenuList.length<1){
    		alertM("변경된 건이 없습니다.");
    		return false;
    	}
		
    	var newCount = getCountWithValue(newMenuList, "newYn", "Y");	//신규 추가건 갯수
    	if(newCount<0){
    		alertM("변경된 건이 없습니다.");
    		return false;
    	}
    	
    	//------------validation : E
    	
    	//--sort 순서 
    	
    	if(true==fnObj.chkTreeValidate(newMenuList)){	//트리 적합성 판별
    		
    		//------ 정렬 세팅
        	var pArray = [];		//저장을 위해 새로운 배열객체를 만든다.
        	var rObj;				//row object
        	var cntLvl0 = 0;				
        	var cntLvl1 = 0;
        	var cntLvl2 = 0;
        	var preLevel = -1;								//이전데이터 레벨
        	
        	for(var i=0; i<newMenuList.length; i++){
        		
        		///변경 
        		switch(newMenuList[i].depth * 1){					
    				case 0: cntLvl0 ++;
    						cntLvl1 = 0;
    						cntLvl2 = 0;
    						break;
    				case 1: cntLvl1 ++;
    						cntLvl2 = 0;
    						break;
    				case 2: cntLvl2 ++;
    						break;
    			}
        		
        		
        		if(newMenuList[i].depth * 1 == 0){
        			newMenuList[i].sort = (cntLvl0).toString();		
        		}else if(newMenuList[i].depth * 1 == 1){
        			newMenuList[i].sort = (cntLvl1).toString();	
        		}else if(newMenuList[i].depth * 1 == 2){
        			newMenuList[i].sort = (cntLvl2).toString();	
        		}
    			
        	}
        	
        	//-- 정렬 세팅 끝
    	}
    	
    	
    	//저장		
    	var url = contextRoot + "/system/doCopySelectRoleMenuList.do";
    	var param = {
    			menuList: JSON.stringify(newMenuList),			//그리드 데이터 (JSON 문자열)
    			roleId	: g_roleObj.roleId,
    			orgId	: g_roleObj.orgId,
    			menuLoc	: "TOP"								//메뉴위치코드
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
    			
    			alert("저장되었습니다.");
    			opener.fnObj.getCopyResult('${rowIdx}');
    			window.close();
    		}else{
    			
    		}
    		
    	};
    	
    	commonAjax("POST", url, param, callback,false);
    },
    
    //그리드 반영 취소
    setRefresh : function(){
    	
    	fnObj.setRightMenuGrid(g_menuList);	//오른쪽 그리드 재 세팅 
    	g_changeMenuList = g_menuList;		//바뀐 메뉴를 전역변수에 담아둔다
    	
    	$("#doCancelBtn").hide();			//취소버튼 감추기
    	$("#doSetBtn").show();				//반영버튼 보이기
    	$("#doSetTopBtn").show();			//반영버튼 보이기(TOP)
    	
    },
    
    //최상위 버튼 자동세팅
    setTopBox : function(){
		
    	$('[name="menuChk"]').hide();
    	
    	var list = myGrid.getList();
    	
    	if(true == fnObj.chkTreeValidate(list)){	//트리적합성 판별 후 
    	
	    	$("#topMenuChk").prop('checked',true);							//추가버튼 클릭
	    	
	    	fnObj.setPreviewMenu();											//위치 추가 
	    	
	    	$("#menuPreview").scrollLeft($("#menuPreview").width());		//스크롤이동
	    	
    	}
    	
    	
    }
    
    
	
};

$(function(){
	
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	
	if('${openFlag}' != 'preview') {	//권한 메뉴 세팅에서 열었으면
		
		fnObj.doSearch();
		
		$( '#SGridTarget tbody' ).multisortable({
			items: "tr",
		    selectedClass: "selected",
		    sort : function(){},
		    stop: function(event, elem) {
		    	fnObj.moveRow();
		    	
		    }
		});
	}
});


</script>