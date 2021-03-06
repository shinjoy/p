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



	<div class="modalWrap2">
		<div class="mo_container">
	    	<table id="SGridTarget" class="tb_basic_left">
	        	<colgroup>
		       		<col width="17%"/>
		       		<col width="28%"/>
					<col width="17%" />
					<col width="28%"/>
				</colgroup>
				<tbody>
				<tr>
					<th scope="row">프로그램그룹</th>
					<td colspan="3"><span id="groupListDiv"></span></td>
				</tr>
				<tr>
	 				<th scope="row">프로그램 ID</th>
	 				<td><input type="text" id="cboardUid" placeholder="프로그램ID" value="" class="input_b w100pro" /></td>
	 				<th scope="row">이름</th>
	 				<td><input type="text" id="cboardName" placeholder="프로그램 이름을 입력하세요" value="" class="input_b w100pro" /></td>
	 			</tr>
	 			<tr>
		 			<th scope="row">게시판 속성</th>
		 			<td colspan="3">
		  				<span class="radio_list2">
		   					<label><input type="radio" name="approveYn" value="N" checked /><span>일반형</span></label>
		   					<label><input type="radio" name="approveYn" value="Y" /><span>승인형</span></label>
		  				</span>
		 			</td>
		 		</tr>
		 		<tr>
		 			<th scope="row">공개범위설정</th>
		 			<td class="last">
		  				<span class="radio_list2">
		   					<label><input type="radio" name="openAllYn" value="N" checked /><span>사내</span></label>
		   					<label><input type="radio" name="openAllYn" value="Y" /><span>전사</span></label>
		  				</span>
		 			</td>
		 			<th scope="row">공개기간설정</th>
		 			<td class="last">
		  				<span class="radio_list2">
		   					<label><input type="radio" name="openPeriodYn" value="Y"  /><span>사용</span></label>
		   					<label><input type="radio" name="openPeriodYn" value="N" checked/><span>사용안함</span></label>
		  				</span>
		 			</td>
		 		</tr>
		 		<tr>
		 			<th scope="row">설명</th>
		 			<td colspan="3"><input type="text" id="cboardDesc" placeholder="프로그램설명을 입력하세요" value="" class="input_b w100pro" /></td>
				</tr>
				<tr>
					<th scope="row">사용여부</th>
		 			<td>
		 				<span class="radio_list2">
		  					<label><input type="radio" name="deleteFlag" value="N" checked /><span>사용</span></label>
		   					<label><input type="radio" name="deleteFlag" value="Y" /><span>사용안함</span></label>
		   				</span>
		 			</td>
		 			<th scope="row">헤드라인기능</th>
		 			<td>
		  				<span class="radio_list2">
		   					<label><input type="radio" name="noticeYn" value="Y" checked /><span>사용</span></label>
		   					<label><input type="radio" name="noticeYn" value="N" /><span>사용안함</span></label>
		  				</span>
		 			</td>
				</tr>
				<tr>
		 			<th scope="row">댓글기능</th>
		 			<td>
		  				<span class="radio_list2">
		   					<label><input type="radio" name="replyYn" value="Y" checked onclick="fnObj.checkReplyYn();" /><span>사용</span></label>
		   					<label>(<input type="checkbox" name="secretYn" value="Y" checked /><span>비밀글사용</span>)</label>
		   					<div><label><input type="radio" name="replyYn" value="N" onclick="fnObj.checkReplyYn();"/><span>사용안함</span></label></div>
		  				</span>
		 			</td>
		 			<th scope="row">파일첨부기능</th>
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


