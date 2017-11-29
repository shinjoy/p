/*
 * UserTree.js
 *
 * Class :  1. UserTree (관계사별 부서별 사용자 리스트)
 *
 *
 * (*필요 js : jstree, jquery )
 */


//-------------------------------------------------- UserTree :S -------------------------------------------------------

/**
 * UserTree Class
 *
 */
function UserTree(){

	//----- member variable :S -----

	//setConfig(config) config 내용
	this.targetID;					//대상 위치 id (div, span)
	this.url;						//데이터 URL
	this.isCheckbox;				//체크박스 유형 여부			(true:체크박스,		그외,: 체크박스X (default))
	this.isOnlyOne;					//선택건수 1개 여부			(false: 복수,		그외,: 한명(default))
	this.isAllOrg;					//전체 ORG 범위로의 여부		(true: 전체ORG, 		그외,: 나의권한ORG (default))
	this.oneOrg;					//전달받은 한개의 ORG ID
	this.defaultSelectList;			//기본 선택 id array 			(로딩시점 초기 기본 선택 노드 id list)
	this.isDeptSelectable;			//부서선택 가능여부(= 하위 사용자 모두 선택)		(true: 해당부서하위모두선택, 	그외,:부서선택불가 (default))
	this.isUserSelectable;			//사용자선택 가능여부 			(false: 사용자선택불가, 		그외,: 사용자선택가능(default))
	this.callbackFn;				//콜백 function
	this.orgCallbackFn;				//콜백 function
	this.isCallbackEnable;			//콜백 함수 enable 상태		(false: disable,	그외,: enable (default))
	this.isOrgCallbackEnable;		//콜백 함수 enable 상태		(false: disable(default),	그외,: enable )
	//this.isFirstCallback;			//첫 로딩시 콜백 호출 여부		(false: 콜백호출 X,	그외,: 호출 (default))
	this.useAllCheck;				//전체선택 기능 사용 여부		(true: 사용,			그외,: 미사용(default))
	this.defaultUseAllCheck			//전체선택 디폴트 선택
	this.isOnlyDeptId;				//결과값으로 부서 id 만 반환
	this.useNameSortList;			//이름정렬선택 리스트 사용 여부	(true: 사용,			그외,: 미사용(default))
	this.hasDeptTopLevel;			//부서의 회장 부서 표시여부  (true: 포함,     그외,: 미포함(default))
	this.userStatusFire;			//퇴사자 여부
	this.treeId;					//tree make

	//조회 정보
	this.orgList;					//org list
	this.deptObj;					//dept list array object 	{ORG1 : [{부서1},{부서2},...], ORG2 : [{부서1},{부서2},...], ...}
	this.userObj;					//user list array object	{ORG1 : [{사용자1},{사용자2},...], ORG2 : [{사용자1},{사용자2},...], ...}

	this.isReturnObj;				//return 객체 여부 (유저 list return)

	this.isFirstLoad = true;		//첫 로딩(생성)시점 (트리 생성시 이벤트 리스너에 의해 콜백함수를 호출 하는것을 막기 위함)
	this.isAllCheckList = {};		//전체선택 상태여부 객체 (전체선택 상태인지...전체선택 기능 사용시 사용)

	this.rtnField;					//userId, cusId, empNo (id 로 사용되는 값)
	this.treeId;					//트리 ID (추가 sjy 2017.10.16)

	this.selectedTab = 'DEPT';      //선택된 탭


	this.isUserGroup = false;   //유저그룹 탭 사용여부 (true: 사용,       그외,: 미사용(default))
	this.openDeptId;			//디폴트 오픈 부서 (하위부서까지 다)
	this.selectDeptId;			//디폴트 선택 부서(하위부서까지 다)

	this.openAllnode;			//전체열기여부
	this.closeAllnode;			//전체닫기여부
	this.selectableClickDeptId;	//선택가능 부서아이디(하위부서까지 다)

	this.myUserId;				//내유저아이디
	this.myOrgId;				//내 orgId
	this.beforeOrgId = '';		//전 orgId

	this.pageType;				//트리 페이지
	this.myDeptId = '';			//내 부서
	//----- member variable :E -----
	this.callbackYn = 'Y';


	//----- member function (prototype defined) :S -----

	//setConfig(config)		트리 설정 함수
	//drawTree()			트리 생성 START 함수
	//setOrgDeptUserList()	트리 데이터 서버콜 및 트리 생성 함수 호출
	//makeTree()			트리 생성 함수
	//changedTree			변경 이벤트 리스너 함수
	//setCallbackEnable		콜백 함수 enable

	//----- member function (prototype defined) :E -----

}//UserTree




/**
 * 사용자트리 설정함수 (UserTree Class prototype function)
 *
 * @param		: config - 설정정보 객체
 * @return		:
 * @author		:
 * @date		: 2016. 11. 01.
 */
UserTree.prototype.setConfig = function(config){

	this.targetID = config.targetID;												//대상 위치 id (div, span)
	this.url = config.url;															//데이터 URL
	this.isCheckbox = (config.isCheckbox == undefined? false:config.isCheckbox);;	//체크박스 유형 여부			(true:체크박스,		그외,: 체크박스X (default))
	this.isOnlyOne = (config.isOnlyOne == undefined? true:config.isOnlyOne);		//선택건수 1개 여부			(false: 복수,		그외,: 한명(default))
	this.isAllOrg = (config.isAllOrg == undefined? false:config.isAllOrg);			//전체 ORG 범위로의 여부		(true: 전체ORG, 		그외,: 나의권한ORG (default))
	this.oneOrg = (config.oneOrg == undefined? '':config.oneOrg);					//전달받은 한개의 ORG ID
	this.defaultSelectList = (config.defaultSelectList == undefined? []:config.defaultSelectList);	//기본 선택 id array 			(로딩시점 초기 기본 선택 노드 id list)
	this.isDeptSelectable = (config.isDeptSelectable == undefined? false:config.isDeptSelectable);	//부서선택 가능여부(= 하위 사용자 모두 선택)		(true: 해당부서하위모두선택, 	그외,:부서선택불가 (default))
	this.isUserSelectable = (config.isUserSelectable == undefined? true:config.isUserSelectable);	//사용자선택 가능여부 (false: 사용자선택불가, 		그외,: 사용자선택가능(default))
	this.callbackFn = config.callbackFn;											//콜백 function
	this.orgCallbackFn = config.orgCallbackFn;										//콜백 function
	this.isCallbackEnable = (config.isCallbackEnable == undefined? true:config.isCallbackEnable);	//콜백 함수 enable 상태		(false: disable,	그외,: enable (default))
	this.isOrgCallbackEnable = (config.isOrgCallbackEnable == undefined? false:config.isOrgCallbackEnable);	//콜백 함수 enable 상태		(false: disable(default),	그외,: enable )
	//this.isFirstCallback = (config.isFirstCallback == undefined? true:config.isFirstCallback);	//첫 로딩시 콜백 호출 여부		(false: 콜백호출 X,	그외,: 호출 (default))
	this.useAllCheck = (config.useAllCheck == undefined? false:config.useAllCheck);	//전체선택 기능 사용 여부		(true: 사용,			그외,: 미사용(default))
	this.defaultUseAllCheck = (config.defaultUseAllCheck == undefined? false:config.defaultUseAllCheck);	//전체선택 디폴트
	this.isOnlyDeptId = (config.isOnlyDeptId == undefined? false:config.isOnlyDeptId);	//콜백에 던지는 결과값으로 부서 id 만
	this.useNameSortList = (config.useNameSortList == undefined? false:config.useNameSortList);	//이름정렬선택 리스트 사용 여부 (true: 사용,		그외,: 미사용(default))
	this.hasDeptTopLevel = (config.hasDeptTopLevel == undefined? false:config.hasDeptTopLevel);	//부서의 회장 부서 표시여부  (true: 포함,     그외,: 미포함(default))
	this.userStatusFire = (config.userStatusFire == undefined? false : config.userStatusFire);	//퇴사자 여부

	this.openDeptId = (config.openDeptId == undefined? '0' : config.openDeptId);			//디폴트 오픈 부서 (하위부서까지 다)
	this.selectDeptId = (config.selectDeptId == undefined? '0' : config.selectDeptId);		//디폴트 선택 부서(하위부서까지 다)
	this.closeAllnode = (config.closeAllnode == undefined? false : config.closeAllnode);	//전체닫기 기본값 false

	this.nodeOpenEnable = (config.nodeOpenEnable == undefined? false : config.nodeOpenEnable);	//오픈 여부
	this.authTree = (config.authTree == undefined? false : config.authTree);					//권한 트리인지
	this.deptManagerDeptId  = (config.deptManagerDeptId == undefined? false : config.deptManagerDeptId);	//부서장 부서

	this.openAllnode = (config.openAllnode == undefined? false : config.openAllnode);		//전체열기 기본값 false

	this.myUserId = (config.myUserId == undefined? '' : config.myUserId);				//로그인유저 아이디 판별값
	this.myOrgId = (config.myOrgId == undefined? '' : config.myOrgId);					//로그인 유저 orgId
	this.pageType = (config.pageType == undefined? '' : config.pageType);					//트리 페이지
	this.myDeptId = (config.myDeptId == undefined? '' : config.myDeptId);					//내 부서

	this.isReturnObj = (config.isReturnObj == undefined? false : config.isReturnObj);	//userList return
	this.rtnField = (config.rtnField == undefined? 'userId' : config.rtnField);			//userId, cusId, empNo (id 로 사용되는 값)

	this.isUserGroup = (config.isUserGroup == undefined? false:config.isUserGroup);  	//유저그룹 탭 사용여부 (true: 사용,       그외,: 미사용(default))
	this.treeId = (config.treeId == undefined ? 'AXJSTree' : config.treeId);			//트리 ID (추가 sjy 2017.10.16)
	this.selectedTab = 'DEPT';

	this.g_userIdList = [];
	this.g_userObjList = [];

	this.g_selectableUserList = [];
	this.g_selectableDeptList = [];

	//변경 값
	//선택가능 부서아이디(하위부서까지 다) - '' 전체 선택가능/'0' 내것만 선택가능/그외 아이디
	this.selectableClickDeptId = (config.deptManagerDeptId == undefined? '' : config.deptManagerDeptId);

	//객체 외부에서 사용할 전역변수
	g_callbackFn_f = config.callbackFn;			//콜백함수
	if(this.isOrgCallbackEnable) g_orgCallbackFn_f = config.orgCallbackFn;			//콜백함수
	g_userTree = this;							//UserTree 외부에서 사용하기 위해




};//setConfig


