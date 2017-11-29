<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script>
$(document).ready(function(){
	calendarObj.preloadCode();
	calendarObj.calendarData();

	sheduleObj.preloadCode();
	sheduleObj.pageStart();

	if('${baseUserLoginInfo.applyOrgId}' != "${baseUserLoginInfo.orgId}") sheduleObj.getWorkDailyList('A');
    else sheduleObj.getWorkDailyList('Y');

	//sheduleObj.getScheduleList();

});

var g_selectDate = '';
var myModal = new AXModal();		// instance
var g_chkbox_seq = 0;				//체크박스 유니크 id 추가를 위한 변수

var g_secretYnCalendar = "";

var calendarObj = {



	preloadCode : function(){
		g_selectDate = new Date().yyyy_mm_dd();

	},

	pageStart : function(){


	},

	//달력 그리기
	calendarData : function(){

		$("#yearMonthArea").html(g_selectDate.substring(0,7).replace(/-/gi,'.'));

		var dateArr = g_selectDate.split("-");
		var nowDate = new Date( dateArr[0], dateArr[1]-1, dateArr[2]);			//해당날짜
		var lastDay = ( new Date( dateArr[0], dateArr[1], 0) ).getDate();		//해당월의 끝날짜
		var monthWeekCnt = nowDate.getDay();									//오늘날짜의 요일인지
		var weekSeq = parseInt((parseInt(lastDay) + monthWeekCnt - 1)/7) + 1;

		var weekArr = [];

		var str='';
		str+='<tr>';

		var weekCnt = -1;					//요일
		for(var k=1;k<=lastDay;k++){											//날짜세팅

			var currentDate = new Date( dateArr[0], dateArr[1]-1, k);			//기준일
			weekCnt = currentDate.getDay();

			if(k==1){
				var emptyCnt = weekCnt;
				if(weekCnt == 0) emptyCnt =7;
				for(var j=1;j<emptyCnt;j++){
					str+='<td></td>';
				}
			}

			str+='<td id=dateTd_'+k+' name="dateTd" style="cursor:pointer;"';

			if(currentDate.yyyy_mm_dd() == g_selectDate){
				str+=' class="current"';
			}

			str+=' onclick="calendarObj.moveDate('+k+',this);"><span>'+k+'</span></td>';

			if(weekCnt ==0) str+='</tr><tr>';
		}

		//여분 공간 td  채우기
		for(var m=0;m<7-weekCnt;m++){
			str+='<td></td>';
		}

		$("#dateArea").html(str);
	},

	//달력 화살표 이동
	moveCalendar : function(value){

		var dateArr = g_selectDate.split("-");
		var nowDate = new Date( dateArr[0], dateArr[1]-1, dateArr[2]);			//해당날짜

		var lastDay = ( new Date( dateArr[0],parseInt(dateArr[1])+value, 0) ).getDate();		//해당 다음 or 전 월의 끝날짜
		if(dateArr[2]>lastDay){													//전이나 다음월에 마지막 날짜가 현재 선택한 날보다 작으면
			nowDate = new Date( dateArr[0], dateArr[1]-1, lastDay);				//끝날로 세팅
		}

		nowDate.setMonth(nowDate.getMonth()+value);

		g_selectDate = nowDate.yyyy_mm_dd();

		calendarObj.calendarData();

		sheduleObj.getWorkDailyList();		//업무일지 업무 내용 변경.
		//sheduleObj.getScheduleList();		//업무일지 일정 변경
		//memoObj.getMemoList();				//메모

	},

	//달력 날짜 선택 변경
	moveDate : function(day,th){

		var dateArr = g_selectDate.split("-");
		g_selectDate = dateArr[0] +'-'+ dateArr[1] +'-'+ fillzero(day, 2);
		$('td[name=dateTd]').removeClass("current");
		$(th).addClass("current");

		sheduleObj.getWorkDailyList();		//업무일지 업무 변경.
		//sheduleObj.getScheduleList();		//업무일지 일정 변경
		//memoObj.getMemoList();				//메모
	},

	//오늘 버튼 클릭
	todayClick : function(){

		g_selectDate =new Date().yyyy_mm_dd();
		var dateArr = g_selectDate.split("-");
		$('td[name=dateTd]').removeClass("current");
		$("#dateTd_"+dateArr[2]).addClass("current");

		calendarObj.moveCalendar(0);		//달력 다시 세팅

	}
};



