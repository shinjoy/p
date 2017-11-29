<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" defer="defer">
	var orderList = ["name","cpnNm","deptNm"];	//order 정보 셋팅 : 트리
	var orderEleIdx = -1;	//order 정보 셋팅
	var orderEleClass = "";	//order 정보 셋팅

	var orderListGroup = ["GROUP_NM","GROUP_USER_CNT"];	//order 정보 셋팅 : 그룹
	var orderEleIdxGroup = -1;	//order 정보 셋팅
	var orderEleClassGroup = "";	//order 정보 셋팅

	var orderListGroupUser = ["name","cpnNm","deptNm"];	//order 정보 셋팅 :그룹유저
	var orderEleIdxGroupUser = -1;	//order 정보 셋팅
	var orderEleClassGroupUser = "";	//order 정보 셋팅


	var orgInfoJson;	//조직도 정보 제이슨
	var dbclick=false; //그룹 테이블의 클릭/더블클릭 이벤트를 구분

	var isGroupProc = true; //그룹 등록/수정 /삭제 가능여부

	var searchOrgUserListJson = ""; //트리검색 json
	var searchGroupUserListJson = ""; //그룹유저검색 json
	$(document).ready(function(){
		doLoadTreeview();
		addGroupTableEvent();

		$("#userGroupTable tbody tr").eq(0).trigger("click");

		$("body").attr("onBeforeUnload","closePop()");
	});

	//조직정보를 트리로 만들어 해당 영역에 만듬
	function doLoadTreeview(){
		var url = contextRoot + "/personnel/getOrganizationListInfoList.do";
    	var param = {};

    	var callback = function(result){
    		//alert(result);
    		var obj = JSON.parse(result);
    		orgInfoJson = JSON.stringify(obj.resultList);
    		viewTree(orgInfoJson);

    	};

    	commonAjax("POST", url, param, callback);
	}

	//################# else function :E #################
    function viewTree(jsonDeptData) {
    	$('#orgTreeArea').jstree('destroy');

    	$('#orgTreeArea').jstree({
    				'core' : {
    							"check_callback" : true,
    							"data" : JSON.parse(jsonDeptData),
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
    					  	"ALL" : {
    					  		"select_node": false
    					  	},
    					  	"ORG" : {

    					  	},
    					  	"DEPT" : {

    					  	}

    				},
    				"conditionalselect" : function (node, event) {
    					if(node.type == 'ALL'){			//그룹노드이면
    						return false;
    					}else{
    						$("#searchName").val("");

    						for(var i = 0 ; i < orderList.length ; i++){
    				    		$("#sort_column_prefix"+i).attr("class" , "sort_normal");
    				    	}
							var childDt = node.children_d;
    						orderEleIdx = -1;
    						orderEleClass = "";

    						var childDt = node.children_d;
    						searchOrgUserList(node.type,node.id,childDt);
    						return true;
    					}
    			    },
    				"dnd" : {
    						//
    				}}).bind("loaded.jstree",function(event, data){		//첫 로딩시
    					 $(this).jstree("open_node","ALL");
    		    	}).bind("select_node.jstree", function (event, data){


    		     	}).bind("changed.jstree", function (event, data){


    		     	}).bind("move_node.jstree",function(event,data){
        		    }).bind("click.jstree",function(event,data){


    					//fnObj.doSearchAndPopup(event);
        		    }).bind("ready.jstree",function(event,data){
        		    	//loaded 에서 호출시 ie 10 이하 버전에서 에러 발생 !! ready 함수로 바인드 2017.01.03 sjy
        		    });;
 	}

	//트리에서 관계사를 선택했을때
	function searchOrgUserList(type,id,childDt){
		var url = contextRoot + "/personnel/getOrgUserList.do";
		var param = {};
		if(type == "ORG"){

			$("#searchId").val(id);
			$("#type").val(type);
			param = {orgId : id , searchOrder : $("#searchOrder").val()};
		}else if(type == "DEPT"){

			var idBuf = id.split("_");
			var deptId = idBuf[1];

			$("#searchId").val(id);
			$("#type").val(type);

			if(childDt!=null&&childDt.length>0){
				var deptArrStr = deptId;
				for(var i = 0;i<childDt.length;i++){

					var deptIdBuf = childDt[i].split("_");
					var deptArrId = deptIdBuf[1];
					deptArrStr += ","+deptArrId;
				}

				param = {searchDeptArr : deptArrStr};
			}else{
				param = {deptId : deptId, searchOrder : $("#searchOrder").val()};
			}
		}else if(type == "NAME"){
			$("#type").val(type);
			param = {searchName : $("#searchName").val() , searchOrder : $("#searchOrder").val()};
		}
		searchOrgUserListJson = "";
    	commonAjax("POST", url, param, searchOrgUserListCallback);
	}

	//트리 검색 콜백
	function searchOrgUserListCallback(result){
		var obj;
		if(searchOrgUserListJson == ""){
			obj = JSON.parse(result);
		}else{
			obj=result;
		}
		var stStr = '';
		for(var i = 0 ; i < obj.resultVal; i++){
			stStr += '<tr id = "'+obj.resultList[i].userId+'_tr">';
			stStr += '<td scope="row"><label><input type="checkbox" name = "userIdList" value = "'+obj.resultList[i].userId+'" onclick="toggleCheckBox()"/></label></td>';
			stStr += '<td>'+obj.resultList[i].name+'<span class="mblevel">('+obj.resultList[i].userRankNm+')</span></td>';
			stStr += '<td>'+obj.resultList[i].cpnNm+'</td>';
			stStr += '<td>'+obj.resultList[i].deptNm+'</td>';
			stStr += '</tr>'
		}

		if(stStr == '') {
			stStr = '<tr class="tr_selected2"><td colspan="4">선택된 직원이 없습니다.</td></tr>';
		}
		$("#userSearchTable tbody").html(stStr);

		$("#searchOrder").val("");
		$("#type").val("");

		searchOrgUserListJson = obj;
	}
	//그룹 유저 추가
	function addGropuUser(){
		var chk = true;
		if($("#searchUserGroupId").val()==""){
			alert("그룹을 선택해 주세요.");
			return;
		}


		var k = 0;
		$("#userSearchTable tbody").find("input[type='checkbox']:checked").each(function(i){
			var user_id = $(this).val();
			if($("#userGroupUserTable").find("#"+user_id+"_tr").length>0){
				return true;
			}
			$("#userGroupUserTable tbody").append($("#"+user_id+"_tr").clone());
			k++;
		});

		if($("#userSearchTable tbody input[type='checkbox']").length==0){
			var stStr = "";
			stStr += '<tr id = "emptyTr" class="tr_selected2"><td colspan="4">선택된 직원이 없습니다.</td></tr>';
			$("#userSearchTable tbody").html(stStr);

		}else{
			$("#emptyTr").remove();
			if(k>0){
				//$("a[name='userSortArea']").hide();
				//$("span[name = 'userNoneSortArea']").show();
				isGroupProc = false;
				var $target = $("input[name = 'userGroupId'][value='"+$("#searchUserGroupId").val()+"']");
				var beforeUserCnt = $target.parent().find("input[name='groupUserCntBuf']").val();

				var afterUserCnt = parseInt(beforeUserCnt)+k;
				$target.parent().find("input[name='groupUserCntBuf']").val(afterUserCnt);
				$target.parent().parent().find("td[name='userCnt']").text(afterUserCnt);
			}
		}

		$("#userSearchTable input[type='checkbox']").prop("checked",false);
		$("#userGroupUserTable input[type='checkbox']").prop("checked",false);
		doSave();

	}
	//그룹 유저 삭제
	function deleteGropuUser(){
		var chk = true;
		if($("#searchUserGroupId").val()==""){
			alert("그룹을 선택해 주세요.");
			return;
		}


		var k = 0;
		$("#userGroupUserTable tbody").find("input[type='checkbox']:checked").each(function(i){
			var user_id = $(this).val();
			$(this).parent().parent().parent().remove();
			k++;
		});

		if($("#userGroupUserTable tbody input[type='checkbox']").length==0){
			var stStr = "";
			stStr += '<tr id = "emptyTr" class="tr_selected2"><td colspan="4">선택된 직원이 없습니다.</td></tr>';
			$("#userGroupUserTable tbody").html(stStr);

		}else{
			$("#emptyTr").remove();
			if(k>0){
				//$("a[name='userSortArea']").hide();
				//$("span[name = 'userNoneSortArea']").show();
				isGroupProc = false;
				var $target = $("input[name = 'userGroupId'][value='"+$("#searchUserGroupId").val()+"']");
				var beforeUserCnt = $target.parent().find("input[name='groupUserCntBuf']").val();

				var afterUserCnt = parseInt(beforeUserCnt)-k;
				$target.parent().find("input[name='groupUserCntBuf']").val(afterUserCnt);
				$target.parent().parent().find("td[name='userCnt']").text(afterUserCnt);
			}
		}

		$("#userSearchTable input[type='checkbox']").prop("checked",false);
		$("#userGroupUserTable input[type='checkbox']").prop("checked",false);
		doSave();
	}
	//컬럼 소팅
    function doSort(idx){

		if(searchOrgUserListJson == ""){
			return;
		}
		var beforeClass = $("#sort_column_prefix"+idx).attr("class");
		var afterClass = "";
		if(beforeClass == "sort_normal"||beforeClass == "sort_hightolow"){
			afterClass = "sort_lowtohigh";
		}else if(beforeClass == "sort_lowtohigh"){
			afterClass = "sort_hightolow";
		}
		var sort = afterClass == "sort_hightolow"?"DESC":"ASC";
		//var sortSql = orderList[idx]+" "+sort;
		//$("#searchOrder").val(sortSql);
		searchOrgUserListJson.resultList = sortByKey(searchOrgUserListJson.resultList, orderList[idx],sort);

		searchOrgUserListCallback(searchOrgUserListJson);

    	$("#sort_column_prefix"+idx).attr("class" , afterClass);
    	orderEleIdx = idx;
    	orderEleClass = afterClass;

    	for(var i = 0 ; i < orderList.length ; i++){
    		if(i!=idx) $("#sort_column_prefix"+i).attr("class" , "sort_normal");
    	}
    }
	//이름으로 검색
	function searchName(){
		var searchName = $("#searchName").val();
		if(searchName == "") {
			alert("검색이름을 한글자 이상 입력하세요.");
			$("#searchName").focus();
			return;
		}
		$("#searchId").val("");
		viewTree(orgInfoJson);
		searchOrgUserList("NAME",null);
	}
	//체크박스 전체선택
	function toggleCheckBoxAll(tableId){
		if($("#"+tableId+" thead input[type='checkbox']").prop("checked")){
			$("#"+tableId+" tbody input[type='checkbox']").prop("checked",true);
		}else{
			$("#"+tableId+" tbody input[type='checkbox']").prop("checked",false);
		}
	}
	//체크박스 부분선택 체크
	function toggleCheckBox(){
		if($("#userSearchTable tbody input[type='checkbox']").length!=0){
			if($("#userSearchTable tbody input[type='checkbox']:checked").length == $("#userSearchTable tbody input[type='checkbox']").length){
				$("#userSearchTable thead input[type='checkbox']").prop("checked",true);
			}else{
				$("#userSearchTable thead input[type='checkbox']").prop("checked",false);
			}
		}
		if($("#userGroupUserTable tbody input[type='checkbox']").length!=0){
			if($("#userGroupUserTable tbody input[type='checkbox']:checked").length == $("#userGroupUserTable tbody input[type='checkbox']").length){
				$("#userGroupUserTable thead input[type='checkbox']").prop("checked",true);
			}else{
				$("#userGroupUserTable thead input[type='checkbox']").prop("checked",false);
			}
		}
	}

	//그룹 클릭/더블클릭/그룹명 포커스아웃 이벤트
	function addGroupTableEvent(){
		$("tr[name = 'userGroupTr']").click(function(){

			if(!isGroupProc){
				if(!confirm("수정된 그룹 직원 정보는 저장되지 않습니다.\n진행하시겠습니까? ")){
					return;
				}else{
					isGroupProc = true;
					var $target = $("input[name = 'userGroupId'][value='"+$("#searchUserGroupId").val()+"']");
					var userCnt = $target.parent().find("input[name='groupUserCnt']").val();
					$target.parent().find("input[name='groupUserCntBuf']").val(userCnt);
					$target.parent().parent().find("td[name='userCnt']").text(userCnt);

					$("a[name='userSortArea']").show();
					$("span[name = 'userNoneSortArea']").hide();
				}
			}

			$("tr[name = 'userGroupTr']").removeClass("tr_selected");
			$(this).addClass("tr_selected");
			$("#searchUserGroupId").val($(this).find("input[name='userGroupId']").val());

			reloadGroupUserList();
        }).dblclick(function(){
        	$(this).find("span").hide();
            $(this).find("input[name='groupNm']").show().focus();
        });

		$("input[name='groupNm']").focusout(function(e){

			$("tr[name = 'userGroupTr']").removeClass("tr_selected");
			$("input[name='groupNm']").hide();
			$("#userGroupTable tbody span").show();

			if($(this).val() == ""){
				if($("#groupNmNew").length>0){
					$("#groupNmNew").parent().parent().remove();
					$("#searchUserGroupId").val("");
					return;
				}else{
					$(this).val($(this).parent().find("span").text());
					$("#searchUserGroupId").val("");
					return;
				}
			}
			processUserGroup();
		});
	}
	//그룹 추가/수정/삭제
	function processUserGroup(){
		var chk = true;
		$("input[name='groupNm']").each(function(){
			if($(this).val() == ""){
				alert("그룹명을 입력해 주세요.");
				chk = false;
				return false;
			}
		});

		if(!chk) return;

		var url = contextRoot + "/personnel/processUserGroupAjax.do";
		var $target = $("input[name = 'userGroupId'][value='"+$("#searchUserGroupId").val()+"']");
		var userGroupId = $target.val();
		var groupOrd = $target.parent().find("input[name='groupOrd']").val();
		var groupNm = $target.parent().find("input[name='groupNm']").val();
		var param = {userGroupId:userGroupId,groupOrd:groupOrd,groupNm:groupNm};

		var callback = function(result){
    		//alert(result);
    		var obj = JSON.parse(result);
    		if(obj.result == "SUCCESS"){
    			var returnCnt = parseInt(obj.returnCnt);
    			if(returnCnt>0)
    				$("#searchUserGroupId").val(returnCnt);

    			reloadUserGroup();
    		}else{
    			alert("저장에 실패했습니다. 다시 시도해 주세요.");
    			window.close();
    		}
    	};

    	commonAjax("POST", url, param, callback);

	}
	//그룹 추가(화면)
	function addGroup(){

		if(!isGroupProc){
			if(!confirm("수정된 그룹 직원 정보는 저장되지 않습니다.\n진행하시겠습니까? ")){
				return;
			}else{
				isGroupProc = true;
				var $target = $("input[name = 'userGroupId'][value='"+$("#searchUserGroupId").val()+"']");
				var userCnt = $target.parent().find("input[name='groupUserCnt']").val();
				$target.parent().find("input[name='groupUserCntBuf']").val(userCnt);
				$target.parent().parent().find("td[name='userCnt']").text(userCnt);

				//$("a[name='userSortArea']").show();
				//$("span[name = 'userNoneSortArea']").hide();
			}
		}

		$("#searchUserGroupId").val("");
		$("#emptyGroupTr").remove();
		$("tr[name = 'userGroupTr']").removeClass("tr_selected");

		var sort = $("#userGroupTable tbody tr").length +1;
		var sortTxt = sort<10?"0"+sort:sort;
		var stStr = '';
		stStr += '<tr name="userGroupTr" class = "tr_selected">';
		stStr += '<td scope="row">'+sortTxt+'</td>';
		stStr += '<td class="txt_left">';
		stStr += '<span></span>';
		stStr += '<input type="text" name = "groupNm" id="groupNmNew" placeholder="그룹명을 입력" class="input_b w100pro" value="" />';
		stStr += '<input type="hidden" name = "groupOrd" value="'+sort+'" />';
		stStr += '<input type="hidden" name = "userGroupId" value="" />';
		stStr += '</td>';
		stStr += '<td class="num_date_type">0</td></tr>';
		$("#userGroupTable tbody").append(stStr);


		stStr = '<tr class="tr_selected2"><td colspan="4">선택된 직원이 없습니다.</td></tr>';

		$("#userGroupUserTable tbody").html(stStr);

		addGroupTableEvent();
		setTimeout(function(){$("#groupNmNew").focus()}, 100);
	}
	//유저그룹 리로드
	function reloadUserGroup(){
		var url = contextRoot + "/user/getUserGroupList.do";
		var param = {searchOrder : $("#searchOrderGroup").val()};
		var callback = function(result){
    		//alert(result);
    		var obj = JSON.parse(result);
    		var stStr = '';
    		for(var i = 0 ; i < obj.resultVal; i++){
    			var sort = obj.resultList[i].groupOrd;
    			var sortTxt = parseInt(sort)<10?"0"+sort:sort;
				stStr += '<tr name="userGroupTr">';
				stStr += '<td scope="row">'+sortTxt+'</td>';
				stStr += '<td class="txt_left">';
				stStr += '<span>'+obj.resultList[i].groupNm+'</span>';
				stStr += '<input type="text" name = "groupNm" style="display: none;" placeholder="그룹명을 입력" class="input_b w100pro" value="'+obj.resultList[i].groupNm+'" />';
				stStr += '<input type="hidden" name = "groupOrd" value="'+obj.resultList[i].groupOrd+'" />';
				stStr += '<input type="hidden" name = "groupUserCnt" value="'+obj.resultList[i].groupUserCnt+'" />';
				stStr += '<input type="hidden" name = "groupUserCntBuf" value="'+obj.resultList[i].groupUserCnt+'" />';
				stStr += '<input type="hidden" name = "userGroupId" value="'+obj.resultList[i].userGroupId+'" /></td>';

				stStr += '<td class="num_date_type" name="userCnt">'+obj.resultList[i].groupUserCnt+'</td>';
				stStr += '</tr>';
    		}

    		if(stStr == '') {
    			stStr = '<tr class="tr_selected2" id = "emptyGroupTr"><td colspan="4">선택된 직원이 없습니다.</td></tr>';
    		}
    		$("#userGroupTable tbody").html(stStr);


    		//$("#searchOrderGroup").val("");
    		//$("#searchUserGroupId").val("");

    		addGroupTableEvent();

    		var searchUserGroupId = $("#searchUserGroupId").val();
    		if(searchUserGroupId != ""){
    			var $target = $("input[name = 'userGroupId'][value='"+$("#searchUserGroupId").val()+"']");
    			$target.parent().parent().trigger("click");
    		}

    	};

    	commonAjax("POST", url, param, callback);

	}
	//그룹유저리스트조회
	function reloadGroupUserList(){
		var url = contextRoot + "/personnel/getGroupDetailUserListAjax.do";
		var $target = $("input[name = 'userGroupId'][value='"+$("#searchUserGroupId").val()+"']");
		var userGroupId = $target.val();

		var param = {userGroupId:userGroupId,searchOrder : $("#searchOrderGroupUser").val()};

		searchGroupUserListJson = "";
    	commonAjax("POST", url, param, reloadGroupUserListCallback);
	}
	//그룹유저리스트 조회 콜백
	function reloadGroupUserListCallback(result){
		var obj;

		if(searchGroupUserListJson == ""){
			obj = JSON.parse(result);
		}else{
			obj=result;
		}
		var stStr = '';
		for(var i = 0 ; i < obj.resultVal; i++){
			stStr += '<tr id = "'+obj.resultList[i].userId+'_tr">';
			stStr += '<td scope="row"><label><input type="checkbox" name = "userIdList" value = "'+obj.resultList[i].userId+'" onclick="toggleCheckBox()"/></label></td>';
			stStr += '<td>'+obj.resultList[i].name+'<span class="mblevel">('+obj.resultList[i].userRankNm+')</span></td>';
			stStr += '<td>'+obj.resultList[i].cpnNm+'</td>';
			stStr += '<td>'+obj.resultList[i].deptNm+'</td>';
			stStr += '</tr>'
		}

		if(stStr == '') {
			stStr = '<tr class="tr_selected2" id = "emptyTr"><td colspan="4">선택된 직원이 없습니다.</td></tr>';
		}
		$("#userGroupUserTable tbody").html(stStr);

		$("#searchOrder").val("");

		searchGroupUserListJson = obj;
	}

	//그룹 컬럼 소팅
    function doSortGroup(idx){

		var beforeClass = $("#sort_column_group_prefix"+idx).attr("class");
		var afterClass = "";
		if(beforeClass == "sort_normal"||beforeClass == "sort_hightolow"){
			afterClass = "sort_lowtohigh";
		}else if(beforeClass == "sort_lowtohigh"){
			afterClass = "sort_hightolow";
		}
		var sort = afterClass == "sort_hightolow"?"DESC":"ASC";
		var sortSql = orderListGroup[idx]+" "+sort;
		$("#searchOrderGroup").val(sortSql);

		reloadUserGroup();

    	$("#sort_column_group_prefix"+idx).attr("class" , afterClass);
    	orderEleIdxGroup = idx;
    	orderEleClassGroup = afterClass;

    	for(var i = 0 ; i < orderList.length ; i++){
    		if(i!=idx) $("#sort_column_group_prefix"+i).attr("class" , "sort_normal");
    	}
    }

  	//그룹 유저 컬럼 소팅
    function doSortGroupUser(idx){

		var beforeClass = $("#sort_user_column_group_prefix"+idx).attr("class");
		var afterClass = "";
		if(beforeClass == "sort_normal"||beforeClass == "sort_hightolow"){
			afterClass = "sort_lowtohigh";
		}else if(beforeClass == "sort_lowtohigh"){
			afterClass = "sort_hightolow";
		}
		var sort = afterClass == "sort_hightolow"?"DESC":"ASC";
		//var sortSql = orderListGroupUser[idx]+" "+sort;
		//$("#searchOrderGroupUser").val(sortSql);
		searchGroupUserListJson.resultList = sortByKey(searchGroupUserListJson.resultList, orderList[idx],sort);
		//reloadGroupUserList();
		reloadGroupUserListCallback(searchGroupUserListJson);

    	$("#sort_user_column_group_prefix"+idx).attr("class" , afterClass);
    	orderEleIdxGroupUser = idx;
    	orderEleClassGroupUser = afterClass;

    	for(var i = 0 ; i < orderList.length ; i++){
    		if(i!=idx) $("#sort_user_column_group_prefix"+i).attr("class" , "sort_normal");
    	}
    }

	//그룹수정(화면)
	function modifyGroup(){

		if(!isGroupProc){
			if(!confirm("수정된 그룹 직원 정보는 저장되지 않습니다.\n진행하시겠습니까? ")){
				return;
			}else{
				isGroupProc = true;
				var $target = $("input[name = 'userGroupId'][value='"+$("#searchUserGroupId").val()+"']");
				var userCnt = $target.parent().find("input[name='groupUserCnt']").val();
				$target.parent().find("input[name='groupUserCntBuf']").val(userCnt);
				$target.parent().parent().find("td[name='userCnt']").text(userCnt);

				$("a[name='userSortArea']").show();
				$("span[name = 'userNoneSortArea']").hide();

				reloadGroupUserList();
			}
		}


		var searchUserGroupId = $("#searchUserGroupId").val();
		if(searchUserGroupId == ""){
			alert("수정할 그룹을 선택해 주세요.");
			return;
		}
		var $target=$("input[name = 'userGroupId'][value='"+searchUserGroupId+"']").parent().parent();
		$target.find("span").hide();

		setTimeout(function(){$target.find("input[name='groupNm']").show().focus();}, 100);


	}
	//그룹삭제
	function deleteGroup(){

		if(!isGroupProc){
			if(!confirm("수정된 그룹 직원 정보는 저장되지 않습니다.\n진행하시겠습니까? ")){
				return;
			}else{
				isGroupProc = true;
				var $target = $("input[name = 'userGroupId'][value='"+$("#searchUserGroupId").val()+"']");
				var userCnt = $target.parent().find("input[name='groupUserCnt']").val();
				$target.parent().find("input[name='groupUserCntBuf']").val(userCnt);
				$target.parent().parent().find("td[name='userCnt']").text(userCnt);

				$("a[name='userSortArea']").show();
				$("span[name = 'userNoneSortArea']").hide();
			}
		}

		var searchUserGroupId = $("#searchUserGroupId").val();
		if(searchUserGroupId == ""){
			alert("삭제할 그룹을 선택해 주세요.");
			return;
		}

		if($("#userGroupTable tbody tr").length<2){
			alert("마지막 그룹은 삭제할 수 없습니다.");
			return;
		}
		var url = contextRoot + "/personnel/deleteUserGroupAjax.do";
		var $target = $("input[name = 'userGroupId'][value='"+$("#searchUserGroupId").val()+"']");
		var userGroupId = $target.val();
		var param = {userGroupId:userGroupId,groupOrd:$target.parent().find("input[name='groupOrd']").val()};

		var callback = function(result){
    		var obj = JSON.parse(result);
    		if(obj.result == "SUCCESS"){
    			reloadUserGroup();
    			stStr = '<tr class="tr_selected2"><td colspan="4">선택된 직원이 없습니다.</td></tr>';

    			$("#userGroupUserTable tbody").html(stStr);

    			$("#searchUserGroupId").val("");
    		}else{
    			alert("삭제에 실패했습니다. 다시 시도해 주세요.");
    			window.close();
    		}
    	};
		if(confirm('삭제하시겠습니까?')){
    		commonAjax("POST", url, param, callback);
		}
	}
	//그룹 복사
	function copyGroup(){

		if($("#searchUserGroupId").val() == ""){
			alert("그룹을 선택해 주세요.");
			return;
		}
		if(!isGroupProc){
			if(!confirm("수정된 그룹 직원 정보는 저장되지 않습니다.\n진행하시겠습니까? ")){
				return;
			}else{
				isGroupProc = true;
				var $target = $("input[name = 'userGroupId'][value='"+$("#searchUserGroupId").val()+"']");
				var userCnt = $target.parent().find("input[name='groupUserCnt']").val();
				$target.parent().find("input[name='groupUserCntBuf']").val(userCnt);
				$target.parent().parent().find("td[name='userCnt']").text(userCnt);

				$("a[name='userSortArea']").show();
				$("span[name = 'userNoneSortArea']").hide();
			}
		}
		var url = contextRoot + "/personnel/copyUserGroupAjax.do";

		var param = {userGroupId:$("#searchUserGroupId").val()};

		var callback = function(result){
    		//alert(result);
    		var obj = JSON.parse(result);
    		if(obj.result == "SUCCESS"){
    			$("#searchUserGroupId").val("");
    			var returnCnt = parseInt(obj.resultObject.returnCnt);
    			if(returnCnt>0)
    				$("#searchUserGroupId").val(returnCnt);

    			reloadUserGroup();
    		}else{
    			alert("저장에 실패했습니다. 다시 시도해 주세요.");
    			window.close();
    		}
    	};

    	commonAjax("POST", url, param, callback);
	}

	//그룹 userList 저장
	function doSave(){
		if($("#searchUserGroupId").val()==""){
			alert("저장할 그룹을 선택해 주세요.");
			return;
		}
		var url = contextRoot + "/personnel/procUserGroupDetailAjax.do";
		var $target = $("input[name = 'userGroupId'][value='"+$("#searchUserGroupId").val()+"']");
		var userGroupId = $target.val();

		var userListStr = "";
		$("#userGroupUserTable tbody").find("input[type='checkbox']").each(function(i){
			var userId = $(this).val();
			if(i>0) userListStr +=",";
			userListStr+=userId;
		});
		var param = {userGroupId:userGroupId,userListStr:userListStr};

		var callback = function(result){
    		//alert(result);
    		var obj = JSON.parse(result);
    		if(obj.result == "SUCCESS"){
    			reloadUserGroup();
    			//reloadGroupUserList();
    			$("a[name='userSortArea']").show();
				$("span[name = 'userNoneSortArea']").hide();
				isGroupProc = true;

				//alert("저장되었습니다.");
    		}else{
    			alert("저장에 실패했습니다. 다시 시도해 주세요.");
    			window.close();
    		}
    	};

    	commonAjax("POST", url, param, callback);
	}
	//순서변경
	function chgOrder(type){
		if($("#searchUserGroupId").val() == ""){
			alert("그룹을 선택해 주세요.");
			return;
		}

		if(!isGroupProc){
			if(!confirm("수정된 그룹 직원 정보는 저장되지 않습니다.\n진행하시겠습니까? ")){
				return;
			}else{
				isGroupProc = true;
				var $target = $("input[name = 'userGroupId'][value='"+$("#searchUserGroupId").val()+"']");
				var userCnt = $target.parent().find("input[name='groupUserCnt']").val();
				$target.parent().find("input[name='groupUserCntBuf']").val(userCnt);
				$target.parent().parent().find("td[name='userCnt']").text(userCnt);

				$("a[name='userSortArea']").show();
				$("span[name = 'userNoneSortArea']").hide();
			}
		}
		var userGroupId = $("#searchUserGroupId").val();
		var targetUserGroupId = "";
		var $target = $("input[name = 'userGroupId'][value='"+$("#searchUserGroupId").val()+"']");

		switch(type){
		case 'TOP' :
			if($target.parent().parent().prev().length==0){
				alert("이미 첫번째 그룹입니다.");
				return;
			}
			targetUserGroupId = $("input[name = 'userGroupId']").eq(0).val();
			break;
		case 'prev' :
			if($target.parent().parent().prev().length==0){
				alert("첫번째 그룹입니다.");
				return;
			}
			targetUserGroupId = $target.parent().parent().prev().find("input[name = 'userGroupId']").val();
			break;
		case 'next' :
			if($target.parent().parent().next().length==0){
				alert("이미 마지막 그룹입니다.");
				return;
			}
			targetUserGroupId = $target.parent().parent().next().find("input[name = 'userGroupId']").val();
			break;
		case 'BOT' :
			if($target.parent().parent().next().length==0){
				alert("이미 마지막 그룹입니다.");
				return;
			}
			targetUserGroupId = $("input[name = 'userGroupId']").eq($("input[name = 'userGroupId']").length-1).val();
			break;
		}

		if(targetUserGroupId == ""){
			alert("순서변경에 실패했습니다. 다시 시도해 주세요.");
			window.close();
		}

		var url = contextRoot + "/personnel/procUserGroupSortOrderAjax.do";

		var param = {userGroupId:userGroupId,targetUserGroupId:targetUserGroupId};

		var callback = function(result){
    		//alert(result);
    		var obj = JSON.parse(result);
    		if(obj.result == "SUCCESS"){
    			reloadUserGroup();
    			$("a[name='userSortArea']").show();
				$("span[name = 'userNoneSortArea']").hide();
    		}else{
    			alert("저장에 실패했습니다. 다시 시도해 주세요.");
    			window.close();
    		}
    	};

    	commonAjax("POST", url, param, callback);

	}
	//창을 닫는다
	function closePop(){
		$("body").attr("onBeforeUnload","");
		window.opener.reloadUserTree("GROUP");
		window.close();
	}