/**
 * 사용자트리 데이터 세팅 (UserTree Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2016. 11. 01.
 */
UserTree.prototype.drawTree = function(){

	if(this.myOrgId != '' && this.isUserGroup && this.myOrgId != this.oneOrg && this.authTree) defaultMyOrgTree();
	else this.setOrgDeptUserList(); //tree draw

};//drawTree


/**
 * 트리 데이터 서버콜 및 트리생성 함수호출 (UserTree Class prototype function)
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2016. 11. 01.
 */
UserTree.prototype.setOrgDeptUserList = function(){

	var thisUserTree = this;		//UserTree 를 this 이외에 접근하기 위한 객체변수

	var url = this.url;

	var param = {
			'isOnlyOne' : (this.isOnlyOne?'Y':'N'),		//선택건수 1개 여부
			'isAllOrg' : (this.isAllOrg?'Y':'N'),		//전체 ORG 범위로의 여부
			'oneOrg' : this.oneOrg	,					//전달받은 한개의 ORG ID
			'rtnField' : this.rtnField	,				//전달받은 userId, cusId, empNo
			'isUserGroup' : (this.isUserGroup?'Y':'N'), 	//유저그룹 탭 사용여부
			'hasDeptTopLevel' : (this.hasDeptTopLevel?'Y':'N'), 	//부서의 회장 부서 표시여부  (true: 포함,     그외,: 미포함(default))
			'userStatusFire'	: (this.userStatusFire?'Y':''),	//퇴사자만 조회 여부
	};

	var callback = function(result){
		var rslt = JSON.parse(result);
		var obj = rslt.resultObject;

		var orgList = obj.orgList;		//org list
		var deptObj = obj.deptObj;		//dept list array object 	{ORG1 : [{부서1},{부서2},...], ORG2 : [{부서1},{부서2},...], ...}
		var userObj = obj.userObj;		//user list array object	{ORG1 : [{사용자1},{사용자2},...], ORG2 : [{사용자1},{사용자2},...], ...}

		var groupOrgList = obj.orgList;		//org list
		var groupDeptObj = obj.groupDeptObj;		//dept list array object 	{ORG1 : [{부서1},{부서2},...], ORG2 : [{부서1},{부서2},...], ...}
		var groupUserObj = obj.groupUserObj;		//user list array object	{ORG1 : [{사용자1},{사용자2},...], ORG2 : [{사용자1},{사용자2},...], ...}

		this.orgList = orgList;

		//member variable 로도 세팅
		thisUserTree.orgList = obj.orgList;
		thisUserTree.deptObj = obj.deptObj;
		thisUserTree.userObj = obj.userObj;

		thisUserTree.groupOrgList = obj.groupOrgList;
		thisUserTree.groupDeptObj = obj.groupDeptObj;
		thisUserTree.groupUserObj = obj.groupUserObj;
		thisUserTree.groupUserList = obj.groupUserList;


		var selectOrgList = obj.selectOrgList;
		var userAuth = "";	//선택 관계사의 권한

		//객체 외부에서 사용할 전역변수
		g_orgIdList_v = obj.orgList;			//ORG 리스트

		for(var i=0; i<orgList.length; i++){	//ORG 리스트 수만큼 트리 생성
			if(orgList[i].orgId != 0){

				var groupHtml = "";
				if(thisUserTree.isUserGroup){
					groupHtml = '&nbsp;&nbsp;<button type="button" class="btn_grMgmt" id="groupMgmtButton" style="display:none" onclick="javascript:processUserGroupInfo()">그룹관리</button>';
				}

			 var headHtml = "";


			 headHtml += '<div class="tnavi_title"><select name="treeOrg" id="treeOrg" class="select_b w_date" onchange="reloadUserTree(\'DEPT\');">';  //w_100px w80pro
			   for(var x=0; x<selectOrgList.length; x++){	//ORG 리스트 수만큼 트리 생성
				   if(selectOrgList[x].orgId == thisUserTree.oneOrg){
					   headHtml += '<option value="' + selectOrgList[x].orgId + '" selected staffDeptId="'+selectOrgList[x].staffDeptId+'" staffUserId="'+selectOrgList[x].staffUserId+'"    targetAuth="'+selectOrgList[x].orgAccessAuthType+'">'+selectOrgList[x].orgNm+'</option>';
					   userAuth = selectOrgList[x].orgAccessAuthType; //선택 관계사의 권한
				   }else{
					   headHtml += '<option value="' + selectOrgList[x].orgId + '" staffDeptId="'+selectOrgList[x].staffDeptId+'" staffUserId="'+selectOrgList[x].staffUserId+'"   targetAuth="'+selectOrgList[x].orgAccessAuthType+'">'+selectOrgList[x].orgNm+'</option>';
				   }
			   }
			   headHtml += '</select>&nbsp;&nbsp;' + groupHtml;
				if(thisUserTree.useAllCheck){
					headHtml += '<span id="sapnCheckAllTreeUser"><input onclick="doCheckAllTreeUser(' + orgList[i].orgId + ');" type="checkbox" id="allTree_'+ orgList[i].orgId +'"/></span>';
				}
				headHtml += '</label></div>';


				//이름정렬선택 리스트 사용
				var tabCss = "";
				if(thisUserTree.isUserGroup) tabCss = "mn03";
				else tabCss = "";
				if(thisUserTree.useNameSortList){
					headHtml += '<div id="tabZoneTreeList" class="tabZone_tree_list '+tabCss+'"><ul style="border-top:none; border-right:none; ">';
					headHtml += '<li id="tabZoneDept_'+ orgList[i].orgId +'" class="current"><a href="javascript:selectTabZone(\'DEPT\',' + orgList[i].orgId + ')" >부서별</a></li>';
					headHtml += '<li id="tabZoneUser_'+ orgList[i].orgId +'"><a href="javascript:selectTabZone(\'USER\',' + orgList[i].orgId + ')" >직원별</a></li>';
					if(thisUserTree.isUserGroup){
						headHtml += '<li id="tabZoneGroup_0"><a href="javascript:selectTabZone(\'GROUP\',' + orgList[i].orgId + ')" >그룹별</a></li>';
					}
					headHtml += '</ul></div>';
				}

				$("#" + thisUserTree.targetID).append(headHtml);

				var treeId = thisUserTree.treeId + orgList[i].orgId ;

				$("#" + thisUserTree.targetID).append('<div id="' + treeId + '" class="tnavi_treezone"></div>');

				$("#" + thisUserTree.targetID).append('<div id="nameSortList' + thisUserTree.treeId + orgList[i].orgId + '" class="allmem_array_list" style="display:none;"></div>');

				$("#" + thisUserTree.targetID).append('<div id="AXJSTree0" class="tnavi_treezone" style="display:none;"></div>');

				var deptList = deptObj[orgList[i].orgId];
				var userList = userObj[orgList[i].orgId];

				thisUserTree.g_userObjList = userList;

				var deptUserList = deptList.concat(userList);

				if(thisUserTree.authTree){
					deptUserList = nodeDataSet(deptUserList,deptList,userAuth);
				}

				var deptUserCustomList = $.extend(true,[],deptUserList); //userList 객체복사

				//기본 선택 상태
				deptUserList.forEach(function(value, index){										//기본 선택상태 세팅 위해
					if(getArrayIndexWithValue(thisUserTree.defaultSelectList, value.id) >= 0){		//찾아서
						deptUserList[index].state = {"selected" : true};							//선택 상태로 세팅  'opened' : true

					}
				});

				//( 부서별 직급 부서장 표시를 위해 추가 -sjy)

				//기본 선택 상태(팀별 부서별 직급 부서장 표시를 위해 추가 -sjy)
				deptUserCustomList.forEach(function(value, index){									//기본 선택상태 세팅 위해

					if(deptUserCustomList[index].type == 'user'){
						var str ="<span class='t_name'>"+deptUserCustomList[index].text+"</span>";
		     			str += "<span class='t_position'>"+deptUserCustomList[index].rankNm+"</span>";
		     			str += deptUserCustomList[index].deptManagerYn == "Y" ? "<span class='t_deptM'><em></em></span>" : "";

		     			deptUserCustomList[index].text = str;
					}

					if(getArrayIndexWithValue(thisUserTree.defaultSelectList, value.id) >= 0){		//찾아서

						deptUserCustomList[index].state = {"selected" : true};						//선택 상태로 세팅  'opened' : true

					}
				});

				thisUserTree.makeTree(deptUserCustomList, orgList[i].orgId);		//트리 생성
				thisUserTree.makeNameList(JSON.stringify(deptUserList), orgList[i].orgId);	//이름정렬선택 리스트
				thisUserTree.isAllCheckList[orgList[i].orgId] = false;		//디폴드 세팅 (false ..전체해제상태)

			}


		}//for (ORG 리스트 수만큼)

		if(thisUserTree.isUserGroup){

			var groupDeptList = groupDeptObj[0];
			var groupUserList = groupUserObj[0];
			var groupDeptUserList = groupDeptList.concat(groupUserList);

			//권한 트리일때
			if(thisUserTree.authTree){
				groupDeptUserList.forEach(function(value, index){									//기본 선택상태 세팅 위해
					groupDeptUserList[index].state = {"disabled" : true};

					if(getArrayIndexWithValue(enableDeptArr, groupDeptUserList[index].orgDeptId) > -1){
						groupDeptUserList[index].state = {"disabled" : false};
					}

					if(groupDeptUserList[index].orgAccessAuthType == 'SUPER'
						|| groupDeptUserList[index].orgAccessAuthType == 'VIP'
							|| thisUserTree.selectableClickDeptId == '-1'
								|| (thisUserTree.myOrgId != groupDeptUserList[index].orgId
										&& groupDeptUserList[index].orgAccessAuthType != '')){
						groupDeptUserList[index].state = {"disabled" : false};
					}

					//나는 선택가능
					if(groupDeptUserList[index].userId == thisUserTree.myUserId) groupDeptUserList[index].state = {"disabled" : false};

				});
			}


			thisUserTree.makeTree(groupDeptUserList, "0");	//유저그룹 트리 리스트  makeUserGroupTree
		}
	};

	commonAjax("POST", url, param, callback, false);

};//setOrgDeptUserList


