<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript" defer="defer">
//회사 추가하기
$('.newCpn_btnOk').click(function(){
	var obj = $(this).parent().parent().parent().parent().parent();
	var chkRdo = obj.find('[checked=checked]').attr('id');
	// var cpnId = (chkRdo=='offerListed')?obj.find('[id^=cpn_id]').val():obj.find('[id^=cpn__id]').html();
	// var cpnNm = obj.find('[id^=cpn_nm]').val();
	// var cstId = obj.find('[id^=AP_cstId]').val();
	if(chkRdo=='offerListed'){
		if($("#cpn_id").val().length != 6){
			alert("숫자 6자리 코드를 입력하세요.");
			return;
		}
	}
	var cpnId = (chkRdo=='offerListed')?'A'+$("#cpn_id").val():$("#cpn__id").html();
	var cpnNm = $("#cpn_nm").val();
	var cstId = 0;

	var page = 0;
	if("popUpReg" == $('#tmpTak').val()){
		page = 1;
	}
	$("input").css('background-color','');
	if(cpnId.is_null()){
		$("#cpn_id").css('background-color','#A9F5BC');
		alert("상장코드를 입력하세요.");
		// (chkRdo=='offerListed')?obj.find('[id^=cpn_id]').focus():obj.find('[id^=cpn__id]').focus();
		(chkRdo=='offerListed')?$("#cpn_id").focus():$("#cpn__id").focus();
		return;
	}
	if(cpnNm.is_null()){
		$("#cpn_nm").focus();
		$("#cpn_nm").css('background-color','#A9F5BC');
		alert("회사명을 입력하세요.");
		// obj.find('[id^=cpn_nm]').focus();
		return;
	}
	if(cstId.is_null()){
		//alert("대표이사를 선택하세요.");
		//obj.find('[id^=AP_cstId]').focus();
		//return;
		cstId=0;
	}
	if(confirm("적용하시겠습니까?")){
		$.ajax({
			type:"POST",        //POST GET
			url:"../company/insertCpn.do",     //PAGEURL
			data : ({
				cpnId: cpnId,
				cpnNm: cpnNm,
				ceoId: cstId,
				rgId: $('#rgstId').val()
				}),
			timeout : 30000,       //제한시간 지정
			cache : false,        //true, false
			success: function whenSuccess(arg){  //SUCCESS FUNCTION
//						$(obj).hide();
				$('#c_Name').val(cpnId);
				$("input[name='cpnId']").val(cpnId);
				if(page != 1){
					commonAjaxSubmit("POST",$("#companyName"),newCpnCallback);
					//var frm = document.getElementById('companyName');//sender form id
					//frm.target = "mainFrame";//target frame name
					//frm.submit();
				}else{
					End(cpnId,cpnNm);
				}

			},
			error: function whenError(x,e){    //ERROR FUNCTION
				ajaxErrorAlert(x,e);
			}
		});
	}

});
function newCpnCallback(data){
	$("#mainArea").empty();
	$("#mainArea").append(data);
}
</script>
