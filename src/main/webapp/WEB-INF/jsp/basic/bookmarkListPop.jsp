<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<!-- 북마크 추가 레이어 팝업 : S -->
<div id="choiceBox" class="mo_container">
	<!-- <p class="sitemap_title">즐겨찾기메뉴 관리페이지입니다. <strong>메뉴는 최대 12개</strong>까지 선택가능합니다.</p> -->
	<div class="sitemap_mnlistBox" id="menuListArea"></div>
	<div class="btnZoneBox mgt0">
		<a href="javascript:fnObj.saveBookMark();" class="p_blueblack_btn"><strong>저장</strong></a>
		<a href="javascript:fnObj.closeMenuList();" class="p_withelin_btn">취소</a>
	</div>
</div>
<!-- 북마크 추가 레이어 팝업 : E -->


<script type="text/javascript">
//Global variables :S ---------------

var myModal = new AXModal();		// instance
//사용자언어
var lang = '${baseUserLoginInfo.lang}'; //language (profile language... 'KOR' or 'ENG')

//Global variables :E ---------------

/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {

	//################# init function :S #################

	//선로딩코드
	preloadCode : function() {
		//공통코드


	},

	//화면세팅
	pageStart : function() {

	},//end pageStart.
	//################# init function :E #################


	//북마크 추가 레이어 팝업 세팅
	bookMarkAdd : function(){

		
	 	//할당된 메뉴 리스트 가져오기
		var url = contextRoot + "/basic/selectUserAllMenuList.do";
		var param = {};
		var callback = function(result) {
			var obj = JSON.parse(result);
			var list = obj.resultList; //결과

			var str = '';
			for(var i=0;i<list.length;i++){
				var menuObj = list[i];


				if(menuObj.menuLevel == 0){				//첫번째 top
					str+='<dl>';
					str+='<dt>'+menuObj.menuTitleKor+'</dt>';

					if(menuObj.childCount>0){
						str+='<dd>';
						str+='<ul>';
						str+=fnObj.childSetting(list,menuObj.menuId,'');
						str+='</ul>';
						str+='</dd>';
					}

				}
				str+='</dl>';
			}

			$("#menuListArea").html(str);
			parent.myModal.resize();

		}

		commonAjax("POST", url, param, callback);
	},

	//자식 노드 세팅
	childSetting : function(list,menuId,chileStr){
		//var chileStr = '';
		for(var i=0;i<list.length; i++){
			if(menuId == list[i].menuParentId){
				 chileStr += '<li><label>';

				 if(list[i].menuNum != ''){
					 chileStr += '<input type="checkbox" name="selectMenu" value="'+list[i].menuId+'" '+( list[i].chk >0 ? "checked=checked" : "" )+'>';
				 }
				 
				chileStr += '<span>'+list[i].menuTitleKor+'</span><span class="codenum">'+list[i].menuNum+'</span></label>';
				if(list[i].childCount>0){
					 chileStr+='<ul>';
					 chileStr+=fnObj.childSetting(list,list[i].menuId,'');
					 chileStr+='</ul>';
				}
				chileStr += '</li>';
			}
		}
		return chileStr;
	},

	//북마크 저장(추가 수정 - 레이어 팝업 액션)
	saveBookMark : function(){
		var dbMenuList = [];
		var selectMenuList = [];
		var addMenuList = [];
		var deleteMenuList = [];

		<c:forEach var="menuObj" items="${bookMarkList}">
			dbMenuList.push('${menuObj.menuId}');
		</c:forEach>


		$("input[name=selectMenu]:checked").each(function() {
			var menuId = $(this).val();
			selectMenuList.push(menuId); 	//선택된 리스트

			if(getArrayIndexWithValue(dbMenuList,menuId) == -1){			//새로 추가된 리스트
				addMenuList.push(menuId);
			}

		});

		for(var i=0;i<dbMenuList.length;i++){
			if(getArrayIndexWithValue(selectMenuList,dbMenuList[i]) ==-1){	//삭제할 리스트
				deleteMenuList.push(dbMenuList[i]);
			}
		}


		if(selectMenuList.length == 0){
			alert("선택된 메뉴가 없습니다.");
			return;
		}

		if(selectMenuList.length > 12){
			alert("최대 12개 까지만 가능합니다.");
			return;
		}


		var url = contextRoot + "/basic/saveBookmark.do";
		var param = {
			deleteMenuStr	: deleteMenuList.join(","),
			addMenuStr		: addMenuList.join(",")
		};
		var callback = function(result) {
			alert("저장되었습니다.");
			fnObj.closeMenuList();
			parent.location.reload();

		}

		commonAjax("POST", url, param, callback);

	},

	closeMenuList : function(){
		parent.myModal.close();
	}


//################# else function :E #################

};//end fnObj.

/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function() {
	fnObj.preloadCode(); 	//공통코드 or 각종선로딩코드
	fnObj.pageStart(); 		//화면세팅
	fnObj.bookMarkAdd(); 	//북마크 리스트 불러오기 

});
</script>