/**
 * 트리다시 그리기
 *
 * @param		:
 * @return		:
 * @author		:
 * @date		: 2016. 11. 01.
 */
UserTree.prototype.reDrawTree = function(openType){

	var thisUserTree = this;		//UserTree 를 this 이외에 접근하기 위한 객체변수

	var url = this.url;

	var param = {
			'isOnlyOne' : (this.isOnlyOne?'Y':'N'),		//선택건수 1개 여부
			'isAllOrg' : (this.isAllOrg?'Y':'N'),		//전체 ORG 범위로의 여부
			'oneOrg' : this.oneOrg	,					//전달받은 한개의 ORG ID
			'rtnField' : this.rtnField	,				//전달받은 userId, cusId, empNo
			'isUserGroup' : (this.isUserGroup?'Y':'N'), 	//유저그룹 탭 사용여부
			'hasDeptTopLevel' : (this.hasDeptTopLevel?'Y':'N'), 	//부서의 회장 부서 표시여부  (true: 포함,     그외,: 미포함(default))
			'userStatusFire'	: (this.userStatusFire?'Y':'')	//퇴사자만 조회 여부
	};

	var callback = function(result){
		var rslt = JSON.parse(result);
		var obj = rslt.resultObject;

		var orgList = obj.orgList;		//org list
		var deptObj = obj.deptObj;		//dept list array object 	{ORG1 : [{부서1},{부서2},...], ORG2 : [{부서1},{부서2},...], ...}
		var userObj = obj.userObj;		//user list array object	{ORG1 : [{사용자1},{사용자2},...], ORG2 : [{사용자1},{사용자2},...], ...}

		var groupOrgList = obj.orgList;		//org list
		var groupDeptObj = obj.groupDeptObj;		//dept list array object 	{ORG1 : [{부서1},{부서2},...], ORG2 : [{부서1},{부서2},...], ...}
		var groupUserObj = obj.groupUserObj;		//user list array object	{ORG1 : [{사용자1},{사용자2},...], ORG2 : [{사용자1},{사용자2},...], ...}


		this.orgList = orgList;


		//member variable 로도 세팅
		thisUserTree.orgList = obj.orgList;
		thisUserTree.deptObj = obj.deptObj;
		thisUserTree.userObj = obj.userObj;

		thisUserTree.groupOrgList = obj.groupOrgList;
		thisUserTree.groupDeptObj = obj.groupDeptObj;
		thisUserTree.groupUserObj = obj.groupUserObj;
		thisUserTree.groupUserList = obj.groupUserList;

		var selectOrgList = obj.selectOrgList;

		//초기화 변수들
		thisUserTree.selectedTab = "";
		thisUserTree.g_userIdList = "";
		thisUserTree.g_userIdList = "";
		thisUserTree.isFirstLoad = true;

		var userAuth = '';
		var orgObj = getRowObjectWithValue(selectOrgList, 'orgId', thisUserTree.oneOrg);
		if(orgObj != null){
			userAuth = orgObj.orgAccessAuthType;

		}
		//객체 외부에서 사용할 전역변수
		g_orgIdList_v = obj.orgList;			//ORG 리스트

		for(var i=0; i<orgList.length; i++){	//ORG 리스트 수만큼 트리 생성
			if(orgList[i].orgId != 0){

				if(thisUserTree.useAllCheck){
					var orgChkHtml = '<input onclick="doCheckAllTreeUser(' + orgList[i].orgId + ');" type="checkbox" id="allTree_'+ orgList[i].orgId +'"/>';
					$("#sapnCheckAllTreeUser").html(orgChkHtml);
				}

				var headHtml = "";
				var tabCss = "";
				if(thisUserTree.isUserGroup) tabCss = "mn03";
				else tabCss = "";
				if(openType == "GROUP"){
					if(thisUserTree.useNameSortList){
						headHtml += '<div><ul style="border-top:none; border-right:none; ">';
						headHtml += '<li id="tabZoneDept_'+ orgList[i].orgId +'" ><a href="javascript:selectTabZone(\'DEPT\',' + orgList[i].orgId + ')" >부서별</a></li>';
						headHtml += '<li id="tabZoneUser_'+ orgList[i].orgId +'"><a href="javascript:selectTabZone(\'USER\',' + orgList[i].orgId + ')" >직원별</a></li>';
						if(thisUserTree.isUserGroup){
							headHtml += '<li id="tabZoneGroup_0" class="current"><a href="javascript:selectTabZone(\'GROUP\',' + orgList[i].orgId + ')" >그룹별</a></li>';
						}
						headHtml += '</ul></div>';
					}

					$("#tabZoneTreeList").html(headHtml);

					var treeId = thisUserTree.treeId  + orgList[i].orgId;

					$("#" + thisUserTree.targetID).append('<div id="' + treeId + '" class="tnavi_treezone" style="display:none;"></div>');
					$("#" + thisUserTree.targetID).append('<div id="nameSortList' + thisUserTree.treeId + orgList[i].orgId + '" class="allmem_array_list" style="display:none;"></div>');
					$("#" + thisUserTree.targetID).append('<div id="AXJSTree0" class="tnavi_treezone"></div>');

					$("#groupMgmtButton").show();
				}else{
					if(thisUserTree.useNameSortList){
						headHtml += '<div><ul style="border-top:none; border-right:none; ">';
						headHtml += '<li id="tabZoneDept_'+ orgList[i].orgId +'" class="current"><a href="javascript:selectTabZone(\'DEPT\',' + orgList[i].orgId + ')" >부서별</a></li>';
						headHtml += '<li id="tabZoneUser_'+ orgList[i].orgId +'"><a href="javascript:selectTabZone(\'USER\',' + orgList[i].orgId + ')" >직원별</a></li>';
						if(thisUserTree.isUserGroup){
							headHtml += '<li id="tabZoneGroup_0"><a href="javascript:selectTabZone(\'GROUP\',' + orgList[i].orgId + ')" >그룹별</a></li>';
						}
						headHtml += '</ul></div>';
					}

					$("#tabZoneTreeList").html(headHtml);

					var treeId = thisUserTree.treeId  + orgList[i].orgId;

					$("#" + thisUserTree.targetID).append('<div id="' + treeId + '" class="tnavi_treezone"></div>');
					$("#" + thisUserTree.targetID).append('<div id="nameSortList' + thisUserTree.treeId + orgList[i].orgId + '" class="allmem_array_list" style="display:none;"></div>');
					$("#" + thisUserTree.targetID).append('<div id="AXJSTree0" class="tnavi_treezone" style="display:none;"></div>');

					$("#groupMgmtButton").hide();
				}

				var deptList = deptObj[orgList[i].orgId];
				var userList = userObj[orgList[i].orgId];

				thisUserTree.g_userObjList = userList;
				var deptUserList = deptList.concat(userList);


				if(thisUserTree.authTree){
					deptUserList = nodeDataSet(deptUserList,deptList,userAuth);
				}

				var deptUserCustomList = $.extend(true,[],deptUserList); //userList 객체복사

				//기본 선택 상태
				if(openType != "GROUP"){
					deptUserList.forEach(function(value, index){								//기본 선택상태 세팅 위해
						if(getArrayIndexWithValue(thisUserTree.defaultSelectList, value.id) >= 0){		//찾아서
							deptUserList[index].state = {"selected" : true};					//선택 상태로 세팅  'opened' : true
						}
					});

					//기본 선택 상태(팀별 부서별 직급 부서장 표시를 위해 추가 -sjy)
					deptUserCustomList.forEach(function(value, index){								//기본 선택상태 세팅 위해

						if(deptUserCustomList[index].type == 'user'){
							var str ="<span class='t_name'>"+deptUserCustomList[index].text+"</span>";
			     			str += "<span class='t_position'>"+deptUserCustomList[index].rankNm+"</span>";
			     			str += deptUserCustomList[index].deptManagerYn == "Y" ? "<span class='t_deptM'><em></em></span>" : "";

			     			deptUserCustomList[index].text = str;
						}
						//우선순위 disable 보다 selected 가 위
						if(getArrayIndexWithValue(thisUserTree.defaultSelectList, value.id) >= 0){		//찾아서
							deptUserCustomList[index].state = {"selected" : true};					//선택 상태로 세팅  'opened' : true

						}
					});

				}
				thisUserTree.makeTree(deptUserCustomList, orgList[i].orgId,openType);		//트리 생성
				thisUserTree.makeNameList(JSON.stringify(deptUserList), orgList[i].orgId);	//이름정렬선택 리스트
				thisUserTree.isAllCheckList[orgList[i].orgId] = false;		//디폴드 세팅 (false ..전체해제상태)

			}


		}//for (ORG 리스트 수만큼)

		//그룹별 탭 활성화
		if(thisUserTree.isUserGroup){

			var groupDeptList = groupDeptObj[0];
			var groupUserList = groupUserObj[0];
			var groupDeptUserList = groupDeptList.concat(groupUserList);

			//기본 선택 상태
			if(openType == "GROUP"){
				var isSelected = false;
				groupDeptUserList.forEach(function(value, index){								//기본 선택상태 세팅 위해
					if(getArrayIndexWithValue(thisUserTree.defaultSelectList, value.userId) >= 0){		//찾아서
						if(!isSelected){
							groupDeptUserList[index].state = {"selected" : true};					//선택 상태로 세팅  'opened' : true
							isSelected = true;
						}
					}
				});
				thisUserTree.selectedTab = 'GROUP';
			}

			//권한 트리일때
			if(thisUserTree.authTree){
				groupDeptUserList.forEach(function(value, index){									//기본 선택상태 세팅 위해
					groupDeptUserList[index].state = {"disabled" : true};

					if(getArrayIndexWithValue(enableDeptArr, groupDeptUserList[index].orgDeptId) > -1){
						groupDeptUserList[index].state = {"disabled" : false};
					}

					if(groupDeptUserList[index].orgAccessAuthType == 'SUPER'
						|| groupDeptUserList[index].orgAccessAuthType == 'VIP'
							|| thisUserTree.selectableClickDeptId == '-1'
								|| (thisUserTree.myOrgId != groupDeptUserList[index].orgId
										&& groupDeptUserList[index].orgAccessAuthType != '')){
						groupDeptUserList[index].state = {"disabled" : false};
					}

					//나는 선택가능
					if(groupDeptUserList[index].userId == thisUserTree.myUserId) groupDeptUserList[index].state = {"disabled" : false};

				});
			}


			thisUserTree.makeTree(groupDeptUserList, "0",openType);	//유저그룹 트리 리스트  makeUserGroupTree

			thisUserTree.isAllCheckList[0] = false;		//디폴드 세팅 (false ..전체해제상태)
		}
	};

	commonAjax("POST", url, param, callback, false);

};//reDrawTree

