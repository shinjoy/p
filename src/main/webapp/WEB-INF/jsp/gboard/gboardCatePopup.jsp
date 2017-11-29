<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>



<link href="<c:url value='/css/new_network.css'/>" rel="stylesheet" type="text/css">

<!-- ============== style css :S ============== -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jquery-ui.css">				<!-- jquery-ui -->
<!-- ============== style css :E ============== -->


<script type="text/javascript">
    $(document).ready(function(){
    	numberFormatForDigitClass();
		//공통코드조회
        var comCodeType = getBaseCommonCode('GENERAL_BOARD_WRITE_TYPE', null, 'CD', 'NM', null, null, null, { orgId : "${baseUserLoginInfo.applyOrgId}" });
        var comCodeCommentType = getBaseCommonCode('GENERAL_BOARD_COMMENT_WRITE_TYPE', null, 'CD', 'NM', null, null, null, { orgId : "${baseUserLoginInfo.applyOrgId}" });
        //라디오박스 생성
        var radioTag = createRadioTag('writerType', comCodeType, 'CD', 'NM', null, 17, null, 'fnObj.clickWriterType(this)');    //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        var readRadioTag = createRadioTag('readType', comCodeType, 'CD', 'NM', null, 17, null, 'fnObj.clickReadType(this)');    //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        var commentRadioTag = createRadioTag('commentWriterType', comCodeCommentType, 'CD', 'NM', null, 17, null, null);    //'fnObj.clickRdBudget(this);');//radio tag creator 함수 호출 (common.js)
        //화면 셋팅
        $("#writerTypeTag").html(radioTag);
        $("#readTypeTag").html(readRadioTag);
        $("#commentTypeTag").html(commentRadioTag);
        //All에 체크
        $("input[type='radio'][name='writerType'][value='ALL']").prop("checked", true);
        $("input[type='radio'][name='readType'][value='ALL']").prop("checked", true);
        $("input[type='radio'][name='commentWriterType'][value='ALL']").prop("checked", true);


    });
    </script>
<!-- -------- each page css :S -------- -->
<style type="text/css">

</style>
<!-- -------- each page css :E -------- -->

