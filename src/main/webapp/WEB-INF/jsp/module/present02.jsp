<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript" defer="defer">

    $(document).ready(function(){
    	var nowDate= new Date();
        var searchDate2 = getFormatDate(nowDate,'.');

        $("#present2searchDate2").html(searchDate2);
        $("#presentExecFrm #searchDate2").val(searchDate2);

        $('#presentExecFrm #searchDate2').datepicker({
            inline: true,
            dateFormat: "yy.mm.dd",    /* 날짜 포맷 */
            prevText: 'prev',
            nextText: 'next',
            showButtonPanel: true,    /* 버튼 패널 사용 */
            changeMonth: true,        /* 월 선택박스 사용 */
            changeYear: true,        /* 년 선택박스 사용 */
            showOtherMonths: true,    /* 이전/다음 달 일수 보이기 */
            selectOtherMonths: true,    /* 이전/다음 달 일 선택하기 */
            buttonImageOnly: true,
            buttonText: "Calendar",
            closeText: '닫기',
            currentText: '오늘',
            showMonthAfterYear: true,        /* 년과 달의 위치 바꾸기 */
            /* 한글화 */
            monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            dayNames : ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
            showAnim: 'slideDown',
            yearRange: 'c-100:c+10',
            onSelect: function(dateText) {
                $("#present2searchDate2").html(dateText);
                $("#presentExecFrm #searchDate2").val(dateText);
                presentExecObj.doSearch("");
            },
            onClose: function(dateText) {
                $("#present2searchDate2").html(dateText);
                $("#presentExecFrm #searchDate2").val(dateText);
                presentExecObj.doSearch("");
            }
        });

        $("#present2searchDate2").click(function(){
            $("#presentExecFrm #searchDate2").datepicker("show");
        });

        //최초 정보셋팅
        presentExecObj.doSearch("");
    });
    var presentExecObj = {

        doSearch : function(searchInfoType){
            $("#searchInfoType").val(searchInfoType); //7개만 조회

            $("#presentExecFrm").attr("action",contextRoot+"/schedule/mainExecEmpInfoListAjax.do");
            commonAjaxSubmit("POST",$("#presentExecFrm"),presentExecObj.mainPresentExecCallback);

        },
        mainPresentExecCallback : function(data){

            $("#presentExecArea").empty();

            //list obj
            var list = data.resultObject;
            var strHtml = "";

            if(list == undefined || list.length<1){
                //nodata
                $("#presentExecArea").append("<div class=\"m_nocontxt\">등록된 임원일정이 없습니다.</div>");
            }else{
                for(var i = 0 ; i <list.length ; i++){
                    var dataObj = list[i];
                    var activityCss = "ps_education";
                    if(dataObj.appvDocType == "EDU") activityCss = "ps_education";
                    else if(dataObj.appvDocType == "TRIP") activityCss = "ps_b_trip";
                    else if(dataObj.appvDocType == "LEAVE") activityCss = "ps_vacation";

                    strHtml += '<tr>';
                    if(dataObj.scheAllTime == 'Y'){  //종일일정
                    	strHtml += '    <th scope="row">종일일정</th>';
                    }else{
                    	strHtml += '    <th scope="row">'+dataObj.scheSTime+'~'+dataObj.scheETime+'</th>';
                    }
                    strHtml += '    <td>';
                    strHtml += '        <ul class="ceomember_list">';
                    var arrEntryNm = dataObj.entryNm.split(',');

                    if(arrEntryNm != null){
                    	for(var k=0;k<arrEntryNm.length;k++){
                    		var arrPerNm = arrEntryNm[k].split(':');
                    		if(arrPerNm != null){
                    			strHtml += '            <li>';
                    			strHtml += "<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+arrPerNm[2]+"\",$(this),\"mouseover\",null,0,-300,300)'>";
                    			strHtml += '<strong>'+arrPerNm[0]+'</strong></span><span>('+arrPerNm[1]+')</span></li>';

                    			//<strong>'+arrPerNm[0]+'</strong><span>('+arrPerNm[1]+')</span></li>';
                    		}
                    	}
                    }
                    /*strHtml += '            <li><strong>'+dataObj.perNm+'</strong><span>( '+dataObj.rankNm+')</span></li>'; */
                    strHtml += '        </ul>';
                    strHtml += '    </td>';
                    strHtml += '    <td>';

                    var delimiter = "";
                    var position = "";
                    if(dataObj.companyNm != "" && dataObj.customerNm != "") delimiter =  " : ";
                    if(dataObj.position != "") position = "(" + dataObj.companyNm + ")";

                    strHtml += '        <p>'+dataObj.companyNm+delimiter+dataObj.customerNm+position+'</p>';
                    strHtml += '        <p><a href="javascript:presentExecObj.openSchedulePop('+dataObj.scheSeq+')">'+dataObj.activityNm+'</a></p>';
                    strHtml += '    </td>';
                    strHtml += '</tr>';
                }
                $("#presentExecArea").append(strHtml);
            }
         	 //유저프로필 이벤트 셋팅
        	initUserProfileEvent();

        },
        goScheduleMain : function(){
            $("#presentExecFrm").attr("action",contextRoot+"/ScheduleCal.do").submit();
        },
        openSchedulePop : function(scheSeq){
        	var url = "<c:url value='/ScheduleView.do?scheSeq="+scheSeq+"&ParentPage=Main'/>";
            var popup = window.open(url, 'scheduleView', 'resizable=no,width=700,height=750,scrollbars=yes');
        },
     // 달력이동
        moveDay : function(interVal){
            var searchDate2 = $("#presentExecFrm #searchDate2").val();

            var choiceYear = parseInt(searchDate2.split('.')[0]);
            var choiceMonth = parseInt(searchDate2.split('.')[1])-1;
            var choiceDay = parseInt(searchDate2.split('.')[2]);

            var loadDt = new Date(choiceYear,choiceMonth,choiceDay); //현재 날짜 및 시간   //현재시간 기준 계산
            var newDate= new Date(Date.parse(loadDt) + (interVal * 1000 * 60 * 60 * 24));  //하루전/후
            var strDate = getFormatDate(newDate,'.');

             $("#present2searchDate2").html(strDate);
             $("#presentExecFrm #searchDate2").val(strDate);

             presentExecObj.doSearch("");  //조회
         },
    }
  //화면 리로딩
    function openPageReload(){
    	presentExecObj.doSearch("");
    }