/**
 * 트리 생성 함수 (UserTree Class prototype function)
 *
 * @param		: data	- 그리드 1 row 데이터
 * 				  index	- 특정 index
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
UserTree.prototype.makeTree = function(jsonDeptData, orgId,openType){
	var thisUserTree = this;		//UserTree 를 this 이외에 접근하기 위한 객체변수

	var treeId = thisUserTree.treeId + orgId;

	$("#"+treeId).jstree('destroy');

	$("#"+treeId).jstree({
				'core' : {
							"check_callback" : true,
							"data" : JSON.parse(JSON.stringify(jsonDeptData)),
							"multiple" : !thisUserTree.isOnlyOne,				//다중선택
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
						"themes",  "json_data", "types", "sort", "conditionalselect", (thisUserTree.isCheckbox?"checkbox":null)		/* "wholerow",  "dnd", "crrm", */
				],
				"types" : {
						"default" : {
							//"icon" : "folder"
					  	},
					  	"user" : {
					    	"icon" : contextRoot + "/images/work/red_dot.png"	//(thisUserTree.isCheckbox?null:"../images/work/red_dot.png")	//"http://jstree.com/tree.png"
					  	}
				},
				"sort" :  function (a, b) {
					var aVal = this.get_node(a).original.type;
					var bVal = this.get_node(b).original.type;

					if(aVal == "user") aVal = "cept";
					if(bVal == "user") bVal = "cept";

					aVal += '_' + fillzero(this.get_node(a).original.levelSeq, 7);
					bVal += '_' + fillzero(this.get_node(b).original.levelSeq, 7);
					aVal += '_' + fillzero(this.get_node(a).original.deptOrder, 7);
					bVal += '_' + fillzero(this.get_node(b).original.deptOrder, 7);
					aVal += '_' + fillzero(this.get_node(a).original.deptSeq, 7);
					bVal += '_' + fillzero(this.get_node(b).original.deptSeq, 7);
					aVal += '_' + fillzero(this.get_node(a).original.positionSort, 7);
					bVal += '_' + fillzero(this.get_node(b).original.positionSort, 7);
					aVal += '_' + fillzero(this.get_node(a).original.userId, 7);
					bVal += '_' + fillzero(this.get_node(b).original.userId, 7);

				    //return this.get_node(a).original.type < this.get_node(b).original.type ? 1 : -1;
					return aVal > bVal ? 1 : -1;
				},
				"conditionalselect" : function (node, event) {

					if((node.id).indexOf('DEPT-') != -1){			//부서노드 이면
						if(thisUserTree.isDeptSelectable && !thisUserTree.isOnlyOne){
							return true;
						}else{
							return false;
						}
					}else{									//사용자 노드
						if(thisUserTree.isUserSelectable){	//사용자 선택가능
							return true;
						}else{
							toast.push("부서만 선택 가능 합니다!");
							return false;
						}
					}

					/*
					if(thisUserTree.isDeptSelectable && !thisUserTree.isOnlyOne) return true;

					if(node.id.substr(0,1) == 'D'){			//부서노드 이면
						return false;
					}else{
						return true;
					}*/
			    },
				"dnd" : {
						//
				}}).bind("loaded.jstree",function(event, data){		//첫 로딩시

					//ie 10 이하 버전에서 에러 발생 !! ready 함수로 바인드 2017.01.03 sjy

		    	}).bind("select_node.jstree", function (event, data){

		    		thisUserTree.isFirstLoad = false;				//클릭선택시 에는 무조건 기능동작하도록. (false)

		     	}).bind("open_node.jstree", function (event, data){
		     		var isShowContextmenu = true;
		     		$("a[id*='_anchor']").each(function(){

    		    		var id = $(this).attr("id");
    		    		var idBuf = id.split("_");

    		    		var userId = "";
    		    		var type = "";

    		    		if(parseInt(idBuf[0])) userId=idBuf[0];
    		    		else{
    		    			userId=idBuf[0]+"_"+idBuf[1];
    		    			type = "empId";
    		    		}
    		    		if(userId.indexOf('DEPT-') == -1) {
    		    			if(isShowContextmenu) isShowContextmenu = false;
    		    			openUserProfileBox(userId,$(this),"rClick",null,5,-100,100,type);
    		    		}
    		    	});

		     	}).bind("changed.jstree", function (event, data){

		     		if(!thisUserTree.isFirstLoad){					//첫로딩시(트리생성시) 아닐때
		     			if(thisUserTree.isCallbackEnable)			//콜백함수 사용 가능상태
		     				thisUserTree.changedTree(event, data, orgId, $(this));		//상태 변경 이벤트 리스너 함수 호출
		     		}
		     		thisUserTree.isFirstLoad = false;


		     	}).bind("move_node.jstree",function(event,data){

    		    }).bind("dblclick.jstree",function(event,data){
					//fnObj.doSearchAndPopup(event);
    		    }).bind("ready.jstree",function(event,data){
    		    	//loaded 에서 호출시 ie 10 이하 버전에서 에러 발생 !! ready 함수로 바인드 2017.01.03 sjy

    		    	//하위 부서 open
    		    	if(thisUserTree.openDeptId != '0'){

    		    		var thisNode = $(this).jstree(true).get_node('DEPT-'+thisUserTree.openDeptId+'_anchor');

    		    		if(thisNode != false && thisNode.children_d.length>0){
    		    			var childNodeArr = thisNode.children_d;

    		    			var str ='';
    		    			for(var i=0; i<childNodeArr.length; i++){
    		    				if(childNodeArr[i].indexOf('DEPT-') != -1){
    		    					$(this).jstree('open_node', $('#'+childNodeArr[i]));
    		    				}
    		    			}
    		    		}
    		    	}

    		    	//전체 펼침 ( 전체 펼침 사용 가능 트리)
    		    	if(thisUserTree.nodeOpenEnable) $(this).jstree("open_all");



    		    	if(thisUserTree.isOnlyDeptId && thisUserTree.defaultSelectList.length>0 &&  orgId != "0"){			//부서 id 반환 전용 트리인경우(디폴트 선택 (org id list)이 기본 선택 되도록)
			     		for(var i=0; i<thisUserTree.defaultSelectList.length;i++){


			     			thisUserTree.isAllCheckList[orgId] = false;
							doCheckAllTreeUser(orgId);		//전체 선택
							if(thisUserTree.useAllCheck){
								$("#allTree_" + orgId).attr("checked", true);
							}
						}
					}else if((openType == "GROUP" && orgId == "0") || (openType == "DEPT" && orgId != "0")){
    		    		var isSelectedTree = false;
    			     	if(thisUserTree.defaultSelectList.length>0){			//부서 id 반환 전용 트리인경우(디폴트 선택 (org id list)이 기본 선택 되도록)
    			     		for(var i=0; i<thisUserTree.defaultSelectList.length;i++){
    			     			jsonDeptData.forEach(function(value, index){								//기본 선택상태 세팅 위해
        							if(thisUserTree.defaultSelectList[i] == value.userId){		//찾아서
        								isSelectedTree = true;
        							}
        						});
    						}
    					}
    			     	if(!isSelectedTree ){
    		     			thisUserTree.callbackFn("0", orgId);
    		     		}
    		    	}

    		    	// 접근권한이 없는 유저는 비활성화하기
    		    	if(openType == "GROUP" && orgId == "0"){
    		    		var tmpUserList = thisUserTree.groupUserList;
    	    			for(k=0;k<tmpUserList.length;k++){
    	    				if(tmpUserList[k].authOrgYn == "N"){
    	    					var strHtml = '<dl class="childteam"><i class="icon_cir  off"></i><span class="t_name">'+ tmpUserList[k].userName +'</span></dl>';
    	    					$("#" + tmpUserList[k].id+"_anchor").removeAttr("href");
    	    					$("#" + tmpUserList[k].id+"_anchor").prop("disabled", true);
    	    					$("#" + tmpUserList[k].id+"_anchor").html(strHtml);
    	    				}
    	    			}
    		    	}
    		    	var isShowContextmenu = true;

    		    	$("a[id*='_anchor']").each(function(){

    		    		var id = $(this).attr("id");
    		    		var idBuf = id.split("_");

    		    		var userId = "";
    		    		var type = "";

    		    		if(parseInt(idBuf[0])) userId=idBuf[0];
    		    		else{
    		    			userId=idBuf[0]+"_"+idBuf[1];
    		    			type = "empId";
    		    		}
    		    		if(userId.indexOf('DEPT-') == -1) {
    		    			if(isShowContextmenu) isShowContextmenu = false;
    		    			openUserProfileBox(userId,$(this),"rClick",null,5,-100,100,type);

    		    		}

    		    	});


    		    	if(!isShowContextmenu) $("body").attr("oncontextmenu","return false");
    		        if(thisUserTree.selectDeptId != '0') $(this).jstree('check_node',$("#DEPT-"+thisUserTree.selectDeptId+"_anchor"));

    		    	if(thisUserTree.defaultUseAllCheck) $("#allTree_"+orgId).trigger('click');

    		    	if(thisUserTree.closeAllnode) $(this).jstree("close_all");

    		    	//전체 선택 버튼 감추기
					if(thisUserTree.useAllCheck){

	    		    	if(thisUserTree.selectableClickDeptId != '-1'
	    		    		&& thisUserTree.selectableClickDeptId != ''){

	    		    		var orgAuth = $("#treeOrg option:selected").attr('targetAuth');

	    		    		if(thisUserTree.myOrgId != orgId && orgAuth !='') $("#allTree_"+orgId).show();
	    		    		else if(thisUserTree.myOrgId == orgId && (orgAuth =='SUPER' || orgAuth =='VIP')) $("#allTree_"+orgId).show();
	    		    		else if(thisUserTree.authTree)$("#allTree_"+orgId).hide();

	    		    	}else{
	    		    		$("#allTree_"+orgId).show();
	    		    	}
					}

    		    	if(thisUserTree.beforeOrgId != ''
    		    		&& thisUserTree.beforeOrgId != thisUserTree.oneOrg){

    		    		var treeId = thisUserTree.treeId + thisUserTree.myOrgId;

    		    		$("#"+treeId).remove();
    		    		$("#nameSortList" + treeId).remove();
    		    		$("#AXJSTree0").remove();

    		    		$("#treeOrg").val(thisUserTree.beforeOrgId);
    		    		thisUserTree.oneOrg = thisUserTree.beforeOrgId;

    		    		thisUserTree.beforeOrgId = '';
    		    		thisUserTree.callbackYn = 'Y';
    		    		reloadUserTree('DEPT');
    		    		//thisUserTree.reDrawTree('DEPT');

    		    	}
    		    });
	//2016.12.28. IE 버전에 따라 처음로딩 실패에 따른 분기처리(10.0이하 분기처리함)
	var verString = get_version_of_IE();
	if(verString != "N/A"){
		var verNumber = parseInt ( verString , 10 );
		if(verNumber <= 10  ){
			thisUserTree.isFirstLoad = false;
		}
	}
};//makeTree

