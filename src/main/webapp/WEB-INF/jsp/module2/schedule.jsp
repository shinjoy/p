<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script src="${pageContext.request.contextPath}/js/sp/synergy_util.js"></script>

<script type="text/javascript" defer="defer">
$(window).load(function(){
    sheduleObj.preloadCode();
    sheduleObj.pageStart();

    if('${baseUserLoginInfo.applyOrgId}' != "${baseUserLoginInfo.orgId}") sheduleObj.getWorkDailyList('A');
    else sheduleObj.getWorkDailyList('Y');

    //sheduleObj.getScheduleList();

});

var g_selectDate = '';
var g_selectType = 'ALL';
var myModal = new AXModal();        // instance
var g_chkbox_seq = 0;               //체크박스 유니크 id 추가를 위한 변수

var g_secretYnCalendar = "";

var sheduleObj = {

    preloadCode : function(){
    	g_selectDate = new Date().yyyy_mm_dd();
        $("#todoTitleArea").html(g_selectDate.replace(/-/gi,'.') + "<em>("+ getDateWeekLabel(g_selectDate) +")</em>");
        $("#scheduleSearchDate").val(g_selectDate);

        $('#scheduleSearchDate').datepicker({
            inline: true,
            dateFormat: "yy-mm-dd",    /* 날짜 포맷 */
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
                g_selectDate = dateText;
                $("#todoTitleArea").html(g_selectDate.replace(/-/gi,'.') + "<em>("+ getDateWeekLabel(g_selectDate) +")</em>");
                $("#scheduleSearchDate").val(g_selectDate);
                sheduleObj.getWorkDailyList();  //조회
            },
            onClose: function(dateText) {
                g_selectDate = dateText;
                $("#todoTitleArea").html(g_selectDate.replace(/-/gi,'.') + "<em>("+ getDateWeekLabel(g_selectDate) +")</em>");
                $("#scheduleSearchDate").val(g_selectDate);
                sheduleObj.getWorkDailyList();  //조회
            }
        });

        $("#todoTitleArea").click(function(){
            $("#scheduleSearchDate").datepicker("show");
        });
    },

    pageStart : function(){

        //-------------------------- 모달창 :S -------------------------
        myModal.setConfig({
            windowID:"myModalCT",

            width:740,
            mediaQuery: {
                mx:{min:0, max:767}, dx:{min:767}
            },
            displayLoading:true,
            scrollLock: false,
            onclose: function(){

            }
            ,contentDivClass: "popup_outline"

        });
        //-------------------------- 모달창 :E -------------------------
    },

    //업무일지 리스트
    getWorkDailyList : function(secretYn, selectType){

        if(secretYn == "A"){
            $("#workDailyListAll").hide();
            $("#workDailyListUser").show();
            g_secretYnCalendar = secretYn;
        }else if(secretYn == "Y"){
            $("#workDailyListAll").show();
            $("#workDailyListUser").hide();
            g_secretYnCalendar = secretYn;
        }else{
            if(g_secretYnCalendar == "A"){
                $("#workDailyListAll").hide();
                $("#workDailyListUser").show();
            }else if(g_secretYnCalendar == "Y"){
                $("#workDailyListAll").show();
                $("#workDailyListUser").hide();
            }else{
            	if('${baseUserLoginInfo.vipAuthYn}' != "Y")
                    $("#workDailyListAll").remove();
            }
            secretYn = g_secretYnCalendar;
        }

        var dateArr = g_selectDate.split('-');

      //탭활성화 초기화
        $(".scheduleTab").removeClass("current");
        //선택한 타입을 전역으로 갖는다.
        if(selectType != undefined){
        	g_selectType = selectType;
        }
        switch(g_selectType){
	        //전체
	        case 'ALL':
	            //탭활성화
	            $("#scheduleAllTab").addClass("current");
	            $("#scheduleWorkTab").removeClass("current");
	            $("#scheduleScheduleTab").removeClass("current");
	            break;
	        case 'WORK':
	            //탭활성화
	            $("#scheduleAllTab").removeClass("current notDraggable");
	            $("#scheduleWorkTab").addClass("current");
	            $("#scheduleScheduleTab").removeClass("current");
	            break;
	        case 'SCHEDULE':
	            //탭활성화
	            $("#scheduleAllTab").removeClass("current notDraggable");
	            $("#scheduleWorkTab").removeClass("current");
	            $("#scheduleScheduleTab").addClass("current");
	            break;
        }

        var url = contextRoot + "/work/workDailyListByMain.do";

        var param = {
                 selectDate : g_selectDate,
                 secretYn  : secretYn,
                 selectType         : g_selectType,
                 calYear    : dateArr[0],
                 mm         : dateArr[1],
                 dd         : dateArr[2],
        };

        var callback = function(result){
            var obj = JSON.parse(result);
            var totalObj = obj.resultObject;

            var teamWorkDailyList = totalObj.teamWorkDailyList;
            var workDailyList = totalObj.workDailyList;
            var scheDuleDailyList = totalObj.scheDuleDailyList;
            $("#todoArea").empty();
            sheduleObj.setGridWork(workDailyList,"workDailyArea",scheDuleDailyList);
            sheduleObj.setGridWork(teamWorkDailyList,"teamWorkDailyArea");

        };

        commonAjax("POST", url, param, callback, true);
    },

    setGridWork : function(list,id,scheList){
        var str = '';

        for(var i=0; i<list.length; i++){
            str+='<li><div class="note_workBox">';

            str+='<p class="conBox"><input type="checkbox" class="chst" id="unique_checkbox' + (++g_chkbox_seq) + '" ';
            if(list[i].createdBy == '${baseUserLoginInfo.userId}'){ //본일일때만체크박스 생성
                str +='onclick="sheduleObj.endWorkDaily(\''+list[i].listId+'\',\''+list[i].complete+'\',\''+list[i].progress+'\',\''+g_selectDate+'\');"';
            }else{
                str+=' disabled="disabled" ';
            }

            if(list[i].complete == 'Y'){    //완료일정일때 체크
                str+=' checked="checked" ';
            }

            str+='title="업무종료 체크"/><label for="unique_checkbox' + g_chkbox_seq + '"><em class="hidden">오늘할일체크</em></label>';


            str+='<a href="javascript:sheduleObj.viewWorkDaily('+list[i].empId+','+list[i].listId+',\''+list[i].workType+'\',\''+g_selectDate+'\',\'VIEW\');" class="con_txt ' ;


            if(list[i].complete == 'Y'){        //완료일정일때 해당일정 줄긋기
                str+='ck_finish';
            }
            str+='">';
            if(list[i].workType == 'TEAM'){
                str+='<span class="icon_teamwork"></span>';
            }
            str+='<span class="icon_important_L'+list[i].important+'"></span>';

            str+= devUtil.fn_escapeReplace(list[i].title);              //내용
            str+='</a>';



            str+='</span>';

            str+='</p>';
            str += "<p class='writeinfo'><span class='writer ";
            if(list[i].complete == 'Y'){        //완료일정일때 해당일정 줄긋기
            	str+= ' ck_finish';
            }
            str+= "'";
            str += " onmousedown = 'openUserProfileBox(\""+list[i].empId+"\",$(this),\"mouseover\",null,0,-300,300)'>";

            str+=  '['+ list[i].empNm + ' ' + list[i].empRankNm +']</span></span>';

            str+='<span class="fr_block">';

            if(list[i].dailyType == 'BEFORE'){
                str+='<em class="state_date">'+(list[i].workDayCount >0 ? '+' : '-')+list[i].workDayCount+'</em>';
            }else{
                //str+='<em class="state_date">'+list[i].progressTxt+'</em>';
            }
            str+='</span>';

            if(list[i].createdBy == '${baseUserLoginInfo.userId}'){ //내가 내 화면 볼때 and 오늘 등록일정만 버튼

                if(list[i].workType != 'TEAM'){
                    str+='<a href="javascript:sheduleObj.openWorkDaily('+list[i].listId+',\''+g_selectDate+'\',\'EDIT\');" class="btn_modify_con"><em>수정</em></a>';

                }else{
                    str+='<a href="javascript:sheduleObj.viewWorkDaily('+list[i].empId+','+list[i].listId+',\''+list[i].workType+'\',\''+g_selectDate+'\',\'EDIT\');" class="btn_modify_con"><em>수정</em></a>';
                }

                if(list[i].createdBy == '${baseUserLoginInfo.userId}')  //내가 내글 일때만 삭제 처리(팀 업무 때문에 팀업무는 팀리더만 삭제가능)
                str+='<a href="javascript:sheduleObj.deleteWorkDaily('+list[i].listId+',\''+list[i].workType+'\')" class="btn_delete_con"><em>삭제</em></a>';
            }

            str+= '</p>';

            if(list[i].complete=='Y'){
                str+='<span class="state_icon finish">완료</span>';
            }else if(list[i].progressTxt=='진행'){
                str+='<span class="state_icon ing">진행</span>';
            }else if(list[i].progressTxt=='보류'){
                str+='<span class="state_icon delay">보류</span>';
            }else if(list[i].progressTxt=='계획'){
                str+='<span class="state_icon preplan">계획</span>';
            }else{
                str+='<span class="state_icon ing">'+list[i].progressTxt+'</span>';
            }

            str+= '</div></li>';

        }

        if(scheList != undefined){
            for(var i=0; i<scheList.length; i++){
                str+='<li><div class="note_workBox">';

                str+='<p class="conBox"><input type="checkbox" class="chst" id="unique_checkbox' + (++g_chkbox_seq) + '" ';
                if(scheList[i].perSabun == '${baseUserLoginInfo.empNo}'){   //본인일정일때만 체크박스 생성
                    str +='onclick="sheduleObj.chkSchedule(\''+scheList[i].scheSeq+'\',\''+scheList[i].scheChkFlag+'\');"';
                }else{
                    str+=' disabled="disabled" ';
                }

                if(scheList[i].scheChkFlag == 'Y'){ //완료일정일때 체크
                    str+=' checked="checked" ';
                }

                str += ' /><label for="unique_checkbox' + g_chkbox_seq + '"><em class="hidden">오늘할일체크</em></label>';


                str += '<a href="javascript:sheduleObj.viewSchedule('+scheList[i].scheSeq+');" class="con_txt ' ;

                if(scheList[i].scheChkFlag == 'Y'){     //완료일정일때 해당일정 줄긋기
                    str+=' ck_finish';
                }
                str+='">';

                if(scheList[i].scheAllTime=='Y'){       //종일일정 이면
                    str += "["+scheList[i].activityNm+"]";
                    str += (devUtil.fn_escapeReplace(scheList[i].scheTitle)).replace(/&lt;/g, '<').replace(/&gt;/g,'>'); + '</a>';
                }else{
                    str += '<span class="time">' + scheList[i].scheSTime + '</span>'+ "["+devUtil.fn_escapeReplace(scheList[i].activityNm)+"]" + devUtil.fn_escapeReplace(scheList[i].scheTitle) + '</a>';
                }
                str+='</span></p>';

                str += "<p class='writeinfo'><span class='writer ";
				if(scheList[i].scheChkFlag == 'Y'){     //완료일정일때 해당일정 줄긋기
				    str+= ' ck_finish';
				}
				str+= "'";
                str += "><span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+scheList[i].regPerId+"\",$(this),\"mouseover\",null,0,-300,300)'>";
                str+=  '['+ scheList[i].regPerNm + ' ' + scheList[i].regPerRankNm +']</span></span></p>';

                if(scheList[i].scheChkFlag=='Y'){
                	str+='<span class="state_icon finish">완료</span>';
                }else if(g_selectDate > new Date().yyyy_mm_dd()){
                    str+='<span class="state_icon preplan">계획</span>';
                }else{
                	str+='<span class="state_icon ing">진행</span>';
                }
                /* str+='<span class="state_icon">' + (scheList[i].scheChkFlag=='Y'?'완료':(g_selectDate>new Date().yyyy_mm_dd()?'계획':'진행')) + '</span>'; */

                str+='</div></li>';
            }
        }

        if(str.length > 0 ){
            $("#todoArea").append('<ul class="note_workList" id="'+id+'"></ul>');
            $("#"+id).html(str);
        }

    },

    //업무일지 등록 팝업
    openWorkDaily : function(listId,viewDate){


        var param = {
             listId     : listId,
             workUserId : '${baseUserLoginInfo.userId}',
             workDate   : viewDate
        };

        var url =contextRoot+"/work/workDailyRegPopup/pop.do";

       myModal.open({
            url: url,
            pars: param,
            titleBarText: '업무일지 '+(listId>0 ? '수정' : '등록')+'',          //titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
            method:"POST",
            top: $(document).scrollTop()+10,
            width: 750,
            closeByEscKey: true             //esc 키로 닫기
        });

        $('#myModalCT').draggable();
    },

    //업무일지 보기화면
    viewWorkDaily : function(empId,listId,workType,viewDate,openType){


        var url =contextRoot+"/work/workDailyViewPopup/pop.do";
        var width = 750;
        if(workType == 'TEAM'){ //팀업무
            //url 바꾸기
            url =contextRoot+"/work/workDailyTeamViewPopup/pop.do";
            width = 1300;
        }

        var param = {
                 listId     : listId,
                 /* workUserId  : '${baseUserLoginInfo.userId}', */
                 workUserId    : empId,
                 workDate   : viewDate,
                 openType   : openType
        };


        myModal.open({
            url: url,
            pars: param,
            titleBarText: '업무일지 상세',            //titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
            method:"POST",
            top: $(document).scrollTop()+10,
            width: width,
            closeByEscKey: true             //esc 키로 닫기
        });

        $('#myModalCT').draggable();

    },

    //업무일지종료처리
    endWorkDaily : function(listId,nowComplete,progress,workDate){

        var complete = 'N';
        var completeDate = '1988-09-12';


        if(nowComplete == 'N'){         //현재 미완료된 일정이다.
            complete = 'Y';
            completeDate = new Date().yyyy_mm_dd();
        }


        var url =contextRoot + "/work/endWorkDaily.do";


         var param = {
                 listId         : listId,
                 complete       : complete,
                 completeDate   : completeDate,
                 progress       : progress

         };

         var callback = function(result){
            var obj = JSON.parse(result);
            var cnt = obj.resultVal;
            if(cnt>0){
                sheduleObj.getWorkDailyList();

            }else{
                dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
            }
        };

        commonAjax("POST", url, param, callback, false);
    },

    //업무일지삭제
    deleteWorkDaily : function(listId,workType){

        var url =contextRoot + "/work/deleteWorkDaily.do";

        var param = {
                listId          : listId,
                workType        : workType


        };

        var callback = function(result){
            var obj = JSON.parse(result);
            var cnt = obj.resultVal;
            if(cnt>0){
                sheduleObj.getWorkDailyList();

            }else{
                dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
            }
        };

        commonAjax("POST", url, param, callback, false);
    },


    //일정 보기
    viewSchedule : function(scheSeq){
        schePopFlag = false;
        var url = "<c:url value='/ScheduleView.do?ScheSeq=" + scheSeq + "'/>";
        window.open(url, 'scheduleView','resizable=no,width=674,height=700,scrollbars=yes');
        schePopFlag = true;
    },


    //일정 종료처리
    chkSchedule : function(scheSeq, complete){

        var url = contextRoot + "/work/updateScheduleStts.do";

        var param = {
                scheSeq  : scheSeq,
                sttsCd : (complete=='Y'?'N':'Y')
        };

        var callback = function(result){
            var obj = JSON.parse(result);
            var cnt = obj.resultVal;
            if(cnt>0){
                toast.push("변경되었습니다!");
                sheduleObj.getWorkDailyList();

            }else{
                dialog.push({body:"서버 오류!", type:"", onConfirm:function(){}});
            }
        };

        commonAjax("POST", url, param, callback, true);
    },

    //더보기
    moreWorkDaily : function(){
        location.href = contextRoot+"/work/getDailyWork.do?selectDate="+g_selectDate;
    },

 // 달력이동
    moveDay : function(interVal){
        var searchDate2 = g_selectDate;

        var choiceYear = parseInt(searchDate2.split('-')[0]);
        var choiceMonth = parseInt(searchDate2.split('-')[1])-1;
        var choiceDay = parseInt(searchDate2.split('-')[2]);

        var loadDt = new Date(choiceYear,choiceMonth,choiceDay); //현재 날짜 및 시간   //현재시간 기준 계산
        var newDate= new Date(Date.parse(loadDt) + (interVal * 1000 * 60 * 60 * 24));  //하루전/후
        var strDate = getFormatDate(newDate,'-');

        g_selectDate = strDate;
        $("#todoTitleArea").html(g_selectDate.replace(/-/gi,'.') + "<em>("+ getDateWeekLabel(g_selectDate) +")</em>");
        $("#scheduleSearchDate").val(g_selectDate);
        sheduleObj.getWorkDailyList();  //조회
     },

};

