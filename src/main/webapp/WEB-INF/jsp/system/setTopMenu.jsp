<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- -------- each page css :S -------- -->
<style>
.btn_wh_bevel{
    float: right;
    background-color: #fff;
    padding-left: 3px;
    padding-right: 3px;
    width: 50px;
    height: 21px;
    line-height: 21px;
    vertical-align: middle;
    border: #c2c2c2 solid 1px;
    color: #666;
    display: inline-block;
    font-size: 11px;
    text-align: center;
}
</style>
<!-- -------- each page css :E -------- -->



	<div style="padding:5px; background-color:white;height:459px;overflow-y:auto;">
	<form name="myForm" method="post">
	<input id="inputMenuId" type="hidden" name="menuId" >
	<div id="container_pop">	
	</div>	
	<div style="margin:5px;text-align:center;">
		<button id="btnSave" type="button" class="AXButton Classic" onclick="fnObj.doSetParent();"><i class="fa fa-check-circle fa-lg"></i>&nbsp;&nbsp;확&nbsp;&nbsp;&nbsp;&nbsp;인&nbsp;&nbsp;&nbsp;</button>
	</div>
	</form>
	</div>



<script type="text/javascript">

//Global variables :S --------------- 
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

				

var inputTitleBorder;				//제목 border style
var contentBorder;					//내용 border style
var roleId = '${roleId }';
var selectTopMenu = []; //선택된 메뉴들(부모창으로 넘어갈 메뉴 리스트)

var topMenuId_ = 0; 	//전체 일괄 적용을 위한 최상단 메뉴
var secondMenuId_ = 0; 	//전체 일괄 적용을 위한 중간 메뉴
var thirdMenuId_ = 0; 	//전체 일괄 적용을 위한 하위 메뉴
var tableLength = 0;    //전체 테이블 수
var checkLength = 0;    //전체 적용된 테이블 수


//Global variables :E ---------------

