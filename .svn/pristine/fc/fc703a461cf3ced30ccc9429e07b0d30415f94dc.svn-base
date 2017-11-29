/*
 * gboardTree.js
 *
 * Class :  1. GboardTree (일반게시판 리스트)
 *
 *
 * (*필요 js : jstree, jquery )
 */


//-------------------------------------------------- GboardTree :S -------------------------------------------------------

/**
 * 객체 외부에서 사용할 전역변수
 */
var g_gboardCallbackFn_f;			//콜백함수
/**
 * GboardTree Class
 *
 */
function GboardTree(){

	//----- member variable :S -----

	//setConfig(config) config 내용
	this.targetID;					//대상 위치 id (div, span)
	this.url;						//데이터 URL
	this.callbackFn;				//콜백 function
	this.isCallbackEnable;			//콜백 함수 enable 상태		(false: disable,	그외,: enable (default))
	this.isFirstLoad = true;		//첫 로딩(생성)시점 (트리 생성시 이벤트 리스너에 의해 콜백함수를 호출 하는것을 막기 위함)
	this.orgNm;
	this.firstGboardId;
	//----- member variable :E -----

}//GboardTree




/**
 * Gboard트리 설정함수 (GboardTree Class prototype function)
 *
 * @param		: config - 설정정보 객체
 * @return		:
 * @author		:
 * @date		: 2016. 11. 01.
 */
GboardTree.prototype.setConfig = function(config){

	this.targetID = config.targetID;												//대상 위치 id (div, span)
	this.url = config.url;															//데이터 URL
	this.callbackFn = config.callbackFn;											//콜백 function
	this.isCallbackEnable = (config.isCallbackEnable == undefined? true:config.isCallbackEnable);	//콜백 함수 enable 상태		(false: disable,	그외,: enable (default))
	this.orgNm = config.orgNm;
	this.firstGboardId = config.firstGboardId;
	//객체 외부에서 사용할 전역변수
	g_gboardCallbackFn_f = config.callbackFn;			//콜백함수

};//setConfig


/**
 * Gboard트리 데이터 세팅 (GboardTree Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2016. 11. 01.
 */
GboardTree.prototype.drawTree = function(){

	this.setGboardTreeList();

};//drawTree

/**
 * 트리 데이터 서버콜 및 트리생성 함수호출 (GboardTree Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2016. 11. 01.
 */
GboardTree.prototype.setGboardTreeList = function(){

	var thisGboardTree = this;		//GboardTree 를 this 이외에 접근하기 위한 객체변수

	var url = this.url;

	var param = {
	};

	var callback = function(result){
		var rslt = JSON.parse(result);
		var obj = rslt.resultObject;

		var headHtml = '<div class="tnavi_title"><label><span>'+this.orgNm+'</span>';

		headHtml += '</label></div>';

		$("#" + thisGboardTree.targetID).append(headHtml);
		$("#" + thisGboardTree.targetID).append('<div id="AXJSTree" class="tnavi_treezone"></div>');
		$("#" + thisGboardTree.targetID).append('<div id="nameSortList" class="allmem_array_list" ></div>');

		var groupList = obj.groupList;		//gboard group list
		var gboardList = obj.gboardList;	//gboard list

		//member variable 로도 세팅
		thisGboardTree.groupList = obj.groupList;
		thisGboardTree.gboardList = obj.gboardList;

		var gboardGroupList = groupList.concat(gboardList);

		thisGboardTree.makeTree(JSON.stringify(gboardGroupList));		//트리 생성
	};

	commonAjax("POST", url, param, callback, false);

};//setGboardTreeList
/**
 * 트리 생성 함수 (GboardTree Class prototype function)
 *
 * @param		: data	- 그리드 1 row 데이터
 * 				  index	- 특정 index
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
GboardTree.prototype.makeTree = function(jsonGboreData){

	var thisGboardTree = this;		//GboardTree 를 this 이외에 접근하기 위한 객체변수


	$('#AXJSTree').jstree('destroy');

	$('#AXJSTree').jstree({
				'core' : {
							"check_callback" : true,
							"data" : JSON.parse(jsonGboreData),
							"multiple" : false,				//다중선택

							"two_state": true
					},
				"themes" : {
						//"variant" : "large",
						"variant" : "small",
						"icons": true,
						"stripes" : true,
						"responsive" : false,
						"dots" : true
				},
				"plugins" : [
						"themes",  "json_data", "types", "conditionalselect", null
				],
				"types" : {
						"default" : {
							//"icon" : "folder"
					  	},
					  	"GBOARD" : {
					    	"icon" : contextRoot + "/images/work/red_dot.png"	//(thisGboardTree.isCheckbox?null:"../images/work/red_dot.png")	//"http://jstree.com/tree.png"
					  	}
				},
				"conditionalselect" : function (node, event) {
					if(node.id.substr(0,1) == 'D'){			//그룹노드이면
						return false;
					}else{
						thisGboardTree.callbackFn(node.id);
						return true;
					}
			    },
				"dnd" : {
						//
				}}).bind("loaded.jstree",function(event, data){		//첫 로딩시

		    	}).bind("select_node.jstree", function (event, data){
		    		thisGboardTree.isFirstLoad = true;				//클릭선택시 에는 무조건 기능동작하도록. (false)

		     	}).bind("changed.jstree", function (event, data){
		     		thisGboardTree.changedTree(event, data, $(this));

		     		thisGboardTree.isFirstLoad = false;

		     	}).bind("move_node.jstree",function(event,data){
    		    }).bind("click.jstree",function(event,data){


					//fnObj.doSearchAndPopup(event);
    		    }).bind("ready.jstree",function(event,data){
    		    	//loaded 에서 호출시 ie 10 이하 버전에서 에러 발생 !! ready 함수로 바인드 2017.01.03 sjy
    		    	$(this).jstree("open_all");		//전체 펼침
    		    	$("#"+thisGboardTree.firstGboardId+"_anchor").trigger("click");
    		    });;

	//2016.12.28. IE 버전에 따라 처음로딩 실패에 따른 분기처리(10.0이하 분기처리함)
	var verString = get_version_of_IE();
	if(verString != "N/A"){
		var verNumber = parseInt ( verString , 10 );
		if(verNumber <= 10  ){
			thisGboardTree.isFirstLoad = false;
		}
	}
};//makeTree

/**
 * 변경 이벤트 리스너 함수 (GboardTree Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
GboardTree.prototype.changedTree = function(event, data, treeObj){

};//changedTree