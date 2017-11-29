<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="mo_container" style="min-height: 300px;">

	<div id="CompanySerach" class="mgt0">
		<table class="tb_ProfileInfo" summary="회사검색">
			<caption>회사검색</caption>
			<colgroup>
				<col width="120">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" rowspan="2" class="bgGray"><label for="IDNAME05">승인자설정</label></th>
					<td class="itemList">
						<div class="noti_period mgl0">
							<input type="text" id="openStartDate" readonly="readonly" class="input_date mgl6" value="${openStartDate}" title="종료일선택">
							<a href="javascript:;" onclick="javascript:clickDate('openStartDate');return false;" class="icon_calendar" ></a>
							<span>~</span>
							<input type="text" id="openEndDate"  readonly="readonly" class="input_date mgl6" value="${openEndDate}" title="종료일선택">
							<a href="javascript:;" onclick="javascript:clickDate('openEndDate');return false;" class="icon_calendar" ></a>
							<a href="javascript:;" onclick="javascript:clickDate('forever');" class="icon_calendar_forever mgl10">&nbsp;</a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!--페이지버튼-->
	<div class="btnZoneBox"><a href="javascript:editOpenPeriod();" class="p_blueblack_btn"><strong>확인</strong></a><a href="javascript:parent.myModal.close();" class="p_withelin_btn">취소</a></div>
	<!--//검색결과有//-->
</div>

<script type="text/javascript">

function clickDate(obj){

	if(obj == 'forever') $("#openEndDate").val('9999-12-31');
	else{
		if(obj == 'openEndDate' && $("#openEndDate").val() > '3000-01-01')  $("#openEndDate").val(new Date().yyyy_mm_dd());

		$('#'+obj).datepicker('show');
		$("#ui-datepicker-div").zIndex("9999");

	}

}

//저장
function editOpenPeriod(){

	if($("#openStartDate").val() > $("#openEndDate").val()){
		alert("시작일을 확인해주세요");
		return;
	}
	var url = contextRoot + '/board/editOpenPeriod.do';
	var param = {
		contentId		: 	'${contentId}',
		openStartDate	: 	$("#openStartDate").val(),
		openEndDate		: 	$("#openEndDate").val(),
	};

	var callback = function(result){
		var obj = JSON.parse(result);
		var cnt = obj.resultVal;

		if(cnt>0){
			alert("수정되었습니다.");

			parent.fnObj.doSearch();
			parent.myModal.close();

		}

	};

	commonAjax("POST", url, param, callback, false);
}

//datepicker 설정
function setDatepicker(obj){
	$('#'+obj).datepicker({
		dateFormat: 'yy-mm-dd',
		changeMonth: true,
		changeYear: true,
		showOn: "button",
		yearRange: 'c-7:c+7',
	 	monthNames: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], // 개월 텍스트 설정
	    monthNamesShort: ['1 월','2 월','3 월','4 월','5 월','6 월','7 월','8 월','9 월','10 월','11 월','12 월'], // 개월 텍스트 설정
	    dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'], // 요일 텍스트 설정
	    dayNamesShort: ['일','월','화','수','목','금','토'], // 요일 텍스트 축약 설정
	    dayNamesMin: ['일','월','화','수','목','금','토'], // 요일 최소 축약 텍스트 설정
	    showButtonPanel: false,
		isRTL: false,
	    buttonText: ""
	});
}

$(document).ready(function(){
	setDatepicker('openStartDate');
	setDatepicker('openEndDate');

});


</script>