/*
 * 	메인창 화면에서 가져온 pageParamMenuList 변수가 있는 경우 
 *  이 정보를 팝업창 모달 화면에 매핑을 해준다.
 *  pageParamMenuList 변수에 데이터가 없는 경우
 *	선택한 메뉴 리스트에서 item.notTreeTopMenuInfo 변수를 통해 팝업창 모달 화면에 매핑을 해준다.
 *  
 *  디비에 저장된 상위메뉴 : notTreeTopMenuInfo
 *  메인화면에 임시저장된 상위 메뉴 : pageParamMenuList
 *  
 *  모달 창 최초 호출 시 notTreeTopMenuInfo에 의해 매핑이 되지만
 *  상위 메뉴 선택 후  확인버튼을 누르면 doSetParent()에 의해 메인창에서 임시정보(pageParamMenuList)를 가지고 있게된다.
 *  메인창에서 '상위메뉴설정'을 클릭 시 이 임시정보(pageParamMenuList)를 
 *	모달창에 다시 전달하게 되고 이를 토대로 모달 화면 매핑을 해준다.
 *
 *  받아온 정보인 디비에 저장된 상위메뉴 정보 혹은 메인화면에 임시저장된 상위 메뉴 정보를 토대로  
 *	loadMenuRootId , loadMenuMiddleId , loadMenuBottomId 를 만들어
 *  최상단 메뉴를 만들기 위해 checkMenuType() 를 호출한다.
 *  최상단 메뉴는 권한(roleId)를 토대로 ajax로 데이터를 받아온다. 
 *  이 권한에 따라 불러오는 최상단 메뉴는 달라질 수 있다. 
 *
 *  매핑은 trigger에 의해 이루어진다.
 *
 *  상위메뉴들을 선택 할때 마다 맨 끝에 selectMenuStr()를 호출하여 
 *  어떤 메뉴를 사용자가 선택하였는지 정리해서 보여준다.
 *  또한 이 함수에서는 '전체적용' 이 되었는지 체크하여 
 *  전체적용을 위한 전역변수들을 초기화 시켜준다. (topMenuId_, secondMenuId_, thirdMenuId_)
 *
 *  '전체적용'은 첫번째 테이블에서 선택된 상위 메뉴들을 나머지 테이블의 메뉴에도 
 *  똑같이 적용하는 함수이다.
 *
 *  상위 메뉴 선택 시 최상단 메뉴부터 차례대로 클릭하면 
 *  그 아래 메뉴들을 ajax로 받아온 데이터를 토대로 html을 만들어주고 있으나 
 *  이는 최초에만 적용되며 html이 이미 만들어져 있는 경우는 
 *  display 속성을 사용하여 숨김,보임 처리를 해준다. 
 *  

	menu 구조도
	<table id=table(메인창에서 선택된 메뉴아이디)>
		<tbody>
		<tr id=tabDiv>
		<td colspan =2>
			<!-- 최상단 메뉴 정보 -->
			<div id ="top_div0" name="top_div">
				<input type="radio" id="top_(최상단 메뉴의 인덱스 (0부터))" name="top_menu_table(메인창에서 선택된 메뉴아이디)">업무일지
				<!-- 중간 메뉴 정보 -->
				<div id="contain_top_div0">
						<div id="middle_div0">
							<input type="radio" id="middle_(중간 메뉴의 인덱스 (0부터))" name="middle_menu_table(메인창에서 선택된 메뉴아이디)">메뉴관리
							<!-- 하단 메뉴 정보 -->
							<div id="contain_bottom">
								<div id="bottom_div0">	
									<input type="radio" id="bottom_(하단 메뉴의 인덱스 (0부터))" name="bottom_menu_table(메인창에서 선택된 메뉴아이디)">메뉴관리
								</div>
								<div id="bottom_div1"></div>
							</div>
						</div>
						<div id="middle_div1">
							권한관리
							<div id="contain_bottom">
								<div id="bottom_div0"></div>
								<div id="bottom_div1"></div>
							</div>
						</div>
				</div>		
			</div>
			<<div id ="top_div1" name="top_div"></div>
		</td>
		</tr>
		</tbody>
	</table>
*/


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {
	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
		//메인창에서 가져온 메뉴 아이디 정보
		var pageParamMenuList = "${pageParamMenuList}";
		$("#container_pop").append("<div style='font-size:0.9em;padding-bottom:5px;'>* 확인 버튼을 누르신다음 메인창에서 '저장'을 누르셔야 선택하신 결과가 저장됩니다.</div>");
	
		<c:forEach items="${menuList}" var="item" varStatus="varStatus">	
			tableLength++;
			//공통 정보
			var html = '<table id="table${item.menuId}" cellpadding="0" cellspacing="0" class="AXFormTable" style="width:100%;margin-bottom:3px;">';
			html += '<colgroup><col width="130" /><col /></colgroup>';
			html += '<tbody>';
			html += '<tr><th><div class="tdRel">메뉴명</div></th>';
			html += '<td class="last" bgcolor="#F7F7F7"><div class="tdRel">';
			html += '${item.menuKor} ( ${item.menuEng} )';
			<c:if test="${varStatus.index == 0}">
				html += '<span class="rightblock"><a href="#" class="btn_wh_bevel" onclick="fnObj.setAllSameManu();">전체 적용</a></span>';
			</c:if>
	  		html += '</div></td></tr>';
	  		html += '<tr><th><div class="tdRel">메뉴타입</div></th>';
	  		html += '<td class="last" bgcolor="#F7F7F7"><div class="tdRel">${item.menuType} ( URL : ${item.menuPath} )</div></td></tr>';
	  		$("#container_pop").append(html);
	  		
	  		$("<tr />",{ id : "tabIdvMenu" }).append($("<th />",{ text : "선택된 메뉴 "})).appendTo("#container_pop #table${item.menuId}");
	  		$("<td />",{ class: "last" }).append( $("<div />",{ id : "tabDivMenu_str"})).appendTo("#container_pop #table${item.menuId} tr:eq(2)");
	  		$("<tr />",{ id : "tabDiv"}).append($("<td />", { colspan : "2"})).appendTo("#container_pop #table${item.menuId}");
	 	  		
	  		
	  		//DB에 저장된 메뉴 정보(pageParamMenuList 정보가 없는 경우 필요한 데이터)
	  		var loadMenuRootId = "${item.notTreeTopMenuInfo.menuRootId}";
	  		var loadMenuMiddleId = "${item.notTreeTopMenuInfo.middleMenuId}";
	  		var loadMenuBottomId = "${item.notTreeTopMenuInfo.bottomMenuId}";
	  		
	  		//화면상 저장된 메뉴 정보 가져옴.(pageParamMenuList 정보를 토대로)
			if (pageParamMenuList != "") {
				var pageParamMenuArray = pageParamMenuList.split(",");
				for (var j = 0; j < pageParamMenuArray.length; j++) {
					var subMenuItemArray = pageParamMenuArray[j].split(":");
					//같은 메뉴 아이디인 경우
					if (subMenuItemArray[0] == "${item.menuId}") {
						if (loadMenuRootId != subMenuItemArray[1]) {
							//최상단 메뉴가 변경된 경우.
							loadMenuRootId = subMenuItemArray[1];
							if (subMenuItemArray[2] != "" && subMenuItemArray[2] != null && subMenuItemArray[2] != 0) {
								if (loadMenuMiddleId != subMenuItemArray[2]) {
									loadMenuMiddleId = subMenuItemArray[2];
								}
							}
							if (subMenuItemArray[3] != "" && subMenuItemArray[3] != null && subMenuItemArray[3] != 0) {
								if (loadMenuBottomId != subMenuItemArray[3]) {
									loadMenuBottomId = subMenuItemArray[3];
								}
							}
						} else {
							//중간 메뉴가 변경된 경우.
							if (subMenuItemArray[2] != "" && subMenuItemArray[2] != null && subMenuItemArray[2] != 0) {
								if (loadMenuMiddleId != subMenuItemArray[2]) {
									loadMenuMiddleId = subMenuItemArray[2];
								}

								if (subMenuItemArray[3] != "" && subMenuItemArray[3] != null && subMenuItemArray[3] != 0) {
									if (loadMenuBottomId != subMenuItemArray[3]) {
										loadMenuBottomId = subMenuItemArray[3];
									}
								}
							}
						}
					}
				}
			}
	  		
			//메뉴 타입과 권한(roleId)에 따른 최상단 메뉴 정보 불러오기
			//loadMenuRootId : 저장혹은 선택된 상단 메뉴아이디,  loadMenuMiddleId :저장혹은 선택된 중간 메뉴아이디 , loadMenuBottomId :저장혹은 선택된 하단 메뉴아이디)
			fnObj.checkMenuType("${item.menuType}", "table${item.menuId}",loadMenuRootId, loadMenuMiddleId, loadMenuBottomId);
			
			</c:forEach>
		},
		
		//checkbox label 클릭시 앞에 radio event 실행시킴.
		triggerClick : function(level, table, id) {
			if (level == 0) {
				$("#" + table + " input:radio[id='" + id + "']").prop('checked', true).trigger("click");
			} else {
				$("#" + table + " " + id).prop('checked', true).trigger("click");
			}
		},
		//최상단 메뉴 구성 및  메뉴 데이터 ajax 반환
		checkMenuType : function(rdMenuType, tableId, menuTopId, menuMiddleId, menuBottomId) {
		
			//하위 메뉴가 없고 depth : 1 까지인 경우 맨 하위메뉴 정보에 0 세팅.
			if (menuMiddleId == menuBottomId) {
				menuBottomId = 0;
			}

			//초기화
			$("#" + tableId + " #tabDiv td").html("");

			var url = "${pageContext.request.contextPath}/system/tabMenu.do";
			var param = {
				menuLevel : 0,
				roleId : roleId
			}
			var divId = "#" + tableId + " #tabDiv td";
			var callback = function(result) {
				var result = JSON.parse(result);
				var list = result.resultObject;
				for (var i = 0; i < list.length; i++) {
					
					var item = list[i];
					if (list.length - 1 == i) {
						$('<div  />', {	name : "top_div", id : "top_div" + i, style : "margin-bottom:3px;padding:1px;"}).appendTo(divId);
					} else {
						$('<div  />',{name : "top_div", id : "top_div" + i, style : "margin-bottom:3px;border-bottom:1px solid rgba(221, 221, 221, 0.39);padding:1px;"}).appendTo(divId);
					}
					$('<input />',{ type : "radio", id : "top_" + i, name : "top_menu_" + tableId, value : item.menuId, style : "margin-right:3px;", onclick : "fnObj.checkTopMenu(1, '" + tableId+ "', 'top_div" + i + "', '" + menuMiddleId + "','" + menuBottomId+ "')"}).appendTo(divId + " #top_div" + i);
					$('<label />',{ text : item.menuKor, onclick : "fnObj.triggerClick(0, '" + tableId+ "', 'top_" + i + "')"}).appendTo(divId + " #top_div" + i);

					//기존저장된 정보를 가져오는 경우 (최상위 menu_id 클릭)
					if (menuTopId == item.menuId) {
						fnObj.triggerClick(0, tableId, 'top_' + i);
					}
				}
				$("#tabDiv").show();

			}
			commonAjax("POST", url, param, callback);

		},

		//상단 및 중간 메뉴 클릭 시 화면 생성 ajax
		checkTopMenu : function(level, tableId, locId, menuMiddleId, menuBottomId) {
			var parentMenuId = 0;

			if (level == 1) { // depth : 1 (중간메뉴 가져오기)	
				//이전 선택된 영역의 메뉴 리스트(중간메뉴,하단메뉴) 가림.
				$("#" + tableId + " div[name='contain_top_div']").css("display", "none");
				$("#" + tableId + " div[name='contain_bottom']").css("display", "none");

				//중간메뉴,하단메뉴에 선택된 내용 초기화
				$("#" + tableId + " input:radio[name^='middle_menu']").prop("checked", false);
				$("#" + tableId + " input:radio[name^='bottom_menu']").prop("checked", false);

				//상위 메뉴아이디 정보 가져오기.
				parentMenuId = $("#" + tableId	+ " input:radio[name^='top_menu']:checked").val();
				//이미 ajax로 메뉴 정보를 가져온 경우 display 속성만 변경하고 return
				if ($("#" + tableId + " #" + locId).find("#middle_div0").length > 0) {
					$("#" + tableId + " #contain_" + locId).css("display","block");
					//전체적용해야 하는 경우
					if(secondMenuId_ != 0 )
						$("#" + tableId + " input:radio[name^='middle_menu'][value='"+secondMenuId_+"']").prop("checked", true).trigger("click");
					return;
				}
			} else { // depth : 2 (하위메뉴 가져오기)	
				//상위 메뉴아이디 정보 가져오기.
				parentMenuId = $("#" + tableId+ " input:radio[name^='middle_menu']:checked").val();
				
				//최하위 메뉴 초기화.
				$("#" + tableId + " input:radio[name^='bottom_menu']").prop("checked", false);
				//최하위 메뉴 모두 안보임 처리
				$("#" + tableId + " div[name='contain_bottom']").css("display", "none");

				//이미 ajax로 메뉴 정보를 가져온 경우 return
				if ($("#" + tableId + " #" + locId).find("#bottom_div0").length > 0) {
					$("#" + tableId + " #" + locId + " div[name='contain_bottom']").css("display", "block");
					//전체적용해야 하는 경우
					if(thirdMenuId_ != 0 )
						$("#" + tableId + " input:radio[name^='bottom_menu'][value='"+thirdMenuId_+"']").prop("checked", true);
					return;
				}
			}

			var url = "${pageContext.request.contextPath}/system/tabMenu.do";
			var param = {
				menuLevel : level,
				menuParentId : parentMenuId,
				roleId : roleId
			}

			var callback = function(result) {
				var result = JSON.parse(result);
				var list = result.resultObject;
				if (level == 1) {
					for (var i = 0; i < list.length; i++) {
						//ex) locId : top_div0 / top_div1
						var item = list[i];
						if (i == 0) {
							$('<div  />',{ id : "contain_" + locId, name : "contain_top_div", style : "padding-left:30px;background-color:#fff;"}).appendTo( "#" + tableId + " #tabDiv #" + locId);
						}
						$('<div  />', { id : "middle_div" + i, name : "middle_div",	style : "margin-bottom:3px;padding-left:3px;background-color:#f7f7f7;"}).appendTo("#" + tableId + " #tabDiv #contain_" + locId);
						$('<input />', 	{ type : "radio", id : "middle_" + i, name : "middle_menu_" + tableId, value : item.menuId, onclick : "fnObj.checkTopMenu(2, '"+ tableId + "' , 'contain_" + locId+ " #middle_div" + i + "','"+ menuMiddleId + "','"+ menuBottomId + "')"}).appendTo("#" + tableId + " #tabDiv #contain_" + locId+ " #middle_div" + i);
						$('<label />', { text : item.menuKor + "(" + item.menuPath	+ ")", onclick : "fnObj.triggerClick(1, '"	+ tableId + "', '#contain_" + locId+ " #middle_div" + i + " #middle_"+ i + "')"}).appendTo("#" + tableId + " #tabDiv #contain_" + locId+ " #middle_div" + i);

						if(secondMenuId_ != 0 && secondMenuId_ == item.menuId){
							//전체적용한 아이디를 가져올 경우.
							fnObj.triggerClick(1, tableId, '#contain_' + locId+ ' #middle_div' + i + ' #middle_' + i);
						}else if (menuMiddleId != 0 && menuMiddleId == item.menuId) {
							//depth : 2에 저장된 메뉴 아이디를 가져오는 경우
							fnObj.triggerClick(1, tableId, '#contain_' + locId+ ' #middle_div' + i + ' #middle_' + i);
						}
					}
				} else {
					for (var i = 0; i < list.length; i++) {
						//ex) locId : contain_top_div9 middle_div0
						var item = list[i];
						if (i == 0) {
							$('<div  />',{ id : "contain_bottom",	name : "contain_bottom", style : "padding-left:30px;background-color:#fff;" }).appendTo( "#" + tableId + " #tabDiv #" + locId);
						}
						$('<div  />', { id : "bottom_div" + i, style : "margin-bottom:3px;"}).appendTo("#" + tableId + " #" + locId+ " #contain_bottom");
						$('<input />', { type : "radio", id : "bottom_" + i, name : "bottom_menu_" + tableId, onclick : "fnObj.selectMenuStr('" + tableId + "')", value : item.menuId}).appendTo("#" + tableId + " #" + locId + " #bottom_div"+ i);
						$('<label />', { text : item.menuKor + "(" + item.menuPath+ ")", onclick : "fnObj.triggerClick(2 , '"+ tableId + "', '#" + locId+ " #bottom_div" + i + " #bottom_"+ i + "')"}).appendTo("#" + tableId + " #" + locId + " #bottom_div"+ i);

						if(thirdMenuId_ != 0 && thirdMenuId_ == item.menuId){
							//전체 적용한 하위 메뉴가 존재하는 경우 
							fnObj.triggerClick(2, tableId, '#' + locId+ ' #bottom_div' + i + ' #bottom_' + i);
						}else if (menuBottomId != 0 && menuBottomId == item.menuId) {
							//depth : 3에 해당하는 저장된 메뉴 아이디를 가져오는 경우
							fnObj.triggerClick(2, tableId, '#' + locId+ ' #bottom_div' + i + ' #bottom_' + i);
						}

					}
				}
				fnObj.selectMenuStr(tableId);
			}
			commonAjax("POST", url, param, callback);
		},
		//선택한 메뉴 정보를 테이블 메뉴 아이디 별로 정리함.
		selectMenuStr : function(tableId) {
			var str = "";
			var topStr = $("#" + tableId + " input:radio[name^=top_menu]:checked").parent().find("label:eq(0)").text();
			str += topStr;

			var middleStr = $("#" + tableId + " input:radio[name^=middle_menu]:checked").parent().find("label:eq(0)").text();
			if (middleStr != "") {
				str += " <br/> &nbsp; - " + middleStr;
			}
			var bottomStr = $("#" + tableId + " input:radio[name^=bottom_menu]:checked").parent().find("label:eq(0)").text();
			if (bottomStr != "") {
				str += " <br/> &nbsp;&nbsp;&nbsp; - " + bottomStr;
			}
			//선택한 메뉴 에 들어갈 정보
			$("#" + tableId + " #tabDivMenu_str").html(str);

			//부모창으로 전달할 메뉴 정보 정리
			var topMenuId = $("#" + tableId + " input:radio[name^=top_menu]:checked").val();
			var middleMenuId = $("#" + tableId + " input:radio[name^=middle_menu]:checked").val();
			if(middleMenuId == undefined || middleMenuId == null || middleMenuId == ""){
				middleMenuId = 0;
			}
			var bottomMenuId = $("#" + tableId + " input:radio[name^=bottom_menu]:checked").val();
			if(bottomMenuId == undefined || bottomMenuId == null || bottomMenuId == ""){
				bottomMenuId = 0;
			}
			
			var addYn = true;
			for (var i = 0; i < selectTopMenu.length; i++) {
				//기존에 저장이 되어있는 경우 다시 세팅
				if (selectTopMenu[i].id == tableId) {
					addYn = false;
					selectTopMenu[i].topMenuId = topMenuId;
					selectTopMenu[i].middleMenuId = middleMenuId;
					selectTopMenu[i].bottomMenuId = bottomMenuId;
					selectTopMenu[i].topStr = topStr;
					selectTopMenu[i].middleStr = middleStr;
					selectTopMenu[i].bottomStr = bottomStr;
				}
			}

			//새로운 정보인 경우 배열에 정리해서 추가
			if (addYn) {
				selectTopMenu.push({
					"id" : tableId,
					"topMenuId" : topMenuId,
					"middleMenuId" : middleMenuId,
					"bottomMenuId" : bottomMenuId,
					"topStr" : topStr,
					"middleStr" : middleStr,
					"bottomStr" : bottomStr
				});
			}
			
			//전체 적용 여부 체크함.
			var changeAllYn = true;
			//전체 적용되었는지 체크.
			if(!(topMenuId == topMenuId_ && middleMenuId == secondMenuId_ && bottomMenuId == thirdMenuId_)){
				changeAllYn = false;
			}	
			//전체적용이 된경우 +1 증가시킴.
			if(changeAllYn){
				checkLength++;
			}
			
			//전체적용 완료된 테이블수가 체크된 테이블수보다 많은 경우 전체적용 전역 변수 초기화
			if(checkLength > tableLength){
				topMenuId_ = 0;
				secondMenuId_ = 0;
				thirdMenuId_ = 0;
			}

		},
		//맨 처음 권한으로 전체 세팅하기
		setAllSameManu : function(){
			if(!confirm("첫번째 메뉴에 선택된 메뉴로 전체 적용됩니다. \n적용하시겠습니까?")){
				return false;
			}
			//전체적용될 테이블 수 초기화 
			checkLength = 0;
						
			$("#container_pop table").each(function(index, value){
				if(index == 0){
					//첫번째 메뉴의 상위 메뉴 정보 가져오기.
					topMenuId_ = $(this).find("input:radio[name^='top_menu']:checked").val();
					secondMenuId_ = $(this).find("input:radio[name^='middle_menu']:checked").val();
					secondMenuId_ = (secondMenuId_ == undefined)? 0 : secondMenuId_;
					thirdMenuId_ = $(this).find("input:radio[name^='bottom_menu']:checked").val();
					thirdMenuId_ = (thirdMenuId_ == undefined)? 0 : thirdMenuId_;
				}else{					
					//기존 체크 내용 초기화
					$(this).find("input:radio[name^='bottom_menu']").prop("checked" , false);
					$(this).find("input:radio[name^='middle_menu']").prop("checked" , false);
					//첫번째 메뉴의 상단메뉴 아이디로 체크 trigger
					$(this).find("input:radio[name^='top_menu'][value='"+topMenuId_+"']").prop("checked", true).trigger("click");
				}
			});
		},
		// 부모창으로 전달하기.
		doSetParent : function() {
			parent.fnObj.updateValue(selectTopMenu);
			parent.myModal2.close();
		},

	//################# else function :E #################

	};//end fnObj.

	/*
	 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
	 */
	$(function() {
		fnObj.preloadCode(); //공통코드 or 각종선로딩코드
	});
</script>