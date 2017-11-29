<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<div id="IB_Snb">
	<p class="Snb_title">MAIN</p>
    <ul class="Snb_List">
    </ul>
</div>




<script type='text/javascript'>
//Menu Summary Map 이있다면 메뉴 카운트
$(document).ready(function(){
<c:forEach items="${menuSummaryMap }" var="data">
	$("#${data.key}").html('${data.value}');
</c:forEach>
});
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 메뉴 생성 스크립트 :S ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
/*
 * function makeMenu_Left
 *
 * description: menu object 의 정렬 순서가 중요(순서대로 만들어지기 때문)
 * 				- 순서는, 그룹단위별로 만들어진다(한개의 그룹이 모두 만들어진후 다음 그룹이 만들어지는 방식)
 * 																※ 한개 그룹: (0 level ~ 최하위 level까지)
 */
function makeMenu_Left(){

	var lang = '${baseUserLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')

	var menuStr = window.localStorage['menuTop'];		//menuTop...json string	!!!!!!!!!!!!!!!!!!일단 top 메뉴와 동일하게 하기 위해 사용

	var rootId = '${menuParam.mr}';				//root menu id(0 level menu id)
	var myId = '${menuParam.me}';				//my menu id
	var upId = '${menuParam.mu}';				//up menu id

	var orgProjectNm = "${baseUserLoginInfo.projectTitle }";

	if(menuStr.length>0){
		var menu = eval(menuStr);	//menu object (string to object(array))

		var menuDepth1;				//GNB 부모값이 'N'인 자식들을 보이지 않게 하기 위해... 그룹세팅값

		var menuRootId;
		var menu1LvlId;

		var ul;						//level 1
		var li;

		//var menuSpanLvl2;
		var root = $('.Snb_List')[0];	//document.getElementById('ulLeftMenu');	//document.getElementsByTagName('ul')[0];		//menu space

		for(var i=0;i<menu.length;i++){
			var menuTitleKor = menu[i].menuTitleKor;

			if(menuTitleKor.indexOf("#PROJECT#")>-1){
				menuTitleKor = menuTitleKor.split("#PROJECT#").join(orgProjectNm);
			}

			//왼쪽메뉴 category name(0 level) setting :S ---------
			if(menu[i].menuId == rootId){

				$("p.Snb_title").html((lang=='KOR')?menuTitleKor:menu[i].menuTitleEng);
			}
			//왼쪽메뉴 category name(0 level) setting :E ---------


			if(menu[i].menuRootId == rootId && menu[i].menuId != rootId){	//해당 root 메뉴인 것들의 하위메뉴만 뿌려준다.

				//기본 트리 메뉴가 아닌 경우에는 skip	 (단, 루트부터 그 그룹의 모두가 기본 트리가 아닌경우에는 보인다(경로 직접접근인경우))
				if(menu[i].basicTreeYn == 'N' && (menu[i].parentBasicTreeYn == 'Y' || menu[i].rootBasicTreeYn == 'Y')) continue;


				if(menu[i].depth == '1'){

					menuDepth1 = menu[i].menuId;						//해당그룹 세팅


					li = document.createElement('li');
					var oA = document.createElement('a');

					if(menu[i].menuId == myId || menu[i].menuId == upId){	//선택된 메뉴
						if(menu[i+1] == undefined || menu[i+1].depth == undefined || menu[i+1].depth == 1 || menu[i+1].depth == 0){
							li.className = "current_single";		//자식없는 1 level 의 선택
						}else{
							li.className = "current";				//자식있는 1 level 의 선택
						}

					}else{													//선택되지 않은 메뉴
						if(menu[i+1] == undefined || menu[i+1].depth == undefined || menu[i+1].depth == 1 || menu[i+1].depth == 0){
							li.className = "";						//자식없는 1 level
						}else{
							li.className = "open_mn";				//자식있는 1 level

							oA.setAttribute('onclick', 'menuFoldIt(this);');	//자식있는 1 level
						}
					}

					var hrefStr;
					var url = menu[i].menuPath;
					if(url==''||url==null){
						hrefStr = '#';

					}else{
						if(menu[i+1] == undefined || menu[i+1].depth == undefined || menu[i+1].depth == 1 || menu[i+1].depth == 0){
							//자식없는 1 level
							hrefStr = contextRoot + '/' + url;
						}else{
							//자식있는 1 level (** top 메뉴와는 다르게, 경로(이동대상 url)가 있어도 접히는 효과를 위해 이동을 막는다)
							hrefStr = '#';
						}
					}

					oA.setAttribute('href', hrefStr);											//경로

					oA.innerHTML = ((lang=='KOR')?menuTitleKor:menu[i].menuTitleEng) + '<span id="MENU_' + menu[i].menuEng + '"></span>';		//메뉴명

					li.appendChild(oA);

					root.appendChild(li);	//메뉴에 넣기


				}else{	// if(menu[i].depth == '2'){

					if(menuDepth1 != menu[i].menuUpId) continue;		//해당 그룹이 아닌경우 제외


					if(menu1LvlId != menu[i].menuUpId){	//1 level 메뉴가 만들어진 다음, 첫번째 하위(level 2)를 만드려는 경우
						menu1LvlId = menu[i].menuUpId;
						ul = document.createElement('ul');		//menu 그룹의 하위(2레벨) list 기본 생성
						ul.setAttribute('class', 'Snb_de_List');
					    li.appendChild(ul);
					}


					var li = document.createElement('li');
					var oA = document.createElement('a');

					if(menu[i].menuId == myId){
						oA.className = "current";
					}else{
						oA.className = "";
					}

					var hrefStr;
					var url = menu[i].menuPath;
					if(url==''||url==null){
						hrefStr = '#';
					}else{
						hrefStr = contextRoot + '/' + url;
					}

					oA.setAttribute('href', hrefStr);											//경로

					//oA.innerHTML = (lang=='KOR')?menu[i].menuTitleKor:menu[i].menuTitleEng;		//메뉴명

					oA.innerHTML = ((lang=='KOR')?menuTitleKor:menu[i].menuTitleEng) + '<span id="MENU_' + menu[i].menuEng + '"></span>';		//메뉴명

					li.appendChild(oA);

					ul.appendChild(li);		//메뉴에 넣기
				}
			}
		}//end for.
	}
}//end makeMenu_Left.


makeMenu_Left();		//메뉴를 만든다.

//메뉴 접었다 폈다 함수. (왼쪽메뉴 depth 3)
function menuFoldIt(obj){
	var p = $(obj).parent();
	if($(p).attr('class') == 'open_mn'){	//열려있는 상태이면
		$(p).children('ul').hide();
		$(p).attr('class', 'close_mn');
	}else{
		$(p).children('ul').show();
		$(p).attr('class', 'open_mn');
	}

}
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 메뉴 생성 스크립트 :E ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
</script>