</script>
<!-- 조직도 트리검색을 위한 파라미터 -->
<input type="hidden" id = "searchId" name = "searchId">
<input type="hidden" id = "type" name = "type">
<input type="hidden" id = "searchOrder" name = "searchOrder">
<!-- 그룹관리를 위한 파라미터 -->
<input type="hidden" id = "searchUserGroupId" name = "searchUserGroupId">
<input type="hidden" id = "searchOrderGroup" name = "searchOrderGroup">
<!-- 그룹유저 파라미터 -->
<input type="hidden" id = "searchOrderGroupUser" name = "searchOrderGroupUser">

<div class="popModal_wrap bggray">
		<h3 class="pop_title">그룹관리</h3>
		<div class="mo_container">
			<div class="groupMgmtWrap">
				<div class="fl_block">
					<h3 class="h3_title_basic">직원 리스트</h3>
					<p class="rightsearch">
						<input type="text" placeholder="직원이름입력" id = "searchName" name = "searchName" onkeypress="if(event.keyCode==13) searchName();"/>
						<button type="button" onclick="searchName()">검색</button>
					</p>
					<div class="group_orgBox" id = "orgTreeArea"></div>

					<div class="selmb_listWrap">
						<!-- 직원리스트 -->
						<table class="datagrid_basic last_lineadd" summary="직원리스트 (직원명, 회사명, 부서명)" id = "userSearchTable">
				            <caption>직원리스트</caption>
				            <colgroup>
				               <col width="40" />
				               <col width="*" />
				               <col width="*" />
				               <col width="*" />
				           </colgroup>
				            <thead>
				                <tr>
				                    <th scope="col"><label><input type="checkbox" onclick="toggleCheckBoxAll('userSearchTable')"/></label></th>
				                    <th scope="col"><a href="#" onclick="doSort(0);" id="sort_column_prefix0" class="sort_normal">이름<span class="mblevel">(직위)</span><em>정렬</em></a></th>
				                    <th scope="col"><a href="#" onclick="doSort(1);" id="sort_column_prefix1" class="sort_normal">회사<em>정렬</em></a></th>
				                    <th scope="col"><a href="#" onclick="doSort(2);" id="sort_column_prefix2" class="sort_normal">부서<em>정렬</em></a></th>
				                    <!-- <th scope="col"><a href="#" onclick="fnObj.doSort(3);" id="sort_column_prefix3" class="sort_normal">사번<em>정렬</em></a></th> -->
				                </tr>
				            </thead>
				            <tbody>
				            	<tr class="tr_selected2">
				            		<td colspan="4">선택된 직원이 없습니다.</td>
				            	</tr>
				            </tbody>
				        </table>
						<!--/ 직원리스트 /-->
					</div>
				</div>
				<div class="fr_block">
					<h3 class="h3_title_basic">그룹관리</h3>
					<div class="selgr_listWrap">
						<!-- 그룹관리리스트 -->
						<table id="userGroupTable" class="datagrid_basic last_lineadd" summary="그룹관리 리스트 (순번, 그룹명, 직원수)">
				            <caption>그룹관리 리스트</caption>
				            <colgroup>
				               <col width="60">
				               <col width="*">
				               <col width="80">
				           </colgroup>
				            <thead>
				                <tr>
				                    <th scope="col">순번</th>
				                    <th scope="col">
				                    	<!-- <a href="#" onclick="doSortGroup(0);" id="sort_column_group_prefix0" name="userSortArea" class="sort_normal">그룹명<em>정렬</em></a> -->
				                    	<span>그룹명</span>
				                    </th>
				                    <th scope="col">
				                    	<!-- <a href="#" onclick="doSortGroup(1);" id="sort_column_group_prefix1" name="userSortArea" class="sort_normal">직원수<em>정렬</em></a> -->
				                    	<span>직원수</span>
				                    </th>
				                </tr>
				            </thead>
				            <tbody>
				            	<c:forEach items="${getUserGroupList }" var="data">
				            		 <tr name="userGroupTr">
						            	<td scope="row">
						            		<c:if test="${data.groupOrd <10}">0</c:if>${data.groupOrd }
						            	</td>
						            	<td class="txt_left">
						            		<span>${data.groupNm }</span>
						            		<input type="text" name = "groupNm" style="display: none;" placeholder="그룹명을 입력" class="input_b w100pro" value="${data.groupNm }" />
						            		<input type="hidden" name = "groupOrd" value="${data.groupOrd }" />
						            		<input type="hidden" name = "groupUserCnt" value="${data.groupUserCnt }" />
						            		<input type="hidden" name = "groupUserCntBuf" value="${data.groupUserCnt }" />
											<input type="hidden" name = "userGroupId" value="${data.userGroupId }" />
						            	</td>
						            	<td class="num_date_type" name="userCnt">${data.groupUserCnt }</td>
						            </tr>
				            	</c:forEach>
				            	<c:if test="${fn:length(getUserGroupList)<=0 }">
				            		<tr class="tr_selected2" id = "emptyGroupTr">
					            		<td colspan="3">저장된 그룹이 없습니다.</td>
					            	</tr>
				            	</c:if>
				            </tbody>
				        </table>
						<!--/ 그룹관리리스트 /-->
					</div>
					<div class="btn_groupCtall">
						<div class="fl_block">
							<button type="button" onclick="addGroup()">그룹추가</button>
							<button type="button" onclick="modifyGroup()">그룹수정</button>
							<button type="button" onclick="deleteGroup()">그룹삭제</button>
							<button type="button" onclick="copyGroup()">그룹복사</button>
						</div>
						<div class="fr_block">
							<button type="button" onclick="chgOrder('TOP')"><span class="icon_upend"><em>최상단으로</em></span></button>
							<button type="button" onclick="chgOrder('prev')"><span class="icon_up"><em>위로</em></span></button>
							<button type="button" onclick="chgOrder('next')"><span class="icon_down"><em>아래로</em></span></button>
							<button type="button" onclick="chgOrder('BOT')"><span class="icon_downend"><em>최하단으로</em></span></button>
						</div>
					</div>
					<div class="selmb_listWrap">
						<table id="userGroupUserTable" class="datagrid_basic last_lineadd" summary="그룹내 회원리스트 (직원명, 회사명, 부서명)">
				            <caption>그룹내 회원리스트</caption>
				            <colgroup>
				               <col width="40" />
				               <col width="*" />
				               <col width="*" />
				               <col width="*" />
				           </colgroup>
				            <thead>
				                <tr>
				                    <th scope="col"><label><input type="checkbox" onclick="toggleCheckBoxAll('userGroupUserTable')"/></label></th>
				                    <th scope="col">
				                    	<a href="#" onclick="doSortGroupUser(0);" id="sort_user_column_group_prefix0" name="userSortArea" class="sort_normal">이름<span class="mblevel">(직위)</span><em>정렬</em></a>
				                    	<span style="display: none;" name="userNoneSortArea">이름<span class="mblevel">(직위)</span></span>
				                    </th>
				                    <th scope="col">
				                    	<a href="#" onclick="doSortGroupUser(1);" id="sort_user_column_group_prefix1" name="userSortArea" class="sort_normal">회사<em>정렬</em></a>
				                    	<span style="display: none;" name="userNoneSortArea">회사</span>
				                    </th>
				                    <th scope="col">
				                    	<a href="#" onclick="doSortGroupUser(2);" id="sort_user_column_group_prefix2" name="userSortArea" class="sort_normal">부서<em>정렬</em></a>
				                    	<span style="display: none;" name="userNoneSortArea">부서</span>
				                    </th>
				                    <!-- <th scope="col"><a href="#" onclick="fnObj.doSort(3);" id="sort_column_prefix3" class="sort_normal">사번<em>정렬</em></a></th> -->
				                </tr>
				            </thead>
				            <tbody>
					            <tr id = "emptyTr" class="tr_selected2">
				            		<td colspan="4">선택된 직원이 없습니다.</td>
				            	</tr>
				            </tbody>
				        </table>
					</div>
				</div>
				<div class="selmb_btnzone">
					<button type="button" onclick="addGropuUser()"><span class="icon_add"><em>추가</em></span></button>
					<button type="button" onclick="deleteGropuUser()"><span class="icon_delete"><em>삭제</em></span></button>
				</div>
			</div>
			<div class="btnZoneBox">
				<!-- <a href="#" onclick="doSave();return false;" class="p_blueblack_btn"><strong>저장</strong></a> -->
				<a href="#" onclick="closePop()" class="p_withelin_btn">닫기</a>
			</div>
		</div>
	</div>

