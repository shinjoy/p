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
        var searchDate = getFormatDate(nowDate,'.');

        $("#present1SearchDate").html(searchDate);
        $("#presentEmpFrm #searchDate").val(searchDate);

        $('#presentEmpFrm #searchDate').datepicker({
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
            	$("#present1SearchDate").html(dateText);
                $("#presentEmpFrm #searchDate").val(dateText);
                presentEmpObj.doSearch("");
            },
            onClose: function(dateText) {
	            $("#present1SearchDate").html(dateText);
	            $("#presentEmpFrm #searchDate").val(dateText);
	            presentEmpObj.doSearch("");
	        }
        });

        $("#present1SearchDate").click(function(){
        	$("#presentEmpFrm #searchDate").datepicker("show");
        });

        //최초 정보셋팅
        presentEmpObj.doSearch("");

    });
    var presentEmpObj = {
        doSearch : function(searchInfoType){
            $("#presentEmpFrm #searchInfoType").val(searchInfoType);

            $("#presentEmpFrm").attr("action",contextRoot+"/schedule/mainPresentEmpInfoListAjax.do");
            commonAjaxSubmit("POST",$("#presentEmpFrm"),presentEmpObj.mainPresentEmpCallback);

            $("#ALL").attr("class","");
            $("#ANNUAL_ALL").attr("class","");
            $("#TRIP").attr("class","");
            $("#EDUCATION").attr("class","");
            $("#SICK").attr("class","");
            $("#REST").attr("class","");
            $("#ETC_ALL").attr("class","");
            $("#ATTEND").attr("class","");
            if(searchInfoType == "") $("#ALL").attr("class","current");
            else $("#"+searchInfoType).attr("class","current");

        },
        mainPresentEmpCallback : function(data){

            $("#presentEmpArea").empty();

            //list obj
            var list = data.resultObject;
            var strHtml = "";

            var infoType = $("#presentEmpFrm #searchInfoType").val();

            if(list == undefined || list.length<1){
                //nodata
                var infoTypeText = "근태";

                if(infoType == "ANNUAL_ALL") infoTypeText = "휴가";
                else if(infoType == "TRIP") infoTypeText = "출장";
                else if(infoType == "EDUCATION") infoTypeText = "교육";
                else if(infoType == "SICK") infoTypeText = "병가";
                else if(infoType == "REST") infoTypeText = "휴직";
                else if(infoType == "ETC_ALL") infoTypeText = "기타휴가";
                else if(infoType == "ATTEND") infoTypeText = "현출";

                $("#presentEmpArea").append("<div style='padding:80px' class=\"m_nocontxt\">직원"+infoTypeText+"정보가 없습니다.</div>");
            }else{
                for(var i = 0 ; i <list.length ; i++){
                    var dataObj = list[i];
                    var activityCss = "ps_education";
                    var infoTypeText = "";

                    if(dataObj.appvDocType == "EDUCATION"){
                    	activityCss = "ps_education";
                    	infoTypeText = "교육";
                    }else if(dataObj.appvDocType == "TRIP"){
                    	activityCss = "ps_b_trip";
                    	infoTypeText = "출장";
                    }else if(dataObj.appvDocType == "ANNUAL_ALL"){
                    	activityCss = "ps_vacation";
                    	infoTypeText = "휴가";
                    }else if(dataObj.appvDocType == "SICK"){
                    	activityCss = "ps_sick";
                    	infoTypeText = "병가";
                    }else if(dataObj.appvDocType == "REST"){
                    	activityCss = "ps_stwork";
                    	infoTypeText = "휴직";
                    }else if(dataObj.appvDocType == "ETC_ALL"){
                        activityCss = "ps_vacation";
                        infoTypeText = "기타휴가";
                    }else if(dataObj.appvDocType == "ATTEND"){
                    	activityCss = "ps_b_trip2";
                    	infoTypeText = "현출";
                    }

                    strHtml += '<li>';
                    strHtml += '    <div class="fl_block">';

                    if(infoType == "ATTEND") strHtml += '            <span class="mbsicon_set ps_b_trip2">현출</span>';
                    else strHtml += '            <span class="mbsicon_set '+activityCss+'">'+dataObj.activityNm+'</span>';

                    strHtml += '            <span class="present_m_name">';
                    strHtml += "				<span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+dataObj.userId+"\",$(this),\"mouseover\",null,0,-300,300)'>";
                    strHtml += 						dataObj.perNm+'</span></span>';
                    strHtml += '            <span class="bs_team">'+dataObj.deptNm+' / '+dataObj.rankNm+'</span>';

                    if(dataObj.attendYn == "Y" && dataObj.appvDocType != "ATTEND" && $("#presentEmpFrm #searchInfoType").val() != "ATTEND"){
                    	strHtml += '            <spa class="present_s_out">(현지출근)</spa>';
                    }else if(infoType == "ATTEND" && infoTypeText != "" && dataObj.appvDocType != "ATTEND"){
                    	strHtml += '            <spa class="present_s_out">('+infoTypeText+')</spa>';
                    }

                    strHtml += '    </div>';
                    strHtml += '</li>';
                }
                $("#presentEmpArea").html(strHtml);
            }
        },
        goScheduleMain : function(){
        	$("#presentEmpFrm").attr("action",contextRoot+"/ScheduleCal.do").submit();
        },

       // 달력이동
       moveDay : function(interVal){
    	   var searchDate = $("#presentEmpFrm #searchDate").val();

    	   var choiceYear = parseInt(searchDate.split('.')[0]);
           var choiceMonth = parseInt(searchDate.split('.')[1])-1;
           var choiceDay = parseInt(searchDate.split('.')[2]);

           var loadDt = new Date(choiceYear,choiceMonth,choiceDay); //현재 날짜 및 시간   //현재시간 기준 계산
           var newDate= new Date(Date.parse(loadDt) + (interVal * 1000 * 60 * 60 * 24));  //하루전/후
           var strDate = getFormatDate(newDate,'.');

            $("#present1SearchDate").html(strDate);
            $("#presentEmpFrm #searchDate").val(strDate);

            presentEmpObj.doSearch("");  //조회
        },
    }

