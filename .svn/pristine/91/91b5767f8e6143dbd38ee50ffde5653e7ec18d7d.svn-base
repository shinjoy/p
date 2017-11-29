<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	

<div id="mnmgmt_choiceBox" style="margin-top:10px;">
	<div class="mnmgmt_listBox" id="menuArea"></div>
</div>

<!-- 버튼 영역 -->
<div class="btnZoneBox mgb30">
	<a href="#" id="btnSave" class="p_blueblack_btn" onclick="javascript:fnObj.doSetParent();"><strong>저장</strong></a>
	<a href="#" class="p_withelin_btn" onclick="javascript:window.close();">취소</a>
</div>



<script type="text/javascript">

//Global variables :S --------------- 
//사용자언어
var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

var roleId = '${roleId }';
var menuList = [];

/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {
	//################# init function :S #################

	//선로딩코드
	preloadCode: function(){
	
		
	},
	
	//메뉴 리스트를 가저옴.
	getMemuList : function(){
		var url = "${pageContext.request.contextPath}/system/getMenuListForTab.do";
		var param={};
		var callback = function(result) {
			var obj = JSON.parse(result);
			var list = obj.resultList;
			menuList = list;
			var str ='';
			for(var i = 0; i < list.length; i++){
				
				var menuObj = list[i];
				if(menuObj.depth == 0){
					str +='<dl>';
					str +='<dt id="dt_'+menuObj.menuId+'"><label><input name="menuSelect" onclick="fnObj.setActive(\'dt_'+menuObj.menuId+'\');" type="radio" value="'+menuObj.menuId+'"/>';
					str +='<span>'+menuObj.menuTitleKor+'</span></label></dt>';
					str +='<input type="hidden" id="menu_'+menuObj.menuId+'" value="'+menuObj.menuId+'"/>';
					if(menuObj.childCount != 0){
						str+='<dd>'+fnObj.setChildMemuList(list,menuObj.menuId,'',menuObj.menuId)+'</dd>';
					}
					str +='</dl>';
				}
			}
			
			$("#menuArea").html(str);
		}
		commonAjax("POST", url, param, callback,false);
		
	},
	

	//메뉴 리스트를 돌려 자식 세팅
	setChildMemuList : function(menuList,menuId,childStr,menuRootId){
		
		childStr +='<ul>';
		for(var i = 0; i < menuList.length; i++){
			var menuObj = menuList[i];
			if(menuId == menuObj.menuUpId){
				childStr +='<li>';
				childStr +='<label id="label_'+menuObj.menuId+'"><input name="menuSelect" onclick="fnObj.setActive(\'label_'+menuObj.menuId+'\');" type="radio" value="'+menuObj.menuId+'"/>';
				childStr +='<span>'+menuObj.menuTitleKor+'</span></label>';
				childStr +='<input type="hidden" id="menu_'+menuObj.menuId+'" value="'+menuRootId+'"/>';
				if(menuObj.childCount != 0){
					childStr+=fnObj.setChildMemuList(menuList,menuObj.menuId,'',menuRootId);
					childStr +='</li>';
				}else{
					childStr +='</li>';
				}
			}
		}
		childStr +='</ul>';
		
		return childStr;
	},
	
	// 부모창으로 전달하기.
	doSetParent : function() {
		var menuId = $("input[name=menuSelect]:checked").val();
		var menuObj;
		for(var i=0;i<menuList.length;i++){
			if(menuList[i].menuId == menuId ){
				menuObj = menuList[i];
			}
		}
		if(menuObj != null){
			opener.fnObj.setTopMenu(JSON.stringify(menuObj),$("#menu_"+menuId).val());	//menuObj, menuRootId
			window.close();
		}else{
			alert("상위메뉴를 선택해주세요");
		}
		
	},
	
	//버튼 액션
	setActive : function(id){
		
		$(".active").removeClass();
		$('#'+id).addClass("active");
	}

	//################# else function :E #################

};//end fnObj.

/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function() {

	fnObj.preloadCode(); //공통코드 or 각종선로딩코드
	fnObj.getMemuList();
});
</script>