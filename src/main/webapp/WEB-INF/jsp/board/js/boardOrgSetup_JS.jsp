<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>



<script type="text/javascript">

//직원선택 창 호출
function openEmpPopup(cboardId){

	 var paramList = [];

     var paramObj = { name : 'userList', value : ''};
     paramList.push(paramObj);


     // 단건선택
     paramObj ={ name : 'isOneOrg' ,value : 'Y'};
     paramList.push(paramObj);
     paramObj ={ name : 'isAllOrg' ,value : 'N'};
     paramList.push(paramObj);
     paramObj ={ name : 'oneOrg' ,value : '${baseUserLoginInfo.orgId}'};
     paramList.push(paramObj);
     paramObj ={ name : 'isCheckDisable' ,value : 'N'};
     paramList.push(paramObj);
     paramObj ={ name : 'isOneUser' ,value : 'Y'};
     paramList.push(paramObj);
     paramObj ={ name : 'parentKey' ,value : cboardId};
     paramList.push(paramObj);


     userSelectPopCall(paramList); // 공통 선택 팝업 호출


}

//지우기
function deleteEmp(obj){
    var span = $(obj).parent();
    span.remove();
}

//저장
function doSaveOrgSetup(){

	 var userIdArr = $('input[name="arrUserId"]');

	 var userList = new Array();

	 for(var i=0; i<userIdArr.length; i++){
		 var userObj = {
				 cboardId 	 : $(userIdArr[i]).attr('targetCateId'),
				 staffUserId : $(userIdArr[i]).val()
		 };

		 userList.push(userObj);
	 }

	 var url = contextRoot + "/board/doSaveOrgSetup.do";

	 var param = {

			 userListStr  :  (userList.length > 0 ? JSON.stringify(userList) : '')
	 };

	 var callback = function(result){
			toast.push('저장되었습니다.');
		 	fnObj.setPage();
	 };

	 commonAjax("POST", url, param, callback, false);
}




var fnObj = {



	setPage : function(){

    	var url = contextRoot + "/board/boardOrgSetupAjax.do";
		var param = {};

    	var callback = function(result){

			$("#boardOrgSetupArea").empty();

    		$("#boardOrgSetupArea").html(result);

    	};

    	 commonAjax("POST", url, param, callback, false);
    },

	//팝업 리턴
    getResult: function(resultList,parentKey){
    	var str ='';
    	if(resultList.length > 0){
	    	str += '<span class="employee_list">';
	    	str += '<span>'+resultList[0].userName+'<em>('+resultList[0].position+')</em></span><a href="javascript:;" onclick="deleteEmp(this);" class="btn_delete_employee"><em>삭제</em></a>';
	    	str += '<input type="hidden" name="arrUserId" targetCateId="'+parentKey+'" id="arrUserId" value="'+resultList[0].userId+'">';
	    	str += '</span>';
    	}

    	$("#userArea_"+parentKey).html(str);
	 }

};//end fnObj.


/*
 * 화면로딩완료후, 자바스크립트 화면세팅 과 그외동작들 호출.
 */
$(function(){
	fnObj.setPage();

});
</script>