/**
 * 변경 이벤트 리스너 함수 (UserTree Class prototype function)
 *
 * @param		: orgId	- 이벤트 해당 ORG
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
UserTree.prototype.changedTree = function(event, data, orgId, treeObj){

	var thisUserTree = this;		//UserTree 를 this 이외에 접근하기 위한 객체변수


	//선택한 노드의 하위 전체 노드 선택(부서일 경우 하위 전체)
	var userList = [];
	if(data.node != undefined){
		userList = data.node.children_d;									//선택한 노드의 하위 children id 찾아
	}
	for(var i=0; i<userList.length; i++){
		if(data.node.state.selected){			//선택한 이벤트일때
			treeObj.jstree(true).select_node(userList[i], true);				//children id 들로 children 도 선택시킨다.
		}else{									//선택해제한 이벤트일때
			treeObj.jstree(true).deselect_node(userList[i], true);				//children id 들로 children 도 선택시킨다.
		}
	}


	//1개 선택 모드일 경우 다른 ORG 가 있을경우 초기화 시킨다
	if(thisUserTree.isOnlyOne && thisUserTree.orgList.length > 1){			//복수 ORG 이면서, 1개 선택 모드일경우
		var orgs = thisUserTree.orgList;
		for(var i=0; i<orgs.length; i++){
			if(orgs[i].orgId != orgId){										//이 트리가 아닌 ORG 트리인것에 대해서
				var treeId = thisUserTree.treeId + orgs[i].orgId;
				$('#' + treeId).jstree("deselect_all", true);//선택 해제
			}
		}
	}


	//선택한 정보를 모은다.(전체 ORG 안에서)
	var userIdList = [];
	var orgs = thisUserTree.orgList;
	for(var i=0; i<orgs.length; i++){
		var sel;

		var treeId = thisUserTree.treeId + orgs[i].orgId;

		if(thisUserTree.isOnlyDeptId){	//부서id 만 결과로 원하는 경우(부모 노드가 없는 최상위만 선택한다...일단 이렇게(바서 옵션으로 나눌 수 있게))
			sel = $('#' + treeId).jstree("get_top_selected");	//최상위 부서 노드
		}else{
			sel = $('#' + treeId).jstree("get_selected");		//선택한 사용자 정보
		}

		userIdList = userIdList.concat(sel);		//모든 ORG 트리에서 선택된 정보를 모은다.
	}


	//선택한 노드중에서
	if(thisUserTree.isOnlyDeptId){		//부서id 만 결과로 원하는 경우(부모 노드가 없는 최상위만 선택한다...일단 이렇게(바서 옵션으로 나눌 수 있게))
		//부서 노드만 선택시킨다
		userIdList = $.grep(userIdList, function(item){
		    return (item.indexOf('DEPT-') != -1);
		});

		//부서 노드 id 에서 앞에 'D' 를 제거해서 실제 부서 id 로 전달
		for(var i=0; i<userIdList.length; i++){
			var userId = userIdList[i];
			var userArr = userId.split('DEPT-');
			userIdList[i] = userArr[1]

		}

	}else{					//사용자 만 결과로 원하는 경우
		//부서 노드는 제외시킨다
		userIdList = $.grep(userIdList, function(item){
		    return (item.indexOf('DEPT-') == -1);
		});

	}

	//alert(JSON.stringify(userIdList));
	//console.debug(userIdList);

	//2016.11.21 이인희  조직 전체선택후 트리 클릭시 전체 조직 선택 해제...
	if(!swAllCheck){
		$("#allTree_" + orgId).attr("checked", false);
		g_userTree.isAllCheckList[orgId] = false;
	}


	/* 콜백함수에 사원리스트(사원)를 담아 최종 호출 */
	// ORG ID 가 0번(그룹별탭) 이면 "userId_deptId" 이므로 userId를 추출한다.
	var rtnUserIdList = [];
	if(orgId == "0"){
		for(i=0;i<userIdList.length;i++){
			var tmpUserId = userIdList[i].split("_");
			rtnUserIdList[i] = tmpUserId[0];
		}
	}else{
		rtnUserIdList = userIdList;
	}

	thisUserTree.g_userIdList = rtnUserIdList;

	if(thisUserTree.callbackYn == 'Y'){
		if(thisUserTree.isReturnObj){
			thisUserTree.callbackFn(rtnUserIdList[0],thisUserTree.g_userObjList,thisUserTree.oneOrg);		//선택된 사용자 id 로 callback 함수 호출
		}else if(thisUserTree.isOnlyOne){
			thisUserTree.callbackFn(rtnUserIdList[0],thisUserTree.oneOrg);		//선택된 사용자 id 로 callback 함수 호출
		}else{
			thisUserTree.callbackFn(rtnUserIdList,thisUserTree.oneOrg);		//선택된 사용자 id array 로 callback 함수 호출
		}
	}

};//changedTree