var g_cboardId ='${cboardId}';
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
    	var url = contextRoot + "/board/getBoardCateList.do";
    	var param = { groupId : g_groupId , cboardId:g_cboardId};
		var callback = function(result){
    		var obj = JSON.parse(result);
    		var resultList = obj.resultList;
    		for(var i=0;i<resultList.length;i++){
    			$("#groupId").val(resultList[i].groupId);
    			$("#cboardUid").val(resultList[i].cboardUid);
    			$("#cboardName").val(resultList[i].cboardName);
    			$("#cboardDesc").val(resultList[i].cboardDesc);
    			$("input:radio[name=deleteFlag]:input[value=" + resultList[i].deleteFlag + "]").prop("checked", true);
    			$("input:radio[name=noticeYn]:input[value=" + resultList[i].noticeYn + "]").prop("checked", true);
    			$("input:radio[name=replyYn]:input[value=" + resultList[i].replyYn + "]").prop("checked", true);
    			$("input:radio[name=fileYn]:input[value=" + resultList[i].fileYn + "]").prop("checked", true);
    			$("input:radio[name=approveYn]:input[value=" + resultList[i].approveYn + "]").prop("checked", true);
    			$("input:radio[name=openPeriodYn]:input[value=" + resultList[i].openPeriodYn + "]").prop("checked", true);
    			$("input:radio[name=openAllYn]:input[value=" + resultList[i].openAllYn + "]").prop("checked", true);

    			if(resultList[i].replyYn == 'N') $("input:checkbox[name=secretYn]").attr('disabled',true);

				if(resultList[i].secretYn == 'Y') $("input:checkbox[name=secretYn]").prop("checked", true);
				else $("input:checkbox[name=secretYn]").prop("checked", false);

    			$("#listCount").val(resultList[i].listCount);
    			$("#pageCount").val(resultList[i].pageCount);
    			$("#cboardUid").attr("readonly",true);					//프로그램 uid 수정못하게

    		}
    	};
    	commonAjax("POST", url, param, callback, false);
    },

  	//검색(메뉴리스트)
    getCateInfo : function(){
    	if(g_groupId != 0){
    		fnObj.doSearch();
    	}
    },

    //그룹 리스트
    getGroupList : function(){
		var url = contextRoot + "/board/getBoardGroupList.do";
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
    	var cboardUid	= $("#cboardUid").val();							//프로그램 ID
    	var cboardName	= $("#cboardName").val();							//프로그램명
    	var cboardDesc	= $("#cboardDesc").val();							//프로그램설명
    	var deleteFlag	= $("input:radio[name=deleteFlag]:checked").val();	//숨김여부
    	var noticeYn	= $("input:radio[name=noticeYn]:checked").val();	//헤드라인기능
    	var replyYn		= $("input:radio[name=replyYn]:checked").val();		//답글기능
    	var fileYn		= $("input:radio[name=fileYn]:checked").val();		//파일첨부기능

    	var approveYn	= $("input:radio[name=approveYn]:checked").val();		//관계사승인여부
		var openPeriodYn= $("input:radio[name=openPeriodYn]:checked").val();	//공개기간여부
		var secretYn	= ($("input:checkbox[name=secretYn]").is(':checked') ? 'Y' : 'N');		//비밀댓글 여부
		var openAllYn	= $("input:radio[name=openAllYn]:checked").val();		//전사공개여부

		var listCount	= $("#listCount").val();							//리스트갯수
    	var pageCount	= $("#pageCount").val();							//페이지갯수

    	if(groupId == null){
    		alert("그룹을 선택해 주세요.");
    		$("#groupId").focus();
    		return;
    	}
    	//프로그램 아이디 유효성 검사
    	if(strInNumNEn(cboardUid)){
    		alert("프로그램ID는 영문,숫자만 가능합니다.");
    		$("#cboardUid").focus();
    		return;
    	}
    	if(isEmpty(cboardName)){
    		alert("프로그램명을 입력하세요.");
    		$("#cboardName").focus();
    		return;
    	}
    	if(isEmpty(cboardDesc)){
    		alert("프로그램설명을 입력하세요.");
    		$("#cboardDesc").focus();
    		return;
    	}

    	var url = contextRoot + "/board/saveBoardCate.do";
    	var param = {
    			cboardId	: g_cboardId,
    			groupId 	: groupId,
    			cboardUid 	: cboardUid,
    			cboardName 	: cboardName,
    			cboardDesc 	: cboardDesc,
    			deleteFlag 	: deleteFlag,
    			noticeYn 	: noticeYn,
    			replyYn 	: replyYn,
    			fileYn 		: fileYn,
    			approveYn	: approveYn,
    			openPeriodYn: openPeriodYn,
    			secretYn	: secretYn,
    			openAllYn	: openAllYn,
    			listCount 	: listCount,
    			pageCount 	: pageCount,

    	};

    	var callback = function(result){
    		var obj = JSON.parse(result);
    		var resultObj = obj.resultObject;
    		var chk = resultObj.chk;			//신규등록시 아이디 중복검사 결과
    		var saveChk = resultObj.saveChk;	//저장여부 검사
    		if(chk>0){
    			alert("동일 ID가 존재합니다.");
    			$("#cboardUid").focus();
    			return false;
    		}
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

    checkReplyYn : function(){

    	if($('input[name=replyYn]:checked').val() == 'N'){
    		$("input[name=secretYn]").prop('checked',false).attr('disabled',true);
    	}else{
    		$("input[name=secretYn]").prop('checked',true).attr('disabled',false);
    	}

    }



};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.preloadCode();	//공통코드 or 각종선로딩코드
	fnObj.pageStart();		//화면세팅
	fnObj.getCateInfo();	//검색(메뉴리스트)

});
</script>