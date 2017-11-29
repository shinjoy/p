<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
<script>
  $( function() {
    $( "#sortable_P" ).sortable();
    $( "#sortable_P" ).disableSelection();
  } );
</script>

<!-- 북마크 추가 레이어 팝업 : S -->
<!-- <div id="sitemap_choiceBox" style="display: block;display: none;z-index:9999;">
	<p class="sitemap_title">즐겨찾기메뉴 관리페이지입니다. <strong>메뉴는 최대 12개</strong>까지 선택가능합니다.</p>
	<div class="sitemap_mnlistBox" id="menuListArea"></div>
	<div class="btnZoneBox mgb30">
		<a href="javascript:fnObj.saveBookMark();" class="p_blueblack_btn"><strong>저장</strong></a>
		<a href="javascript:fnObj.closeMenuList();" class="p_withelin_btn">취소</a>
	</div>
</div> -->
<!-- 북마크 추가 레이어 팝업 : E -->



<div class="deatailconWrap">
	<section id="detail_contents">

		<div class="bookMark_Wrap">
			<!--안내문구-->
			<div class="bookMark_titleZone">
				<h3 class="h3_design_title"><span class="point">Quick-Menu</span> Manager</h3>
				<p class="sub_title"><span>자주 사용하는 메뉴명 옆에</span> <span class="icon_quicklink add"></span> <span>바로가기 아이콘을 클릭하여 퀵메뉴처럼 사용하실수 있습니다.</span></p>
				<p class="des_txt">선택하신 메뉴는 드래그앤 드롭으로 메뉴 순서를 정하실수 있으며<br>최대 12개까지 메뉴를 추가하실 수 있습니다. </p>
			</div>
			<!--//안내문구//-->
			<!--메뉴 바로가기-->
			<ul id="sortable_P">
				<c:set var="bookMarkCount" value="0"/>
				<c:forEach items="${bookMarkList}" var="bookmark" varStatus="st">
					<c:set var="bookMarkCount" value="${st.count}"/>
					<li class="ui-state-default" oriIdx="${st.count}"  id="${bookmark.menuId}">
						<dl class="favorBox">
							<dt class="favor_mnName"><strong>${bookmark.menuTitleKor}</strong><span><c:if test="${!empty bookmark.menuNum}">[${bookmark.menuNum}]</c:if></span></dt>
							<dd class="favor_location"><span>${bookmark.menuRootKor}</span><span>${bookmark.menuParentKor}</span></dd>
							<dd class="favor_sumnail">
								<span class="photo_aspect aspect_2_1"></span>
							</dd>
							<dd class="btn_delete"><a href="javascript:fnObj.removeBookMark(${bookmark.menuId});"><em>삭제</em></a></dd>
						</dl>
					</li>
				</c:forEach>
				<c:forEach var="i" begin="1" end="${12-bookMarkCount}" step="1">
					<li class="ui-state-default">
						<div class="favorBox_empthy" onClick="fnObj.bookMarkAdd();">+</div>
					</li>
				</c:forEach>
			</ul>
			<!--메뉴바로가기//-->
		</div>
		<!--버튼영역-->
		<!-- <div class="btn_baordZone2">
			<a href="#" onclick="fnObj.doSave();" class="btn_blueblack">저장</a>
		</div> -->
		<!--//버튼영역//-->
	</section>
</div>

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

		$( "#sortable_P" ).sortable({
	    	update : function( event, ui ) {
	    		var booMarkList = $(this).sortable('toArray');
	    		fnObj.doSave(booMarkList);
	    	}
	    });

		$("#sortable_P").disableSelection();

		$('#btnLeftMenuHide').show();	//왼쪽메뉴 숨김버튼 숨기기
		$('#btnLeftMenuShow').hide();	//왼쪽메뉴 보기버튼 보이게
		
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

		//=================================================== 왼쪽 :s ======================================================

	},//end pageStart.
	//################# init function :E #################

	//저장(메뉴구조)
	doSave : function(booMarkList,type) {

		var pArray = [];
		var cntLvl0 = 0;

		for(var i=0; i< booMarkList.length;i++){
			if(!isEmpty(booMarkList[i])){			//menuId 가 존재하는 것만 골라.
				var rObj = new Object();
				rObj.menuId = booMarkList[i];
				cntLvl0++;
				rObj.sort = (cntLvl0 * 10).toString();
				pArray.push(rObj);
			}
		}
		//--------------- validation :E ---------------

		var url = contextRoot + "/basic/updateBookMark.do";
		var param = {
			pList : JSON.stringify(pArray), //그리드 데이터 (JSON 문자열)
		}

		//console.log(pArray);
		var callback = function(result) {

			var obj = JSON.parse(result);
			//console.log(obj);

			var cnt = obj.resultVal; //결과수

			if (obj.result == "SUCCESS") {
				parent.toast.push("저장OK!");

				var list = obj.resultObject.bookmarkList;

				//상단 퀵메뉴 세팅
				$("ul.quickmn_list").html("");
				for (var i = 0; i < list.length; i++) {
					var item = list[i];
					$(
							"<li id="+item.menuId +"><a href='"+contextRoot+"/"+item.menuPath+"'>"
									+ item.menuKor + "</a>").appendTo(
							"ul.quickmn_list");
				}


				if(type == 'del'){
					var liCount = $(".ui-state-default").length;
					//console.log(12-liCount.length);
					for(var i=0; i<12-liCount;i++){
						var str ='';
						str+=' <li class="ui-state-default">';
						str+='<div class="favorBox_empthy" onClick="fnObj.bookMarkAdd();">+</div></li>';
						$(str).appendTo("#sortable_P");
					}
				}

			} else {
				alertM("저장 도중 오류가 발생하였습니다.");
				return;
			}

		};

		commonAjax("POST", url, param, callback);

	},//end doSave

	//삭제
	removeBookMark : function(menuId){
		if (confirm("삭제하시겠습니까?")) {

			$("#sortable_P #"+menuId).remove();
			$("#sortable #"+menuId).remove();

			var booMarkList = $("#sortable_P").sortable('toArray');
	    	fnObj.doSave(booMarkList,'del');
		}
	},

	//북마크 추가 레이어 팝업 세팅
	bookMarkAdd : function(){

	 	//할당된 메뉴 리스트 가져오기
		var url = contextRoot + "/basic/bookmarkListPop/pop.do";
		var param = {};
		
		myModal.open({
 	   		url: url,
 	   		pars: param,
 	   		titleBarText: '메뉴 바로가기  설정',			//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
 	   		method:"POST",
 	   		top: $(document).scrollTop() + 150,
 	   		width: 1200,
 	   		closeByEscKey: true				//esc 키로 닫기
   		});

	   $('#myModalCT').draggable();
	}



//################# else function :E #################

};//end fnObj.

/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function() {
	fnObj.preloadCode(); //공통코드 or 각종선로딩코드
	fnObj.pageStart(); //화면세팅

});
</script>