/**
 * 콜백함수 enable (UserTree Class prototype function)
 *
 * @param		: val	- true : enable, false : disable
 * @return		:
 * @author		:
 * @date		: 2016. 11. 07.
 */
UserTree.prototype.setCallbackEnable = function(val){
	this.isCallbackEnable = val;
};//setCallbackEnable


/**
 * 이름정렬 선택리스트 생성 함수 (UserTree Class prototype function)
 *
 * @param		: data	- 그리드 1 row 데이터
 * 				  index	- 특정 index
 * @return		:
 * @author		:
 * @date		: 2015. 9. 7.
 */
UserTree.prototype.makeNameList = function(jsonDeptData, orgId){

	var thisUserTree = this;		//UserTree 를 this 이외에 접근하기 위한 객체변수

	var userList = JSON.parse(jsonDeptData);
	userList = sortByKey(userList, 'text', 'ASC');		//이름 정렬

	var listHtml = '<ul>';

	var selType = thisUserTree.isOnlyOne?'radio':'checkbox';		//선택 유형

	for(var i=0; i<userList.length; i++){
		var user = userList[i];
		if(user.type=='user'){
			listHtml += '<li><label><input onclick="doCheckNameList(' + thisUserTree.isOnlyOne + ');" value="' + user.id + '"  name="nameSortInputNm' + orgId + '" type="' + selType + '" ';


			if(user.state){

				listHtml += (user.state.disabled ?' disabled=true' : '');
				listHtml += (user.state.selected ?' checked=true' : '');
			}


			listHtml += '/><span>' + user.text + '</span></label></li>';
		}
	}

	listHtml += '</ul>';

	$('#nameSortList'+ thisUserTree.treeId + orgId).html(listHtml);

};//makeNameList






/**
 * 객체 외부에서 사용할 전역변수
 */
var g_userTree;				//UserTree
var g_orgIdList_v;			//ORG 리스트
var g_callbackFn_f;			//콜백함수
var g_orgCallbackFn_f;			//콜백함수



/**
 * 사용자 전체선택 함수
 *
 * @param		: orgId	... 전체선택할 트리 ORG ID
 * @return		:
 * @author		:
 * @date		: 2016. 11. 02
 */
var swAllCheck = false;
function doCheckAllTreeUser(orgId){
	// orgId = g_userTree.oneOrg;
	//전체 선택 버튼 해당 ORG에 따라 전체 선택상태 적용
	swAllCheck = true;
	if(g_userTree.isAllCheckList[orgId] == false){		//전체선택 버튼 누르기전 전체해제 상태이면
		//선택한 ORG 의 사용자를 전체 선택한다.
		if($('#tabZoneUser_' + orgId).hasClass('current')){		//해당 ORG가 직원별 탭에 있을때.
			$('input[name=nameSortInputNm' + orgId + ']').attr('checked', true);	//전체 선택
		}else{																		//해당 ORG가 부서별 탭(트리)에 있을때.
			var treeId = g_userTree.treeId + orgId;
			$('#' + treeId).jstree("select_all", true);								//전체 선택
		}

		g_userTree.isAllCheckList[orgId] = true;

	}else{

		//선택한 ORG 의 사용자를 전체 해제한다.
		if($('#tabZoneUser_' + orgId).hasClass('current')){		//해당 ORG가 직원별 탭에 있을때.
			$('input[name=nameSortInputNm' + orgId + ']').attr('checked', false);	//전체 선택 해제
		}else{																		//해당 ORG가 부서별 탭(트리)에 있을때.
			var treeId = g_userTree.treeId + orgId;
			$('#' + treeId).jstree("deselect_all", true);							//전체 선택 해제
		}

		g_userTree.isAllCheckList[orgId] = false;
	}
	swAllCheck = false;



	//모든 ORG 의 선택된 사용자 정보를 모은다.
	var userIdList = [];
	var orgs = g_orgIdList_v;
	for(var i=0; i<orgs.length; i++){

		if($('#tabZoneUser_' + orgs[i].orgId).hasClass('current')){		//해당 ORG가 직원별 탭에 있을때.
			//선택된 사용자 정보를 모은다.
			var selList = $('input[name=nameSortInputNm' + orgs[i].orgId + ']:checked');
			for(var i=0; i<selList.length; i++){
				userIdList.push(selList[i].value);
			}

		}else{															//해당 ORG가 부서별 탭(트리)에 있을때.
			var treeId = g_userTree.treeId + orgs[i].orgId;

			if(g_userTree.isOnlyDeptId){	//부서id 만 결과로 원하는 경우(부모 노드가 없는 최상위만 선택한다...일단 이렇게(바서 옵션으로 나눌 수 있게))

				userIdList = userIdList.concat($('#' + treeId).jstree("get_top_selected"));		//최상위 부서 노드
			}else{
				userIdList = userIdList.concat($('#' + treeId).jstree("get_selected"));		//모든 ORG 트리에서 선택된 정보를 모은다.

			}
		}

	}


	if(g_userTree.isOnlyDeptId){
		//부서 노드만
		userIdList = $.grep(userIdList, function(item){
		    return (item.indexOf('DEPT-') != -1);
		});

		//부서 노드 id 에서 앞에 'D' 를 제거해서 실제 부서 id 로 전달
		for(var i=0; i<userIdList.length; i++){
			var userId = userIdList[i];
			var userArr = userId.split('DEPT-');
			userIdList[i] = userArr[1]
		}

	}else{
		//부서 노드는 제외시킨다
		userIdList = $.grep(userIdList, function(item){
		    return (item.indexOf('DEPT-') == -1);
		});
	}

	// ORG ID 가 0번(그룹별탭) 이면 "userId_deptId" 이므로 userId를 추출한다.
	var rtnUserIdList = [];
	if(orgId == "0"){
		for(i=0;i<userIdList.length;i++){
			var tmpUserId = userIdList[i].split("_");
			rtnUserIdList[i] = tmpUserId[0];
		}
	}else{
		rtnUserIdList = userIdList;
	}

	g_callbackFn_f(rtnUserIdList,orgId);		//선택된 사용자 id array 로 callback 함수 호출

}//doCheckAllTreeUser