</script>

<form id = "presentEmpFrm" name = "presentEmpFrm" method="post">
<input type="hidden" id="actionType" name="actionType" value="EMP"/>
<input type="hidden" id="searchInfoType" name="searchInfoType"/>

<h2 class="module_title">
    <strong onclick="presentEmpObj.goScheduleMain()">직원 근태현황</strong>
    <c:if test="${baseUserLoginInfo.vipAuthYn eq 'Y'}"><span>(전체)</span></c:if>
</h2>
<ul class="module_calendar">
    <li class="prebtn" onClick="presentEmpObj.moveDay(-1);" style="cursor:pointer;"></li>
    <li id="present1SearchDate" style="cursor:pointer;"></li>
    <input type="hidden" id="searchDate" name="searchDate"/>
    <li class="nxtbtn" onClick="presentEmpObj.moveDay(1);" style="cursor:pointer;"></li>
</ul>

<div class="module_conBox">
	<ul class="mtab_st01">
		<li id="ALL" class="current"><a href="javascript:presentEmpObj.doSearch('');">전체</a></li>
		<li id="ANNUAL_ALL"><a href="javascript:presentEmpObj.doSearch('ANNUAL_ALL');">휴가</a></li>
		<li id="TRIP"><a href="javascript:presentEmpObj.doSearch('TRIP');">출장</a></li>
		<li id="EDUCATION"><a href="javascript:presentEmpObj.doSearch('EDUCATION');">교육</a></li>
		<li id="SICK"><a href="javascript:presentEmpObj.doSearch('SICK');">병가</a></li>
		<li id="REST"><a href="javascript:presentEmpObj.doSearch('REST');">휴직</a></li>
		<li id="ETC_ALL"><a href="javascript:presentEmpObj.doSearch('ETC_ALL');">기타휴가</a></li>
		<li id="ATTEND"><a href="javascript:presentEmpObj.doSearch('ATTEND');">현출</a></li>
	</ul>
	<ul class="board_mbs_list" id="presentEmpArea"></ul>
</div>
<a href="javascript:presentEmpObj.goScheduleMain();" class="btn_more"><em>더보기</em></a>
</form>