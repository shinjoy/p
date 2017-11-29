<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="customTagUi" uri="/WEB-INF/tlds/ui.tld"%>

<script type="text/JavaScript" src="${pageContext.request.contextPath}/js/jquery.multisortable.js"></script>

<style>
.row_0_class td{background:#B9E2FA!important;}
.row_1_class td{background:#E8F5FF!important;}
.rowFirst{background-color: #eaf5fd;}
.basicN{background-color: #f8ffef;}
.row_disable_class td{background:#EEE!important;text-decoration: line-through;text-decoration-color:red!important;}
.selected {background:#eff0f1;/* #f2f2f5; */}
.toolBoxArea{

	background: white;
   	margin-left: -138px;
    margin-top: 4px;
    border: #888 solid 1px;
    box-shadow: 5px 5px 3px rgba(0, 0, 0, 0.3);
    padding: 11px;
    }
</style>

<!-- 미리보기 화면 띄우기위한 폼 -->
<form id="previewMenuForm" name="previewMenuForm" action="${pageContext.request.contextPath}/system/showPreviewMenu.do" method="POST" target="previewPop">
	<input type="hidden" name="menuList" id="menuList"/>
	<input type="hidden" name="openFlag" id="openFlag" value="preview"/>
</form>


<section id="detail_contents">
	<form name="myForm" id="myForm">
		<input type="hidden" name="targetOrgId" id="targetOrgId" value="${targetOrgId}">
	</form>
	<div class="sys_halfWrap">
		<div class="fl_halfBox">
			<h3 class="h3_title_basic mgb10">메뉴리스트</h3>
			<div class="sys_search_box">
				<div id="AXSearchTarget" class="fl_block"></div>
			</div>
			<div class="sys_p_noti mgt10 mgb10"><span class="icon_noti"></span><span class="pointB">[등록방법]</span><span> 수정한 메뉴구조를 적용하시려면 재로그인 하시기 바랍니다.</span></div>
			<div class="spending_st_box">
				<span class="scroll_cover"  onclick="javascript:setdayFull('leftTable');"></span>
				<div class="sp_scroll_header">
					<table class="spending_tb_basic " summary="템플릿게시판 (가입일, 제목, 회사명, 자료링크)" >
						<colgroup>
		                   <col width="40" />  	<!-- 번호 -->
		                   <col width="40" /> 	<!-- 체크박스 -->
		                   <col width="40" />	<!-- 아이디 -->
		                   <col width="100" />	<!-- 메뉴타입 -->
		                   <col width="160" />	<!-- 메뉴한글 -->
		                   <col width="*" />	<!-- url-->
	               		</colgroup>
		               <thead>
		                   <tr>
		                   	   <th scope="col" style="padding:10px;">NO</th>
		                       <th scope="col"><input type='checkbox' name='allChkLeft' readonly='true' onclick='fnObj.allCheck(0);' /></th>
		                       <th scope="col">ID</th>
		                       <th scope="col">메뉴타입</th>
		                       <th scope="col">메뉴제목한글</th>
		                       <th scope="col">URL</th>
		                   </tr>
		               </thead>
		               <tbody>
		               	<!-- ////////// 내용 위치 ///////// -->
		           	   </tbody>
	           	   	</table>
	           	</div>
	           	<div class="sp_scroll_body leftTable">
					<table class="spending_tb_basic " id="SGridTarget" summary="템플릿게시판 (가입일, 제목, 회사명, 자료링크)" >
						<colgroup>
		                   <col width="40" />  	<!-- 번호 -->
		                   <col width="40" /> 	<!-- 체크박스 -->
		                   <col width="40" />	<!-- 아이디 -->
		                   <col width="100" />	<!-- 메뉴타입 -->
		                   <col width="160" />	<!-- 메뉴한글 -->
		                   <col width="*" />	<!-- url-->
	               		</colgroup>

		               <tbody>
		               	<!-- ////////// 내용 위치 ///////// -->
		           	   </tbody>
	           	   </table>
	           	</div>
			</div>
		</div>
		<div class="fr_halfBox">
			<h3 class="h3_title_basic mgb10">권한별메뉴등록</h3>
			<div class="sys_search_box">
				<div id="AXSearchTarget2" class="fl_block"></div>

			</div>
			<div class="sys_p_noti mgt10 mgb10"><span class="icon_noti"></span><span class="pointB">[정렬방법]</span><span> 행(단일),Ctrl+행(다중) 클릭 후, drag&drop 을 이용해 정렬을 변경할 수 있습니다.</span> <span class="pointred">(상단메뉴는 'GNB'값이 'Y' 인 메뉴로 구성됩니다)</span></div>


			<!-- <div id="AXGridTarget2"></div> -->

			<div class="spending_st_box">
				<span class="scroll_cover"  onclick="javascript:setdayFull('rightTable');"></span>
				<div class="sp_scroll_header">
					<table class="spending_tb_basic " summary="템플릿게시판 (가입일, 제목, 회사명, 자료링크)" >
						<colgroup>
		                   <col width="40" />  	<!-- 번호 -->
		                   <col width="40" /> 	<!-- 체크박스 -->
		                   <col width="40" /> 	<!-- 레벨 -->
		                   <col width="90" /> 	<!-- 메뉴타입 -->
		                   <col width="200" />	<!-- 트리구조 -->
		                   <col width="40" />	<!-- gnb -->
		                   <col width="*" />	<!-- url -->
		                   <col width="40" />	<!-- id -->
		                   <col width="40" />	<!-- 사용 -->
		                   <col width="40" />	<!-- 사용 -->
	               		</colgroup>
		               <thead>
		                   <tr>
		                   	   <th scope="col" style="padding:10px;">NO</th>
		                       <th scope="col"><input type='checkbox' name='allChkRight' readonly='true' onclick='fnObj.allCheck(1);' /></th>
		                       <th scope="col">레벨</th>
		                       <th scope="col">메뉴타입</th>
		                       <th scope="col">트리구조</th>
		                       <th scope="col">GNB</th>
		                       <th scope="col">URL</th>
		                       <th scope="col">ID</th>
		                       <th scope="col">메뉴<br>사용</th>
		                       <th scope="col">관계사<br>사용</th>
		                   </tr>
		               </thead>
		               <tbody>
		               	<!-- ////////// 내용 위치 ///////// -->
		           	   </tbody>
	           	   	</table>
	           	</div>
	           	<div class="sp_scroll_body rightTable">
					<table class="spending_tb_basic " id="SGridTarget2" summary="템플릿게시판 (가입일, 제목, 회사명, 자료링크)" >
						<colgroup>
		                   <col width="40" />  	<!-- 번호 -->
		                   <col width="40" /> 	<!-- 체크박스 -->
		                   <col width="40" /> 	<!-- 레벨 -->
		                   <col width="90" />	<!-- 메뉴타입 -->
		                   <col width="200" />	<!-- 트리구조 -->
		                   <col width="40" />	<!-- gnb -->
		                   <col width="*" />	<!-- url -->
		                   <col width="40" />	<!-- id -->
		                   <col width="40" />	<!-- 사용 -->
		                   <col width="40" />	<!-- 사용 -->
	               		</colgroup>

		               <tbody>
		               	<!-- ////////// 내용 위치 ///////// -->
		           	   </tbody>
	           	   </table>
	           	</div>
			</div>


			<div class="systemBtn_bothz mgt20">

				<div class="fl_block">
					<span class="sub_title" style="margin-right:3px;">레벨변경 :</span>
					<span class="rd_systemList">
						<label><input type="radio" name="rdLevel" value="0" /><span>0</span></label>
                    	<label><input type="radio" name="rdLevel" value="1" /><span>1</span></label>
                    	<label><input type="radio" name="rdLevel" value="2" /><span>2</span></label>
                    </span>
                    <button type="button" class="AXButton graarrow_x" onclick="fnObj.chngLevel();"><strong>적용</strong></button>

                    <span class="sub_title mgl20" style="margin-right:3px;">메뉴위치이동 :</span>
				    <button type="button" class="AXButton graarrow_x" onclick="fnObj.moveUp();"><i class="axi axi-chevron-up"></i></button>
				    <button type="button" class="AXButton graarrow_x" onclick="fnObj.moveDown();"><i class="axi axi-chevron-down"></i></button>

				    <span class="sub_title mgl20" style="margin-right:3px;">GNB :</span>
					<span class="rd_systemList">
						<label><input type="radio" name="rdBasicTree" value="Y" /><span>Y</span></label>
                    	<label><input type="radio" name="rdBasicTree" value="N" /><span>N</span></label>
                    </span>
                    <button type="button" class="AXButton graarrow_x" onclick="fnObj.chngBasicTree();"><strong>적용</strong></button>


                </div>

            </div>
            <div class="mgt10" style="float:right;">
            	<button type="button" class="AXButton Classic" onclick="fnObj.showPreview();">미리보기</button>
            	<customTagUi:authBtn txt="<i class='axi axi-content-copy'></i> 선택메뉴 복사" orgId="${empty targetOrgId ? baseUserLoginInfo.applyOrgId:targetOrgId}" event="onclick='fnObj.copySelectRole();'" ele="button" classValue="AXButton Classic btn_auth" id="btnSave"/>
            	<customTagUi:authBtn txt="<i class='axi-content-copy'></i> 메뉴 복사" orgId="${empty targetOrgId ? baseUserLoginInfo.applyOrgId:targetOrgId}" event="onclick='fnObj.copyRole();'" ele="button" classValue="AXButton Classic btn_auth" id="btnSave"/>
            	<customTagUi:authBtn txt="<i class='fa fa-check-circle fa-lg'></i> 저장" orgId="${empty targetOrgId ? baseUserLoginInfo.applyOrgId:targetOrgId}" event="onclick='fnObj.doSave();'" ele="button" classValue="AXButton Classic btn_auth" id="btnSave"/>
            </div>
		</div>
		<div class="btn_arrow_halbox" id="mvBtn">
			<button type="button" class="AXButton graarrow " onclick="fnObj.moveLeft();"><i class="axi axi-chevron-left2" style="font-size:12px;"></i></button>
			<button type="button" class="AXButton graarrow" onclick="fnObj.moveRight();"><i class="axi axi-chevron-right2" style="font-size:12px;"></i></button>

			<button type="button" class="AXButton graarrow" onclick="fnObj.allCheck(1);" style="height:26px;" title="체크해제"><i class="axi axi-expand" style="font-size:9px;"></i></button>
			<button type="button" class="AXButton graarrow" onclick="fnObj.showTool();" style="height:26px;" title="상세세팅"><i class="axi axi-ion-android-settings" style="font-size:9px;"></i></button>


			<div id="toolBox" class="toolBoxArea" style="display:none;">
				<a href="#;" onclick="fnObj.showTool();" style="float: right;"><img src="../images/network/btn_tooltip_closed.gif" alt="닫기"></a>
				<div class="mgt10"><strong>레벨</strong></div>
				<div class="rd_systemList">
					<label><input type="radio" name="rdLevel" value="0" /><span>0</span></label>
	                <label><input type="radio" name="rdLevel" value="1" /><span>1</span></label>
	                <label class="mgr10"><input type="radio" name="rdLevel" value="2" /><span>2</span></label>
	            	<input type="button" class="AXButton graarrow_x" onclick="fnObj.chngLevel();" value="적용"/>
				</div>
				<div class="mgt10"><strong>GNB</strong></div>
				<div class="rd_systemList">
					<label><input type="radio" name="rdBasicTree" value="Y" /><span>Y</span></label>
	                <label class="mgr10"><input type="radio" name="rdBasicTree" value="N" /><span>N</span></label>
	                <input type="button" class="AXButton graarrow_x" onclick="fnObj.chngBasicTree();" value="적용"/>

				</div>
			</div>
		</div>
	</div>
</section>



<script type="text/javascript">



function setdayFull(knd){
    	var h = '';
    	if(knd == 'week_allday')
    		h = '99px';
    	else
    		h = '450px';

    	if($('.'+knd).css('max-height') == h)
    		$('.'+knd).css('max-height','none');
    	else
    		$('.'+knd).css('max-height', h);
}



//Global variables :S ---------------
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')
var targetOrgId = "${targetOrgId}";
//공통코드(외,코드)
var roleCodeCombo;				//권한코드
var orgCodeCombo;				//관계사코드

var mySearch = new AXSearch(); 	// instance
var mySearch2 = new AXSearch(); // instance (오른쪽)

var myModal = new AXModal();	// instance

var myGrid = new SGrid();		// instance		new sjs
var myGrid2 = new SGrid(); 	// instance	(오른쪽)

//이동위해 체크한 값 저장 array
var chkDataJar = new Array();
var g_width =0;

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

		var params = {'authOrgId':'Y', 'userId':'${baseUserLoginInfo.userId}'};		//나에게 권한이 있는 관계사만 볼 수 있다
		orgCodeCombo = getCodeInfo(lang, 'optionValue', 'optionText', null, null, null, '/common/getOrgCodeCombo.do', params);	//ORG코드(콤보용) 호출

		roleCodeCombo = getCodeInfo(lang, 'CD', 'NM', null, null, null, '/system/getRoleCodeCombo.do', { 'orgId' : targetOrgId , enable : 'Y' });		//권한코드(콤보용) 호출
		if(roleCodeCombo == null){
			roleCodeCombo = [{ CD : "", NM :"선택"}];
		}

		//'optionValue','optionText' 프로퍼티를 생성하며 값으로 CD, NM 의 값 할당
		this.addComCodeArray(roleCodeCombo);


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
						{label:"관계사", type:"selectBox", width:"", key:"orgId", addClass:"secondItem", valueBoxStyle:"", value:targetOrgId,
							options: orgCodeCombo,
							AXBind:{
								type:"select", config:{
									onChange:function(){
										fnObj.doMove();		//orgID에 해당하는 화면 표시.
									}
								}
							}
						},
   						{type:"inputText", width:"150", key:"search", placeholder:"검색어입력", addClass:"secondItem mgl10", value:"",
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
    	 var configObj = {
        		columnCountForEmpty : 5,
        		targetID : "SGridTarget",		//그리드의 id

        		//그리드 컬럼 정보
        		colGroup : [
	        		{key:"NO", 				formatter:function(obj){
	                								return ("<font color=silver><b>" + (obj.index + 1) + "</b></font>");
	                }},
	                {key:"chk", 			formatter:function(obj){return ("<input type='checkbox' name='mCheckLeft' onclick='fnObj.clickCheckboxL(this, " + obj.index + ");' " + ((obj.item.chk==1)?"checked":"") + " />");}},
	                {key:"menuId", 		 	formatter:function(obj){return ("<b>" + (obj.item.menuId) + "</b>");}},
	                {key:"menuTypeNm"},
	                {key:"menuTitleKor"},
	             	{key:"menuPath"}
                ],


                body : {
                    onclick: function(obj, e){


                    }
                }
            };


        	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */

        	var rowHtmlStr = '<tr>';
        	rowHtmlStr +=	 '<td class="b_num">#[0]</td>';
        	rowHtmlStr +=	 '<td class="b_title" style="cursor:pointer;">#[1]</td>';		//td 에 이벤트를 준 케이스
        	rowHtmlStr +=	 '<td class="b_writer">#[2]</td>';
        	rowHtmlStr +=	 '<td class="b_date">#[3]</td>';
        	rowHtmlStr +=	 '<td class="b_count">#[4]</td>';
        	rowHtmlStr +=	 '<td class="txt_left">#[5]</td>';
            rowHtmlStr +=	 '</tr>';
        	configObj.rowHtmlStr = rowHtmlStr;


        	myGrid.setConfig(configObj);		//그리드 설정정보 세팅

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
    	//=================================================== 왼쪽 :E ======================================================


    	//=================================================== 오른쪽 :S =====================================================
    	//-------------------------- 검색 :S ---------------------------
    	//mySearch2 (오른쪽)
        mySearch2.setConfig({
            targetID : "AXSearchTarget2",
            theme : "AXSearch",

            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },

            onsubmit: function(){	// 버튼이 선언되지 않았거나 submit 개체가 있는 경우 발동 합니다.
				fnObj.doSearch2();
			},

			rows:[
					{display:true, addClass:"", style:"", list:[
   						{label:"권한", type:"selectBox", width:"150", key:"roleId", addClass:"secondItem", value:"title",
   							//options:[{optionValue:"userName", optionText:"이름"}, {optionValue:"userSabun", optionText:"사번"}, {optionValue:"userId", optionText:"아이디"}],
   							options: roleCodeCombo,
   							AXBind:{
   								type:"select", config:{
   									onChange:function(){
   										//toast.push(Object.toJSON(this));
   										fnObj.doSearch2();
   									}
   								}
   							}
   						},

   						{label:"", type:"inputText", width:"150", key:"searchMenu", placeholder:"검색어입력", addClass:"secondItem mgl10" ,value:"",
   							onchange: function(changedValue){
   								//아래 2개의 값을 사용 하실 수 있습니다.
   								dialog.push(Object.toJSON(this));
   								dialog.push(changedValue);
   							}
   						},

   						{type : "button",  width:"40", value : "검색", addClass:"mgl10",
   	   						onClick: function(selectedObject, value){
   								//검색호출
   								fnObj.doSearch2();

   							}

      					}

   					]},
			     ]

        });//end mySearch2.setConfig
    	//-------------------------- 검색 :E ---------------------------

    	//-------------------------- 그리드2 :S -------------------------

        var configObj2 = {
        		columnCountForEmpty : 10,
        		targetID : "SGridTarget2",		//그리드의 id

        		//그리드 컬럼 정보
        		colGroup : [
	        	{key:"NO", 				formatter:function(obj){
                													return ("<font color=silver><b>" + (obj.index + 1) + "</b></font>");
                }},
                {key:"chk", 			formatter:function(obj){
                													if(obj.item.chk == -1) return '';
                													else return ("<label for='chkR"+obj.index+"' style='padding:3px;'><input type='checkbox' name='mCheckRight' id='chkR"+obj.index+"' onclick='fnObj.clickCheckboxR(this, " + obj.index + ");' " + ((obj.item.chk==1)?"checked":"") + " /></label>");
                }},
                {key:"depth",			formatter:function(obj){
																	if(obj.item.depth == 0) 		return "<b>"+obj.item.depth+"</b>";
																	else if(obj.item.depth == 1) 	return "<b>"+obj.item.depth+"</b>";
																	else if(obj.item.depth == 2) 	return "<b>"+obj.item.depth+"</b>";
																	else return "<b>"+obj.item.depth+"</b>";
				}},
				{key:"menuTypeNm"},
                {key:"menuTree",		formatter:function(obj){
																	var levelVal = obj.item.depth;
																	var result = "";
																	var titleKor = '';
																	if(levelVal !=0) result='<span style="padding-left:'+parseInt(15*levelVal)+'px;"></span>';

																	if(obj.item.depth == 0) titleKor = '<span class="titleKor"><strong style="color:#3f64bd;">'+obj.item.menuTitleKor + '</strong></span>' ;
																	else titleKor = '<span class="titleKor">'+obj.item.menuTitleKor+'</span>' ;

																	return (result=="") ? titleKor : result +"┗ "+ titleKor;
				}},

                {key:"basicTreeYn",		formatter:function(obj){
																	if(obj.item.basicTreeYn == 'N')
																		return '<b>'+obj.item.basicTreeYn+'</b>';
																	else
																		return obj.item.basicTreeYn;
				}},
                {key:"menuPath" 		},
                {key:"menuId" 			},
                {key:"enable", 			formatter:function(obj){ return (obj.item.enable == 'N' ? '<b>'+obj.item.enable+'</b>' : obj.item.enable);}},
               	{key:"orgEnable", 		formatter:function(obj){ return (obj.item.orgEnable == 'N' ? '<b>'+obj.item.orgEnable+'</b>' : obj.item.orgEnable);}},
               	{key:"", 				formatter:function(obj){
								               		if(obj.item.enable == 'N' || obj.item.orgEnable == 'N') return "row_disable_class ";		//"gray";


				}}
                ],


                body : {
                	 onclick: function(obj, e){

                     },

                     ondblclick: function(){

                     },
                }
            };


        	/* 그리드 한건 데이터 HTML 포맷 (** 1.tbody 내에 들어갈 tr 태그,  2.#[n] 의 위치에 colGroup 의 순서대로 데이터 세팅) */

        	var rowHtmlStr = '<tr class="#[9]" id="#[7]">';
        	rowHtmlStr +=	 '<td class="b_num">#[0]</td>';
        	rowHtmlStr +=	 '<td class="txt_left" style="cursor:pointer;">#[1]</td>';		//td 에 이벤트를 준 케이스
        	rowHtmlStr +=	 '<td class="b_count">#[2]</td>';
        	rowHtmlStr +=	 '<td class="b_count">#[3]</td>';
        	rowHtmlStr +=	 '<td class="txt_left">#[4]</td>';
        	rowHtmlStr +=	 '<td class="b_count">#[5]</td>';
        	rowHtmlStr +=	 '<td class="b_count"><b>#[6]</b></td>';
        	rowHtmlStr +=	 '<td class="b_count">#[7]</td>';
        	rowHtmlStr +=	 '<td class="b_count">#[8]</td>';
        	rowHtmlStr +=	 '<td class="b_count">#[9]</td>';
            rowHtmlStr +=	 '</tr>';
            configObj2.rowHtmlStr = rowHtmlStr;


        	myGrid2.setConfig(configObj2);		//그리드 설정정보 세팅







    	//-------------------------- 그리드2 :E -------------------------
    	//=================================================== 오른쪽 :E =====================================================





    	//------------- 레벨 변경 버튼 동적이동 ---------------
		var currentPosition = parseInt($("#mvBtn").css("top"));
    	$(window).scroll(function(){
			var position = $(window).scrollTop();
			$("#mvBtn").stop().animate({"top":position+currentPosition+"px"}, 0);
   		});
        //--------------------------------------------------

    },//end pageStart.
  	//################# init function :E #################


    //################# else function :S #################

  	//검색(메뉴리스트)
    doSearch: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	var pars = mySearch.getParam();

    	var url = contextRoot + "/system/getMenuListForOrg.do";
    	var param = mySearch.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서
    	//param.enable = 'Y';	//사용여부 'Y' 인것만 권한별메뉴설정위해 ///////일단 N 도 메뉴설정할 수 있도록 해놓고 바서 바꾸자!!!!!!!!!!!!!!!!!!!!!!!
    	param.allTree = 'Y';	//TREE AND M_TREE 모바일 메뉴도 불러오기 위해

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

    		//myGrid.clearSort();			//소팅초기화
    		myGrid.setGridData(gridData);	//그리드에결과반영
    	};

    	commonAjax("POST", url, param, callback);
    },//end doSearch


  	//검색(권한 위치별 메뉴리스트)
    doSearch2: function(page){		//knd : null - 검색버튼, 숫자 - 페이지검색

    	var pars = mySearch2.getParam();

    	var url = contextRoot + "/system/getMenuByRole.do";
    	var param = mySearch2.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서
    	param.menuLoc = "TOP";
    	param.allTree = 'Y';	//TREE AND M_TREE 모바일 메뉴도 불러오기 위해
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

    		//myGrid2.clearSort();		//소팅초기화
    		myGrid2.setGridData(gridData);	//그리드에결과반영
    		fnObj.searchMenu(param.searchMenu);

    	};

    	commonAjax("POST", url, param, callback);
    },//end doSearch


  	//저장(메뉴구조)
    doSave: function(){

    	//--------------- validation :S ---------------
    	//------ 메뉴 트리구조 적합성
    	var invalIdx = -1;								//부적합한 row index
    	var list = myGrid2.getList();					//그리드 데이터 리스트
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
    		var chkList = document.getElementsByName('mCheckRight');
    		var zIdx = chkList.length/2;		//** AxisJ 의 고정컬럼 그리드에서는 고정컬럼으로 표현되는 부분은 2중으로 겹치게 표현하는것 같다... 따라서 체크박스가 2배수로 생겼다.

    		chkList[zIdx + invalIdx].checked = true;	//부적합한 row 의 체크박스를 체크해서 확인시킨다.

    		return;	//끝낸다
    	}

    	///////정합성 완료


    	//------ 부모아이디, 루트아이디, 정렬값 구해서 세팅
    	var pArray = [];		//저장을 위해 새로운 배열객체를 만든다.
    	var rObj;				//row object
    	var cntLvl0 = 0;
    	var cntLvl1 = 0;
    	var cntLvl2 = 0;
    	var preLevel = -1;								//이전데이터 레벨

    	for(var i=0; i<list.length; i++){
    		rObj = new Object();	//new row object

    		rObj.menuId = list[i].menuId.toString();				//메뉴아이디 key,value 추가
    		rObj.depth  = list[i].depth.toString();					//레벨 key,value 추가
    		rObj.basicTreeYn  = list[i].basicTreeYn.toString();		//기본 트리 메뉴 여부

    		/* switch(list[i].depth * 1){						//해당 레벨의 값을 1증가, 하위는 0 초기화... (cntLvl0 * 100 + cntLvl1 * 10 + cntLvl2) 가 sort(정렬)값이 된다.
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
    		rObj.sort = (cntLvl0 * 10000 + cntLvl1 * 100 + cntLvl2).toString();					// sort 값 세팅 */



    		/* if(i == 0){		//0 level
    			rObj.menuParentId = '';															//부모 id
    			rObj.menuRootId = list[0].menuId.toString();									//루트 id

    		}else{
    			var depth = list[i].depth * 1;			// * 1 은 숫자형으로
    			if(depth == 0){
    				rObj.menuParentId = '';														//부모 id
    				rObj.menuRootId = list[i].menuId.toString();								//루트 id

    			}else if(depth == 1){
    				var tIdx = this.getPreMenuIdOfLvl(i, 0);			//i level 상위의 첫번째 0 level 을 찾는다.
    				rObj.menuParentId = list[tIdx].menuId.toString();							//부모 id
    				rObj.menuRootId   = list[tIdx].menuId.toString();							//루트 id

    			}else{	//(list[i].depth == 2)
    				rObj.menuParentId = list[this.getPreMenuIdOfLvl(i, 1)].menuId.toString();	//부모 id
    				rObj.menuRootId   = list[this.getPreMenuIdOfLvl(i, 0)].menuId.toString();	//루트 id
    			}
    		} */

    		///변경

    		switch(list[i].depth * 1){
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



    		if(list[i].depth * 1 == 0){
    			rObj.sort = (cntLvl0).toString();
    		}else if(list[i].depth * 1 == 1){
    			rObj.sort = (cntLvl1).toString();
    		}else if(list[i].depth * 1 == 2){
    			rObj.sort = (cntLvl2).toString();
    		}


    		if(i == 0){		//0 level
    			rObj.menuParentId = '';															//부모 id
    			rObj.menuRootId = list[0].menuId.toString();									//루트 id

    		}else{
    			var depth = list[i].depth * 1;			// * 1 은 숫자형으로
    			if(depth == 0){
    				rObj.menuParentId = '0';													//부모 id
    				rObj.menuRootId = list[i].menuId.toString();								//루트 id

    			}else if(depth == 1){
    				var tIdx = this.getPreMenuIdOfLvl(i, 0);									//i level 상위의 첫번째 0 level 을 찾는다.
    				rObj.menuParentId = list[tIdx].menuId.toString();							//부모 id
    				rObj.menuRootId   = list[tIdx].menuId.toString();							//루트 id

    			}else{	//(list[i].depth == 2)
    				rObj.menuParentId = list[this.getPreMenuIdOfLvl(i, 1)].menuId.toString();	//부모 id
    				rObj.menuRootId   = list[this.getPreMenuIdOfLvl(i, 0)].menuId.toString();	//루트 id
    			}
    		}

    		//// 객체 추가
    		pArray.push(rObj);
    	}


    	//--------------- validation :E ---------------


    	//저장
    	var sObj = mySearch2.getParam().queryToObjectDec();	//query string 을 객체로 바꿔준다.		*queryToObjectDec 디코딩해서


    	var url = contextRoot + "/system/doSaveMenuByRole.do";
    	var param = {
    			pList	: JSON.stringify(pArray),			//그리드 데이터 (JSON 문자열)
    			roleId	: $("select[name='roleId']").val(),
    			orgId	: $("select[name='orgId']").val(),
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

    			//parent.fnObj.doSearch(parent.curPageNo);	//목록화면 재조회 호출.
    			//parent.myModal.close();						//글쓰기 창 닫기.
    			//parent.dialog.push("등록OK!");
    			parent.toast.push("저장OK!");
    		}else{
    			//alertMsg();
    		}

    	};

    	commonAjax("POST", url, param, callback);


    },//end doSave


    //권한별메뉴복사
    copyRole: function(){
    	var url = "<c:url value='/system/copyRole.do'/>";
    	var params = { orgId : $("select[name='orgId']").val() };	//{mode:'new'};	//"btype=1&cate=1".queryToObject();		//게시판유형(board_type), 게시판 카테고리 를 넘긴다.

    	myModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '권한별 메뉴 복사',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: $(window).scrollTop() + 200,
    		width: 500,
    		closeByEscKey: true				//esc 키로 닫기
    	});

    	$('#myModalCT').draggable();
    },

    //선택권한별메뉴복사
    copySelectRole: function(){

    	var list = fnObj.setList();			//리스트 재 새팅. (parent, root 세팅)

    	var checkMenuList = [];
    	var menuRootIdGroup = 0;

    	//-- 체크 메뉴 리스트 선별
    	for(var i =0 ; i<list.length; i++){
    		//체크가 되어있으면
    		if(list[i].chk == 1){
    			checkMenuList.push(list[i]);
    		}
    	}

    	//-- 체크 메뉴 리스트 유효성 검사
    	if(checkMenuList.length != 0){
	    	var newMenuList = [];
    		var menuRootId =checkMenuList[0].menuRootId;
	    	for(var i=0;i<checkMenuList.length;i++){
	    		if(checkMenuList[i].menuRootId != menuRootId){
	    			alertM("같은 그룹 내에서 선택해 주세요.");
	        		return false;
	    		}
	    		if(checkMenuList[i].enable == 'Y') newMenuList.push(checkMenuList[i]);
	    		else{
	    			alertM("메뉴 사용여부가 N인 메뉴는 복사 할 수없습니다.");
	        		return false;
	    		}

	    	}
    	}else{
    		alertM("복사할 메뉴를 선택해 주세요.");
    		return false;
    	}


    	var url = "<c:url value='/system/copySelectRole.do'/>";
    	var params = { orgId : $("select[name='orgId']").val(), copyMenuList : JSON.stringify(newMenuList) };	//{mode:'new'};	//"btype=1&cate=1".queryToObject();		//게시판유형(board_type), 게시판 카테고리 를 넘긴다.

    	myModal.open({
    		url: url,
    		pars: params,
    		titleBarText: '권한별 선택 메뉴 복사',		//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
    		method:"POST",
    		top: $(window).scrollTop() + 200,
    		width: 1000,
    		closeByEscKey: true				//esc 키로 닫기
    	});

    	$('#myModalCT').draggable();
    },


    //상위 메뉴 index 가져오기 (첫번째 해당 level)
    getPreMenuIdOfLvl: function(baseIdx, trgtLvl){		//baseIdx: 기준index, trgtLvl: 찾으려는 level
    	var list = myGrid2.getList();					//그리드 데이터 리스트
    	var preLevel = -1;								//이전데이터 레벨
    	for(var i=baseIdx-1; i>=0; i--){
    		if(list[i].depth * 1 == trgtLvl) return i;
    	}
    },

  	//동일 형제의 sort 순서
    getSortByDept : function(baseIdx, trgtLvl){

    	var list = myGrid2.getList();					//그리드 데이터 리스트
    	var preLevel = -1;								//이전데이터 레벨
    	for(var i=baseIdx-1; i>=0; i--){
    		if(list[i].depth * 1 == trgtLvl) return i;
    	}

    },


    //배열에 새로운 인자로 추가 (공통코드 이상문제해결)
    addComCodeArray: function(obj){
		for(var i=0; i<obj.length; i++){
			obj[i].optionValue = obj[i].CD;		//'optionValue' 프로퍼티를 생성하며 값으로 CD 의 값 할당
			obj[i].optionText  = obj[i].NM;		//'optionText'  프로퍼티를 생성하며 값으로 NM 의 값 할당
		}
    },

  	//권한코드리스트 호출 --- 사용 안함.
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


    //오른쪽으로 이동 (메뉴리스트 >> 권한별메뉴등록)
    moveRight: function(){
    	var leftList = myGrid.getList();								//왼쪽   그리드 데이터

    	var chkCnt = 0;			//이동을 위해 체크한 수
    	var chkIndex = -1;		//체크한 row index
    	var moveObj;			//체크해서 이동할 row Object
    	for(var i=0; i<leftList.length; i++){
    		if(leftList[i].chk == 1){	//체크되어 있는 것을
    			chkCnt++;
    			moveObj = leftList[i];									//이동할 row data

    			if(!fnObj.checkMoveRight(moveObj, myGrid2.getList())){
    				continue;
    			}

    			//추가(key,value)
    			moveObj.depth = 0;
    			moveObj.sort = 100;
    			moveObj.menuLoc = mySearch2.getParam().queryToObjectDec().menuLoc;		//메뉴위치 코드
    			moveObj.menuRootId = moveObj.menuId;
    			moveObj.menuTypeNm = moveObj.menuTypeNm;
    			moveObj.basicTreeYn = 'Y';								//GNB 여부 기본 'Y'

    			myGrid2.getList().push(moveObj);								//오른쪽 그리드에 추가
    		}
    	}

    	if(chkCnt == 0){
    		alertM("이동할 메뉴를 먼저 선택해주세요!");
    		return;
    	}

    	//그리드 싱크 ....pushList 는 싱크도 되는듯
    	//myGrid.dataSync();
    	//myGrid2.dataSync();
    	myGrid2.refresh();
    	//그리드 사이즈 변경(데이터에 맞게)
    	//myGrid2.setHeight(myGrid2.getList().length * 35 + 50);
    	/* if($('#' + myGrid2.config.targetID + '_FullSizeButton').hasClass('open')){
    		$('#' + myGrid2.config.targetID + '_FullSizeButton').click();
    	} */

    	//setdayFull('');
    	$('.rightTable').css('max-height','none');


    },
    //메뉴 아이디를 체크하여 오른쪽 그리드 추가 여부 체크
    checkMoveRight : function(obj, list){
    	var moveYn = true;
    	for(var i = 0 ;i < list.length ;i++){
    		var item = list[i];
    		if(item.menuId == obj.menuId){
    			moveYn = false;
    		}
    	}

    	return moveYn;
    },
  	//왼쪽으로 이동 (메뉴리스트 << 권한별메뉴등록) ... 실제는 삭제로 구현
    moveLeft: function(){
    	var rightList = myGrid2.getList();								//오른쪽 그리드 데이터

    	var chkCnt = 0;			//이동을 위해 체크한 수
    	var chkIndex = -1;		//체크한 row index
    	var moveObj;			//체크해서 이동할 row Object
    	for(var i=rightList.length-1; i>=0; i--){
    		if(rightList[i].chk == 1){	//체크되어 있는 것을
    			chkCnt++;
    			rightList.splice(i, 1);									//체크 요소를 삭제
    		}

    	}

    	if(chkCnt == 0){
    		alertM("이동할 메뉴를 먼저 선택해주세요!");
    		return;
    	}

    	//그리드 싱크
    	//myGrid.dataSync();
    	//myGrid2.dataSync();
    	//myGrid2.redrawGrid();	//하단 상태바 count(s) 숫자도 반영되게하려면 redrawGrid().
    	myGrid2.refresh();

    },


    //레벨변경
    chngLevel: function(){

    	//변경할 레벨값확인
    	var rdLevel = document.getElementsByName('rdLevel');
    	var toLevel = -1;
    	for(var i=0; i<rdLevel.length; i++){
    		if(rdLevel[i].checked) toLevel = rdLevel[i].value;
    	}
    	if(toLevel == -1){
    		alertM("변경하실 레벨을 선택해주세요!");
    		return;
    	}


    	//레벨변경
    	var list = myGrid2.getList();		//권한별메뉴리스트

    	for(var i=0; i<list.length; i++){	//초기 위엣처럼 보여지는 체크박스를 기준으로 하였다가, chk 값을 기준으로 하였다.
    		if(list[i].chk == 1){
    			list[i].depth = toLevel;		//레벨 변경(선택한 레벨로)
    		}

    	}

    	myGrid2.refresh();			//변경한 데이터로 화면에서 보이도록 (DB미적용)
    },


  	//체크박스 체크 validation (위,아래 이동)
	checkChkValidUpDown: function(knd){		//knd ... 'UP' : 위에서 부터 담기(index 작은것부터), 'DOWN': 아래것 부터 담기 (index 큰것부터)

    	var list = myGrid2.getList();		// --- 초기 위에처럼 보이는 체크박스의 데이터로 이동하였지만 이상현상으로 chk 데이터를 가지고 이동
    	var chkCnt = 0;
    	var chkIndex = -1;

    	if(knd == 'UP'){
    		for(var i=0; i<list.length; i++){
        		if(list[i].chk == 1){
        			chkCnt++;
        			chkIndex = i;
        			chkDataJar.push(chkIndex);
        		}
        	}

    	}else{	//knd == 'DOWN'
    		for(var i=list.length-1; i>=0; i--){
        		if(list[i].chk == 1){
        			chkCnt++;
        			chkIndex = i;
        			chkDataJar.push(chkIndex);
        		}
        	}
    	}


    	if(chkCnt==0){
    		alertM("이동할 메뉴를 먼저 선택해주세요!");
    		return -1;
    	}else{
    		return 1;		//valid
    	}

    },


    //메뉴위치 위로
    moveUp: function(){

    	chkDataJar = new Array();		//초기화.


    	//체크박스 체크 validation
    	var chk = this.checkChkValidUpDown('UP');	//체크한 것 담기 ... 'UP' : 위에서 부터 담기(index 작은것부터)
    	if(chk == -1){			//false(체크된것이 없다)
    		return;				//끝낸다.
    	}


    	/////////////////// 이동 ///////////////////
    	for(var i=0; i<chkDataJar.length; i++){

    		var chkIndex = chkDataJar[i];			//체크한 것 빼서

    		var list = myGrid2.getList();
        	if(chkIndex == 0){						//이미 처음 index
        		return;
        	}

        	var chkObj = list[chkIndex];			//이동할 배열객체를 담고
        	list.splice(chkIndex, 1);				//chkIndex 요소를 원본에서 삭제

        	var toIndex = chkIndex - 1;				//위로 1칸

        	myGrid2.setGridData({list:addToArray(list, toIndex, chkObj)});	//이동할 위치로 이동후 그리드에 세팅.
    	}

    },


  	//메뉴위치 아래로
    moveDown: function(){

		chkDataJar = new Array();		//초기화.


    	//체크박스 체크 validation
    	var chk = this.checkChkValidUpDown('DOWN');	//체크한 것 담기 ... 'UP' : 위에서 부터 담기(index 작은것부터)
    	if(chk == -1){			//false(체크된것이 없다)
    		return;				//끝낸다.
    	}


    	/////////////////// 이동 ///////////////////
    	for(var i=0; i<chkDataJar.length; i++){

    		var chkIndex = chkDataJar[i];			//체크한 것 빼서

	    	var list = myGrid2.getList();
	    	if(chkIndex == (list.length-1)){		//이미 마지막 index
	    		return;
	    	}


	    	var chkObj = list[chkIndex];			//이동할 배열객체를 담고
	    	list.splice(chkIndex, 1);				//chkIndex 요소를 원본에서 삭제

	    	var toIndex = chkIndex + 1;				//아래로 1칸

	    	myGrid2.setGridData({list:addToArray(list, toIndex, chkObj)});	//이동할 위치로 이동
	    	//myGrid2.dataSync();						//그리드 data sync (화면)
    	}

    },

    //sortable 이동
    moveSet	: function(){
    	var sortList = [];
    	var gridList = myGrid2.getList();
    	var newGridList = [];

    	var trList = $("#SGridTarget2 tbody").find('tr');

    	//아이디 리스트 순서대로
    	for(var i=0;i<trList.length;i++){
    		var id = $(trList[i]).attr('id');
    		sortList.push(id);
    	}

    	//순서에 맞게 그리드 리스트 재 세팅
    	for(var i=0;i<sortList.length;i++){

    		var menuObj = getRowObjectWithValue(gridList, "menuId", sortList[i]);

    		newGridList.push(menuObj);

    	}

    	myGrid2.setGridData({list:newGridList});	//새로 정렬해서 다시

    },


  	//기본 트리 메뉴 여부 설정
    chngBasicTree: function(){

    	//변경할 기본여부값(GNB) 확인
    	var rdBasicTree = document.getElementsByName('rdBasicTree');	//기본 라디오 테그들
    	var toYn = '';
    	for(var i=0; i<rdBasicTree.length; i++){
    		if(rdBasicTree[i].checked) toYn = rdBasicTree[i].value;
    	}
    	if(toYn == ''){
    		alertM("변경하실 GNB값(Y/N)을 선택해주세요!");
    		return;
    	}


    	//GNB 값을 'Y' 로 바꾸려는 경우, 부모가 'N' 인경우에는 안되도록
    	var list = myGrid2.getList();			//권한별메뉴리스트
    	var bsLvl = 10;		//기준 레벨(임의의 큰값 10)

    	var chkEnable = false;

    	for(var i=0; i<list.length; i++){

    		//기준레벨 세팅
    		if(list[i].depth <= bsLvl){			//같거나 상위레벨

    			chkEnable = true;

    			if(toYn == 'N' && list[i].chk == 1){					//N 으로 바꿀때는 체크한것이 기준레벨
    				bsLvl = list[i].depth;		//기준레벨 세팅
    			}else if(toYn == 'Y' && list[i].basicTreeYn == 'N'){	//Y 로 바꿀때는 GNB값이 N 인 것이 기준레벨
    				bsLvl = list[i].depth;		//기준레벨 세팅
    			}else{
    				bsLvl = 10;
    			}
    		}

    		//값 변경
    		if(toYn == 'N'){
    			if(list[i].depth > bsLvl || list[i].chk == 1){
    				list[i].basicTreeYn = toYn;		//GNB 값 변경(선택한 GNB값(Y/N)으로)
    				//if(!chkEnable) list[i].chk = -1;
    			}
    		}else{
    			if(list[i].depth <= bsLvl && list[i].chk == 1){
    				list[i].basicTreeYn = toYn;		//GNB 값 변경(선택한 GNB값(Y/N)으로)
    				bsLvl = 10;						//초기화
    			}
    		}
    	}

    	/*
    	//값 변경
    	var list = myGrid2.getList();			//권한별메뉴리스트
    	var bsLvl = 10;		//기준 레벨

    	for(var i=0; i<list.length; i++){

    		if(list[i].depth <= bsLvl){			//같거나 상위레벨
    			if(list[i].chk == 1){
    				bsLvl = list[i].depth;		//기준레벨 세팅
    			}else{
    				bsLvl = 10;
    			}
    		}

    		if(list[i].depth > bsLvl){
    			//if(toYn == 'N')
    				list[i].basicTreeYn = toYn;		//기본(상단)값 변경(선택한 상단값(Y/N)으로)
    		}

    		if(list[i].chk == 1){	// && list[i].depth >= bsLvl){
    			//bsLvl = list[i].depth;			//기준레벨 세팅
    			list[i].basicTreeYn = toYn;		//기본(상단)값 변경(선택한 상단값(Y/N)으로)
    		}
    	}
    	 */


    	myGrid2.refresh();			//변경한 데이터로 화면에서 보이도록 (DB미적용)
    },


    //마우스 오버 텍스트 하이라이트
    mouseoverBtn: function(knd){
    	//초기화
    	//$('.txt_btn').css('background-color', 'white');
    	//하이라이트
    	$('.' + knd).css('color', 'red');
    	$('.' + knd).css('font-weight', 'bold');
    },
 	//마우스 아웃 텍스트 하이라이트 초기화
    mouseoutBtn: function(knd){
    	//초기화
    	$('.txt_btn').css('color', 'black');
    	$('.' + knd).css('font-weight', 'normal');
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


    //왼쪽 그리드 체크박스 클릭 이벤트 핸들러 (그리드 data Sync)
    clickCheckboxL: function(obj, idx){
    	var list = myGrid.getList();
    	if(obj.checked){
    		list[idx].chk = 1;
    	}else{
    		list[idx].chk = 0;
    	}
    },

  	//오른쪽 그리드 체크박스 클릭 이벤트 핸들러 (그리드 data Sync)
    clickCheckboxR: function(obj, idx){
    	var list = myGrid2.getList();
    	if(obj.checked){
    		list[idx].chk = 1;
    	}else{
    		list[idx].chk = 0;
    	}
    },

    //체크박스 전체 체크
    allCheck: function(knd){
    	if(knd == 0){	//왼쪽 그리드
    		/* var chkList = document.getElementsByName('mCheckLeft');
    		var list = myGrid.getList();
    		var addIdx = chkList.length/2;
    		var toBe = document.getElementsByName('allChkLeft')[1].checked;
    		for(var i=chkList.length/2; i<chkList.length; i++){
        		chkList[i].checked = toBe;		//체크여부
        		list[i-addIdx].chk = toBe?1:0;	//그리드데이터도 함께 변환(아직 그리드 데이터는 변하지 않은 상태이기때문에)
        	} */


    		var list = myGrid.getList();
    		var toBe = document.getElementsByName('allChkLeft')[0].checked;
    		for(var i=0; i<list.length; i++){
        		list[i].chk = toBe?1:0;	//그리드데이터도 함께 변환(아직 그리드 데이터는 변하지 않은 상태이기때문에)
        	}

    		myGrid.refresh();
    		document.getElementsByName('allChkLeft')[0].checked = toBe;

    	}else{	// knd == 1 오른쪽
    		/* var chkList = document.getElementsByName('mCheckRight');
    		var list = myGrid2.getList();
    		var addIdx = chkList.length/2;
    		var toBe = document.getElementsByName('allChkRight')[1].checked;
    		for(var i=chkList.length/2; i<chkList.length; i++){
        		chkList[i].checked = toBe;		//체크여부
        		list[i-addIdx].chk = toBe?1:0;	//그리드데이터도 함께 변환(아직 그리드 데이터는 변하지 않은 상태이기때문에)
        	} */


    		var list = myGrid2.getList();
    		var toBe = document.getElementsByName('allChkRight')[0].checked;
    		for(var i=0; i<list.length; i++){
        		list[i].chk = toBe?1:0;	//그리드데이터도 함께 변환(아직 그리드 데이터는 변하지 않은 상태이기때문에)
        	}

    		myGrid2.refresh();
    		document.getElementsByName('allChkRight')[0].checked = toBe;

    	}
    },


    //오른쪽 체크박스 전체 해지
    uncheckAll: function(){
    	var chkList = document.getElementsByName('mCheckRight');
    	var list = myGrid2.getList();
    	var addIdx = chkList.length/2;
    	for(var i=chkList.length/2; i<chkList.length; i++){
    		chkList[i].checked = false;		//체크해지
    		list[i-addIdx].chk = 0;			//그리드데이터도 함께 변환(아직 그리드 데이터는 변하지 않은 상태이기때문에)
    	}
    },


  	//상단메뉴와 동일하게 복사 시도	  ****참조!! 현재는 상단메뉴를 가지고 좌측메뉴 카피만을 고려해서 만들었는데, 우측 이나 하단 도 간단히 수정하여 가능
    tryCopyByTop: function(){

    	dialog.push({
    	    body:'<b>Caution</b>&nbsp;&nbsp;복사하시겠습니까?', top:250, type:'Caution', buttons:[
                {buttonValue:'복사', buttonClass:'Red', onClick:fnObj.doCopyByTop},	//, data:{param:"222"}},	//Red W100
                {buttonValue:'취소', buttonClass:'Blue', onClick:function(){}}	//, data:'data2'},
                //{buttonValue:'button3', buttonClass:'Green', onClick:fnObj.btnClick, data:'data3'}
    	    ]});

    },

    //상단메뉴와 동일하게 복사
    doCopyByTop: function(){

		var url = contextRoot + "/system/doCopyByTop.do";
		var param = mySearch2.getParam().queryToObjectDec();

		var callback = function(result){

			var obj = JSON.parse(result);

			//세션로그아웃 >> 재로그인
			if(obj.result=='FAIL' && obj.resultVal=='SESSION'){
				window.open('<c:url value="/login/loginPop.do" />', 'loginPop', 'width=500 height=200');
				return;
			}

			var cnt = obj.resultVal;	//결과수

			if(obj.result == "SUCCESS"){
				fnObj.doSearch2();				//목록화면 재조회 호출.

				//parent.dialog.push("등록OK!");
				toast.push("복사OK!");
			}else{
				//alertMsg();
			}

		};

		commonAjax("POST", url, param, callback);

	},
	//관계사 바뀔 때마다 로드
	doMove : function(){
		$("#targetOrgId").val($("select[name='orgId']").val());
		$('#myForm').attr("method", "post").attr('action', contextRoot + "/system/menuPerRole.do").submit();
	},

	//가운데 도구
	showTool : function(){

		if($("#toolBox").css("display") == "none") $("#toolBox").show();
		else $("#toolBox").hide();
	},



  	//################# else function :E #################

  	//리스트 세팅
  	setList : function(){

  		var list = myGrid2.getList();
  		var menuList = list.clone();
  		var topCnt =1;
  		for(var i=0;i<menuList.length;i++){


  			if(i == 0){		//0 level
  				menuList[i].menuParentId = '';															//부모 id
  				menuList[i].menuRootId = list[0].menuId.toString();									//루트 id

    		}else{
    			var depth = list[i].depth * 1;			// * 1 은 숫자형으로
    			if(depth == 0){
    				menuList[i].menuParentId = '0';													//부모 id
    				menuList[i].menuRootId = list[i].menuId.toString();								//루트 id
    				//if(menuList[i].basicTreeYn == 'Y')
    				topCnt++;
    			}else if(depth == 1){
    				var tIdx = this.getPreMenuIdOfLvl(i, 0);									//i level 상위의 첫번째 0 level 을 찾는다.
    				menuList[i].menuParentId = list[tIdx].menuId.toString();							//부모 id
    				menuList[i].menuRootId   = list[tIdx].menuId.toString();							//루트 id

    			}else{	//(list[i].depth == 2)
    				menuList[i].menuParentId = list[this.getPreMenuIdOfLvl(i, 1)].menuId.toString();	//부모 id
    				menuList[i].menuRootId   = list[this.getPreMenuIdOfLvl(i, 0)].menuId.toString();	//루트 id
    			}
    		}
  		}

  		g_width = topCnt*130;
  		if(g_width < 1000) g_width=1000;


  		return menuList;

  	},

  	//미리보기
  	showPreview : function(){

  		var list = fnObj.setList();				//리스트를 재 세팅 한다. menuParent,menuRoot 추가 해서.

  		$("#menuList").val(JSON.stringify(list));

  		var url = contextRoot+"/system/showPreviewMenu.do";
  		var option = "left=" + (screen.width > 1400?"250":"0") + ", top=" + (screen.height > 810?"100":"0") + ", width="+g_width+", height=600, menubar=no, status=no, toolbar=no, location=no, scrollbars=yes, resizable=yes";
  		window.open('','previewPop',option);

  		document.previewMenuForm.submit(); // target에 쏜다.

  	},

  	 //찾기
    searchMenu : function(key){

    	$(".titleKor:contains('"+key+"')").css({ "background" : "#c6f55a" , "font-weight" : "bold", "padding" : "4px"});

    	var objList = $(".titleKor:contains('"+key+"')");

    	if(objList.length >0){
    		var posi = $(objList[0]).position();
    		$('.rightTable').animate({scrollTop : posi.top - 70}, 400);
    	}



    }


};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */

 var menuList = [];
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.doSearch();		//검색(메뉴리스트)
	fnObj.doSearch2();		//검색(권한별메뉴)

	//검색버튼 동작
	$(".searchButtonItem").on("click", function(){
		fnObj.doSearch();
	});

	$( '#SGridTarget2 tbody' ).multisortable({
		items: "tr",
	    selectedClass: "selected",
	    sort : function(){},
	    stop: function(event, elem) {
	    	fnObj.moveSet(menuList);

	    }

	});

});
</script>