<form name="writerTypeForm" id="writerTypeForm" action="" method="post" style="height:500px; overflow-y:scroll; ">
    <input type="hidden" id = "writerTypeList" name = "writerTypeList">


	<div class="modalWrap2">
		<div class="mo_container">
	    	<table id="SGridTarget" class="tb_basic_left">
	        	<colgroup>
		       		<col width="15%"/>
		       		<col width="30%"/>
					<col width="15%" />
					<col width="30%"/>
				</colgroup>
				<tbody>
				<tr>
					<th scope="row">게시판그룹</th>
					<td><span id="groupListDiv"></span></td>
					<th scope="row">공개여부</th>
		 			<td>
		 				<span class="radio_list2">
		  					<label><input type="radio" name="openFlag" value="Y" checked /><span>공개</span></label>
		   					<label><input type="radio" name="openFlag" value="N" /><span>비공개</span></label>
		   				</span>
		 			</td>
				</tr>
				<tr>
	 				<th scope="row">이름</th>
	 				<td><input type="text" id="gboardName" placeholder="게시판 이름을 입력하세요" onchange="fnObj.changeBoardName();" value="" class="input_b w100pro" maxlength="12"/></td>
	 				<th scope="row">순서</th>
                    <td><input type="text" id="sort" placeholder="순서를 입력하세요" value="" class="input_b w100pro digit" /></td>
	 			</tr>
		 		<tr>
		 			<th scope="row">설명</th>
		 			<td colspan="3"><input type="text" id="gboardDesc" placeholder="게시판설명을 입력하세요" value="" class="input_b w100pro" /></td>
				</tr>
				<tr>
					<th scope="row">사용여부</th>
		 			<td>
		 				<span class="radio_list2">
		  					<label><input type="radio" name="deleteFlag" value="N" checked /><span>사용</span></label>
		   					<label><input type="radio" name="deleteFlag" value="Y" /><span>사용안함</span></label>
		   				</span>
		 			</td>
		 			<th scope="row">헤드라인</th>
		 			<td>
		  				<span class="radio_list2">
		   					<label><input type="radio" name="noticeYn" value="Y" checked /><span>사용</span></label>
		   					<label><input type="radio" name="noticeYn" value="N" /><span>사용안함</span></label>
		  				</span>
		 			</td>
				</tr>
				<tr>
		 			<th scope="row">댓글</th>
		 			<td>
		  				<span class="radio_list2">
		   					<label><input type="radio" name="replyYn" value="Y" checked /><span>사용</span></label>
		   					<label><input type="radio" name="replyYn" value="N" /><span>사용안함</span></label>
		  				</span>
		 			</td>
		 			<th scope="row">파일첨부</th>
		 			<td class="last">
		  				<span class="radio_list2">
		   					<label><input type="radio" name="fileYn" value="Y" checked /><span>사용</span></label>
		   					<label><input type="radio" name="fileYn" value="N" /><span>사용안함</span></label>
		  				</span>
		 			</td>
				</tr>
				<tr>
		 			<th scope="row">노출갯수</th>
		 			<td>
		 				<select id="listCount" class="select_b">
			   				<option value="15">15</option>
			   				<option value="20">20</option>
			   				<option value="30">30</option>
			   				<option value="50">50</option>
		   				</select>
		 			</td>
		 			<th scope="row">페이지갯수</th>
		 			<td>
		 				<select id="pageCount" class="select_b">
			   				<option value="5">5</option>
			   				<option value="10">10</option>
			   				<option value="15">15</option>
		   				</select>
		 			</td>
				</tr>
				<tr >
                    <th scope="row"  id="approveCcTh">게시판 작성권한</th>
                    <td colspan="3">
                        <span id="writerTypeTag"  class="radio_list2"></span>
                        <a id = "writerTypeDept" href="javascript:fnObj.openEmpPopup('DEPT');" class="btn_select_team mgl10" style="display: none;">
                            <em>부서선택</em>
                        </a>
                        <a id = "writerTypeUser" href="javascript:fnObj.openEmpPopup('USER');" class="btn_select_employee mgl10" style="display: none;">
                            <em>직원선택</em>
                        </a>
                    </td>
                </tr>
                <tr id = "approveCcTr" style="display: none;">
                    <td colspan="3" class="dot_line" id = "approveCcArea">
                    </td>
                </tr>
                <tr >
                    <th scope="row"  id="approveReadCcTh">게시판 읽기권한</th>
                    <td colspan="3">
                        <span id="readTypeTag"  class="radio_list2"></span>
                        <a id = "readTypeDept" href="javascript:fnObj.openReadEmpPopup('READDEPT');" class="btn_select_team mgl10" style="display: none;">
                            <em>부서선택</em>
                        </a>
                        <a id = "readTypeUser" href="javascript:fnObj.openReadEmpPopup('READUSER');" class="btn_select_employee mgl10" style="display: none;">
                            <em>직원선택</em>
                        </a>
                    </td>
                </tr>
                <tr id = "approveReadCcTr" style="display: none;">
                    <td colspan="3" class="dot_line" id = "approveReadCcArea">
                    </td>
                </tr>
                <tr >
                    <th scope="row">댓글 쓰기 권한자</th>
                    <td colspan="3">
                        <span id="commentTypeTag"  class="radio_list2"></span>
                    </td>
                </tr>
			</tbody>
		</table>
    	<div class="btnZoneBox">
	    	<a href="javascript:fnObj.doSave();" class="p_blueblack_btn btn_auth"><strong>저장</strong></a>
	    	<a href="javascript:fnObj.doClose();" class="p_withelin_btn">닫기</a>
        </div>
	</div>
</div>

