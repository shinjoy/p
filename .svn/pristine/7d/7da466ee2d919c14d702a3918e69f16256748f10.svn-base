<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
	var colorObj = {};
	$(document).ready(function(){

		//유저프로필 이벤트 셋팅
		initUserProfileEvent();
	})
	//검색
	function linkPage(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action",contextRoot+"/approve/approveBookmarkFormListAjax.do");
		commonAjaxSubmit("POST",$("#frm"),searchCallback);
	}

	// 검색 콜백
	function searchCallback(data){
		$("#listArea").html(data);

		//유저프로필 이벤트 셋팅
		initUserProfileEvent();
	}


	//상세화면으로 이동
	function goDetailPage(appvDocId,appvDocClass, appvDocType ,appvCompanyFormId ){
		$("#appvDocId").val(appvDocId);
		$("#appvDocClass").val(appvDocClass);
		$("#appvDocType").val(appvDocType);
		$("#appvCompanyFormId").val(appvCompanyFormId);

		if(appvDocId>0){
			$("#frm").attr("action",contextRoot+"/approve/approveBookmarkForm.do").submit();
		}else if(appvDocClass!="COMPANY"){
			switch(appvDocClass){
			case 'BASIC':
				$("#frm").attr("action",contextRoot+"/approve/reqBasic.do").submit();
				break;
			case 'REPORT':
				$("#frm").attr("action",contextRoot+"/approve/reqReport.do").submit();
				break;
			case 'EXPENSE':
				$("#frm").attr("action",contextRoot+"/approve/reqExpense.do").submit();
				break;
			case 'VACATION':
				$("#frm").attr("action",contextRoot+"/approve/reqVacation.do").submit();
				break;
			case 'PURCHASE':
				$("#frm").attr("action",contextRoot+"/approve/reqPurchase.do").submit();
				break;
			case 'EDUCATION':
				$("#frm").attr("action",contextRoot+"/approve/reqEdu.do").submit();
				break;
			case 'TRIP':
				$("#frm").attr("action",contextRoot+"/approve/reqTrip.do").submit();
				break;
			case 'EVENT':
				$("#frm").attr("action",contextRoot+"/approve/reqEvent.do").submit();
				break;
			case 'REST':
				$("#frm").attr("action",contextRoot+"/approve/reqRest.do").submit();
				break;
			}
		}else{
			$("#frm").attr("action", contextRoot + "/approve/reqCompany.do").submit();
		}



	}

	//일괄삭제
	function deleteBookmarkAll(){
		if($("input[name='chkedDoc']:checked").length == 0){
			alert("최소 한건 이상 선택해 주세요.");
			return;
		}

		if(confirm("선택하신 즐겨찾는서식을 [삭제] 하시겠습니까?")){
			$("#frm").attr("action",contextRoot+"/approve/deleteAppvFavListAjax.do");
			commonAjaxSubmit("POST",$("#frm"),deleteBookmarkAllCallback);
		}
	}
	function deleteBookmarkAllCallback(data){
		if(data.resultObject.result =="SUCCESS"){//성공 메세지가 바뀌는 상황에 구현한다.
			alert("선택하신 즐겨찾는서식이 삭제 되었습니다.");
			linkPage($("#pageIndex").val());
		}else{
			alert("저장에 실패했습니다. 담당자에게 문의해 주세요.");
		}
	}
</script>