function openPageReload(){
    sheduleObj.getWorkDailyList();
}


</script>
<!--업무일지/일정-->
<div class="note_workWrap">
	<div class="labelsetLine">
		<h3><strong>업무일지/일정</strong><a href="javascript:sheduleObj.moreWorkDaily();" class="rdmore_btn"><em>더보기</em></a></h3>
		<button type="button" class="toggle_sort all" id="workDailyListAll" onclick="sheduleObj.getWorkDailyList('A');" style="display: none;"><em>전체</em></button>
		<button type="button" class="toggle_sort personal" id="workDailyListUser" onclick="sheduleObj.getWorkDailyList('Y');" style="display: none;"><em>개인</em></button>
	</div>
	<div class="module_tabList">
		<ul>
			<li id="scheduleAllTab" class="scheduleTab current notDraggable" onclick="sheduleObj.getWorkDailyList('','ALL');" style="cursor:pointer;">전체</li>
			<li id="scheduleWorkTab"  class="scheduleTab notDraggable" onclick="sheduleObj.getWorkDailyList('','WORK');" style="cursor:pointer;">업무일지</li>
			<li id="scheduleScheduleTab" class="scheduleTab notDraggable" onclick="sheduleObj.getWorkDailyList('','SCHEDULE');" style="cursor:pointer;">일정</li>
		</ul>
	</div>
	<div class="selectDayBox">
		<button type="button" class="btn_pre" onClick="sheduleObj.moveDay(-1);"><em>이전날</em></button>
		<input type="hidden" id="scheduleSearchDate" name="scheduleSearchDate"/>
		<span  id="todoTitleArea" style="cursor:pointer;"></span>
		<button type="button" class="btn_next" onClick="sheduleObj.moveDay(1);"><em>다음날</em></button>
	</div>
	<div id="todoArea"></div>
</div>
<!--//업무일지/일정//-->