</script>
<form id = "presentExecFrm" name = "presentExecFrm" method="post">
<input type="hidden" id="actionType" name="actionType" value="EXEC"/>
<input type="hidden" id="searchInfoType" name="searchInfoType"/>
<input type="hidden" id="outOfOfficeTracking" name="outOfOfficeTracking" value="Y"/>

<h2 class="module_title">
    <strong onclick="presentExecObj.goScheduleMain()">임원현황</strong>
    <c:if test="${baseUserLoginInfo.vipAuthYn eq 'Y'}"><span>(전체)</span></c:if>
</h2>
<ul class="module_calendar">
    <li class="prebtn" onClick="presentExecObj.moveDay(-1);" style="cursor:pointer;"></li>
    <li id="present2searchDate2" style="cursor:pointer;"></li>
    <input type="hidden" id="searchDate2" name="searchDate2"/>
    <li class="nxtbtn" onClick="presentExecObj.moveDay(1);" style="cursor:pointer;"></li>
</ul>
<div class="module_conBox">
	<table id = "presentExecArea" class="ceopresent_tb" summary="임원현황(시간별 임원현황안내)">
		<caption>임원현황안내</caption>
		<colgroup>
			<col width="100" />
			<col width="*" />
			<col width="*" />
		</colgroup>
		<tbody></tbody>

	</table>
</div>
<a href="javascript:presentExecObj.goScheduleMain();" class="btn_more"><em>더보기</em></a>

</form>