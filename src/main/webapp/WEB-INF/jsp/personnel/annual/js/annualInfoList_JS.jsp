<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<script type="text/javascript">
	$(document).ready(function(){
		var nowYear = new Date().getFullYear();
		for (i = (nowYear+3); i > 2000; i--){
            $('#year').append($('<option />').val(i).html(i));
        }
		$('#year').val(nowYear);

		numberFormatForDigitClass();
		linkPage('1');
	});

	//부서선택 selectbox onchange
	function searchDeptId(){
		var deptIdBuf = $("#searchDeptIdBuf").val();
		if(deptIdBuf!=""){
			var deptId = deptIdBuf.split("_")[1];
			$("#searchDeptId").val(deptId);
		}else{
			$("#searchDeptId").val("");
		}

		linkPage('1');
	}
	//검색
	function linkPage(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action",contextRoot+"/personnel/getAnnualInfoListAjax.do");
		commonAjaxSubmit("POST",$("#frm"),searchCallback);
	}

	// 검색 콜백
	function searchCallback(data){
		$("#listArea").html(data);
	}

	//상세 페이지로 이동
	/* function goDetailPage(userId){
		$("#userId").val(userId);
		$("#frm").attr("action",contextRoot+"/personnel/getPersonnelInfo.do").submit();
	} */

	//선택된 Row CSS 해제
    function clearSelectedApprovalHeaderCss(){
        $("#selectedApproveHeaderTr").removeClass("tr_selected");
        $("#selectedApproveHeaderTr").attr("id", "");
    }
	//선택된 Row CSS
    function setSelectedApprovalHeaderCss(trObj){
        this.clearSelectedApprovalHeaderCss();

        if(trObj != undefined){
            $(trObj).attr("id", "selectedApproveHeaderTr");
            $(trObj).addClass("tr_selected");
        }
    }

	//연차 수정폼 활성화
    function setUpdForm(trObj, leaveId, orgId, userId, empNoView, name, cpnNm, deptNm, position, hiredDate, annualLeaveDay,
    		workAnnualLeaveDay, userAnnualLeaveDay){

        this.setSelectedApprovalHeaderCss(trObj);

        $("#trdata").show();
        $("#trNodata").hide();
        
        //연차수정 이름 표시추가
      	$('#displaynameTag').html(name+' ');

        $("#leaveId").val(leaveId);
        $("#orgId").val(orgId);
        $("#userId").val(userId);
        $("#empNoViewTag").text(empNoView);
        $("#nameTag").text(name);
        $("#cpnNmTag").text(cpnNm);
        $("#deptNmTag").text(deptNm);
        $("#positionTag").text(position);
        $("#hiredDateTag").text(hiredDate);
        $("#annualLeaveDay").val(annualLeaveDay);
        $("#workAnnualLeaveDay").val(workAnnualLeaveDay);
        $("#userAnnualLeaveDay").val(userAnnualLeaveDay);
    }

  //연차 저장
    function doSaveUserLeaveH(){
    	if($("#trdata").css("display") == "none"){  //
            alert("선택된 직원이 없습니다.");
            return;
        }else if($("#annualLeaveDay").val() == ""){  //
            alert("기본 년차일수를 입력하여 주시기 바랍니다.");
            $("#annualLeaveDay").focus();
            return;
        }else if($("#workAnnualLeaveDay").val()  == ""){  //
        	alert("근속년수 년차일수를 입력하여 주시기 바랍니다.");
            $("#workAnnualLeaveDay").focus();
            return;
        }else if($("#userAnnualLeaveDay").val()   == ""){  //
        	alert("임의추가 년차일수를 입력하여 주시기 바랍니다.");
            $("#userAnnualLeaveDay").focus();
            return;
        }

       /*  $("#minAmount").val($("#minAmount").val().split(",").join(""));
        $("#maxAmount").val($("#maxAmount").val().split(",").join("")); */

        var url = contextRoot + "/personnel/doSaveUserLeaveH.do";
        $('#frm').attr('action', url);
        commonAjaxSubmit("POST", $("#frm"), doSaveUserLeaveHCallback);
    }

  //연차 저장 Ajax 콜백
    function doSaveUserLeaveHCallback(result){
        if(result.result == "SUCCESS"){
            alert("정상적으로 저장되었습니다.");
            resetUpdateForm();
            linkPage($("#pageIndex").val());
        }else if(result.result == "FAIL"){
            alert("저장에 실패하였습니다. 담당자에게 문의하시기 바랍니다.");
        }
    }

  //저장폼 리셋
  function resetUpdateForm(){
	  $("#leaveId").val("");
      $("#orgId").val("");
      $("#userId").val("");
      $("#empNoViewTag").text("");
      $("#nameTag").text("");
      $("#cpnNmTag").text("");
      $("#deptNmTag").text("");
      $("#positionTag").text("");
      $("#hiredDateTag").text("");
      $("#annualLeaveDay").val("");
      $("#workAnnualLeaveDay").val("");
      $("#userAnnualLeaveDay").val("");

      $("#trdata").hide();
      $("#trNodata").show();
      
	  //연차수정 이름 표시추가
	  $('#displaynameTag').html('');
  }
</script>