var sheduleObj = {

	preloadCode : function(){
		$("#todoTitleArea").html('('+g_selectDate.replace(/-/gi,'.')+')');
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
	getWorkDailyList : function(secretYn){


		if(secretYn == "A"){
            $("#workDailyListAll").attr("class","on");
            $("#workDailyListUser").attr("class","");
            g_secretYnCalendar = secretYn;
        }else if(secretYn == "Y"){
            $("#workDailyListAll").attr("class","");
            $("#workDailyListUser").attr("class","on");
            g_secretYnCalendar = secretYn;
        }else{
        	if(g_secretYnCalendar == "A"){
                $("#workDailyListAll").attr("class","on");
                $("#workDailyListUser").attr("class","");
            }else if(g_secretYnCalendar == "Y"){
                $("#workDailyListAll").attr("class","");
                $("#workDailyListUser").attr("class","on");
            }
            secretYn = g_secretYnCalendar;
        }

		$("#todoTitleArea").html('('+g_selectDate.replace(/-/gi,'.')+')');

		var dateArr = g_selectDate.split('-');

		var url = contextRoot + "/work/workDailyListByMain.do";

		var param = {
	   			 selectDate	: g_selectDate,
	   			secretYn  : secretYn,
	   			 calYear 	: dateArr[0],
				 mm 		: dateArr[1],
				 dd 		: dateArr[2],
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

		/* if('${baseUserLoginInfo.orgId}' == '${baseUserLoginInfo.applyOrgId}'){
    		commonAjax("POST", url, param, callback, false);
		}else{
			$('#workDailyArea').hide();
			$('#teamWorkDailyArea').hide();
		} */
	},


	setGridWork : function(list,id,scheList){


		var str = '';

		for(var i=0; i<list.length; i++){
			str+='<li><span class="fl_block">';

			str+='<input type="checkbox" class="chst" id="unique_checkbox' + (++g_chkbox_seq) + '" ';
			if(list[i].createdBy == '${baseUserLoginInfo.userId}'){	//본일일때만체크박스 생성
				str +='onclick="sheduleObj.endWorkDaily(\''+list[i].listId+'\',\''+list[i].complete+'\',\''+list[i].progress+'\',\''+g_selectDate+'\');"';
			}else{
				str+=' disabled="disabled" ';
			}

			if(list[i].complete == 'Y'){	//완료일정일때 체크
				str+=' checked="checked" ';
			}

			str+='title="업무종료 체크"/><label for="unique_checkbox' + g_chkbox_seq + '"><em class="hidden">오늘할일체크</em></label>';


			str+='<a href="javascript:sheduleObj.viewWorkDaily('+list[i].empId+','+list[i].listId+',\''+list[i].workType+'\',\''+g_selectDate+'\',\'VIEW\');" class="con_txt ' ;


			if(list[i].complete == 'Y'){		//완료일정일때 해당일정 줄긋기
				str+='ck_finish';
			}
			str+='">';
			if(list[i].workType == 'TEAM'){
				str+='<span class="icon_teamwork"></span>';
			}
			str+='<span class="icon_important_L'+list[i].important+'"></span>';

			str+= devUtil.fn_escapeReplace(list[i].title);				//내용
			str+='</a>';

			if(list[i].createdBy == '${baseUserLoginInfo.userId}'){	//내가 내 화면 볼때 and 오늘 등록일정만 버튼

				if(list[i].workType != 'TEAM'){
					str+='<a href="javascript:sheduleObj.openWorkDaily('+list[i].listId+',\''+g_selectDate+'\',\'EDIT\');" class="btn_modify_con"><em>수정</em></a>';

				}else{
					str+='<a href="javascript:sheduleObj.viewWorkDaily('+list[i].empId+','+list[i].listId+',\''+list[i].workType+'\',\''+g_selectDate+'\',\'EDIT\');" class="btn_modify_con"><em>수정</em></a>';

				}

				if(list[i].createdBy == '${baseUserLoginInfo.userId}')	//내가 내글 일때만 삭제 처리(팀 업무 때문에 팀업무는 팀리더만 삭제가능)
				str+='<a href="javascript:sheduleObj.deleteWorkDaily('+list[i].listId+',\''+list[i].workType+'\')" class="btn_delete_con"><em>삭제</em></a>';
			}

			str+='</span>';
			str+='<span class="fr_block">';

			if(list[i].dailyType == 'BEFORE'){
				str+='<em class="state_date">'+(list[i].workDayCount >0 ? '+' : '-')+list[i].workDayCount+'</em>';
			}else{
				str+='<em class="state_date">'+list[i].progressTxt+'</em>';
			}
			str+='</span>';
			/* str+='<span class="fr_block"><em class="work_write">' + list[i].empNm + '</em></span>'; */
			str += "<div class='fr_block'><span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+list[i].empId+"\",$(this),\"mouseover\",null,0,-300,300)'>";
            str+=  '<em class="work_write">'+ list[i].empNm +'</em></span></span>';
			str+='</li>';

		}

		if(scheList != undefined){
			for(var i=0; i<scheList.length; i++){
				str+='<li><span class="fl_block">';

				str+='<input type="checkbox" class="chst" id="unique_checkbox' + (++g_chkbox_seq) + '" ';
				if(scheList[i].perSabun == '${baseUserLoginInfo.empNo}'){	//본인일정일때만 체크박스 생성
					str +='onclick="sheduleObj.chkSchedule(\''+scheList[i].scheSeq+'\',\''+scheList[i].scheChkFlag+'\');"';
				}else{
					str+=' disabled="disabled" ';
				}

				if(scheList[i].scheChkFlag == 'Y'){	//완료일정일때 체크
					str+=' checked="checked" ';
				}

				str += ' /><label for="unique_checkbox' + g_chkbox_seq + '"><em class="hidden">오늘할일체크</em></label>';


				str += '<a href="javascript:sheduleObj.viewSchedule('+scheList[i].scheSeq+');" class="con_txt ' ;

				if(scheList[i].scheChkFlag == 'Y'){		//완료일정일때 해당일정 줄긋기
					str+='ck_finish';
				}
				str+='">';

				if(scheList[i].scheAllTime=='Y'){		//종일일정 이면
					str += "["+scheList[i].activityNm+"]";
					str += (devUtil.fn_escapeReplace(scheList[i].scheTitle)).replace(/&lt;/g, '<').replace(/&gt;/g,'>'); + '</a>';
				}else{
					str += '<span class="time">' + scheList[i].scheSTime + '</span>'+ "["+devUtil.fn_escapeReplace(scheList[i].activityNm)+"]" + devUtil.fn_escapeReplace(scheList[i].scheTitle) + '</a>';
				}
				str+='</span>';
				/* str+='<span class="fr_block"><em class="work_write">' + scheList[i].entryNm + '</em>'; */

				str += "<div class='fr_block'><span class='userProfileTargetArea' onmousedown = 'openUserProfileBox(\""+scheList[i].regPerId+"\",$(this),\"mouseover\",null,0,-300,300)'>";
	            str+=  '<em class="work_write">'+ scheList[i].regPerNm +'</em></span></span>';

				str+='<em class="state_date">' + (scheList[i].scheChkFlag=='Y'?'완료':(g_selectDate>new Date().yyyy_mm_dd()?'계획':'진행중')) + '</em></span>';

				str+='</li>';
			}
		}

		if(str.length > 0 ){
			$("#todoArea").append('<ul class="todo_list" id="'+id+'"></ul>');
			$("#"+id).html(str);
		}


	},

	//업무일지 등록 팝업
	openWorkDaily : function(listId,viewDate){


   		var param = {
   			 listId 	: listId,
   			 workUserId	: '${baseUserLoginInfo.userId}',
   			 workDate	: viewDate
	   	};

 	    var url =contextRoot+"/work/workDailyRegPopup/pop.do";

 	   myModal.open({
 	   		url: url,
 	   		pars: param,
 	   		titleBarText: '업무일지 '+(listId>0 ? '수정' : '등록')+'',			//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
 	   		method:"POST",
 	   		top: $(document).scrollTop()+10,
 	   		width: 750,
 	   		closeByEscKey: true				//esc 키로 닫기
   		});

   		$('#myModalCT').draggable();
    },

 	//업무일지 보기화면
    viewWorkDaily : function(empId,listId,workType,viewDate,openType){


    	var url =contextRoot+"/work/workDailyViewPopup/pop.do";
    	var width = 750;
    	if(workType == 'TEAM'){	//팀업무
    		//url 바꾸기
    		url =contextRoot+"/work/workDailyTeamViewPopup/pop.do";
    		width = 1300;
    	}

    	var param = {
      			 listId 	: listId,
      			 /* workUserId	: '${baseUserLoginInfo.userId}', */
      			 workUserId    : empId,
      			 workDate	: viewDate,
      			 openType	: openType
      	};


    	myModal.open({
 	   		url: url,
 	   		pars: param,
 	   		titleBarText: '업무일지 상세',			//titleBarText 속성 추가하였음.(원 Axisj에는 없었던것)
 	   		method:"POST",
 	   		top: $(document).scrollTop()+10,
 	   		width: width,
 	   		closeByEscKey: true				//esc 키로 닫기
   		});

   		$('#myModalCT').draggable();

    },

    //업무일지종료처리
    endWorkDaily : function(listId,nowComplete,progress,workDate){

    	var complete = 'N';
		var completeDate = '1988-09-12';


    	if(nowComplete == 'N'){			//현재 미완료된 일정이다.
    		complete = 'Y';
    		completeDate = new Date().yyyy_mm_dd();
    	}


    	var url =contextRoot + "/work/endWorkDaily.do";


	   	 var param = {
	   			 listId		 	: listId,
	   			 complete 		: complete,
	   			 completeDate	: completeDate,
	   			 progress 		: progress

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
	   			listId		 	: listId,
	   			workType		: workType


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
				scheSeq	 : scheSeq,
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
    }

};

function openPageReload(){
    sheduleObj.getWorkDailyList();
}


</script>

<div class="m_moduleBox calendar_module">
	<h2 class="module_title"><button type="button" class="btn_prev" onclick="calendarObj.moveCalendar(-1);"><em>이전달</em></button><strong id="yearMonthArea"></strong><button type="button" class="btn_next" onclick="calendarObj.moveCalendar(1);"><em>다음달</em></button></h2>
	<div class="calendarBoxWrap">
		<table id="calendarTarget" class="mcalendar_tb_st" summary="탐방일정 달력(년도별, 월별, 요일별 탐방일정 확인)">
			<caption>탐방일정 달력</caption>
			<colgroup>
				<col span="7" width="*">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">MON</th>
					<th scope="col">TUE</th>
					<th scope="col">WED</th>
					<th scope="col">THU</th>
					<th scope="col">FRI</th>
					<th scope="col"><font style="color:#AAAAFF;">SAT</font></th>
					<th scope="col"><font style="color:#FF7777;">SUN</font></th>
				</tr>
			</thead>
			<tbody id="dateArea">

			</tbody>
		</table>

		<span class="month_arrow"></span>
		<a href="javascript:calendarObj.todayClick();" class="btn_today mgr20"><em>TODAY</em></a>
	</div>
</div>

<div class="m_moduleBox schedule_module">
	<h2 class="module_title">
	    <strong onclick="sheduleObj.moreWorkDaily()">업무일지</strong>
	    <span id="todoTitleArea"></span>
	    <c:if test="${baseUserLoginInfo.vipAuthYn eq 'Y'}">
		    <ul class="module_tab">
		        <li id="workDailyListAll" onclick="sheduleObj.getWorkDailyList('A');" style="cursor: pointer; ">전체</li>
                <c:if test="${baseUserLoginInfo.applyOrgId eq baseUserLoginInfo.orgId}">
                    <li id="workDailyListUser" onclick="sheduleObj.getWorkDailyList('Y');" style="cursor: pointer; " class="on">개인</li>
                </c:if>
	        </ul>
	    </c:if>
    </h2>
	<div class="module_conBox calander_oneday_st" id="todoArea"></div>
	<a href="javascript:sheduleObj.moreWorkDaily();" class="btn_more"><em>더보기</em></a>
</div>
