<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link href="<c:url value='/css/new_network.css'/>" rel="stylesheet" type="text/css">

<!-- ============== style css :S ============== -->
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/jquery-ui.css">				<!-- jquery-ui --> --%>
<!-- ============== style css :E ============== -->

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
			 			<th scope="row">그룹ID(영문)</th>
			 			<td><input type="text"  id="groupUid" placeholder="그룹ID" value="" class="input_b w100pro" /></td>
			 			<th scope="row">그룹명</th>
			 			<td><input type="text" id="groupName" placeholder="그룹 이름을 입력하세요" value="" class="input_b w100pro" /></td>
			 		</tr>
			 		<tr>
			 			<th scope="row">그룹설명</th>
			 			<td colspan="3"><input type="text" id="groupDesc" placeholder="그룹 설명을 입력하세요" value="" class="input_b w100pro" /></td>
					</tr>
					<tr>
			 			<th scope="row">사용여부</th>
			 			<td colspan="3">
			 				<span class="radio_list2">
								<label><input type="radio" name="deleteFlag" value="N" checked /><span>사용</span></label>
								<label><input type="radio" name="deleteFlag" value="Y" /><span>사용안함</span></label>
							</span>
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



<script type="text/javascript">

//Global variables :S ---------------
//사용자언어
<%--
var lang = '${userLoginInfo.lang}';		//language (profile language... 'KOR' or 'ENG')
--%>
//공통코드(외,코드)
var myGrid = new SGrid(); 		// instance

var g_groupId  ='${groupId}';

//Global variables :E ---------------


/*
 * 화면세팅에 관한함수(pageStart)와, 각종 함수들을 정의하는 fnObj(function object).
 */
var fnObj = {


	//선로딩코드
	preloadCode : function(){
	},

	//화면세팅
    pageStart : function(){


    },//end pageStart.

    doSearch : function(){
    	var url = contextRoot + "/board/getBoardGroupList.do";
    	var param = { groupId : g_groupId};
		var callback = function(result){
    		var obj = JSON.parse(result);
    		var resultObj = obj.resultObject;
    		var resultList = resultObj.list;
    		for(var i=0;i<resultList.length;i++){
    			$("#groupUid").val(resultList[i].groupUid);			//그룹 uid
    			$("#groupName").val(resultList[i].groupName);		//그룹 이름
    			$("#groupDesc").val(resultList[i].groupDesc);		//그룹 설명
    			$("input:radio[name=deleteFlag]:input[value=" + resultList[i].deleteFlag + "]").prop("checked", true);//사용여부
    		}
    		$("#groupUid").attr("readonly",true);					//그룹 uid 수정못하게
    	};
    	commonAjax("POST", url, param, callback, false);
    },

  	//검색 전 신규인지 수정인지 판별
    getGroupInfo : function(){
    	if(g_groupId != 0){
    		fnObj.doSearch();
    	}
    },

    //저장
    doSave : function(){
    	var groupUid   = $("#groupUid").val();						//그룹 uid
    	var groupName  = $("#groupName").val();						//그룹 이름
    	var groupDesc  = $("#groupDesc").val();						//그룹 설명
    	var deleteFlag = $("input:radio[name=deleteFlag]:checked").val();					//사용여부

    	//그룹 아이디 유효성 검사
    	if(strInNumNEn(groupUid)){
    		alert("그룹ID는 영문,숫자만 가능합니다.");
    		$("#groupUid").focus();
    		return;
    	}
    	if(isEmpty(groupName)){
    		alert("그룹명을 입력하세요.");
    		$("#groupName").focus();
    		return;
    	}
    	if(isEmpty(groupDesc)){
    		alert("그룹설명을 입력하세요.");
    		$("#groupDesc").focus();
    		return;
    	}
    	var url = contextRoot + "/board/saveBoardGroup.do";
    	var param = {
    			groupId 	: g_groupId,
    			groupUid 	: groupUid,
    			groupName 	: groupName,
    			groupDesc 	: groupDesc,
    			deleteFlag 	: deleteFlag
    	};

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var resultObj = obj.resultObject;
    		var chk = resultObj.chk;			//신규등록시 아이디 중복검사 결과
    		var saveChk = resultObj.saveChk;	//저장여부 검사
    		if(chk>0){
    			alert("동일 ID가 존재합니다.");
    			$("#groupUid").focus();
    			return;
    		}
    		if(saveChk ==0){
    			alert("저장에 실패하였습니다.");
    			return;
    		}else{
    			parent.toast.push("완료되었습니다.");
    			parent.fnObj.getGroupList();
    			parent.fnObj.clickGroup(saveChk);
    			fnObj.doClose();
    		}

    	};

    	commonAjax("POST", url, param, callback, false);
    },

    doClose : function(){
    	parent.myModal.close();
    }



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.getGroupInfo();	//검색

});
</script>