/**
 * 전체 ORG 의 사용자를 모두 해제한다.
 *
 * @param		:
 * @return		:
 * @author		: 이인희
 * @date		: 2016. 11. 14
 */
function doUnCheckAllTreeUser(){
	for(var i=0; i<orgList.length; i++){	//ORG 리스트 수만큼 트리 생성
		//선택한 ORG 의 사용자를 전체 해제한다.
		if($('#tabZoneUser_' + orgList[i].orgId).hasClass('current')){		//해당 ORG가 직원별 탭에 있을때.
			$('input[name=nameSortInputNm' + orgList[i].orgId + ']').attr('checked', false);	//전체 선택 해제
		}else{															//해당 ORG가 부서별 탭(트리)에 있을때.
			var treeId = g_userTree.treeId + orgList[i].orgId;
			$('#' + treeId).jstree("deselect_all", true);							//전체 선택 해제
		}
		// $('#AXJSTree' + orgList[i].orgId).jstree("deselect_all", true);		//전체 선택 해제
		$("#allTree_" + orgList[i].orgId).attr("checked", false);
		g_userTree.isAllCheckList[orgList[i].orgId] = false;
	}
}


/**
 *  사용자id 로 사용자를 선택해제한다.
 *
 * @param		: userId : 선택한 userId
 * @return		:
 * @author		: 이인희
 * @date		: 2016. 11. 14
 */
function doUnCheckTreeUser(userId){
	for(var i=0; i<orgList.length; i++){	//ORG 리스트 수만큼 트리 생성

		var treeId = g_userTree.treeId + orgList[i].orgId;

		$('#' + treeId).jstree(true).deselect_node(userId, true);				//children id 들로 children 도 선택시킨다.
		$("#allTree_" + orgList[i].orgId).attr("checked", false);
	}
}


/**
 *  부서별, 직원별 탭 선택
 *
 * @param		:
 * @return		:
 * @author		: oys
 * @date		: 2016. 12. 27
 */
function selectTabZone(kind, orgId){

	var treeId = g_userTree.treeId + orgId;

	if(kind == 'USER' && g_userTree.selectedTab != 'USER'){			//직원별 탭으로
		$("#groupMgmtButton").hide();

		//선택 상태 표시 ----------------------
		$('#tabZoneUser_' + orgId).addClass('current');
		$('#tabZoneDept_' + orgId).removeClass('current');
		$('#tabZoneGroup_0').removeClass('current');

		$('#nameSortList' + g_userTree.treeId + orgId).show();


		$('#' + treeId).hide();
		if(g_userTree.isUserGroup) $('#AXJSTree0').hide();
		//-----------------------------------


		//이전탭 데이터 싱크 ------------------
		//선택된 사용자 정보를 모은다.
		if(g_userTree.selectedTab == 'GROUP'){
			var userIdList = g_userTree.g_userIdList;  // 선택된 유저

			//모은 사용자 정보로 직원별탭의 이름에 체크
			$('input[name=nameSortInputNm' + orgId + ']').attr('checked', false);
			for(var i=0; i<userIdList.length; i++){
				$('input[name=nameSortInputNm' + orgId + '][value=' + userIdList[i] + ']').attr('checked', true);
			}

		}else{
			var userIdList = [];
			userIdList = userIdList.concat($('#' + treeId).jstree("get_selected"));		//모든 ORG 트리에서 선택된 정보를 모은다.

			//모은 사용자 정보로 직원별탭의 이름에 체크
			$('input[name=nameSortInputNm' + orgId + ']').attr('checked', false);
			for(var i=0; i<userIdList.length; i++){
				$('input[name=nameSortInputNm' + orgId + '][value=' + userIdList[i] + ']').attr('checked', true);
			}
		}
		g_userTree.selectedTab = 'USER';
		//----------------------------------


	}else if(kind == 'DEPT' && g_userTree.selectedTab != 'DEPT'){		//부서별 탭으로

		$("#groupMgmtButton").hide();

		//선택 상태 표시 ----------------------
		$('#tabZoneDept_' + orgId).addClass('current');
		$('#tabZoneUser_' + orgId).removeClass('current');
		$('#tabZoneGroup_0').removeClass('current');



		$('#' + treeId).show();
		$('#nameSortList'+ g_userTree.treeId + orgId).hide();
		if(g_userTree.isUserGroup) $('#AXJSTree0').hide();
		//-----------------------------------


		//이전탭 데이터 싱크 ------------------
		//선택된 사용자 정보를 모은다.
		if(g_userTree.selectedTab == 'GROUP'){
			var userIdList = g_userTree.g_userIdList;  // 선택된 유저

			$('#' + treeId).jstree("deselect_all", true);							//일단 전체 선택 해제
			for(var i=0; i<userIdList.length; i++){
				$('#' + treeId).jstree(true).select_node(userIdList[i], true);	//사용자 정보를 가지고 트리에서 선택 상태로 만든다.
			}
		}else{
			var selList = $('input[name=nameSortInputNm' + orgId + ']:checked');

			$("#" + treeId).jstree("deselect_all", true);							//일단 전체 선택 해제
			for(var i=0; i<selList.length; i++){
				$("#" + treeId).jstree(true).select_node(selList[i].value, true);	//사용자 정보를 가지고 트리에서 선택 상태로 만든다.
			}
		}

		g_userTree.selectedTab = 'DEPT';

		if(g_userTree.closeAllnode) $('#' + treeId).jstree("close_all");
		//----------------------------------
	}else if(kind == 'GROUP' && g_userTree.selectedTab != 'GROUP'){			//그룹별 탭으로

		$("#groupMgmtButton").show();

		//선택 상태 표시 ----------------------
		$('#tabZoneGroup_0').addClass('current');
		$('#tabZoneUser_' + orgId).removeClass('current');
		$('#tabZoneDept_' + orgId).removeClass('current');

		$('#AXJSTree0').show();


		$('#' + treeId).hide();
		$('#nameSortList'+ g_userTree.treeId + orgId).hide();
		//-----------------------------------


		//이전탭 데이터 싱크 ------------------
		//선택된 사용자 정보를 모은다.
		var userIdList = g_userTree.g_userIdList;  // 선택된 유저
		var tmpUserList = g_userTree.groupUserList;

		//ORG ID 가 0번(그룹별탭) 이면 "userId_deptId" 이므로 userId를 추출해서 같으면 선택한다.
		$('#AXJSTree0').jstree("deselect_all", true);							//일단 전체 선택 해제
		for(var i=0; i<userIdList.length; i++){
			for(var j=0; j<tmpUserList.length; j++){
				var tmpUserId = tmpUserList[j].id.split("_");
				if(tmpUserId[0] == userIdList[i]){
					$('#AXJSTree0').jstree(true).select_node(tmpUserList[j].id, true);	//사용자 정보를 가지고 트리에서 선택 상태로 만든다.
					break;
				}
			}
		}

		// 접근권한이 없는 유저는 비활성화하기
		for(k=0;k<tmpUserList.length;k++){
			if(tmpUserList[k].authOrgYn == "N"){
				var strHtml = '<dl class="childteam"><i class="icon_cir  off"></i><span class="t_name">'+ tmpUserList[k].userName +'</span></dl>';
				$("#" + tmpUserList[k].id+"_anchor").removeAttr("href");
				$("#" + tmpUserList[k].id+"_anchor").prop("disabled", true);
				$("#" + tmpUserList[k].id+"_anchor").html(strHtml);
			}
		}

		g_userTree.selectedTab = 'GROUP';
		//----------------------------------


	}

}//selectTabZone