</form>

<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
<%--
var lang = '${userLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')
--%>
//공통코드(외,코드)
var myGrid = new SGrid(); 		// instance


var g_gboardId ='${gboardId}';
var g_groupId  ='${groupId}';
var groupList;					//그룹리스트
//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {


	//선로딩코드
	preloadCode : function(){
		fnObj.getGroupList();
	},

	//화면세팅
    pageStart : function(){
    	 var str = createSelectTag("groupId", groupList, 'groupId', 'groupName', '${groupId}', '', '', 181, 'select_b');
    	 $("#groupListDiv").html(str);

    },//end pageStart.

    doSearch : function(){
    	var url = contextRoot + "/gboard/getBoardCateList.do";
    	var param = { groupId : g_groupId , gboardId:g_gboardId};
		var callback = function(result){
    		var obj = JSON.parse(result);
    		var resultList = obj.resultList;
    		for(var i=0;i<resultList.length;i++){
    			$("#groupId").val(resultList[i].groupId);
    			$("#sort").val(resultList[i].sort);
    			$("#gboardName").val(resultList[i].gboardName);
    			$("#gboardDesc").val(resultList[i].gboardDesc);
    			$("input:radio[name=deleteFlag]:input[value=" + resultList[i].deleteFlag + "]").prop("checked", true);
    			$("input:radio[name=noticeYn]:input[value=" + resultList[i].noticeYn + "]").prop("checked", true);
    			$("input:radio[name=replyYn]:input[value=" + resultList[i].replyYn + "]").prop("checked", true);
    			$("input:radio[name=fileYn]:input[value=" + resultList[i].fileYn + "]").prop("checked", true);
    			$("#listCount").val(resultList[i].listCount);
    			$("#pageCount").val(resultList[i].pageCount);
    			$("input:radio[name=writerType]:input[value=" + resultList[i].writerType + "]").prop("checked", true);
    			$("input:radio[name=readType]:input[value=" + resultList[i].readerType + "]").prop("checked", true);
    			$("input:radio[name=commentWriterType]:input[value=" + resultList[i].commentWriterType + "]").prop("checked", true);
    			$("input:radio[name=openFlag]:input[value=" + resultList[i].openFlag + "]").prop("checked", true);
    			popType = resultList[i].writerType;
    			readPopType = resultList[i].readerType;
    		}
    	};
    	commonAjax("POST", url, param, callback, false);
    },

    doSearchWriter : function(){
    	if(popType != "ALL"){
    		var url = contextRoot + "/gboard/getGboardWriterList.do";
            var param = { groupId : g_groupId , gboardId:g_gboardId};
            var callback = function(result){
                var obj = JSON.parse(result);
                var resultList = obj.resultList;
                for(var i=0;i<resultList.length;i++){
                    $("#approveCcArea").empty();
                    switch(popType){
                    case 'DEPT':
                    	$("#writerTypeDept").show();
                        $("#writerTypeUser").hide();
                        for(var i = 0 ; i <resultList.length; i++){
                            $("#approveCcTh").attr("rowspan","2");
                            $("#approveCcTr").show();
                           var usrHtml = '';
                           usrHtml += '<span class="employee_list" >';
                           usrHtml += '<strong>'+ resultList[i].deptNm +'</strong><a href="#" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                           usrHtml += '<input type="hidden" name="arrDeptId" id="arrDeptId" value="'+resultList[i].deptId+'"/>';
                           usrHtml += '</span>';

                           $("#approveCcArea").append(usrHtml);
                        }
                        break;
                    case 'USER':
                    	$("#writerTypeDept").hide();
                        $("#writerTypeUser").show();
                        for(var i = 0 ; i <resultList.length; i++){
                            $("#approveCcTh").attr("rowspan","2");
                            $("#approveCcTr").show();

                            var usrHtml = '';
                            usrHtml += '<span class="employee_list" >';
                            usrHtml += '<strong>'+ resultList[i].userNm +'</strong><a href="#" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                            usrHtml += '<input type="hidden" name="arrUserId" id="arrUserId" value="'+resultList[i].userId+'"/>';
                            usrHtml += '</span>';
                            $("#approveCcArea").append(usrHtml);
                        }
                        break;
                    }
                }
            };
            commonAjax("POST", url, param, callback, false);
    	}

    },
    doSearchReader : function(){
    	if(readPopType != "ALL"){
    		var url = contextRoot + "/gboard/getGboardReaderList.do";
            var param = { groupId : g_groupId , gboardId:g_gboardId};
            var callback = function(result){
                var obj = JSON.parse(result);
                var resultList = obj.resultList;
                for(var i=0;i<resultList.length;i++){
                    $("#approveReadCcArea").empty();
                    switch(readPopType){
                    case 'DEPT':
                    	$("#readTypeDept").show();
                        $("#readTypeUser").hide();
                        for(var i = 0 ; i <resultList.length; i++){
                            $("#approveReadCcTh").attr("rowspan","2");
                            $("#approveReadCcTr").show();
                           var usrHtml = '';
                           usrHtml += '<span class="employee_list" >';
                           usrHtml += '<strong>'+ resultList[i].deptNm +'</strong><a href="#" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                           usrHtml += '<input type="hidden" name="arrReadDeptId" id="arrReadDeptId" value="'+resultList[i].deptId+'"/>';
                           usrHtml += '</span>';

                           $("#approveReadCcArea").append(usrHtml);
                        }
                        break;
                    case 'USER':
                    	$("#readTypeDept").hide();
                        $("#readTypeUser").show();
                        for(var i = 0 ; i <resultList.length; i++){
                            $("#approveReadCcTh").attr("rowspan","2");
                            $("#approveReadCcTr").show();

                            var usrHtml = '';
                            usrHtml += '<span class="employee_list" >';
                            usrHtml += '<strong>'+ resultList[i].userNm +'</strong><a href="#" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                            usrHtml += '<input type="hidden" name="arrReadUserId" id="arrReadUserId" value="'+resultList[i].userId+'"/>';
                            usrHtml += '</span>';
                            $("#approveReadCcArea").append(usrHtml);
                        }
                        break;
                    }
                }
            };
            commonAjax("POST", url, param, callback, false);
    	}

    },

  	//검색(메뉴리스트)
    getCateInfo : function(){
    	if(g_groupId != 0){
    		fnObj.doSearch();
    		fnObj.doSearchWriter();
    		fnObj.doSearchReader();
    	}
    },

    //그룹 리스트
    getGroupList : function(){
		var url = contextRoot + "/gboard/getBoardGroupList.do";
    	var param = {};
		var callback = function(result){
    		var obj = JSON.parse(result);
    		var resultObj = obj.resultObject;
    		var list = resultObj.list;
    		groupList = list;
    	};
    	commonAjax("POST", url, param, callback, false);
    },

  	//저장
    doSave : function(){

    	var groupId		= $("#groupId").val();								//그룹아이디
    	var sort	= $("#sort").val();							//게시판 ID
    	var gboardName	= $("#gboardName").val();							//게시판명
    	var gboardDesc	= $("#gboardDesc").val();							//게시판설명
    	var deleteFlag	= $("input[type='radio'][name=deleteFlag]:checked").val();	//숨김여부
    	var noticeYn	= $("input[type='radio'][name=noticeYn]:checked").val();	//헤드라인기능
    	var replyYn		= $("input[type='radio'][name=replyYn]:checked").val();		//답글기능
    	var fileYn		= $("input[type='radio'][name=fileYn]:checked").val();		//파일첨부기능
    	var listCount	= $("#listCount").val();							//리스트갯수
    	var pageCount	= $("#pageCount").val();							//페이지갯수
    	var writerType  = $('input[type="radio"][name="writerType"]:checked').val();//게시판 작성권한
    	var readType    = $('input[type="radio"][name="readType"]:checked').val();  //게시판 읽기권한
		var commentWriterType = $('input:radio[name="commentWriterType"]:checked').val();  //게시판 댓글쓰기권한

		var openFlag =  $("input:radio[name=openFlag]:checked").val();

    	/* var arrDeptId  = $("#arrDeptId").val(); */
    	var arrDeptId  = [];
    	$("input[name=arrDeptId]").each(function(){
    		arrDeptId.push($(this).val());
        });

    	/* var arrReadDeptId  = $("#arrReadDeptId").val(); */
    	var arrReadDeptId  = [];
    	$("input[name=arrReadDeptId]").each(function(){
    		arrReadDeptId.push($(this).val());
        });
    	var arrUserId  = [];
    	$("input[name=arrUserId]").each(function(){
    		arrUserId.push($(this).val());
    	});

    	var arrReadUserId  = [];
    	$("input[name=arrReadUserId]").each(function(){
    		arrReadUserId.push($(this).val());
    	});

    	if(groupId == null){
    		alert("그룹을 선택해 주세요.");
    		$("#groupId").focus();
    		return;
    	}
    	//게시판 아이디 유효성 검사
    	/* if(strInNumNEn(cboardUid)){
    		alert("게시판ID는 영문,숫자만 가능합니다.");
    		$("#cboardUid").focus();
    		return;
    	} */
    	if(isEmpty(gboardName)){
    		alert("게시판명을 입력하세요.");
    		$("#gboardName").focus();
    		return;
    	}
    	if(isEmpty(sort)){
            alert("순서를 입력하세요.");
            $("#sort").focus();
            return;
        }
    	if(isEmpty(gboardDesc)){
    		alert("게시판설명을 입력하세요.");
    		$("#gboardDesc").focus();
    		return;
    	}

    	if(writerType == "DEPT" && isEmpty(arrDeptId.join())){
            alert("게시판 작성권한이 부서인 경우는 부서선택이 필수 입니다.");
            $("#writerType").focus();
            return;
        }

    	if(writerType == "USER" && isEmpty(arrUserId.join())){
            alert("게시판 작성권한이 사용자인 경우는 직원선택이 필수 입니다.");
            $("#writerType").focus();
            return;
        }

    	if(readType == "DEPT" && isEmpty(arrReadDeptId.join())){
            alert("게시판 읽기권한이 부서인 경우는 부서선택이 필수 입니다.");
            $("#readType").focus();
            return;
        }

    	if(readType == "USER" && isEmpty(arrReadUserId.join())){
            alert("게시판 읽기권한이 사용자인 경우는 직원선택이 필수 입니다.");
            $("#readType").focus();
            return;
        }

    	var url = contextRoot + "/gboard/saveBoardCate.do";
    	var param = {
    			gboardId	: g_gboardId,
    			groupId 	: groupId,
    			sort 	: sort,
    			gboardName 	: gboardName,
    			gboardDesc 	: gboardDesc,
    			deleteFlag 	: deleteFlag,
    			noticeYn 	: noticeYn,
    			replyYn 	: replyYn,
    			fileYn 		: fileYn,
    			listCount 	: listCount,
    			pageCount 	: pageCount,
    			writerType : writerType,
    			readType   : readType,
    			commentWriterType: commentWriterType ,
    			openFlag  : openFlag,
    			arrUserId : arrUserId.join(),
    			arrDeptId : arrDeptId.join(),
    			arrReadUserId : arrReadUserId.join(),
    			arrReadDeptId : arrReadDeptId.join()

    	};

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var resultObj = obj.resultObject;
    		var saveChk = resultObj.saveChk;	//저장여부 검사

    		if(saveChk ==0){
    			alert("저장에 실패하였습니다.");
    			return false;
    		}else{
    			parent.toast.push("완료되었습니다.");
    			parent.fnObj.clickGroup(groupId);
    			fnObj.doClose();
    		}

    	};

    	commonAjax("POST", url, param, callback, false);
    },

    doClose : function(){
    	parent.myModal.close();
    },

    clickWriterType : function(){
    	$("#approveCcArea").empty();
        $("#approveCcTh").attr("rowspan","1");
        $("#approveCcTr").hide();
        if($("input[name='writerType']:checked").val()=='ALL'){
            $("#writerTypeDept").hide();
            $("#writerTypeUser").hide();
        }else if($("input[name='writerType']:checked").val()=='DEPT'){
        	$("#writerTypeDept").show();
            $("#writerTypeUser").hide();
        }else if($("input[name='writerType']:checked").val()=='USER'){
            $("#writerTypeDept").hide();
            $("#writerTypeUser").show();
        }
    },
    clickReadType : function(){
    	$("#approveReadCcArea").empty();
        $("#approveReadCcTh").attr("rowspan","1");
        $("#approveReadCcTr").hide();
        if($("input[name='readType']:checked").val()=='ALL'){
            $("#readTypeDept").hide();
            $("#readTypeUser").hide();
        }else if($("input[name='readType']:checked").val()=='DEPT'){
        	$("#readTypeDept").show();
            $("#readTypeUser").hide();
        }else if($("input[name='readType']:checked").val()=='USER'){
            $("#readTypeDept").hide();
            $("#readTypeUser").show();
        }
    },
  	//직원선택 팝업   (idx : activity index, knd : 'project' 프로젝트전체에 배정하는 케이스)
    openEmpPopup: function(type){
    	popType = type;

        /* var arrDeptId  = $("#arrDeptId").val();
        if(isEmpty(arrDeptId)) arrDeptId = ""; */

        var arrDeptId = [];
        $("input[name=arrDeptId]").each(function(){
            arrDeptId.push($(this).val());
        });

        var arrUserId  = [];
        $("input[name=arrUserId]").each(function(){
        	arrUserId.push($(this).val());
        });

        var paramList = [];
        var paramObj ={ name : 'userList'   ,value :  (type=='USER') ? arrUserId.join() : arrDeptId.join() };
        paramList.push(paramObj);
        paramObj ={ name : 'isOneOrg' ,value : 'Y'};
        paramList.push(paramObj);
        paramObj ={ name : 'isAllOrgSelect' ,value : 'Y'};  //관계사 직원 다중선택가능 옵션
        paramList.push(paramObj);
        paramObj ={ name : 'isDeptSelect' , value : (type=='USER') ? 'N' : 'Y'};  //직원,부선 옵션
        paramList.push(paramObj);
        paramObj ={ name : 'isOneDept' ,value : 'N'};
        paramList.push(paramObj);

        userSelectPopCall(paramList);       //공통 선택 팝업 호출
    },
  	//읽기권한 직원선택 팝업   (idx : activity index, knd : 'project' 프로젝트전체에 배정하는 케이스)
    openReadEmpPopup: function(type){
    	popType = type;

        var arrDeptId = [];
        $("input[name=arrReadDeptId]").each(function(){
        	arrDeptId.push($(this).val());
        });
        /* if(isEmpty(arrDeptId)) arrDeptId = ""; */
        var arrUserId  = [];
        $("input[name=arrReadUserId]").each(function(){
        	arrUserId.push($(this).val());
        });


        var paramList = [];
        var paramObj ={ name : 'userList'   ,value :  (type=='READUSER') ? arrUserId.join() : arrDeptId.join() };
        paramList.push(paramObj);
        paramObj ={ name : 'isOneOrg' ,value : 'Y'};
        paramList.push(paramObj);
        paramObj ={ name : 'isAllOrgSelect' ,value : 'Y'};  //관계사 직원 다중선택가능 옵션
        paramList.push(paramObj);
        paramObj ={ name : 'isDeptSelect' , value : (type=='READUSER') ? 'N' : 'Y'};  //직원,부선 옵션
        paramList.push(paramObj);
        paramObj ={ name : 'isOneDept' ,value : 'N'};
        paramList.push(paramObj);

        userSelectPopCall(paramList);       //공통 선택 팝업 호출
    },

  	//사원 및 부서 선택 팝업에서 선택한 데이터를 처리
    getResult: function(resultList){

    	switch(popType){
        case 'DEPT':
        	$("#approveCcArea").empty();
        	for(var i = 0 ; i <resultList.length; i++){
                $("#approveCcTh").attr("rowspan","2");
                $("#approveCcTr").show();
               var usrHtml = '';
               usrHtml += '<span class="employee_list" >';
               usrHtml += '<strong>'+ resultList[i].deptNm +'</strong><a href="#;" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
               usrHtml += '<input type="hidden" name="arrDeptId" id="arrDeptId" value="'+resultList[i].deptId+'"/>';
               usrHtml += '</span>';

               $("#approveCcArea").append(usrHtml);
            }
        	break;
        case 'USER':
        	$("#approveCcArea").empty();
        	for(var i = 0 ; i <resultList.length; i++){
                $("#approveCcTh").attr("rowspan","2");
                $("#approveCcTr").show();

                var usrHtml = '';
                usrHtml += '<span class="employee_list" >';
                usrHtml += '<strong>'+ resultList[i].userNm +'</strong><a href="#;" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                usrHtml += '<input type="hidden" name="arrUserId" id="arrUserId" value="'+resultList[i].userId+'"/>';
                usrHtml += '</span>';

                $("#approveCcArea").append(usrHtml);
            }
        	break;
        case 'READDEPT':
        	$("#approveReadCcArea").empty();
        	for(var i = 0 ; i <resultList.length; i++){
                $("#approveReadCcTh").attr("rowspan","2");
                $("#approveReadCcTr").show();
               var usrHtml = '';
               usrHtml += '<span class="employee_list" >';
               usrHtml += '<strong>'+ resultList[i].deptNm +'</strong><a href="#;" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
               usrHtml += '<input type="hidden" name="arrReadDeptId" id="arrReadDeptId" value="'+resultList[i].deptId+'"/>';
               usrHtml += '</span>';

               $("#approveReadCcArea").append(usrHtml);
            }
        	break;
        case 'READUSER':
        	$("#approveReadCcArea").empty();
        	for(var i = 0 ; i <resultList.length; i++){
                $("#approveReadCcTh").attr("rowspan","2");
                $("#approveReadCcTr").show();

                var usrHtml = '';
                usrHtml += '<span class="employee_list" >';
                usrHtml += '<strong>'+ resultList[i].userNm +'</strong><a href="#;" onClick="fnObj.deleteStaff(this);"  class="btn_delete_employee"><em>삭제</em></a>';
                usrHtml += '<input type="hidden" name="arrReadUserId" id="arrReadUserId" value="'+resultList[i].userId+'"/>';
                usrHtml += '</span>';

                $("#approveReadCcArea").append(usrHtml);
            }
        	break;
    	}
    },

    deleteStaff : function(obj){

    	var span = $(obj).parent();
        span.remove();

		if( $("#approveCcArea").html().trim()==''){
			$("#approveCcTh").attr("rowspan","1");
            $("#approveCcTr").hide();
		}
		if( $("#approveReadCcArea").html()==''){
			$("#approveReadCcTh").attr("rowspan","1");
            $("#approveReadCcTr").hide();
		}
    },


    //게시판 이름 변경(추가시)
    changeBoardName : function(){
    	if(g_gboardId == 0 && !isEmpty($('#gboardName').val())){
    		$('#gboardDesc').val($('#gboardName').val() + ' 게시판입니다.');
    	}
    }


};//end fnObj.

var popType = "";
var readPopType = "";

/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.getCateInfo();	//검색(메뉴리스트)
});
</script>