/**
 * 이름정렬 사용자리스트 선택 이벤트 함수
 *
 * @param		:
 * @return		:
 * @author		: oys
 * @date		: 2016. 12. 27
 */
function doCheckNameList(isOnlyOne){

	var userIdList = [];
	var orgs = g_orgIdList_v;
	for(var i=0; i<orgs.length; i++){		//전체 ORG 에서 선택된 정보를 모은다.

		if($('#tabZoneUser_' + orgs[i].orgId).hasClass('current')){		//해당 ORG가 직원별 탭에 있을때.
			//선택된 사용자 정보를 모은다.
			var selList = $('input[name=nameSortInputNm' + orgs[i].orgId + ']:checked');
			for(var i=0; i<selList.length; i++){

				userIdList.push(selList[i].value);
			}

		}else{															//해당 ORG가 부서별 탭(트리)에 있을때
			var treeId = g_userTree.treeId +  orgs[i].orgId;

			var tempList = $('#' + treeId).jstree("get_selected");		//트리에서 선택된 정보를 모은다.
			//부서 노드는 제외시킨다
			tempList = $.grep(tempList, function(item){
			    return (item.indexOf('DEPT-') == -1);
			});
			userIdList = userIdList.concat(tempList);
		}

	}


	/* 콜백함수에 사원리스트(사원)를 담아 최종 호출 */
	g_userTree.g_userIdList = userIdList;

	if(g_userTree.isReturnObj){			//사용자 , jstree userList return

		g_callbackFn_f(userIdList[0],g_userTree.g_userObjList,g_userTree.oneOrg);		//선택된 사용자 id 로 callback 함수 호출

	}else if(isOnlyOne){
		g_callbackFn_f(userIdList[0], g_userTree.oneOrg);		//선택된 사용자 id 로 callback 함수 호출

	}else{
		g_callbackFn_f(userIdList, g_userTree.oneOrg);		//선택된 사용자 id array 로 callback 함수 호출
	}


}//doCheckNameList



//IE버전체크
function get_version_of_IE () {

	 var word;
	 var version = "N/A";

	 var agent = navigator.userAgent.toLowerCase();
	 var name = navigator.appName;

	 // IE old version ( IE 10 or Lower )
	 if ( name == "Microsoft Internet Explorer" ) word = "msie ";

	 else {
		 // IE 11
		 if ( agent.search("trident") > -1 ) word = "trident/.*rv:";

		 // Microsoft Edge
		 else if ( agent.search("edge/") > -1 ) word = "edge/";
	 }

	 var reg = new RegExp( word + "([0-9]{1,})(\\.{0,}[0-9]{0,1})" );

	 if (  reg.exec( agent ) != null  ) version = RegExp.$1 + RegExp.$2;

	 return version;
}

//사용자별 그룹관리 : test.............psj
function processUserGroupInfo(){
	window.open(contextRoot+'/user/processUserGroupInfoPopup.do', 'newinfov','resizable=no,width=968,height=845,scrollbars=yes')
}

//내 관계사 디폴트 draw
function defaultMyOrgTree(){

	var oldOrgId = g_userTree.oneOrg;
	var newOrgId = g_userTree.myOrgId;

	g_userTree.oneOrg = newOrgId;
	g_userTree.beforeOrgId = oldOrgId;
	g_userTree.callbackYn = 'N';
	g_userTree.setOrgDeptUserList();

}

// 기관변경시, 또는 유저트리 리로딩 필요시
function reloadUserTree(openType){
	var oldOrgId = g_userTree.oneOrg;
	var newOrgId = $("#treeOrg").val();

	if(!newOrgId) newOrgId = oldOrgId;

	var treeId = g_userTree.treeId + oldOrgId;

	$("#"+treeId).remove();
	$("#nameSortList" + g_userTree.treeId +oldOrgId).remove();
	$("#AXJSTree0").remove();

	var orgAuth = '';

	var cardStaff = '';
	var cardDept = '';

	if(g_userTree.authTree){
		//관계사 권한
		orgAuth = $("#treeOrg option:selected").attr('targetAuth');

		cardStaff = $("#treeOrg option:selected").attr('staffUserId');
		cardDept = $("#treeOrg option:selected").attr('staffDeptId');

		if(orgAuth == 'SUPER' || orgAuth == 'VIP' || (g_userTree.myOrgId != newOrgId && orgAuth !='')){
			g_userTree.selectableClickDeptId = '';

		}else{

			if(g_userTree.deptManagerDeptId == '-1'){	//권한자 (절대적)
				g_userTree.selectableClickDeptId = '-1';
			}else if(g_userTree.deptManagerDeptId != '') {
				g_userTree.selectableClickDeptId = g_userTree.deptManagerDeptId;
			}else if(g_userTree.deptManagerDeptId == '') g_userTree.selectableClickDeptId ='0';

			//재무 담당 / 담당부서 (슈퍼 권한)
			if(g_userTree.pageType == 'CARD'){
				if(cardStaff == g_userTree.myUserId){
					g_userTree.selectableClickDeptId = '';
				}
				if(cardDept == g_userTree.myDeptId){
					g_userTree.selectableClickDeptId = '';
				}
			}

		}

	}

	g_userTree.oneOrg = newOrgId;
	g_userTree.reDrawTree(openType);

	//orgId 선택시 콜백 호출 상태이면(네트워크/고객 사용중)
	if(g_userTree.isOrgCallbackEnable) {

		g_orgCallbackFn_f(newOrgId);
		/*if(g_userTree.pageType == 'CARD'){
			g_orgCallbackFn_f(cardStaff,cardDept,orgAuth,newOrgId);
		}else */
	}

	if(g_userTree.selectableClickDeptId != '' && g_userTree.selectableClickDeptId != '-1'){
		$("#allTree_"+newOrgId).hide();
	}else{
		$("#allTree_"+newOrgId).show();
	}

}


/**
 * 그리드 리스트 반환
 *
 * @param		:
 *
 * @return		:
 * @author		:
 * @date		: 2017. 10. 16.
 */

function returnUserList(){

	return g_userTree.g_userObjList;

};//returnUserList



var enableDeptArr = new Array();	//선택가능 부서

function nodeDataSet(userList,deptList,auth){

	var allUserCheck = false;

	//타관계사 무조건 리드권한 이상
	if(g_userTree.myOrgId != g_userTree.oneOrg && auth !='') g_userTree.selectableClickDeptId = ''
	else if(auth != 'SUPER' && auth != 'VIP' && g_userTree.selectableClickDeptId != '-1' && g_userTree.selectableClickDeptId != ''){
		if(g_userTree.selectableClickDeptId != '0') enableDeptSet(deptList,g_userTree.selectableClickDeptId);
		allUserCheck = true;
	}

	if(allUserCheck){
		for(var i=0; i<userList.length; i++){


			userList[i].state = {"disabled" : true};		//전체 disable

			if(getArrayIndexWithValue(enableDeptArr,userList[i].deptId) > -1){
				userList[i].state = {"disabled" : false};
			}
		}
	}

	return userList;

}

//부서
function enableDeptSet(deptList,userDeptId){

	enableDeptArr.push(parseInt(g_userTree.selectableClickDeptId));

	for(var i=0; i<deptList.length; i++){
		if(deptList[i].parentDeptId == g_userTree.selectableClickDeptId){
			enableDeptArr.push(deptList[i].deptId);
			enableDeptSet2(deptList,deptList[i].deptId)
		}
	}

}

//하위부서 찾기
function enableDeptSet2(deptList,parentDeptId){

	for(var i=0; i<deptList.length; i++){

		if(deptList[i].parentDeptId == parentDeptId){
			enableDeptArr.push(deptList[i].deptId);
			enableDeptSet2(deptList,deptList[i].deptId);
		}
	}
}
